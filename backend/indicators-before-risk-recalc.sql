--
-- PostgreSQL database dump
--

\restrict XJ0bejG27qpty4EzW1WJtK1JOL86uf1DZGph5QV2kWBDXC4DbLRTSnbflje22m6

-- Dumped from database version 18.6 (Debian 18.6-3)
-- Dumped by pg_dump version 18.6 (Debian 18.6-3)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: indicators; Type: TABLE; Schema: public; Owner: threatuser
--

CREATE TABLE public.indicators (
    id integer NOT NULL,
    value character varying NOT NULL,
    type character varying NOT NULL,
    severity_score integer,
    confidence integer,
    status character varying,
    created_at timestamp with time zone DEFAULT now(),
    enrichment_status character varying DEFAULT 'pending'::character varying,
    reputation character varying DEFAULT 'unknown'::character varying,
    country character varying,
    asn character varying,
    malware_family character varying,
    last_seen timestamp with time zone,
    detection_score integer DEFAULT 0,
    detection_reasons text,
    risk_score integer DEFAULT 0,
    correlation_score integer DEFAULT 0
);


ALTER TABLE public.indicators OWNER TO threatuser;

--
-- Name: indicators_id_seq; Type: SEQUENCE; Schema: public; Owner: threatuser
--

CREATE SEQUENCE public.indicators_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.indicators_id_seq OWNER TO threatuser;

--
-- Name: indicators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatuser
--

ALTER SEQUENCE public.indicators_id_seq OWNED BY public.indicators.id;


--
-- Name: indicators id; Type: DEFAULT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.indicators ALTER COLUMN id SET DEFAULT nextval('public.indicators_id_seq'::regclass);


--
-- Data for Name: indicators; Type: TABLE DATA; Schema: public; Owner: threatuser
--

