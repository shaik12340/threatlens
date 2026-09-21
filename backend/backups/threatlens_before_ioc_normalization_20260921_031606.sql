--
-- PostgreSQL database dump
--

\restrict qY31nyLPl6cUO3dqLupz6RkxkwvMODlAGlufJxwpvxqx7nEg0mdKUo7P9V8ELbN

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
-- Name: correlations; Type: TABLE; Schema: public; Owner: threatuser
--

CREATE TABLE public.correlations (
    id integer NOT NULL,
    source_ioc integer,
    target_ioc integer,
    relation_type character varying NOT NULL,
    score integer
);


ALTER TABLE public.correlations OWNER TO threatuser;

--
-- Name: correlations_id_seq; Type: SEQUENCE; Schema: public; Owner: threatuser
--

CREATE SEQUENCE public.correlations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.correlations_id_seq OWNER TO threatuser;

--
-- Name: correlations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatuser
--

ALTER SEQUENCE public.correlations_id_seq OWNED BY public.correlations.id;


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
-- Name: investigation_actions; Type: TABLE; Schema: public; Owner: threatuser
--

CREATE TABLE public.investigation_actions (
    id integer NOT NULL,
    ioc_id integer NOT NULL,
    action text NOT NULL,
    analyst character varying(255),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.investigation_actions OWNER TO threatuser;

--
-- Name: investigation_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: threatuser
--

CREATE SEQUENCE public.investigation_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.investigation_actions_id_seq OWNER TO threatuser;

--
-- Name: investigation_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatuser
--

ALTER SEQUENCE public.investigation_actions_id_seq OWNED BY public.investigation_actions.id;


--
-- Name: investigation_notes; Type: TABLE; Schema: public; Owner: threatuser
--

CREATE TABLE public.investigation_notes (
    id integer NOT NULL,
    ioc_id integer NOT NULL,
    note text NOT NULL,
    analyst character varying(255),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.investigation_notes OWNER TO threatuser;

--
-- Name: investigation_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: threatuser
--

CREATE SEQUENCE public.investigation_notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.investigation_notes_id_seq OWNER TO threatuser;

--
-- Name: investigation_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatuser
--

ALTER SEQUENCE public.investigation_notes_id_seq OWNED BY public.investigation_notes.id;


--
-- Name: investigation_tags; Type: TABLE; Schema: public; Owner: threatuser
--

CREATE TABLE public.investigation_tags (
    id integer NOT NULL,
    ioc_id integer NOT NULL,
    tag character varying(100) NOT NULL,
    added_by character varying(255),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.investigation_tags OWNER TO threatuser;

--
-- Name: investigation_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: threatuser
--

CREATE SEQUENCE public.investigation_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.investigation_tags_id_seq OWNER TO threatuser;

--
-- Name: investigation_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatuser
--

ALTER SEQUENCE public.investigation_tags_id_seq OWNED BY public.investigation_tags.id;


--
-- Name: investigations; Type: TABLE; Schema: public; Owner: threatuser
--

CREATE TABLE public.investigations (
    id integer NOT NULL,
    ioc_id integer NOT NULL,
    assigned_to character varying(255),
    analyst character varying(255),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.investigations OWNER TO threatuser;

--
-- Name: investigations_id_seq; Type: SEQUENCE; Schema: public; Owner: threatuser
--

CREATE SEQUENCE public.investigations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.investigations_id_seq OWNER TO threatuser;

--
-- Name: investigations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: threatuser
--

ALTER SEQUENCE public.investigations_id_seq OWNED BY public.investigations.id;


--
-- Name: correlations id; Type: DEFAULT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.correlations ALTER COLUMN id SET DEFAULT nextval('public.correlations_id_seq'::regclass);


--
-- Name: indicators id; Type: DEFAULT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.indicators ALTER COLUMN id SET DEFAULT nextval('public.indicators_id_seq'::regclass);


--
-- Name: investigation_actions id; Type: DEFAULT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.investigation_actions ALTER COLUMN id SET DEFAULT nextval('public.investigation_actions_id_seq'::regclass);


--
-- Name: investigation_notes id; Type: DEFAULT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.investigation_notes ALTER COLUMN id SET DEFAULT nextval('public.investigation_notes_id_seq'::regclass);


--
-- Name: investigation_tags id; Type: DEFAULT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.investigation_tags ALTER COLUMN id SET DEFAULT nextval('public.investigation_tags_id_seq'::regclass);


--
-- Name: investigations id; Type: DEFAULT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.investigations ALTER COLUMN id SET DEFAULT nextval('public.investigations_id_seq'::regclass);


--
-- Data for Name: correlations; Type: TABLE DATA; Schema: public; Owner: threatuser
--

COPY public.correlations (id, source_ioc, target_ioc, relation_type, score) FROM stdin;
\.


--
-- Data for Name: indicators; Type: TABLE DATA; Schema: public; Owner: threatuser
--

COPY public.indicators (id, value, type, severity_score, confidence, status, created_at, enrichment_status, reputation, country, asn, malware_family, last_seen, detection_score, detection_reasons, risk_score, correlation_score) FROM stdin;
58	https://www.youtube.com/watch?v=AEIVhBS6baE&list=RDHqjPEwhiWcE&index=8	url	30	90	active	2026-09-21 03:03:05.002645-05	completed	unknown	United States	AS15169 - Google LLC	\N	2026-09-21 03:03:14-05	0		0	0
59	https://login-verify-security.example.com/reset/confirm/malware/update.exe	url	30	90	active	2026-09-21 03:03:57.883701-05	completed	unknown	\N	\N	\N	2026-09-21 03:04:18-05	90	Suspicious Extension (.exe) | Phishing Keywords: login, verify, update | Malware Indicators: malware | Credential Indicators: login | Phishing Path: /reset, /confirm | Suspicious File Name: update	90	0
60	https://critical-security-alert.example.com/malware.exe	url	30	90	active	2026-09-21 03:04:44.0524-05	completed	unknown	\N	\N	\N	2026-09-21 03:04:44-05	40	Suspicious Extension (.exe) | Malware Indicators: malware	40	0
61	https://low-risk-test.example.net/download.exe	url	30	90	active	2026-09-21 03:05:44.894518-05	completed	unknown	\N	\N	\N	2026-09-21 03:05:46-05	20	Suspicious Extension (.exe)	20	0
62	https://example.com/	url	0	0	active	2026-09-21 03:10:08.85137-05	pending	unknown	\N	\N	\N	\N	0	\N	0	0
\.


--
-- Data for Name: investigation_actions; Type: TABLE DATA; Schema: public; Owner: threatuser
--

COPY public.investigation_actions (id, ioc_id, action, analyst, created_at) FROM stdin;
\.


--
-- Data for Name: investigation_notes; Type: TABLE DATA; Schema: public; Owner: threatuser
--

COPY public.investigation_notes (id, ioc_id, note, analyst, created_at) FROM stdin;
\.


--
-- Data for Name: investigation_tags; Type: TABLE DATA; Schema: public; Owner: threatuser
--

COPY public.investigation_tags (id, ioc_id, tag, added_by, created_at) FROM stdin;
\.


--
-- Data for Name: investigations; Type: TABLE DATA; Schema: public; Owner: threatuser
--

COPY public.investigations (id, ioc_id, assigned_to, analyst, created_at) FROM stdin;
\.


--
-- Name: correlations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatuser
--

SELECT pg_catalog.setval('public.correlations_id_seq', 1, false);


--
-- Name: indicators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatuser
--

SELECT pg_catalog.setval('public.indicators_id_seq', 62, true);


--
-- Name: investigation_actions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatuser
--

SELECT pg_catalog.setval('public.investigation_actions_id_seq', 2, true);


--
-- Name: investigation_notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatuser
--

SELECT pg_catalog.setval('public.investigation_notes_id_seq', 3, true);


--
-- Name: investigation_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatuser
--

SELECT pg_catalog.setval('public.investigation_tags_id_seq', 1, true);


--
-- Name: investigations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: threatuser
--

SELECT pg_catalog.setval('public.investigations_id_seq', 1, true);


--
-- Name: correlations correlations_pkey; Type: CONSTRAINT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.correlations
    ADD CONSTRAINT correlations_pkey PRIMARY KEY (id);


--
-- Name: indicators indicators_pkey; Type: CONSTRAINT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.indicators
    ADD CONSTRAINT indicators_pkey PRIMARY KEY (id);


--
-- Name: investigation_actions investigation_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.investigation_actions
    ADD CONSTRAINT investigation_actions_pkey PRIMARY KEY (id);


--
-- Name: investigation_notes investigation_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.investigation_notes
    ADD CONSTRAINT investigation_notes_pkey PRIMARY KEY (id);


--
-- Name: investigation_tags investigation_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.investigation_tags
    ADD CONSTRAINT investigation_tags_pkey PRIMARY KEY (id);


--
-- Name: investigations investigations_pkey; Type: CONSTRAINT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.investigations
    ADD CONSTRAINT investigations_pkey PRIMARY KEY (id);


--
-- Name: ix_correlations_id; Type: INDEX; Schema: public; Owner: threatuser
--

CREATE INDEX ix_correlations_id ON public.correlations USING btree (id);


--
-- Name: ix_indicators_id; Type: INDEX; Schema: public; Owner: threatuser
--

CREATE INDEX ix_indicators_id ON public.indicators USING btree (id);


--
-- Name: ix_indicators_value; Type: INDEX; Schema: public; Owner: threatuser
--

CREATE INDEX ix_indicators_value ON public.indicators USING btree (value);


--
-- Name: correlations correlations_source_ioc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.correlations
    ADD CONSTRAINT correlations_source_ioc_fkey FOREIGN KEY (source_ioc) REFERENCES public.indicators(id);


--
-- Name: correlations correlations_target_ioc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.correlations
    ADD CONSTRAINT correlations_target_ioc_fkey FOREIGN KEY (target_ioc) REFERENCES public.indicators(id);


--
-- Name: investigation_actions investigation_actions_ioc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.investigation_actions
    ADD CONSTRAINT investigation_actions_ioc_id_fkey FOREIGN KEY (ioc_id) REFERENCES public.indicators(id) ON DELETE CASCADE;


--
-- Name: investigation_notes investigation_notes_ioc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.investigation_notes
    ADD CONSTRAINT investigation_notes_ioc_id_fkey FOREIGN KEY (ioc_id) REFERENCES public.indicators(id) ON DELETE CASCADE;


--
-- Name: investigation_tags investigation_tags_ioc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.investigation_tags
    ADD CONSTRAINT investigation_tags_ioc_id_fkey FOREIGN KEY (ioc_id) REFERENCES public.indicators(id) ON DELETE CASCADE;


--
-- Name: investigations investigations_ioc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: threatuser
--

ALTER TABLE ONLY public.investigations
    ADD CONSTRAINT investigations_ioc_id_fkey FOREIGN KEY (ioc_id) REFERENCES public.indicators(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict qY31nyLPl6cUO3dqLupz6RkxkwvMODlAGlufJxwpvxqx7nEg0mdKUo7P9V8ELbN

