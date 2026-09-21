from urllib.parse import urlparse

def extract_hostname(value: str, indicator_type: str):
    try:
        if indicator_type.lower() == "url":
            return urlparse(value).hostname
        elif indicator_type.lower() in ["ip", "domain"]:
            return value.strip()
    except:
        pass
    return None


def calculate_correlation(ioc1, ioc2):
    score = 0
    reasons = []

    # Same IP / hostname
    h1 = extract_hostname(ioc1.value, ioc1.type)
    h2 = extract_hostname(ioc2.value, ioc2.type)

    if h1 and h2 and h1 == h2:
        score += 40
        reasons.append("Same IP / Hostname")

    # Same malware family
    if (
        ioc1.malware_family
        and ioc2.malware_family
        and ioc1.malware_family == ioc2.malware_family
    ):
        score += 30
        reasons.append("Same Malware Family")

    # Ignore trusted infrastructure
    if (
        ioc1.reputation == "benign" or
        ioc2.reputation == "benign"
    ):
        return {"score":0,"reasons":[]}

    # Same reputation
    # Unknown reputation is not threat evidence, so do not correlate it.
    if (
        ioc1.reputation
        and ioc2.reputation
        and ioc1.reputation == ioc2.reputation
        and ioc1.reputation in ("malicious", "suspicious")
    ):
        if ioc1.reputation == "malicious":
            score += 10
        elif ioc1.reputation == "suspicious":
            score += 20

        reasons.append("Same Reputation")

    return {
        "score": score,
        "reasons": reasons
    }
