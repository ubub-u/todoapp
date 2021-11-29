--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: ubu
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO ubu;

--
-- Name: todolist; Type: TABLE; Schema: public; Owner: ubu
--

CREATE TABLE public.todolist (
    id integer NOT NULL,
    name character varying NOT NULL,
    completed boolean NOT NULL
);


ALTER TABLE public.todolist OWNER TO ubu;

--
-- Name: todolist_id_seq; Type: SEQUENCE; Schema: public; Owner: ubu
--

CREATE SEQUENCE public.todolist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.todolist_id_seq OWNER TO ubu;

--
-- Name: todolist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubu
--

ALTER SEQUENCE public.todolist_id_seq OWNED BY public.todolist.id;


--
-- Name: todos; Type: TABLE; Schema: public; Owner: ubu
--

CREATE TABLE public.todos (
    id integer NOT NULL,
    description character varying NOT NULL,
    completed boolean NOT NULL,
    list_id integer NOT NULL
);


ALTER TABLE public.todos OWNER TO ubu;

--
-- Name: todos_id_seq; Type: SEQUENCE; Schema: public; Owner: ubu
--

CREATE SEQUENCE public.todos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.todos_id_seq OWNER TO ubu;

--
-- Name: todos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ubu
--

ALTER SEQUENCE public.todos_id_seq OWNED BY public.todos.id;


--
-- Name: todolist id; Type: DEFAULT; Schema: public; Owner: ubu
--

ALTER TABLE ONLY public.todolist ALTER COLUMN id SET DEFAULT nextval('public.todolist_id_seq'::regclass);


--
-- Name: todos id; Type: DEFAULT; Schema: public; Owner: ubu
--

ALTER TABLE ONLY public.todos ALTER COLUMN id SET DEFAULT nextval('public.todos_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: ubu
--

COPY public.alembic_version (version_num) FROM stdin;
ea2f64026702
\.


--
-- Data for Name: todolist; Type: TABLE DATA; Schema: public; Owner: ubu
--

COPY public.todolist (id, name, completed) FROM stdin;
2	Urgent	f
3	hello	f
6	listitem	f
5	bravenewworld	f
12	newlist	f
13	listylist	f
\.


--
-- Data for Name: todos; Type: TABLE DATA; Schema: public; Owner: ubu
--

COPY public.todos (id, description, completed, list_id) FROM stdin;
7	doingthing	f	2
8	thing5	f	2
9	howdy there	f	5
11	hello 	f	5
13	hi	f	5
14	hi	f	5
16	adding to a new list	f	12
17	new thing	f	13
18	newthing2	f	13
19	newthing3	f	13
\.


--
-- Name: todolist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubu
--

SELECT pg_catalog.setval('public.todolist_id_seq', 16, true);


--
-- Name: todos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ubu
--

SELECT pg_catalog.setval('public.todos_id_seq', 22, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: ubu
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: todolist todolist_pkey; Type: CONSTRAINT; Schema: public; Owner: ubu
--

ALTER TABLE ONLY public.todolist
    ADD CONSTRAINT todolist_pkey PRIMARY KEY (id);


--
-- Name: todos todos_pkey; Type: CONSTRAINT; Schema: public; Owner: ubu
--

ALTER TABLE ONLY public.todos
    ADD CONSTRAINT todos_pkey PRIMARY KEY (id);


--
-- Name: todos todos_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ubu
--

ALTER TABLE ONLY public.todos
    ADD CONSTRAINT todos_list_id_fkey FOREIGN KEY (list_id) REFERENCES public.todolist(id);


--
-- PostgreSQL database dump complete
--