COPY public.indicators (id, value, type, severity_score, confidence, status, created_at, enrichment_status, reputation, country, asn, malware_family, last_seen, detection_score, detection_reasons, risk_score, correlation_score) FROM stdin;
34	http://192.236.217.110/83/goodthings.hta	url	85	90	active	2026-09-17 12:10:07.918378-05	completed	malicious	United States	AS36352 - HostPapa	URLhaus tags: hta, rat, RemcosRAT	2026-09-17 11:22:15-05	35	Suspicious Extension (.hta) | Raw IP Address	0	0
27	http://119.115.65.183:53858/bin.sh	url	85	90	active	2026-09-17 12:10:07.918378-05	completed	malicious	China	AS4837 - China Unicom Liaoning province network	URLhaus tags: 32-bit, elf, mips, Mozi	2026-09-17 11:50:35-05	25	Raw IP Address | Non-Standard Port (53858)	0	0
30	http://96.44.167.210/18/bcc.hta	url	85	90	active	2026-09-17 12:10:07.918378-05	completed	malicious	Canada	AS36352 - HostPapa	URLhaus tags: hta	2026-09-17 11:42:14-05	35	Suspicious Extension (.hta) | Raw IP Address	0	0
17	http://182.115.74.13:47904/i	url	85	90	active	2026-09-17 11:58:57.08311-05	pending	unknown	\N	\N	\N	\N	25	Raw IP Address | Non-Standard Port (47904)	0	0
31	https://firebasestorage.googleapis.com/v0/b/julyendingapama.firebasestorage.app/o/kingjoo.png?alt=media&token=36145a21-d722-4709-9287-f8d67e90830a	url	85	90	active	2026-09-17 12:10:07.918378-05	completed	malicious	United States	AS15169 - Google LLC	URLhaus tags: Formbook, stego	2026-09-17 11:37:19-05	0		0	0
41	https://www.google.com/	url	10	90	active	2026-09-19 12:08:56.915998-05	completed	benign	United States	AS15169 - Google LLC	Trusted Infrastructure	2026-09-19 12:33:53-05	0		0	0
42	192.168.1.14	ip	90	95	active	2026-09-19 12:37:39.072543-05	completed	unknown	\N	\N	\N	\N	0		0	0
33	http://96.44.167.210/2lgdJx7f	url	85	90	active	2026-09-17 12:10:07.918378-05	completed	malicious	Canada	AS36352 - HostPapa	URLhaus tags: ascii, rat, RemcosRAT	2026-09-17 11:22:18-05	15	Raw IP Address	0	0
10	http://107.175.148.115/60/givingbestthings.hta	url	85	90	active	2026-09-17 11:58:51.854799-05	pending	unknown	\N	\N	\N	\N	35	Suspicious Extension (.hta) | Raw IP Address	0	0
26	http://119.115.65.183:53858/i	url	85	90	active	2026-09-17 12:10:07.918378-05	pending	unknown	\N	\N	\N	\N	25	Raw IP Address | Non-Standard Port (53858)	0	0
28	http://115.42.71.239:59734/i	url	85	90	active	2026-09-17 12:10:07.918378-05	completed	malicious	Pakistan	AS132165 - Metro Ethernet Network	URLhaus tags: 32-bit, elf, mips, Mozi	2026-09-17 11:45:30-05	25	Raw IP Address | Non-Standard Port (59734)	0	0
29	http://94.154.43.227:8080/bins/cirqueira.sh	url	85	90	active	2026-09-17 12:10:07.918378-05	pending	unknown	\N	\N	\N	\N	25	Raw IP Address | Non-Standard Port (8080)	0	0
12	http://5.175.169.207/img_113727.png	url	85	90	active	2026-09-17 11:58:51.854799-05	pending	unknown	\N	\N	\N	\N	15	Raw IP Address	0	0
13	http://5.175.169.207/img_113850.png	url	85	90	active	2026-09-17 11:58:51.854799-05	pending	unknown	\N	\N	\N	\N	15	Raw IP Address	0	0
14	https://rough-truth-e072.publicftpresend.workers.dev/	url	85	90	active	2026-09-17 11:58:51.854799-05	pending	unknown	\N	\N	\N	\N	0		0	0
15	http://204.44.93.77/128/img_032911.png	url	85	90	active	2026-09-17 11:58:51.854799-05	pending	unknown	\N	\N	\N	\N	15	Raw IP Address	0	0
16	http://204.44.93.77/86RbddL0	url	85	90	active	2026-09-17 11:58:57.08311-05	pending	unknown	\N	\N	\N	\N	15	Raw IP Address	0	0
18	http://96.44.167.210/16/goodthingsformebest.jS	url	85	90	active	2026-09-17 11:58:57.08311-05	pending	unknown	\N	\N	\N	\N	35	Suspicious Extension (.js) | Raw IP Address	0	0
19	https://bun-pullz.b-cdn.net/img_083453.png	url	85	90	active	2026-09-17 11:58:57.08311-05	pending	unknown	\N	\N	\N	\N	0		0	0
20	http://212.2.35.14/9E2J3518	url	85	90	active	2026-09-17 11:58:57.08311-05	pending	unknown	\N	\N	\N	\N	15	Raw IP Address	0	0
21	http://212.2.35.14/35/img_182135.png	url	85	90	active	2026-09-17 11:58:57.08311-05	pending	unknown	\N	\N	\N	\N	15	Raw IP Address	0	0
22	http://212.2.35.14/35/givingmebestthings.hta	url	85	90	active	2026-09-17 11:58:57.08311-05	pending	unknown	\N	\N	\N	\N	35	Suspicious Extension (.hta) | Raw IP Address	0	0
23	http://107.173.227.124/60/img_185503.png	url	85	90	active	2026-09-17 11:58:57.08311-05	pending	unknown	\N	\N	\N	\N	15	Raw IP Address	0	0
24	http://212.2.35.14/9xJZ2C1I	url	85	90	active	2026-09-17 11:58:57.08311-05	pending	unknown	\N	\N	\N	\N	15	Raw IP Address	0	0
25	http://107.173.227.124/60/goodthings.hta	url	85	90	active	2026-09-17 11:58:57.08311-05	completed	malicious	United States	AS36352 - RackNerd LLC	URLhaus tags: hta, rat, RemcosRAT	2026-09-17 11:23:16-05	35	Suspicious Extension (.hta) | Raw IP Address	0	0
32	http://96.44.167.210/15/img_222310.png	url	85	90	active	2026-09-17 12:10:07.918378-05	completed	malicious	Canada	AS36352 - HostPapa	URLhaus tags: rat, RemcosRAT	2026-09-17 11:22:19-05	15	Raw IP Address	0	0
37	https://www.youtube.com/watch?v=4L_lXGET9gU&list=RD4L_lXGET9gU&start_radio=1	url	50	90	active	2026-09-19 11:40:57.124945-05	completed	unknown	United States	AS15169 - Google LLC	\N	2026-09-19 13:15:26-05	0		0	0
38	https://vegamoviess.foo/	url	50	90	active	2026-09-19 11:46:35.335688-05	completed	suspicious	United States	AS13335 - Cloudflare, Inc.	Suspicious Phishing Infrastructure	2026-09-19 11:49:11-05	0		0	0
35	http://96.44.167.210/15/givenmebestthingsforbetter.hta	url	85	90	active	2026-09-17 12:10:07.918378-05	completed	malicious	Canada	AS36352 - HostPapa	URLhaus tags: hta, rat, RemcosRAT	2026-09-17 11:22:15-05	35	Suspicious Extension (.hta) | Raw IP Address	85	0
\.


--
-- Name: indicators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatuser
--

SELECT pg_catalog.setval('public.indicators_id_seq', 42, true);


--
-- Name: indicators indicators_pkey; Type: CONSTRAINT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.indicators
    ADD CONSTRAINT indicators_pkey PRIMARY KEY (id);


--
-- Name: ix_indicators_id; Type: INDEX; Schema: public; Owner: threatuser
--

CREATE INDEX ix_indicators_id ON public.indicators USING btree (id);


--
-- Name: ix_indicators_value; Type: INDEX; Schema: public; Owner: threatuser
--

CREATE INDEX ix_indicators_value ON public.indicators USING btree (value);


--
-- PostgreSQL database dump complete
--

\unrestrict XJ0bejG27qpty4EzW1WJtK1JOL86uf1DZGph5QV2kWBDXC4DbLRTSnbflje22m6

