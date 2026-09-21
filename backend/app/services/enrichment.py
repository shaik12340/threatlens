from urllib.parse import urlparse
from datetime import datetime, UTC
import socket
import os
import httpx
from dotenv import load_dotenv

load_dotenv()

TRUSTED_DOMAINS = [
    "google.com",
    "chatgpt.com",
    "openai.com",
    "github.com",
    "microsoft.com",
    "apple.com",
    "amazon.com",
    "cloudflare.com",
]

def enrich_indicator(value: str, indicator_type: str) -> dict:
    result = {
        "enrichment_status": "completed",
        "reputation": "unknown",
        "country": None,
        "asn": None,
        "malware_family": None,
        "last_seen": None,
    }

    try:
        value = value.strip()
        indicator_type = indicator_type.lower().strip()

        hostname = None

        if indicator_type == "url":
            hostname = urlparse(value).hostname
        elif indicator_type in ["domain", "ip"]:
            hostname = value

        if not hostname:
            result["enrichment_status"] = "failed"
            return result

        # ---------- Trusted domains ----------
        if any(hostname.endswith(d) for d in TRUSTED_DOMAINS):
            result["reputation"] = "benign"
            result["malware_family"] = "Trusted Infrastructure"
            result["last_seen"] = datetime.now(UTC).strftime("%Y-%m-%d %H:%M:%S UTC")

        # ---------- URLhaus ----------
        auth_key = os.getenv("URLHAUS_AUTH_KEY")

        if auth_key and indicator_type == "url" and result["reputation"] != "benign":
            try:
                response = httpx.post(
                    "https://urlhaus-api.abuse.ch/v1/url/",
                    data={"url": value},
                    headers={"Auth-Key": auth_key},
                    timeout=10.0
                )

                if response.status_code == 200:
                    data = response.json()
                    status = data.get("query_status")

                    if status == "ok":
                        result["reputation"] = "malicious"
                        result["last_seen"] = data.get("date_added")

                        tags = data.get("tags") or []
                        if tags:
                            result["malware_family"] = "URLhaus tags: " + ", ".join(tags[:5])

                    elif status == "no_results":
                        result["reputation"] = "unknown"
                        result["last_seen"] = datetime.now(UTC).strftime("%Y-%m-%d %H:%M:%S UTC")

            except Exception:
                pass

        # ---------- DNS + ASN ----------
        try:
            ip = socket.gethostbyname(hostname)
        except:
            ip = hostname

        try:
            r = httpx.get(f"https://ipwho.is/{ip}", timeout=8)
            if r.status_code == 200:
                j = r.json()
                if j.get("success"):
                    result["country"] = j.get("country")
                    c = j.get("connection") or {}
                    if c.get("asn"):
                        result["asn"] = f'AS{c["asn"]} - {c.get("org","")}'
        except:
            pass

        # ---------- Malware fallback ----------
        if result["malware_family"] is None:
            l = value.lower()

            if ".hta" in l:
                result["malware_family"] = "HTA Loader"
            elif ".js" in l:
                result["malware_family"] = "JavaScript Payload"
            elif "firebase" in l:
                result["malware_family"] = "Firebase Phishing Kit"
            elif "workers.dev" in l:
                result["malware_family"] = "Cloudflare Worker Phishing"
            elif result["reputation"] == "suspicious":
                result["malware_family"] = "Suspicious Phishing Infrastructure"

        return result

    except Exception:
        result["enrichment_status"] = "failed"
        return result
