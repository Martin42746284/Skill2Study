--
-- PostgreSQL database dump
--

\restrict ngoODTCZuYv5cYMouQLWpe4eyefziGLuxbSeajkNqtur0D5rNaI6w6iunT8b9pi

-- Dumped from database version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)

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

--
-- Name: enum_filieres_difficulte; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_filieres_difficulte AS ENUM (
    'facile',
    'moyen',
    'difficile',
    'tres_difficile'
);


ALTER TYPE public.enum_filieres_difficulte OWNER TO postgres;

--
-- Name: enum_filieres_niveau; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_filieres_niveau AS ENUM (
    'Licence',
    'Master',
    'Doctorat',
    'DTS',
    'DUT',
    'Ingénieur'
);


ALTER TYPE public.enum_filieres_niveau OWNER TO postgres;

--
-- Name: enum_notifications_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_notifications_type AS ENUM (
    'test',
    'candidature',
    'info',
    'success',
    'warning'
);


ALTER TYPE public.enum_notifications_type OWNER TO postgres;

--
-- Name: enum_profils_academiques_mention; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_profils_academiques_mention AS ENUM (
    'Passable',
    'Assez bien',
    'Bien',
    'Très bien'
);


ALTER TYPE public.enum_profils_academiques_mention OWNER TO postgres;

--
-- Name: enum_profils_academiques_preference_type_univ; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_profils_academiques_preference_type_univ AS ENUM (
    'publique',
    'privee',
    'indifferent'
);


ALTER TYPE public.enum_profils_academiques_preference_type_univ OWNER TO postgres;

--
-- Name: enum_recommendation_rules_methode_scoring; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_recommendation_rules_methode_scoring AS ENUM (
    'pondere',
    'knn',
    'decision_tree',
    'hybrid'
);


ALTER TYPE public.enum_recommendation_rules_methode_scoring OWNER TO postgres;

--
-- Name: enum_testimonials_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_testimonials_status AS ENUM (
    'Approuvé',
    'En attente',
    'Rejeté'
);


ALTER TYPE public.enum_testimonials_status OWNER TO postgres;

--
-- Name: enum_tests_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_tests_type AS ENUM (
    'diagnostic',
    'specialise',
    'competence'
);


ALTER TYPE public.enum_tests_type OWNER TO postgres;

--
-- Name: enum_universites_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_universites_type AS ENUM (
    'publique',
    'privee'
);


ALTER TYPE public.enum_universites_type OWNER TO postgres;

--
-- Name: enum_user_settings_profile_visibility; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_user_settings_profile_visibility AS ENUM (
    'public',
    'private'
);


ALTER TYPE public.enum_user_settings_profile_visibility OWNER TO postgres;

--
-- Name: enum_user_settings_theme; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_user_settings_theme AS ENUM (
    'light',
    'dark',
    'system'
);


ALTER TYPE public.enum_user_settings_theme OWNER TO postgres;

--
-- Name: enum_users_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_users_role AS ENUM (
    'bachelier',
    'admin'
);


ALTER TYPE public.enum_users_role OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO postgres;

--
-- Name: favoris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favoris (
    id integer NOT NULL,
    user_id integer NOT NULL,
    filiere_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.favoris OWNER TO postgres;

--
-- Name: favoris_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.favoris_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.favoris_id_seq OWNER TO postgres;

--
-- Name: favoris_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.favoris_id_seq OWNED BY public.favoris.id;


--
-- Name: filieres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.filieres (
    id integer NOT NULL,
    universite_id integer NOT NULL,
    nom character varying(200) NOT NULL,
    code character varying(50),
    domaine character varying(100),
    specialite character varying(150),
    niveau public.enum_filieres_niveau,
    duree_annees character varying(50),
    cout_annuel double precision,
    langue character varying(50) DEFAULT 'Arabe/Français'::character varying,
    series_bac_acceptees json,
    moyenne_min_requise double precision,
    competences_requises json,
    centres_interet json,
    difficulte public.enum_filieres_difficulte,
    taux_emploi double precision,
    salaire_moyen_debutant double precision,
    debouches json,
    description text,
    actif boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    cout_description character varying(255),
    niveaux json DEFAULT '[]'::json
);


ALTER TABLE public.filieres OWNER TO postgres;

--
-- Name: filieres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.filieres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.filieres_id_seq OWNER TO postgres;

--
-- Name: filieres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.filieres_id_seq OWNED BY public.filieres.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    type public.enum_notifications_type NOT NULL,
    title character varying(255) NOT NULL,
    message text NOT NULL,
    data json,
    read boolean DEFAULT false,
    read_at timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: options_reponses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.options_reponses (
    id integer NOT NULL,
    question_id integer NOT NULL,
    texte character varying(300) NOT NULL,
    poids json,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.options_reponses OWNER TO postgres;

--
-- Name: options_reponses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.options_reponses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.options_reponses_id_seq OWNER TO postgres;

--
-- Name: options_reponses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.options_reponses_id_seq OWNED BY public.options_reponses.id;


--
-- Name: parcours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parcours (
    id integer NOT NULL,
    filiere_id integer NOT NULL,
    nom character varying(200) NOT NULL,
    code character varying(50),
    description text,
    duree_mois integer,
    specialisation character varying(150),
    competences_acquises json,
    debouches_professionnels json,
    actif boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.parcours OWNER TO postgres;

--
-- Name: parcours_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.parcours_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.parcours_id_seq OWNER TO postgres;

--
-- Name: parcours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.parcours_id_seq OWNED BY public.parcours.id;


--
-- Name: profils_academiques; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profils_academiques (
    id integer NOT NULL,
    user_id integer NOT NULL,
    serie_bac character varying(50) NOT NULL,
    annee_bac integer,
    mention public.enum_profils_academiques_mention,
    moyenne_generale double precision,
    notes_matieres json,
    competences json,
    centres_interet json,
    scores_test json,
    objectifs_professionnels text,
    secteur_vise character varying(100),
    budget_max_mensuel double precision,
    distance_max_km integer,
    duree_max_etudes integer,
    preference_type_univ public.enum_profils_academiques_preference_type_univ DEFAULT 'indifferent'::public.enum_profils_academiques_preference_type_univ,
    ville_preference character varying(100),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.profils_academiques OWNER TO postgres;

--
-- Name: profils_academiques_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profils_academiques_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profils_academiques_id_seq OWNER TO postgres;

--
-- Name: profils_academiques_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profils_academiques_id_seq OWNED BY public.profils_academiques.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    texte text NOT NULL,
    categorie character varying(100),
    series_bac_cibles json,
    ordre integer,
    actif boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.questions_id_seq OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: recommendation_rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recommendation_rules (
    id integer NOT NULL,
    nom character varying(150) DEFAULT 'Règles par défaut'::character varying NOT NULL,
    description text,
    poids_serie integer DEFAULT 25,
    poids_moyenne integer DEFAULT 20,
    poids_interet integer DEFAULT 20,
    poids_competences integer DEFAULT 15,
    poids_budget integer DEFAULT 10,
    poids_duree integer DEFAULT 5,
    poids_test integer DEFAULT 5,
    moyenne_min_acceptable double precision DEFAULT '10'::double precision,
    filtre_eliminer_hors_serie boolean DEFAULT true,
    filtre_eliminer_hors_budget boolean DEFAULT false,
    top_n_recommendations integer DEFAULT 10,
    methode_scoring public.enum_recommendation_rules_methode_scoring DEFAULT 'pondere'::public.enum_recommendation_rules_methode_scoring,
    actif boolean DEFAULT true,
    est_default boolean DEFAULT false,
    version character varying(50) DEFAULT '1.0'::character varying,
    notes_modifications text,
    date_creation timestamp with time zone,
    date_modification timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.recommendation_rules OWNER TO postgres;

--
-- Name: recommendation_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recommendation_rules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recommendation_rules_id_seq OWNER TO postgres;

--
-- Name: recommendation_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recommendation_rules_id_seq OWNED BY public.recommendation_rules.id;


--
-- Name: recommendations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recommendations (
    id integer NOT NULL,
    user_id integer NOT NULL,
    session_test_id integer,
    filiere_id integer NOT NULL,
    score_compatibilite double precision,
    rang integer,
    justification json,
    sauvegardee boolean DEFAULT false,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.recommendations OWNER TO postgres;

--
-- Name: recommendations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recommendations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recommendations_id_seq OWNER TO postgres;

--
-- Name: recommendations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recommendations_id_seq OWNED BY public.recommendations.id;


--
-- Name: sessions_test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions_test (
    id integer NOT NULL,
    user_id integer NOT NULL,
    reponses json,
    scores json,
    complete boolean DEFAULT false,
    date_completion timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.sessions_test OWNER TO postgres;

--
-- Name: sessions_test_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sessions_test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sessions_test_id_seq OWNER TO postgres;

--
-- Name: sessions_test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sessions_test_id_seq OWNED BY public.sessions_test.id;


--
-- Name: sessions_test_multi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions_test_multi (
    id integer NOT NULL,
    user_id integer NOT NULL,
    test_id integer NOT NULL,
    reponses json DEFAULT '{}'::json,
    score double precision,
    scores_par_domaine json,
    complete boolean DEFAULT false,
    date_completion timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.sessions_test_multi OWNER TO postgres;

--
-- Name: sessions_test_multi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sessions_test_multi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sessions_test_multi_id_seq OWNER TO postgres;

--
-- Name: sessions_test_multi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sessions_test_multi_id_seq OWNED BY public.sessions_test_multi.id;


--
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settings (
    id integer NOT NULL,
    platform_name character varying(200) DEFAULT 'Skill2Study'::character varying,
    platform_description text DEFAULT 'Plateforme d''aide à l''orientation universitaire'::text,
    contact_email character varying(150) DEFAULT 'contact@orientai.mg'::character varying,
    email_notifications boolean DEFAULT true,
    moderation_alerts boolean DEFAULT true,
    weekly_reports boolean DEFAULT false,
    two_factor_auth boolean DEFAULT false,
    open_registration boolean DEFAULT true,
    email_verification boolean DEFAULT true,
    maintenance_mode boolean DEFAULT false,
    maintenance_message text,
    logo_url character varying(255),
    favicon_url character varying(255),
    theme_color character varying(50) DEFAULT '#3b82f6'::character varying,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.settings OWNER TO postgres;

--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.settings_id_seq OWNER TO postgres;

--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;


--
-- Name: test_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_questions (
    id integer NOT NULL,
    test_id integer NOT NULL,
    question_id integer NOT NULL,
    ordre integer,
    poids_importance double precision DEFAULT '1'::double precision,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.test_questions OWNER TO postgres;

--
-- Name: test_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_questions_id_seq OWNER TO postgres;

--
-- Name: test_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_questions_id_seq OWNED BY public.test_questions.id;


--
-- Name: testimonials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.testimonials (
    id integer NOT NULL,
    student_name character varying(150) NOT NULL,
    student_serie character varying(100),
    university_name character varying(200) NOT NULL,
    course_name character varying(200) NOT NULL,
    text text NOT NULL,
    rating integer NOT NULL,
    status public.enum_testimonials_status DEFAULT 'En attente'::public.enum_testimonials_status,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.testimonials OWNER TO postgres;

--
-- Name: testimonials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.testimonials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.testimonials_id_seq OWNER TO postgres;

--
-- Name: testimonials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.testimonials_id_seq OWNED BY public.testimonials.id;


--
-- Name: tests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tests (
    id integer NOT NULL,
    nom character varying(150) NOT NULL,
    description text,
    type public.enum_tests_type DEFAULT 'specialise'::public.enum_tests_type,
    domaine character varying(100),
    duree_minutes integer DEFAULT 15,
    ordre integer,
    actif boolean DEFAULT true,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.tests OWNER TO postgres;

--
-- Name: tests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tests_id_seq OWNER TO postgres;

--
-- Name: tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tests_id_seq OWNED BY public.tests.id;


--
-- Name: universites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.universites (
    id integer NOT NULL,
    nom character varying(200) NOT NULL,
    type public.enum_universites_type NOT NULL,
    ville character varying(100) NOT NULL,
    wilaya character varying(100),
    adresse text,
    site_web character varying(255),
    email_contact character varying(150),
    telephone character varying(60),
    description character varying(500),
    duree_etudes character varying(100),
    cout_estimatif character varying(200),
    logo_url text,
    date_fondation integer,
    actif boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.universites OWNER TO postgres;

--
-- Name: universites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.universites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.universites_id_seq OWNER TO postgres;

--
-- Name: universites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.universites_id_seq OWNED BY public.universites.id;


--
-- Name: user_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_settings (
    id integer NOT NULL,
    user_id integer NOT NULL,
    email_notifications boolean DEFAULT true,
    new_university_notifications boolean DEFAULT true,
    test_updates_notifications boolean DEFAULT true,
    recommendations_notifications boolean DEFAULT true,
    theme public.enum_user_settings_theme DEFAULT 'system'::public.enum_user_settings_theme,
    language character varying(10) DEFAULT 'fr'::character varying,
    profile_visibility public.enum_user_settings_profile_visibility DEFAULT 'private'::public.enum_user_settings_profile_visibility,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.user_settings OWNER TO postgres;

--
-- Name: user_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_settings_id_seq OWNER TO postgres;

--
-- Name: user_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_settings_id_seq OWNED BY public.user_settings.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    nom character varying(100) NOT NULL,
    prenom character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    mot_de_passe character varying(255) NOT NULL,
    role public.enum_users_role DEFAULT 'bachelier'::public.enum_users_role,
    serie_bac character varying(50),
    moyenne_generale double precision,
    ville character varying(100),
    budget_mensuel double precision,
    actif boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    avatar_url text,
    email_verified boolean DEFAULT false,
    verification_token character varying(255),
    verification_token_expires timestamp with time zone,
    email_verification_token character varying(255),
    email_verification_token_expires timestamp with time zone,
    password_reset_token character varying(255),
    password_reset_token_expires timestamp with time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: favoris id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoris ALTER COLUMN id SET DEFAULT nextval('public.favoris_id_seq'::regclass);


--
-- Name: filieres id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres ALTER COLUMN id SET DEFAULT nextval('public.filieres_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: options_reponses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options_reponses ALTER COLUMN id SET DEFAULT nextval('public.options_reponses_id_seq'::regclass);


--
-- Name: parcours id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parcours ALTER COLUMN id SET DEFAULT nextval('public.parcours_id_seq'::regclass);


--
-- Name: profils_academiques id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profils_academiques ALTER COLUMN id SET DEFAULT nextval('public.profils_academiques_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: recommendation_rules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendation_rules ALTER COLUMN id SET DEFAULT nextval('public.recommendation_rules_id_seq'::regclass);


--
-- Name: recommendations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendations ALTER COLUMN id SET DEFAULT nextval('public.recommendations_id_seq'::regclass);


--
-- Name: sessions_test id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions_test ALTER COLUMN id SET DEFAULT nextval('public.sessions_test_id_seq'::regclass);


--
-- Name: sessions_test_multi id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions_test_multi ALTER COLUMN id SET DEFAULT nextval('public.sessions_test_multi_id_seq'::regclass);


--
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- Name: test_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_questions ALTER COLUMN id SET DEFAULT nextval('public.test_questions_id_seq'::regclass);


--
-- Name: testimonials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testimonials ALTER COLUMN id SET DEFAULT nextval('public.testimonials_id_seq'::regclass);


--
-- Name: tests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests ALTER COLUMN id SET DEFAULT nextval('public.tests_id_seq'::regclass);


--
-- Name: universites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universites ALTER COLUMN id SET DEFAULT nextval('public.universites_id_seq'::regclass);


--
-- Name: user_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_settings ALTER COLUMN id SET DEFAULT nextval('public.user_settings_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SequelizeMeta" (name) FROM stdin;
add-avatar-to-users.js
add-cout-description-to-filieres.js
create-multitests-tables.js
update-series-bac-values.js
standardize-domaines.js
\.


--
-- Data for Name: favoris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favoris (id, user_id, filiere_id, created_at, updated_at) FROM stdin;
1	36	487	2026-06-05 13:51:05.14+03	2026-06-05 13:51:05.14+03
2	36	231	2026-06-07 19:37:54.029+03	2026-06-07 19:37:54.029+03
\.


--
-- Data for Name: filieres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.filieres (id, universite_id, nom, code, domaine, specialite, niveau, duree_annees, cout_annuel, langue, series_bac_acceptees, moyenne_min_requise, competences_requises, centres_interet, difficulte, taux_emploi, salaire_moyen_debutant, debouches, description, actif, created_at, updated_at, cout_description, niveaux) FROM stdin;
524	415	Commissaire de Police	\N	Défense et Sécurité	\N	\N	2	\N	Français	["A2","C","D","S"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-09 07:07:43.922+03	2026-06-09 07:07:43.922+03	\N	[]
525	415	Officier de Police	\N	Défense et Sécurité	\N	\N	2	\N	Français	["A2","C","D","S"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-09 07:10:18.727+03	2026-06-09 07:10:18.727+03	\N	[]
526	415	Formation Continue des Cadres de Police	\N	Défense et Sécurité	\N	\N	2 ou 3	\N	Français	["A2","C","D","S"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-09 07:12:21.343+03	2026-06-09 07:12:21.343+03	\N	[]
43	22	Communication et Journalisme	ESSV-COMMJ-001	Arts, Lettres et Communication	Communication et Journalisme	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.946128+03	2026-06-07 18:01:09.924+03	\N	["Licence"]
16	10	Agronomie	EPSA-AGRO-001	Agriculture et Environnement	Sciences Agronomiques	Licence	3	\N	Français	["Toutes séries"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:55:40.920511+03	2026-06-09 07:19:05.261+03	\N	["Licence"]
19	12	Génie Civil - Bâtiment et Travaux Publics	ESBTP-BTP-001	Sciences et Technologies	BTP	Licence	3	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:55:40.923733+03	2026-06-09 07:27:44.216+03	\N	["Licence"]
527	10	Master Agronomie	\N	Agriculture et Environnement	\N	\N	2	\N	Français	["C","D","S","Technique"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-09 07:22:10.645+03	2026-06-09 07:22:10.645+03	\N	[]
110	64	Agronomie	IPSATTA-AGRO-001	Sciences et Technologies	Agronomie	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.028538+03	2026-06-07 18:01:08.974+03	\N	["Licence"]
89	48	BTP	IFTT-BTP-001	Sciences et Technologies	BTP	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.002623+03	2026-06-07 18:01:09.3+03	\N	["Licence"]
528	12	Génie Civil (Master)	\N	Sciences et Technologies	\N	\N	2	\N	Français	["C","D","S","Technique"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-09 07:30:19.982+03	2026-06-09 07:30:19.982+03	\N	[]
147	93	Technologie	ISPPM-TECH-001	Sciences et Technologies	Technologie	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.084782+03	2026-06-07 18:24:33.961+03	\N	["Licence"]
161	118	Agronomie	ONIFRA-AGRO-001	Sciences et Technologies	Agronomie	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.102096+03	2026-06-07 18:01:08.998+03	\N	["Licence"]
145	91	Biotechnologies	ISPM-BIOTECH-001	Sciences et Technologies	Biotechnologies	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.080494+03	2026-06-07 18:01:09.217+03	\N	["Master"]
184	130	Droit	UCM-DROIT-001	Droit et Sciences Politiques	Droit	Master	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.139119+03	2026-06-07 18:01:10.343+03	\N	["Master"]
23	15	Travail Social	ESDEES-TRAVS-002	Sciences Humaines et Sociales	Travail Social	Master	3 - 5	\N	Français	["D","A1","A2"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-02 18:55:40.926913+03	2026-06-09 07:41:48.459+03	\N	["Master"]
529	15	Agronomie	\N	Agriculture et Environnement	\N	\N	3	\N	Français	["D","S","C","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-09 07:46:55.575+03	2026-06-09 07:46:55.575+03	\N	[]
231	149	Biochimie et Sciences de l'Environnement	UMHJ-BIOCHENV-001	Sciences et Technologies	Biochimie	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.21566+03	2026-06-07 18:01:09.156+03	\N	["Master"]
530	14	Droit Privé	\N	Droit et Sciences Politiques	\N	\N	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-09 07:53:19.916+03	2026-06-09 07:53:19.916+03	\N	[]
531	14	Science Politique	\N	Droit et Sciences Politiques	\N	\N	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-09 07:56:04.313+03	2026-06-09 07:56:04.313+03	\N	[]
236	150	Droit	UTOA-DROIT-001	Droit et Sciences Politiques	Droit	Master	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.224511+03	2026-06-07 18:01:10.782+03	\N	["Master"]
532	26	Management de l'Environnement et Gestion de Projets	\N	Sciences de Gestion	\N	\N	36	\N	Français	["Toutes séries"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-09 08:05:00.255+03	2026-06-09 08:05:00.255+03	\N	[]
533	26	Master Ingénierie et Management de Projets	\N	Sciences de Gestion	\N	\N	2	\N	Français	["C","D","S","Technique","A2"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-09 08:08:24.964+03	2026-06-09 08:08:24.964+03	\N	[]
534	26	Master Qualité, Agronomie et Développement Durable	\N	Agriculture et Environnement	\N	\N	2	\N	Français	["A2","C","D"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-09 08:10:24.64+03	2026-06-09 08:10:24.64+03	\N	[]
535	26	Master Informatique Appliquée à la Gestion d'Entreprise	\N	Sciences de Gestion	\N	\N	2	\N	Français	["C","D","Technique","A2"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-09 08:12:06.173+03	2026-06-09 08:12:53.81+03	\N	[]
456	420	Formation Militaire des Cadres Spécialisés (PFMCS)	\N	Formation militaire spécialisée	\N	Licence	1	\N	Français	["C","D","S","A2"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 17:55:11.484+03	2026-06-07 18:18:54.734+03	Généralement pris en charge par l'État	["Licence"]
32	17	Informatique, Risques et Décision	ESMIAP-INFO-001	Sciences et Technologies	Informatique	Licence	3	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:55:40.936766+03	2026-06-09 08:15:44.48+03	\N	["Licence"]
536	17	Banque et Assurance	\N	Sciences de Gestion	\N	\N	3	\N	Français	["A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-09 08:17:06.261+03	2026-06-09 08:17:06.261+03	\N	[]
537	17	Ingénierie et Management de Projets	\N	Sciences de Gestion	\N	\N	3	\N	Français	["A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-09 08:18:20.451+03	2026-06-09 08:18:58.729+03	\N	[]
538	17	Qualité, Agronomie et Développement Durable	\N	Agriculture et Environnement	\N	\N	3	\N	Français	["D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-09 08:19:42.241+03	2026-06-09 08:20:29.523+03	\N	[]
539	17	Informatique Appliquée à la Gestion d'Entreprise (MIAGE)	\N	Sciences et Technologies	\N	\N	2	\N	Français	["C","D","S"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-09 08:21:10.956+03	2026-06-09 08:21:46.51+03	\N	[]
463	2	Agroalimentaire	\N	Industrie Alimentaire	\N	Master	5	\N	Français	\N	\N	\N	\N	moyen	\N	\N	\N	\N	f	2026-06-03 19:02:11.748+03	2026-06-03 19:49:31.549+03	Non publié	["Master"]
439	296	Droit	CNTEMAD-ANT-DROIT-001	Droit et Sciences Politiques	Droit	Master	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.123654+03	2026-06-07 18:01:10.138+03	\N	["Master"]
464	2	Économie et Commerce	\N	Sciences de Gestion	\N	Licence	\N	\N	Français	\N	\N	\N	\N	moyen	\N	\N	\N	\N	f	2026-06-03 19:05:45.309+03	2026-06-03 19:53:07.456+03	Non publié	["Licence"]
468	1	Marketing et Vente	\N	Sciences de Gestion	\N	Master	5	\N	Français	\N	\N	\N	\N	moyen	\N	\N	\N	\N	f	2026-06-03 19:24:43.384+03	2026-06-03 20:30:59.307+03	Non publié	["Master"]
411	276	Santé Publique et Communautaire	UMAT-INFO-001	Santé et Paramédical	Informatique	Master	3 - 5	\N	Français	["C","D","S"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:56:19.076452+03	2026-06-07 18:01:17.37+03	\N	["Licence","Master"]
469	1	Business Development	\N	Développement des affaires	\N	Licence	3	\N	Français	\N	\N	\N	\N	moyen	\N	\N	\N	\N	f	2026-06-03 19:26:53.313+03	2026-06-03 20:30:08.332+03	Non publié	["Licence"]
540	23	Comptabilité et Finances	\N	Sciences de Gestion	\N	\N	3	\N	Français	["A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-09 08:27:09.368+03	2026-06-09 08:27:09.368+03	\N	[]
541	23	Commerce International	\N	Sciences de Gestion	\N	\N	3	\N	Français	["A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-09 08:28:41.466+03	2026-06-09 08:28:41.466+03	\N	[]
542	23	Marketing et Distribution	\N	Sciences de Gestion	\N	\N	3	\N	Français	["A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-09 08:30:11.585+03	2026-06-09 08:31:17.845+03	\N	[]
543	23	Management Stratégique	\N	Sciences de Gestion	\N	\N	3 - 5	\N	Français	["A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-09 08:31:48.119+03	2026-06-09 08:33:01.003+03	\N	[]
544	23	Marketing Touristique et Gestion Hôtelière	\N	Sciences de Gestion	\N	\N	3	\N	Français	["A1","A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-09 08:33:38.525+03	2026-06-09 08:33:38.525+03	\N	[]
454	275	Formation Militaire	ACMIL-MIL-001	Droit et Sciences Politiques	Militaire	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.141307+03	2026-06-07 18:01:11.857+03	\N	["Licence"]
451	273	Sciences Nucléaires	INSTN-NUCL-002	Sciences et Technologies	Physique	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.138507+03	2026-06-07 18:23:42.864+03	\N	["Master"]
450	273	Sciences Nucléaires	INSTN-NUCL-001	Sciences et Technologies	Physique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.137521+03	2026-06-07 18:23:44.901+03	\N	["Licence"]
453	274	Tourisme et Hôtellerie	INTH-TOUR-002	Arts, Lettres et Communication	Tourisme	Master	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.140427+03	2026-06-07 18:25:06.557+03	\N	["Master"]
452	274	Tourisme et Hôtellerie	INTH-TOUR-001	Arts, Lettres et Communication	Tourisme	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.139461+03	2026-06-07 18:25:08.604+03	\N	["Licence"]
45	24	Intégration et Développement (IDEV)	ESTI-INFO-001	Sciences et Technologies	Informatique	Licence	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:55:40.947721+03	2026-06-09 08:37:10.97+03	\N	["Licence"]
545	24	Réseaux et Systèmes (RSI)	\N	Sciences et Technologies	\N	\N	3	\N	Français	["C","D","S"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-09 08:38:57.75+03	2026-06-09 08:40:19.77+03	\N	[]
546	24	Management des Systèmes d'Information (MSI)	\N	Sciences et Technologies	\N	\N	2	\N	Français	["C","D","S"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-09 08:40:54.949+03	2026-06-09 08:42:40.746+03	\N	[]
547	24	Infrastructure et Cybersécurité (IC)	\N	Sciences et Technologies	\N	\N	2	\N	Français	["C","D","S"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-09 08:43:15.696+03	2026-06-09 08:44:17.47+03	\N	[]
508	8	Gestion et Administration d'Entreprises	\N	Sciences de Gestion	\N	\N	2 - 5	\N	Français	["A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-04 16:18:40.65+03	2026-06-07 18:21:07.619+03	\N	["Master","DTS","Licence"]
513	276	Sciences Infirmières	\N	Santé et Paramédical	\N	\N	3	\N	Français	["C","D","S"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-04 16:42:41.092+03	2026-06-07 18:23:30.623+03	\N	["Licence"]
518	6	Génie Civil et Bâtiment	\N	Génie Civil	\N	\N	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-05 11:50:30.538+03	2026-06-07 18:18:56.763+03	\N	["Licence","Ingénieur"]
1	1	Marketing et Vente	BS-INFOG-001	Sciences de Gestion	Informatique de Gestion	Licence	3 - 5	\N	Français	["A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-02 18:55:40.896521+03	2026-06-07 18:21:46.451+03	Non publié	["Licence","Master"]
27	16	Sciences de Gestion	ESIGE-SCGEST-001	Sciences de Gestion	Sciences de Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.93001+03	2026-06-07 18:22:04.855+03	\N	["Licence"]
313	249	Sciences Humaines et Sociales	ED-GEOCHIMEDE-001	Sciences Humaines et Sociales	Chimie	Doctorat	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.508863+03	2026-06-07 18:23:20.422+03	\N	["Doctorat"]
470	1	Business Development	\N	Développement des affaires	\N	Master	5	500000	Français	["A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 19:28:40.506+03	2026-06-07 18:18:15.834+03	Non publié	["Master","Licence"]
28	16	Droit	ESIGE-DROIT-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.930738+03	2026-06-07 18:01:10.034+03	\N	["Licence"]
39	21	Commerce et Gestion	ESSGM-COMGEST-001	Sciences de Gestion	Commerce et Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.942986+03	2026-06-07 18:18:21.968+03	\N	["Licence"]
4	2	Sciences Agronomiques	ASJA-AGRO-002	Agriculture et Environnement	Sciences Agronomiques	Master	5	\N	Français	\N	\N	\N	\N	moyen	\N	\N	\N	\N	f	2026-06-02 18:55:40.9072+03	2026-06-03 20:29:40.399+03	Non publié	["Master"]
10	2	Droit	ASJA-DROIT-002	Droit et Sciences Politiques	Droit	Licence	3	\N	Français	\N	\N	\N	\N	difficile	\N	\N	\N	\N	f	2026-06-02 18:55:40.912925+03	2026-06-03 19:52:13.318+03	Non publié	["Licence"]
46	25	Droit	ESTIIM-DROIT-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.949282+03	2026-06-07 18:01:10.3+03	\N	["Licence"]
38	20	Droit	ESSD-DROIT-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.942169+03	2026-06-07 18:01:10.366+03	\N	["Licence"]
41	21	Droit	ESSGM-DROIT-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.944522+03	2026-06-07 18:01:10.618+03	\N	["Licence"]
160	117	Droit	MUST-DROIT-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.099882+03	2026-06-07 18:01:10.74+03	\N	["Licence"]
47	25	Droit et Sciences Politiques	ESTIIM-DROITSP-001	Droit et Sciences Politiques	Droit	Master	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.951742+03	2026-06-07 18:01:11.004+03	\N	["Master"]
30	16	Droit et Sciences Politiques	ESIGE-DROITSP-001	Droit et Sciences Politiques	Droit	Master	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.93459+03	2026-06-07 18:01:11.09+03	\N	["Master"]
51	25	Environnement	ESTIIM-ENV-001	Sciences et Technologies	Environnement	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.95648+03	2026-06-07 18:01:11.607+03	\N	["Licence"]
5	2	Géosciences	ASJA-SCTERR-001	Sciences et Technologies	Sciences de la Terre	Licence	3	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:55:40.908216+03	2026-06-07 18:01:11.94+03	Non publié	["Licence"]
29	16	Informatique	ESIGE-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.932101+03	2026-06-07 18:01:14.314+03	\N	["Licence"]
53	25	Informatique	ESTIIM-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.958529+03	2026-06-07 18:01:14.43+03	\N	["Licence"]
34	18	Informatique	ESPBIG-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.939075+03	2026-06-07 18:01:14.581+03	\N	["Licence"]
50	25	Administration, Management, Commerce, Marketing	ESTIIM-ADMM-002	Sciences de Gestion	Management	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.955347+03	2026-06-07 18:18:01.508+03	\N	["Master"]
49	25	Administration, Management, Commerce, Marketing	ESTIIM-ADMM-001	Sciences de Gestion	Management	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.953948+03	2026-06-07 18:18:03.547+03	\N	["Licence"]
314	250	Affaires Comptables et Financières	ED-SMH-001	Sciences de Gestion	Sciences Marines	Doctorat	3 - 5	\N	Français	["A2","C","D"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.510509+03	2026-06-07 18:18:07.626+03	\N	["Doctorat"]
40	21	Commerce et Gestion	ESSGM-COMGEST-002	Sciences de Gestion	Commerce et Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.943709+03	2026-06-07 18:18:24.001+03	\N	["Master"]
25	16	Gestion	ESIGE-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.92829+03	2026-06-07 18:19:13.106+03	\N	["Licence"]
26	16	Gestion	ESIGE-GEST-002	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.929149+03	2026-06-07 18:19:15.153+03	\N	["Master"]
48	25	Gestion	ESTIIM-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.952915+03	2026-06-07 18:20:10.366+03	\N	["Licence"]
36	19	Gestion	ESPIC-GEST-002	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.940625+03	2026-06-07 18:20:38.963+03	\N	["Master"]
35	19	Gestion	ESPIC-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.939864+03	2026-06-07 18:20:51.261+03	\N	["Licence"]
42	22	Gestion Management	ESSV-GESTM-001	Sciences de Gestion	Gestion Management	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.945338+03	2026-06-07 18:21:13.779+03	\N	["Licence"]
37	19	Sciences de Gestion	ESPIC-SCGEST-001	Sciences de Gestion	Sciences de Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.94138+03	2026-06-07 18:22:08.923+03	\N	["Master"]
6	2	Sciences de la Terre	ASJA-SCTERR-002	Sciences et Technologies	Sciences de la Terre	Master	5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:55:40.909516+03	2026-06-07 18:22:29.297+03	Non publié	["Master"]
61	29	Industriel	ETSM-IND-001	Sciences et Technologies	Technologie Industrielle	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.968897+03	2026-06-07 18:01:13.536+03	\N	["Licence"]
59	28	Maintenance	ETFPS-MAINT-001	Sciences et Technologies	Maintenance	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.96449+03	2026-06-07 18:01:15.616+03	\N	["Licence"]
67	32	Agronomie	GATE-AGRO-001	Sciences et Technologies	Agronomie	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.97588+03	2026-06-07 18:01:08.943+03	\N	["Licence"]
86	46	BTP	IFTBTP-BTP-001	Sciences et Technologies	BTP	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.996646+03	2026-06-07 18:01:09.259+03	\N	["Licence"]
81	44	Droit	IFT-DROIT-001	Droit et Sciences Politiques	Droit	Master	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.992159+03	2026-06-07 18:01:10.534+03	\N	["Master"]
12	5	Équipement Rural	CFAMA-AGRO-001	Sciences et Technologies	Sciences Agronomiques	Licence	2	\N	Français	["C","D","S","Technique"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-02 18:55:40.914352+03	2026-06-07 18:01:11.79+03	\N	["DTS"]
264	188	Infirmier	INSPNMAD-INF-001	Sciences et Technologies	Infirmier	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.344703+03	2026-06-07 18:01:13.68+03	\N	["Licence"]
24	15	Gestion	ESDEES-GEST-001	Sciences de Gestion	Gestion	Licence	3	\N	Français	["A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-02 18:55:40.927539+03	2026-06-09 07:42:59.116+03	\N	["Licence"]
22	15	Économie	ESDEES-TRAVS-001	Sciences de Gestion	Travail Social	Licence	3	\N	Français	["C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-02 18:55:40.926072+03	2026-06-09 07:44:29.721+03	\N	["Licence"]
21	14	Droit Public	ESD-DROIT-001	Droit et Sciences Politiques	Droit	Licence	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:55:40.925281+03	2026-06-09 07:51:06.504+03	\N	["Licence"]
55	26	Gestion	ESM-GEST-001	Sciences de Gestion	Gestion	Licence	3	\N	Français	["Toutes séries"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-02 18:55:40.960598+03	2026-06-09 08:01:25.365+03	\N	["Licence"]
54	26	Banque et Assurance	ESM-INFO-001	Sciences de Gestion	Informatique	Licence	3	\N	Français	["C","D","A2"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-02 18:55:40.959637+03	2026-06-09 08:03:25.94+03	\N	["Licence"]
31	17	Management de l'Environnement et Gestion de Projets	ESMIAP-GEST-001	Sciences de Gestion	Gestion	Licence	3	\N	Français	["A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:55:40.935847+03	2026-06-09 08:14:45.488+03	\N	["Licence"]
44	23	Développement Informatique – Réseaux et Télécommunications	EST-INFO-001	Sciences et Technologies	Informatique	Licence	3	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:55:40.946905+03	2026-06-09 08:25:10.498+03	\N	["Licence"]
415	278	Informatique	UINF-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.085341+03	2026-06-07 18:01:14.201+03	\N	["Licence"]
88	48	Informatique	IFTT-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.999957+03	2026-06-07 18:01:14.358+03	\N	["Licence"]
82	44	Informatique	IFT-INFO-001	Sciences et Technologies	Informatique	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.993098+03	2026-06-07 18:01:14.811+03	\N	["Master"]
60	28	Informatique	ETFPS-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.967191+03	2026-06-07 18:01:14.829+03	\N	["Licence"]
416	279	Informatique	JAU-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.088877+03	2026-06-07 18:01:14.99+03	\N	["Licence"]
85	45	Informatique	IFTA-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.995902+03	2026-06-07 18:01:15.154+03	\N	["Licence"]
71	36	Informatique	ICTUS-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.979276+03	2026-06-07 18:01:15.256+03	\N	["Licence"]
62	30	Ingenierie et Management des Actions de Developpement	EUIOI-INGM-001	Arts, Lettres et Communication	Management	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.97011+03	2026-06-07 18:01:15.492+03	\N	["Licence"]
58	27	Administration, Gestion, Finances, Informatique de Gestion	ETEC-ADMG-002	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.963527+03	2026-06-07 18:17:57.399+03	\N	["Master"]
18	11	Banque et Institutions de Microfinance	EPSL-BANQ-001	Sciences de Gestion	Banque	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.922933+03	2026-06-07 18:18:11.738+03	\N	["Licence"]
64	32	Gestion	GATE-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.972786+03	2026-06-07 18:19:37.677+03	\N	["Licence"]
72	36	Gestion	ICTUS-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.980142+03	2026-06-07 18:19:41.792+03	\N	["Licence"]
65	32	Gestion	GATE-GEST-002	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.973801+03	2026-06-07 18:19:54.047+03	\N	["Master"]
80	40	Gestion	IESTIMA-GEST-002	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.991123+03	2026-06-07 18:20:06.283+03	\N	["Master"]
76	39	Gestion	IESTIM-GEST-002	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.98631+03	2026-06-07 18:20:22.6+03	\N	["Master"]
79	40	Gestion	IESTIMA-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.990049+03	2026-06-07 18:20:26.696+03	\N	["Licence"]
75	39	Gestion	IESTIM-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.985194+03	2026-06-07 18:20:43.067+03	\N	["Licence"]
17	11	Gestion et Administration d'Entreprises	EPSL-GADM-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.921972+03	2026-06-07 18:21:05.573+03	\N	["Licence"]
68	33	Management et Sciences	HECMM-MGTS-001	Sciences de Gestion	Management	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.976766+03	2026-06-07 18:21:42.362+03	\N	["Master"]
77	39	Sciences de Gestion	IESTIM-SCGEST-001	Sciences de Gestion	Sciences de Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.987338+03	2026-06-07 18:22:10.965+03	\N	["Licence"]
69	34	Sciences de Gestion	HEDM-SCGEST-001	Sciences de Gestion	Sciences de Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.97747+03	2026-06-07 18:22:15.031+03	\N	["Licence"]
84	44	Sciences de l'Environnement	IFT-SCENV-001	Sciences et Technologies	Environnement	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.994979+03	2026-06-07 18:22:49.727+03	\N	["Master"]
78	39	Sciences de l'Informatique	IESTIM-SCINFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.98889+03	2026-06-07 18:23:01.988+03	\N	["Licence"]
70	34	Sciences juridiques	HEDM-SCJUR-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.978357+03	2026-06-07 18:23:32.661+03	\N	["Licence"]
74	38	Sciences Politiques	IEP-SCPOL-002	Droit et Sciences Politiques	Sciences Politiques	Master	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.983435+03	2026-06-07 18:23:48.978+03	\N	["Master"]
73	38	Sciences Politiques	IEP-SCPOL-001	Droit et Sciences Politiques	Sciences Politiques	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.980996+03	2026-06-07 18:23:51.025+03	\N	["Licence"]
15	9	Technologie	CONDORCET-TECH-002	Sciences et Technologies	Technologie	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.919539+03	2026-06-07 18:24:29.904+03	\N	["Master"]
14	9	Technologie	CONDORCET-TECH-001	Sciences et Technologies	Technologie	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.918326+03	2026-06-07 18:24:31.934+03	\N	["Licence"]
66	32	Tourisme	GATE-TOUR-001	Arts, Lettres et Communication	Tourisme	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.974833+03	2026-06-07 18:24:56.375+03	\N	["Licence"]
101	54	Building and Public Work	IMT-BPW-001	Sciences et Technologies	BTP	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.018115+03	2026-06-07 18:01:09.323+03	\N	["Licence"]
104	58	Droit	IUR-DROIT-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.022523+03	2026-06-07 18:01:10.411+03	\N	["Licence"]
132	83	Droit	IUPM-DROIT-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.064326+03	2026-06-07 18:01:10.449+03	\N	["Licence"]
105	58	Droit	IUR-DROIT-002	Droit et Sciences Politiques	Droit	Master	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.02364+03	2026-06-07 18:01:10.819+03	\N	["Master"]
135	85	Droit des Affaires et Administration d'Entreprises	ISMST-DROITAFF-001	Droit et Sciences Politiques	Droit	Master	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.070166+03	2026-06-07 18:01:10.862+03	\N	["Master"]
134	85	Droit et Sciences Politiques	ISMST-DROITSP-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.068867+03	2026-06-07 18:01:10.953+03	\N	["Licence"]
122	78	Gestion Informatique	ISIIME-GESTINFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.047667+03	2026-06-07 18:01:13.356+03	\N	["Licence"]
123	78	Gestion Informatique	ISIIME-GESTINFO-002	Sciences et Technologies	Informatique	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.050574+03	2026-06-07 18:01:13.405+03	\N	["Master"]
114	67	Informatique	ISAPSP-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.034748+03	2026-06-07 18:01:14.038+03	\N	["Licence"]
126	79	Informatique	ISI-INFO-002	Sciences et Technologies	Informatique	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.057316+03	2026-06-07 18:01:14.105+03	\N	["Master"]
125	79	Informatique	ISI-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.054902+03	2026-06-07 18:01:14.17+03	\N	["Licence"]
20	13	Gestion	ESCT-COMM-001	Sciences de Gestion	Commerce	Licence	3	\N	Français	["A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-02 18:55:40.92456+03	2026-06-09 07:34:56.072+03	\N	["Licence"]
56	26	Informatique, Risques et Décision	ESM-STAT-001	Sciences et Technologies	Statistique	Licence	3	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:55:40.961638+03	2026-06-09 08:06:29.862+03	\N	["Licence"]
106	58	Informatique	IUR-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.024718+03	2026-06-07 18:01:14.612+03	\N	["Licence"]
120	74	Informatique	ISGEI-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.042463+03	2026-06-07 18:01:14.672+03	\N	["Licence"]
117	70	Informatique	ISCM-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.03928+03	2026-06-07 18:01:14.772+03	\N	["Licence"]
121	74	Informatique	ISGEI-INFO-002	Sciences et Technologies	Informatique	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.044948+03	2026-06-07 18:01:14.941+03	\N	["Master"]
94	53	Sciences Biologiques et environnementales	IMAM-SCBENV-001	Sciences et Technologies	Sciences Biologiques	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.009265+03	2026-06-07 18:01:17.594+03	\N	["Licence"]
95	53	Administration	IMAM-ADM-001	Sciences de Gestion	Administration	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.010264+03	2026-06-07 18:17:53.285+03	\N	["Master"]
107	59	Banque et Institutions des micros finances	INSPNMAD-BANQ-001	Sciences de Gestion	Banque	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.025715+03	2026-06-07 18:18:13.79+03	\N	["Master"]
119	73	Gestion	ISETES-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.041261+03	2026-06-07 18:19:11.068+03	\N	["Licence"]
136	87	Gestion	ISNA-GEST-001	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.07182+03	2026-06-07 18:19:21.334+03	\N	["Master"]
109	63	Gestion	IPAM-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.027593+03	2026-06-07 18:19:29.494+03	\N	["Licence"]
102	58	Gestion	IUR-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.019602+03	2026-06-07 18:19:39.754+03	\N	["Licence"]
108	62	Gestion	ITPAME-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.026734+03	2026-06-07 18:19:52.008+03	\N	["Licence"]
113	66	Gestion	IAEAC-GEST-001	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.031943+03	2026-06-07 18:19:58.132+03	\N	["Master"]
129	83	Gestion	IUPM-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.060989+03	2026-06-07 18:20:04.242+03	\N	["Licence"]
116	69	Gestion	ISCAM-GEST-002	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.037401+03	2026-06-07 18:20:30.787+03	\N	["Master"]
103	58	Gestion	IUR-GEST-002	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.020714+03	2026-06-07 18:20:34.889+03	\N	["Master"]
115	69	Gestion	ISCAM-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.036239+03	2026-06-07 18:20:36.928+03	\N	["Licence"]
124	78	Gestion	ISIIME-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.053202+03	2026-06-07 18:20:45.114+03	\N	["Licence"]
130	83	Gestion	IUPM-GEST-002	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.062223+03	2026-06-07 18:20:55.357+03	\N	["Master"]
133	85	Gestion en Administration d'Entreprise	ISMST-GADM-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.066822+03	2026-06-07 18:21:03.529+03	\N	["Licence"]
111	66	Management	IAEAC-MGT-001	Sciences de Gestion	Management	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.029355+03	2026-06-07 18:21:25.988+03	\N	["Licence"]
100	54	Management and Business Studies	IMT-MBS-002	Sciences de Gestion	Management	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.015463+03	2026-06-07 18:21:28.039+03	\N	["Master"]
99	54	Management and Business Studies	IMT-MBS-001	Sciences de Gestion	Management	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.013956+03	2026-06-07 18:21:30.081+03	\N	["Licence"]
96	53	Management d'Entreprise et Banque	IMAM-MGTB-001	Sciences de Gestion	Management	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.011321+03	2026-06-07 18:21:32.121+03	\N	["Master"]
91	50	Sciences et Technologies	IISS-SCTECH-002	Sciences et Technologies	Sciences	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.005612+03	2026-06-07 18:23:14.286+03	\N	["Master"]
90	50	Sciences et Technologies	IISS-SCTECH-001	Sciences et Technologies	Sciences	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.004125+03	2026-06-07 18:23:16.34+03	\N	["Licence"]
128	81	Technologie	ISM2M-TECH-002	Sciences et Technologies	Technologie	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.059794+03	2026-06-07 18:24:25.813+03	\N	["Master"]
127	81	Technologie	ISM2M-TECH-001	Sciences et Technologies	Technologie	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.058654+03	2026-06-07 18:24:27.859+03	\N	["Licence"]
171	125	Droit	UNPT-DROIT-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.114498+03	2026-06-07 18:01:10.657+03	\N	["Licence"]
166	118	Droit	ONIFRA-DROIT-001	Droit et Sciences Politiques	Droit	Master	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.108839+03	2026-06-07 18:01:10.698+03	\N	["Master"]
140	91	Droit et Technique des Affaires	ISPM-DROITAFF-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.075992+03	2026-06-07 18:01:11.138+03	\N	["Licence"]
162	118	Environnement	ONIFRA-ENV-001	Sciences et Technologies	Environnement	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.103306+03	2026-06-07 18:01:11.496+03	\N	["Master"]
144	91	Environnement et Tourisme	ISPM-ENVTOUR-001	Sciences et Technologies	Environnement	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.079644+03	2026-06-07 18:01:11.748+03	\N	["Master"]
174	127	Informatique	TSI-INFO-002	Sciences et Technologies	Informatique	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.120345+03	2026-06-07 18:01:14.39+03	\N	["Master"]
150	99	Informatique	ISSMI-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.089262+03	2026-06-07 18:01:14.642+03	\N	["Licence"]
151	99	Informatique	ISSMI-INFO-002	Sciences et Technologies	Informatique	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.09033+03	2026-06-07 18:01:14.756+03	\N	["Master"]
173	127	Informatique	TSI-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.119131+03	2026-06-07 18:01:14.791+03	\N	["Licence"]
157	112	Informatique	JDU-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.095865+03	2026-06-07 18:01:14.882+03	\N	["Licence"]
172	126	Informatique	TOPINFO-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.117195+03	2026-06-07 18:01:14.964+03	\N	["Licence"]
178	129	Informatique	UADV-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.125216+03	2026-06-07 18:01:15.2+03	\N	["Licence"]
156	111	Administration d'Entreprise	IUPAEM-ADM-001	Sciences de Gestion	Administration	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.094939+03	2026-06-07 18:17:55.346+03	\N	["Licence"]
137	88	Gestion	ISNM-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.073041+03	2026-06-07 18:19:17.198+03	\N	["Licence"]
168	120	Gestion	ONIFRA-ARIV-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.111559+03	2026-06-07 18:19:19.29+03	\N	["Licence"]
149	98	Gestion	ISSIG-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.087455+03	2026-06-07 18:19:23.38+03	\N	["Licence"]
167	119	Gestion	ONIFRA-AMBTM-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.110312+03	2026-06-07 18:19:35.629+03	\N	["Licence"]
177	129	Gestion	UADV-GEST-002	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.124179+03	2026-06-07 18:19:43.841+03	\N	["Master"]
153	101	Gestion	ISSG-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.092257+03	2026-06-07 18:19:47.924+03	\N	["Licence"]
175	127	Gestion	TSI-GEST-001	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.122028+03	2026-06-07 18:20:08.326+03	\N	["Master"]
185	130	Gestion	UCM-GEST-001	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.14082+03	2026-06-07 18:20:14.454+03	\N	["Master"]
155	110	Gestion	IUM-GEST-001	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.094103+03	2026-06-07 18:20:16.498+03	\N	["Master"]
176	129	Gestion	UADV-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.123145+03	2026-06-07 18:20:47.161+03	\N	["Licence"]
169	121	Gestion	ONIFRA-MOR-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.112588+03	2026-06-07 18:20:49.211+03	\N	["Licence"]
154	110	Gestion et Commerce	IUM-GCOM-001	Sciences de Gestion	Commerce	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.093168+03	2026-06-07 18:21:09.681+03	\N	["Licence"]
146	92	Gestion et Commerce International	ISPMDDF-GCOMINT-001	Sciences de Gestion	Commerce	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.081905+03	2026-06-07 18:21:11.73+03	\N	["Licence"]
159	116	Sciences de la Gestion	MU-SCGEST-001	Sciences de Gestion	Sciences de Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.097597+03	2026-06-07 18:22:23.169+03	\N	["Licence"]
158	112	Sciences de la Gestion	JDU-SCGEST-001	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.09668+03	2026-06-07 18:22:25.214+03	\N	["Master"]
139	89	Sciences de la Vie et de la Terre	ISPA-SCVT-001	Sciences et Technologies	Sciences de la Vie et Terre	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.075012+03	2026-06-07 18:22:43.604+03	\N	["Licence"]
148	97	Sciences de l'Environnement	ISLEG-SCENV-001	Sciences et Technologies	Environnement	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.086428+03	2026-06-07 18:22:51.766+03	\N	["Licence"]
164	118	Sciences de l'Informatique	ONIFRA-SCINFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.10631+03	2026-06-07 18:23:04.025+03	\N	["Licence"]
143	91	Technique de l'environnement et du Tourisme	ISPM-TECHENVTOUR-001	Sciences et Technologies	Environnement	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.078901+03	2026-06-07 18:24:19.68+03	\N	["Licence"]
141	91	Technique du Tourisme	ISPM-TECHTOUR-001	Arts, Lettres et Communication	Tourisme	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.077006+03	2026-06-07 18:24:23.77+03	\N	["Licence"]
209	146	Biologie	UANT-BIO-001	Sciences et Technologies	Biologie	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.177651+03	2026-06-07 18:01:09.177+03	\N	["Licence"]
210	146	Biologie	UANT-BIO-002	Sciences et Technologies	Biologie	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.178681+03	2026-06-07 18:01:09.196+03	\N	["Master"]
188	132	BTP	UGSI-BTP-001	Sciences et Technologies	BTP	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.14624+03	2026-06-07 18:01:09.278+03	\N	["Licence"]
207	146	Chimie	UANT-CHEM-001	Sciences et Technologies	Chimie	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.175608+03	2026-06-07 18:01:09.348+03	\N	["Licence"]
208	146	Chimie	UANT-CHEM-002	Sciences et Technologies	Chimie	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.176591+03	2026-06-07 18:01:09.366+03	\N	["Master"]
228	148	Chimie	UYFIN-CHEM-001	Sciences et Technologies	Chimie	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.210622+03	2026-06-07 18:01:09.39+03	\N	["Master"]
202	145	Droit	MBS-DROIT-001	Droit et Sciences Politiques	Droit	Master	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.169554+03	2026-06-07 18:01:09.966+03	\N	["Master"]
201	145	Droit et Sciences politiques	MBS-DROITSP-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.167894+03	2026-06-07 18:01:10.914+03	\N	["Licence"]
225	148	Informatique	UYFIN-INFO-001	Sciences et Technologies	Informatique	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.204914+03	2026-06-07 18:01:14.555+03	\N	["Master"]
186	132	Informatique	UGSI-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.142929+03	2026-06-07 18:01:15.015+03	\N	["Licence"]
198	139	Informatique	UPHS-INFO-001	Sciences et Technologies	Informatique	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.161833+03	2026-06-07 18:01:15.309+03	\N	["Master"]
197	139	Informatique de gestion	UPHS-INFOG-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.160731+03	2026-06-07 18:01:15.342+03	\N	["Licence"]
195	137	Informatique de Gestion	UP-INFOG-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.158291+03	2026-06-07 18:01:15.364+03	\N	["Licence"]
215	146	Informatique et Technologie	UANT-INFTECH-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.186573+03	2026-06-07 18:01:15.402+03	\N	["Licence"]
216	146	Informatique et Technologie	UANT-INFTECH-002	Sciences et Technologies	Informatique	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.188+03	2026-06-07 18:01:15.435+03	\N	["Master"]
227	148	Maths et Applications	UYFIN-MATHAPP-002	Sciences et Technologies	Mathématiques	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.209042+03	2026-06-07 18:01:15.758+03	\N	["Master"]
226	148	Maths et Applications	UYFIN-MATHAPP-001	Sciences et Technologies	Mathématiques	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.207484+03	2026-06-07 18:01:15.789+03	\N	["Licence"]
223	148	Physique Chimie	UYFIN-PHYSCHEM-001	Sciences et Technologies	Physique Chimie	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.20066+03	2026-06-07 18:01:16.067+03	\N	["Licence"]
224	148	Physique Chimie	UYFIN-PHYSCHEM-002	Sciences et Technologies	Physique Chimie	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.203151+03	2026-06-07 18:01:16.151+03	\N	["Master"]
211	146	Physique et Applications	UANT-PHYSAPP-001	Sciences et Technologies	Physique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.179698+03	2026-06-07 18:01:16.187+03	\N	["Licence"]
212	146	Physique et Applications	UANT-PHYSAPP-002	Sciences et Technologies	Physique	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.180591+03	2026-06-07 18:01:16.27+03	\N	["Master"]
217	147	Sciences Chimiques	UATSN-SCCHEM-001	Sciences et Technologies	Sciences Chimiques	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.189535+03	2026-06-07 18:01:17.634+03	\N	["Master"]
189	134	Commerce	UIM-COMM-001	Sciences de Gestion	Commerce	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.147602+03	2026-06-07 18:18:19.92+03	\N	["Licence"]
196	138	Entreprenariat rural	UPAVA-ENTREPURAL-001	Sciences de Gestion	Entrepreneuriat	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.159548+03	2026-06-07 18:18:46.546+03	\N	["Licence"]
193	137	Gestion	UP-GEST-002	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.155459+03	2026-06-07 18:19:33.587+03	\N	["Master"]
204	145	Gestion	MBS-GEST-002	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.172585+03	2026-06-07 18:20:12.405+03	\N	["Master"]
187	132	Gestion	UGSI-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.144642+03	2026-06-07 18:20:20.557+03	\N	["Licence"]
203	145	Gestion	MBS-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.17077+03	2026-06-07 18:20:24.641+03	\N	["Licence"]
192	137	Gestion	UP-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.153751+03	2026-06-07 18:20:28.744+03	\N	["Licence"]
190	134	Gestion	UIM-GEST-001	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.14985+03	2026-06-07 18:20:32.839+03	\N	["Master"]
219	147	Sciences de la Nature et de l'Environnement	UATSN-SCNENV-001	Sciences et Technologies	Environnement	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.191491+03	2026-06-07 18:22:27.257+03	\N	["Master"]
213	146	Sciences de la Terre et de l'Environnement	UANT-SCTERR-001	Sciences et Technologies	Sciences de la Terre	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.182437+03	2026-06-07 18:22:31.34+03	\N	["Licence"]
214	146	Sciences de la Terre et de l'Environnement	UANT-SCTERR-002	Sciences et Technologies	Sciences de la Terre	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.185068+03	2026-06-07 18:22:33.378+03	\N	["Master"]
229	148	Sciences de la vie	UYFIN-SCVIE-001	Sciences et Technologies	Sciences de la Vie	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.212131+03	2026-06-07 18:22:35.418+03	\N	["Licence"]
230	148	Sciences de la vie	UYFIN-SCVIE-002	Sciences et Technologies	Sciences de la Vie	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.213661+03	2026-06-07 18:22:37.465+03	\N	["Master"]
220	147	Sciences du Vivant et de la Terre	UATSN-SCVT-001	Sciences et Technologies	Sciences de la Vie et Terre	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.192635+03	2026-06-07 18:23:08.11+03	\N	["Licence"]
222	147	Sciences et Technologie de l'Information et de la Communication	UATSN-STIC-001	Sciences et Technologies	Technologie Information	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.197681+03	2026-06-07 18:23:12.207+03	\N	["Licence"]
218	147	Sciences Physiques	UATSN-SCPHYS-001	Sciences et Technologies	Sciences Physiques	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.190529+03	2026-06-07 18:23:46.938+03	\N	["Master"]
234	149	Droit et sciences Politiques	UMHJ-DROITSP-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.222179+03	2026-06-07 18:01:10.889+03	\N	["Licence"]
278	210	Infirmier	ISPAVA-INF-001	Sciences et Technologies	Infirmier	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.425218+03	2026-06-07 18:01:13.555+03	\N	["Licence"]
257	171	Infirmier	IFPMDR-INF-001	Sciences et Technologies	Infirmier	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.26883+03	2026-06-07 18:01:13.574+03	\N	["Licence"]
267	190	Infirmier	INSPNMAD-MAE-INF-001	Sciences et Technologies	Infirmier	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.378744+03	2026-06-07 18:01:13.599+03	\N	["Licence"]
260	174	Infirmier	IFSISJA-INF-001	Sciences et Technologies	Infirmier	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.276134+03	2026-06-07 18:01:13.619+03	\N	["Licence"]
273	197	Infirmier	ISB-INF-001	Sciences et Technologies	Infirmier	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.394625+03	2026-06-07 18:01:13.638+03	\N	["Licence"]
269	193	Infirmier	INSPNMAD-TOL-INF-001	Sciences et Technologies	Infirmier	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.38581+03	2026-06-07 18:01:13.659+03	\N	["Licence"]
268	191	Infirmier	INSPNMAD-MHJ-INF-001	Sciences et Technologies	Infirmier	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.381102+03	2026-06-07 18:01:13.698+03	\N	["Licence"]
256	167	Infirmier	IFPAMA-INF-001	Sciences et Technologies	Infirmier	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.263539+03	2026-06-07 18:01:13.758+03	\N	["Licence"]
258	172	Infirmier	IFPANT-INF-001	Sciences et Technologies	Infirmier	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.272313+03	2026-06-07 18:01:13.823+03	\N	["Licence"]
261	177	Infirmier	IFSPANT-INF-001	Sciences et Technologies	Infirmier	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.280699+03	2026-06-07 18:01:13.857+03	\N	["Licence"]
277	208	Infirmier	ISISFA-ITAO-INF-001	Sciences et Technologies	Infirmier	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.421875+03	2026-06-07 18:01:13.894+03	\N	["Licence"]
239	150	Physique Chimie	UTOA-PHYSCHEM-001	Sciences et Technologies	Physique Chimie	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.22758+03	2026-06-07 18:01:16.11+03	\N	["Licence"]
274	200	Sage-femme	ISFP-TAJ-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.398201+03	2026-06-07 18:01:16.564+03	\N	["Licence"]
255	164	Sage-femme	IFISA2-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.260779+03	2026-06-07 18:01:16.7+03	\N	["Licence"]
252	161	Sage-femme	IFAS-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.255483+03	2026-06-07 18:01:16.718+03	\N	["Licence"]
244	152	Sage-femme	USVP-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.236646+03	2026-06-07 18:01:16.737+03	\N	["Licence"]
270	194	Sage-femme	IPBS-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.388126+03	2026-06-07 18:01:16.801+03	\N	["Licence"]
253	162	Sage-femme	IFIMA-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.257222+03	2026-06-07 18:01:16.825+03	\N	["Licence"]
249	157	Sage-femme	ESIF-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.247007+03	2026-06-07 18:01:16.888+03	\N	["Licence"]
248	156	Sage-femme	ESIJP2-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.245387+03	2026-06-07 18:01:16.964+03	\N	["Licence"]
246	154	Sage-femme	EFI-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.241594+03	2026-06-07 18:01:17.002+03	\N	["Licence"]
247	155	Sage-femme	ESFPB-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.243567+03	2026-06-07 18:01:17.047+03	\N	["Licence"]
275	201	Sage-femme	ISFPM-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.40974+03	2026-06-07 18:01:17.126+03	\N	["Licence"]
250	158	Sage-femme	ESISFA-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.24927+03	2026-06-07 18:01:17.202+03	\N	["Licence"]
241	151	Gestion	UTOL-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.229622+03	2026-06-07 18:19:25.413+03	\N	["Licence"]
237	150	Gestion	UTOA-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.2256+03	2026-06-07 18:20:41.013+03	\N	["Licence"]
238	150	Sciences de Gestion	UTOA-SCGEST-001	Sciences de Gestion	Sciences de Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.226607+03	2026-06-07 18:22:12.995+03	\N	["Master"]
232	149	Sciences de la vie, de la terre et de l'environnement	UMHJ-SCVTE-001	Sciences et Technologies	Sciences de la Vie	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.218919+03	2026-06-07 18:22:39.517+03	\N	["Licence"]
233	149	Sciences de la vie, de la terre et de l'environnement	UMHJ-SCVTE-002	Sciences et Technologies	Sciences de la Vie	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.220583+03	2026-06-07 18:22:41.56+03	\N	["Master"]
242	151	Sciences Marines et Halieutiques	UTOL-SCMH-001	Sciences et Technologies	Sciences Marines	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.230545+03	2026-06-07 18:23:36.74+03	\N	["Licence"]
243	151	Sciences Marines et Halieutiques	UTOL-SCMH-002	Sciences et Technologies	Sciences Marines	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.232489+03	2026-06-07 18:23:38.775+03	\N	["Master"]
245	153	Soins de Santé	AHU-SOINS-001	Sciences et Technologies	Santé	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.238979+03	2026-06-07 18:23:59.188+03	\N	["Licence"]
262	181	Technicien de Laboratoire	IFSTM-TECH-001	Sciences et Technologies	Laboratoire	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.287926+03	2026-06-07 18:24:07.401+03	\N	["Licence"]
279	211	Technicien de Laboratoire	ISPMD-TECH-001	Sciences et Technologies	Laboratoire	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.4274+03	2026-06-07 18:24:09.446+03	\N	["Licence"]
276	205	Technicien de Laboratoire	ISISFA-TECH-001	Sciences et Technologies	Laboratoire	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.417419+03	2026-06-07 18:24:11.495+03	\N	["Licence"]
272	197	Technicien de Laboratoire	ISB-TECH-001	Sciences et Technologies	Laboratoire	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.393388+03	2026-06-07 18:24:13.547+03	\N	["Licence"]
251	161	Technicien de Laboratoire	IFAS-TECH-001	Sciences et Technologies	Laboratoire	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.254054+03	2026-06-07 18:24:15.59+03	\N	["Licence"]
266	188	Urgences et Catastrophes	INSPNMAD-URG-001	Sciences et Technologies	Urgences	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.348044+03	2026-06-07 18:25:16.778+03	\N	["Licence"]
303	239	Environnement	ED-VRNR-001	Agriculture et Environnement	Ressources Naturelles	Doctorat	3 - 5	\N	Français	["D","S","Technique"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.480763+03	2026-06-07 18:18:50.648+03	\N	["Doctorat"]
310	246	Valorisation des Ressources Naturelles Renouvelables	ED-CADDETHIQUE-001	Agriculture et Environnement	Environnement	Doctorat	3 - 5	\N	Français	["C","D","S"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.50296+03	2026-06-09 06:53:05.727+03	\N	["Doctorat"]
312	248	Gestion des Ressources Naturelles et Développement	ED-DROITSP-001	Environnement, Développement Durable et Ressources Naturelles	Droit	Doctorat	3 - 5	\N	Français	["D","S"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.506707+03	2026-06-07 18:21:01.485+03	\N	["Doctorat"]
316	252	Informatique et Technologies	ED-LHIC-001	Informatique, Numérique et Technologies	Langues	Doctorat	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.513717+03	2026-06-07 18:21:17.832+03	\N	["Doctorat"]
305	241	Ingénierie et Géosciences	ED-GRND-001	Sciences de l'Ingénieur et Géosciences	Gestion Environnement	Doctorat	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.49135+03	2026-06-07 18:21:19.861+03	\N	["Doctorat"]
309	245	Mathématiques Appliquées	ED-INFTECH-001	Mathématiques et Informatique Théorique	Informatique	Doctorat	3 - 5	\N	Français	["C","D","S"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.499199+03	2026-06-07 18:21:48.495+03	\N	["Doctorat"]
301	237	Physique et Applications	ED-PA-001	Sciences et Technologies	Physique	Doctorat	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.477625+03	2026-06-07 18:01:16.227+03	\N	["Doctorat"]
308	244	Physique et Applications	ED-ENRE-001	Physique et Sciences de l'Ingénieur	Environnement	Doctorat	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.496918+03	2026-06-07 18:21:52.578+03	\N	["Doctorat"]
304	240	Ressources Agricoles et Alimentaires	ED-SVS-001	Sciences Agronomiques et Agroalimentaires	Sciences de la Santé	Doctorat	3 - 5	\N	Français	["D","S","Technique"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.484421+03	2026-06-07 18:21:56.669+03	\N	["Doctorat"]
300	236	Sciences de la Vie et Environnement	ED-SVE-001	Sciences et Technologies	Sciences Biologiques	Doctorat	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.476175+03	2026-06-07 18:22:45.649+03	\N	["Doctorat"]
455	420	Sciences Militaires et Commandement	\N	Défense et Sécurité	\N	Licence	3	\N	Français	["C","D","S","A2"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-03 17:50:47.66+03	2026-06-07 18:23:40.816+03	Formation prise en charge par l'État (pour les admis)	["Licence"]
321	257	Sciences Marines et Halieutiques	ED-SCI-001	Sciences Marines, Halieutiques et Environnementales	Sciences Politiques	Doctorat	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.524534+03	2026-06-07 18:23:34.701+03	\N	["Doctorat"]
296	232	Environnement	ED-ENV-001	Sciences et Technologies	Environnement	Doctorat	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.468465+03	2026-06-07 18:01:11.377+03	\N	["Doctorat"]
315	251	Environnement et Ressources Naturelles	ED-BET-001	Sciences et Technologies	Biotechnologies	Doctorat	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.512228+03	2026-06-07 18:01:11.656+03	\N	["Doctorat"]
289	223	Infirmier	PARAMA-AMBO-INF-001	Sciences et Technologies	Infirmier	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.452333+03	2026-06-07 18:01:13.788+03	\N	["Licence"]
288	222	Infirmier	PARAMA-IF-INF-001	Sciences et Technologies	Infirmier	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.449015+03	2026-06-07 18:01:13.928+03	\N	["Licence"]
298	234	Ingenierie	ED-INGE-001	Sciences et Technologies	Ingénierie	Doctorat	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.473221+03	2026-06-07 18:01:15.458+03	\N	["Doctorat"]
295	231	Pluridisciplinarite des Disciplines	ED-PED-001	Sciences et Technologies	Recherche	Doctorat	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.464886+03	2026-06-07 18:01:16.309+03	\N	["Doctorat"]
297	233	Ressources Agricoles et Alimentaires	ED-GPSIAA-001	Sciences et Technologies	Agronomie	Doctorat	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.470507+03	2026-06-07 18:01:16.484+03	\N	["Doctorat"]
291	226	Sage-femme	UAZ-PARAM-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.457284+03	2026-06-07 18:01:16.505+03	\N	["Licence"]
280	213	Sage-femme	ISPMD-AMB-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.430164+03	2026-06-07 18:01:16.524+03	\N	["Licence"]
282	217	Sage-femme	ISPRD-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.437431+03	2026-06-07 18:01:16.546+03	\N	["Licence"]
284	220	Sage-femme	ISSFP-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.443057+03	2026-06-07 18:01:16.583+03	\N	["Licence"]
293	229	Sage-femme	UPRIM-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.461303+03	2026-06-07 18:01:16.603+03	\N	["Licence"]
281	216	Sage-femme	ISPRAITRA-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.435121+03	2026-06-07 18:01:16.641+03	\N	["Licence"]
283	219	Sage-femme	ISPS-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.441246+03	2026-06-07 18:01:16.777+03	\N	["Licence"]
286	221	Sage-femme	ISSSD-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.445955+03	2026-06-07 18:01:16.852+03	\N	["Licence"]
294	230	Sage-femme	URM-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.462866+03	2026-06-07 18:01:17.085+03	\N	["Licence"]
290	224	Sage-femme	SEFAM-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.454455+03	2026-06-07 18:01:17.165+03	\N	["Licence"]
311	247	Sciences de la Vie et de la Santé	ED-GENESIS-001	Santé et Paramédical	Génétique	Doctorat	3 - 5	\N	Français	["C","D","S"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.504872+03	2026-06-09 06:42:14.604+03	\N	["Doctorat"]
320	256	Géochimie et Chimie Médicinale	ED-SCIENCES-001	Chimie, Géosciences et Sciences Pharmaceutiques	Recherche	Doctorat	3 - 5	\N	Français	["C","D","S"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.523047+03	2026-06-07 18:18:58.8+03	\N	["Doctorat"]
299	235	Sciences et Techniques Information Communication	ED-STICOM-001	Sciences et Technologies	Informatique	Doctorat	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.474792+03	2026-06-07 18:23:10.154+03	\N	["Doctorat"]
285	221	Technicien de Laboratoire	ISSSD-TECH-001	Sciences et Technologies	Laboratoire	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.445032+03	2026-06-07 18:24:05.34+03	\N	["Licence"]
287	221	Technicien de Radiologie	ISSSD-RADIO-001	Sciences et Technologies	Radiologie	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.446766+03	2026-06-07 18:24:17.635+03	\N	["Licence"]
307	243	Sciences de la Vie et de l'Environnement	ED-ACF-001	Agriculture et Environnement	Finance	Doctorat	\N	\N	Français	["C","D","S"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.495284+03	2026-06-09 06:37:24.836+03	\N	["Doctorat"]
8	2	Informatique	ASJA-INFO-002	Sciences et Technologies	Informatique	Master	5	\N	Français	\N	\N	\N	\N	difficile	\N	\N	\N	\N	f	2026-06-02 18:55:40.911256+03	2026-06-03 20:29:11.754+03	Non publié	["Master"]
432	292	Sciences Politiques et Gouvernance	IEP-ED-SCI-001	Droit et Sciences Politiques	Sciences Politiques	Doctorat	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.115818+03	2026-06-07 18:23:53.067+03	\N	["Doctorat"]
442	268	Sciences Infirmières	CNTEMAD-MAH-INFO-001	Santé	Informatique	Licence	3	\N	Français	["C","D","S"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:56:19.128722+03	2026-06-07 18:23:24.507+03	\N	["Licence"]
423	286	Droit	OUP-DROIT-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.099001+03	2026-06-07 18:01:10.574+03	\N	["Licence"]
467	1	Management et Administration des Entreprises	\N	Sciences de Gestion	\N	Master	5	\N	Français	\N	\N	\N	\N	moyen	\N	\N	\N	\N	f	2026-06-03 19:21:01.028+03	2026-06-03 20:30:38.136+03	Non publié	["Master"]
437	295	Sciences	CRFUF-SCI-001	Sciences et Technologies	Sciences	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.121813+03	2026-06-07 18:01:17.457+03	\N	["Licence"]
409	271	Entrepreneuriat rural	UPA-ENTREPR-001	Sciences de Gestion	Entrepreneuriat	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.070753+03	2026-06-07 18:18:48.603+03	\N	["Licence"]
447	271	Finance	INSCAE-FIN-001	Sciences de Gestion	Finance	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.134631+03	2026-06-07 18:18:52.698+03	\N	["Master"]
419	282	Gestion	UIM-GEST-002	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.093777+03	2026-06-07 18:19:45.885+03	\N	["Master"]
466	2	Droit	\N	Droit et Sciences Politiques	\N	Master	5	\N	Français	\N	\N	\N	\N	difficile	\N	\N	\N	\N	f	2026-06-03 19:11:02.917+03	2026-06-03 19:52:06.969+03	Non publié	["Master"]
434	293	Droit	UCM-ED-DROIT-001	Droit et Sciences Politiques	Droit	Doctorat	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.118566+03	2026-06-07 18:01:09.987+03	\N	["Doctorat"]
430	290	Environnement	ISSM-ENV-001	Sciences et Technologies	Environnement	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.111914+03	2026-06-07 18:01:11.558+03	\N	["Licence"]
438	296	Informatique	CNTEMAD-ANT-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.12274+03	2026-06-07 18:01:14.738+03	\N	["Licence"]
428	290	Informatique	ISSM-INFO-001	Sciences et Technologies	Informatique	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.10709+03	2026-06-07 18:01:14.851+03	\N	["Licence"]
457	268	Maïeutique (Sage-femme)	\N	Santé et Paramédical	\N	Licence	3	\N	Français	["C","D","S"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 18:25:59.566+03	2026-06-07 18:01:15.59+03	\N	["Licence"]
424	287	Philosophie	PSP-PHILO-001	Arts, Lettres et Communication	Philosophie	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.100875+03	2026-06-07 18:01:15.874+03	\N	["Licence"]
461	269	Santé Publique	\N	Santé et Paramédical	\N	Licence	3	\N	Français	["C","D","S"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 18:43:06.795+03	2026-06-07 18:01:17.288+03	Non publié	["Licence"]
449	272	Santé Publique	INSPC-SANTE-001	Santé et Paramédical	Santé Publique	Master	\N	\N	Français	["C","D","S"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.136556+03	2026-06-07 18:01:17.328+03	\N	["Master"]
435	293	Gestion	UCM-ED-GEST-001	Sciences de Gestion	Gestion	Doctorat	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.119606+03	2026-06-07 18:19:49.965+03	\N	["Doctorat"]
440	267	Gestion	CNTEMAD-FIA-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.124542+03	2026-06-07 18:19:56.088+03	\N	["Licence"]
446	271	Gestion	INSCAE-GEST-002	Sciences de Gestion	Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.133717+03	2026-06-07 18:20:18.526+03	\N	["Master"]
445	271	Gestion	INSCAE-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.132504+03	2026-06-07 18:20:53.308+03	\N	["Licence"]
443	269	Maïeutique	CNTEMAD-TOL-GEST-001	Santé maternelle	Gestion	Licence	3	\N	Français	["C","D","S"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:56:19.130324+03	2026-06-07 18:21:23.945+03	Non publié	["Licence"]
448	271	Marketing, Entrepreneuriat	INSCAE-MARK-001	Sciences de Gestion	Marketing	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.135566+03	2026-06-07 18:21:44.409+03	\N	["Master"]
408	270	Sage-femme	MBS-COMM-001	Santé Maternelle et Infantile	Communication	Master	3	\N	Français	["C","D","S"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:56:19.066713+03	2026-06-07 18:21:58.721+03	\N	["Licence"]
459	268	Santé Publique	\N	Santé publique	\N	Licence	3	\N	Français	["C","D","S"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 18:30:10.096+03	2026-06-07 18:22:00.766+03	\N	["Licence"]
417	279	Sciences de la Gestion	JAU-SCGEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.091191+03	2026-06-07 18:22:21.137+03	\N	["Licence"]
444	270	Sciences Infirmières	ENSP-POL-001	Santé et Paramédical	Police	Licence	3	\N	Français	["C","D","S"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:56:19.131381+03	2026-06-07 18:23:26.542+03	\N	["Licence"]
404	269	Sciences Infirmières	ASCOM-GEST-001	Santé	Gestion	Licence	3	\N	Français	["C","D","S"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:56:19.055717+03	2026-06-07 18:23:28.579+03	Non publié	["Licence"]
458	268	Technologie Biomédicale	\N	Ingénierie biomédicale	\N	Licence	3	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 18:27:59.075+03	2026-06-07 18:24:36.005+03	\N	["Licence"]
460	269	Technologie Biomédicale	\N	Biomédical	\N	Licence	3	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 18:40:44.258+03	2026-06-07 18:24:38.044+03	Non publié	["Licence"]
410	275	Tourisme Durable	UTAM-TOUR-001	Arts, Lettres et Communication	Tourisme	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.073697+03	2026-06-07 18:25:02.475+03	\N	["Licence"]
478	410	Sciences Sociales de Développement Rural et Communautaire	\N	Sciences de la Société	\N	\N	3	\N	Français	["A1","A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 21:10:54.236+03	2026-06-07 18:23:55.104+03	\N	["Licence"]
322	258	Biodiversité et Environnements Tropicaux	ED-TOAM-DROITSP-001	Sciences de la Vie et de l’Environnement	Droit	Doctorat	3 - 5	\N	Français	\N	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.525896+03	2026-06-04 16:56:26.862+03	\N	["Doctorat"]
482	5	Machinisme Agricole	\N	Agriculture et Génie Rural	\N	\N	3	\N	Français	["D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 21:21:56.764+03	2026-06-07 18:21:21.901+03	\N	["Licence"]
9	2	Droit	ASJA-DROIT-001	Droit et Sciences Politiques	Droit	Licence	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-02 18:55:40.912139+03	2026-06-07 18:01:10.164+03	\N	["Licence","Master"]
492	412	Informatique	\N	Sciences et Technologies	\N	\N	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 22:10:56.636+03	2026-06-07 18:01:14.7+03	\N	["Licence","Master"]
493	412	Télécommunications	\N	Sciences et Technologies	\N	\N	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 22:12:23.316+03	2026-06-07 18:24:44.138+03	\N	["Licence","Master"]
515	276	Santé Spécialisée	\N	Santé et Paramédical	\N	\N	2	\N	Français	["C","D","S"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-04 16:46:39.011+03	2026-06-07 18:01:17.411+03	\N	["Master"]
480	410	Tourisme	\N	Sciences et Technologies	\N	\N	3	\N	Français	["C","D","S","Technique"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 21:14:51.334+03	2026-06-07 18:24:54.323+03	\N	["Licence"]
462	2	Agroalimentaire	\N	Industrie Alimentaire	\N	Licence	3 -5	\N	Français	["D","S","Technique"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 19:00:36.472+03	2026-06-07 18:18:09.689+03	Non publié	["Licence","Master"]
494	412	Communication	\N	Arts, Lettres et Communication	\N	\N	3 - 5	\N	Français	["A1","A2"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 22:14:08.791+03	2026-06-07 18:01:09.761+03	\N	["Licence","Master"]
485	411	Droit	\N	Droit et Sciences Politiques	\N	\N	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 21:51:19.23+03	2026-06-07 18:01:10.281+03	\N	["Licence","Master"]
500	413	Communication	\N	Arts, Lettres et Communication	\N	\N	3 -  5	\N	Français	["A1","A2"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-04 15:59:59.867+03	2026-06-07 18:01:09.859+03	\N	["Licence","Master"]
491	412	Droit	\N	Droit et Sciences Politiques	\N	\N	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 22:08:59.851+03	2026-06-07 18:01:10.494+03	\N	["Licence","Master"]
481	410	Environnement et Technologies Écologiques	\N	Sciences et Technologies	\N	\N	5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 21:17:11.003+03	2026-06-07 18:01:11.705+03	\N	["Master"]
510	8	Droit et Techniques des Affaires	\N	Droit et Sciences Politiques	\N	\N	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-04 16:23:15.576+03	2026-06-07 18:01:11.183+03	\N	["Licence","Master"]
497	413	Droit	\N	Droit et Sciences Politiques	\N	\N	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-04 15:53:39.561+03	2026-06-07 18:01:10.319+03	\N	["Licence","Master"]
477	4	Gestion de l'Environnement au Service du Développement	\N	Sciences et Technologies	\N	\N	3	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 21:05:46.921+03	2026-06-07 18:01:13.179+03	\N	["Licence"]
479	410	Agronomie – Technologie – Environnement	\N	Sciences et Technologies	\N	\N	3	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 21:13:01.777+03	2026-06-07 18:01:09.019+03	\N	["Licence"]
506	414	Communication	\N	Arts, Lettres et Communication	\N	\N	3 - 5	\N	Français	["A1","A2"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-04 16:10:47.019+03	2026-06-07 18:01:09.522+03	\N	["Licence","Master"]
488	411	Communication	\N	Arts, Lettres et Communication	\N	\N	3 - 5	\N	Français	["A1","A2"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 21:57:43.66+03	2026-06-07 18:01:09.723+03	\N	["Licence","Master"]
503	414	Droit	\N	Droit et Sciences Politiques	\N	\N	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-04 16:05:25.854+03	2026-06-07 18:01:10.103+03	\N	["Licence","Master"]
11	3	Informatique	CEIST-INFO-001	Sciences et Technologies	Informatique	Licence	3	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:55:40.913592+03	2026-06-07 18:01:14.071+03	\N	["Licence"]
486	411	Informatique	\N	Sciences et Technologies	\N	\N	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 21:53:42.607+03	2026-06-07 18:01:14.138+03	\N	["Licence","Master"]
511	8	Informatique	\N	Sciences et Technologies	\N	\N	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-04 16:25:26.041+03	2026-06-07 18:01:14.718+03	\N	["Licence","Master"]
474	382	Droit	\N	Sciences de la Société	\N	\N	3	\N	Français	["A1","A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 20:50:22.889+03	2026-06-07 18:18:36.284+03	\N	["Licence"]
465	2	Économie et Commerce	\N	Sciences de Gestion	\N	Master	3 - 5	\N	Français	["A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 19:07:51.023+03	2026-06-07 18:18:40.373+03	Non publié	["Master","Licence"]
473	382	Économie – Gestion	\N	Sciences de la Société	\N	\N	3	\N	Français	["A1","A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 20:48:17.47+03	2026-06-07 18:18:42.418+03	\N	["Licence"]
512	7	Gestion	\N	Sciences de la Société	\N	\N	3	\N	Français	["A1","A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-04 16:30:57.137+03	2026-06-07 18:19:00.853+03	\N	["Licence"]
502	414	Gestion	\N	Sciences de la Société	\N	\N	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-04 16:03:49.685+03	2026-06-07 18:19:02.894+03	\N	["Licence","Master"]
484	411	Gestion	\N	Sciences de la Société	\N	\N	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 21:49:30.488+03	2026-06-07 18:19:04.933+03	\N	["Licence","Master"]
490	412	Gestion	\N	Sciences de la Société	\N	\N	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 22:07:31.05+03	2026-06-07 18:19:06.976+03	\N	["Licence","Master"]
496	413	Gestion	\N	Sciences de la Société	\N	\N	3 -  5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-04 15:50:02+03	2026-06-07 18:19:09.026+03	Inclus dans les frais annuels CNTEMAD	["Licence","Master"]
471	383	Gestion des Ressources Humaines	\N	Sciences de la Société	\N	\N	3	\N	Français	["A1","A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 20:41:07.623+03	2026-06-07 18:20:57.397+03	\N	["Licence"]
472	383	Gestion des Ressources Humaines Avancée	\N	Sciences de la Société	\N	\N	5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 20:43:50.799+03	2026-06-07 18:20:59.442+03	\N	["Master"]
476	3	Management des Systèmes d'Information	\N	Informatique de Gestion	\N	\N	\N	\N	Français	["C","D","Technique"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 20:58:41.588+03	2026-06-07 18:21:34.159+03	\N	["Licence"]
514	276	Management et Administration de la Santé	\N	Gestion de la Santé	\N	\N	2	\N	Français	["A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-04 16:44:36.418+03	2026-06-07 18:21:38.253+03	\N	["Master"]
483	5	Mécanisation Agricole Avancée	\N	Génie Agricole	\N	\N	2	\N	Français	["D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 21:25:04.887+03	2026-06-07 18:21:50.537+03	\N	["Master"]
487	411	Télécommunications	\N	Sciences et Technologies	\N	\N	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 21:55:52.87+03	2026-06-07 18:24:40.075+03	\N	["Licence","Master"]
509	8	Transit et Douane	\N	Logistique et Commerce International	\N	\N	2 - 3	\N	Français	["A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-04 16:21:07.512+03	2026-06-07 18:25:10.655+03	\N	["DTS","Licence"]
302	238	Pluridisciplinarité des Disciplines	ED-MA-001	Sciences Humaines, Sociales et Interdisciplinaires	Mathématiques	Doctorat	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.479204+03	2026-06-07 18:21:54.623+03	\N	["Doctorat"]
7	2	Informatique	ASJA-INFO-001	Sciences et Technologies	Informatique	Licence	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:55:40.910515+03	2026-06-07 18:01:14.239+03	Non publié	["Licence","Master"]
507	414	Commerce et Management des Affaires	\N	Sciences de Gestion	\N	\N	3 - 5	\N	Français	["A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-04 16:12:28.385+03	2026-06-07 18:18:28.086+03	\N	["Licence","Master"]
92	50	Arts et Lettres	IISS-ARTLETT-001	Arts, Lettres et Communication	Arts et Lettres	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.006886+03	2026-06-07 18:01:09.04+03	\N	["Licence"]
93	50	Arts et Lettres	IISS-ARTLETT-002	Arts, Lettres et Communication	Arts et Lettres	Master	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.008004+03	2026-06-07 18:01:09.06+03	\N	["Master"]
180	129	Communication	UADV-COMM-002	Arts, Lettres et Communication	Communication	Master	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.127462+03	2026-06-07 18:01:09.629+03	\N	["Master"]
179	129	Communication	UADV-COMM-001	Arts, Lettres et Communication	Communication	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.126301+03	2026-06-07 18:01:09.682+03	\N	["Licence"]
118	73	Communication	ISETES-COMM-001	Arts, Lettres et Communication	Communication	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.040348+03	2026-06-07 18:01:09.893+03	\N	["Licence"]
112	66	Communication et Journalisme	IAEAC-COMMJ-001	Arts, Lettres et Communication	Communication	Master	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.03063+03	2026-06-07 18:01:09.946+03	\N	["Master"]
319	255	Droit et Sciences Politiques	ED-STPFJKM-001	Droit et Sciences Politiques	Philosophie	Doctorat	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.521087+03	2026-06-07 18:01:10.934+03	\N	["Doctorat"]
98	54	Hotel and Tourism Management	IMT-HOTM-002	Arts, Lettres et Communication	Tourisme	Master	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.013178+03	2026-06-07 18:01:13.47+03	\N	["Master"]
97	54	Hotel and Tourism Management	IMT-HOTM-001	Arts, Lettres et Communication	Tourisme	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.012228+03	2026-06-07 18:01:13.516+03	\N	["Licence"]
83	44	Information-Communication-Journalisme	IFT-INFCOM-001	Arts, Lettres et Communication	Communication	Master	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.994022+03	2026-06-07 18:01:13.968+03	\N	["Master"]
13	6	Informatique	CNAM-SIND-001	Sciences et Technologies	Sciences Industrielles	Master	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-02 18:55:40.916222+03	2026-06-07 18:01:14.001+03	\N	["Licence","Master"]
504	414	Informatique	\N	Sciences et Technologies	\N	\N	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-04 16:07:32.408+03	2026-06-07 18:01:14.914+03	\N	["Licence","Master"]
498	413	Informatique	\N	Sciences et Technologies	\N	\N	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-04 15:55:40.239+03	2026-06-07 18:01:15.046+03	\N	["Licence","Master"]
63	30	Ingenierie et Management des Actions de Developpement	EUIOI-INGM-002	Arts, Lettres et Communication	Management	Master	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.971508+03	2026-06-07 18:01:15.525+03	\N	["Master"]
181	130	Philosophie	UCM-PHILO-001	Arts, Lettres et Communication	Philosophie	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.129879+03	2026-06-07 18:01:15.916+03	\N	["Licence"]
182	130	Philosophie	UCM-PHILO-002	Arts, Lettres et Communication	Philosophie	Master	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.132886+03	2026-06-07 18:01:15.952+03	\N	["Master"]
475	3	Réseaux et Télécommunications	\N	Sciences et Technologies	\N	\N	3	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-03 20:56:48.77+03	2026-06-07 18:01:16.424+03	\N	["Licence"]
522	263	Sciences	\N	Sciences et Technologies	\N	\N	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-06 13:22:54.327+03	2026-06-07 18:01:17.494+03	\N	["Doctorat"]
495	412	Commerce et Management des Affaires	\N	Sciences de Gestion	\N	\N	3 - 5	\N	Français	["A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 22:15:40.87+03	2026-06-07 18:18:30.141+03	\N	["Licence","Master"]
489	411	Commerce et Management des Affaires	\N	Sciences de Gestion	\N	\N	3 - 5	\N	Français	["A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-03 21:59:12.398+03	2026-06-07 18:18:32.189+03	\N	["Licence","Master"]
516	6	Comptabilité et Finance	\N	Comptabilité et Finance	\N	\N	3 - 5	\N	Français	["A2","C","D"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-05 11:46:08.866+03	2026-06-07 18:18:34.231+03	\N	["Licence","Master"]
519	6	Énergie, Environnement et Développement Durable	\N	Agriculture et Environnement	\N	\N	3 - 5	\N	Français	["D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-05 11:52:07.211+03	2026-06-07 18:18:44.483+03	\N	["Licence","Ingénieur"]
517	6	Management et Administration	\N	Sciences de Gestion	\N	\N	3 - 5	\N	Français	["A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-05 11:48:36.986+03	2026-06-07 18:21:36.204+03	\N	["Licence","Master"]
3	2	Sciences Agronomiques	ASJA-AGRO-001	Agriculture et Environnement	Sciences Agronomiques	Licence	3 - 5	\N	Français	["D","S","Technique"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-02 18:55:40.906327+03	2026-06-07 18:22:02.814+03	Non publié	["Licence","Master"]
163	118	Sciences de la Communication	ONIFRA-SCCOM-001	Arts, Lettres et Communication	Communication	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.104675+03	2026-06-07 18:22:17.075+03	\N	["Licence"]
138	89	Sciences de l'Education	ISPA-SCEDUC-001	Sciences Humaines et Sociales	Sciences de l'Education	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.073933+03	2026-06-07 18:22:47.691+03	\N	["Licence"]
170	124	Sciences de l'Information et Communication	SAMIS-SCINFCOM-001	Arts, Lettres et Communication	Communication	Master	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.113483+03	2026-06-07 18:22:57.904+03	\N	["Master"]
520	261	Sciences Humaines, Sociales, Juridiques et Politiques	\N	Sciences Humaines, Sociales, Juridiques et Politiques	\N	\N	3  - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-06 13:06:36.238+03	2026-06-07 18:23:22.464+03	\N	["Doctorat"]
521	262	Sciences Théologiques et Philosophiques	\N	Théologie, Philosophie et Sciences Religieuses	\N	\N	3 - 5	\N	Français	["A1","A2"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-06 13:19:26.023+03	2026-06-07 18:23:57.144+03	\N	["Doctorat"]
142	91	Technique du Tourisme	ISPM-TECHTOUR-002	Arts, Lettres et Communication	Tourisme	Master	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.078007+03	2026-06-07 18:24:21.729+03	\N	["Master"]
499	413	Télécommunications	\N	Sciences et Technologies	\N	\N	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-04 15:57:09.087+03	2026-06-07 18:24:42.105+03	\N	["Licence","Master"]
505	414	Télécommunications	\N	Sciences et Technologies	\N	\N	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	difficile	\N	\N	\N	\N	t	2026-06-04 16:08:54.988+03	2026-06-07 18:24:46.161+03	\N	["Licence","Master"]
131	83	Tourisme	IUPM-TOUR-001	Arts, Lettres et Communication	Tourisme	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.063318+03	2026-06-07 18:24:50.237+03	\N	["Licence"]
165	118	Tourisme	ONIFRA-TOUR-001	Arts, Lettres et Communication	Tourisme	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.107671+03	2026-06-07 18:24:58.415+03	\N	["Licence"]
152	99	Tourisme, Environnement	ISSMI-TOUR-001	Arts, Lettres et Communication	Tourisme	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.091288+03	2026-06-07 18:25:04.516+03	\N	["Licence"]
436	294	Bible et Histoire Interculturelle	ONIFRA-ED-BIB-001	Arts, Lettres et Communication	Théologie	Doctorat	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.120654+03	2026-06-07 18:01:09.118+03	\N	["Doctorat"]
199	141	Communication	UPM-COMM-001	Arts, Lettres et Communication	Communication	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.163302+03	2026-06-07 18:01:09.554+03	\N	["Licence"]
441	267	Communication	CNTEMAD-FIA-COMM-001	Arts, Lettres et Communication	Communication	Master	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.125639+03	2026-06-07 18:01:09.589+03	\N	["Master"]
191	136	Communication	UPAS-COMM-001	Arts, Lettres et Communication	Communication	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.152286+03	2026-06-07 18:01:09.819+03	\N	["Licence"]
240	151	Droit	UTOL-DROIT-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.228535+03	2026-06-07 18:01:10.197+03	\N	["Licence"]
235	150	Droit et Sciences Politiques	UTOA-DROITSP-001	Droit et Sciences Politiques	Droit	Licence	\N	\N	Français	["A1","A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.223441+03	2026-06-07 18:01:10.973+03	\N	["Licence"]
52	25	Environnement	ESTIIM-ENV-002	Sciences et Technologies	Environnement	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.957488+03	2026-06-07 18:01:11.423+03	\N	["Master"]
263	184	Infirmier	INSPALM-INF-001	Sciences et Technologies	Infirmier	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.29327+03	2026-06-07 18:01:13.726+03	\N	["Licence"]
323	259	Langages, Histoires, Interactions et Critiques	ED-MAHAJ-3SH-001	Sciences Humaines et Sociales	Sciences Sociales	Doctorat	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.527386+03	2026-06-07 18:01:15.551+03	\N	["Doctorat"]
431	291	Philosophie	ISSSPTA-PHILO-001	Arts, Lettres et Communication	Philosophie	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.114278+03	2026-06-07 18:01:15.833+03	\N	["Licence"]
433	293	Philosophie	UCM-ED-PHILO-001	Arts, Lettres et Communication	Philosophie	Doctorat	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.117318+03	2026-06-07 18:01:15.99+03	\N	["Doctorat"]
194	137	Philosophie	UP-PHILO-001	Arts, Lettres et Communication	Philosophie	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.156755+03	2026-06-07 18:01:16.029+03	\N	["Licence"]
183	130	Psychologie	UCM-PSYCH-001	Arts, Lettres et Communication	Psychologie	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.137084+03	2026-06-07 18:01:16.351+03	\N	["Licence"]
254	163	Sage-femme	IFISA-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.259029+03	2026-06-07 18:01:16.679+03	\N	["Licence"]
292	228	Sage-femme	UPAHPI-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.459705+03	2026-06-07 18:01:16.756+03	\N	["Licence"]
271	196	Sage-femme	ISAPSP-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.391295+03	2026-06-07 18:01:16.923+03	\N	["Licence"]
259	173	Sage-femme	IFPT-SF-001	Sciences et Technologies	Sage-femme	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.27408+03	2026-06-07 18:01:17.247+03	\N	["Licence"]
57	27	Administration, Gestion, Finances, Informatique de Gestion	ETEC-ADMG-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.962582+03	2026-06-07 18:17:59.444+03	\N	["Licence"]
501	413	Commerce et Management des Affaires	\N	Sciences de Gestion	\N	\N	3 - 5	\N	Français	["A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-04 16:01:36.771+03	2026-06-07 18:18:26.035+03	\N	["Licence","Master"]
317	253	Dynamique des Cadres de Vie	ED-SPM-001	Géographie, Aménagement et Environnement	Sciences Politiques	Doctorat	3 - 5	\N	Français	["D","C"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.516321+03	2026-06-07 18:18:38.332+03	\N	["Doctorat"]
33	18	Gestion	ESPBIG-GEST-001	Sciences de Gestion	Gestion	Licence	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.937965+03	2026-06-07 18:19:27.45+03	\N	["Licence"]
318	254	Glocalisme, Environnement et Sécurité des Sociétés Indienocéaniques	ED-EDHSJP-001	Sciences Sociales, Environnement et Gouvernance	Sciences Sociales	Doctorat	3 - 5	\N	Français	["A1","A2","C","D"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.519333+03	2026-06-07 18:21:15.807+03	\N	["Doctorat"]
2	1	Management et Administration des Entreprises	BS-GEST-001	Sciences de Gestion	Gestion	Licence	3 - 5	\N	Français	["A2","C","D"]	\N	\N	\N	moyen	\N	\N	\N	\N	t	2026-06-02 18:55:40.90512+03	2026-06-07 18:21:40.297+03	Non publié	["Licence","Master"]
205	145	Sciences de Gestion	MBS-SCGEST-001	Sciences de Gestion	Sciences de Gestion	Master	\N	\N	Français	["A2","C","D"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.1736+03	2026-06-07 18:22:06.883+03	\N	["Master"]
206	145	Sciences de la Communication	MBS-SCCOM-001	Arts, Lettres et Communication	Communication	Master	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.174614+03	2026-06-07 18:22:19.113+03	\N	["Master"]
87	47	Sciences de l'Environnement	IFTMJ-SCENV-001	Sciences et Technologies	Environnement	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.997571+03	2026-06-07 18:22:53.81+03	\N	["Licence"]
426	288	Sciences de l'Information et Communication	SAMIS-SIC-002	Arts, Lettres et Communication	Communication	Master	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.104202+03	2026-06-07 18:22:55.862+03	\N	["Master"]
425	288	Sciences de l'Information et Communication	SAMIS-SIC-001	Arts, Lettres et Communication	Communication	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.102525+03	2026-06-07 18:22:59.949+03	\N	["Licence"]
221	147	Sciences du Vivant et de la Terre	UATSN-SCVT-002	Sciences et Technologies	Sciences de la Vie et Terre	Master	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.195077+03	2026-06-07 18:23:06.065+03	\N	["Master"]
306	242	Sciences et Technologies de l'Information et de la Communication	ED-SHS-001	Informatique, Télécommunications et Technologies Numériques	Sciences Sociales	Doctorat	3 - 5	\N	Français	["C","D","S","Technique"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-02 18:55:41.493474+03	2026-06-07 18:23:18.38+03	\N	["Doctorat"]
265	188	Technicien de laboratoire	INSPNMAD-TECH-001	Sciences et Technologies	Laboratoire	Licence	\N	\N	Français	["C","D","S","Technique"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.346494+03	2026-06-07 18:24:03.268+03	\N	["Licence"]
427	289	Théologie	SALTY-THEO-001	Arts, Lettres et Communication	Théologie	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.105641+03	2026-06-07 18:24:48.192+03	\N	["Licence"]
429	290	Tourisme	ISSM-TOUR-001	Arts, Lettres et Communication	Tourisme	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:19.108646+03	2026-06-07 18:24:52.282+03	\N	["Licence"]
200	143	Tourisme Durable	UTMAD-TOURDUR-001	Arts, Lettres et Communication	Tourisme	Licence	\N	\N	Français	["A1","A2"]	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.16487+03	2026-06-07 18:25:00.447+03	\N	["Licence"]
523	265	Recherche Doctorale Multidisciplinaire	\N	Sciences Humaines et Sociales	\N	\N	3 - 5	\N	Français	["Toutes séries"]	\N	\N	\N	tres_difficile	\N	\N	\N	\N	t	2026-06-09 06:47:15.738+03	2026-06-09 06:47:15.738+03	\N	[]
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, user_id, type, title, message, data, read, read_at, created_at, updated_at) FROM stdin;
56	36	info	📋 Recommandations disponibles	96 filière(s) vous ont été recommandée(s) basé sur vos réponses au test.	{"recommendation_count":96}	t	2026-06-03 12:50:36.604+03	2026-06-03 12:30:14.037+03	2026-06-03 12:50:36.604+03
57	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Sciences Militaires et Commandement à ACADEMIE MILITAIRE	{"field_name":"Sciences Militaires et Commandement","university_name":"ACADEMIE MILITAIRE"}	f	\N	2026-06-03 17:50:47.747+03	2026-06-03 17:50:47.747+03
58	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Formation Militaire des Cadres Spécialisés (PFMCS) à ACADEMIE MILITAIRE	{"field_name":"Formation Militaire des Cadres Spécialisés (PFMCS)","university_name":"ACADEMIE MILITAIRE"}	f	\N	2026-06-03 17:55:11.52+03	2026-06-03 17:55:11.52+03
62	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Technologie Biomédicale à AROVY HEALTHCARE UNIVERSITY MAHAJANGA	{"field_name":"Technologie Biomédicale","university_name":"AROVY HEALTHCARE UNIVERSITY MAHAJANGA"}	f	\N	2026-06-03 18:40:44.278+03	2026-06-03 18:40:44.278+03
63	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Santé Publique à AROVY HEALTHCARE UNIVERSITY MAHAJANGA	{"field_name":"Santé Publique","university_name":"AROVY HEALTHCARE UNIVERSITY MAHAJANGA"}	f	\N	2026-06-03 18:43:06.838+03	2026-06-03 18:43:06.838+03
69	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Management et Administration des Entreprises à ESCM BUSINESS SCHOOL	{"field_name":"Management et Administration des Entreprises","university_name":"ESCM BUSINESS SCHOOL"}	f	\N	2026-06-03 19:21:01.062+03	2026-06-03 19:21:01.062+03
70	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Marketing et Vente à ESCM BUSINESS SCHOOL	{"field_name":"Marketing et Vente","university_name":"ESCM BUSINESS SCHOOL"}	f	\N	2026-06-03 19:24:43.412+03	2026-06-03 19:24:43.412+03
71	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Business Development à ESCM BUSINESS SCHOOL	{"field_name":"Business Development","university_name":"ESCM BUSINESS SCHOOL"}	f	\N	2026-06-03 19:26:53.361+03	2026-06-03 19:26:53.361+03
72	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Business Development à ESCM BUSINESS SCHOOL	{"field_name":"Business Development","university_name":"ESCM BUSINESS SCHOOL"}	f	\N	2026-06-03 19:28:40.553+03	2026-06-03 19:28:40.553+03
75	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Économie – Gestion à CENTRE DE RESSOURCES, D'ASSISTANCE ET DE CONSEIL ETUDIANTS	{"field_name":"Économie – Gestion","university_name":"CENTRE DE RESSOURCES, D'ASSISTANCE ET DE CONSEIL ETUDIANTS"}	f	\N	2026-06-03 20:48:17.484+03	2026-06-03 20:48:17.484+03
76	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Droit à CENTRE DE RESSOURCES, D'ASSISTANCE ET DE CONSEIL ETUDIANTS	{"field_name":"Droit","university_name":"CENTRE DE RESSOURCES, D'ASSISTANCE ET DE CONSEIL ETUDIANTS"}	f	\N	2026-06-03 20:50:22.905+03	2026-06-03 20:50:22.905+03
79	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Gestion de l'Environnement au Service du Développement à CENTRE ECOLOGIQUE DE LIBANONA	{"field_name":"Gestion de l'Environnement au Service du Développement","university_name":"CENTRE ECOLOGIQUE DE LIBANONA"}	f	\N	2026-06-03 21:05:46.937+03	2026-06-03 21:05:46.937+03
84	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Machinisme Agricole à CFAMA - CENTRE DE FORMATION ET D'APPLICATION DU MACHINISME AGRICOLE	{"field_name":"Machinisme Agricole","university_name":"CFAMA - CENTRE DE FORMATION ET D'APPLICATION DU MACHINISME AGRICOLE"}	f	\N	2026-06-03 21:21:56.803+03	2026-06-03 21:21:56.803+03
85	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Mécanisation Agricole Avancée à CFAMA - CENTRE DE FORMATION ET D'APPLICATION DU MACHINISME AGRICOLE	{"field_name":"Mécanisation Agricole Avancée","university_name":"CFAMA - CENTRE DE FORMATION ET D'APPLICATION DU MACHINISME AGRICOLE"}	f	\N	2026-06-03 21:25:04.902+03	2026-06-03 21:25:04.902+03
90	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Communication à CNTEMAD ANTSIRANANA	{"field_name":"Communication","university_name":"CNTEMAD ANTSIRANANA"}	f	\N	2026-06-03 21:57:43.692+03	2026-06-03 21:57:43.692+03
91	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Commerce et Management des Affaires à CNTEMAD ANTSIRANANA	{"field_name":"Commerce et Management des Affaires","university_name":"CNTEMAD ANTSIRANANA"}	f	\N	2026-06-03 21:59:12.406+03	2026-06-03 21:59:12.406+03
97	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Commerce et Management des Affaires à CNTEMAD FIANARANTSOA	{"field_name":"Commerce et Management des Affaires","university_name":"CNTEMAD FIANARANTSOA"}	f	\N	2026-06-03 22:15:40.883+03	2026-06-03 22:15:40.883+03
98	36	success	🎉 Test complété !	Vous avez complété le test d'orientation. Votre score: 100%	{"test_session_id":21,"score":100}	f	\N	2026-06-04 13:30:08.345+03	2026-06-04 13:30:08.345+03
99	36	success	🎉 Test complété !	Vous avez complété le test d'orientation. Votre score: 100%	{"test_session_id":22,"score":100}	f	\N	2026-06-04 13:31:08.091+03	2026-06-04 13:31:08.091+03
100	36	info	📋 Recommandations disponibles	111 filière(s) vous ont été recommandée(s) basé sur vos réponses au test.	{"recommendation_count":111}	f	\N	2026-06-04 13:31:08.21+03	2026-06-04 13:31:08.21+03
101	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Gestion à CNTEMAD MAHAJANGA	{"field_name":"Gestion","university_name":"CNTEMAD MAHAJANGA"}	f	\N	2026-06-04 15:50:02.09+03	2026-06-04 15:50:02.09+03
102	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Droit à CNTEMAD MAHAJANGA	{"field_name":"Droit","university_name":"CNTEMAD MAHAJANGA"}	f	\N	2026-06-04 15:53:39.628+03	2026-06-04 15:53:39.628+03
103	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Informatique à CNTEMAD MAHAJANGA	{"field_name":"Informatique","university_name":"CNTEMAD MAHAJANGA"}	f	\N	2026-06-04 15:55:40.284+03	2026-06-04 15:55:40.284+03
104	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Télécommunications à CNTEMAD MAHAJANGA	{"field_name":"Télécommunications","university_name":"CNTEMAD MAHAJANGA"}	f	\N	2026-06-04 15:57:09.13+03	2026-06-04 15:57:09.13+03
105	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Communication à CNTEMAD MAHAJANGA	{"field_name":"Communication","university_name":"CNTEMAD MAHAJANGA"}	f	\N	2026-06-04 15:59:59.9+03	2026-06-04 15:59:59.9+03
106	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Commerce et Management des Affaires à CNTEMAD MAHAJANGA	{"field_name":"Commerce et Management des Affaires","university_name":"CNTEMAD MAHAJANGA"}	f	\N	2026-06-04 16:01:36.803+03	2026-06-04 16:01:36.803+03
107	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Gestion à CNTEMAD TOLIARA	{"field_name":"Gestion","university_name":"CNTEMAD TOLIARA"}	f	\N	2026-06-04 16:03:49.717+03	2026-06-04 16:03:49.717+03
108	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Droit à CNTEMAD TOLIARA	{"field_name":"Droit","university_name":"CNTEMAD TOLIARA"}	f	\N	2026-06-04 16:05:25.888+03	2026-06-04 16:05:25.888+03
109	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Informatique à CNTEMAD TOLIARA	{"field_name":"Informatique","university_name":"CNTEMAD TOLIARA"}	f	\N	2026-06-04 16:07:32.439+03	2026-06-04 16:07:32.439+03
110	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Télécommunications à CNTEMAD TOLIARA	{"field_name":"Télécommunications","university_name":"CNTEMAD TOLIARA"}	f	\N	2026-06-04 16:08:55.019+03	2026-06-04 16:08:55.019+03
129	36	success	[DONE] Profil mis à jour	Vos informations personnelles ont été mises à jour avec succès.	\N	f	\N	2026-06-07 08:20:24.974+03	2026-06-07 08:20:24.974+03
59	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Maïeutique (Sage-femme) à AROVY HEALTHCARE UNIVERSITY	{"field_name":"Maïeutique (Sage-femme)","university_name":"AROVY HEALTHCARE UNIVERSITY"}	f	\N	2026-06-03 18:25:59.607+03	2026-06-03 18:25:59.607+03
60	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Technologie Biomédicale à AROVY HEALTHCARE UNIVERSITY	{"field_name":"Technologie Biomédicale","university_name":"AROVY HEALTHCARE UNIVERSITY"}	f	\N	2026-06-03 18:27:59.113+03	2026-06-03 18:27:59.113+03
61	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Santé Publique à AROVY HEALTHCARE UNIVERSITY	{"field_name":"Santé Publique","university_name":"AROVY HEALTHCARE UNIVERSITY"}	f	\N	2026-06-03 18:30:10.131+03	2026-06-03 18:30:10.131+03
64	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Agroalimentaire à ATHENEE SAINT JOSEPH ANTSIRABE	{"field_name":"Agroalimentaire","university_name":"ATHENEE SAINT JOSEPH ANTSIRABE"}	f	\N	2026-06-03 19:00:36.504+03	2026-06-03 19:00:36.504+03
65	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Agroalimentaire à ATHENEE SAINT JOSEPH ANTSIRABE	{"field_name":"Agroalimentaire","university_name":"ATHENEE SAINT JOSEPH ANTSIRABE"}	f	\N	2026-06-03 19:02:11.789+03	2026-06-03 19:02:11.789+03
66	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Économie et Commerce à ATHENEE SAINT JOSEPH ANTSIRABE	{"field_name":"Économie et Commerce","university_name":"ATHENEE SAINT JOSEPH ANTSIRABE"}	f	\N	2026-06-03 19:05:45.339+03	2026-06-03 19:05:45.339+03
67	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Économie et Commerce à ATHENEE SAINT JOSEPH ANTSIRABE	{"field_name":"Économie et Commerce","university_name":"ATHENEE SAINT JOSEPH ANTSIRABE"}	f	\N	2026-06-03 19:07:51.034+03	2026-06-03 19:07:51.034+03
68	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Droit à ATHENEE SAINT JOSEPH ANTSIRABE	{"field_name":"Droit","university_name":"ATHENEE SAINT JOSEPH ANTSIRABE"}	f	\N	2026-06-03 19:11:02.954+03	2026-06-03 19:11:02.954+03
73	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Gestion des Ressources Humaines à CENTRE DE FORMATION DES RESSOURCES HUMAINES	{"field_name":"Gestion des Ressources Humaines","university_name":"CENTRE DE FORMATION DES RESSOURCES HUMAINES"}	f	\N	2026-06-03 20:41:07.66+03	2026-06-03 20:41:07.66+03
74	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Gestion des Ressources Humaines Avancée Champ à CENTRE DE FORMATION DES RESSOURCES HUMAINES	{"field_name":"Gestion des Ressources Humaines Avancée Champ","university_name":"CENTRE DE FORMATION DES RESSOURCES HUMAINES"}	f	\N	2026-06-03 20:43:50.82+03	2026-06-03 20:43:50.82+03
77	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Réseaux et Télécommunications à CENTRE D'ETUDES, DE L'INFORMATION ET SES TECHNOLOGIES	{"field_name":"Réseaux et Télécommunications","university_name":"CENTRE D'ETUDES, DE L'INFORMATION ET SES TECHNOLOGIES"}	f	\N	2026-06-03 20:56:48.793+03	2026-06-03 20:56:48.793+03
78	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Management des Systèmes d'Information à CENTRE D'ETUDES, DE L'INFORMATION ET SES TECHNOLOGIES	{"field_name":"Management des Systèmes d'Information","university_name":"CENTRE D'ETUDES, DE L'INFORMATION ET SES TECHNOLOGIES"}	f	\N	2026-06-03 20:58:41.616+03	2026-06-03 20:58:41.616+03
80	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Sciences Sociales de Développement Rural et Communautaire à CENTRE REGIONAL DE FORMATION UNIVERSITAIRE FARAFANGANA	{"field_name":"Sciences Sociales de Développement Rural et Communautaire","university_name":"CENTRE REGIONAL DE FORMATION UNIVERSITAIRE FARAFANGANA"}	f	\N	2026-06-03 21:10:54.276+03	2026-06-03 21:10:54.276+03
81	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Agronomie – Technologie – Environnement à CENTRE REGIONAL DE FORMATION UNIVERSITAIRE FARAFANGANA	{"field_name":"Agronomie – Technologie – Environnement","university_name":"CENTRE REGIONAL DE FORMATION UNIVERSITAIRE FARAFANGANA"}	f	\N	2026-06-03 21:13:01.794+03	2026-06-03 21:13:01.794+03
82	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Tourisme à CENTRE REGIONAL DE FORMATION UNIVERSITAIRE FARAFANGANA	{"field_name":"Tourisme","university_name":"CENTRE REGIONAL DE FORMATION UNIVERSITAIRE FARAFANGANA"}	f	\N	2026-06-03 21:14:51.353+03	2026-06-03 21:14:51.353+03
83	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Environnement et Technologies Écologiques à CENTRE REGIONAL DE FORMATION UNIVERSITAIRE FARAFANGANA	{"field_name":"Environnement et Technologies Écologiques","university_name":"CENTRE REGIONAL DE FORMATION UNIVERSITAIRE FARAFANGANA"}	f	\N	2026-06-03 21:17:11.033+03	2026-06-03 21:17:11.033+03
86	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Gestion à CNTEMAD ANTSIRANANA	{"field_name":"Gestion","university_name":"CNTEMAD ANTSIRANANA"}	f	\N	2026-06-03 21:49:30.521+03	2026-06-03 21:49:30.521+03
87	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Droit à CNTEMAD ANTSIRANANA	{"field_name":"Droit","university_name":"CNTEMAD ANTSIRANANA"}	f	\N	2026-06-03 21:51:19.256+03	2026-06-03 21:51:19.256+03
88	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Informatique à CNTEMAD ANTSIRANANA	{"field_name":"Informatique","university_name":"CNTEMAD ANTSIRANANA"}	f	\N	2026-06-03 21:53:42.638+03	2026-06-03 21:53:42.638+03
89	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Télécommunications à CNTEMAD ANTSIRANANA	{"field_name":"Télécommunications","university_name":"CNTEMAD ANTSIRANANA"}	f	\N	2026-06-03 21:55:52.898+03	2026-06-03 21:55:52.898+03
92	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Gestion à CNTEMAD FIANARANTSOA	{"field_name":"Gestion","university_name":"CNTEMAD FIANARANTSOA"}	f	\N	2026-06-03 22:07:31.078+03	2026-06-03 22:07:31.078+03
93	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Droit à CNTEMAD FIANARANTSOA	{"field_name":"Droit","university_name":"CNTEMAD FIANARANTSOA"}	f	\N	2026-06-03 22:08:59.881+03	2026-06-03 22:08:59.881+03
94	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Informatique à CNTEMAD FIANARANTSOA	{"field_name":"Informatique","university_name":"CNTEMAD FIANARANTSOA"}	f	\N	2026-06-03 22:10:56.666+03	2026-06-03 22:10:56.666+03
95	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Télécommunications à CNTEMAD FIANARANTSOA	{"field_name":"Télécommunications","university_name":"CNTEMAD FIANARANTSOA"}	f	\N	2026-06-03 22:12:23.327+03	2026-06-03 22:12:23.327+03
96	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Communication à CNTEMAD FIANARANTSOA	{"field_name":"Communication","university_name":"CNTEMAD FIANARANTSOA"}	f	\N	2026-06-03 22:14:08.813+03	2026-06-03 22:14:08.813+03
111	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Communication à CNTEMAD TOLIARA	{"field_name":"Communication","university_name":"CNTEMAD TOLIARA"}	f	\N	2026-06-04 16:10:47.058+03	2026-06-04 16:10:47.058+03
112	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Commerce et Management des Affaires à CNTEMAD TOLIARA	{"field_name":"Commerce et Management des Affaires","university_name":"CNTEMAD TOLIARA"}	f	\N	2026-06-04 16:12:28.415+03	2026-06-04 16:12:28.415+03
113	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Gestion et Administration d'Entreprises à EBM INSTITUTE - ENGINEERING AND BUSINESS MALAGASY	{"field_name":"Gestion et Administration d'Entreprises","university_name":"EBM INSTITUTE - ENGINEERING AND BUSINESS MALAGASY"}	f	\N	2026-06-04 16:18:40.696+03	2026-06-04 16:18:40.696+03
114	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Transit et Douane à EBM INSTITUTE - ENGINEERING AND BUSINESS MALAGASY	{"field_name":"Transit et Douane","university_name":"EBM INSTITUTE - ENGINEERING AND BUSINESS MALAGASY"}	f	\N	2026-06-04 16:21:07.55+03	2026-06-04 16:21:07.55+03
115	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Droit et Techniques des Affaires à EBM INSTITUTE - ENGINEERING AND BUSINESS MALAGASY	{"field_name":"Droit et Techniques des Affaires","university_name":"EBM INSTITUTE - ENGINEERING AND BUSINESS MALAGASY"}	f	\N	2026-06-04 16:23:15.607+03	2026-06-04 16:23:15.607+03
116	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Informatique à EBM INSTITUTE - ENGINEERING AND BUSINESS MALAGASY	{"field_name":"Informatique","university_name":"EBM INSTITUTE - ENGINEERING AND BUSINESS MALAGASY"}	f	\N	2026-06-04 16:25:26.076+03	2026-06-04 16:25:26.076+03
117	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Gestion à ECOLE DE COMPTABILITE ET D'ADMINISTRATION TARATRA	{"field_name":"Gestion","university_name":"ECOLE DE COMPTABILITE ET D'ADMINISTRATION TARATRA"}	f	\N	2026-06-04 16:30:57.175+03	2026-06-04 16:30:57.175+03
118	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Sciences Infirmières à ECOLE DE SANTE PUBLIQUE ET MEDECINE	{"field_name":"Sciences Infirmières","university_name":"ECOLE DE SANTE PUBLIQUE ET MEDECINE"}	f	\N	2026-06-04 16:42:41.128+03	2026-06-04 16:42:41.128+03
119	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Management et Administration de la Santé à ECOLE DE SANTE PUBLIQUE ET MEDECINE	{"field_name":"Management et Administration de la Santé","university_name":"ECOLE DE SANTE PUBLIQUE ET MEDECINE"}	f	\N	2026-06-04 16:44:36.453+03	2026-06-04 16:44:36.453+03
120	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Santé Spécialisée à ECOLE DE SANTE PUBLIQUE ET MEDECINE	{"field_name":"Santé Spécialisée","university_name":"ECOLE DE SANTE PUBLIQUE ET MEDECINE"}	f	\N	2026-06-04 16:46:39.044+03	2026-06-04 16:46:39.044+03
121	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Comptabilité et Finance à CONSERVATOIRE NATIONAL DES ARTS ET METIERS	{"field_name":"Comptabilité et Finance","university_name":"CONSERVATOIRE NATIONAL DES ARTS ET METIERS"}	f	\N	2026-06-05 11:46:08.909+03	2026-06-05 11:46:08.909+03
122	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Management et Administration à CONSERVATOIRE NATIONAL DES ARTS ET METIERS	{"field_name":"Management et Administration","university_name":"CONSERVATOIRE NATIONAL DES ARTS ET METIERS"}	f	\N	2026-06-05 11:48:37.023+03	2026-06-05 11:48:37.023+03
123	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Génie Civil et Bâtiment à CONSERVATOIRE NATIONAL DES ARTS ET METIERS	{"field_name":"Génie Civil et Bâtiment","university_name":"CONSERVATOIRE NATIONAL DES ARTS ET METIERS"}	f	\N	2026-06-05 11:50:30.558+03	2026-06-05 11:50:30.558+03
124	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Énergie, Environnement et Développement Durable à CONSERVATOIRE NATIONAL DES ARTS ET METIERS	{"field_name":"Énergie, Environnement et Développement Durable","university_name":"CONSERVATOIRE NATIONAL DES ARTS ET METIERS"}	f	\N	2026-06-05 11:52:07.228+03	2026-06-05 11:52:07.228+03
125	36	success	❤️ Favori ajouté	Télécommunications a été ajoutée à vos favoris	{"filiere_id":487,"filiere_name":"Télécommunications"}	f	\N	2026-06-05 13:51:05.192+03	2026-06-05 13:51:05.192+03
126	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Sciences Humaines, Sociales, Juridiques et Politiques à ECOLE DOCTORALE SCIENCES HUMAINES SOCIALES JURIDIQUE POLITIQUE	{"field_name":"Sciences Humaines, Sociales, Juridiques et Politiques","university_name":"ECOLE DOCTORALE SCIENCES HUMAINES SOCIALES JURIDIQUE POLITIQUE"}	f	\N	2026-06-06 13:06:36.311+03	2026-06-06 13:06:36.311+03
127	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Sciences Théologiques et Philosophiques à ECOLE DOCTORALE SCIENCES THEO PHIL	{"field_name":"Sciences Théologiques et Philosophiques","university_name":"ECOLE DOCTORALE SCIENCES THEO PHIL"}	f	\N	2026-06-06 13:19:26.076+03	2026-06-06 13:19:26.076+03
128	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Sciences à ECOLE DOCTORALE SCIENCES UCM	{"field_name":"Sciences","university_name":"ECOLE DOCTORALE SCIENCES UCM"}	f	\N	2026-06-06 13:22:54.37+03	2026-06-06 13:22:54.37+03
130	36	success	[DONE] Profil mis à jour	Vos informations personnelles ont été mises à jour avec succès.	\N	f	\N	2026-06-07 08:20:25.099+03	2026-06-07 08:20:25.099+03
131	36	success	[DONE] Profil mis à jour	Vos informations personnelles ont été mises à jour avec succès.	\N	f	\N	2026-06-07 08:32:59.38+03	2026-06-07 08:32:59.38+03
132	36	success	[DONE] Profil mis à jour	Vos informations personnelles ont été mises à jour avec succès.	\N	f	\N	2026-06-07 08:32:59.579+03	2026-06-07 08:32:59.579+03
133	36	success	[DONE] Profil mis à jour	Vos informations personnelles ont été mises à jour avec succès.	\N	f	\N	2026-06-07 18:49:55.625+03	2026-06-07 18:49:55.625+03
134	36	success	[DONE] Profil mis à jour	Vos informations personnelles ont été mises à jour avec succès.	\N	f	\N	2026-06-07 18:49:55.722+03	2026-06-07 18:49:55.722+03
135	36	success	[CELEBRATE] Test complété !	Vous avez complété le test d'orientation. Votre score: 100%	{"test_session_id":38,"score":100}	f	\N	2026-06-07 19:24:33.064+03	2026-06-07 19:24:33.064+03
136	36	info	[LIST] Recommandations disponibles	11 filière(s) vous ont été recommandée(s) basé sur vos réponses au test.	{"recommendation_count":11}	f	\N	2026-06-07 19:24:33.409+03	2026-06-07 19:24:33.409+03
137	36	success	[DONE] Profil mis à jour	Vos informations personnelles ont été mises à jour avec succès.	\N	f	\N	2026-06-07 19:36:10.081+03	2026-06-07 19:36:10.081+03
138	36	success	[DONE] Profil mis à jour	Vos informations personnelles ont été mises à jour avec succès.	\N	f	\N	2026-06-07 19:36:10.456+03	2026-06-07 19:36:10.456+03
139	36	success	[CELEBRATE] Test complété !	Vous avez complété le test d'orientation. Votre score: 100%	{"test_session_id":39,"score":100}	f	\N	2026-06-07 19:37:22.145+03	2026-06-07 19:37:22.145+03
140	36	info	[LIST] Recommandations disponibles	24 filière(s) vous ont été recommandée(s) basé sur vos réponses au test.	{"recommendation_count":24}	f	\N	2026-06-07 19:37:22.465+03	2026-06-07 19:37:22.465+03
141	36	success	❤️ Favori ajouté	Biochimie et Sciences de l'Environnement a été ajoutée à vos favoris	{"filiere_id":231,"filiere_name":"Biochimie et Sciences de l'Environnement"}	t	2026-06-07 19:38:17.297+03	2026-06-07 19:37:54.079+03	2026-06-07 19:38:17.298+03
142	36	success	[DONE] Profil mis à jour	Vos informations personnelles ont été mises à jour avec succès.	\N	f	\N	2026-06-07 19:43:07.521+03	2026-06-07 19:43:07.521+03
143	36	success	[DONE] Profil mis à jour	Vos informations personnelles ont été mises à jour avec succès.	\N	f	\N	2026-06-07 19:43:07.592+03	2026-06-07 19:43:07.592+03
144	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Recherche Doctorale Multidisciplinaire à ECOLE DOCTORALE TOAMASINA	{"field_name":"Recherche Doctorale Multidisciplinaire","university_name":"ECOLE DOCTORALE TOAMASINA"}	f	\N	2026-06-09 06:47:15.794+03	2026-06-09 06:47:15.794+03
145	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Commissaire de Police à ÉCOLE NATIONALE SUPÉRIEURE DE LA POLICE	{"field_name":"Commissaire de Police","university_name":"ÉCOLE NATIONALE SUPÉRIEURE DE LA POLICE"}	f	\N	2026-06-09 07:07:43.957+03	2026-06-09 07:07:43.957+03
146	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Officier de Police à ÉCOLE NATIONALE SUPÉRIEURE DE LA POLICE	{"field_name":"Officier de Police","university_name":"ÉCOLE NATIONALE SUPÉRIEURE DE LA POLICE"}	f	\N	2026-06-09 07:10:18.756+03	2026-06-09 07:10:18.756+03
147	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Formation Continue des Cadres de Police à ÉCOLE NATIONALE SUPÉRIEURE DE LA POLICE	{"field_name":"Formation Continue des Cadres de Police","university_name":"ÉCOLE NATIONALE SUPÉRIEURE DE LA POLICE"}	f	\N	2026-06-09 07:12:21.367+03	2026-06-09 07:12:21.367+03
148	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Master Agronomie à ECOLE PROFESSIONNELLE SUPERIEURE AGRICOLE	{"field_name":"Master Agronomie","university_name":"ECOLE PROFESSIONNELLE SUPERIEURE AGRICOLE"}	f	\N	2026-06-09 07:22:10.681+03	2026-06-09 07:22:10.681+03
149	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Génie Civil (Master) à ECOLE SUPERIEURE DE BATIMENT ET TRAVAUX PUBLICS	{"field_name":"Génie Civil (Master)","university_name":"ECOLE SUPERIEURE DE BATIMENT ET TRAVAUX PUBLICS"}	f	\N	2026-06-09 07:30:20.036+03	2026-06-09 07:30:20.036+03
150	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Agronomie à ECOLE SUPERIEURE DE DEVELOPPEMENT ECONOMIQUE ET SOCIAL	{"field_name":"Agronomie","university_name":"ECOLE SUPERIEURE DE DEVELOPPEMENT ECONOMIQUE ET SOCIAL"}	f	\N	2026-06-09 07:46:55.602+03	2026-06-09 07:46:55.602+03
151	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Droit Privé à ECOLE SUPERIEURE DE DROIT	{"field_name":"Droit Privé","university_name":"ECOLE SUPERIEURE DE DROIT"}	f	\N	2026-06-09 07:53:19.952+03	2026-06-09 07:53:19.952+03
152	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Science Politique à ECOLE SUPERIEURE DE DROIT	{"field_name":"Science Politique","university_name":"ECOLE SUPERIEURE DE DROIT"}	f	\N	2026-06-09 07:56:04.337+03	2026-06-09 07:56:04.337+03
153	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Management de l'Environnement et Gestion de Projets à ECOLE SUPERIEURE DE MANAGEMENT	{"field_name":"Management de l'Environnement et Gestion de Projets","university_name":"ECOLE SUPERIEURE DE MANAGEMENT"}	f	\N	2026-06-09 08:05:00.281+03	2026-06-09 08:05:00.281+03
154	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Master Ingénierie et Management de Projets à ECOLE SUPERIEURE DE MANAGEMENT	{"field_name":"Master Ingénierie et Management de Projets","university_name":"ECOLE SUPERIEURE DE MANAGEMENT"}	f	\N	2026-06-09 08:08:24.987+03	2026-06-09 08:08:24.987+03
155	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Master Qualité, Agronomie et Développement Durable à ECOLE SUPERIEURE DE MANAGEMENT	{"field_name":"Master Qualité, Agronomie et Développement Durable","university_name":"ECOLE SUPERIEURE DE MANAGEMENT"}	f	\N	2026-06-09 08:10:24.663+03	2026-06-09 08:10:24.663+03
156	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Master Informatique Appliquée à la Gestion d'Entreprise à ECOLE SUPERIEURE DE MANAGEMENT	{"field_name":"Master Informatique Appliquée à la Gestion d'Entreprise","university_name":"ECOLE SUPERIEURE DE MANAGEMENT"}	f	\N	2026-06-09 08:12:06.195+03	2026-06-09 08:12:06.195+03
157	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Banque et Assurance à ECOLE SUPERIEURE DE MANAGEMENT ET D'INFORMATIQUE APPLIQUEE	{"field_name":"Banque et Assurance","university_name":"ECOLE SUPERIEURE DE MANAGEMENT ET D'INFORMATIQUE APPLIQUEE"}	f	\N	2026-06-09 08:17:06.286+03	2026-06-09 08:17:06.286+03
158	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Ingénierie et Management de Projets à ECOLE SUPERIEURE DE MANAGEMENT ET D'INFORMATIQUE APPLIQUEE	{"field_name":"Ingénierie et Management de Projets","university_name":"ECOLE SUPERIEURE DE MANAGEMENT ET D'INFORMATIQUE APPLIQUEE"}	f	\N	2026-06-09 08:18:20.472+03	2026-06-09 08:18:20.472+03
159	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Qualité, Agronomie et Développement Durable à ECOLE SUPERIEURE DE MANAGEMENT ET D'INFORMATIQUE APPLIQUEE	{"field_name":"Qualité, Agronomie et Développement Durable","university_name":"ECOLE SUPERIEURE DE MANAGEMENT ET D'INFORMATIQUE APPLIQUEE"}	f	\N	2026-06-09 08:19:42.264+03	2026-06-09 08:19:42.264+03
160	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Informatique Appliquée à la Gestion d'Entreprise (MIAGE) à ECOLE SUPERIEURE DE MANAGEMENT ET D'INFORMATIQUE APPLIQUEE	{"field_name":"Informatique Appliquée à la Gestion d'Entreprise (MIAGE)","university_name":"ECOLE SUPERIEURE DE MANAGEMENT ET D'INFORMATIQUE APPLIQUEE"}	f	\N	2026-06-09 08:21:10.976+03	2026-06-09 08:21:10.976+03
161	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Comptabilité et Finances à ECOLE SUPERIEURE DE TECHNOLOGIE	{"field_name":"Comptabilité et Finances","university_name":"ECOLE SUPERIEURE DE TECHNOLOGIE"}	f	\N	2026-06-09 08:27:09.394+03	2026-06-09 08:27:09.394+03
162	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Commerce International à ECOLE SUPERIEURE DE TECHNOLOGIE	{"field_name":"Commerce International","university_name":"ECOLE SUPERIEURE DE TECHNOLOGIE"}	f	\N	2026-06-09 08:28:41.488+03	2026-06-09 08:28:41.488+03
163	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Marketing et Distribution à ECOLE SUPERIEURE DE TECHNOLOGIE	{"field_name":"Marketing et Distribution","university_name":"ECOLE SUPERIEURE DE TECHNOLOGIE"}	f	\N	2026-06-09 08:30:11.624+03	2026-06-09 08:30:11.624+03
164	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Management Stratégique à ECOLE SUPERIEURE DE TECHNOLOGIE	{"field_name":"Management Stratégique","university_name":"ECOLE SUPERIEURE DE TECHNOLOGIE"}	f	\N	2026-06-09 08:31:48.143+03	2026-06-09 08:31:48.143+03
165	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Marketing Touristique et Gestion Hôtelière à ECOLE SUPERIEURE DE TECHNOLOGIE	{"field_name":"Marketing Touristique et Gestion Hôtelière","university_name":"ECOLE SUPERIEURE DE TECHNOLOGIE"}	f	\N	2026-06-09 08:33:38.546+03	2026-06-09 08:33:38.546+03
166	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Réseaux et Systèmes (RSI) à ECOLE SUPERIEURE DE TECHNOLOGIES DE L'INFORMATION	{"field_name":"Réseaux et Systèmes (RSI)","university_name":"ECOLE SUPERIEURE DE TECHNOLOGIES DE L'INFORMATION"}	f	\N	2026-06-09 08:38:57.777+03	2026-06-09 08:38:57.777+03
167	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Management des Systèmes d'Information (MSI) à ECOLE SUPERIEURE DE TECHNOLOGIES DE L'INFORMATION	{"field_name":"Management des Systèmes d'Information (MSI)","university_name":"ECOLE SUPERIEURE DE TECHNOLOGIES DE L'INFORMATION"}	f	\N	2026-06-09 08:40:54.974+03	2026-06-09 08:40:54.974+03
168	36	info	📚 Nouvelle filière	Une nouvelle filière a été ajoutée: Infrastructure et Cybersécurité (IC) à ECOLE SUPERIEURE DE TECHNOLOGIES DE L'INFORMATION	{"field_name":"Infrastructure et Cybersécurité (IC)","university_name":"ECOLE SUPERIEURE DE TECHNOLOGIES DE L'INFORMATION"}	f	\N	2026-06-09 08:43:15.718+03	2026-06-09 08:43:15.718+03
\.


--
-- Data for Name: options_reponses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.options_reponses (id, question_id, texte, poids, created_at, updated_at) FROM stdin;
7	2	Mathématiques	{"score":10}	2026-06-02 14:54:27.109+03	2026-06-02 14:54:27.109+03
8	2	Physique-Chimie	{"score":20}	2026-06-02 14:54:27.111+03	2026-06-02 14:54:27.111+03
9	2	Sciences naturelles	{"score":30}	2026-06-02 14:54:27.115+03	2026-06-02 14:54:27.115+03
10	2	Langues étrangères	{"score":40}	2026-06-02 14:54:27.117+03	2026-06-02 14:54:27.117+03
11	2	Littérature	{"score":50}	2026-06-02 14:54:27.12+03	2026-06-02 14:54:27.12+03
12	2	Informatique	{"score":60}	2026-06-02 14:54:27.123+03	2026-06-02 14:54:27.123+03
13	3	Toujours en équipe	{"score":10}	2026-06-02 14:54:27.127+03	2026-06-02 14:54:27.127+03
14	3	Plutôt en équipe	{"score":20}	2026-06-02 14:54:27.13+03	2026-06-02 14:54:27.13+03
15	3	Plutôt seul	{"score":30}	2026-06-02 14:54:27.133+03	2026-06-02 14:54:27.133+03
16	3	Toujours seul	{"score":40}	2026-06-02 14:54:27.135+03	2026-06-02 14:54:27.135+03
17	4	Université publique	{"score":10}	2026-06-02 14:54:27.14+03	2026-06-02 14:54:27.14+03
18	4	Grande école	{"score":20}	2026-06-02 14:54:27.143+03	2026-06-02 14:54:27.143+03
19	4	Institut spécialisé	{"score":30}	2026-06-02 14:54:27.145+03	2026-06-02 14:54:27.145+03
20	4	Formation en alternance	{"score":40}	2026-06-02 14:54:27.148+03	2026-06-02 14:54:27.148+03
21	5	Licence (3 ans)	{"score":10}	2026-06-02 14:54:27.154+03	2026-06-02 14:54:27.154+03
22	5	Master (5 ans)	{"score":20}	2026-06-02 14:54:27.156+03	2026-06-02 14:54:27.156+03
23	5	Doctorat (8+ ans)	{"score":30}	2026-06-02 14:54:27.159+03	2026-06-02 14:54:27.159+03
24	5	Formation courte (2 ans)	{"score":40}	2026-06-02 14:54:27.161+03	2026-06-02 14:54:27.161+03
25	6	Antananarivo	{"score":10}	2026-06-02 14:54:27.166+03	2026-06-02 14:54:27.166+03
26	6	Fianarantsoa	{"score":20}	2026-06-02 14:54:27.169+03	2026-06-02 14:54:27.169+03
27	6	Toamasina	{"score":30}	2026-06-02 14:54:27.172+03	2026-06-02 14:54:27.172+03
28	6	Mahajanga	{"score":40}	2026-06-02 14:54:27.174+03	2026-06-02 14:54:27.174+03
29	6	Antsiranana	{"score":50}	2026-06-02 14:54:27.176+03	2026-06-02 14:54:27.176+03
30	6	Toliara	{"score":60}	2026-06-02 14:54:27.178+03	2026-06-02 14:54:27.178+03
31	6	Pas de préférence	{"score":70}	2026-06-02 14:54:27.181+03	2026-06-02 14:54:27.181+03
32	7	Oui, beaucoup	{"score":10}	2026-06-02 14:54:27.186+03	2026-06-02 14:54:27.186+03
33	7	Un peu	{"score":20}	2026-06-02 14:54:27.189+03	2026-06-02 14:54:27.189+03
34	7	Pas vraiment	{"score":30}	2026-06-02 14:54:27.192+03	2026-06-02 14:54:27.192+03
35	7	Pas du tout	{"score":40}	2026-06-02 14:54:27.194+03	2026-06-02 14:54:27.194+03
36	8	J'adore	{"score":10}	2026-06-02 14:54:27.2+03	2026-06-02 14:54:27.2+03
37	8	Ça me plaît	{"score":20}	2026-06-02 14:54:27.203+03	2026-06-02 14:54:27.203+03
38	8	C'est correct	{"score":30}	2026-06-02 14:54:27.206+03	2026-06-02 14:54:27.206+03
39	8	Je n'aime pas	{"score":40}	2026-06-02 14:54:27.209+03	2026-06-02 14:54:27.209+03
40	9	Très à l'aise	{"score":10}	2026-06-02 14:54:27.215+03	2026-06-02 14:54:27.215+03
41	9	Assez à l'aise	{"score":20}	2026-06-02 14:54:27.217+03	2026-06-02 14:54:27.217+03
42	9	Quelques difficultés	{"score":30}	2026-06-02 14:54:27.221+03	2026-06-02 14:54:27.221+03
43	9	Pas à l'aise	{"score":40}	2026-06-02 14:54:27.223+03	2026-06-02 14:54:27.223+03
44	10	Oui, je lis beaucoup	{"score":10}	2026-06-02 14:54:27.228+03	2026-06-02 14:54:27.228+03
45	10	J'aime lire de temps en temps	{"score":20}	2026-06-02 14:54:27.23+03	2026-06-02 14:54:27.23+03
46	10	Rarement	{"score":30}	2026-06-02 14:54:27.233+03	2026-06-02 14:54:27.233+03
47	10	Non	{"score":40}	2026-06-02 14:54:27.236+03	2026-06-02 14:54:27.236+03
112	26	test1Reponses	\N	2026-06-07 19:20:34.947+03	2026-06-07 19:20:34.947+03
113	26	test2Reponses	\N	2026-06-07 19:20:34.947+03	2026-06-07 19:20:34.947+03
114	1	Sciences et Technologies	\N	2026-06-07 19:22:10.492+03	2026-06-07 19:22:10.492+03
115	1	Sciences de Gestion	\N	2026-06-07 19:22:10.492+03	2026-06-07 19:22:10.492+03
116	1	Droit et Sciences Politiques	\N	2026-06-07 19:22:10.492+03	2026-06-07 19:22:10.492+03
117	1	Arts, Lettres et Communication	\N	2026-06-07 19:22:10.492+03	2026-06-07 19:22:10.492+03
118	1	Santé et Paramédical	\N	2026-06-07 19:22:10.492+03	2026-06-07 19:22:10.492+03
119	1	Agriculture et Environnement	\N	2026-06-07 19:22:10.492+03	2026-06-07 19:22:10.492+03
120	1	Sciences Humaines et Sociales (Éducation, Philosophie, Théologie)	\N	2026-06-07 19:22:10.492+03	2026-06-07 19:22:10.492+03
121	1	Défense et Sécurité	\N	2026-06-07 19:22:10.492+03	2026-06-07 19:22:10.492+03
\.


--
-- Data for Name: parcours; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parcours (id, filiere_id, nom, code, description, duree_mois, specialisation, competences_acquises, debouches_professionnels, actif, created_at, updated_at) FROM stdin;
9	455	Marine Militaire	\N	Préparation aux fonctions d'officier dans les forces navales.	36	Opérations navales	\N	\N	t	2026-06-03 18:04:33.561+03	2026-06-03 18:04:33.561+03
10	455	Aviation Militaire	\N	Parcours permettant une orientation vers les métiers de l'aviation militaire.	36	Pilotage et opérations aériennes	\N	\N	t	2026-06-03 18:04:33.561+03	2026-06-03 18:04:33.561+03
11	455	Gendarmerie	\N	ormation des officiers de la Gendarmerie Nationale.	36	Sécurité intérieure et maintien de l'ordre	\N	\N	t	2026-06-03 18:04:33.561+03	2026-06-03 18:04:33.561+03
12	455	Armée de Terre	\N	Formation destinée aux futurs officiers chargés de commander les unités terrestres.	36	Commandement terrestre	\N	\N	t	2026-06-03 18:04:33.561+03	2026-06-03 18:04:33.561+03
13	456	Technicien Militaire	\N	Formation militaire des techniciens spécialisés.	9	Maintenance et soutien technique	\N	\N	t	2026-06-03 18:05:07.52+03	2026-06-03 18:05:07.52+03
14	456	Informaticien Militaire	\N	Formation militaire des spécialistes informatiques.	9	Systèmes d'information et cybersécurité	\N	\N	t	2026-06-03 18:05:07.52+03	2026-06-03 18:05:07.52+03
15	456	Ingénieur Militaire	\N	Formation destinée aux ingénieurs rejoignant les forces armées.	9	Génie militaire	\N	\N	t	2026-06-03 18:05:07.52+03	2026-06-03 18:05:07.52+03
16	456	Médecin Militaire	\N	Formation militaire complémentaire destinée aux médecins.	9	Santé militaire	\N	\N	t	2026-06-03 18:05:07.52+03	2026-06-03 18:05:07.52+03
17	442	Sciences Infirmières Générales	\N	Formation des infirmiers polyvalents intervenant dans les hôpitaux, centres de santé et structures communautaires.	36	Soins infirmiers	\N	\N	t	2026-06-03 18:24:16.747+03	2026-06-03 18:24:16.747+03
18	457	Maïeutique	\N	Formation des sages-femmes assurant le suivi de grossesse, l'accouchement et les soins du nouveau-né.	36	Obstétrique et santé maternelle	\N	\N	t	2026-06-03 18:25:59.582+03	2026-06-03 18:25:59.582+03
19	458	Maintenance Biomédicale	\N	nstallation, maintenance et gestion des dispositifs médicaux et hospitaliers.	36	Maintenance des équipements médicaux	\N	\N	t	2026-06-03 18:27:59.089+03	2026-06-03 18:27:59.089+03
20	458	Instrumentation Biomédicale	\N	Utilisation, contrôle et gestion des équipements biomédicaux modernes.	36	Technologies de diagnostic et thérapeutiques	\N	\N	t	2026-06-03 18:27:59.089+03	2026-06-03 18:27:59.089+03
21	459	Gestion des Programmes de Santé	\N	ormation à la planification, à l'évaluation et à la gestion des programmes de santé publique.	36	Administration et gestion sanitaire	\N	\N	t	2026-06-03 18:30:10.108+03	2026-06-03 18:30:10.108+03
22	459	Promotion de la Santé	\N	Formation orientée vers la prévention des maladies et la sensibilisation communautaire.	36	Prévention et éducation sanitaire	\N	\N	t	2026-06-03 18:30:10.108+03	2026-06-03 18:30:10.108+03
34	8	Génie Logiciel	\N	Conception, développement et maintenance des logiciels.	24	Développement d'applications et systèmes informatiques	\N	\N	t	2026-06-03 18:50:23.314+03	2026-06-03 18:50:23.314+03
35	8	Réseaux et Systèmes	\N	Gestion des systèmes informatiques et réseaux d'entreprise.	24	Administration réseaux et infrastructures	\N	\N	t	2026-06-03 18:50:23.314+03	2026-06-03 18:50:23.314+03
36	8	Bases de Données et Systèmes d'Information	\N	Administration des bases de données et systèmes décisionnels.	24	Gestion et analyse de données	\N	\N	t	2026-06-03 18:50:23.314+03	2026-06-03 18:50:23.314+03
37	6	Géologie Minière	\N	Étude des ressources minérales et de leur exploitation.	24	Exploration et exploitation minière	\N	\N	t	2026-06-03 18:52:18.382+03	2026-06-03 18:52:18.382+03
38	6	Hydrogéologie	\N	Étude des nappes phréatiques et gestion des ressources hydriques.	24	Ressources en eau souterraine	\N	\N	t	2026-06-03 18:52:18.382+03	2026-06-03 18:52:18.382+03
39	5	Géologie Minière	\N	Étude des ressources minérales et de leur exploitation.	36	Exploration et exploitation minière	\N	\N	t	2026-06-03 18:53:58.368+03	2026-06-03 18:53:58.368+03
40	5	Hydrogéologie	\N	Étude des nappes phréatiques et gestion des ressources hydriques.	36	Ressources en eau souterraine	\N	\N	t	2026-06-03 18:53:58.368+03	2026-06-03 18:53:58.368+03
44	4	Production Végétale	\N	Techniques modernes de production agricole.	24	Cultures agricoles	\N	\N	t	2026-06-03 18:58:38.369+03	2026-06-03 18:58:38.369+03
45	4	Production et Santé Animale	\N	Gestion des élevages et prévention des maladies animales.	24	Élevage et santé animale	\N	\N	t	2026-06-03 18:58:38.369+03	2026-06-03 18:58:38.369+03
46	4	Génie Agricole	\N	Mécanisation et innovation agricole.	24	Techniques et équipements agricoles	\N	\N	t	2026-06-03 18:58:38.369+03	2026-06-03 18:58:38.369+03
49	463	Transformation Alimentaire	\N	Transformation des matières premières agricoles.	24	Production agroalimentaire	\N	\N	t	2026-06-03 19:02:11.771+03	2026-06-03 19:02:11.771+03
50	463	Contrôle Qualité Alimentaire	\N	Contrôle et certification des produits alimentaires.	24	Assurance qualité et sécurité alimentaire	\N	\N	t	2026-06-03 19:02:11.771+03	2026-06-03 19:02:11.771+03
51	464	Gestion des Entreprises	\N	Gestion opérationnelle et stratégique des organisations.	36	Administration et management	\N	\N	t	2026-06-03 19:05:45.319+03	2026-06-03 19:05:45.319+03
52	464	Commerce et Marketing	\N	Développement commercial et marketing	36	Commerce et techniques de vente	\N	\N	t	2026-06-03 19:05:45.319+03	2026-06-03 19:05:45.319+03
53	464	Développement Économique	\N	Étude des mécanismes de croissance et de développement.	36	Analyse économique et développement territorial	\N	\N	t	2026-06-03 19:05:45.319+03	2026-06-03 19:05:45.319+03
57	10	Droit Privé	\N	Étude des relations entre personnes physiques et morales.	36	Droit civil et commercial	\N	\N	t	2026-06-03 19:09:38.199+03	2026-06-03 19:09:38.199+03
58	10	Droit Public	\N	Étude des institutions de l'État et du droit administratif	36	Administration et institutions publiques	\N	\N	t	2026-06-03 19:09:38.199+03	2026-06-03 19:09:38.199+03
59	466	Droit Privé	\N	Étude des relations entre personnes physiques et morales.	24	Droit civil et commercial	\N	\N	t	2026-06-03 19:11:02.931+03	2026-06-03 19:11:02.931+03
60	466	Droit Public	\N	Étude des institutions de l'État et du droit administratif	24	Administration et institutions publiques	\N	\N	t	2026-06-03 19:11:02.931+03	2026-06-03 19:11:02.931+03
63	467	Management des Organisations	\N	Formation des futurs managers et responsables d'organisation.	24	Administration et gestion d'entreprise	\N	\N	t	2026-06-03 19:21:01.04+03	2026-06-03 19:21:01.04+03
64	467	Entrepreneuriat	\N	Conception, lancement et gestion de projets entrepreneuriaux.	24	Création et développement d'entreprise	\N	\N	t	2026-06-03 19:21:01.04+03	2026-06-03 19:21:01.04+03
67	468	Marketing Digital	\N	Communication digitale, réseaux sociaux et stratégie web.	24	Marketing numérique	\N	\N	t	2026-06-03 19:24:43.393+03	2026-06-03 19:24:43.393+03
68	468	Marketing & Sales	\N	Gestion commerciale, négociation et relation client.	24	Vente et développement commercial	\N	\N	t	2026-06-03 19:24:43.393+03	2026-06-03 19:24:43.393+03
69	469	Développement Commercial	\N	Stratégies de développement et expansion des activités.	36	Croissance des entreprises	\N	\N	t	2026-06-03 19:26:53.343+03	2026-06-03 19:26:53.343+03
70	469	Gestion de Projet	\N	Méthodes de gestion et conduite de projets innovants.	36	Pilotage de projets	\N	\N	t	2026-06-03 19:26:53.343+03	2026-06-03 19:26:53.343+03
79	462	Contrôle Qualité Alimentaire	\N	Contrôle et certification des produits alimentaires.	36	Assurance qualité et sécurité alimentaire	\N	\N	t	2026-06-03 19:49:18.919+03	2026-06-03 19:49:18.919+03
80	462	Transformation Alimentaire	\N	Transformation des matières premières agricoles.	36	Production agroalimentaire	\N	\N	t	2026-06-03 19:49:18.919+03	2026-06-03 19:49:18.919+03
81	465	Développement Économique	\N	Étude des mécanismes de croissance et de développement.	24	Analyse économique et développement territorial	\N	\N	t	2026-06-03 19:52:54.3+03	2026-06-03 19:52:54.3+03
82	465	Commerce et Marketin	\N	Développement commercial et marketing.	24	Commerce et techniques de vente	\N	\N	t	2026-06-03 19:52:54.3+03	2026-06-03 19:52:54.3+03
83	465	Gestion des Entreprises	\N	Gestion opérationnelle et stratégique des organisations.	24	Administration et management	\N	\N	t	2026-06-03 19:52:54.3+03	2026-06-03 19:52:54.3+03
84	7	Bases de Données et Systèmes d'Information	\N	Administration des bases de données et systèmes décisionnels.	36	Gestion et analyse de données	\N	\N	t	2026-06-03 20:29:04.006+03	2026-06-03 20:29:04.006+03
85	7	Réseaux et Systèmes	\N	Gestion des systèmes informatiques et réseaux d'entreprise.	36	Administration réseaux et infrastructures	\N	\N	t	2026-06-03 20:29:04.006+03	2026-06-03 20:29:04.006+03
86	7	Génie Logiciel	\N	Conception, développement et maintenance des logiciels.	36	Développement d'applications et systèmes informatiques	\N	\N	t	2026-06-03 20:29:04.006+03	2026-06-03 20:29:04.006+03
87	3	Génie Agricole	\N	Mécanisation et innovation agricole.	36	Techniques et équipements agricoles	\N	\N	t	2026-06-03 20:29:25.627+03	2026-06-03 20:29:25.627+03
88	3	Production et Santé Animale	\N	Gestion des élevages et prévention des maladies animales	36	Élevage et santé animale	\N	\N	t	2026-06-03 20:29:25.627+03	2026-06-03 20:29:25.627+03
89	3	Production Végétale	\N	Techniques modernes de production agricole.	36	Cultures agricoles	\N	\N	t	2026-06-03 20:29:25.627+03	2026-06-03 20:29:25.627+03
94	2	Entrepreneuriat	\N	Conception, lancement et gestion de projets entrepreneuriaux	36	Création et développement d'entreprise	\N	\N	t	2026-06-03 20:31:50.819+03	2026-06-03 20:31:50.819+03
95	2	Management des Organisations	\N	Formation des futurs managers et responsables d'organisation.	36	Administration et gestion d'entreprise	\N	\N	t	2026-06-03 20:31:50.819+03	2026-06-03 20:31:50.819+03
96	470	Développement Commercial	\N	Stratégies de développement et expansion des activités.	24	Croissance des entreprises	\N	\N	t	2026-06-03 20:32:03.171+03	2026-06-03 20:32:03.171+03
97	470	Gestion de Projet	\N	Méthodes de gestion et conduite de projets innovants.	24	Pilotage de projets	\N	\N	t	2026-06-03 20:32:03.171+03	2026-06-03 20:32:03.171+03
98	1	Marketing & Sales	\N	Gestion commerciale, négociation et relation client.	36	Vente et développement commercial	\N	\N	t	2026-06-03 20:32:21.407+03	2026-06-03 20:32:21.407+03
99	1	Marketing Digital	\N	Communication digitale, réseaux sociaux et stratégie web.	36	Marketing numérique	\N	\N	t	2026-06-03 20:32:21.407+03	2026-06-03 20:32:21.407+03
100	443	Sage-femme	\N	Suivi des grossesses, accouchements et soins du nouveau-né.	36	Santé maternelle et néonatale	\N	\N	t	2026-06-03 20:33:09.795+03	2026-06-03 20:33:09.795+03
101	461	Épidémiologie	\N	Analyse des données de santé et gestion des risques sanitaires.	36	Surveillance et contrôle des maladies	\N	\N	t	2026-06-03 20:33:19.892+03	2026-06-03 20:33:19.892+03
102	461	Santé Communautaire	\N	Interventions sanitaires auprès des communautés et populations.	36	Prévention et promotion de la santé	\N	\N	t	2026-06-03 20:33:19.892+03	2026-06-03 20:33:19.892+03
103	461	Gestion des Programmes de Santé	\N	Gestion des projets et programmes de santé publique.	36	Administration sanitaire	\N	\N	t	2026-06-03 20:33:19.892+03	2026-06-03 20:33:19.892+03
104	404	Infirmier Anesthésiste	\N	Formation orientée vers l'assistance anesthésique et les soins périopératoires.	36	Anesthésie et réanimation	\N	\N	t	2026-06-03 20:33:32.267+03	2026-06-03 20:33:32.267+03
105	404	Infirmier Généraliste	\N	Formation permettant d'exercer dans les hôpitaux, cliniques, centres de santé et ONG.	36	Soins infirmiers polyvalents	\N	\N	t	2026-06-03 20:33:32.267+03	2026-06-03 20:33:32.267+03
106	460	Instrumentation Biomédicale	\N	Utilisation et contrôle des équipements de diagnostic et de traitement.	36	Technologies médicales	\N	\N	t	2026-06-03 20:33:44.97+03	2026-06-03 20:33:44.97+03
107	460	Maintenance Biomédicale	\N	Gestion, maintenance et réparation des dispositifs médicaux.	36	Maintenance des équipements médicaux	\N	\N	t	2026-06-03 20:33:44.97+03	2026-06-03 20:33:44.97+03
108	471	Administration des Ressources Humaines	\N	Gestion administrative des salariés, contrats, paie et carrière	36	Gestion du personnel	\N	\N	t	2026-06-03 20:41:07.643+03	2026-06-03 20:41:07.643+03
109	471	Recrutement et Développement RH	\N	Sélection, intégration et développement des compétences des collaborateurs.	36	Recrutement et gestion des talents	\N	\N	t	2026-06-03 20:41:07.643+03	2026-06-03 20:41:07.643+03
110	471	Relations Sociales	\N	Gestion des relations employeur-employés et climat social.	36	Droit du travail et dialogue social	\N	\N	t	2026-06-03 20:41:07.643+03	2026-06-03 20:41:07.643+03
114	472	Management Stratégique des Ressources Humaines	\N	Élaboration et mise en œuvre de stratégies RH.	24	Pilotage RH	\N	\N	t	2026-06-03 20:44:15.623+03	2026-06-03 20:44:15.623+03
115	472	Ingénierie de la Formation	\N	Conception et gestion des plans de formation.	24	Développement des compétences	\N	\N	t	2026-06-03 20:44:15.623+03	2026-06-03 20:44:15.623+03
116	472	Audit et Performance RH	\N	Analyse et amélioration des processus RH.	24	Contrôle et optimisation des pratiques RH	\N	\N	t	2026-06-03 20:44:15.623+03	2026-06-03 20:44:15.623+03
117	473	Gestion des Entreprises	\N	Gestion opérationnelle des organisations, management et entrepreneuriat.	36	Administration et management	\N	\N	t	2026-06-03 20:48:17.474+03	2026-06-03 20:48:17.474+03
118	473	Comptabilité et Finance	\N	Formation aux techniques comptables, financières et fiscales.	36	Comptabilité et gestion financière	\N	\N	t	2026-06-03 20:48:17.474+03	2026-06-03 20:48:17.474+03
119	473	Marketing et Commerce	\N	Marketing, vente, négociation et gestion de la relation client.	36	Développement commercial	\N	\N	t	2026-06-03 20:48:17.474+03	2026-06-03 20:48:17.474+03
120	473	Gestion des Ressources Humaines	\N	Recrutement, gestion des carrières et développement des compétences.	36	Administration du personnel	\N	\N	t	2026-06-03 20:48:17.474+03	2026-06-03 20:48:17.474+03
121	474	Droit Privé	\N	Étude des relations juridiques entre particuliers et entreprises.	36	Droit civil et droit des affaires	\N	\N	t	2026-06-03 20:50:22.895+03	2026-06-03 20:50:22.895+03
122	474	Droit Public	\N	Institutions publiques, droit administratif et collectivités territoriales.	36	Administration publique	\N	\N	t	2026-06-03 20:50:22.895+03	2026-06-03 20:50:22.895+03
123	474	Droit des Affaires	\N	Droit commercial, fiscalité et environnement juridique des entreprises.	36	Entreprises et commerce	\N	\N	t	2026-06-03 20:50:22.895+03	2026-06-03 20:50:22.895+03
124	11	Génie Logiciel	\N	Conception, développement et maintenance de logiciels.	36	Développement d'applications	\N	\N	t	2026-06-03 20:53:45.477+03	2026-06-03 20:53:45.477+03
125	11	Développement Web et Mobile	\N	Création de solutions numériques pour le web et les smartphones.	36	Applications web et mobiles	\N	\N	t	2026-06-03 20:53:45.477+03	2026-06-03 20:53:45.477+03
126	11	Bases de Données et Systèmes d'Information	\N	Administration des bases de données et systèmes d'information.	36	Gestion des données	\N	\N	t	2026-06-03 20:53:45.477+03	2026-06-03 20:53:45.477+03
127	475	Administration Réseau	\N	Gestion et maintenance des infrastructures réseau.	36	Réseaux informatiques	\N	\N	t	2026-06-03 20:56:48.784+03	2026-06-03 20:56:48.784+03
128	475	Sécurité Informatique	\N	Protection des systèmes et des données numériques.	36	Cybersécurité	\N	\N	t	2026-06-03 20:56:48.784+03	2026-06-03 20:56:48.784+03
129	476	Informatique de Gestion	\N	Utilisation des technologies numériques dans la gestion d'entreprise.	36	Gestion informatisée des organisations	\N	\N	t	2026-06-03 20:58:41.598+03	2026-06-03 20:58:41.598+03
130	476	Audit et Gouvernance des SI	\N	Contrôle et optimisation des systèmes d'information.	36	Pilotage des systèmes d'information	\N	\N	t	2026-06-03 20:58:41.598+03	2026-06-03 20:58:41.598+03
131	477	Conservation de la Biodiversité	\N	Formation sur la gestion des aires protégées, la conservation des espèces et la préservation des ressources naturelles.	36	Protection des écosystèmes et de la faune	\N	\N	t	2026-06-03 21:05:46.929+03	2026-06-03 21:05:46.929+03
132	477	Écotourisme	\N	Développement d'activités touristiques respectueuses de l'environnement et des communautés locales.	36	Tourisme durable et valorisation des ressources naturelles	\N	\N	t	2026-06-03 21:05:46.929+03	2026-06-03 21:05:46.929+03
133	477	Développement Humain Durable	\N	Conception et gestion de projets conciliant développement économique, social et environnemental	36	Développement local et gestion durable	\N	\N	t	2026-06-03 21:05:46.929+03	2026-06-03 21:05:46.929+03
134	477	Approche Communautaire et Gestion des Ressources Naturelles	\N	Travail avec les communautés locales pour la gestion durable des ressources et le développement territorial	36	Gestion participative des ressources naturelles	\N	\N	t	2026-06-03 21:05:46.929+03	2026-06-03 21:05:46.929+03
135	478	Développement Rural	\N	Formation aux stratégies de développement territorial et communautaire.	36	Développement local	\N	\N	t	2026-06-03 21:10:54.251+03	2026-06-03 21:10:54.251+03
136	478	Développement Communautaire	\N	Accompagnement des communautés dans la mise en œuvre de projets de développement.	36	Animation et gestion de projets communautaires	\N	\N	t	2026-06-03 21:10:54.251+03	2026-06-03 21:10:54.251+03
137	478	Socio-économie Rurale	\N	Analyse des activités économiques et sociales en milieu rural.	36	Économie rurale	\N	\N	t	2026-06-03 21:10:54.251+03	2026-06-03 21:10:54.251+03
138	479	Agronomie	\N	Techniques agricoles adaptées aux réalités locales.	36	Production végétale et agricole	\N	\N	t	2026-06-03 21:13:01.784+03	2026-06-03 21:13:01.784+03
139	479	Technologie Environnementale	\N	Outils et technologies pour la protection de l'environnement.	36	Gestion des ressources naturelles	\N	\N	t	2026-06-03 21:13:01.784+03	2026-06-03 21:13:01.784+03
140	479	Développement Durable	\N	Intégration des dimensions économiques, sociales et environnementales.	36	Gestion durable des territoires	\N	\N	t	2026-06-03 21:13:01.784+03	2026-06-03 21:13:01.784+03
141	480	Gestion Touristique	\N	Gestion des entreprises et projets touristiques.	36	Administration touristique	\N	\N	t	2026-06-03 21:14:51.344+03	2026-06-03 21:14:51.344+03
142	480	Écotourisme	\N	Valorisation du patrimoine naturel et culturel.	36	Tourisme durable	\N	\N	t	2026-06-03 21:14:51.344+03	2026-06-03 21:14:51.344+03
143	480	Développement Touristique Territorial	\N	Conception et promotion des destinations touristiques.	36	Aménagement touristique	\N	\N	t	2026-06-03 21:14:51.344+03	2026-06-03 21:14:51.344+03
144	481	Gestion de l'Environnement	\N	Gestion et conservation des écosystèmes.	24	Protection environnementale	\N	\N	t	2026-06-03 21:17:11.014+03	2026-06-03 21:17:11.014+03
145	481	Technologies Écologiques	\N	Développement de solutions technologiques respectueuses de l'environnement.	24	Innovations environnementales	\N	\N	t	2026-06-03 21:17:11.014+03	2026-06-03 21:17:11.014+03
146	481	Aménagement Durable	\N	Gestion durable des ressources et des territoires.	24	Planification territoriale durable	\N	\N	t	2026-06-03 21:17:11.014+03	2026-06-03 21:17:11.014+03
147	482	Maintenance des Machines Agricoles	\N	Formation des techniciens capables d'assurer l'entretien et la réparation des tracteurs et matériels agricoles.	36	Diagnostic et réparation des équipements agricoles	\N	\N	t	2026-06-03 21:21:56.779+03	2026-06-03 21:21:56.779+03
148	482	Exploitation et Gestion des Équipements Agricoles	\N	Formation axée sur l'utilisation optimale des machines agricoles dans les exploitations.	36	Utilisation et gestion du parc matériel	\N	\N	t	2026-06-03 21:21:56.779+03	2026-06-03 21:21:56.779+03
149	482	Mécanisation Agricole	\N	Description : Conception, adaptation et diffusion des techniques de mécanisation agricole adaptées au contexte malgache.	36	Technologies de mécanisation	\N	\N	t	2026-06-03 21:21:56.779+03	2026-06-03 21:21:56.779+03
150	12	Équipements Agricoles	\N	Formation de techniciens supérieurs chargés de la maintenance des équipements agricoles et ruraux.	24	Installation et maintenance	\N	\N	t	2026-06-03 21:23:47.158+03	2026-06-03 21:23:47.158+03
151	12	Fabrication de Matériels Agricoles	\N	Fabrication d'outils agricoles, semoirs, décortiqueuses et autres équipements adaptés aux producteurs locaux.	24	Construction métallique agricole	\N	\N	t	2026-06-03 21:23:47.158+03	2026-06-03 21:23:47.158+03
201	502	Études Financières et Comptables	\N	Comptabilité générale, analyse financière et gestion budgétaire.	36	Comptabilité et finance	\N	\N	t	2026-06-04 16:03:49.696+03	2026-06-04 16:03:49.696+03
202	503	Droit Privé	\N	Étude des relations juridiques entre particuliers et entreprises.	36	Droit civil et commercial	\N	\N	t	2026-06-04 16:05:25.867+03	2026-06-04 16:05:25.867+03
153	483	Ingénierie de la Mécanisation Agricole	\N	Formation d'ingénieurs spécialisés dans les technologies de mécanisation et l'innovation agricole.	24	Conception et innovation des équipements agricoles	\N	\N	t	2026-06-03 21:26:04.652+03	2026-06-03 21:26:04.652+03
154	483	Gestion des Systèmes de Production Mécanisés	\N	Gestion des systèmes agricoles intégrant les technologies modernes de mécanisation.	24	Optimisation de la production agricole	\N	\N	t	2026-06-03 21:26:04.652+03	2026-06-03 21:26:04.652+03
155	484	Études Économiques et de Gestion	\N	Formation en management, organisation et administration des entreprises.	36	Gestion d'entreprise	\N	\N	t	2026-06-03 21:49:30.503+03	2026-06-03 21:49:30.503+03
156	484	Études Financières et Comptables	\N	Comptabilité générale, analyse financière et gestion budgétaire.	36	Comptabilité et finance	\N	\N	t	2026-06-03 21:49:30.503+03	2026-06-03 21:49:30.503+03
157	485	Droit Privé	\N	Étude des relations juridiques entre particuliers et entreprises.	36	Droit civil et commercial	\N	\N	t	2026-06-03 21:51:19.24+03	2026-06-03 21:51:19.24+03
158	485	Droit Public	\N	Institutions publiques, droit administratif et collectivités territoriales.	36	Administration publique	\N	\N	t	2026-06-03 21:51:19.24+03	2026-06-03 21:51:19.24+03
159	486	Génie Logiciel	\N	Analyse, conception et développement d'applications.	36	Développement logiciel	\N	\N	t	2026-06-03 21:53:42.616+03	2026-06-03 21:53:42.616+03
160	486	Systèmes d'Information	\N	Administration des systèmes d'information d'entreprise.	36	Gestion des données et SI	\N	\N	t	2026-06-03 21:53:42.616+03	2026-06-03 21:53:42.616+03
161	486	Développement Web	\N	Création d'applications web et plateformes numériques.	36	Technologies Internet	\N	\N	t	2026-06-03 21:53:42.616+03	2026-06-03 21:53:42.616+03
162	487	Réseaux Informatiques	\N	Conception et gestion des infrastructures réseau.	36	Administration réseau	\N	\N	t	2026-06-03 21:55:52.882+03	2026-06-03 21:55:52.882+03
163	487	Télécommunications	\N	Étude des systèmes de transmission et télécommunication.	36	Technologies de communication	\N	\N	t	2026-06-03 21:55:52.882+03	2026-06-03 21:55:52.882+03
164	488	Communication d'Entreprise	\N	Gestion de la communication des organisations.	36	Communication institutionnelle	\N	\N	t	2026-06-03 21:57:43.686+03	2026-06-03 21:57:43.686+03
165	488	Journalisme	\N	Techniques rédactionnelles, médias et communication numérique.	36	Médias et information	\N	\N	t	2026-06-03 21:57:43.686+03	2026-06-03 21:57:43.686+03
166	488	Relations Publiques	\N	Gestion de l'image et des relations avec les parties prenantes.	36	Communication externe	\N	\N	t	2026-06-03 21:57:43.686+03	2026-06-03 21:57:43.686+03
167	489	Commerce	\N	Vente, négociation et développement commercial.	36	Techniques commerciales	\N	\N	t	2026-06-03 21:59:12.402+03	2026-06-03 21:59:12.402+03
168	489	Management des Affaires	\N	Pilotage et développement des organisations.	36	Gestion stratégique	\N	\N	t	2026-06-03 21:59:12.402+03	2026-06-03 21:59:12.402+03
169	490	Études Économiques et de Gestion	\N	Formation en management, organisation et administration des entreprises.	36	Gestion d'entreprise	\N	\N	t	2026-06-03 22:07:31.063+03	2026-06-03 22:07:31.063+03
170	490	Études Financières et Comptables	\N	Comptabilité générale, contrôle de gestion et finance d'entreprise.	36	Comptabilité et finance	\N	\N	t	2026-06-03 22:07:31.063+03	2026-06-03 22:07:31.063+03
171	491	Droit Privé	\N	Étude du droit applicable aux particuliers et aux entreprises.	36	Droit civil et commercial	\N	\N	t	2026-06-03 22:08:59.861+03	2026-06-03 22:08:59.861+03
172	491	Droit Public	\N	Étude des institutions publiques et du droit administratif.	36	Administration publique	\N	\N	t	2026-06-03 22:08:59.861+03	2026-06-03 22:08:59.861+03
173	492	Génie Logiciel	\N	Analyse, conception et développement de logiciels.	36	Développement d'applications	\N	\N	t	2026-06-03 22:10:56.647+03	2026-06-03 22:10:56.647+03
174	492	Systèmes d'Information	\N	Administration des données et systèmes informatiques.	36	Gestion des systèmes d'information	\N	\N	t	2026-06-03 22:10:56.647+03	2026-06-03 22:10:56.647+03
175	492	Développement Web	\N	Développement de plateformes web et applications numériques.	36	Technologies Internet	\N	\N	t	2026-06-03 22:10:56.647+03	2026-06-03 22:10:56.647+03
176	493	Réseaux Informatiques	\N	Conception, déploiement et maintenance des réseaux.	36	Administration réseau	\N	\N	t	2026-06-03 22:12:23.321+03	2026-06-03 22:12:23.321+03
177	493	Télécommunications	\N	Étude des systèmes de transmission et télécommunications.	36	Technologies de communication	\N	\N	t	2026-06-03 22:12:23.321+03	2026-06-03 22:12:23.321+03
178	494	Communication d'Entreprise	\N	Gestion de la communication interne et externe.	36	Communication organisationnelle	\N	\N	t	2026-06-03 22:14:08.804+03	2026-06-03 22:14:08.804+03
179	494	Journalisme	\N	echniques journalistiques et communication numérique.	36	Médias et information	\N	\N	t	2026-06-03 22:14:08.804+03	2026-06-03 22:14:08.804+03
180	494	Relations Publiques	\N	Gestion des relations avec les partenaires et le public.	36	Image institutionnelle	\N	\N	t	2026-06-03 22:14:08.804+03	2026-06-03 22:14:08.804+03
181	495	Commerce	\N	Vente, négociation et développement commercial.	36	Techniques commerciales	\N	\N	t	2026-06-03 22:15:40.877+03	2026-06-03 22:15:40.877+03
182	495	Management des Affaires	\N	Pilotage et développement des organisations.	36	Gestion stratégique	\N	\N	t	2026-06-03 22:15:40.877+03	2026-06-03 22:15:40.877+03
183	496	Études Économiques et de Gestion	\N	Formation en management, organisation et administration des entreprises.	36	Gestion d'entreprise	\N	\N	t	2026-06-04 15:50:02.073+03	2026-06-04 15:50:02.073+03
184	496	Études Financières et Comptables	\N	Comptabilité générale, analyse financière et gestion budgétaire.	36	Comptabilité et finance	\N	\N	t	2026-06-04 15:50:02.073+03	2026-06-04 15:50:02.073+03
185	497	Droit Privé	\N	Étude des relations juridiques entre particuliers et entreprises.	36	Droit civil et commercial	\N	\N	t	2026-06-04 15:53:39.595+03	2026-06-04 15:53:39.595+03
186	497	Droit Public	\N	Institutions publiques, droit administratif et collectivités territoriales.	36	\N	\N	\N	t	2026-06-04 15:53:39.595+03	2026-06-04 15:53:39.595+03
190	499	Réseaux Informatiques	\N	Conception et gestion des infrastructures réseau.	36	Administration réseau	\N	\N	t	2026-06-04 15:57:09.095+03	2026-06-04 15:57:09.095+03
191	499	Télécommunications	\N	Étude des systèmes de transmission et télécommunication.	36	Technologies de communication	\N	\N	t	2026-06-04 15:57:09.095+03	2026-06-04 15:57:09.095+03
192	498	Génie Logiciel	\N	Analyse, conception et développement d'applications.	36	Développement logiciel	\N	\N	t	2026-06-04 15:57:22.91+03	2026-06-04 15:57:22.91+03
193	498	Systèmes d'Information	\N	Administration des systèmes d'information d'entreprise.	36	Gestion des données et SI	\N	\N	t	2026-06-04 15:57:22.91+03	2026-06-04 15:57:22.91+03
194	498	Développement Web	\N	Création d'applications web et plateformes numériques.	36	Technologies Internet	\N	\N	t	2026-06-04 15:57:22.91+03	2026-06-04 15:57:22.91+03
195	500	Communication d'Entreprise	\N	Gestion de la communication des organisations.	36	Communication institutionnelle	\N	\N	t	2026-06-04 15:59:59.876+03	2026-06-04 15:59:59.876+03
196	500	Journalisme	\N	Techniques rédactionnelles, médias et communication numérique.	36	Médias et information	\N	\N	t	2026-06-04 15:59:59.876+03	2026-06-04 15:59:59.876+03
197	500	Relations Publiques	\N	Gestion de l'image et des relations avec les parties prenantes.	36	Communication externe	\N	\N	t	2026-06-04 15:59:59.876+03	2026-06-04 15:59:59.876+03
198	501	Commerce	\N	Vente, négociation et développement commercial.	36	Techniques commerciales	\N	\N	t	2026-06-04 16:01:36.782+03	2026-06-04 16:01:36.782+03
199	501	Management des Affaires	\N	Pilotage et développement des organisations.	36	Gestion stratégique	\N	\N	t	2026-06-04 16:01:36.782+03	2026-06-04 16:01:36.782+03
200	502	Études Économiques et de Gestion	\N	Formation en management, organisation et administration des entreprises.	36	Gestion d'entreprise	\N	\N	t	2026-06-04 16:03:49.696+03	2026-06-04 16:03:49.696+03
203	503	Droit Public	\N	Institutions publiques, droit administratif et collectivités territoriales.	36	Administration publique	\N	\N	t	2026-06-04 16:05:25.867+03	2026-06-04 16:05:25.867+03
204	504	Génie Logiciel	\N	Analyse, conception et développement d'applications.	36	Développement logiciel	\N	\N	t	2026-06-04 16:07:32.419+03	2026-06-04 16:07:32.419+03
205	504	Systèmes d'Information	\N	Administration des systèmes d'information d'entreprise.	36	Gestion des données et SI	\N	\N	t	2026-06-04 16:07:32.419+03	2026-06-04 16:07:32.419+03
206	504	Développement Web	\N	Création d'applications web et plateformes numériques.	36	Technologies Internet	\N	\N	t	2026-06-04 16:07:32.419+03	2026-06-04 16:07:32.419+03
207	505	Réseaux Informatiques	\N	Conception et gestion des infrastructures réseau.	36	Administration réseau	\N	\N	t	2026-06-04 16:08:54.998+03	2026-06-04 16:08:54.998+03
208	505	Télécommunications	\N	Étude des systèmes de transmission et télécommunication.	36	Technologies de communication	\N	\N	t	2026-06-04 16:08:54.998+03	2026-06-04 16:08:54.998+03
209	506	Communication d'Entreprise	\N	Gestion de la communication des organisations.	36	Communication institutionnelle	\N	\N	t	2026-06-04 16:10:47.033+03	2026-06-04 16:10:47.033+03
210	506	Journalisme	\N	Techniques rédactionnelles, médias et communication numérique.	36	Médias et information	\N	\N	t	2026-06-04 16:10:47.033+03	2026-06-04 16:10:47.033+03
211	506	Relations Publiques	\N	Gestion de l'image et des relations avec les parties prenantes.	36	Communication externe	\N	\N	t	2026-06-04 16:10:47.033+03	2026-06-04 16:10:47.033+03
212	507	Commerce	\N	Vente, négociation et développement commercial.	36	Techniques commerciales	\N	\N	t	2026-06-04 16:12:28.395+03	2026-06-04 16:12:28.395+03
213	507	Management des Affaires	\N	Pilotage et développement des organisations.	36	Gestion stratégique	\N	\N	t	2026-06-04 16:12:28.395+03	2026-06-04 16:12:28.395+03
214	508	Management des Entreprises	\N	Formation aux techniques de gestion, d'organisation et de pilotage des entreprises.	36	Management et organisation	\N	\N	t	2026-06-04 16:18:40.673+03	2026-06-04 16:18:40.673+03
215	508	Finance et Comptabilité	\N	Comptabilité, contrôle de gestion, audit et finance d'entreprise.	36	Gestion financière	\N	\N	t	2026-06-04 16:18:40.673+03	2026-06-04 16:18:40.673+03
216	508	Marketing et Commerce International	\N	Commerce international, marketing digital et développement commercial.	36	Marketing stratégique	\N	\N	t	2026-06-04 16:18:40.673+03	2026-06-04 16:18:40.673+03
217	509	Transit International	\N	Organisation des flux internationaux de marchandises.	36	Gestion des opérations d'import-export	\N	\N	t	2026-06-04 16:21:07.526+03	2026-06-04 16:21:07.526+03
218	509	Douane et Réglementation	\N	Maîtrise des réglementations douanières nationales et internationales.	36	Procédures douanières	\N	\N	t	2026-06-04 16:21:07.526+03	2026-06-04 16:21:07.526+03
219	509	Logistique et Supply Chain	\N	Gestion des chaînes d'approvisionnement et transport de marchandises.	36	Gestion logistique	\N	\N	t	2026-06-04 16:21:07.526+03	2026-06-04 16:21:07.526+03
220	510	Droit Privé	\N	Étude des relations juridiques entre particuliers et entreprises.	36	Droit civil et commercial	\N	\N	t	2026-06-04 16:23:15.586+03	2026-06-04 16:23:15.586+03
221	510	Droit Public	\N	Étude des institutions publiques et de l'administration.	36	Droit administratif	\N	\N	t	2026-06-04 16:23:15.586+03	2026-06-04 16:23:15.586+03
222	510	Techniques des Affaires	\N	Sécurisation juridique des activités commerciales et entrepreneuriales.	36	Juridique d'entreprise	\N	\N	t	2026-06-04 16:23:15.586+03	2026-06-04 16:23:15.586+03
223	511	Génie Logiciel	\N	Conception et développement d'applications informatiques.	36	Développement logiciel	\N	\N	t	2026-06-04 16:25:26.056+03	2026-06-04 16:25:26.056+03
224	511	Systèmes d'Information	\N	Administration des systèmes d'information et bases de données.	36	Gestion des données	\N	\N	t	2026-06-04 16:25:26.056+03	2026-06-04 16:25:26.056+03
225	511	Réseaux et Cybersécurité	\N	Gestion des réseaux et sécurité des systèmes informatiques.	36	Infrastructure informatique	\N	\N	t	2026-06-04 16:25:26.056+03	2026-06-04 16:25:26.056+03
226	512	Comptabilité	\N	Formation orientée vers la gestion comptable, l'analyse financière et le contrôle des opérations comptables.	36	Comptabilité générale et financière	\N	\N	t	2026-06-04 16:30:57.15+03	2026-06-04 16:30:57.15+03
227	512	Finance	\N	Formation en gestion financière, analyse des investissements et pilotage financier.	36	Finance d'entreprise	\N	\N	t	2026-06-04 16:30:57.15+03	2026-06-04 16:30:57.15+03
228	512	Commerce et Marketing	\N	Formation couvrant les techniques commerciales, le marketing et la relation client.	36	Marketing et développement commercial	\N	\N	t	2026-06-04 16:30:57.15+03	2026-06-04 16:30:57.15+03
229	512	Management des Organisations	\N	Formation en gestion des organisations, leadership et administration d'entreprise.	36	Management et administration	\N	\N	t	2026-06-04 16:30:57.15+03	2026-06-04 16:30:57.15+03
230	444	Infirmier Généraliste	\N	Formation couvrant les soins préventifs, curatifs et éducatifs auprès des patients en milieu hospitalier et communautaire.	36	Soins infirmiers polyvalents	\N	\N	t	2026-06-04 16:35:05.149+03	2026-06-04 16:35:05.149+03
231	444	Infirmier Hospitalier	\N	Prise en charge des patients dans les services médicaux, chirurgicaux et d'urgence.	36	Soins cliniques	\N	\N	t	2026-06-04 16:35:05.149+03	2026-06-04 16:35:05.149+03
232	408	Sage-femme	\N	Suivi de grossesse, accouchement, soins du nouveau-né et accompagnement des mères.	36	Santé maternelle	\N	\N	t	2026-06-04 16:36:06.456+03	2026-06-04 16:36:06.456+03
233	411	Promotion de la Santé	\N	Conception et mise en œuvre des programmes de promotion de la santé.	36	Prévention et éducation sanitaire	\N	\N	t	2026-06-04 16:41:20.18+03	2026-06-04 16:41:20.18+03
234	411	Nutrition Communautaire	\N	Prévention de la malnutrition et amélioration de l'état nutritionnel des populations.	36	Nutrition et santé publique	\N	\N	t	2026-06-04 16:41:20.18+03	2026-06-04 16:41:20.18+03
235	411	Gestion des Intrants de Santé	\N	Gestion des médicaments, vaccins et équipements médicaux.	36	Logistique sanitaire	\N	\N	t	2026-06-04 16:41:20.18+03	2026-06-04 16:41:20.18+03
236	411	Assainissement et Génie Sanitaire	\N	Gestion de l'eau, de l'assainissement et de l'hygiène publique.	36	Santé environnementale	\N	\N	t	2026-06-04 16:41:20.18+03	2026-06-04 16:41:20.18+03
237	411	Optométrie	\N	Prévention, dépistage et correction des troubles visuels.	36	Santé visuelle	\N	\N	t	2026-06-04 16:41:20.18+03	2026-06-04 16:41:20.18+03
238	513	Sciences Infirmières	\N	Formation des professionnels infirmiers pour les soins hospitaliers et communautaires.	36	Soins infirmiers	\N	\N	t	2026-06-04 16:42:41.107+03	2026-06-04 16:42:41.107+03
239	514	Management en Santé	\N	Organisation, planification et gestion des services de santé.	24	Gestion des systèmes de santé	\N	\N	t	2026-06-04 16:44:36.429+03	2026-06-04 16:44:36.429+03
240	514	Administration Hospitalière	\N	Administration et pilotage des établissements de santé.	24	Gestion hospitalière	\N	\N	t	2026-06-04 16:44:36.429+03	2026-06-04 16:44:36.429+03
241	514	Cadre de Santé	\N	Formation des responsables et superviseurs du secteur sanitaire.	24	Encadrement des professionnels de santé	\N	\N	t	2026-06-04 16:44:36.429+03	2026-06-04 16:44:36.429+03
242	515	Anesthésie-Réanimation	\N	Prise en charge anesthésique et réanimation des patients.	24	Soins critiques	\N	\N	t	2026-06-04 16:46:39.022+03	2026-06-04 16:46:39.022+03
243	515	Gestion des Urgences et Catastrophes	\N	Gestion des crises sanitaires et des situations d'urgence.	24	Médecine d'urgence	\N	\N	t	2026-06-04 16:46:39.022+03	2026-06-04 16:46:39.022+03
244	515	Soins Ophtalmiques	\N	Prévention et prise en charge des pathologies oculaires.	24	Santé oculaire	\N	\N	t	2026-06-04 16:46:39.022+03	2026-06-04 16:46:39.022+03
245	314	Comptabilité	\N	Recherche avancée en normes comptables, reporting financier, comptabilité internationale et gouvernance.	60	Recherche en comptabilité	\N	\N	t	2026-06-04 16:51:02.26+03	2026-06-04 16:51:02.26+03
246	314	Audit et Contrôle de Gestion	\N	Recherche sur les systèmes de contrôle interne, l'audit financier et la performance organisationnelle.	60	Audit organisationnel	\N	\N	t	2026-06-04 16:51:02.26+03	2026-06-04 16:51:02.26+03
247	314	Finance d'Entreprise	\N	Étude des décisions financières, de la création de valeur et de la gestion des risques.	60	Finance et investissement	\N	\N	t	2026-06-04 16:51:02.26+03	2026-06-04 16:51:02.26+03
248	314	Finance de Marché	\N	Recherche sur les marchés financiers, les produits financiers et l'analyse des investissements.	60	Marchés financiers	\N	\N	t	2026-06-04 16:51:02.26+03	2026-06-04 16:51:02.26+03
249	314	Gouvernance et Performance des Organisations	\N	Analyse des mécanismes de gouvernance, de responsabilité et de performance institutionnelle.	60	Gouvernance d'entreprise	\N	\N	t	2026-06-04 16:51:02.26+03	2026-06-04 16:51:02.26+03
255	322	Biotechnologies et Valorisation des Ressources Naturelles	\N	Valorisation des ressources biologiques (plantes, micro-organismes, substances naturelles) à des fins médicales ou industrielles.	60	Biotechnologie environnementale	\N	\N	t	2026-06-04 17:01:02.315+03	2026-06-04 17:01:02.315+03
256	322	Biodiversité et Conservation des Écosystèmes	\N	Recherche sur la conservation des espèces, la protection des habitats naturels et la gestion durable des écosystèmes tropicaux.	60	Gestion de la biodiversité	\N	\N	t	2026-06-04 17:01:02.315+03	2026-06-04 17:01:02.315+03
257	322	Sciences Marines et Littorales	\N	Recherche sur les écosystèmes marins, récifs coralliens, ressources halieutiques et dynamique côtière.	60	Environnement marin	\N	\N	t	2026-06-04 17:01:02.315+03	2026-06-04 17:01:02.315+03
258	322	Écologie et Environnement Tropical	\N	Étude du fonctionnement des écosystèmes tropicaux terrestres et marins, et de leur résilience face aux changements climatiques.	60	Écologie des systèmes tropicaux	\N	\N	t	2026-06-04 17:01:02.315+03	2026-06-04 17:01:02.315+03
259	322	Gestion des Ressources Naturelles	\N	Analyse et gestion durable des ressources naturelles (forêts, eau, sols, biodiversité).	60	Développement durable	\N	\N	t	2026-06-04 17:01:02.315+03	2026-06-04 17:01:02.315+03
260	13	Systèmes d'Information	\N	Conception, administration et sécurisation des systèmes d'information	36	Gestion des systèmes d'information	\N	\N	t	2026-06-05 11:44:17.313+03	2026-06-05 11:44:17.313+03
261	13	Développement Logiciel	\N	Conception et développement d'applications professionnelles	36	Génie logiciel	\N	\N	t	2026-06-05 11:44:17.313+03	2026-06-05 11:44:17.313+03
262	13	Informatique Appliquée	\N	Formation orientée vers les solutions informatiques pour les entreprises.	36	Technologies numériques	\N	\N	t	2026-06-05 11:44:17.313+03	2026-06-05 11:44:17.313+03
263	516	Comptabilité Générale	\N	Comptabilité financière et gestion des opérations comptables	36	Gestion comptable	\N	\N	t	2026-06-05 11:46:08.891+03	2026-06-05 11:46:08.891+03
264	516	Audit et Contrôle	\N	Contrôle des comptes et analyse financière.	36	Audit financier	\N	\N	t	2026-06-05 11:46:08.891+03	2026-06-05 11:46:08.891+03
265	516	Expertise Comptable	\N	Préparation aux diplômes de la filière INTEC du CNAM.	60	Expertise comptable	\N	\N	t	2026-06-05 11:46:08.891+03	2026-06-05 11:46:08.891+03
266	517	Management des Organisations	\N	Organisation et pilotage des entreprises.	36	Gestion d'entreprise	\N	\N	t	2026-06-05 11:48:37.001+03	2026-06-05 11:48:37.001+03
267	517	Ressources Humaines	\N	Recrutement, administration du personnel et développement RH.	36	Gestion RH	\N	\N	t	2026-06-05 11:48:37.001+03	2026-06-05 11:48:37.001+03
268	517	Management International	\N	Gestion des organisations dans un contexte international.	60	Management stratégique	\N	\N	t	2026-06-05 11:48:37.001+03	2026-06-05 11:48:37.001+03
269	518	Ingénierie du Bâtiment	\N	Étude des bâtiments et infrastructures.	60	Construction	\N	\N	t	2026-06-05 11:50:30.546+03	2026-06-05 11:50:30.546+03
270	518	Travaux Publics	\N	Conception et réalisation d'ouvrages publics.	60	Génie civil	\N	\N	t	2026-06-05 11:50:30.546+03	2026-06-05 11:50:30.546+03
271	518	Géotechnique	\N	Analyse des sols et fondations des ouvrages.	60	Étude des sols	\N	\N	t	2026-06-05 11:50:30.546+03	2026-06-05 11:50:30.546+03
272	519	Énergie et Développement Durable	\N	Gestion des systèmes énergétiques durables	36	Transition énergétique	\N	\N	t	2026-06-05 11:52:07.217+03	2026-06-05 11:52:07.217+03
273	519	Aménagement et Environnement	\N	Aménagement du territoire et protection de l'environnement.	36	Gestion environnementale	\N	\N	t	2026-06-05 11:52:07.217+03	2026-06-05 11:52:07.217+03
274	519	Management Environnemental	\N	Gestion des projets environnementaux et développement durable.	36	Développement durable	\N	\N	t	2026-06-05 11:52:07.217+03	2026-06-05 11:52:07.217+03
275	319	Droit Public	\N	Recherche sur le droit constitutionnel, administratif, fiscal et les collectivités territoriales	60	Administration publique et institutions	\N	\N	t	2026-06-05 11:56:56.606+03	2026-06-05 11:56:56.606+03
276	319	Droit Privé et Sciences des Affaires	\N	Étude des relations juridiques entre personnes physiques, entreprises et organisations.	60	Droit civil et commercial	\N	\N	t	2026-06-05 11:56:56.606+03	2026-06-05 11:56:56.606+03
277	319	Droit International et Relations Internationales	\N	Recherche sur le droit international, l'intégration régionale et les relations entre États.	60	Coopération internationale	\N	\N	t	2026-06-05 11:56:56.606+03	2026-06-05 11:56:56.606+03
278	319	Sciences Politiques et Gouvernance	\N	Analyse des systèmes politiques, de la gouvernance et des politiques publiques.	60	Gouvernance publique	\N	\N	t	2026-06-05 11:56:56.606+03	2026-06-05 11:56:56.606+03
279	319	Droits Humains et Développement	\N	Recherche sur les droits humains, le développement durable et la justice sociale	60	Protection des droits fondamentaux	\N	\N	t	2026-06-05 11:56:56.606+03	2026-06-05 11:56:56.606+03
280	317	Géographie Humaine et Développement Territorial	\N	Recherche sur les dynamiques démographiques, économiques et sociales des territoires	60	Organisation des territoires	\N	\N	t	2026-06-05 12:01:35.942+03	2026-06-05 12:01:35.942+03
281	317	Aménagement du Territoire et Urbanisme	\N	Étude de l'organisation des espaces urbains et ruraux, de la planification et des politiques d'aménagement.	60	Planification territoriale	\N	\N	t	2026-06-05 12:01:35.942+03	2026-06-05 12:01:35.942+03
282	317	Environnement et Gestion Durable des Ressources	\N	Recherche sur la gestion des ressources naturelles, les risques environnementaux et l'adaptation aux changements climatiques	60	Développement durable	\N	\N	t	2026-06-05 12:01:35.942+03	2026-06-05 12:01:35.942+03
283	317	Géomatique et Systèmes d'Information Géographique	\N	Utilisation des SIG, de la télédétection et des outils géospatiaux pour l'étude des territoires.	60	Analyse spatiale	\N	\N	t	2026-06-05 12:01:35.942+03	2026-06-05 12:01:35.942+03
284	317	Population, Mobilité et Cadres de Vie	\N	Analyse des migrations, de la mobilité, de l'habitat et des transformations des cadres de vie.	60	Dynamiques socio-spatiales	\N	\N	t	2026-06-05 12:01:35.942+03	2026-06-05 12:01:35.942+03
285	303	Écologie et Biodiversité	\N	Recherche sur la biodiversité, la dynamique des populations animales et végétales, et la conservation des habitats naturels	60	Conservation des écosystèmes	\N	\N	t	2026-06-05 12:06:08.504+03	2026-06-05 12:06:08.504+03
286	303	Gestion Durable des Ressources Naturelles	\N	Étude de la gestion durable des forêts, des sols, de l'eau et des ressources biologiques.	60	Ressources naturelles	\N	\N	t	2026-06-05 12:06:08.504+03	2026-06-05 12:06:08.504+03
287	303	Changements Climatiques et Développement Durable	\N	Analyse des impacts du changement climatique et élaboration de stratégies d'adaptation et d'atténuation.	60	Adaptation climatique	\N	\N	t	2026-06-05 12:06:08.504+03	2026-06-05 12:06:08.504+03
288	303	Pollution et Qualité de l'Environnement	\N	Recherche sur la pollution de l'air, de l'eau et des sols ainsi que sur les méthodes de contrôle environnemental.	60	Gestion environnementale	\N	\N	t	2026-06-05 12:06:08.504+03	2026-06-05 12:06:08.504+03
289	303	Environnement et Développement Territorial	\N	Étude des interactions entre environnement, développement économique et aménagement du territoire.	60	Aménagement durable	\N	\N	t	2026-06-05 12:06:08.504+03	2026-06-05 12:06:08.504+03
290	315	Gestion Durable des Ressources Naturelles	\N	Recherche sur l'exploitation durable des ressources forestières, hydriques et biologiques	60	Gestion des ressources renouvelables	\N	\N	t	2026-06-05 13:22:18.635+03	2026-06-05 13:22:18.635+03
291	315	Biodiversité et Conservation	\N	Étude de la biodiversité malgache, des espèces endémiques et des stratégies de conservation.	60	Conservation des écosystèmes	\N	\N	t	2026-06-05 13:22:18.635+03	2026-06-05 13:22:18.635+03
292	315	Écologie et Fonctionnement des Écosystèmes	\N	Analyse des interactions entre organismes vivants et environnement	60	Écologie appliquée	\N	\N	t	2026-06-05 13:22:18.635+03	2026-06-05 13:22:18.635+03
293	315	Changements Climatiques et Développement Durable	\N	Recherche sur les impacts du changement climatique et les solutions durables	60	Adaptation et résilience climatique	\N	\N	t	2026-06-05 13:22:18.635+03	2026-06-05 13:22:18.635+03
294	315	Gestion de l'Eau, des Sols et des Ressources Naturelles	\N	Étude de la préservation des ressources en eau, des sols et des bassins versants.	60	Ressources environnementales	\N	\N	t	2026-06-05 13:22:18.635+03	2026-06-05 13:22:18.635+03
295	318	Gouvernance et Développement Territorial	\N	Recherche sur les politiques publiques, la gouvernance territoriale et le développement local dans les sociétés de l'océan Indien.	60	Gouvernance locale et régionale	\N	\N	t	2026-06-05 13:27:28.808+03	2026-06-05 13:27:28.808+03
296	318	Environnement et Développement Durable	\N	Étude des interactions entre environnement, ressources naturelles et développement durable	60	Gestion environnementale	\N	\N	t	2026-06-05 13:27:28.808+03	2026-06-05 13:27:28.808+03
297	318	Sécurité et Gestion des Risques	\N	Analyse des risques naturels, sociaux, économiques et sécuritaires affectant les territoires insulaires.	60	Sécurité humaine et territoriale	\N	\N	t	2026-06-05 13:27:28.808+03	2026-06-05 13:27:28.808+03
298	318	Relations Internationales et Coopération Régionale	\N	Recherche sur les relations diplomatiques, la coopération régionale et l'intégration dans l'océan Indien.	60	Espace indianocéanique	\N	\N	t	2026-06-05 13:27:28.808+03	2026-06-05 13:27:28.808+03
299	318	Dynamiques Sociales et Culturelles	\N	Étude des mutations culturelles, identitaires et sociales dans les sociétés indianocéaniques.	60	Sociétés et transformations sociales	\N	\N	t	2026-06-05 13:27:28.808+03	2026-06-05 13:27:28.808+03
300	320	Géochimie Appliquée	\N	Étude de la composition chimique des sols, des roches, des eaux et des ressources minérales. Cette thématique est cohérente avec l'intitulé officiel GEOCHIMED.	60	Géochimie environnementale et minérale	\N	\N	t	2026-06-05 13:31:42.711+03	2026-06-05 13:31:42.711+03
301	320	Chimie Médicinale	\N	Recherche sur les substances naturelles et synthétiques à potentiel thérapeutique.	60	Conception et étude de molécules bioactives	\N	\N	t	2026-06-05 13:31:42.711+03	2026-06-05 13:31:42.711+03
302	320	Valorisation des Ressources Naturelles	\N	Étude et valorisation des ressources végétales, minérales et biologiques de Madagascar	60	Produits naturels et substances bioactives	\N	\N	t	2026-06-05 13:31:42.711+03	2026-06-05 13:31:42.711+03
303	320	Chimie Analytique et Contrôle Qualité	\N	Développement et application des techniques d'analyse chimique pour la recherche et l'industrie.	60	Analyse chimique avancée	\N	\N	t	2026-06-05 13:31:42.711+03	2026-06-05 13:31:42.711+03
304	320	Pharmacochimie et Substances Naturelles	\N	Identification, extraction et caractérisation de composés d'intérêt médical issus de la biodiversité.	60	Recherche pharmaceutique	\N	\N	t	2026-06-05 13:31:42.711+03	2026-06-05 13:31:42.711+03
305	312	Écologie et Biodiversité	\N	Recherche sur les écosystèmes, les espèces, les changements environnementaux et la conservation de la biodiversité	60	Conservation et biodiversité	\N	\N	t	2026-06-05 13:36:18.741+03	2026-06-05 13:36:18.741+03
306	312	Économie et Politique des Ressources Naturelles	\N	Étude de la gouvernance des ressources naturelles, des aires protégées, des politiques environnementales et du développement durable	60	Gouvernance environnementale	\N	\N	t	2026-06-05 13:36:18.741+03	2026-06-05 13:36:18.741+03
307	312	Gestion des Forêts et des Ressources Naturelles	\N	Recherche sur l'aménagement forestier, la sylviculture tropicale, la restauration des paysages forestiers et la gestion de l'eau et des sols.	60	Foresterie et gestion durable	\N	\N	t	2026-06-05 13:36:18.741+03	2026-06-05 13:36:18.741+03
308	312	Agro-Management et Développement Durable des Territoires	\N	Analyse des politiques publiques, du développement rural, de l'économie agricole et du management territorial	60	Développement territorial	\N	\N	t	2026-06-05 13:36:18.741+03	2026-06-05 13:36:18.741+03
309	312	Sciences Expérimentales et Valorisation des Ressources Naturelles	\N	Recherche appliquée sur les ressources biologiques, agricoles et naturelles ainsi que leur valorisation scientifique et économique	60	Valorisation des ressources naturelles	\N	\N	t	2026-06-05 13:36:18.741+03	2026-06-05 13:36:18.741+03
310	316	Réseaux, Intelligence Artificielle, Multimédia, Sécurité et Systèmes d'Information (RIMMS)	\N	Recherche en intelligence artificielle, cybersécurité, systèmes d'information, multimédia et réseaux informatiques. Cette équipe d'accueil est explicitement mentionnée dans l'ED-STII	60	Informatique avancée et IA	\N	\N	t	2026-06-05 13:41:18.29+03	2026-06-05 13:41:18.29+03
311	316	Sciences Cognitives et Applications (SCA)	\N	Recherche sur les systèmes intelligents, l'apprentissage, l'interaction homme-machine et les applications des sciences cognitives.	60	IA et sciences cognitives	\N	\N	t	2026-06-05 13:41:18.29+03	2026-06-05 13:41:18.29+03
312	316	Systèmes Embarqués, Instrumentation et Modélisation des Systèmes Électroniques (SE-I-MSDE)	\N	Développement de systèmes embarqués, électronique avancée, instrumentation et modélisation.	60	Systèmes embarqués	\N	\N	t	2026-06-05 13:41:18.29+03	2026-06-05 13:41:18.29+03
313	316	Télécommunication, Automatique, Signal et Images (TASI)	\N	Recherche en télécommunications, traitement d'images, automatique et systèmes numériques.	60	Télécommunications et traitement du signal	\N	\N	t	2026-06-05 13:41:18.29+03	2026-06-05 13:41:18.29+03
314	316	Sciences et Techniques de l'Information et de la Communication (STIC)	\N	Recherche sur les infrastructures numériques, les systèmes d'information et les technologies de communication	60	Technologies de l'information	\N	\N	t	2026-06-05 13:41:18.29+03	2026-06-05 13:41:18.29+03
315	305	Géosciences et Ressources Minérales	\N	Recherche sur la géologie, la cartographie géologique, les ressources minérales et les processus géodynamiques	60	Géologie et ressources naturelles	\N	\N	t	2026-06-05 13:45:12.2+03	2026-06-05 13:45:12.2+03
316	305	Génie des Matériaux	\N	Étude, caractérisation et développement de nouveaux matériaux pour l'industrie et la construction.	60	Science et technologie des matériaux	\N	\N	t	2026-06-05 13:45:12.2+03	2026-06-05 13:45:12.2+03
317	305	Énergie et Procédés Industriels	\N	Recherche sur les systèmes énergétiques, les énergies renouvelables et les procédés industriels.	60	Génie énergétique	\N	\N	t	2026-06-05 13:45:12.2+03	2026-06-05 13:45:12.2+03
318	305	Génie Civil et Infrastructures	\N	Étude des ouvrages, infrastructures, géotechnique et développement territorial	60	Construction et aménagement	\N	\N	t	2026-06-05 13:45:12.2+03	2026-06-05 13:45:12.2+03
319	305	Ingénierie des Systèmes et Innovation Technologique	\N	Recherche sur les systèmes complexes, l'optimisation, l'innovation technologique et les applications industrielles.	60	Innovation et technologies appliquées	\N	\N	t	2026-06-05 13:45:12.2+03	2026-06-05 13:45:12.2+03
320	323	Linguistique et Sciences du Langage	\N	Étude des structures linguistiques, de la sociolinguistique et des usages du langage dans la société.	60	Analyse des langues et communication	\N	\N	t	2026-06-05 13:49:28.841+03	2026-06-05 13:49:28.841+03
321	323	Littérature et Études Culturelles	\N	Recherche sur les œuvres littéraires, les courants culturels et les productions artistiques	60	Analyse littéraire et culturelle	\N	\N	t	2026-06-05 13:49:28.841+03	2026-06-05 13:49:28.841+03
322	323	Histoire et Civilisations	\N	Étude des périodes historiques, des sociétés anciennes et contemporaines, et des dynamiques de civilisation.	60	Recherche historique	\N	\N	t	2026-06-05 13:49:28.841+03	2026-06-05 13:49:28.841+03
323	323	Philosophie et Pensée Critique	\N	Analyse des systèmes de pensée, de l’éthique, de la politique et des fondements de la connaissance.	60	Philosophie générale et appliquée	\N	\N	t	2026-06-05 13:49:28.841+03	2026-06-05 13:49:28.841+03
324	323	Communication, Médias et Interactions Sociales	\N	Étude des médias, des interactions sociales, de la communication institutionnelle et numérique.	60	Sciences de la communication	\N	\N	t	2026-06-05 13:49:28.841+03	2026-06-05 13:49:28.841+03
329	309	Modélisation Mathématique	\N	Développement de modèles mathématiques appliqués à la physique, la biologie, l'économie et l'environnement	60	Modèles et simulation	\N	\N	t	2026-06-06 12:16:19.301+03	2026-06-06 12:16:19.301+03
330	309	Recherche Opérationnelle et Optimisation	\N	Étude des méthodes d'optimisation, de planification, de logistique et de gestion des systèmes complexes	60	Aide à la décision	\N	\N	t	2026-06-06 12:16:19.301+03	2026-06-06 12:16:19.301+03
331	309	Statistique et Probabilités	\N	Recherche en statistiques avancées, probabilités, science des données et analyse quantitative.	60	Analyse des données	\N	\N	t	2026-06-06 12:16:19.301+03	2026-06-06 12:16:19.301+03
332	309	Analyse Numérique et Calcul Scientifique	\N	Développement d'algorithmes et de méthodes de résolution numérique pour les problèmes scientifiques et industriels	60	Méthodes numériques	\N	\N	t	2026-06-06 12:16:19.301+03	2026-06-06 12:16:19.301+03
333	309	Mathématiques Fondamentales et Applications	\N	Recherche en mathématiques fondamentales avec applications aux sciences et aux technologies.	60	Algèbre, analyse et géométrie	\N	\N	t	2026-06-06 12:16:19.301+03	2026-06-06 12:16:19.301+03
334	308	Physique des Matériaux	\N	Recherche sur les propriétés physiques, mécaniques et électroniques des matériaux destinés aux applications industrielles et technologiques.	60	Matériaux avancés	\N	\N	t	2026-06-06 12:22:57.069+03	2026-06-06 12:22:57.069+03
335	308	Énergie et Énergies Renouvelables	\N	Physique de l'Environnement et Climat	60	Systèmes énergétiques	\N	\N	t	2026-06-06 12:22:57.069+03	2026-06-06 12:22:57.069+03
336	308	Physique de l'Environnement et Climat	\N	Analyse des phénomènes atmosphériques, climatiques et environnementaux à l'aide d'outils de modélisation physique	60	Physique environnementale	\N	\N	t	2026-06-06 12:22:57.069+03	2026-06-06 12:22:57.069+03
337	308	Électronique, Instrumentation et Mesures Physiques	\N	Développement de systèmes de mesure, de capteurs et d'instruments utilisés dans la recherche et l'industrie.	60	Instrumentation scientifique	\N	\N	t	2026-06-06 12:22:57.069+03	2026-06-06 12:22:57.069+03
338	308	Modélisation et Physique Théorique	\N	Recherche en physique théorique, simulation numérique et modélisation mathématique des systèmes complexes.	60	Modélisation des phénomènes physiques	\N	\N	t	2026-06-06 12:22:57.069+03	2026-06-06 12:22:57.069+03
339	302	Sciences de l'Éducation et Formation	\N	Recherche sur les systèmes éducatifs, les méthodes pédagogiques, la formation professionnelle et les politiques éducatives.	60	Éducation et pédagogie	\N	\N	t	2026-06-06 12:50:23.39+03	2026-06-06 12:50:23.39+03
340	302	Développement Local et Territorial	\N	Étude des dynamiques territoriales, du développement rural, de la gouvernance locale et de l'aménagement du territoire	60	Développement socio-économique	\N	\N	t	2026-06-06 12:50:23.39+03	2026-06-06 12:50:23.39+03
341	302	Société, Culture et Identités	\N	Analyse des phénomènes sociaux, culturels, identitaires et des transformations des sociétés contemporaines	60	Anthropologie et sociologie	\N	\N	t	2026-06-06 12:50:23.39+03	2026-06-06 12:50:23.39+03
342	302	Économie, Gestion et Développement	\N	Recherche sur les politiques économiques, le développement durable, l'entrepreneuriat et la gestion des organisations	60	Économie du développement	\N	\N	t	2026-06-06 12:50:23.39+03	2026-06-06 12:50:23.39+03
343	302	Communication, Langues et Médiation Sociale	\N	Étude des pratiques communicationnelles, des langues, des médias et des mécanismes de médiation sociale.	60	Communication et interculturalité	\N	\N	t	2026-06-06 12:50:23.39+03	2026-06-06 12:50:23.39+03
348	304	Production Végétale et Agronomie	\N	Recherche sur les systèmes de culture, l'amélioration des productions agricoles, l'agroécologie et la gestion durable des sols.	60	Agriculture durable	\N	\N	t	2026-06-06 12:55:07.706+03	2026-06-06 12:55:07.706+03
349	304	Sciences Animales et Élevage	\N	Étude de la nutrition animale, de la santé animale, de l'amélioration génétique et des systèmes d'élevage	60	Production animale	\N	\N	t	2026-06-06 12:55:07.706+03	2026-06-06 12:55:07.706+03
350	304	Sciences et Technologies Alimentaires	\N	Recherche sur la conservation, la transformation, la qualité et la valorisation des produits agricoles et alimentaires	60	Transformation agroalimentaire	\N	\N	t	2026-06-06 12:55:07.706+03	2026-06-06 12:55:07.706+03
351	304	Nutrition et Sécurité Alimentaire	\N	Analyse de la qualité nutritionnelle des aliments, de la sécurité alimentaire et des stratégies de lutte contre la malnutrition	60	Nutrition humaine	\N	\N	t	2026-06-06 12:55:07.706+03	2026-06-06 12:55:07.706+03
352	304	Valorisation des Ressources Agricoles	\N	Développement de nouvelles technologies et valorisation des ressources agricoles locales pour l'industrie et le développement durable.	60	Innovation agroalimentaire	\N	\N	t	2026-06-06 12:55:07.706+03	2026-06-06 12:55:07.706+03
353	313	Sciences Juridiques	\N	Recherche en droit, institutions, gouvernance et politiques publiques	60	Droit public et privé	\N	\N	t	2026-06-06 13:00:40.752+03	2026-06-06 13:00:40.752+03
354	313	Sciences Économiques	\N	Étude des politiques économiques, de la croissance, du développement et des systèmes économiques.	60	Économie du développement	\N	\N	t	2026-06-06 13:00:40.752+03	2026-06-06 13:00:40.752+03
355	313	Dynamique des Organisations, Gestion et Management (DYOGM)	\N	Recherche sur les organisations, le management, la gouvernance et la stratégie	60	Gestion et management	\N	\N	t	2026-06-06 13:00:40.752+03	2026-06-06 13:00:40.752+03
356	313	Rouages des Sociétés et Développement	\N	Analyse des transformations sociales, du développement humain et des dynamiques communautaires	60	Sociologie et développement	\N	\N	t	2026-06-06 13:00:40.752+03	2026-06-06 13:00:40.752+03
357	313	Cultures, Comportements et Humanité	\N	Étude des comportements humains, des cultures et des identités sociales	60	Anthropologie et psychologie sociale	\N	\N	t	2026-06-06 13:00:40.752+03	2026-06-06 13:00:40.752+03
358	313	Espaces et Sociétés	\N	Recherche sur les territoires, les mobilités, l'environnement et l'organisation des espaces	60	Géographie et aménagement	\N	\N	t	2026-06-06 13:00:40.752+03	2026-06-06 13:00:40.752+03
359	313	Sociétés, Arts et Cultures du Sud-Ouest de l'Océan Indien	\N	Valorisation des patrimoines, des arts et des dynamiques culturelles de l'océan Indien	60	Patrimoine et cultures régionales	\N	\N	t	2026-06-06 13:00:40.752+03	2026-06-06 13:00:40.752+03
360	313	Questions de Valeurs dans la Production de Sens	\N	Recherche en philosophie, éthique, épistémologie et production des savoirs.	60	Philosophie et éthique	\N	\N	t	2026-06-06 13:00:40.752+03	2026-06-06 13:00:40.752+03
361	520	Sciences Juridiques et Politiques	\N	Recherche en droit public, droit privé, science politique, gouvernance et institutions publiques.	60	Droit et gouvernance	\N	\N	t	2026-06-06 13:06:36.282+03	2026-06-06 13:06:36.282+03
362	520	Économie et Management	\N	Recherche en économie, management, gouvernance des organisations et développement économique.	60	Économie du développement et gestion	\N	\N	t	2026-06-06 13:06:36.282+03	2026-06-06 13:06:36.282+03
363	520	Sociologie, Population et Développement	\N	Étude des dynamiques démographiques, du développement humain, de la sociologie et des politiques sociales	60	Sciences sociales appliquées	\N	\N	t	2026-06-06 13:06:36.282+03	2026-06-06 13:06:36.282+03
364	520	Sciences Humaines	\N	Recherche sur les cultures, les comportements humains, l'éthique, la philosophie et les transformations sociales	60	Philosophie, psychologie et anthropologie	\N	\N	t	2026-06-06 13:06:36.282+03	2026-06-06 13:06:36.282+03
365	520	Travail Social et Développement Humain	\N	Recherche sur l'accompagnement social, les politiques publiques, l'inclusion sociale et le développement humain	60	Intervention sociale	\N	\N	t	2026-06-06 13:06:36.282+03	2026-06-06 13:06:36.282+03
366	321	Océanographie et Environnement Marin	\N	Recherche sur les phénomènes océaniques, la dynamique côtière, la qualité des eaux marines et les changements environnementaux	60	Sciences de l'océan	\N	\N	t	2026-06-06 13:10:17.048+03	2026-06-06 13:10:17.048+03
367	321	Ressources Halieutiques et Pêche Durable	\N	Étude des stocks de poissons, de la pêche durable et de la gestion des ressources marines exploitables.	60	Gestion des ressources halieutiques	\N	\N	t	2026-06-06 13:10:17.048+03	2026-06-06 13:10:17.048+03
368	321	Aquaculture et Production Aquatique	\N	Recherche sur les techniques d'élevage aquatique, la production durable et la valorisation des produits aquacoles	60	Aquaculture marine	\N	\N	t	2026-06-06 13:10:17.048+03	2026-06-06 13:10:17.048+03
369	321	Biodiversité et Conservation Marine	\N	Étude de la biodiversité marine, des récifs coralliens, des mangroves et des stratégies de conservation.	60	Conservation des écosystèmes marins	\N	\N	t	2026-06-06 13:10:17.048+03	2026-06-06 13:10:17.048+03
370	321	Valorisation des Ressources Marines	\N	Recherche sur la valorisation des organismes marins dans les domaines alimentaire, pharmaceutique et industriel	60	Biotechnologies marines	\N	\N	t	2026-06-06 13:10:17.048+03	2026-06-06 13:10:17.048+03
371	306	Intelligence Artificielle et Science des Données	\N	Recherche sur l'intelligence artificielle, l'apprentissage automatique, l'analyse de données massives et les systèmes intelligents	60	IA, Machine Learning et Big Data	\N	\N	t	2026-06-06 13:14:13.368+03	2026-06-06 13:14:13.368+03
372	306	Systèmes d'Information et Génie Logiciel	\N	Étude des systèmes d'information, du développement logiciel, de l'ingénierie des applications et de la transformation numérique	60	Architecture logicielle et systèmes d'information	\N	\N	t	2026-06-06 13:14:13.368+03	2026-06-06 13:14:13.368+03
373	306	Réseaux et Télécommunications	\N	Recherche sur les réseaux informatiques, les télécommunications, l'Internet des objets (IoT) et les technologies de communication	60	Infrastructures numériques	\N	\N	t	2026-06-06 13:14:13.368+03	2026-06-06 13:14:13.368+03
374	306	Cybersécurité et Sûreté Numérique	\N	Recherche sur la protection des infrastructures numériques, la sécurité informatique, la cryptographie et la résilience des systèmes	60	Sécurité des systèmes d'information	\N	\N	t	2026-06-06 13:14:13.368+03	2026-06-06 13:14:13.368+03
375	306	Technologies Multimédias et Communication Numérique	\N	Étude des technologies multimédias, de la communication numérique, des interfaces interactives et des contenus numériques.	60	Médias numériques et interaction homme-machine	\N	\N	t	2026-06-06 13:14:13.368+03	2026-06-06 13:14:13.368+03
376	521	Théologie Fondamentale	\N	Recherche sur les fondements de la foi, la révélation, les traditions religieuses et les grandes questions théologiques	60	Études théologiques avancées	\N	\N	t	2026-06-06 13:19:26.044+03	2026-06-06 13:19:26.044+03
377	521	Théologie Morale et Éthique	\N	Étude des enjeux éthiques contemporains liés à la société, à la politique, à l'économie, à la santé et à l'environnement	60	Éthique appliquée	\N	\N	t	2026-06-06 13:19:26.044+03	2026-06-06 13:19:26.044+03
378	521	Philosophie et Pensée Critique	\N	Recherche sur l'épistémologie, la métaphysique, la philosophie politique, l'éthique et l'histoire de la philosophie.	60	Philosophie générale	\N	\N	t	2026-06-06 13:19:26.044+03	2026-06-06 13:19:26.044+03
379	521	Sciences Religieuses et Dialogue Interculturel	\N	Analyse des traditions religieuses, du dialogue interreligieux et des interactions entre religion, culture et société	60	Études religieuses comparées	\N	\N	t	2026-06-06 13:19:26.044+03	2026-06-06 13:19:26.044+03
380	521	Doctrine Sociale et Développement Humain	\N	Recherche sur la justice sociale, les droits humains, le développement durable et la contribution des traditions religieuses au développement.	60	Développement humain intégral	\N	\N	t	2026-06-06 13:19:26.044+03	2026-06-06 13:19:26.044+03
381	522	Sciences de l'Environnement et Développement Durable	\N	Recherche sur les ressources naturelles, les changements climatiques, la conservation et le développement durable	60	Gestion environnementale	\N	\N	t	2026-06-06 13:22:54.341+03	2026-06-06 13:22:54.341+03
382	522	Sciences de la Santé	\N	Études avancées en santé publique, épidémiologie, nutrition et sciences biomédicales	60	Santé publique et biomédicale	\N	\N	t	2026-06-06 13:22:54.341+03	2026-06-06 13:22:54.341+03
383	522	Sciences Agronomiques et Alimentaires	\N	Recherche sur la production agricole, l'alimentation, la nutrition et les systèmes agroalimentaires.	60	Agriculture et sécurité alimentaire	\N	\N	t	2026-06-06 13:22:54.341+03	2026-06-06 13:22:54.341+03
384	522	Informatique et Technologies	\N	Recherche sur les systèmes informatiques, les technologies de l'information, l'intelligence artificielle et l'innovation numérique	60	Technologies numériques	\N	\N	t	2026-06-06 13:22:54.341+03	2026-06-06 13:22:54.341+03
385	522	Sciences Fondamentales	\N	Recherche fondamentale visant l'avancement des connaissances scientifiques et leurs applications.	60	Mathématiques, Physique et Chimie	\N	\N	t	2026-06-06 13:22:54.341+03	2026-06-06 13:22:54.341+03
386	307	Sciences du Végétal (SVEG)	\N	Recherche sur la biodiversité végétale, la conservation, l'agronomie et la valorisation des ressources végétales	60	Botanique, écologie végétale et ressources végétales	\N	\N	t	2026-06-09 06:37:24.903+03	2026-06-09 06:37:24.903+03
387	307	Zoologie et Anthropologie Biologique (ZAB)	\N	Étude de la biodiversité animale, de l'évolution et de l'anthropologie biologique.	60	Faune, biodiversité animale et anthropologie biologique	\N	\N	t	2026-06-09 06:37:24.903+03	2026-06-09 06:37:24.903+03
388	307	Biodiversité et Santé (BIOSAN)	\N	Recherche sur les interactions entre biodiversité, environnement et santé humaine	60	Santé environnementale et biodiversité	\N	\N	t	2026-06-09 06:37:24.903+03	2026-06-09 06:37:24.903+03
389	307	Sciences de l'Alimentation et Nutrition (SAN)	\N	Études sur la nutrition, l'alimentation, la sécurité alimentaire et la santé publique	60	Nutrition et sécurité alimentaire	\N	\N	t	2026-06-09 06:37:24.903+03	2026-06-09 06:37:24.903+03
390	307	Biotechnologies (BIOTEC)	\N	Développement de biotechnologies appliquées à l'environnement, à l'agriculture et à la santé.	60	Biotechnologies et valorisation des ressources naturelles	\N	\N	t	2026-06-09 06:37:24.903+03	2026-06-09 06:37:24.903+03
391	307	Pathogènes et Diversité Moléculaire (PDM)	\N	Recherche sur les agents pathogènes, la génétique et la diversité moléculaire	60	Microbiologie et biologie moléculaire	\N	\N	t	2026-06-09 06:37:24.903+03	2026-06-09 06:37:24.903+03
392	307	Immunologie, Immunopathologie et Immunodiagnostic	\N	Recherche sur les maladies infectieuses, les réponses immunitaires et les outils de diagnostic.	60	Immunologie et diagnostic biomédical	\N	\N	t	2026-06-09 06:37:24.903+03	2026-06-09 06:37:24.903+03
393	311	Santé Publique et Épidémiologie	\N	Recherche sur les politiques de santé, l'épidémiologie, la prévention et la promotion de la santé.	60	Santé communautaire	\N	\N	t	2026-06-09 06:42:14.617+03	2026-06-09 06:42:14.617+03
394	311	Biologie et Sciences du Vivant	\N	Étude des organismes vivants, de la biodiversité, de la physiologie et des mécanismes biologiques.	60	Biologie appliquée	\N	\N	t	2026-06-09 06:42:14.617+03	2026-06-09 06:42:14.617+03
395	311	Biomédecine et Sciences Cliniques	\N	Recherche sur les maladies humaines, les diagnostics, les traitements et les innovations médicales.	60	Recherche biomédicale	\N	\N	t	2026-06-09 06:42:14.617+03	2026-06-09 06:42:14.617+03
396	311	Microbiologie et Parasitologie	\N	Étude des bactéries, virus, parasites et maladies infectieuses, particulièrement en milieu tropical.	60	Agents pathogènes	\N	\N	t	2026-06-09 06:42:14.617+03	2026-06-09 06:42:14.617+03
397	311	Nutrition et Santé	\N	Recherche sur la nutrition, la sécurité alimentaire et la lutte contre la malnutrition	60	Nutrition humaine	\N	\N	t	2026-06-09 06:42:14.617+03	2026-06-09 06:42:14.617+03
398	311	Biotechnologies de la Santé	\N	Développement de technologies appliquées à la santé, au diagnostic et à la recherche biomédicale.	60	Innovation biomédicale	\N	\N	t	2026-06-09 06:42:14.617+03	2026-06-09 06:42:14.617+03
399	523	Sciences de l'Environnement Tropical	\N	Recherche sur la biodiversité, les écosystèmes tropicaux, les changements climatiques et la gestion durable des ressources naturelles	60	Gestion environnementale	\N	\N	t	2026-06-09 06:50:22.496+03	2026-06-09 06:50:22.496+03
400	523	Sciences Économiques et Développement	\N	Analyse des politiques économiques, du développement territorial et de la gouvernance économique.	60	Économie du développement	\N	\N	t	2026-06-09 06:50:22.496+03	2026-06-09 06:50:22.496+03
401	523	Gestion et Management	\N	Recherche sur la gestion des organisations, l'entrepreneuriat et le management stratégique.	60	Administration et stratégie	\N	\N	t	2026-06-09 06:50:22.496+03	2026-06-09 06:50:22.496+03
402	523	Sciences Sociales et Développement	\N	Étude des transformations sociales, du développement humain et des dynamiques communautaires.	60	Sociologie et développement	\N	\N	t	2026-06-09 06:50:22.496+03	2026-06-09 06:50:22.496+03
403	523	Technologies et Innovation	\N	Recherche sur les technologies émergentes, l'innovation et le développement industriel	60	Technologies appliquées	\N	\N	t	2026-06-09 06:50:22.496+03	2026-06-09 06:50:22.496+03
405	310	Gestion des Ressources Naturelles	\N	Recherche sur la gestion durable des ressources naturelles, la conservation et les politiques environnementales	60	Gestion durable des ressources	\N	\N	t	2026-06-09 06:55:03.373+03	2026-06-09 06:55:03.373+03
406	310	Biodiversité et Conservation	\N	Étude de la faune, de la flore, des écosystèmes et des stratégies de conservation	60	Conservation de la biodiversité	\N	\N	t	2026-06-09 06:55:03.373+03	2026-06-09 06:55:03.373+03
407	310	Foresterie et Ressources Forestières	\N	Recherche sur les ressources forestières, le reboisement et l'exploitation durable des forêts.	60	Gestion forestière	\N	\N	t	2026-06-09 06:55:03.373+03	2026-06-09 06:55:03.373+03
408	310	Agroécologie et Développement Rural	\N	Étude des systèmes agricoles durables et du développement des territoires ruraux	60	Agriculture durable	\N	\N	t	2026-06-09 06:55:03.373+03	2026-06-09 06:55:03.373+03
409	310	Biotechnologies et Valorisation des Produits Naturels	\N	Recherche sur la transformation et la valorisation des ressources biologiques pour des applications industrielles, pharmaceutiques et alimentaires.	60	Biotechnologies appliquées	\N	\N	t	2026-06-09 06:55:03.373+03	2026-06-09 06:55:03.373+03
410	310	Environnement et Développement Durable	\N	Recherche sur les impacts environnementaux, les changements climatiques et les stratégies de développement durable	60	Gestion environnementale	\N	\N	t	2026-06-09 06:55:03.373+03	2026-06-09 06:55:03.373+03
412	524	Commandement et Administration de la Police	\N	Formation des futurs commissaires chargés du commandement, de la gestion des unités de police, du maintien de l'ordre et de la sécurité publique	24	Direction des services de police	\N	\N	t	2026-06-09 07:08:36.23+03	2026-06-09 07:08:36.23+03
413	525	Commandement Opérationnel	\N	Formation destinée aux futurs officiers responsables de l'encadrement opérationnel, de la coordination des interventions et de l'application des politiques de sécurité publique	24	Gestion opérationnelle des unités	\N	\N	t	2026-06-09 07:11:06.854+03	2026-06-09 07:11:06.854+03
414	526	Sécurité Publique	\N	Renforcement des compétences des cadres de police en activité	24	Gestion des opérations de sécurité	\N	\N	t	2026-06-09 07:13:37.314+03	2026-06-09 07:13:37.314+03
415	526	Maintien de l'Ordre	\N	Formation spécialisée sur les interventions et la coordination des opérations de sécurité	24	Gestion des crises et interventions	\N	\N	t	2026-06-09 07:13:37.314+03	2026-06-09 07:13:37.314+03
416	16	Production Végétale	\N	Formation sur les systèmes de culture, les pratiques agricoles durables, la production végétale et l'accompagnement des producteurs agricoles	36	Agronomie et cultures	\N	\N	t	2026-06-09 07:19:05.273+03	2026-06-09 07:19:05.273+03
417	16	Production Animale	\N	Formation en élevage, nutrition animale, gestion des exploitations d'élevage et développement des filières animales	36	Élevage et zootechnie	\N	\N	t	2026-06-09 07:19:05.273+03	2026-06-09 07:19:05.273+03
418	16	Socio-Management Agricole	\N	Formation en gestion des exploitations agricoles, management rural, entrepreneuriat et développement territorial	36	Gestion et entrepreneuriat agricole	\N	\N	t	2026-06-09 07:19:05.273+03	2026-06-09 07:19:05.273+03
419	527	Production Végétale Avancée	\N	Formation d'ingénieurs agronomes spécialisés dans les systèmes de production végétale et l'innovation agricole	24	Ingénierie agronomique végétale	\N	\N	t	2026-06-09 07:23:15.135+03	2026-06-09 07:23:15.135+03
420	527	Production Animale Avancée	\N	Formation d'ingénieurs agronomes spécialisés dans la production animale et le développement des élevages	24	Ingénierie zootechnique	\N	\N	t	2026-06-09 07:23:15.135+03	2026-06-09 07:23:15.135+03
421	19	Bâtiment	\N	Formation en conception, réalisation et gestion des projets de construction, calcul des structures, métrés et suivi de chantier	36	Construction de bâtiments	\N	\N	t	2026-06-09 07:29:07.768+03	2026-06-09 07:29:07.768+03
422	19	Travaux Publics	\N	Formation orientée vers la voirie, l'assainissement, l'adduction d'eau, les ponts et les infrastructures publiques	36	Infrastructures et ouvrages publics	\N	\N	t	2026-06-09 07:29:07.768+03	2026-06-09 07:29:07.768+03
423	19	Topographie et Géomatique	\N	Formation aux relevés topographiques, à l'utilisation des stations totales, aux systèmes de mesure et à la cartographie	36	Géomètre-topographe	\N	\N	t	2026-06-09 07:29:07.768+03	2026-06-09 07:29:07.768+03
424	528	Ingénierie du Bâtiment	\N	Formation avancée en structures, organisation des chantiers et management des projets de construction.	24	Conception et gestion de projets de construction	\N	\N	t	2026-06-09 07:31:33.087+03	2026-06-09 07:31:33.087+03
425	528	Ingénierie des Travaux Publics	\N	Approfondissement des compétences en conception et réalisation d'infrastructures routières et hydrauliques.	24	Infrastructures et ouvrages d'art	\N	\N	t	2026-06-09 07:31:33.087+03	2026-06-09 07:31:33.087+03
426	20	Outils de Base de Gestion	\N	Formation aux fondamentaux de la gestion, de l'administration, de l'organisation des entreprises et du management	36	Gestion d'entreprise	\N	\N	t	2026-06-09 07:35:57.766+03	2026-06-09 07:35:57.766+03
427	20	Finances et Comptabilité	\N	Formation en comptabilité générale, comptabilité analytique, fiscalité, gestion financière et contrôle de gestion	36	Comptabilité et finance	\N	\N	t	2026-06-09 07:35:57.766+03	2026-06-09 07:35:57.766+03
428	23	Intervention Sociale	\N	Formation aux méthodes d'intervention auprès des familles, communautés et populations vulnérables	36	Accompagnement social	\N	\N	t	2026-06-09 07:41:48.465+03	2026-06-09 07:41:48.465+03
429	23	Développement Communautaire	\N	Conception et gestion de projets de développement social et communautaire	36	Développement local	\N	\N	t	2026-06-09 07:41:48.465+03	2026-06-09 07:41:48.465+03
430	23	Protection Sociale	\N	Formation sur les politiques sociales, la protection de l'enfance et l'insertion sociale	36	Inclusion et accompagnement	\N	\N	t	2026-06-09 07:41:48.465+03	2026-06-09 07:41:48.465+03
432	24	Management des Organisations	\N	Formation en management, organisation et administration des entreprises	36	Gestion d'entreprise	\N	\N	t	2026-06-09 07:43:52.257+03	2026-06-09 07:43:52.257+03
433	24	Gestion de Projets	\N	Conception, suivi et évaluation de projets de développement	36	Pilotage de projets	\N	\N	t	2026-06-09 07:43:52.257+03	2026-06-09 07:43:52.257+03
434	24	Entrepreneuriat	\N	Formation à la création, au financement et à la gestion d'activités économiques.	36	Création d'entreprise	\N	\N	t	2026-06-09 07:43:52.257+03	2026-06-09 07:43:52.257+03
435	22	Économie du Développement	\N	Analyse des politiques économiques et du développement territorial	36	Développement économique	\N	\N	t	2026-06-09 07:45:49.432+03	2026-06-09 07:45:49.432+03
436	22	Économie Sociale	\N	Étude des modèles économiques à impact social.	36	Économie solidaire	\N	\N	t	2026-06-09 07:45:49.432+03	2026-06-09 07:45:49.432+03
437	22	Analyse Économique	\N	Outils d'analyse statistique et économique appliqués au développement	36	Études économiques	\N	\N	t	2026-06-09 07:45:49.432+03	2026-06-09 07:45:49.432+03
438	529	Production Végétale	\N	Techniques de production et amélioration des cultures	36	Cultures agricoles	\N	\N	t	2026-06-09 07:48:28.317+03	2026-06-09 07:48:28.317+03
439	529	Production Animale	\N	Gestion des systèmes d'élevage et production animale	36	Élevage	\N	\N	t	2026-06-09 07:48:28.317+03	2026-06-09 07:48:28.317+03
440	529	Développement Rural	\N	Appui au développement agricole et rural	36	Agriculture durable	\N	\N	t	2026-06-09 07:48:28.317+03	2026-06-09 07:48:28.317+03
441	21	Administration Publique	\N	Formation sur le fonctionnement de l'État, des collectivités territoriales et des administrations publiques.	36	Gestion des institutions publiques	\N	\N	t	2026-06-09 07:52:28.494+03	2026-06-09 07:52:28.494+03
442	21	Droit Administratif	\N	Étude des relations entre l'administration et les citoyens, des actes administratifs et du contentieux administratif.	36	Réglementation publique	\N	\N	t	2026-06-09 07:52:28.494+03	2026-06-09 07:52:28.494+03
443	21	Gouvernance et Politiques Publiques	\N	Évaluation, conception et mise en œuvre des politiques publiques.	36	Analyse des politiques publiques	\N	\N	t	2026-06-09 07:52:28.494+03	2026-06-09 07:52:28.494+03
444	530	Droit des Affaires	\N	Formation en droit commercial, droit des sociétés et fiscalité	36	Entreprises et commerce	\N	\N	t	2026-06-09 07:55:05.02+03	2026-06-09 07:55:05.02+03
445	530	Droit Civil	\N	Étude des contrats, de la responsabilité civile, du droit de la famille et des successions	36	Relations entre particuliers	\N	\N	t	2026-06-09 07:55:05.02+03	2026-06-09 07:55:05.02+03
446	530	Pratiques Judiciaires et Juridiques	\N	Préparation aux métiers du droit, des tribunaux et du conseil juridique	36	Carrières judiciaires	\N	\N	t	2026-06-09 07:55:05.02+03	2026-06-09 07:55:05.02+03
447	531	Relations Internationales	\N	Étude des relations entre États, des organisations internationales et de la diplomatie	36	Diplomatie et coopération	\N	\N	t	2026-06-09 07:57:39.544+03	2026-06-09 07:57:39.544+03
448	531	Gouvernance Politique	\N	Analyse du fonctionnement des institutions politiques nationales et internationales	36	Institutions et systèmes politiques	\N	\N	t	2026-06-09 07:57:39.544+03	2026-06-09 07:57:39.544+03
449	531	Analyse Politique et Géopolitique	\N	Étude des phénomènes politiques, des conflits et des enjeux géostratégiques.	36	Stratégie et géopolitique	\N	\N	t	2026-06-09 07:57:39.544+03	2026-06-09 07:57:39.544+03
450	55	Finance et Comptabilité	\N	Formation en comptabilité générale, analyse financière, audit, fiscalité, contrôle de gestion et gestion financière des entreprises	36	Gestion financière et comptable	\N	\N	t	2026-06-09 08:02:40.635+03	2026-06-09 08:02:40.635+03
451	55	Marketing et Commerce	\N	Formation aux études de marché, à la communication, à la gestion commerciale et au développement des activités de vente	36	Marketing et développement commercial	\N	\N	t	2026-06-09 08:02:40.635+03	2026-06-09 08:02:40.635+03
452	55	Management, Entrepreneuriat et Leadership	\N	Formation en gestion de projet, management d'équipe, entrepreneuriat, leadership et création d'entreprise	36	Management des organisations	\N	\N	t	2026-06-09 08:02:40.635+03	2026-06-09 08:02:40.635+03
453	54	Banque - Assurance	\N	Formation de professionnels capables de travailler dans les banques, assurances, institutions de microfinance et établissements financiers	36	Services financiers	\N	\N	t	2026-06-09 08:04:04.017+03	2026-06-09 08:04:04.017+03
454	532	Gestion de Projets et Développement Durable	\N	Formation orientée vers la conduite de projets, le développement durable, la gestion environnementale et le management des organisations	36	Management de projets	\N	\N	t	2026-06-09 08:05:48.835+03	2026-06-09 08:05:48.835+03
455	56	Informatique Décisionnelle	\N	Formation combinant informatique, analyse de données, gestion des risques et systèmes d'aide à la décision pour les entreprises	36	Systèmes d'information et aide à la décision	\N	\N	t	2026-06-09 08:07:12.343+03	2026-06-09 08:07:12.343+03
456	533	Ingénierie et Management de Projets	\N	Formation de cadres supérieurs capables de concevoir, piloter et évaluer des projets de développement et d'entreprise	24	Gestion avancée de projets	\N	\N	t	2026-06-09 08:09:24.943+03	2026-06-09 08:09:24.943+03
457	534	Qualité et Développement Durable	\N	Formation sur les démarches qualité, l'agriculture durable et le développement territorial.	24	Management qualité	\N	\N	t	2026-06-09 08:11:20.262+03	2026-06-09 08:11:20.262+03
458	535	Informatique de Gestion	\N	Formation associant informatique, gestion, technologies de l'information et gestion de projets numériques	36	Systèmes d'information d'entreprise	\N	\N	t	2026-06-09 08:12:53.82+03	2026-06-09 08:12:53.82+03
459	31	Gestion de Projets et Développement Durable	\N	Formation en conduite de projets, gestion des risques, communication et développement durable.	36	Management de projets	\N	\N	t	2026-06-09 08:15:13.853+03	2026-06-09 08:15:13.853+03
460	32	Informatique Décisionnelle et Gestion des Risques	\N	Formation orientée vers le développement informatique, l'aide à la décision et la maîtrise des risques organisationnels.	36	Systèmes d'information	\N	\N	t	2026-06-09 08:16:24.717+03	2026-06-09 08:16:24.717+03
461	536	Banque - Assurance	\N	Formation en techniques bancaires, assurance, finance et relation clientèle	36	Services financiers	\N	\N	t	2026-06-09 08:17:41.54+03	2026-06-09 08:17:41.54+03
462	537	Ingénierie et Management de Projets	\N	Formation de cadres capables de piloter des projets complexes, maîtriser les coûts, la qualité et les ressources humaines	36	Gestion stratégique de projets	\N	\N	t	2026-06-09 08:18:58.739+03	2026-06-09 08:18:58.739+03
463	538	Qualité et Développement Durable	\N	Formation spécialisée dans les systèmes qualité, l'agronomie et le développement durable.	36	Management qualité et développement rural	\N	\N	t	2026-06-09 08:20:29.532+03	2026-06-09 08:20:29.532+03
464	539	Informatique de Gestion	\N	Formation alliant informatique, programmation, systèmes d'information, gestion de projets et management des organisations. Les débouchés incluent chef de projet IT, analyste de données, responsable sécurité informatique et consultant SI.	24	Systèmes d'information d'entreprise	\N	\N	t	2026-06-09 08:21:46.52+03	2026-06-09 08:21:46.52+03
465	44	Développement Logiciel	\N	Conception, développement et maintenance d'applications informatiques	36	Génie logiciel	\N	\N	t	2026-06-09 08:26:17.673+03	2026-06-09 08:26:17.673+03
466	44	Réseaux et Télécommunications	\N	Gestion des infrastructures réseaux, télécommunications et sécurité informatique.	36	Administration réseaux	\N	\N	t	2026-06-09 08:26:17.673+03	2026-06-09 08:26:17.673+03
467	44	Systèmes d'Information	\N	Développement et gestion des systèmes d'information des organisations	36	Informatique d'entreprise	\N	\N	t	2026-06-09 08:26:17.673+03	2026-06-09 08:26:17.673+03
468	540	Comptabilité Générale	\N	Formation en comptabilité, fiscalité et gestion financière	36	Gestion comptable	\N	\N	t	2026-06-09 08:28:01.424+03	2026-06-09 08:28:01.424+03
469	540	Audit et Contrôle	\N	Contrôle interne, audit financier et analyse des performances	36	Contrôle de gestion	\N	\N	t	2026-06-09 08:28:01.424+03	2026-06-09 08:28:01.424+03
470	541	Import – Export	\N	Gestion des échanges commerciaux internationaux et logistique internationale	36	Commerce international	\N	\N	t	2026-06-09 08:29:38.339+03	2026-06-09 08:29:38.339+03
471	541	Transit et Douane	\N	Procédures douanières et transport international.	36	Logistique internationale	\N	\N	t	2026-06-09 08:29:38.339+03	2026-06-09 08:29:38.339+03
472	542	Marketing Opérationnel	\N	Études de marché, stratégie marketing et communication commerciale	36	Marketing commercial	\N	\N	t	2026-06-09 08:31:17.853+03	2026-06-09 08:31:17.853+03
473	542	Distribution et Vente	\N	Techniques de vente, négociation et gestion de réseau commercial.	36	Développement commercial	\N	\N	t	2026-06-09 08:31:17.853+03	2026-06-09 08:31:17.853+03
474	543	Management des Organisations	\N	Management, leadership et gestion des ressources humaines	36	Gestion d'entreprise	\N	\N	t	2026-06-09 08:33:01.011+03	2026-06-09 08:33:01.011+03
475	543	Entrepreneuriat	\N	Développement de projets entrepreneuriaux et innovation	36	Création d'entreprise	\N	\N	t	2026-06-09 08:33:01.011+03	2026-06-09 08:33:01.011+03
476	544	Marketing Touristique	\N	Développement des destinations touristiques et marketing du tourisme	36	Promotion touristique	\N	\N	t	2026-06-09 08:34:28.59+03	2026-06-09 08:34:28.59+03
477	544	Gestion Hôtelière	\N	Gestion des établissements hôteliers et services touristiques	36	Management hôtelier	\N	\N	t	2026-06-09 08:34:28.59+03	2026-06-09 08:34:28.59+03
478	45	Développement Logiciel	\N	Conception, développement, test et maintenance d'applications informatiques	36	Génie logiciel	\N	\N	t	2026-06-09 08:38:13.198+03	2026-06-09 08:38:13.198+03
479	45	Développement Web et Mobile	\N	Développement de plateformes web, applications mobiles et services numériques	36	Applications web et mobiles	\N	\N	t	2026-06-09 08:38:13.198+03	2026-06-09 08:38:13.198+03
480	45	Bases de Données	\N	Administration des bases de données, modélisation et exploitation des données	36	Gestion des données	\N	\N	t	2026-06-09 08:38:13.198+03	2026-06-09 08:38:13.198+03
481	545	Administration Réseaux	\N	Configuration et administration des réseaux informatiques d'entreprise	36	Infrastructure réseau	\N	\N	t	2026-06-09 08:40:19.778+03	2026-06-09 08:40:19.778+03
482	545	Systèmes et Cloud	\N	Gestion des serveurs, virtualisation et services cloud	36	Administration système	\N	\N	t	2026-06-09 08:40:19.778+03	2026-06-09 08:40:19.778+03
483	545	Sécurité des Systèmes	\N	Protection des infrastructures numériques et gestion des risques informatiques	36	Cybersécurité fondamentale	\N	\N	t	2026-06-09 08:40:19.778+03	2026-06-09 08:40:19.778+03
484	546	Architecture des Systèmes d'Information	\N	Conception et gouvernance des systèmes d'information	24	Urbanisation SI	\N	\N	t	2026-06-09 08:42:40.755+03	2026-06-09 08:42:40.755+03
485	546	Big Data et Data Management	\N	Gestion, traitement et valorisation des données massives	24	Analyse des données	\N	\N	t	2026-06-09 08:42:40.755+03	2026-06-09 08:42:40.755+03
486	546	Gestion de Projet IT	\N	Management des projets informatiques, méthodes Agile et gouvernance numérique	24	Pilotage de projets numériques	\N	\N	t	2026-06-09 08:42:40.755+03	2026-06-09 08:42:40.755+03
489	547	Cybersécurité	\N	Sécurisation des systèmes d'information, audit et gestion des risques numériques	24	Sécurité informatique	\N	\N	t	2026-06-09 08:44:49.034+03	2026-06-09 08:44:49.034+03
490	547	Cloud Computing	\N	Déploiement et administration des infrastructures cloud modernes	24	Infrastructure cloud	\N	\N	t	2026-06-09 08:44:49.034+03	2026-06-09 08:44:49.034+03
491	547	Internet des Objets (IoT)	\N	Conception et sécurisation des objets connectés et systèmes embarqués	24	Systèmes connectés	\N	\N	t	2026-06-09 08:44:49.034+03	2026-06-09 08:44:49.034+03
\.


--
-- Data for Name: profils_academiques; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profils_academiques (id, user_id, serie_bac, annee_bac, mention, moyenne_generale, notes_matieres, competences, centres_interet, scores_test, objectifs_professionnels, secteur_vise, budget_max_mensuel, distance_max_km, duree_max_etudes, preference_type_univ, ville_preference, created_at, updated_at) FROM stdin;
32	35		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	indifferent	\N	2026-06-02 18:33:38.637+03	2026-06-02 18:33:38.637+03
33	36	S	2016	Assez bien	15.5	\N	{}	[]	{"score":100}	Ingenieur en informatique	Informatique	\N	50	5	publique	Antananarivo	2026-06-02 19:01:21.621+03	2026-06-07 19:43:07.588+03
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, texte, categorie, series_bac_cibles, ordre, actif, created_at, updated_at) FROM stdin;
1	Quels domaines vous passionnent le plus ?	Intérêts	\N	1	t	2026-06-02 14:54:27.085+03	2026-06-02 14:54:27.085+03
3	Préférez-vous travailler en équipe ou seul ?	Personnalité	\N	3	t	2026-06-02 14:54:27.125+03	2026-06-02 14:54:27.125+03
4	Quel type d'environnement d'études préférez-vous ?	Intérêts	\N	4	t	2026-06-02 14:54:27.138+03	2026-06-02 14:54:27.138+03
5	Quelle durée d'études envisagez-vous ?	Valeurs	\N	5	t	2026-06-02 14:54:27.151+03	2026-06-02 14:54:27.151+03
6	Avez-vous une préférence géographique ?	Intérêts	\N	6	t	2026-06-02 14:54:27.164+03	2026-06-02 14:54:27.164+03
7	La physique vous passionne-t-elle ?	Intérêts	\N	7	t	2026-06-02 14:54:27.184+03	2026-06-02 14:54:27.184+03
10	La lecture est-elle une de vos passions ?	Intérêts	\N	10	t	2026-06-02 14:54:27.226+03	2026-06-02 14:54:27.226+03
8	Aimez-vous les expériences en laboratoire ?	Personnalité	\N	8	t	2026-06-02 14:54:27.197+03	2026-06-07 17:38:46.09+03
9	Êtes-vous à l'aise avec les mathématiques avancées ?	Compétences	\N	9	t	2026-06-02 14:54:27.211+03	2026-06-07 17:39:00.077+03
2	Dans quelles matières obtenez-vous les meilleurs résultats ?	Compétences	\N	2	t	2026-06-02 14:54:27.107+03	2026-06-07 17:39:13.155+03
26	Test questions	Intérêts	\N	\N	f	2026-06-07 19:20:34.934+03	2026-06-07 19:20:57.268+03
\.


--
-- Data for Name: recommendation_rules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recommendation_rules (id, nom, description, poids_serie, poids_moyenne, poids_interet, poids_competences, poids_budget, poids_duree, poids_test, moyenne_min_acceptable, filtre_eliminer_hors_serie, filtre_eliminer_hors_budget, top_n_recommendations, methode_scoring, actif, est_default, version, notes_modifications, date_creation, date_modification, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: recommendations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recommendations (id, user_id, session_test_id, filiere_id, score_compatibilite, rang, justification, sauvegardee, created_at, updated_at) FROM stdin;
219	36	39	231	85	1	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
220	36	39	209	85	2	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
221	36	39	228	85	3	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
222	36	39	217	85	4	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
223	36	39	239	85	5	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
224	36	39	232	85	6	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
225	36	39	242	85	7	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
226	36	39	310	85	8	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
227	36	39	311	85	9	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
228	36	39	221	85	10	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
229	36	39	303	82.5	11	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
230	36	39	312	82.5	12	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
231	36	39	316	82.5	13	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
232	36	39	305	82.5	14	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
233	36	39	309	82.5	15	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
234	36	39	308	82.5	16	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
235	36	39	304	82.5	17	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
236	36	39	315	82.5	18	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
237	36	39	320	82.5	19	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
238	36	39	492	82.5	20	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
239	36	39	487	82.5	21	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
240	36	39	522	82.5	22	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
241	36	39	306	82.5	23	{"points_forts":["Votre série \\"S\\" est bien adaptée à cette filière.","Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
242	36	39	322	80.5	24	{"points_forts":["Votre moyenne (15.5/20) est excellente pour l'admission."],"points_attention":[],"raisons":[]}	f	2026-06-07 19:37:22.436+03	2026-06-07 19:37:22.436+03
\.


--
-- Data for Name: sessions_test; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions_test (id, user_id, reponses, scores, complete, date_completion, created_at, updated_at) FROM stdin;
1	36	{}	{}	f	\N	2026-06-03 10:10:20.722+03	2026-06-03 10:10:20.722+03
2	36	{}	{}	f	\N	2026-06-03 10:10:39.735+03	2026-06-03 10:10:39.735+03
38	36	{"1":114,"2":7,"3":14,"4":17,"5":22,"6":25,"7":33,"8":38,"9":40,"10":45}	{"score":100}	t	2026-06-07 19:24:33.043+03	2026-06-07 19:23:08.22+03	2026-06-07 19:24:33.043+03
3	36	{"1":3,"2":8,"3":14,"4":18,"5":22,"6":27,"7":34,"8":39,"9":43,"11":49,"12":52,"13":54,"14":57,"15":60,"16":64,"17":67,"18":69,"19":72,"20":76,"21":78,"22":82}	{}	f	\N	2026-06-03 10:31:59.573+03	2026-06-03 10:33:18.597+03
4	36	{}	{}	f	\N	2026-06-03 10:34:38.799+03	2026-06-03 10:34:38.799+03
5	36	{}	{}	f	\N	2026-06-03 10:34:42.938+03	2026-06-03 10:34:42.938+03
6	36	{}	{}	f	\N	2026-06-03 10:38:38.249+03	2026-06-03 10:38:38.249+03
7	36	{}	{}	f	\N	2026-06-03 10:38:40.514+03	2026-06-03 10:38:40.514+03
8	36	{}	{}	f	\N	2026-06-03 10:38:47.643+03	2026-06-03 10:38:47.643+03
9	36	{}	{}	f	\N	2026-06-03 10:39:19.08+03	2026-06-03 10:39:19.08+03
10	36	{}	{}	f	\N	2026-06-03 10:41:41.314+03	2026-06-03 10:41:41.314+03
11	36	{}	{}	f	\N	2026-06-03 10:43:05.021+03	2026-06-03 10:43:05.021+03
12	36	{}	{}	f	\N	2026-06-03 10:58:06.805+03	2026-06-03 10:58:06.805+03
13	36	{}	{}	f	\N	2026-06-03 11:00:20.855+03	2026-06-03 11:00:20.855+03
14	36	{}	{}	f	\N	2026-06-03 11:01:40.587+03	2026-06-03 11:01:40.587+03
15	36	{}	{}	f	\N	2026-06-03 11:01:42.905+03	2026-06-03 11:01:42.905+03
16	36	{}	{}	f	\N	2026-06-03 11:03:06.084+03	2026-06-03 11:03:06.084+03
17	36	{}	{}	f	\N	2026-06-03 11:03:09.085+03	2026-06-03 11:03:09.085+03
18	36	{}	{}	f	\N	2026-06-04 13:02:25.862+03	2026-06-04 13:02:25.862+03
19	36	{}	{}	f	\N	2026-06-04 13:15:44.599+03	2026-06-04 13:15:44.599+03
20	36	{}	{}	f	\N	2026-06-04 13:29:28.622+03	2026-06-04 13:29:28.622+03
39	36	{"1":114,"2":7,"3":14,"4":17,"5":22,"6":25,"7":35,"8":38,"9":40,"10":45}	{"score":100}	t	2026-06-07 19:37:22.132+03	2026-06-07 19:36:23.003+03	2026-06-07 19:37:22.132+03
21	36	{"1":102,"2":7,"3":15,"4":19,"5":21,"6":27,"7":32,"8":36,"9":43,"10":47}	{"score":100}	t	2026-06-04 13:30:08.338+03	2026-06-04 13:29:46.435+03	2026-06-04 13:30:08.338+03
22	36	{"1":102,"2":8,"3":15,"4":20,"5":21,"6":27,"7":35,"8":36,"9":43,"10":47}	{"score":100}	t	2026-06-04 13:31:08.087+03	2026-06-04 13:30:39.211+03	2026-06-04 13:31:08.087+03
23	36	{}	{}	f	\N	2026-06-07 18:50:03.79+03	2026-06-07 18:50:03.79+03
24	36	{}	{}	f	\N	2026-06-07 18:52:27.424+03	2026-06-07 18:52:27.424+03
25	36	{}	{}	f	\N	2026-06-07 18:53:10.409+03	2026-06-07 18:53:10.409+03
26	36	{}	{}	f	\N	2026-06-07 18:54:51.269+03	2026-06-07 18:54:51.269+03
27	36	{}	{}	f	\N	2026-06-07 18:58:53.258+03	2026-06-07 18:58:53.258+03
28	36	{}	{}	f	\N	2026-06-07 19:00:28.622+03	2026-06-07 19:00:28.622+03
29	36	{}	{}	f	\N	2026-06-07 19:00:42.147+03	2026-06-07 19:00:42.147+03
30	36	{}	{}	f	\N	2026-06-07 19:01:50.598+03	2026-06-07 19:01:50.598+03
31	36	{}	{}	f	\N	2026-06-07 19:02:26.924+03	2026-06-07 19:02:26.924+03
32	36	{}	{}	f	\N	2026-06-07 19:03:18.735+03	2026-06-07 19:03:18.735+03
33	36	{}	{}	f	\N	2026-06-07 19:04:22.535+03	2026-06-07 19:04:22.535+03
34	36	{}	{}	f	\N	2026-06-07 19:08:38.951+03	2026-06-07 19:08:38.951+03
35	36	{}	{}	f	\N	2026-06-07 19:15:25.349+03	2026-06-07 19:15:25.349+03
36	36	{}	{}	f	\N	2026-06-07 19:18:17.056+03	2026-06-07 19:18:17.056+03
37	36	{}	{}	f	\N	2026-06-07 19:20:43.244+03	2026-06-07 19:20:43.244+03
\.


--
-- Data for Name: sessions_test_multi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions_test_multi (id, user_id, test_id, reponses, score, scores_par_domaine, complete, date_completion, created_at, updated_at) FROM stdin;
40	36	17	{"1":1,"2":7,"3":15,"4":18,"5":21,"6":26,"7":34,"8":37,"9":41}	100	{"score":100}	t	2026-06-03 12:13:54.533+03	2026-06-03 12:13:34.409+03	2026-06-03 12:13:54.533+03
25	36	17	{}	\N	\N	f	\N	2026-06-03 11:03:50.654+03	2026-06-03 11:03:50.655+03
26	36	17	{}	\N	\N	f	\N	2026-06-03 11:04:40.989+03	2026-06-03 11:04:40.989+03
27	36	17	{}	\N	\N	f	\N	2026-06-03 11:05:56.681+03	2026-06-03 11:05:56.681+03
28	36	17	{}	\N	\N	f	\N	2026-06-03 11:06:03.641+03	2026-06-03 11:06:03.642+03
29	36	17	{}	\N	\N	f	\N	2026-06-03 11:06:42.876+03	2026-06-03 11:06:42.876+03
30	36	17	{}	\N	\N	f	\N	2026-06-03 11:06:42.891+03	2026-06-03 11:06:42.891+03
31	36	17	{}	\N	\N	f	\N	2026-06-03 11:06:52.471+03	2026-06-03 11:06:52.471+03
32	36	17	{}	\N	\N	f	\N	2026-06-03 11:09:54.917+03	2026-06-03 11:09:54.917+03
33	36	17	{}	\N	\N	f	\N	2026-06-03 11:09:58.24+03	2026-06-03 11:09:58.24+03
41	36	17	{"1":1,"2":9,"3":15,"4":19,"5":23,"6":27,"7":34,"8":37,"9":42}	100	{"score":100}	t	2026-06-03 12:18:05.801+03	2026-06-03 12:17:46.818+03	2026-06-03 12:18:05.801+03
35	36	17	{"1":2,"2":9,"3":13,"4":19,"5":21,"6":27,"7":33,"8":37,"9":41}	100	{"score":100}	t	2026-06-03 12:05:38.176+03	2026-06-03 12:05:05.094+03	2026-06-03 12:05:38.176+03
36	36	17	{"1":2,"2":8,"3":14,"4":18}	\N	\N	f	\N	2026-06-03 12:05:51.484+03	2026-06-03 12:06:10.02+03
42	36	17	{"1":1,"2":7,"3":13,"4":17,"5":22,"6":26,"7":34,"8":37,"9":41}	100	{"score":100}	t	2026-06-03 12:20:08.086+03	2026-06-03 12:19:42.689+03	2026-06-03 12:20:08.086+03
37	36	17	{"1":1,"2":7,"3":14,"4":20,"5":23,"6":27,"7":35,"8":38,"9":40}	100	{"score":100}	t	2026-06-03 12:08:44.136+03	2026-06-03 12:08:22.521+03	2026-06-03 12:08:44.136+03
38	36	17	{}	\N	\N	f	\N	2026-06-03 12:11:45.97+03	2026-06-03 12:11:45.97+03
43	36	17	{"1":1,"2":8,"3":15,"4":18,"5":22,"6":29,"7":35,"8":38,"9":42}	100	{"score":100}	t	2026-06-03 12:21:22.628+03	2026-06-03 12:21:02.995+03	2026-06-03 12:21:22.628+03
44	36	17	{}	\N	\N	f	\N	2026-06-03 12:24:01.695+03	2026-06-03 12:24:01.696+03
39	36	17	{"1":1,"2":8,"3":14,"4":18,"5":22,"6":27,"7":34,"8":38,"9":41}	100	{"score":100}	t	2026-06-03 12:12:08.76+03	2026-06-03 12:11:47.888+03	2026-06-03 12:12:08.76+03
45	36	17	{"1":1,"2":7,"3":14,"4":18,"5":23,"6":27,"7":35,"8":38,"9":42}	100	{"score":100}	t	2026-06-03 12:25:37.533+03	2026-06-03 12:25:21.703+03	2026-06-03 12:25:37.533+03
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settings (id, platform_name, platform_description, contact_email, email_notifications, moderation_alerts, weekly_reports, two_factor_auth, open_registration, email_verification, maintenance_mode, maintenance_message, logo_url, favicon_url, theme_color, created_at, updated_at) FROM stdin;
1	Skill2Study	Plateforme intelligente d'aide à la décision pour l'orientation universitaire post-baccalauréat basée sur l'intelligence artificielle	contact@orientai.mg	t	t	t	t	t	t	f	\N	\N	\N	#3b82f6	2026-06-02 15:42:12.883+03	2026-06-04 10:14:29.349+03
\.


--
-- Data for Name: test_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_questions (id, test_id, question_id, ordre, poids_importance, created_at, updated_at) FROM stdin;
121	17	1	1	1	2026-06-03 10:53:32.404+03	2026-06-03 10:53:32.404+03
122	17	2	2	1	2026-06-03 10:53:32.408+03	2026-06-03 10:53:32.408+03
123	17	3	3	1	2026-06-03 10:53:32.412+03	2026-06-03 10:53:32.412+03
124	17	4	4	1	2026-06-03 10:53:32.416+03	2026-06-03 10:53:32.416+03
125	17	5	5	1	2026-06-03 10:53:32.421+03	2026-06-03 10:53:32.421+03
126	17	6	6	1	2026-06-03 10:53:32.425+03	2026-06-03 10:53:32.425+03
127	17	7	7	1	2026-06-03 10:53:32.429+03	2026-06-03 10:53:32.429+03
128	17	8	8	1	2026-06-03 10:53:32.433+03	2026-06-03 10:53:32.433+03
129	17	9	9	1	2026-06-03 10:53:32.437+03	2026-06-03 10:53:32.437+03
130	17	10	10	1	2026-06-03 10:53:32.439+03	2026-06-03 10:53:32.439+03
\.


--
-- Data for Name: testimonials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.testimonials (id, student_name, student_serie, university_name, course_name, text, rating, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tests (id, nom, description, type, domaine, duree_minutes, ordre, actif, created_at, updated_at) FROM stdin;
17	Orientation Test	Test général d'orientation universitaire pour déterminer vos préférences	diagnostic	general	15	0	t	2026-06-03 10:53:32.373+03	2026-06-03 10:53:32.375+03
\.


--
-- Data for Name: universites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.universites (id, nom, type, ville, wilaya, adresse, site_web, email_contact, telephone, description, duree_etudes, cout_estimatif, logo_url, date_fondation, actif, created_at, updated_at) FROM stdin;
9	ETABLISSEMENT D'ENSEIGNEMENT ET DE FORMATION PROFESSIONNELLE SUPERIEURE CONDORCET	privee	Faravohitra	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.793665+03	2026-06-02 18:55:40.793665+03
11	ETABLISSEMENT PRIVE D'ENSEIGNEMENT SUPERIEUR LUMIERE	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.795191+03	2026-06-02 18:55:40.795191+03
16	ECOLE SUPERIEURE D'INFORMATIQUE ET DE GESTION DES ENTREPRISES	privee	Mahajanga	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.800028+03	2026-06-02 18:55:40.800028+03
18	ETABLISSEMENT SUPERIEUR PROFESSIONNEL BUREAUTIQUE, INFORMATIQUE ET GESTION	privee	Behoririka	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.803324+03	2026-06-02 18:55:40.803324+03
19	ECOLE SUPERIEURE PROFESSIONNELLE EN INFORMATIQUE ET COMMERCE	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.804181+03	2026-06-02 18:55:40.804181+03
20	ECOLE SUPERIEURE SPECIALISEE EN DROIT	privee	Ankatso	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.804909+03	2026-06-02 18:55:40.804909+03
21	ECOLE SUPERIEURE SAINT GABRIEL MAHAJANGA	privee	Mahajanga	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.805607+03	2026-06-02 18:55:40.805607+03
22	ECOLE SUPERIEURE SPECIALISEE DE VAKINAKARATRA	privee	Antsirabe	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.806301+03	2026-06-02 18:55:40.806301+03
25	ENGINEERING SCHOOL OF TOURISM, INFORMATICS, INTERPRETERSHIP AND MANAGEMENT	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.808341+03	2026-06-02 18:55:40.808341+03
27	EDUCATION IN TRAINING, EMPLOYMENT AND COMMUNICATION	privee	Faravohitra	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.80978+03	2026-06-02 18:55:40.80978+03
28	ETABLISSEMENT TECHNIQUE DE FORMATION PROFESSIONNELLE SUPERIEURE	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.811277+03	2026-06-02 18:55:40.811277+03
29	ETABLISSEMENT TECHNIQUE SUPERIEUR SAINT MICHEL	privee	Amparibe	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.812503+03	2026-06-02 18:55:40.812503+03
30	ESPACE UNIVERSITAIRE REGIONAL DE L'OCEAN INDIEN	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.813293+03	2026-06-02 18:55:40.813293+03
31	GRAND SEMINAIRE SAINT PAUL APOTRE	privee	Antsirabe	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.814032+03	2026-06-02 18:55:40.814032+03
32	GATE UNIVERSITY	privee	Ambohidratrimo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.814724+03	2026-06-02 18:55:40.814724+03
33	HAUTES ETUDES CHRETIENNES DE MANAGEMENT ET DE MATHEMATIQUES APPLIQUEES	privee	Alarobia Amboniloha	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.815249+03	2026-06-02 18:55:40.815249+03
34	HAUTES ETUDES EN DROIT ET EN MANAGEMENT	privee	Soanierana	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.8159+03	2026-06-02 18:55:40.8159+03
35	INSTITUT CATHOLIQUE NOTRE DAME	privee	Mahajanga	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.816468+03	2026-06-02 18:55:40.816468+03
36	INSTITUTION CHRETIENNE DE TSIENIMPARIHY, UNIE PAR LE SAUVEUR	privee	Ambalavao	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.817023+03	2026-06-02 18:55:40.817023+03
37	INSTITUT D'ENSEIGNEMENT ET DE FORMATION PROFESSIONNELLE	privee	Ambatomitsangana	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.817645+03	2026-06-02 18:55:40.817645+03
38	INSTITUT D'ETUDES POLITIQUES MADAGASCAR	privee	Ampandrana Ouest	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.818284+03	2026-06-02 18:55:40.818284+03
39	INSTITUT D'ENSEIGNEMENT SUPERIEUR DE TECHNOLOGIE INFORMATIQUE ET DE MANAGEMENT D'ENTREPRISE	privee	Antaninandro	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.818898+03	2026-06-02 18:55:40.818898+03
40	INSTITUT D'ENSEIGNEMENT SUPERIEUR DE TECHNOLOGIE INFORMATIQUE ET DE MANAGEMENT D'ENTREPRISE ANTSIRABE	privee	Antsirabe	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.819468+03	2026-06-02 18:55:40.819468+03
41	INSTITUT DE FORMATION EN AGRONOMIE, GEMMOLOGIE, INDUSTRIALISATION ET PARAMED	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.820141+03	2026-06-02 18:55:40.820141+03
42	INSTITUT DE FORMATION PROFESSIONNELLE RAKETAMANGA	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.820635+03	2026-06-02 18:55:40.820635+03
43	INSTITUT DE FORMATION ET DES RECHERCHES PEDAGOGIQUES	privee	Ambodin'Andohalo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.821283+03	2026-06-02 18:55:40.821283+03
44	INSTITUT DE FORMATION TECHNIQUE	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.821939+03	2026-06-02 18:55:40.821939+03
45	INSTITUT DE FORMATION TECHNIQUE ANTSIRABE	privee	Antsirabe	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.822348+03	2026-06-02 18:55:40.822348+03
46	INSTITUT DE FORMATION TECHNIQUE BTP	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.823023+03	2026-06-02 18:55:40.823023+03
47	INSTITUT DE FORMATION TECHNIQUE MAHAJANGA	privee	Mahajanga	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.823438+03	2026-06-02 18:55:40.823438+03
48	INSTITUT DE FORMATION TECHNIQUE TOAMASINA	privee	Toamasina	Atsinanana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.823978+03	2026-06-02 18:55:40.823978+03
49	INSTITUT DE GEOGRAPHIE DE LA SOFIA	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.82446+03	2026-06-02 18:55:40.82446+03
50	INSTITUT INTERNATIONAL DES SCIENCES SOCIALES	privee	Tsimbazaza	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.825105+03	2026-06-02 18:55:40.825105+03
51	INSTITUT DE LEADERSHIP CHRETIEN	privee	Antaninandro	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.825619+03	2026-06-02 18:55:40.825619+03
52	IMAGE APPLI	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.826189+03	2026-06-02 18:55:40.826189+03
53	INSTITUT DE MANAGEMENT DES ARTS ET METIERS	privee	Ivandry	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.826804+03	2026-06-02 18:55:40.826804+03
54	INSTITUTE OF MANAGEMENT AND TOURISM	privee	Antanimena	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.827465+03	2026-06-02 18:55:40.827465+03
55	INSTITUT DES ARTS ET DES TECHNOLOGIES AVANCEES	privee	Ankadivato	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.82796+03	2026-06-02 18:55:40.82796+03
56	INSTITUT DE FORMATION EN TOURISME	privee	Ankadivato	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.828541+03	2026-06-02 18:55:40.828541+03
57	INFOTOUR - INSTITUT DE FORMATION EN TOURISME	privee	Mahajanga	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.829602+03	2026-06-02 18:55:40.829602+03
58	INSIDE UNIVERSITY ROSSIGNOL	privee	Ambondrona	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.830257+03	2026-06-02 18:55:40.830257+03
59	INSPNMAD ANALAMANGA	privee	Ambaranjana	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.830777+03	2026-06-02 18:55:40.830777+03
60	INSPNMAD MAHAJANGA	privee	Mahajanga	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.831466+03	2026-06-02 18:55:40.831466+03
5	CFAMA - CENTRE DE FORMATION ET D'APPLICATION DU MACHINISME AGRICOLE	privee	Antsirabe	Vakinankaratra	\N	https://sitecfama.wordpress.com/	cfama-abe@moov.mg	(+261) 20 44 488 11	Centre national de référence pour la mécanisation agricole à Madagascar. Il forme des techniciens, conducteurs d'engins agricoles, mécaniciens agricoles, licenciés et masters en machinisme agricole.	2 - 5	Variable selon la formation	\N	\N	t	2026-06-02 18:55:40.790184+03	2026-06-03 21:19:17.581+03
61	INSTITUTE OF TECHNICAL TECHNOLOGY, LIVING AND INTERDISCIPLINARY ARTS OF MADAGASCAR	privee	Andranovory	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.832824+03	2026-06-02 18:55:40.832824+03
13	ECOLE SUPERIEURE DE COMMERCE ET TECHNIQUE	privee	Antananarivo	Analamanga	\N	\N	maherisoaemilien@gmail.com	+261 34 50 410 67	L'École Supérieure de Commerce et Technique (ESCT) est un établissement privé d'enseignement supérieur habilité à Madagascar. Elle forme principalement dans les domaines de la gestion, de la comptabilité et de la finance avec une approche professionnalisante orientée vers les besoins des entreprises.	Licence : 3 ans	Variable selon l'année d'étude	\N	\N	t	2026-06-02 18:55:40.797122+03	2026-06-09 07:34:00.578+03
17	ECOLE SUPERIEURE DE MANAGEMENT ET D'INFORMATIQUE APPLIQUEE	privee	Mahamasina Atsimo	Analamanga	\N	https://www.esmia-i.com/	\N	+261 20 26 413 62	L'ESMIA est une école supérieure spécialisée dans le management, l'informatique appliquée, la gestion des projets, la banque-assurance et le développement durable. L'établissement propose des formations professionnalisantes allant de la Licence au Master et dispose de partenariats académiques et professionnels.	Licence : 3 ans ; Master : 2 ans supplémentaires	Variable selon la formation	\N	\N	t	2026-06-02 18:55:40.801999+03	2026-06-09 08:14:00.082+03
62	IVON-TOERAM-PAMPIANARANA AMBONY MOMBA NY EOKOMENISMA	privee	Anjohy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.834577+03	2026-06-02 18:55:40.834577+03
63	INSTITUT PRIVE AL MOUSTAPHA	privee	Ambohitrarahaba	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.835512+03	2026-06-02 18:55:40.835512+03
64	INSTITUT PROFESSIONNEL SUPERIEUR EN AGRONOMIE ET EN TECHNOLOGIE DE TOMBOTSOA ANTSIRABE	privee	Antsirabe	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.836387+03	2026-06-02 18:55:40.836387+03
65	INSTITUT SUPERIEUR D'AMBATOMIRAHAVANY	privee	Ambatomirahavavy	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.83717+03	2026-06-02 18:55:40.83717+03
66	INSTITUT EN ADMINISTRATION D'ENTREPRISE CABINET ATOMIC	privee	Ankatso	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.837859+03	2026-06-02 18:55:40.837859+03
67	INSTITUT SUPERIEUR POUR L'AVENIR DES POLYTECHNICIENS ET DE LA SANTE PUBLIQUE	privee	Ambanja	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.838528+03	2026-06-02 18:55:40.838528+03
68	INSTITUT SUPERIEUR ATOUT TOURISME MADAGASCAR	privee	Ankorahotra	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.839163+03	2026-06-02 18:55:40.839163+03
69	INSTITUT SUPERIEUR DE LA COMMUNICATION DES AFFAIRES ET DE MANAGEMENT	privee	Ankadifotsy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.839867+03	2026-06-02 18:55:40.839867+03
70	INSTITUT SUPERIEUR CATHOLIQUE DU MENABE	privee	Morondava	Menabe	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.840569+03	2026-06-02 18:55:40.840569+03
71	INSTITUT SUPERIEUR POUR LE DEVELOPPEMENT DE L'ENTREPRENARIAT	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.841152+03	2026-06-02 18:55:40.841152+03
72	INSTITUT SUPERIEUR POUR L'ENTREPRENEURIAT, LE COMMERCE ET LE MANAGEMENT	privee	Ampasamadinika	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.841719+03	2026-06-02 18:55:40.841719+03
73	INSTITUT SUPERIEUR D'ENSEIGNEMENT TECHNOLOGIQUE ET DES SCIENCES	privee	Ambohidahy Ankadindramamy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.842472+03	2026-06-02 18:55:40.842472+03
74	INSTITUT SUPERIEUR DE GENIE ELECTRONIQUE INFORMATIQUE	privee	Ampandrana Ouest	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.843176+03	2026-06-02 18:55:40.843176+03
75	INSTITUT SUPERIEUR DE GEOLOGIE DE L'INGENIEUR ET DE L'ENVIRONNEMENT DE MADAGASCAR	privee	Ankadivato	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.8438+03	2026-06-02 18:55:40.8438+03
76	INSTITUT SUPERIEUR DE L'INNOVATION D'ANTSIRANANA	privee	Antsiranana	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.844464+03	2026-06-02 18:55:40.844464+03
77	INSTITUT SUPERIEUR D'ELECTRONIQUE ET DE SYSTEME INFORMATIQUE	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.845167+03	2026-06-02 18:55:40.845167+03
78	INSTITUT SUPERIEUR D'INFORMATIQUE ET DE MANAGEMENT D'ENTREPRISE	privee	Betongolo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.845692+03	2026-06-02 18:55:40.845692+03
79	INSTITUT SUPERIEUR EN INFORMATIQUE	privee	Ampasamadinika	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.84634+03	2026-06-02 18:55:40.84634+03
80	INSTITUT SUPERIEUR DE L'INGENIERIE ET DES TECHNIQUES DE MANAGEMENT	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.846926+03	2026-06-02 18:55:40.846926+03
81	INSTITUT SUPERIEUR DES METIERS DE MADAGASCAR	privee	Ambohimitsimbina	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.848075+03	2026-06-02 18:55:40.848075+03
82	INSTITUT SUPERIEUR EN MANAGEMENT ET DU DEVELOPPEMENT D'ANTSIRANANA	privee	Antsiranana	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.849677+03	2026-06-02 18:55:40.849677+03
83	INSTITUT UNIVERSITAIRE POLYTECHNIQUE DE MADAGASCAR	privee	Ambohijatovo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.850999+03	2026-06-02 18:55:40.850999+03
84	INSTITUT SUPERIEUR MONSEIGNEUR RAMAROSANDRATANA	privee	Miarinarivo	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.85177+03	2026-06-02 18:55:40.85177+03
85	INSTITUT SUPERIEUR DE MANAGEMENT ET DES SCIENCES TECHNOLOGIQUES	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.852423+03	2026-06-02 18:55:40.852423+03
86	INSTITUT SUPERIEUR DE MANAGEMENT ET DE TECHNOLOGIE	privee	Fianarantsoa	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.853027+03	2026-06-02 18:55:40.853027+03
87	INSTITUT SUPERIEUR NUMERIQUE D'ANTANANARIVO	privee	Antetezana Bongatsara	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.853737+03	2026-06-02 18:55:40.853737+03
88	INSTITUT SUPERIEUR NORD MADAGASCAR	privee	Antsiranana	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.854436+03	2026-06-02 18:55:40.854436+03
89	INSTITUT SUPERIEUR DE PEDAGOGIE D'ANTANANARIVO	privee	Antamponankatso	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.854907+03	2026-06-02 18:55:40.854907+03
90	INSTITUT SUPERIEUR PRIVE AGRICOLE	privee	Ampandrianomby	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.855495+03	2026-06-02 18:55:40.855495+03
91	INSTITUT SUPERIEUR POLYTECHNIQUE DE MADAGASCAR	privee	Ambatomaro Antsobolo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.856061+03	2026-06-02 18:55:40.856061+03
92	INSTITUT SUPERIEUR PRIVE MADAGASCAR DEVELOPPEMENT FORMATION	privee	Isoraka	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.856574+03	2026-06-02 18:55:40.856574+03
93	INSTITUT SUPERIEUR PROTESTANT PAUL MINAULT	privee	Ambohijatovo Atsimo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.85724+03	2026-06-02 18:55:40.85724+03
94	INSTITUT SUPERIEUR PRIVE DE LA REGION DIANA	privee	Antsiranana	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.857712+03	2026-06-02 18:55:40.857712+03
95	INSTITUT SUPERIEUR DES POLYTECHNICIENS DE LA REGION D'ITASY	privee	Analavory	Itasy	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.858357+03	2026-06-02 18:55:40.858357+03
96	INSTITUT SUPERIEUR DES SCIENCES DE DEVELOPPEMENT	privee	Fianarantsoa	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.858837+03	2026-06-02 18:55:40.858837+03
97	INSTITUT SUPERIEUR EN SCIENCES DE L'ENVIRONNEMENT ET DE GESTION	privee	Soanierana	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.859529+03	2026-06-02 18:55:40.859529+03
98	INSTITUT SUPERIEUR SPECIALISE EN INFORMATIQUE ET EN GESTION	privee	Soavimbahoaka	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.860043+03	2026-06-02 18:55:40.860043+03
99	INSTITUT SUPERIEUR SAINT MICHEL ITAOSY	privee	Itaosy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.860611+03	2026-06-02 18:55:40.860611+03
100	INSTITUT SUPERIEUR SALESIEN DE PHILOSOPHIE SAINT THOMAS D'AQUIN	privee	Fianarantsoa	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.861134+03	2026-06-02 18:55:40.861134+03
101	INSTITUT SUPERIEUR DE SPECIALISATION EN SCIENCES DE GESTION GROUPE EMIR CONSULTING	privee	Ankasina	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.861681+03	2026-06-02 18:55:40.861681+03
102	INSTITUT SUPERIEUR PRIVE PROFESSIONNEL	privee	Behoririka	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.86224+03	2026-06-02 18:55:40.86224+03
103	INSTITUT SUPERIEUR DE TECHNOLOGIES	privee	Manakara	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.862903+03	2026-06-02 18:55:40.862903+03
104	INSTITUT SUPERIEUR DE TECHNOLOGIE INDUSTRIEL ET DE MANAGEMENT	privee	Antsiranana	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.863524+03	2026-06-02 18:55:40.863524+03
105	INSTITUT SUPERIEUR DE TECHNOLOGIE REGIONAL DE FITOVINANY	privee	Manakara	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.864339+03	2026-06-02 18:55:40.864339+03
106	INSTITUT SUPERIEUR DE TRAVAIL SOCIAL	privee	Iavoloha	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.865365+03	2026-06-02 18:55:40.865365+03
107	INSTITUT TECHNIQUE SUPERIEUR AGRICOLE	privee	Antady Fianarantsoa	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.866973+03	2026-06-02 18:55:40.866973+03
108	INSTITUT TECHNIQUE SUPERIEUR FRANCOIS XAVIER	privee	Antady Fianarantsoa	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.867873+03	2026-06-02 18:55:40.867873+03
109	INFORMATION TECHNOLOGY UNIVERSITY	privee	Andoharanofotsy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.868545+03	2026-06-02 18:55:40.868545+03
110	INSTITUT UNIVERSITAIRE DE MADAGASCAR	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.869155+03	2026-06-02 18:55:40.869155+03
111	INSTITUT UNIVERSITAIRE PROFESSIONNEL EN ADMINISTRATION D'ENTREPRISE ET EN SCIENCES MARINES	privee	Nosy Be	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.869698+03	2026-06-02 18:55:40.869698+03
112	JEANNE D'ARC UNIVERSITY	privee	Ampandrana Bel Air	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.870327+03	2026-06-02 18:55:40.870327+03
113	LEADERSHIP MANAGEMENT BUSINESS UNIVERSITY	privee	Ambatomaro	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.870932+03	2026-06-02 18:55:40.870932+03
114	LUTHERAN INSTITUTE OF MANAGEMENT AND ENTREPRENEURSHIP	privee	Fianarantsoa	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.87142+03	2026-06-02 18:55:40.87142+03
115	MAD'AID TRAINING CENTER	privee	Nanisana	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.872068+03	2026-06-02 18:55:40.872068+03
116	MILLENIUM UNIVERSITY	privee	Mahitsy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.872538+03	2026-06-02 18:55:40.872538+03
117	MADAGASCAR UNIVERSITY OF SCIENCE AND TECHNOLOGY	privee	Ampefioha	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.873125+03	2026-06-02 18:55:40.873125+03
118	ONIVERSITE FJKM RAVELOJAONA	privee	Ambatonakanga	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.873558+03	2026-06-02 18:55:40.873558+03
119	ONIVERSITE FJKM RAVELOJAONA AMBATOLAMPY	privee	Ambatolampy	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.874293+03	2026-06-02 18:55:40.874293+03
120	ONIVERSITE FJKM RAVELOJAONA ARIVONIMAMO	privee	Arivonimamo	Itasy	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.874817+03	2026-06-02 18:55:40.874817+03
121	ONIVERSITE FJKM RAVELOJAONA MORAMANGA	privee	Moramanga	Atsinanana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.875341+03	2026-06-02 18:55:40.875341+03
122	PHILOSOPHAT SAINT PAUL	privee	Ambanidia	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.875957+03	2026-06-02 18:55:40.875957+03
123	SEKOLY AMBONY LOTERANA MOMBA NY TEOLOJIA	privee	Fianarantsoa	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.876492+03	2026-06-02 18:55:40.876492+03
124	SAMIS - ECOLE SUPERIEURE DE L'INFORMATION ET DE LA COMMUNICATION	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.877028+03	2026-06-02 18:55:40.877028+03
125	ONG - UNIVERSITE POUR TOUS	privee	Ambondrona	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.877628+03	2026-06-02 18:55:40.877628+03
126	INSTITUT TOP INFO	privee	Anjanahary	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.878211+03	2026-06-02 18:55:40.878211+03
127	TECHNOLOGY SPECIALISTS INFORMATIC	privee	Ambatomaro	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.878872+03	2026-06-02 18:55:40.878872+03
128	UNIVERSITE ASCOM	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.879511+03	2026-06-02 18:55:40.879511+03
129	UNIVERSITE ADVENTISTE	privee	Sambaina Antsirabe	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.880525+03	2026-06-02 18:55:40.880525+03
130	UNIVERSITE CATHOLIQUE DE MADAGASCAR	privee	Ambatoroka	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.881077+03	2026-06-02 18:55:40.881077+03
131	UNIVERSITE DES MEDIAS, DE L'AUDIOVISUEL ET DE LA TECHNOLOGIE	privee	Ampasanimalo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.882106+03	2026-06-02 18:55:40.882106+03
132	UNIVERSITE GSI	privee	Antaninarenina	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.883647+03	2026-06-02 18:55:40.883647+03
133	UNIVERS INFORMATIQUE	privee	Andravoahangy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.884674+03	2026-06-02 18:55:40.884674+03
134	UNIVERSITE INTERNATIONALE DE MADAGASCAR	privee	Antetezanafovoany	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.8854+03	2026-06-02 18:55:40.8854+03
135	UNIVERSITE OUEST D'IARIVO	privee	Ambohitrimanjaka	Itasy	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.886142+03	2026-06-02 18:55:40.886142+03
136	UNIVERSITE PRIVEE ALPHA SCHOOL	privee	Itaosy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.886791+03	2026-06-02 18:55:40.886791+03
137	UNIVERSITE PRIVEE	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.887439+03	2026-06-02 18:55:40.887439+03
138	UNIVERSITE PRIVEE D'AVARADRANO	privee	Sabotsy Namehana	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.888064+03	2026-06-02 18:55:40.888064+03
139	UNIVERSITE PRIVEE HAY SOA	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.888632+03	2026-06-02 18:55:40.888632+03
140	UNIVERSITE PRIVEE POUR L'INNOVATION	privee	Ankadindramamy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.88929+03	2026-06-02 18:55:40.88929+03
141	UNIVERSITE PRIVEE DE MADAGASCAR	privee	Andavamamba	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.889948+03	2026-06-02 18:55:40.889948+03
142	UNIVERSITY OF TECHNOLOGY AND BUSINESS	privee	Iavoloha	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.890553+03	2026-06-02 18:55:40.890553+03
143	UNIVERSITE DE TECHNOLOGIES A MADAGASCAR	privee	Toliara	Androy	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.891124+03	2026-06-02 18:55:40.891124+03
144	VATEL - INTERNATIONAL BUSINESS SCHOOL HOTEL AND TOURISM MANAGEMENT	privee	Ambatoroka	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.891594+03	2026-06-02 18:55:40.891594+03
145	MADAGASCAR BUSINESS SCHOOL	privee	Manakambahiny	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.892321+03	2026-06-02 18:55:40.892321+03
146	UNIVERSITE ANTANANARIVO	publique	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.89289+03	2026-06-02 18:55:40.89289+03
147	UNIVERSITE ANTSIRANANA	publique	Antsiranana	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.893403+03	2026-06-02 18:55:40.893403+03
148	UNIVERSITE FIANARANTSOA	publique	Fianarantsoa	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.894141+03	2026-06-02 18:55:40.894141+03
149	UNIVERSITE MAHAJANGA	publique	Mahajanga	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.894689+03	2026-06-02 18:55:40.894689+03
150	UNIVERSITE TOAMASINA	publique	Toamasina	Atsinanana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.895375+03	2026-06-02 18:55:40.895375+03
151	UNIVERSITE TOLIARA	publique	Toliara	Androy	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:40.895963+03	2026-06-02 18:55:40.895963+03
152	UNIVERSITE SAINT VINCENT DE PAUL	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.235695+03	2026-06-02 18:55:41.235695+03
157	ESIJEAN PAUL II	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.244707+03	2026-06-02 18:55:41.244707+03
162	INSTITUT DE FORMATION AUXILIAIRE SANTE	privee	Analamahitsy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.253333+03	2026-06-02 18:55:41.253333+03
163	INSTITUT DE FORMATION INFIRMIER ET MATERNITE	privee	Antalaha	Sava	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.256592+03	2026-06-02 18:55:41.256592+03
166	INSTITUT DE FORMATION INFIRMIER SAGE-FEMME AUXILIAIRE ANTSIRANANA	privee	Antsiranana	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.261686+03	2026-06-02 18:55:41.261686+03
167	INSTITUT DE FORMATION PARAMEDICAL	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.262326+03	2026-06-02 18:55:41.262326+03
168	INSTITUT DE FORMATION PARAMEDICAL MALAGASY	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.262957+03	2026-06-02 18:55:41.262957+03
169	INSTITUT DE FORMATION PARAMEDICAL CRAC	privee	Antsirabe	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.26451+03	2026-06-02 18:55:41.26451+03
170	INSTITUT DE FORMATION PARAMEDICAL CRAC FIANARANTSOA	privee	Fianarantsoa	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.265671+03	2026-06-02 18:55:41.265671+03
171	INSTITUT DE FORMATION PARAMEDICAL MELAKY	privee	Maintirano	Melaky	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.267282+03	2026-06-02 18:55:41.267282+03
172	INSTITUT DE FORMATION PARAMEDICAL MANDRITSARA	privee	Mandritsara	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.268135+03	2026-06-02 18:55:41.268135+03
173	INSTITUT DE FORMATION PARAMEDICAL ANTSOHIHY	privee	Ambalatany Antsohihy	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.270464+03	2026-06-02 18:55:41.270464+03
174	INSTITUT DE FORMATION PARAMEDICAL TSIROANOMANDIDY	privee	Tsiroanomandidy	Bongolava	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.273505+03	2026-06-02 18:55:41.273505+03
175	INSTITUT DE FORMATION SOINS INFIRMIERS SAINT JOSEPH ANTSIRABE	privee	Antsirabe	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.27525+03	2026-06-02 18:55:41.27525+03
176	INSTITUT DE FORMATION SANTE-MEDECINE ANTANANARIVO	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.277295+03	2026-06-02 18:55:41.277295+03
177	INSTITUT DE FORMATION SANTE-MEDECINE ANALANJIROFO	privee	Analanjirofo	Sava	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.278258+03	2026-06-02 18:55:41.278258+03
178	INSTITUT DE FORMATION SANTE-MEDECINE 67 HA	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.279339+03	2026-06-02 18:55:41.279339+03
179	INSTITUT DE FORMATION SAGE-FEMME ET PARAMEDICAL ANTANANARIVO	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.28008+03	2026-06-02 18:55:41.28008+03
180	INSTITUT DE FORMATION SAGE-FEMME ET PARAMEDICAL MAHAMASINA	privee	Mahamasina	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.283595+03	2026-06-02 18:55:41.283595+03
181	INSTITUT DE FORMATION SAGE-FEMME ET PARAMEDICAL LES ROSSIGNOLS	privee	Fianarantsoa	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.284829+03	2026-06-02 18:55:41.284829+03
182	INSTITUT DE FORMATION SAGE-FEMME ET PARAMEDICAL NOSY BE	privee	Nosy Be	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.285605+03	2026-06-02 18:55:41.285605+03
154	AROVY HEALTHCARE UNIVERSITY MAHAJANGA	privee	Mahajanga	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	2026-06-02 18:55:41.240007+03	2026-06-03 09:04:58.265+03
183	INSTITUT DE FORMATION SAGE-FEMME PARAMEDICAL MANANJARY	privee	Mananjary	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.286386+03	2026-06-02 18:55:41.286386+03
184	INSTITUT DE FORMATION SANTE TECHNICIEN MEDECIN	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.287165+03	2026-06-02 18:55:41.287165+03
161	ECOLE DE SANTE PUBLIQUE ET MEDECINE	privee	Andravoahangy Ambony	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	2026-06-02 18:55:41.252636+03	2026-06-04 14:21:24.197+03
156	ESFPB	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	2026-06-02 18:55:41.242743+03	2026-06-04 14:36:18.669+03
158	ESIF	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	2026-06-02 18:55:41.246362+03	2026-06-04 14:36:28.593+03
159	ESISFA	privee	Moramanga	Atsinanana	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	2026-06-02 18:55:41.248036+03	2026-06-04 14:36:47.197+03
160	ESPM	privee	Itaosy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	2026-06-02 18:55:41.251853+03	2026-06-04 14:36:58.042+03
164	INSTITUT DE FORMATION INFIRMIER SAGE-FEMME AUXILIAIRE	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	2026-06-02 18:55:41.258258+03	2026-06-04 14:37:21.508+03
165	INSTITUT DE FORMATION INFIRMIER SAGE-FEMME AUXILIAIRE 2	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	2026-06-02 18:55:41.260132+03	2026-06-04 14:37:33.258+03
185	INSTITUT NATIONAL SUPERIEUR DE FORMATION PARAMEDICAL TOLIARA	privee	Toliara	Androy	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.289462+03	2026-06-02 18:55:41.289462+03
186	INSTITUT NATIONAL SUPERIEUR FORMATION PARAMEDICAL TOLIARY ANOSY	privee	Toliary	Anosy	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.290322+03	2026-06-02 18:55:41.290322+03
187	INSTITUT NATIONAL SUPERIEUR PARAMEDICAL FORT	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.291169+03	2026-06-02 18:55:41.291169+03
188	INSTITUT NATIONAL SUPERIEUR PARAMEDICAL TOLIARA	privee	Toliara	Androy	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.292216+03	2026-06-02 18:55:41.292216+03
189	INSTITUT NATIONAL SUPERIEUR PARAMEDICAL FANDRIANA	privee	Fandriana	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.294659+03	2026-06-02 18:55:41.294659+03
190	INSTITUT NATIONAL SUPERIEUR PARAMEDICAL AMBATOLAMPY	privee	Ambatolampy	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.295519+03	2026-06-02 18:55:41.295519+03
191	INSTITUT NATIONAL SUPERIEUR PARAMEDICAL MAHAJANGA	privee	Mahajanga	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.29631+03	2026-06-02 18:55:41.29631+03
192	INSTITUT NATIONAL SUPERIEUR PARAMEDICAL ANTSIRABE	privee	Antsirabe	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.341706+03	2026-06-02 18:55:41.341706+03
193	INSTITUT NATIONAL SUPERIEUR PARAMEDICAL MIARINARIVO	privee	Miarinarivo	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.342838+03	2026-06-02 18:55:41.342838+03
194	INSTITUT NATIONAL SUPERIEUR PARAMEDICAL NOVATEURS MADAGASCAR ANTANANARIVO	privee	Ambohimanarina	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.343888+03	2026-06-02 18:55:41.343888+03
195	INSTITUT NATIONAL SUPERIEUR PARAMEDICAL NOVATEURS MADAGASCAR MANAKAMBAHINY	privee	Manakambahiny	Bongolava	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.349424+03	2026-06-02 18:55:41.349424+03
196	INSTITUT NATIONAL SUPERIEUR PARAMEDICAL NOVATEURS MADAGASCAR MAEVATANANA	privee	Maevatanana	Bongolava	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.350771+03	2026-06-02 18:55:41.350771+03
197	INSTITUT NATIONAL SUPERIEUR PARAMEDICAL NOVATEURS MADAGASCAR MAHAJANGA	privee	Mahajanga	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.380326+03	2026-06-02 18:55:41.380326+03
198	INSTITUT NATIONAL SUPERIEUR PARAMEDICAL NOVATEURS MADAGASCAR FIANARANTSOA	privee	Fianarantsoa	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.3839+03	2026-06-02 18:55:41.3839+03
199	INSTITUT NATIONAL SUPERIEUR PARAMEDICAL NOVATEURS MADAGASCAR TOLIARA	privee	Toliara	Androy	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.384986+03	2026-06-02 18:55:41.384986+03
200	INSTITUT PARAMEDICAL LE BON SAMARITAIN	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.387309+03	2026-06-02 18:55:41.387309+03
201	INSTITUT PARAMEDICAL PRIVÉ INTERNATIONAL	privee	Antsiranana	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.389749+03	2026-06-02 18:55:41.389749+03
202	INSTITUT SPECIALISE EN AUXILIAIRE PARAMEDICAL SAGE-FEMME ET PROFESSIONNELLES	privee	Antsiranana	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.390574+03	2026-06-02 18:55:41.390574+03
203	INSTITUT SPECIALISE EN AUXILIAIRE SANTE BIOMEDICAL	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.392642+03	2026-06-02 18:55:41.392642+03
204	INSTITUT SPECIALISE DE FORMATION PARAMEDICAL ANDAPA	privee	Andapa	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.395797+03	2026-06-02 18:55:41.395797+03
205	INSTITUT SPECIALISE DE FORMATION PARAMEDICAL ANDOHARANOFOTSY	privee	Andoharanofotsy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.39661+03	2026-06-02 18:55:41.39661+03
206	INSTITUT SPECIALISE DE FORMATION PARAMEDICAL ANDAFIATSIMO TANJOMBATO	privee	Andafiatsimo Tanjombato	Atsimo Andrefana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.397283+03	2026-06-02 18:55:41.397283+03
207	INSTITUT SPECIALISE DE FORMATION PARAMEDICAL MEGNANARA	privee	Vangaindrano	Atsimo Atsinanana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.408909+03	2026-06-02 18:55:41.408909+03
208	INSTITUT SPECIALISE DE FORMATION PARAMEDICAL PROFESSIONNEL MANAKARA	privee	Manakara	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.411374+03	2026-06-02 18:55:41.411374+03
209	INSTITUT SPECIALISE DE FORMATION PARAMEDICAL NAMEHANA	privee	Namehana	Atsimo Atsinanana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.412521+03	2026-06-02 18:55:41.412521+03
210	INSTITUT SPECIALISE DE FORMATION PARAMEDICAL FORT DAUPHIN	privee	Fort Dauphin	Anosy	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.413531+03	2026-06-02 18:55:41.413531+03
211	INSTITUT SPECIALISE DE FORMATION SAGE-FEMME ET SOINS PARAMEDICAL	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.414555+03	2026-06-02 18:55:41.414555+03
212	INSTITUT SPECIALISE INFIRMIER SAGE-FEMME AUXILIAIRE	privee	Ankadifotsy Befelatanana	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.41572+03	2026-06-02 18:55:41.41572+03
213	INSTITUT SPECIALISE INFIRMIER SAGE-FEMME AUXILIAIRE MAHAJANGA	privee	Mahajanga	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.419519+03	2026-06-02 18:55:41.419519+03
214	INSTITUT SPECIALISE INFIRMIER SAGE-FEMME AUXILIAIRE ANTSIRANANA	privee	Antsiranana	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.420358+03	2026-06-02 18:55:41.420358+03
215	INSTITUT SPECIALISE INFIRMIER SAGE-FEMME AUXILIAIRE ITAOSY	privee	Itaosy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.421097+03	2026-06-02 18:55:41.421097+03
216	INSTITUT SPECIALISE PARAMEDICAL SAINT MICHEL	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.423664+03	2026-06-02 18:55:41.423664+03
217	INSTITUT SPECIALISE PARAMEDICAL VATOMANDRY	privee	Vatomandry	Atsinanana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.424451+03	2026-06-02 18:55:41.424451+03
218	INSTITUT SPECIALISE PARAMEDICAL MEDECINE DENTAIRE ANOSIBE	privee	Anosibe	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.426626+03	2026-06-02 18:55:41.426626+03
219	INSTITUT SPECIALISE PARAMEDICAL MEDECINE DENTAIRE TSIROANOMANDIDY	privee	Tsiroanomandidy	Bongolava	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.428628+03	2026-06-02 18:55:41.428628+03
220	INSTITUT SPECIALISE PARAMEDICAL MEDECINE DENTAIRE AMBOHIMANGAKELY	privee	Ambohimangakely	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.429406+03	2026-06-02 18:55:41.429406+03
221	INSTITUT SPECIALISE PARAMEDICAL NOVATEURS ANTSIRANANA	privee	Antsiranana	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.431545+03	2026-06-02 18:55:41.431545+03
222	INSTITUT SPECIALISE PARAMEDICAL PROFESSIONNEL SANTE	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.433083+03	2026-06-02 18:55:41.433083+03
223	INSTITUT SPECIALISE PARAMEDICAL RAITRA	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.434318+03	2026-06-02 18:55:41.434318+03
224	INSTITUT SPECIALISE PARAMEDICAL REGION DIANA	privee	Antsiranana	Diana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.43675+03	2026-06-02 18:55:41.43675+03
225	INSTITUT SPECIALISE PARAMEDICAL REGION SAVA	privee	Antalaha	Sava	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.439324+03	2026-06-02 18:55:41.439324+03
226	INSTITUT SPECIALISE PARAMEDICAL SANTE	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.440464+03	2026-06-02 18:55:41.440464+03
227	INSTITUT SPECIALISE SAGE-FEMME PARAMEDICAL	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.442304+03	2026-06-02 18:55:41.442304+03
228	INSTITUT SPECIALISE SANTE SAGE-FEMME DENTAIRE	privee	Mahitsy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.444098+03	2026-06-02 18:55:41.444098+03
229	INSTITUT PARAMEDICAL AMBOSITRA	privee	Ambositra	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.447879+03	2026-06-02 18:55:41.447879+03
230	INSTITUT PARAMEDICAL AMBOHIDRATRIMO	privee	Ambohidratrimo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.451685+03	2026-06-02 18:55:41.451685+03
231	SECOURS FEMININ ET ACCUEIL MEDICAL	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.453675+03	2026-06-02 18:55:41.453675+03
232	UNIVERSITE ACEEM	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.456106+03	2026-06-02 18:55:41.456106+03
233	UNIVERSITE ADVENTISTE PARAMEDICAL	privee	Sambaina Antsirabe	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.456738+03	2026-06-02 18:55:41.456738+03
234	UNIVERSITE GSI PARAMEDICAL	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.458351+03	2026-06-02 18:55:41.458351+03
235	UNIVERSITE PRIVEE AVARADRANO PARAMEDICAL	privee	Namehana	Atsimo Atsinanana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.459165+03	2026-06-02 18:55:41.459165+03
236	UNIVERSITE PRIVEE DE MADAGASCAR PARAMEDICAL	privee	Andavamamba	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.460645+03	2026-06-02 18:55:41.460645+03
237	UNIVERSITE REGION MADAGASCAR	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:41.462185+03	2026-06-02 18:55:41.462185+03
8	EBM INSTITUTE - ENGINEERING AND BUSINESS MALAGASY	privee	Antanetibe	Analamanga	\N	https://ebm-institute.com	contact@ebm-institute.com	+261 38 38 031 13 / +261 33 10 301 04	EBM Institute est un établissement privé situé à Ambatobe, proposant des formations habilitées par le MESupRES et reconnues par la Fonction Publique. L'institut est orienté vers le management, le droit, le commerce international, la logistique et l'informatique.	2 5	Environ 2 000 000 à 5 000 000 Ar/an (selon le niveau et la formation)	\N	\N	t	2026-06-02 18:55:40.792981+03	2026-06-04 16:15:47.133+03
267	UNIVERSITE SAINT VINCENT DE PAUL	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.609948+03	2026-06-02 18:55:53.609948+03
271	ESFPB	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.624358+03	2026-06-02 18:55:53.624358+03
273	ESIF	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.628244+03	2026-06-02 18:55:53.628244+03
274	ESISFA	privee	Moramanga	Atsinanana	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.629942+03	2026-06-02 18:55:53.629942+03
275	ESPM	privee	Itaosy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.63219+03	2026-06-02 18:55:53.63219+03
270	ECOLE DE FORMATION INFIRMIER MANDRITSARA	privee	Mandritsara	Boeny	\N	\N	mandritsara@moov.mg	22 388 74 / 032 42 446 98	Établissement de formation paramédicale rattaché à l'Hôpital Vaovao Mahafaly. L'école forme principalement des infirmiers et des sages-femmes pour répondre aux besoins sanitaires de la région Sofia.	3 ans (Licence Professionnelle)	\N	\N	\N	t	2026-06-02 18:55:53.622031+03	2026-06-04 16:32:32.108+03
278	INSTITUT DE FORMATION INFIRMIER ET MATERNITE	privee	Antalaha	Sava	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.637101+03	2026-06-02 18:55:53.637101+03
279	INSTITUT DE FORMATION INFIRMIER SAGE-FEMME AUXILIAIRE	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.638559+03	2026-06-02 18:55:53.638559+03
276	ECOLE DE SANTE PUBLIQUE ET MEDECINE	privee	Andravoahangy Ambony	Analamanga	\N	http://www.sante.gov.mg/inspc	\N	+261 20 22 257 01 / +261 34 31 360	L'Institut National de Santé Publique et Communautaire (INSPC) est un établissement public créé en 2002 sous la tutelle du Ministère de la Santé Publique et du Ministère de l'Enseignement Supérieur. Il assure la formation initiale, continue et spécialisée des professionnels de santé à Madagascar.	Licence : 3 ans ; Master : 2 ans supplémentaires	Variable selon la formation et le niveau	\N	\N	t	2026-06-02 18:55:53.633765+03	2026-06-04 16:38:23.772+03
250	ECOLE DOCTORALE AFFAIRES COMPTABLES FINANCIERES	publique	Antananarivo	Analamanga	\N	https://www.univ-antananarivo.mg	\N	Via l'Université d'Antananarivo	L'École Doctorale Affaires Comptables et Financières (EDACF) assure la formation et l'encadrement des doctorants dans les domaines de la comptabilité, de la finance, de l'audit, du contrôle de gestion et de la gouvernance des organisations. Elle développe des activités de recherche appliquée aux entreprises, aux institutions financières et aux administrations publiques.	Doctorat : 3 à 5 ans	Variable selon le cycle doctoral	\N	\N	t	2026-06-02 18:55:41.494492+03	2026-06-04 16:47:59.618+03
251	ECOLE DOCTORALE ENVIRONNEMENT RESSOURCES NATURELLES	publique	Fianarantsoa	Vakinankaratra	\N	https://www.univ-antananarivo.mg	\N	Via l'Université d'Antananarivo	L'École Doctorale Environnement et Ressources Naturelles (EDERN) est spécialisée dans la recherche scientifique liée à l'environnement, à la biodiversité, aux ressources naturelles, à la gestion durable des écosystèmes et aux enjeux du développement durable à Madagascar.	Doctorat : 3 à 5 ans	Variable selon les frais universitaires de doctorat	\N	\N	t	2026-06-02 18:55:41.496297+03	2026-06-05 12:07:46.451+03
259	ECOLE DOCTORALE LANGAGES HISTOIRES INTERACTIONS CRITIQUES	publique	Antananarivo	Androy	\N	https://www.univ-antananarivo.mg	\N	Via l'Université d'Antananarivo	L’École Doctorale Langages, Histoires, Interactions et Critiques (LHIC) est spécialisée dans les sciences humaines et sociales : langues, littérature, histoire, linguistique, philosophie, communication et analyse critique des sociétés et des cultures.	Doctorat : 3 à 5 ans	Variable selon les frais doctoraux	\N	\N	t	2026-06-02 18:55:41.513087+03	2026-06-05 13:46:48.365+03
257	ECOLE DOCTORALE SCIENCES MARINES HALIEUTIQUES	publique	Toliara	Androy	\N	https://www.univ-toliara.mg	\N	Via l'Université de Toliara	L'École Doctorale Sciences Marines et Halieutiques est spécialisée dans la recherche sur les écosystèmes marins, les ressources halieutiques, l'océanographie, l'aquaculture, la biodiversité marine et la gestion durable des ressources côtières. Elle s'appuie notamment sur l'expertise de l'Institut Halieutique et des Sciences Marines (IH.SM) de l'Université de Toliara.	Doctorat : 3 à 5 ans	Variable selon les frais d'inscription doctorale	\N	\N	t	2026-06-02 18:55:41.509897+03	2026-06-06 13:07:53.545+03
286	INSTITUT DE FORMATION PARAMEDICAL MELAKY	privee	Maintirano	Melaky	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.646528+03	2026-06-02 18:55:53.646528+03
287	INSTITUT DE FORMATION PARAMEDICAL MANDRITSARA	privee	Mandritsara	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.64762+03	2026-06-02 18:55:53.64762+03
288	INSTITUT DE FORMATION PARAMEDICAL ANTSOHIHY	privee	Ambalatany Antsohihy	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.650764+03	2026-06-02 18:55:53.650764+03
289	INSTITUT DE FORMATION PARAMEDICAL TSIROANOMANDIDY	privee	Tsiroanomandidy	Bongolava	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.652818+03	2026-06-02 18:55:53.652818+03
290	INSTITUT DE FORMATION SOINS INFIRMIERS SAINT JOSEPH ANTSIRABE	privee	Antsirabe	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.654184+03	2026-06-02 18:55:53.654184+03
291	INSTITUT DE FORMATION SANTE-MEDECINE ANTANANARIVO	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.655447+03	2026-06-02 18:55:53.655447+03
292	INSTITUT DE FORMATION SANTE-MEDECINE ANALANJIROFO	privee	Analanjirofo	Sava	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.656358+03	2026-06-02 18:55:53.656358+03
293	INSTITUT DE FORMATION SANTE-MEDECINE 67 HA	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.657364+03	2026-06-02 18:55:53.657364+03
294	INSTITUT DE FORMATION SAGE-FEMME ET PARAMEDICAL ANTANANARIVO	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.658174+03	2026-06-02 18:55:53.658174+03
295	INSTITUT DE FORMATION SAGE-FEMME ET PARAMEDICAL MAHAMASINA	privee	Mahamasina	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.659259+03	2026-06-02 18:55:53.659259+03
296	INSTITUT DE FORMATION SAGE-FEMME ET PARAMEDICAL LES ROSSIGNOLS	privee	Fianarantsoa	Vakinankaratra	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:55:53.659924+03	2026-06-02 18:55:53.659924+03
247	ECOLE DOCTORALE SCIENCES VIE SANTE	publique	Mahajanga	Analamanga	\N	https://www.univ-mahajanga.edu.mg	\N	Via l'Université de Mahajanga	L'École Doctorale Sciences de la Vie et de la Santé (EDSVS) forme des chercheurs dans les domaines de la santé humaine, des sciences biologiques, de la biomédecine, de la santé publique et des sciences du vivant. Elle contribue à la recherche sur les maladies tropicales, la nutrition, la biologie et l'amélioration des systèmes de santé.	Doctorat : 3 à 5 ans	Variable selon les frais doctoraux	\N	\N	t	2026-06-02 18:55:41.483097+03	2026-06-09 06:38:54.118+03
264	ECOLE DOCTORALE SCIENCES POLITIQUES IEP	publique	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	2026-06-02 18:55:41.523885+03	2026-06-04 14:33:57.025+03
260	ECOLE DOCTORALE SCIENCES POLITIQUES MADAGASCAR	publique	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	2026-06-02 18:55:41.514909+03	2026-06-04 14:34:06.303+03
272	ESIJEAN PAUL II	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	2026-06-02 18:55:53.626565+03	2026-06-04 14:36:37.922+03
282	INSTITUT DE FORMATION PARAMEDICAL	privee	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	2026-06-02 18:55:53.642215+03	2026-06-04 14:37:50.152+03
7	ECOLE DE COMPTABILITE ET D'ADMINISTRATION TARATRA	privee	Fianarantsoa	Vakinankaratra	\N	http://ecat.phids.mg	contact@ecat.phids.mg	+261 34 29 932 77	Établissement supérieur privé habilité par le MESupRES, spécialisé dans les domaines de la comptabilité, de l'administration et de la gestion d'entreprise. Il propose également des formations à distance et des dispositifs de Validation des Acquis de l'Expérience (VAE).	Licence : 3 ans	\N	\N	\N	t	2026-06-02 18:55:40.792109+03	2026-06-04 16:28:32.998+03
6	CONSERVATOIRE NATIONAL DES ARTS ET METIERS	privee	Antananarivo	Analamanga	\N	https://cnam-madagascar.mg	cnam.madagascar@yahoo.com	+261 38 22 290 19 / +261 33 24 259 35	Présent à Madagascar depuis 2003, le CNAM Madagascar dispose de représentations à Antananarivo, Antsiranana, Mahajanga, Toamasina et Fianarantsoa. Il propose des formations professionnalisantes dans les domaines de l'ingénierie, de l'informatique, du management, de la comptabilité et du développement durable, avec possibilité de poursuite d'études au CNAM France.	Licence : 3 ans ; Master : 5 ans ; Ingénieur : 5 ans	Variable selon la formation (généralement plus élevé que les universités publiques)	\N	\N	t	2026-06-02 18:55:40.791173+03	2026-06-05 11:42:05.894+03
239	ECOLE DOCTORALE ENVIRONNEMENT	publique	Antananarivo	Analamanga	\N	https://www.univ-antananarivo.mg	\N	Via l'Université d'Antananarivo	L'École Doctorale Environnement est dédiée à la recherche avancée sur les écosystèmes, les ressources naturelles, les changements climatiques, la conservation de la biodiversité et le développement durable. Elle accueille des doctorants issus des sciences de l'environnement, de la biologie, de l'écologie et des disciplines connexes.	Doctorat : 3 à 5 ans	Variable selon les frais d'inscription doctorale	\N	\N	t	2026-06-02 18:55:41.467792+03	2026-06-05 12:02:59.077+03
248	ECOLE DOCTORALE GESTION RESSOURCES NATURELLES	publique	Antananarivo	Analamanga	\N	https://edgrnd.mg	contact@edgrnd.mg	+261 34 62 65 165	L'EDGRND est l'une des écoles doctorales de l'Université d'Antananarivo. Créée à partir de la fusion des formations doctorales en foresterie, environnement et agro-management, elle forme des chercheurs et experts dans les domaines de la gestion des ressources naturelles, du développement durable, de la biodiversité, de l'économie des ressources naturelles et de l'aménagement des territoires.	Doctorat : 3 à 5 ans	Variable selon les frais doctoraux	\N	\N	t	2026-06-02 18:55:41.490575+03	2026-06-05 13:33:48.534+03
238	ECOLE DOCTORALE PLURIDISCIPLINARITE DES DISCIPLINES	publique	Fianarantsoa	Analamanga	\N	https://www.univ-fianarantsoa.mg	contact@univ-fianarantsoa.mg	(+261) 20 75 508 02	L'École Doctorale Pluridisciplinarité des Disciplines est une structure de recherche qui favorise les approches interdisciplinaires dans les domaines des sciences humaines, sociales, économiques, éducatives et culturelles. Elle permet aux doctorants d'aborder des problématiques complexes en mobilisant plusieurs disciplines scientifiques.	Doctorat : 3 à 5 ans	Variable selon les frais doctoraux	\N	\N	t	2026-06-02 18:55:41.463975+03	2026-06-06 12:46:55.838+03
261	ECOLE DOCTORALE SCIENCES HUMAINES SOCIALES JURIDIQUE POLITIQUE	publique	Antananarivo	Analamanga	\N	https://hayka.mg/ed/ethique-pour-le-d%C3%A9veloppement-humain-et-social-juridiques-et-politiques-12	\N	Via l'Université Catholique de Madagascar	Cette école doctorale est officiellement intitulée « Éthique pour le Développement Humain et Social – Juridiques et Politiques » (EDHSJP). Elle regroupe plusieurs disciplines des sciences humaines, sociales, juridiques, économiques et politiques et forme des chercheurs, enseignants-chercheurs et experts de haut niveau.	Doctorat : 3 ans minimum (généralement 3 à 5 ans)	Variable selon les frais doctoraux de l'UCM	\N	\N	t	2026-06-02 18:55:41.518603+03	2026-06-06 13:02:26.248+03
263	ECOLE DOCTORALE SCIENCES UCM	publique	Antananarivo	Analamanga	\N	https://www.ucm.mg	\N	Via l'Université Catholique de Madagascar	L'École Doctorale des Sciences de l'Université Catholique de Madagascar (UCM) assure la formation à la recherche dans les domaines des sciences fondamentales, sciences appliquées, environnement, santé, technologies et développement durable. Elle accompagne les doctorants dans la réalisation de travaux scientifiques répondant aux enjeux nationaux et internationaux.	Doctorat : 3 à 5 ans	Variable selon les frais doctoraux de l'UCM	\N	\N	t	2026-06-02 18:55:41.522343+03	2026-06-06 13:20:22.309+03
265	ECOLE DOCTORALE TOAMASINA	publique	Toamasina	Atsinanana	\N	https://www.univ-toamasina.mg	\N	Via l'Université de Toamasina	L'École Doctorale de Toamasina coordonne les formations doctorales et les activités de recherche de l'Université de Toamasina. Elle couvre plusieurs domaines scientifiques, technologiques, environnementaux, économiques et sociaux liés notamment au développement régional, à l'environnement tropical et aux ressources naturelles.	Doctorat : 3 à 5 ans	Variable selon les frais d'inscription doctorale	\N	\N	t	2026-06-02 18:55:41.525279+03	2026-06-09 06:43:53.217+03
246	ECOLE DOCTORALE VALORISATION RESSOURCES NATURELLES RENOUVELABLES	publique	Fianarantsoa	Analamanga	\N	https://univ-fianarantsoa.mg	\N	Via l'Université de Fianarantsoa	L'École Doctorale Valorisation des Ressources Naturelles Renouvelables (EDVRNR) est spécialisée dans la recherche sur la gestion durable, la conservation et la valorisation des ressources naturelles renouvelables. Elle contribue au développement durable à travers des travaux portant sur la biodiversité, les ressources forestières, l'agriculture, l'environnement et les biotechnologies.	Doctorat : 3 à 5 ans	Variable selon les frais doctoraux	\N	\N	t	2026-06-02 18:55:41.480108+03	2026-06-09 06:51:51.523+03
10	ECOLE PROFESSIONNELLE SUPERIEURE AGRICOLE	privee	Bevalala	Analamanga	\N	https://www.u-magis.mg/espa	licenceagro@bev.u-magis.mg	+261 34 56 102 56 / +261 32 11 102 56	L'EPSA est une école supérieure agricole fondée par les Jésuites à Bevalala. Elle forme des techniciens supérieurs, licenciés et ingénieurs agronomes orientés vers le développement rural, l'agriculture, l'élevage et le management agricole. L'école applique le système LMD et dispose d'importantes infrastructures de formation pratique (fermes, élevages, exploitations agricoles).	Licence : 3 ans (Bac+3) ; Master : 2 ans supplémentaires (Bac+5)	Variable selon le niveau d'études	\N	\N	t	2026-06-02 18:55:40.794385+03	2026-06-09 07:15:50.798+03
12	ECOLE SUPERIEURE DE BATIMENT ET TRAVAUX PUBLICS	privee	Antananarivo	Analamanga	\N	https://www.u-magis.mg/esbtp/	esbtp@bev.u-magis.mg	+261 34 58 102 56	L'ESBTP a été créée en 2010 à Bevalala à partir de l'expérience de l'École Technique de Bâtiment (ETB). Elle forme des techniciens, licenciés et futurs ingénieurs dans le domaine du génie civil, du bâtiment et des travaux publics selon le système LMD	Licence : 3 ans ; Master : 2 ans supplémentaires	Variable selon le niveau d'étude	\N	\N	t	2026-06-02 18:55:40.796141+03	2026-06-09 07:27:00.244+03
15	ECOLE SUPERIEURE DE DEVELOPPEMENT ECONOMIQUE ET SOCIAL	privee	Antananarivo	Analamanga	\N	https://www.esdesmada.com/inscription/	contact@esdesmada.com	+261 34 46 901 46 / +261 38 61 000 05	Fondée en 2014, l'ESDES est une institution d'enseignement supérieur spécialisée dans le développement économique et social. Elle propose des formations en présentiel et à distance dans les 20 régions de Madagascar, avec une forte orientation vers le développement communautaire, l'entrepreneuriat, la gestion et l'impact social.	Licence : 3 ans ; Master : 2 ans supplémentaires	Variable selon le niveau d'étude	\N	\N	t	2026-06-02 18:55:40.79865+03	2026-06-09 07:37:21.632+03
258	ECOLE DOCTORALE BIOTECHNOLOGIES ENVIRONNEMENT TROPICAUX	publique	Toliara	Androy	\N	\N	\N	+261 32 02 053 48	École doctorale spécialisée dans la recherche sur la biodiversité, les écosystèmes et les environnements tropicaux, avec un accent fort sur les sciences marines, terrestres et la conservation des ressources naturelles à Madagascar.	Doctorat : 3 à 5 ans	Variable (formation doctorale publique)	\N	\N	t	2026-06-02 18:55:41.511515+03	2026-06-04 16:52:51.693+03
255	ECOLE DOCTORALE DROIT SCIENCES POLITIQUES ANTSIRANANA	publique	Antsiranana	Diana	\N	https://www.univ-antsiranana.edu.mg	\N	Via l'Université d'Antsiranana	L'École Doctorale Droit et Sciences Politiques (EDDSP) forme des chercheurs et enseignants-chercheurs spécialisés en droit, gouvernance, administration publique, relations internationales et sciences politiques. Les travaux de recherche portent principalement sur les problématiques juridiques, institutionnelles et politiques de Madagascar et de l'océan Indien.	Doctorat : 3 à 5 ans	Variable selon les frais doctoraux universitaires	\N	\N	t	2026-06-02 18:55:41.506147+03	2026-06-05 11:54:03.171+03
254	ECOLE DOCTORALE GENESIS ANTSIRANANA	publique	Antsiranana	Diana	\N	https://univants.mg/ecoleDoctorale	\N	Via l'Université d'Antsiranana	L'École Doctorale GENESIS est l'une des écoles doctorales de l'Université d'Antsiranana. Son intitulé officiel est « Glocalisme, Environnement et Sécurité des Sociétés Indienocéaniques ». Elle est orientée vers les recherches interdisciplinaires portant sur les dynamiques sociales, environnementales, géopolitiques et sécuritaires dans l'espace de l'océan Indien.	Doctorat : 3 à 5 ans	Variable selon les frais d'inscription doctorale	\N	\N	t	2026-06-02 18:55:41.50413+03	2026-06-05 13:24:14.969+03
252	ECOLE DOCTORALE INFORMATIQUE TECHNOLOGIE	publique	Antananarivo	Vakinankaratra	\N	https://edstii.mg	\N	Via l'École Doctorale STII	Les recherches doctorales en informatique et technologies sont aujourd'hui regroupées au sein de l'École Doctorale en Sciences et Techniques de l'Ingénierie et de l'Innovation (STII). Cette école doctorale couvre les domaines de l'informatique, de l'intelligence artificielle, des réseaux, des télécommunications, des systèmes embarqués et des technologies numériques.	Doctorat : 3 à 5 ans	Variable selon les frais doctoraux universitaires	\N	\N	t	2026-06-02 18:55:41.497941+03	2026-06-05 13:38:13.145+03
245	ECOLE DOCTORALE MATHEMATIQUES APPLIQUEES	publique	Antananarivo	Analamanga	\N	https://www.univ-antananarivo.mg	\N	Via l'Université d'Antananarivo	L'École Doctorale Mathématiques et Applications (EDMA) forme des chercheurs de haut niveau dans les domaines des mathématiques fondamentales, des mathématiques appliquées, de la modélisation, de la statistique, de l'optimisation et de l'aide à la décision. Les travaux de recherche contribuent au développement scientifique, technologique et économique de Madagascar.	Doctorat : 3 à 5 ans	Variable selon les frais d'inscription doctorale	\N	\N	t	2026-06-02 18:55:41.478515+03	2026-06-06 12:13:23.708+03
240	ECOLE DOCTORALE RESSOURCES AGRICOLES ET ALIMENTAIRES	publique	Antananarivo	Analamanga	\N	https://essagro.mg	\N	Via l'ESSA et l'Université d'Antananarivo	L'École Doctorale Ressources Agricoles et Alimentaires est orientée vers la recherche en agriculture, élevage, alimentation, nutrition, sécurité alimentaire, transformation agroalimentaire et valorisation des ressources agricoles. Elle vise à former des chercheurs capables de répondre aux enjeux de développement agricole et de sécurité alimentaire à Madagascar.	Doctorat : 3 à 5 ans	Variable selon les frais doctoraux	\N	\N	t	2026-06-02 18:55:41.469847+03	2026-06-06 12:51:35.651+03
243	ECOLE DOCTORALE SCIENCES VIE ENVIRONNEMENT	publique	Antananarivo	Analamanga	\N	https://www.univ-antananarivo.mg/Sciences-de-la-Vie-et-de-L-Environnement-SVE	victor_jeannoda@yahoo.fr	Via l'Université d'Antananarivo	L'École Doctorale Sciences de la Vie et de l'Environnement (SVE) a été habilitée en 2013. Elle regroupe plusieurs équipes d'accueil doctorales spécialisées dans la biodiversité, la santé, l'alimentation, la nutrition, les biotechnologies et l'environnement. Ses recherches contribuent au développement durable, à la conservation de la biodiversité et à la lutte contre les maladies.	Doctorat : 3 à 5 ans	Variable selon les frais doctoraux	\N	\N	t	2026-06-02 18:55:41.475558+03	2026-06-09 06:33:30.6+03
415	ÉCOLE NATIONALE SUPÉRIEURE DE LA POLICE	publique	Mamory Ivato	Analamanga	\N	http://www.ensp.gov.mg	\N	+261 34 36 438 75	L'ENSP est l'établissement chargé de la formation des cadres supérieurs de la Police Nationale malgache. Située à Ivato, elle forme principalement les commissaires et officiers de police destinés à assurer des fonctions de commandement, de gestion et de sécurité publique.	Environ 2 ans pour les formations de commissaire et d'officier de police	Formation prise en charge par l'État pour les élèves admis par concours	\N	\N	t	2026-06-02 18:56:08.426624+03	2026-06-09 07:05:47.052+03
392	UNIVERSITE INFORMATIQUE GSI	privee	Antaninarenina	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:08.397822+03	2026-06-02 18:56:08.397822+03
393	UNIVERSITE INFORMATIQUE	privee	Andravoahangy	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:08.399357+03	2026-06-02 18:56:08.399357+03
401	ONG UNIVERSITE POUR TOUS	privee	Ambondrona	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:08.412271+03	2026-06-02 18:56:08.412271+03
407	INSTITUT D'ETUDES POLITIQUES - ECOLE DOCTORALE	privee	Ampandrana	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:08.418306+03	2026-06-02 18:56:08.418306+03
408	UNIVERSITE CATHOLIQUE DE MADAGASCAR - ECOLES DOCTORALES	privee	Ambatoroka	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:08.419066+03	2026-06-02 18:56:08.419066+03
409	ONIFRA - UNIVERSITE FJKM RAVELOJAONA - ECOLE DOCTORALE	privee	Ambatonakanga	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:08.420249+03	2026-06-02 18:56:08.420249+03
413	CNTEMAD MAHAJANGA	publique	Mahajanga	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:08.424899+03	2026-06-02 18:56:08.424899+03
414	CNTEMAD TOLIARA	publique	Toliara	Androy	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:08.425772+03	2026-06-02 18:56:08.425772+03
416	INSTITUT NATIONAL DES SCIENCES COMPTABLES ET DE L'ADMINISTRATION D'ENTREPRISE	publique	Antananarivo	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:08.427458+03	2026-06-02 18:56:08.427458+03
417	INSTITUT NATIONAL DE LA SANTE PUBLIQUE ET COMMUNAUTAIRE	publique	Befelatanana	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:08.428297+03	2026-06-02 18:56:08.428297+03
418	INSTITUT NATIONAL DES SCIENCES ET TECHNIQUES NUCLEAIRES	publique	Ankatso	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:08.429168+03	2026-06-02 18:56:08.429168+03
419	INSTITUT NATIONAL DE TOURISME ET HOTELLERIE	publique	Ampefiloha	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	2026-06-02 18:56:08.430099+03	2026-06-02 18:56:08.430099+03
153	AROVY HEALTHCARE UNIVERSITY	privee	Ambohitantely	Analamanga	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	2026-06-02 18:55:41.238131+03	2026-06-03 09:04:44.519+03
382	CENTRE DE RESSOURCES, D'ASSISTANCE ET DE CONSEIL ETUDIANTS	privee	Antsirabe	Analamanga	\N	\N	\N	\N	Établissement d'enseignement supérieur privé spécialisé dans les sciences de la société, offrant des formations orientées vers la gestion, l'économie, le droit et l'accompagnement professionnel.	3	\N	\N	\N	t	2026-06-02 18:56:08.379343+03	2026-06-03 20:45:23.153+03
268	AROVY HEALTHCARE UNIVERSITY	privee	Ambohitantely	Analamanga	\N	https://arovyuniversity-mg.com	\N	\N	Université habilitée par l'État formant des professionnels de santé dans les domaines paramédicaux, biomédicaux et de la santé publique.	3-5	\N	\N	\N	t	2026-06-02 18:55:53.616152+03	2026-06-03 18:08:48.204+03
269	AROVY HEALTHCARE UNIVERSITY MAHAJANGA	privee	Mahajanga	Boeny	\N	\N	\N	\N	Établissement privé formant des professionnels de santé dans les domaines paramédicaux, biomédicaux et de santé publique.	3-5	Variable selon la formation	\N	\N	t	2026-06-02 18:55:53.619519+03	2026-06-03 18:33:26.571+03
420	ACADEMIE MILITAIRE	privee	Antsirabe	Vakinankaratra	\N	\N	\N	\N	Établissement de formation des officiers des Forces Armées Malgaches et de la Gendarmerie Nationale.	3	\N	data:image/jpeg;base64,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	\N	t	2026-06-02 18:56:08.431207+03	2026-06-03 22:19:55.579+03
2	ATHENEE SAINT JOSEPH ANTSIRABE	privee	Antsirabe	Vakinankaratra	\N	https://www.asjaweb.com/	rectorat.asja@gmail.com	+261 34 49 483 19 / +261 34 49 483 20	Université privée à vocation professionnalisante fondée en 2000 par la Congrégation des Pères Déhoniens. Elle propose des formations en sciences, technologies, agronomie, informatique, droit et économie.	3-5	Variable selon la filière (non publié officiellement)	\N	\N	t	2026-06-02 18:55:40.78687+03	2026-06-03 18:45:09.835+03
1	ESCM BUSINESS SCHOOL	privee	Antananarivo	Analamanga	\N	https://www.escm.mg	commercial@escm.mg	+261 32 87 137 10 / +261 32 87 137 11	École de commerce spécialisée en management, marketing, entrepreneuriat, business development, digital et communication. Elle propose également des parcours internationaux et des diplômes reconnus à l'international.	3-5	Variable selon le programme	\N	\N	t	2026-06-02 18:55:40.784636+03	2026-06-03 19:15:51.819+03
383	CENTRE DE FORMATION DES RESSOURCES HUMAINES	privee	Antananarivo	Atsinanana	\N	\N	\N	\N	Établissement spécialisé dans la formation en Gestion des Ressources Humaines et management des organisations. Il est habilité en Licence et Master dans le domaine des Sciences de la Société.	3 - 5	\N	\N	\N	t	2026-06-02 18:56:08.383861+03	2026-06-03 20:38:24.876+03
3	CENTRE D'ETUDES, DE L'INFORMATION ET SES TECHNOLOGIES	privee	Ambolokandrina	Analamanga	\N	\N	\N	\N	Établissement orienté vers les technologies de l'information, l'informatique appliquée et les systèmes d'information, avec une approche professionnalisante des métiers du numérique.	3 - 5	\N	\N	\N	t	2026-06-02 18:55:40.787888+03	2026-06-03 20:51:33.824+03
4	CENTRE ECOLOGIQUE DE LIBANONA	privee	Fort-Dauphin	Anosy	\N	\N	\N	\N	Établissement spécialisé dans la formation aux métiers de l'environnement, de la conservation de la biodiversité, de l'écotourisme et du développement durable. Il travaille en lien avec des projets de conservation et de gestion des ressources naturelles dans le Sud de Madagascar.	3	\N	\N	\N	t	2026-06-02 18:55:40.789016+03	2026-06-03 21:02:55.247+03
410	CENTRE REGIONAL DE FORMATION UNIVERSITAIRE FARAFANGANA	privee	Farafangana	Atsimo-Andrefana	\N	https://www.univ-fianarantsoa.mg/	\N	+261 34 43 733 76	Centre universitaire créé pour rapprocher l'enseignement supérieur des étudiants de la région Atsimo-Atsinanana. Les formations sont orientées vers le développement rural, l'environnement, l'agronomie et les sciences sociales.	3 - 5	Frais universitaires publics	\N	\N	t	2026-06-02 18:56:08.421932+03	2026-06-03 21:07:39.258+03
253	ECOLE DOCTORALE DYNAMIQUE CADRE VIE	publique	Fianarantsoa	Vakinankaratra	\N	https://www.univ-antananarivo.mg	\N	Via l'Université d'Antananarivo	L'École Doctorale Dynamique des Cadres de Vie (EDCV) est spécialisée dans l'étude des territoires, de l'environnement, de l'aménagement, de l'urbanisme, de la géographie et des dynamiques socio-spatiales. Les recherches portent sur les interactions entre les populations, les territoires et les milieux naturels.	Doctorat : 3 à 5 ans	Variable selon les frais universitaires de doctorat	\N	\N	t	2026-06-02 18:55:41.502044+03	2026-06-05 11:58:38.92+03
411	CNTEMAD ANTSIRANANA	publique	Antsiranana	Diana	\N	http://www.cntemad.mg	\N	+261 20 22 600 57	Le CNTEMAD est un établissement public créé en 1992 pour promouvoir l'enseignement supérieur à distance à Madagascar. Il dispose de centres régionaux dans plus de 35 districts, dont Antsiranana, et propose des formations en sciences de la société et sciences de l'ingénieur.	3 - 5	Entre 365 000 Ar et 515 000 Ar par année universitaire selon la filière et le nombre de supports pédagogiques.	\N	\N	t	2026-06-02 18:56:08.423237+03	2026-06-03 22:03:22.978+03
412	CNTEMAD FIANARANTSOA	publique	Fianarantsoa	Vakinankaratra	\N	https://www.cntemad.mg	contact@cntemad.mg	+261 20 22 600 57	Centre régional du CNTEMAD permettant aux étudiants de la région Haute Matsiatra et des régions voisines de suivre des études supérieures à distance avec accompagnement pédagogique local.	3 - 5	Environ 365 000 Ar à 515 000 Ar par année selon la filière	\N	\N	t	2026-06-02 18:56:08.424029+03	2026-06-03 22:05:44.714+03
155	ECOLE DE FORMATION INFIRMIER MANDRITSARA	privee	Mandritsara	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	2026-06-02 18:55:41.240822+03	2026-06-04 14:20:54.023+03
256	ECOLE DOCTORALE GEOCHIMEDE	publique	Fianarantsoa	Vakinankaratra	\N	https://www.univ-fianarantsoa.mg/EcoleDoctorale	contact@univ-fianarantsoa.mg	(+261) 20 75 508 02 / (+261) 20 75 513 25	GEOCHIMED est l'une des écoles doctorales officielles de l'Université de Fianarantsoa. Elle est spécialisée dans les domaines de la géochimie, de la chimie médicinale, de la valorisation des ressources naturelles, de l'analyse chimique et de la recherche pharmaceutique.	Doctorat : 3 à 5 ans	Variable selon les frais d'inscription doctorale	\N	\N	t	2026-06-02 18:55:41.508287+03	2026-06-05 13:29:00.901+03
241	ECOLE DOCTORALE INGENIEURS	publique	Antananarivo	Analamanga	\N	https://edinge.mg	contact@edinge.mg	Via l'Université d'Antananarivo	L'École Doctorale Ingénierie et Géosciences (INGE) forme des chercheurs de haut niveau dans les domaines de l'ingénierie, des géosciences, des matériaux, de l'énergie, des mines, de la géologie et des sciences appliquées. Elle regroupe plusieurs équipes d'accueil et laboratoires de recherche reconnus à Madagascar.	Doctorat : 3 à 5 ans	Variable selon les frais d'inscription doctorale	\N	\N	t	2026-06-02 18:55:41.472497+03	2026-06-05 13:42:39.023+03
266	ECOLE DOCTORALE MAHAJANGA	publique	Mahajanga	Boeny	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	2026-06-02 18:55:41.526707+03	2026-06-04 14:32:52.965+03
244	ECOLE DOCTORALE PHYSIQUE APPLICATIONS	publique	Antananarivo	Analamanga	\N	https://www.univ-antananarivo.mg	\N	Via l'Université d'Antananarivo	L'École Doctorale Physique et Applications (EDPA) est dédiée à la recherche avancée en physique fondamentale et appliquée. Elle forme des chercheurs capables de contribuer aux domaines de l'énergie, des matériaux, de l'électronique, de l'environnement, de l'instrumentation scientifique et des technologies innovantes.	Doctorat : 3 à 5 ans	Variable selon les frais d'inscription doctorale	\N	\N	t	2026-06-02 18:55:41.476995+03	2026-06-06 12:18:56.941+03
249	ECOLE DOCTORALE SCIENCES HUMAINES SOCIALES	publique	Antananarivo	Analamanga	\N	https://www.univ-antananarivo.mg/Sciences-Humaines-et-Sociales-SHS	raitrabe1@gmail.com	+261 20 22 326 39	L'École Doctorale Sciences Humaines et Sociales (EDSHS) forme des chercheurs dans les domaines des sciences humaines, sociales, économiques, juridiques, culturelles et éducatives. Elle regroupe plusieurs équipes d'accueil doctorales couvrant les sciences juridiques, économiques, la gestion, la sociologie, l'histoire, la géographie, les langues et la philosophie.	Doctorat : 3 à 5 ans	Variable selon les frais d'inscription doctorale	\N	\N	t	2026-06-02 18:55:41.492638+03	2026-06-06 12:56:41.007+03
242	ECOLE DOCTORALE SCIENCES TECHNOLOGIES INFORMATION COMMUNICATION	publique	Antananarivo	Analamanga	\N	https://www.univ-antananarivo.mg	\N	Via l'Université d'Antananarivo	L'École Doctorale Sciences et Technologies de l'Information et de la Communication (EDSTIC) est spécialisée dans les domaines des technologies numériques, des systèmes d'information, des télécommunications, de l'intelligence artificielle, du traitement des données et de la communication numérique. Elle forme des chercheurs et experts capables de contribuer au développement de l'économie numérique et de l'innovation technologique.	Doctorat : 3 à 5 ans	Variable selon les frais doctoraux	\N	\N	t	2026-06-02 18:55:41.474232+03	2026-06-06 13:14:41.491+03
262	ECOLE DOCTORALE SCIENCES THEO PHIL	publique	Antananarivo	Analamanga	\N	https://www.ucm.mg	\N	Via l'Université Catholique de Madagascar	L'École Doctorale Sciences Théologiques et Philosophiques est dédiée à la recherche avancée en théologie, philosophie, éthique, sciences religieuses et pensée sociale. Elle vise à former des enseignants-chercheurs, experts et responsables capables d'analyser les questions religieuses, philosophiques et sociétales contemporaines.	Doctorat : 3 à 5 ans	Variable selon les frais d'inscription doctorale	\N	\N	t	2026-06-02 18:55:41.520497+03	2026-06-06 13:15:55.352+03
14	ECOLE SUPERIEURE DE DROIT	privee	Nanisana	Analamanga	\N	https://www.esd.mg	mailto:contact@esd.mg	+261 34 26 321 22	L'ESD est un établissement privé spécialisé exclusivement dans les domaines du droit et de la science politique. Les diplômes de Licence et Master sont habilités par l'État malgache. L'école met l'accent sur la professionnalisation, la recherche juridique et la gouvernance publique.	Licence : 3 ans ; Master : 2 ans supplémentaires	Variable selon le niveau d'études	\N	\N	t	2026-06-02 18:55:40.79783+03	2026-06-09 07:50:10.814+03
26	ECOLE SUPERIEURE DE MANAGEMENT	privee	Antananarivo	Analamanga	\N	https://old.diploma.africa/madagascar/ecole-superieure-de-management	\N	\N	L'École Supérieure de Management (ESUM) est spécialisée dans les sciences de gestion, le management, la finance, le marketing et l'entrepreneuriat. Elle forme des gestionnaires, managers et entrepreneurs destinés aux entreprises privées, ONG et administrations publiques.	Licence : 3 ans ; Master : 2 ans supplémentaires	Variable selon le niveau d'étude	\N	\N	t	2026-06-02 18:55:40.808951+03	2026-06-09 08:00:05.552+03
23	ECOLE SUPERIEURE DE TECHNOLOGIE	privee	Faravohitra	Analamanga	\N	https://www.facebook.com/ESTTana/	\N	\N	L'École Supérieure de Technologie (EST) est un établissement privé fondé en 1992. Elle propose des formations professionnalisantes dans les domaines de l'informatique, des télécommunications, de la gestion, du commerce, du tourisme et du management. L'école dispose notamment de laboratoires informatiques et linguistiques ainsi que d'un centre de ressources documentaires.	Licence : 3 ans ; Master : 2 ans supplémentaires	Variable selon la filière et le niveau	\N	\N	t	2026-06-02 18:55:40.807001+03	2026-06-09 08:23:12.894+03
24	ECOLE SUPERIEURE DE TECHNOLOGIES DE L'INFORMATION	privee	Antanimena	Analamanga	\N	https://esti.mg	contact@esti.mg	\N	L'ESTI est une école d'ingénierie informatique créée avec le soutien du GOTICOM, de la CCIA et de partenaires français. Elle est reconnue pour son modèle de formation en alternance école-entreprise et forme des ingénieurs et experts en technologies de l'information.	Licence : 3 ans ; Master : 2 ans supplémentaires	Variable selon le niveau d'études	\N	\N	t	2026-06-02 18:55:40.807678+03	2026-06-09 08:36:35.573+03
\.


--
-- Data for Name: user_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_settings (id, user_id, email_notifications, new_university_notifications, test_updates_notifications, recommendations_notifications, theme, language, profile_visibility, created_at, updated_at) FROM stdin;
24	36	t	t	t	t	system	fr	private	2026-06-02 19:03:29.04+03	2026-06-02 19:03:29.04+03
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, nom, prenom, email, mot_de_passe, role, serie_bac, moyenne_generale, ville, budget_mensuel, actif, created_at, updated_at, avatar_url, email_verified, verification_token, verification_token_expires, email_verification_token, email_verification_token_expires, password_reset_token, password_reset_token_expires) FROM stdin;
36	Florine	Anita	anita.f@zurcher.edu.mg	$2a$12$/ML45N7CRZrF/APMY6lGXuvojDI8Bx5ErUbfwFerxwJAVpktWi4te	bachelier	\N	\N	Antananarivo	\N	t	2026-06-02 19:01:21.271+03	2026-06-07 19:43:37.474+03	data:image/vnd.microsoft.icon;base64,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1v/b1NT/3NXT/93W1f/d1tT/3NbU/97Y1P/e19X/39nW/+Hb1//h29f/4tzY/+Lc2P/h29f/4dvY/+Hb1//c1tL/1c/M/8jCwf+5s7T/sKmr/6ylp/+poqP/p6Cg/6ijov+qpKP/rqen/6ylpP+vqaj/raal/7CpqP+vqKf/rqin/66npv+xq6n/sqyq/7Cqqf+vqaf/rqin/6mio/+knp7/oZqb/56YmP+alpb/lpKT/4yJi/9/foL/dHR4/1ZXX/9rbHL/3djV//Tt5//38Or/9vDr//Xv6v/17+r/9O7p//Xu6f/17+n/9e/p//Xv6f/17+j/9e7o//Pt5//u6eL/7Obg/+fi3f/g29f/2NTR/8/Myf/FwsH/vLq6/7Sys/+pqKr/np2h/46Plf9/gYj/cXR8/2Zpc/9XXGj/SlBd/zlBUf8sNUf/ICs//xYiOP8RHDP/Dhoy/xAcM/8THzX/dXZz/3V2c/91dnT/dnd0/3Z3dP92d3X/dnd1/3d4df93eHX/d3h2/3d4dv93eHb/eHl3/3h5d/94eXf/eHl3/3h5eP94eXj/eXp4/3l6ef95enn/eXp5/3p6ev96e3r/ent7/3t7e/97fHv/fHx8/3x9fP98fX3/fX19/31+fv98fn7/goF//2Rqc/8wRW7/OE9+/ztVh/9AWo7/Ql6T/0Zimf9HZZz/R2Sc/0hmnP9JZpr/RmKV/7e7w//q49z/4dzY/+Pd2f/j3Nn/4tzY/+Lc2P/i29j/49zY/+Td2v/l3tr/5+Hd/+nj3v/o4t7/6ePf/+rl4f/p5OH/6ePf/+nk3//o4t7/6OLf/+ji3//o4t//6OLf/+rk4P/q5OH/6+Xi/+vl4v/s5uL/7efk/+3n5f/u6OX/7ujm/+/p5v/v6eb/7+nm/+/p5f/v6OX/7ujl/+3n5f/s5uT/6+Xi/+rk4f/p4+H/6ePh/+rk4v/r5uL/6+Xi/+rk4v/p4uD/5eDc/+Lb2//f19f/3NXV/9zV0//d19T/3tjU/93W0//e19X/3tjV/+Da1v/h29f/4drX/+Hb2P/j3Nn/4dzY/+Hc2P/g2tf/29bS/9PNyv/Evb3/trCx/66nqf+qo6X/qaKj/6mjov+po6L/rKal/7Cqqf+tp6X/rqin/62npf+tp6b/r6mo/6+pp/+tp6X/sKmp/7Gqqf+xqqn/sKmo/6+pqP+qpKP/pZ+f/6Gam/+dl5j/m5aX/5uVlv+Yk5T/kY2O/4uHiP9wbW//jImK/+bg3f/o4+D/6eTi/+vm4v/q5eL/6eTh/+jk4P/o49//5+Lf/+fi3//p4+D/6uXh/+nj4P/o4+D/6eXh/+vm4//s5+T/7url//Dq5v/x6+f/8+7p//Xu6f/17+r/9vDq//bv6v/17uj/8+3n//Hq5P/u5+H/6eLd/+Lb1v/X0Mz/y8XC/7u3tP+opaT/kI+R/3l6fv9dYGj/QkhU/3V2c/91dnT/dnZ1/3Z3df92d3X/dnd1/3d4df93eHb/d3h2/3d4dv94eHf/eHl3/3h5d/94eXj/eHl4/3h5eP95enj/eXp4/3l6ef95enn/eXp5/3p6ev96e3r/ent7/3p7e/97fHz/fHx8/3x9ff98fX3/fX19/319fv9+fn7/fX5+/4GBgP9mbHT/MUZu/zdPfv87VIb/P1qO/0JelP9FYpj/R2ad/0dlnf9JZ53/Smab/0Zilv+zt8H/6+Pd/+Lc2P/j3dj/4tzY/+Lc2P/j3Nj/4tvY/+Lb2P/j3dn/5d/b/+bg3P/o4t7/6ePf/+nk4P/r5eL/6uXi/+nk4f/p5OH/6ePg/+jh3//n4d//6eLg/+ni4P/q4+H/6uPh/+vl4v/t5uT/7ebk/+3n5P/u6OX/7+jm/+7o5v/v6ef/7+nn/+/o5//u6Ob/7+jl/+3n5P/t5+X/7Obk/+vl4//q5OL/6ePh/+rj4v/r5OP/6+Xi/+rl4v/q5eL/6ePh/+Xg3f/i3Nr/3tjW/97X1f/d19T/3dfV/93X1P/e2NX/3tfU/97Y1f/f2db/4NrX/+Hb2P/i3Nj/4tzZ/+Lc2f/i3Nj/4dvX/9vW0//Qy8n/wLm6/7Strv+up6n/qqOk/6miov+rpaT/raal/6+op/+xrKr/r6in/66op/+rpaT/rael/66op/+uqKb/rael/7Cqqf+zrav/saqo/7CpqP+wqqn/rKal/6ihoP+inJz/npiZ/5yXl/+dlpf/npeX/5yXlv+ak5P/f3p6/4eDg//g2tj/5+Lf/+nk4f/q5OH/6eTg/+nk4P/o49//5+Lf/+bh3v/o4t//6OPg/+nk4f/r5eL/7Obi/+zn4//s5+T/7Ofk/+3o5P/t6OT/7Obj/+vm4//r5uP/6+bj/+rm4v/p5OH/5+Lf/+Xh3f/k4Nz/4t3a/+Db1//e2dX/3NbR/9rTz//Vz8r/083H/9LLxf/Nxb//xLy2/7avqf91dnT/dXZ1/3Z2dv92d3X/dnh1/3d4df93eHb/d3h2/3d4dv94eXf/eHl3/3h5d/94eXj/eHl4/3l5eP95enj/eXp5/3l6ef95enn/eXp6/3p6ev96e3r/ent7/3t7e/97fHz/fHx8/3x9ff99fX3/fX19/319fv99fX7/fn5+/31+fv+BgoD/aW51/zJGbv82Tnz/O1WG/z5Zjv9CXpP/RWKZ/0dlnf9IZZ3/SGac/0pnm/9FYZX/r7S//+zk3f/i29j/5N3Z/+Lc2P/i3Nj/49zZ/+Pc2f/j3Nn/5N3Z/+Td2v/n4d3/6eLf/+nj3//p5OD/6+Xi/+rl4v/q5OH/6ePg/+nj4P/p4+D/6OLf/+jh3//p4uD/6OLg/+rj4f/r5OP/7OXj/+zl4//t5uT/7ujm/+7o5v/v6Of/7+jn/+/o5//v6ef/7+nm/+/p5v/u6OX/7ujl/+zn5P/s5eP/6+Tj/+rj4v/r5OP/6+Ti/+vl4v/r5uP/6uXi/+rk4f/m4N3/4tva/97X1//d1tX/3dfV/93X1P/d1tT/3dbU/97X1f/e2NT/4NrW/+Lc2P/h29f/4dvY/+Lc2f/i3Nn/493Z/+Hb2P/a1dL/zcjG/7y1tf+wqqv/rKan/6qkpP+spqX/rKal/66npv+vqaj/s6yr/66opv+uqKf/q6Wk/6ulpP+tp6b/rqin/62npv+uqKf/sqyr/7Ksq/+vqaj/r6in/6ympf+po6L/p6Gg/6KcnP+im5v/opqa/6Obm/+jmpr/npaW/4B6ev+JhoX/39nW/+bg3f/o4t//5+Lf/+bh3f/l4N3/5eDc/+Tf2//j39v/5N/b/+Tf2//m4N3/6OPf/+rl4f/r5uL/7Obj/+3o5f/u6OX/7unm/+7p5v/t6OX/7enl/+3p5f/s5+T/6+bi/+vm4v/p5OD/5+Le/+Xg3P/i3Nj/3tnU/9nTz//X0cz/z8nE/8jCvf/Fv7v/vriz/7exrf+0raj/dXZ0/3Z2df92d3b/dnh1/3d4dv93eHb/d3h2/3d4dv94eXf/eHl3/3h5eP94eXj/eXp4/3l6ef95enn/eXp5/3l6ef95enn/enp6/3p7ev96e3v/ent7/3t7e/97fHv/fHx8/3x9ff99fX3/fX1+/31+fv99fn7/fn5+/35+fv99fn7/goGB/2pwdv8zR27/Nk59/ztVh/8/Wo7/Ql6U/0Rjmf9GZZz/SGae/0lnnf9MaZ3/RWGW/6uwvf/s5N3/4t3Z/+Te2v/k3tr/493Z/+Pc2f/j3dn/4tzY/+Td2f/k3tr/5uDc/+ji3v/p49//6uTg/+vm4v/r5eL/6uTh/+nj4f/p4+D/6ePg/+ji4P/o4eD/6eLg/+ni4P/q4+H/6+Ti/+zl4//t5uT/7ebl/+7n5f/u6Ob/7+jm/+/p5v/v6ef/7+nn/+/p5v/u6eb/7+nm/+7o5v/s5+T/7Obj/+vl4//q5OL/6+Xi/+vl4v/s5uP/6+bj/+vl4//q5OH/5+He/+Pc2//f2Nf/3tjY/97Y1f/c1tP/3NbT/93W1P/e19T/3tjV/9/Z1v/h29f/4dvX/+Lc2f/j3dn/493a/+Lc2f/h29j/29bS/8nEwv+5srP/r6ip/6ulpv+rpKT/raem/62npv+wqqn/sauq/7Grqv+spqX/rKal/6umpf+rpaT/rqin/66op/+uqKf/r6in/7Ksq/+0rq3/squq/7CpqP+wqqj/qqSi/6agoP+knZ7/o5yd/6ScnP+lnZ3/p56e/6GZmP9/enn/ko6N/+Lb2f/n4t7/6ePg/+jj4P/o4t//5eDd/+Tf3P/k39v/4t7a/+Hc2P/h29j/497a/+bg3P/n4t//6uXg/+zn4//s5+T/7ejk/+7p5v/t6eX/7enl/+3o5f/t6OX/7enl/+zn5P/q5OH/7urn/+rl4//k39v/4tzY/97Z1f/Z1ND/1dDL/8/Jxf/Jw77/xL66/7+4s/+4sq3/sKqk/3Z3dP92d3X/dnd1/3d4df93eHb/d3h2/3d4d/94eXf/eHl3/3l5eP95eXj/eXp4/3l6ef95enn/eXp5/3l6ef95enr/enp6/3p7ev96e3v/e3t7/3t7e/97fHz/e3x8/3x9ff99fX3/fX1+/319fv9+fn7/fn5+/35+f/9+fn//fn5//4KBgf9tcXf/M0hu/zVNfP87VIb/P1mP/0Jelf9FY5n/RmSc/0hmn/9JZ57/S2ic/0Rhlf+orrz/7OTd/+Hc2f/j3tn/493a/+Te2v/k3dn/5N3a/+Pc2f/j3dn/5N3Z/+bg3P/o4t7/6uPf/+rl4f/r5uL/6+bi/+rl4v/q5OL/6uPh/+nj4v/p4uD/6eLf/+ri4f/p4uH/6uPh/+vk4v/r5eP/7Obj/+7n5f/u5+X/7ujm/+/p5//v6ef/7+nn/+/p5v/v6ub/7unm/+7p5f/u6Ob/7efl/+zn5P/s5eP/6uXj/+rk4v/r5eP/7Obj/+zm4//s5uP/6+Xi/+fh3v/j3Nv/4NnX/97X1f/e2NX/3dfU/9vV0//d19T/3tjV/9/Y1v/g2tb/4dvX/+Lc2P/j3dr/5N3a/+Te2v/l39v/4dzZ/9jT0P/FwL//ta6v/62np/+rpaX/r6io/7Krqv+wqqn/r6mo/7StrP+yrKv/rKal/6mjov+spqX/qqSj/62npv+vqaj/sKqo/7Gsq/+0rq3/tK6s/7Wvrf+xqqn/squp/66op/+po6L/pp+f/6afn/+mnp7/qJ+f/6mfnv+impj/fXl4/5uWlf/j3dr/5eDd/+nk4f/p5eH/6eTg/+jj4P/n4t7/5uHe/+bh3f/l4Nz/5N/b/+Tf2v/m4Nz/6OPf/+nk4P/r5uP/7ejl/+7q5v/u6uf/7urm/+7p5v/u6eb/7ejl/+3p5f/s6OT/6+bj//Pw7v/v6+n/5N7a/+Lc2f/e2dX/2tTQ/9XPy//PycT/ycK9/8O8uP+9trH/t7Ks/6+oo/92d3X/dnd1/3d3dv93eHb/d3h2/3h4d/94eHf/eXl4/3l5eP95eXj/eXl4/3l6ef95enn/eXp6/3p6ef96enr/ent6/3p7e/97e3v/e3t7/3t8e/97fHz/e3x8/3x8fP98fX3/fX19/31+fv99fn7/fn5//35+f/9+fn//fn9//35+f/+CgoH/bnJ4/zRIb/82TX3/O1SH/z9bkP9CX5X/RWOa/0dmn/9JaaH/Smee/0tpnP9GY5b/srW//+zk3f/i3dn/5N/b/+Te2v/j3dn/493Z/+Pd2f/j3Nn/493a/+Te2v/m39v/5+He/+nj3//p5OD/6+bi/+vm4v/q5eL/6uXi/+rk4f/p4+H/6eLh/+jh4P/q4+H/6uPh/+ni4f/r5OP/7OXj/+zl4//t5+T/7ejl/+7o5v/v6ef/7+nn/+/p6P/w6uj/7+rn/+/p5v/u6eX/7ujm/+3o5f/s5uT/6+Tk/+vl4v/r5eL/6+bi/+vm4v/s5uP/7Obj/+vl4v/o4uD/5Nzb/+Da2P/f2db/3tjV/93X1f/b1dP/3NbT/97Y1f/f2tb/4NrW/+Lc2P/j3dn/5N7a/+Te2//k3tv/5d/c/+Lc2f/X0s//wry7/7Krq/+spqb/rKam/7Grqv+1r63/tK6s/7CqqP+yrKr/sauq/6ympf+ooqL/qqWk/6ulpP+sp6X/rqmo/7Ksqv+zrqz/tK6t/7exr/+1r63/tK6r/7CqqP+vqaf/qqOi/6Wgn/+moKD/p6Cg/6qhof+qoZ//o5qY/314d/+inJv/49zZ/+Tf2//o5OD/6uXh/+nk4P/o49//6OLe/+bh3f/m4d3/5ODb/+Tf2//k39v/5d/c/+fi3v/p5OH/6+bj/+3o5f/v6uf/7+vo//Dr6P/w7Oj/7+vo/+/r6P/u6ub/7Ofk//Hu6//18/H/8/Hv/+nk4f/h2tf/39nV/9rV0f/Vz8v/0MrF/8nDvv/CvLf/vLax/7Wvqv+spqH/dnd1/3d4dv93eHb/d3h3/3h4d/94eHj/eHh4/3l5eP95eXj/eXp5/3l6ef95enn/enp5/3p6ev96enr/ent6/3p7e/96e3v/e3t7/3t7e/97fHz/e3x8/3x8fP98fX3/fH19/319fv99fn7/fn5+/35+f/9+f3//f39//39/f/9+f3//goKB/3BzeP81SG//Nk19/ztViP8/Wo//Ql+W/0ZknP9HZqD/SGih/0tpoP9IZZv/VG6c/8fFx//o4Nv/497a/+Xf2//l39v/5N7a/+Te2f/k3tr/493Z/+Pd2f/k3dr/5t/b/+jh3v/p49//6uTh/+vm4//s5+P/6uXi/+rk4v/q5OH/6uTi/+vk4v/p4uD/6uPg/+rj4f/q4+H/6uTi/+zl4//s5uT/7ebl/+3o5f/u6Ob/7+ro//Dq6P/w6un/8Oro/+/q5//w6uf/7+nn/+/p5//t6Ob/7efl/+zm4//r5uP/6+bj/+vm4//s5+P/7efj/+zn5P/s5uP/6ePg/+Xd3f/h2Nr/4NnY/97Y1v/d2NX/3NfU/9zX1P/e2dX/4dvW/+Da1//h3Nj/4tzZ/+Te2//l39z/5uDc/+bf3P/j3dr/1dDO/7+5uf+xq6v/rKen/7Ksqv+1r63/t7Gv/7awr/+zrav/sKqo/7Cqqf+up6f/qaOi/6qlpP+spaX/raen/7Crqv+xq6n/uLKw/7Svrf+4sa//t7Gu/7awrv+0rqz/squq/6qjo/+lnp//pp+f/6miof+so6L/q6Og/5yVk/93c3L/saup/+bg3P/n4t3/6eXg/+zo5P/v6ub/7enl/+vn4v/p5OH/6eXg/+jk3//n49//6OPf/+jk4P/q5eH/6+bj/+zo5f/t6eb/7urn/+/r6P/v6+j/7+vo/+/r5//u6ub/7urm//Lv7P/28/L/9PLw//Px7//y7+3/5+Lf/97X0//Z087/1c/L/8/JxP/Iwr3/wLq0/764sv+2sav/rqij/3d3dv93eHf/d3h3/3h4eP94eHj/eHl4/3h5eP94eXj/eXl5/3l6ef95enn/enp6/3p7ev96e3r/ent6/3p7e/96e3v/e3t7/3t8fP97fHz/fHx8/3x8fP98fX3/fH19/319fv99fn7/fn5+/35+f/9+f3//f3+A/35/gP9/f4D/f3+A/4KCgf9xdHn/NUlv/zZNff87VYj/P1qP/0Nglv9FZJz/SGeg/0looP9LaqD/RmSc/2h9o//W0c7/5d/b/+Xe2//l39v/5eDb/+Xf2//k3tr/5d7a/+Pd2f/k3Nn/5N3Z/+Te2v/m4N3/6ePf/+rk4P/r5uL/7Obj/+vm4v/q5eL/6+Xh/+rk4v/q4+H/6uPg/+rj4P/p4uD/6uPg/+vj4f/r5OL/7OXk/+zm5P/t5+X/7ujl/+/q5//v6ef/7+rn//Dq5//v6uf/7+rn/+7p5//v6ej/7ujn/+3n5v/t5uT/6+bj/+vm4//r5uP/7Obj/+zn5P/s5+T/7Ofk/+rj4f/l3t3/49vb/+HZ2f/g2dj/39nW/93X1f/d19T/39rW/+Db1//h29j/4t3Z/+Te2v/k39v/5+He/+fh3v/m4d3/5N7a/9TPzv+8t7f/saur/7Grqv+3sa//u7az/7q0sf+5s7H/t7Cv/7Krqv+wqaj/raam/6ukpP+sp6b/raem/62npv+zrqz/s62r/7axr/+5s7H/ubOx/7m0sf+3sa//ta+s/7Ksqv+tpqT/p6Gg/6egn/+spaP/r6ak/6efnP+PiIb/amZk/6qkov/i29j/493a/9rU0f/Tzsv/19HO/+Hc2P/m4t7/5N/b/+Ld2P/g29f/4NvX/+Hc2P/k39v/5+Le/+nk4f/s5uT/7unm/+/q5//w7On/8Ozp//Dt6f/x7er/8/Dt//Xz8P/39fP/9vTy//bz8v/18vD/9PHv//Lv7f/q5uT/4NvX/9bQy//PycT/x8C7/763sv+6tK//s62o/6ymof93eHf/d3h3/3h4eP94eHj/eXl4/3l5eP95eXn/eXl5/3l6ef96enr/enp6/3p7ev96e3r/ent6/3p7e/96e3v/e3t7/3t8e/97fHz/fHx8/3x8fP98fH3/fH19/319ff99fn7/fX5+/31+fv9+f3//fn9//39/f/9/gID/f4CA/39/gP+CgoL/cnV5/zZKb/82Tnz/O1WI/z9ckP9DYJb/RmSc/0hoof9KaaH/TWyh/0RjnP+CkKz/3dXP/+Te2v/l3tv/5d/b/+fg3P/n4Nz/5d/a/+Te2v/k3tn/5N3Z/+Te2v/l39v/5+Dd/+nj3//q5OH/7Obj/+zn5P/r5uP/6+bj/+vl4v/r5uP/6+Th/+rj4P/q4+H/6uPg/+ni4f/q4+H/7OXi/+zm4//t5uT/7efl/+7o5v/v6uf/7+ro//Dr6f/w6+j/7+ro/+/q6P/v6uf/7+no/+/o5//u6Ob/7Obl/+zm5P/r5uP/6+bi/+zn5P/t6OX/7Ofk/+3o5P/r5eP/5+Df/+Pd2//i29v/4tvb/+Ha2f/g2tf/39jW/+Hb2P/i3dj/493Z/+Pe2//k39v/5eHd/+fh3v/o4t//6OLf/+Te2v/Uzs3/vLa1/7Surf+4sbD/vbe1/724tf++uLf/ubSy/7mzsf+zrqz/r6mo/62npf+po6L/qqSk/66opv+uqaf/sKup/7Wvrf+2sK7/t7Kv/7q0sf+5tLH/ubOw/7awrf+xrKn/qqSi/6afnf+qo6H/sKim/6ukof+ZkpD/eXNx/1ZSUP+XkI7/39jU/+jh3//m4N7/1c/N/8O8u//CvLn/087L/+Lc2f/j3dn/39vW/9rV0f/Vz8v/1dDM/9rV0f/i3Nj/5uHe/+rl4f/s5+T/7ejl/+vm5P/r5uP/7ejl//Ht6//08vD/9fPx//Ty8P/08vD/9PHv//Pw7v/y8O7/7+zq/+bi3v/b1dD/1s/K/87Hwv/Gv7n/wbu1/7iyrf+vqqT/eHh3/3h4eP94eXj/eHl4/3l5ef95eXn/eXl5/3l6ef96enr/enp6/3p7ev96e3v/ent7/3p7e/97e3v/e3x7/3t8fP97fHz/fHx8/3x8fP98fX3/fX19/319ff99fX7/fX5+/31+fv9+f3//fn9//39/f/9/gID/f4CA/3+AgP9/f4D/goKC/3R3ev83Sm//NU18/zxViP9AW5D/RGGX/0Zmnf9KaqL/TGuj/01sov9GZZ3/naS2/93Vz//j3tv/5eDc/+bg3P/m4Nz/5uDc/+Xf2//k39v/5N7a/+Pd2f/k3tr/5d7a/+Xf2//o4t7/6uTh/+zm4//s5+P/6+bj/+vl4v/r5eL/6uTi/+rk4f/q4+H/6uPg/+ri4P/p4uD/6ePg/+rj4f/r5OH/7OXj/+3n5f/u6Ob/7+nn//Dr6f/w6+n/8Ovp//Dr6f/w6uj/7+nn//Dq6P/v6ef/7ujm/+3n5f/s5uX/7efl/+zn5P/s5+T/7ejl/+7o5v/u6eX/7Ofk/+ni4f/l393/49zb/+Td3P/i3Nr/4tza/+Hb1//h3Nn/497a/+Tf2v/k39v/5eDd/+bh3v/n49//6ePg/+nj4P/k39v/083L/7q0tP+5s7H/wLu4/8K8uf++ubb/wLq4/723tf+5s7H/ta6t/6+qqP+rpqX/q6Wk/6ulpf+rpaX/sKqp/7Gsq/+0rqz/trCu/7iysP+4tLD/u7Wz/7q0sv+5srD/s6yq/6miof+noJ7/rqak/66mpP+fmJf/hH58/19bWv9VUVD/qKGe/9nRz//l3tz/7unm/+zm5P/Z0tL/wbq6/7exsP/Hwb//3NfT/+Pe2v/i3Nn/2tXR/9HMyP/MxsP/0MvH/9vV0v/j39v/6uXi/+7p5f/t6OX/6+bi/+jj4P/n497/6eTh//Ds6v/z8e//8vDt//Lv7f/x7uz/5uLe/9vU0P/Vz8r/083I/9DKxP/MxsD/yMG7/8O8t/+9uLL/ta+q/3h4eP94eHj/eHl4/3l5ef95eXn/eXl5/3l6ef95enr/enp6/3p7ev96e3v/ent7/3t7e/97fHv/e3x7/3t8fP97fHz/fHx8/3x8fP98fH3/fH19/319ff99fX7/fX5+/35+fv9+fn7/fn9//39/f/9/f3//f4CA/3+AgP9/gIH/f4CA/4KCgv91d3v/OEtv/zVNfP88VYj/QVyQ/0Ril/9IZ5//Smuj/0xrov9Ma6L/Tmyg/7a4v//c1dD/5N7b/+bg3P/n4d3/5+Hd/+fh3f/m4Nz/5d/b/+Xe2v/j3dn/493Z/+Te2v/m4Nz/6eLe/+rl4f/t5+T/7efk/+zn5P/t5+T/7Obj/+vm4//r5eL/6uTh/+vk4f/r5OH/6uPh/+rj4f/r5OL/7OXj/+3m5f/u6Ob/7+nn/+/p5//w6+n/8Ovq//Dr6f/w6+j/7+vo//Dr5v/w6+f/8Ovn/+/p5v/u6Of/7ujm/+3m5f/t5+X/7efm/+3o5v/u6eb/7unm/+3o5f/q5OL/6OLg/+bg3f/l39z/5d7c/+Te2//i3dr/4t3a/+Te2//m4N3/5uHd/+bg3f/m4d7/6OPf/+nk4P/p5OD/5N/c/9PNzP+8tbX/vre2/8fBv//Gwb7/w727/8K8uf/Aurj/vLa0/7awrv+xq6r/rqin/6ympf+vqqn/rqen/7Cqqf+zrqz/tK6t/7exsP+7trP/u7az/723tf++ubb/u7Wy/7Ksqv+ooaD/rKSi/7Copv+lnZv/j4mH/3Brav9OS0v/Y2Bf/7ewrf/Sysf/4NrY/+ji4P/x6+n/7ujm/9rU0/++uLf/r6mp/7y2tP/Vz8z/4d3Y/+Pe2v/e2dX/1tDM/83HxP/OyMX/2NLO/+Pe2v/r5uL/7urm/+/r5//t6OT/6eTg/+bh3f/k39z/7uvo//Pw7v/z8e//6+fk/+Da1f/b1tH/1dDL/87Iw//GwLz/wLu1/7u0sP+6s67/tq+p/62nof94eHj/eHl5/3l5ef95eXn/eXp5/3l6ef95enr/enp6/3p7e/96e3v/ent7/3p7e/97fHv/e3x7/3t8fP97fHz/fH18/3x9fP98fXz/fH19/319ff99fX3/fX5+/35+fv9+fn//fn9//35/f/9/gH//f4CA/3+AgP9/gID/gICA/3+Agf+CgoL/dnl8/zpMcP82TX3/PFeH/0BckP9FY5j/SGig/0pro/9NbaP/SWmh/195pv/Kx8f/2NLO/+Xg2//n4d3/5+Dd/+fi3v/o4t7/5+Hd/+Xf2//l39r/5N7a/+Xf2//m39v/5t/b/+ji3v/q5OH/7Obj/+3n5f/t5+T/7Ofk/+zn5P/s5+P/7Obj/+vl4v/r5eH/6uPg/+rk4v/p4+H/6+Th/+zl4//s5uT/7efl/+7p5v/w6uj/8Ovp//Ds6f/w7Oj/8Ovp//Dr6P/v6uf/8Ovo/+/q5//v6eb/7ejm/+3n5f/t5+X/7efm/+3n5f/u6ef/7unn/+/q5//u6ef/7ebl/+rj4v/o4uD/5+He/+bg3v/m4N7/5N7c/+Te2//l4Nz/5+Ld/+bh3f/n4t7/5+Pf/+nk4f/q5eL/6uTh/+bg3f/Uzc3/wLq6/8O9u//MxsT/ysXB/8fCv//Fv7z/wby5/765t/+6tLL/sayq/7Cqqf+uqaj/rqin/7Ktq/+zrav/s62r/7exr/+6tLL/vbi0/7+6tf+/u7f/wr65/764tf+xq6n/qqSi/7Copv+ro6H/nJSS/4F8ev9iX17/SEZG/2dlY/+9t7T/xb+8/9/Y1v/m4N7/7Obk//Pt6//v6uj/2tTT/764t/+qpKT/s6yr/8zGw//b1tH/4dzX/9/Z1f/Z087/0MrG/8zGw//Vz8z/497a/+vn4//v6+f/8Ozn/+7p5f/p5eH/5ODc/+Pf2v/v7ev/7ero/+Te2v/l39r/4tzX/9vV0P/W0Mv/y8W//8K8t/+3saz/sKmk/6ymoP+ln5r/eHl5/3l5ef95eXn/eXl5/3l6ef95enr/enp6/3p6ev96e3v/ent7/3t7e/97fHv/e3x7/3t8fP97fHz/fHx8/3x8fP98fX3/fH19/319ff99fX7/fX5+/35+fv9+fn//fn5//35/f/9+f3//fn9//3+AgP9/gID/gICB/4CAgf+AgIH/goKC/3h6ff88TnH/N059/z1XiP9CXpH/RmSa/0lpoP9MbKT/T26k/0lpof90iav/1c/L/9fSz//n4Nz/6OHd/+fi3v/n4t7/6OLe/+ji3v/m4Nz/5d/b/+Xe2v/j3dr/5d7b/+bg3P/o4t7/6uTh/+zn5P/t5+T/7ejl/+zn5P/r5uP/6+bj/+vl4v/r5eH/6+Th/+rj4P/q4+D/6uPh/+nj4P/q5eL/7Obk/+3o5f/u6eb/7+rn/+/r6P/w6+n/8Ozp//Ds6f/w6+j/7+vo//Dr6f/w6un/7+rp/+7p6P/u6ef/7ujn/+7o5v/u6Of/7unn//Dq6P/w6un/7+no/+3n5//s5eX/6ePi/+ji4P/o4uD/5+Lf/+fh3v/n4d//5+Hf/+ji4P/o4uD/6OPg/+nk4P/p5eH/6+Xi/+rl4v/n4t7/1tDP/8bAwP/IwsH/0MrH/83HxP/LxcL/yMPA/8S+vP/BvLn/vLa0/7Wvrf+yrKv/sKqp/7Grqv+yrKr/s62s/7Surf+3srD/urSy/7+6tv/Au7f/w7+7/8fBvf+/urf/saup/62npf+wqaf/pZ2b/5aOjf98dnT/YFxb/1JPT/9cWln/wLq2/8K7uf/Jw8D/49za/+bg3v/t5+X/9O7t/+/p6P/a1NT/vLa1/6ehof+spaX/w7y5/9PNyP/Z08//29XR/9nTz//Tzcn/zsjE/9XQzP/j3tr/7Ojk//Ds6P/v6+f/7unm/+rm4v/k3tv/6ubj/+Xh3f/f2dT/497Y/+Ld1//e19L/2NLN/9DKxf/Fv7r/vbey/7Ksp/+rpaD/op2X/3l5ef95eXn/eXl6/3l6ef95enr/eXp6/3p6ev96e3v/ent7/3t7e/97e3v/e3x8/3t8fP97fHz/fH18/3x9ff98fX3/fH19/319ff99fn3/fX5+/35+fv9+fn7/fn5//35/f/9/f3//f4CA/3+AgP+AgID/gIGB/4CBgf+AgYH/gIGB/4GCgv96fH7/P1Fy/zhPfv8/WYj/Q1+S/0dlmv9KaqL/TG2l/1Bwpv9IaqL/kZ+1/93Wz//X0s//6OLe/+ni3//o4t//6ePf/+ji3//p4t//5+He/+bg3f/m4Nz/5d/b/+bh3P/n4d3/6ePf/+rk4f/s5+T/7efl/+3o5v/t5+b/7Ofl/+3n5P/s5uT/6+Xi/+vk4v/r5eL/6uPh/+rk4f/q4+L/6uTj/+zl5P/s5uX/7ujn/+/q5//v6+j/8Ozp//Ds6P/w6+n/8Ovo//Dr6P/w6+j/7+vo/+/q6P/v6en/7+jo/+7o6f/u6Oj/7unn/+7p5//v6uj/7+ro//Dr6f/v6ej/7efm/+vl5P/q5OP/6uPj/+rj4v/p4uH/6eLh/+ji4f/p4+L/6uTh/+jj4P/o5OD/6+bi/+vn4//r5uP/6OPf/9nU0//LxcT/zcfF/9PNyv/Ry8n/zcfF/83HxP/Iw8D/xL68/765t/+4s7H/uLKw/7SurP+zraz/ta+t/7Svrf+0rq3/trCv/7u1s/+/urb/wr25/8fDvf/Iw7//wLu4/7Grqf+yq6r/raal/56Xlv+Si4n/fXZ1/2tnZf9pZGP/U1JR/62opP/Y0c7/vLa0/8vFw//i3dr/5eDd/+3o5v/07+3/7unn/9jS0f+8tbX/pZ+g/6eiof+8trP/y8XB/8/Jxv/SzMn/083J/9LMx//Qy8b/19LO/+Tf2//u6eX/8Ozo/+7q5v/s5+P/5+Pe/+Tg2//g29b/3NfR/93Y0//e2dT/3dfS/9vVz//W0Mv/ysS//723sv+2sKr/rqij/6Semv95eXn/eXl5/3l6ev96enr/enp6/3p6ev96e3r/ent7/3t7e/97e3v/e3x8/3t8fP98fHz/fH18/3x9fP98fX3/fH19/3x9ff99fX3/fX5+/35+fv99fn7/fn5//35/f/9+f3//f39//3+AgP9/gID/f4CB/3+Agf+AgYH/gIGB/4CBgf+BgoL/fH5//0NTc/84T37/QFmJ/0Rfk/9IZ5z/TGyj/0xspP9PcKf/Tm+m/66zvv/a1M7/19LP/+ji3v/p49//6ePf/+nj3//p4+D/6eLf/+ji3v/n4d7/5+Hd/+bg3f/n4d3/6OLe/+nk4P/r5eL/7ebl/+7n5v/t5+b/7efm/+3n5f/s5uT/7Ofj/+vl5P/q5OL/6+Ti/+rj4v/p4+H/6uPi/+rk4//r5eP/7efl/+7p5//v6uf/8Ovo//Ds6f/w7On/8Ozp//Hs6f/w6+n/8Ozp//Ds6f/w6+n/8Orq/+/p6f/v6en/7+rp/+/q6P/v6uj/7+vp//Dr6v/x6+r/8Ovp/+7p6P/t5+b/7Obk/+vk5P/r5OT/6uPj/+rj4v/r5OP/6uPj/+rk4v/p5OL/6eXh/+rm4v/s5+T/7Ofk/+nk4f/e19f/087M/9PNy//Vz87/087M/8/Kyf/Oycf/ysXD/8XAvv/Dvbv/vbi2/7m0sv+5tLL/t7Gv/7exsP+1sK//uLKx/7izsf+8trT/xL67/8XAu//KxcD/y8bB/7+6t/+vqqj/sKqp/6agoP+Zk5L/kouK/4WAff95dHP/e3Vz/1BOTv+UkI7/4drX/87Ix/+6tLP/ycTB/+Db2P/n4t//8Ovp//Tw7v/v6uj/2dPS/7u1tf+ln5//pJ6e/7mzsP/Iwr//zMbC/8vFwf/MxsL/zcjE/9LMyP/a1NH/5uHd/+/r5v/x7en/7+vn/+vm4v/l4Nz/4NvW/9zX0v/b1tH/3NbR/9nTzv/W0Mv/19DL/9DKxf/Dvbf/ta+q/6ymof+knpn/eXp6/3l6ev96enr/enp6/3p6ev96e3r/ent7/3t7e/97fHz/e3x8/3t8fP98fHz/fH19/3x9ff98fX3/fH19/3x9ff98fX3/fX5+/31+fv9+fn//fX5//35+f/9/f3//f3+A/39/gP9/gID/gICB/4CAgf+AgYH/gIGB/4CBgf+AgYH/gIKC/36Af/9HVnT/OVB//0FZiv9GYZT/Smed/01tpP9Pb6f/TnCn/1p5qf/Gxcb/19HM/9fSzv/q5OD/6uTh/+vk4f/q5OD/6ePf/+nj4P/o4t//6OLe/+jj3//n4t//5+Le/+nj4P/q5eL/6+bj/+3n5f/u6Ob/7ujn/+3n5v/t5+X/7efl/+3n5P/s5eT/6+Tk/+vk4//r5OT/6uPj/+rk4v/r5OP/6+Xk/+zm5P/t6OX/7+rn/+/q6P/w7On/8Ozp//Ds6v/w6+n/8Ovo//Dr6f/w6+n/8Ovp//Dq6v/w6un/7+nq//Dq6v/v6er/7+rq//Dq6v/w6+r/8Ovq//Dr6v/v6ej/7ejn/+3n5v/t5ub/7Obl/+zl5P/r5OT/6+Tj/+rk4v/r5OP/6uPk/+nk4v/r5uP/7Ojk/+zo5P/q5eL/4dva/9jS0f/X0dD/19HQ/9bQzv/Uzsz/0MvJ/83Ixv/Jw8D/xsG//8K9u/+8t7X/vLa1/7u1s/+7tbP/t7Kw/7eysP+7tbT/v7m4/8jCv//KxMD/zMfD/87Iw/+/ubb/rain/6qlpP+alpX/lY+P/5aQj/+WkI7/i4WD/4qCgP9IRkj/gHx7/9rT0f/j3dz/yMLB/7Svrv/Cu7r/2tTS/+Xf3f/w6+n/9fDu/+/p6P/Y0tP/urO0/6Wfn/+hm5v/tK+s/8fCvf/KxcH/x8G9/8bBvf/KxcH/0cvH/9zW0v/p5OH/8Ozo//Hs6f/t6eb/6eTg/+Pe2f/c19L/2NLN/9nUzv/Z087/1tDL/9PNyP/QysX/x8G8/7exrP+po57/op2Y/3p6ev96enr/enp6/3p6ev96e3v/e3t7/3t7e/97fHz/e3x8/3t8fP97fHz/fHx8/3x9ff98fX3/fH19/3x9ff98fX3/fH19/31+fv99fn7/fX9//31/f/9/f3//f3+A/39/gP9/gID/gICB/4CAgf9/gIH/gIGB/4CBgf+AgoL/gIGC/4CCgv+AgYH/S1p1/zpRgP9EXYz/SGOW/01qn/9PcKb/UXKp/01vp/9wiK//1dDM/9POy//X0s7/6uXg/+rk4f/q5eH/6uTh/+rk4P/p4+D/6uTg/+nj4P/p4+D/6uXh/+rl4f/q5eH/7Obj/+3n5f/u6eb/7ujm/+7p5//u6Of/7ufm/+zm5f/t5uX/7Obl/+zm5f/r5OP/6+Tj/+vk5P/r5OP/6+Xj/+vl5P/t5+X/7ejn/+7q5//v6+n/8Ozp//Ds6v/w7On/8Ozp//Ds6v/w6+n/8Ozr//Dr6//w6+v/8Ovq//Dr6//x6+v/8Ovr//Dr6//v6+r/8Ozr//Ds6v/w6+r/8Ovq/+/q6f/u6ej/7efm/+3m5v/s5uX/7Obl/+vl5P/s5eT/6+bk/+vl5P/q5eT/6+bl/+3p5f/t6eb/6+bk/+Xf3//d19b/2tTT/9nU0v/Y0tH/19HQ/9TOzP/Ry8r/zcfF/8rEwv/Gwb//wry6/7+5t/+9t7X/vLe1/7q0sv+5tLP/vbe2/8C7uf/KxMH/zcjE/8/Jxf/Nx8P/v7m4/6+op/+ln5//lZCR/5qUlP+clZT/n5iW/56Xlf+dlZL/UU9Q/3NwcP/Rysf/5uDe/+Ld3P/Gv7//sqyr/7y2tf/Vz83/493b/+/q6P/18O7/7unn/9jT0v+7tLX/pZ+g/5+Zmf+xq6j/xL66/8nDv//FwLv/xL66/8fBvf/Rysb/39rW/+vn4//w7en/8ezp/+zn4//m4t3/39rV/9jSzv/Uz8n/087J/9PNyP/TzMj/z8jE/8nDvf+9t7L/q6Wg/5+alv96enr/enp6/3p7e/96e3v/ent7/3t7e/97fHv/e3x8/3x8fP98fHz/fHx9/3x9ff98fX3/fH19/3x9ff98fX3/fX1+/31+fv99fn7/fX5//35/f/9+f3//f3+A/39/gP9/gID/f4CB/4CAgP+AgIH/gICB/4CBgf+AgYH/gIKC/4CBgv+BgoL/goKB/09ddv87UoD/RV6M/0pll/9QbaH/U3Oq/1Z3rv9Ibqn/h5i1/97Wz//Tzsv/2dTP/+zm4v/r5OH/6+Xi/+vl4v/r5eL/6+Th/+rl4f/r5eL/6+Xi/+vl4f/r5eP/7Obl/+zn4//u6eb/7+nn/+7p5//u6ef/7+no/+/p5//u6Of/7ufm/+3m5v/t5ub/7Obk/+vl4//s5eP/6+Tj/+vl4//r5eT/7Obm/+7n5//v6uf/8Ozp//Hs6v/x7Ov/8Ozq//Ds6v/w7Or/8Ozr//Ds6//w7Ov/8Ozr//Ds6//x7Ov/8ezr//Hs6//w6+v/8Ovs//Dr7P/x7Ov/8Ovr//Dr6//v6ur/7+ro/+7p5//u6ej/7ejn/+7n5v/s5uX/7efm/+3n5v/s5uX/7Obl/+zn5f/t6OX/7enl/+zn5f/n4eD/39rZ/97Y1v/d1tX/2tTT/9nT0v/W0M7/1M3M/9DKyv/OyMf/y8XD/8jCwf/CvLv/v7q5/765uP+7tbT/u7W0/764uP/Ev73/zcfE/9HLx//Qy8b/zcfE/8G7uf+wqqn/qKOi/5qUk/+gm5r/oZuZ/5+Zlv+ln5z/q6Og/2pmZ/9pZmf/xLy6/93X1f/t5+b/4Nra/8O8vf+xq6v/ubKx/9HKyP/f2df/7ujm//Tv7f/u6ef/2dPS/7mysv+jnJ3/nJaW/66opf/Bu7f/ycO+/8fBvf/Dvbr/xr+8/9LLyP/i3dn/7urm//Ht6v/w6+j/6+bi/+Pd2f/a1dH/0szI/87Jw//OyMP/zcfC/8rEv//Fv7r/vriz/66opP+hm5f/enp7/3p7e/97e3v/e3t7/3t7e/97e3v/e3x7/3x8fP98fH3/fHx8/3x9ff99fX3/fH19/319ff98fX3/fX1+/319fv99fn7/fX5+/35/f/9+f3//fn+A/39/gP9/f4D/gICA/4CAgf9/gIH/f4CB/4CBgv+AgYL/gIKC/4GCgv+BgoL/gYKD/4OEgv9TYHX/OlJ+/0Zfjf9OaZr/UnGl/05vpv9ScKP/YX2o/7C0vv/d1c//087K/9vW0v/t5+P/6+bi/+vl4v/s5eL/6+Xh/+vl4f/r5eL/6+Xi/+zm4//s5uP/7efk/+3n5v/u6eb/7unn/+7p5//w6un/7+np/+/p6f/v6Oj/7ujo/+7n5//u5+f/7ufm/+3m5f/s5uX/7OXl/+zl5P/r5eT/6+bk/+zm5f/u6Of/7+ro//Dr6f/x7Ov/8ezr//Hs6//w7Ov/8Ovs//Dt7P/w7ez/8Ozs//Ht7P/x7ez/8e3s//Hs7P/x7Oz/8Ozs//Hr6//w7Oz/8Ozr//Hs6//w7Ov/8Ozq/+/r6v/u6ej/7uno/+/p6P/t5+f/7efm/+7n5v/t5+b/7Obm/+3m5v/t6OX/7enm/+7q5//t6OX/6OLh/+Ld2//g2tn/39nZ/93X1//c1dX/2dPS/9jR0P/Tzcz/0cvJ/8/Jx//LxsT/x8LA/8G7uv/Bu7r/vri3/723t//Bu7r/yMG//87Ixv/Uzsv/0czI/8vEwv+/uLf/s62s/66op/+noaD/pZ+d/6Odm/+gmZb/q6Si/7Gpp/+Nh4f/c25u/7Grqf/Vzcv/5uHf//Dr6f/b1tX/v7i5/62np/+1rq3/zcbD/93W1P/t5+b/9O/t/+7p5//X0dH/tq+w/6Camv+alJT/rKek/764tP/Evrr/xL67/8W+u//Jwr//1s/M/+bg3P/v6+f/8e3q/+/q5v/o49//3tjU/9PNyP/LxsD/ysO//8jCvf/GwLr/wLq1/7q1r/+tqKP/oJqW/3t7e/97e3v/e3t7/3t7e/97e3v/e3x8/3x8fP98fHz/fH19/3x9ff98fX3/fH19/319ff99fX7/fX1+/319fv99fn7/fn5//35/f/9+f3//fn+A/35/gP+AgID/gICB/4CAgf+AgIL/gIGB/4CBgf+BgYL/gYKC/4GCgv+BgoP/gYKD/4GDg/+EhYL/V2J0/zpQe/9FXIn/RmKQ/1t0nv+MmrT/v8LL/+Le3P/Z0s7/1tDM/9TOyv/g2tb/7ujk/+zn4//s5uP/7efk/+zm4//s5uT/7efk/+3n5P/t5+X/7ujl/+7p5v/u6ef/7+nn/+/p6P/v6un/7+np/+/p6v/v6ej/7+np/+/p6f/v6en/7+jn/+7o5//u5+b/7ebm/+zm5f/s5eX/7Obk/+zm5P/t5+b/7+jo/+/q6P/w7Or/8e3r//Ht7P/x7ev/8ezs//Ds7P/w7ez/8e3t//Ht7f/x7e3/8e7t//Ht7f/x7u3/8e7t//Hu7f/x7u3/8e7t//Ht7P/w7Oz/8Ozr//Ds7P/w7Ov/7+vq/+/r6v/v6un/7+np/+/p6P/u6Oj/7ujo/+3n5//t5+b/7ejm/+7p5//u6ef/7unm/+vm5P/m4d//493c/+Lc3P/f2dr/39nZ/9zW1f/a09P/19HQ/9TOzf/SzMz/0MrJ/8rFw//HwcD/wby7/8K8u//Aurr/xb++/8zFw//Ry8j/1dHN/9LNyv/IwsH/vri3/7StrP+yq6v/r6mo/6qkov+inJr/pJ6b/7Osqf+xqqn/lJCP/5KLi/+gmZf/y8TA/93W1P/s6Ob/8e3r/9rU1P+6tLT/qKGi/7Osq//Lw8L/2dPR/+zn5f/08O7/7+rp/9bQz/+yraz/nZiY/5qUlP+uqKX/vLay/8C5tf/Aurb/xb66/83Hw//c1tP/6uXh//Dr6P/x7On/7ejk/+Xf2v/Z08//zsjE/8jBvf/CvLf/wbu2/764s/+2sKv/rqmj/6Kcl/97e3v/e3t7/3t7e/97e3v/e3x8/3t8fP98fHz/fH19/3x9ff98fX3/fH19/319ff99fX7/fX5+/319fv99fX7/fn5+/35+f/9+f3//fn9//35/gP9/gID/gICA/4CAgf+AgIH/gICB/4CBgf+BgYL/gIGC/4KCg/+CgoP/goOD/4KDhP+Cg4T/hoeF/2BndP8tQmn/QVV4/4mUp//U1Nb/9e/q//bw7P/q5eL/19DN/9fQzP/X0M3/5d/a/+7p5f/t6OT/7efk/+3o5P/s5uP/7efk/+3n5f/u6Ob/7+nn/+7o5//u6Of/7+no/+/q6f/w6+r/8Ovr//Dq6v/w6ur/7+rp//Dr6v/v6en/7+np/+7o6P/v6Oj/7ujn/+7n5v/s5uX/7Obl/+zm5P/s5+T/7Ojl/+7o5//v6uj/8Ovq//Lt7P/x7ez/8O3s//Ht7P/w7ez/8O3t//Hu7v/w7u3/8e7t//Lv7v/x7u7/8O3t//Hu7f/x7u3/8e3t//Ht7f/x7e3/8e3t//Ht7P/w7Oz/8Ozr/+/r6v/v6+r/7+rp/+/q6f/u6ej/7ujo/+7o6P/u6Of/7ufn/+3o5//v6en/7+no/+/q6f/r5ub/6OLj/+bg4P/k3tz/4dva/+Da2f/f2dn/3dXW/9rT0//X0dD/1c/O/9LMzP/MxsX/yMHB/8S+vv/Dvb3/w728/8jCwf/PyMb/0szK/9fRzf/Uz8z/xb6+/7iysv+zrKz/s6yr/7Grqf+qo6L/o52b/6umo/+6tLH/ta+t/4J+fv+el5f/p5+e/66mpf/Vzcv/4NrZ//Hs6//x7ev/1s/P/7Wur/+ln5//tK2s/8vDwv/W0M//6ePi//Tw7f/v6uj/083M/66oqf+clpb/m5WU/6+qp/+9trL/vri0/763s//Evbn/0crH/+Hc2P/t5+T/8ezo/+/q5v/p5OD/3tjU/9DKxf/Hwbz/wbu2/764s/+5s67/saum/6qln/+gm5b/e3t7/3t7e/97fHz/e3x8/3x8fP98fHz/fHx9/3x9ff98fX3/fX19/3x9ff99fn7/fX1+/31+fv99fn7/fn5//35+f/9+f3//fn9//39/gP9+gIH/foCA/3+Agf9/gIH/f4GB/4CBgf+AgoL/gYKD/4KCg/+CgoP/goOE/4OEhP+EhIX/hYaH/4aGhf9iaHH/Z3KH/8PDx//z7en/8+3q/+vm5P/r5uP/497b/9nSzv/Z08//29XR/+ji3v/u6eb/7ujl/+3o5f/u6OX/7ujl/+3o5f/u6Ob/7+nn/+/p6P/v6en/8Orp//Dq6//x6+v/8evr//Dr6//x7Ov/8ezr//Dr6//w6+v/8Ovr//Hr6//w6ur/8Orq/+/p6P/u6Of/7ujn/+zm5v/s5ub/7ejm/+3o5v/v6ej/8Ovp//Hs6//x7e3/8e7u//Hu7v/x7e3/8e7u//Hu7f/x7u3/8e/u//Lv7v/x7u7/8e/u//Lv7//y7+7/8u/u//Lv7//y7u7/8e7u//Lv7v/x7u3/8e3s//Ht7P/x7ez/8e3r//Dr6//w6+v/8Orq/+/q6f/v6en/7+np/+7o6P/u6Oj/7+no/+/q6f/v6uj/7efn/+rk5P/n4eD/5eDf/+Tf3f/j3dz/4dva/+DZ2P/c1tb/2dPT/9rT0v/W0M7/0szL/8zHxf/Iw8L/xsDA/8fBwf/MxsX/0svJ/9XPy//Vz8v/0s3L/8K9vf+0r7D/s6ys/7Kqqf+tpqX/pp+d/6ehnv+1sKz/v7q3/7ixsP9pZ2n/lZCP/8K7uv+im5z/tK6s/9TNy//h29r/8+7s/+/q6P/PyMj/rqio/6Gcm/+4srH/ycPB/9PNy//n4uD/9O7s/+7p5//Pycn/rKam/5uVlf+cl5T/sKqn/7u1sf+9t7L/vrez/8fAvP/Y0s7/5+Le/+/q5v/w6+f/7ejk/+Tf2v/Vz8v/x8C7/723sv+6tK//ubOu/7Grpv+oo53/npiU/3t7e/97e3v/e3x8/3t8fP97fHz/fHx8/3x9ff99fX3/fX19/319ff99fX7/fX5+/31+fv9+fn7/fn5//35+f/9+f3//fn9//35/gP9/gID/f4CA/3+Agf9/gYH/f4GB/4CBgv+AgYL/gIKC/4GCg/+DgoT/g4OE/4ODhf+EhYX/hoaH/4KDg/+PkJD/vLu7/+nl4v/y7Of/7Obk/+rl4v/q5eL/6+Xj/9/Z1v/a1ND/29XR/97Y1P/p49//7unm/+/p5v/u6eX/7unl/+7p5v/u6ef/7+no/+/o6P/v6en/8Orq//Dq6v/w6+v/8Orq//Hr6//w7Ov/8Ovr//Ds6//x7ez/8ezr//Dr6//w6+v/8Orq//Dq6v/v6en/7ufn/+7o5//t5+f/7Obm/+3n5//t6Of/7uno//Dr6v/w7Ov/8e3t//Lu7f/x7e3/8e3t//Hu7v/x7u7/8e/u//Hv7v/x7+//8e/u//Hv7v/y7+//8e/u//Hv7v/y7+//8e7u//Hu7v/y7u7/8e7u//Hu7f/w7ez/8O3s//Dt6//w7Ov/8Ovr//Dr6//v6un/7+rp/+/q6v/u6en/7ujo/+/p6f/w6un/7+rp/+7p6P/s5ub/6eTi/+fi4P/l397/5N7d/+Lc2//h29r/39nZ/9vV1v/b1NX/2dLS/9PNzf/Pycj/zcjG/8nEw//KxMP/z8nH/9PNy//Y0s//19HN/9LMyv+/uLn/squt/7OsrP+up6f/pp+d/6Ocmv+uqKX/v7q2/8S+vP+6tLL/W1td/3Z0df/c1NP/uLKy/6CZmf+2r63/0cnI/+Lc2v/08O7/7Ofl/8fAwf+noqL/op2c/7y1s//KwsD/0MjH/+Te3P/07+3/7ejm/8vExP+po6P/l5KQ/5+Zl/+zrar/urOv/7u1sf+/uLT/zsfC/+Da1v/r5eL/7+rm/+7p5f/o49//3NbS/8zFwP++uLL/s62o/7Grpv+vqaT/p6Gc/5uWkf97e3v/e3t8/3t8fP97fHz/fHx8/3x9ff98fX3/fX19/31+fv99fn7/fX5+/31+fv9+fn7/fn5//35+f/9+f3//fn5//39/gP9/f4D/f3+A/3+AgP+AgIH/f4GB/3+Cgv+BgYL/gIKC/4GDg/+Cg4T/hIOE/4SEhP+FhYb/hISF/4OEhP+qqaj/4N3b//Lu6v/s5uT/6+bj/+vm4v/q5eH/6eTh/+nk4f/e2NT/3NXS/9vV0f/h29f/6uTh/+/q5v/v6uf/7+rn/+/q5v/v6uf/7uro/+/q6f/w6+r/8Ovq//Hr6v/x6+v/8ezr//Hs7P/x7Oz/8e3s//Ht7P/x7Oz/8ezs//Ds6//x7Ov/8Ovr//Hr6//w6+r/8Orq//Dq6v/u6ej/7ejn/+3n5v/t5+b/7unn/+/p6P/v7Or/8O3r//Ht7f/y7u7/8u7u//Hu7f/y7u7/8e7u//Hv7//y8O//8vDv//Lw7//y8O//8vDv//Lw7//x7+//8u/v//Lv7//y7+//8O7u//Hu7v/x7u7/8e7t//Hu7f/x7u3/8e3s//Ds6//w7Ov/8ezr/+/q6v/v6ur/7+rq/+/q6f/v6ur/7+rq/+/q6f/u6ej/7Obm/+vl5f/p4+P/5+Lh/+bg4P/l393/49zb/+Hb2v/f2dj/3dfX/9rV1P/W0ND/0cvK/8/IyP/Ox8f/z8nJ/9HLyv/W0c7/2dTR/9nT0f/Qy8n/vLe3/7KrrP+yq6v/qaOi/6Kbmf+noJ7/uLGu/8W/vP/GwL7/trKw/29ub/9pZ2j/19HP/93Y1f+xqqv/nZaW/7y1s//TzMn/5d/d//Tw7v/n4eD/vrm5/6Cbm/+knp3/w7y5/8nCv//Ox8X/5d/d//Tv7f/q5eP/w728/6OdnP+XkY//pqCd/7exrf+4sa3/ubOv/8O8uP/Vzsv/5uDc/+3o5P/u6eX/6uXi/+Ld2P/SzMf/vrey/7Grpv+sp6L/qqWf/6OdmP+ZlI//e3t7/3t8fP98fHz/fHx8/3x8ff98fX3/fX19/319ff99fn7/fX5+/31+fv99fn7/fn9//35/f/9+f3//fn9//39/gP9+f4D/f3+A/3+Agf+AgIH/gIGB/3+Bgv+BgoL/gYKC/4GCg/+Cg4P/g4OE/4SFhf+Ghof/g4OE/4mKiv/Avr3/8Ozp//Hs6f/r5uP/7Ofk/+vm4//p5OD/6eTh/+rl4v/p5OH/3tjU/97X0//b1tL/493a/+vm4v/v6ub/8Ovo/+/q5//v6uf/7+ro/+/q6P/v6un/8Orp//Dr6v/w6+r/8ezr//Hs6//w7Ov/8ezr//Hs7P/x7ez/8O3s//Ht7P/w7Oz/8e3s//Hs6//x7Ov/8Ozr//Dr6v/w6+r/7+np/+3o5//u6Of/7ejn/+7o5//u6ej/8Ozq//Ht7P/y7u3/8u/u//Lu7v/x7u7/8u/v//Lv7//y7+//8vDv//Lw7//y8O//8vDw//Px8P/y8O//8vDv//Lw7//y8O//8u/v//Lw7//y7+//8e/v//Hv7v/x7u3/8e/t//Du7f/x7ez/8O3s//Hs7P/w7Ov/8Ozr//Dr6v/v6un/7+rq//Dr6v/w6+r/7+vp/+7p6P/s5+X/6+Xk/+nj4v/o4eH/5+Hg/+Tf3f/j3dv/4tva/97Y2P/c1tf/2dPT/9TOzv/SzMv/0MvK/9LMzP/Uzs7/2NLR/9vW0//b1tP/0MnI/7ixsv+yq6z/raen/6OdnP+hm5r/rKak/7+5tv/KxMH/xb+8/7OtrP9+fHz/dnR0/7+6uP/u6eb/0MrJ/6ihov+fmJj/wru5/9PMy//o4+D/9fDu/97Z2P+zra7/nZiX/6+ppv/Iwb7/ysPB/8/Jxv/n4eD/8+7s/+Td3P+6tLP/npmX/5iTkP+tqKT/ubKu/7iyrv+7tLD/ycK+/97Z1P/r5uL/7ujl/+rl4v/k39v/2NPO/8K8t/+tp6L/qKKd/6einf+fm5X/lpGN/3t8fP97fHz/fHx8/3x8ff98fX3/fX19/319ff99fn7/fX5+/31+fv99fn//fn9//35/f/9+f3//fn9//35/f/9/f4D/foCA/36Agf9/gIH/gIGB/4CBgv+AgYL/gIKC/4GCg/+Cg4L/goSE/4OEhf+Ghof/hISE/5GRkf/U0c7/8+3q//Dr6P/t6OX/7ejk/+zn4//q5eL/6eXh/+nl4f/s5uP/6+Xi/97X0//e2NT/3dbT/+Te2//s5+P/7+rn//Dr6P/w6+j/8Ovo/+/r6P/w6+n/8Ovq//Hs6//x7Oz/8e3t//Ls7P/x7Oz/8e3t//Lt7f/y7u3/8e7t//Hu7f/x7uz/8O3s//Dt7P/w7Ov/8e3s//Ht7P/x7Ov/8Ovq/+/q6f/u6ej/7ujn/+3o5//v6un/7+rp//Dt6//w7ez/8e7t//Lv7v/x7+7/8e7u//Lv7//y8O//8u/v//Lw7//y8O//8vHw//Lx8P/y8O//8fDv//Hw7//y8PD/8vDv//Lw7//y8O//8e/v//Hv7v/x7+//8e/u//Hv7//x7+//8e/u//Du7P/w7ez/8O3s//Ds6//w7Ov/8Ovr//Dr6//w6+v/7+rq/+/q6f/u6ej/7efm/+vl5f/p5eP/6ePi/+ji4v/n4eD/5d/d/+Pd3P/h3Nr/3tjY/9vU1P/X0dH/1M/O/9XPzf/X0tD/2dXS/9rV0//e2db/3tnW/9HMyv+4sbH/sKip/6ehof+dl5f/pp+f/7Svrf/Evrv/y8XC/8bAvf+xq6r/iISE/4yIh/+xq6r/39nX/+3o5v/Kw8T/opyd/6Wenf/Hwb//1tHO/+zn5f/x7Or/083N/6qkpP+dl5b/u7Wy/8vEwf/Iwr//0svK/+rk4v/x6+n/2dPR/6+pqP+alZL/npmV/7KtqP+3sa3/u7Sv/8G6tv/Uzcr/5t/c/+3n5P/s5+P/5eDb/9vU0P/Fv7v/rKei/6Oemf+inZj/nJeS/5SQi/98fHz/fHx8/3x8fP98fX3/fH19/319ff99fX7/fX5+/31+fv99f37/fX5+/35/f/9+f3//fn9//35/gP9+f4D/f4CA/3+AgP9/gIH/f4CB/3+Bgv+AgYL/gYKC/4CDgv+Bg4P/goOD/4KEhP+Fhob/g4SE/5WWlv/a2NX/9O7r/+7o5f/v6ub/7ejl/+zn5P/s5+P/6eTg/+jj3//s5+P/8ezo/+nl4P/d2NP/3tnU/97Y1P/m4Nz/7Ofj/+/q5//w7On/8ezp//Dr6P/w6+n/8Ovq//Hs6v/x7Ov/8ezr//Lt7P/y7ez/8e3s//Lu7f/x7e3/8e3s//Hu7f/y7u3/8u7t//Hu7f/x7u3/8e7s//Ht7P/x7ez/8Ozr//Dr6v/v6ur/7+np/+7p6P/t6Of/7uno/+/p6P/w6+r/8e7s//Hv7f/y7+7/8u/v//Lv7v/y7+//8u/v//Lw7//y8PD/8vDw//Lx8P/y8fD/8vDv//Lx7//y8O//8vDw//Lx8P/y8O//8vDw//Lw8P/y8PD/8vDv//Lw7//x7+7/8e/u//Hv7v/w7u3/8e/t//Hu7f/w7ez/8O3s//Dt7P/w7Ov/8ezs//Ds6//w7Ov/7+rp/+7p6P/t6Of/7Ofm/+vl5P/q5OP/6ePi/+bh4P/j3t3/497c/+Hb2//e19f/29XU/9rT0v/a1NP/29XU/93Y1v/e2db/4dzZ/+Hb2P/Qysj/trCw/6+nqP+fmZn/mpSU/6mjo/+4s7H/wry7/8jCwf/GwL3/sauq/4B9fv+Yk5H/squo/8rDwf/q5eP/7ujn/8O9vf+dmJj/raem/8zGxP/Z09H/7unm/+zn5P/GwMD/oZyc/6iioP/GwL3/y8TC/8bAvf/Uzsv/7efk/+zm5P/KxML/paCe/5iUkf+noZ3/ta+q/7avq/+8trH/zcbC/+Da1v/p5OD/7Ofj/+ji3v/e2NT/ycO+/6+qpf+fmpb/npmU/5qVj/+Tjor/fHx8/3x8fP98fX3/fH19/3x9ff99fX3/fX5+/31+fv9+fn7/fX9//35/f/9+f3//foB//36AgP9+gID/foCA/3+AgP9/gID/f4CB/3+Bgv9/goL/gIKC/4GCg/+Bg4L/goOD/4KEhP+DhYX/g4WE/4mKiv/S0M3/8+7q/+3o5f/v6eb/7unl/+3n5P/t5+T/6uXh/+ji3v/p5OD/7+vm/+3n4//h3Nf/39vV/+Db1v/f2tX/5+Le/+3o5f/w7Oj/8ezq//Ds6v/w7Or/8ezr//Ht6//x7er/8e3s//Ht6//y7ez/8e7t//Hu7f/y7e3/8e3t//Lu7f/y7u3/8e7t//Hu7f/x7+7/8e7t//Hu7f/x7uz/8O3s//Hu7P/x7ez/8Ozr/+/q6f/u6ej/7uno/+/q6f/w6+n/8Ozr//Hu7P/x7+7/8vHv//Lw7//y8O//8vDv//Lw7//z8PD/8/Dw//Lx8P/z8fD/8vHw//Lx8P/z8vH/8/Lw//Lx8P/y8fD/8vHw//Lx8P/y8PD/8vDw//Lw7//y8PD/8vDv//Lw7//x8O//8e/u//Hv7v/x7+3/8O7t//Dt7P/x7e3/8e3s//Ds6//w6+r/7+vq/+7q6f/u6uj/7eno/+zo5v/s5uX/6uXj/+nk4//o4uH/5uLf/+Tf3v/j3d3/4dva/9/Z2P/c1tX/3dfW/93Y1//e2tj/4NzZ/+Pf3P/j3dr/0cvJ/7Surf+tpaX/lpCQ/5qUk/+0rq3/wr28/8nDwv/Mx8X/ycTC/7Svrf9vbm7/mZOS/7Osqv/Fv73/19LP//Lu6//o4+L/vLW1/56Zmf+3sK//0MrI/97Z1v/v6uj/493c/7izs/+gnJr/uLKv/8vEwf/GwL3/x8C9/9zV0v/u5+X/493b/7q1sv+fmpf/nJaU/7Crpv+1r6r/t7Gs/8S+uf/a1M//5uHd/+rl4f/n4t7/3dfU/8vEwP+zrqn/oZyX/5mVkP+Xk43/k46K/3x8fP98fX3/fH19/3x9ff99fX3/fX19/31+fv9+fn7/fX9//35/f/9+f3//fn9//36AgP9+gID/f4CA/3+AgP9/gIH/f4GA/4CBgf+AgYL/f4KC/4CCg/+BgoP/gYOD/4KDhP+ChIT/g4aF/3+Bgf+trav/7Ofj/+zn4//u6eX/7+rm/+/p5v/t6OX/7Ofj/+nk4P/i3Nn/7ejk/+/q5//m4Nz/4NvW/+Hc1//g29b/4NzX/+nk3//u6eX/7+vo//Hs6v/x7Oz/8e3r//Ht7P/x7ez/8u3s//Ht7P/y7uz/8u7t//Lu7v/y7u7/8u7u//Pv7v/y7+7/8u7t//Lv7v/y7+3/8u/u//Lv7v/y7+7/8u/t//Hu7f/y7u3/8e3s//Hs6//w6ur/7+rp/+7p6P/u6ej/7+vq//Ds6//w7uz/8e/t//Lw7//y8O//8vDv//Lw7//y8PD/8vDw//Px8P/z8fD/8/Lx//Px8f/y8fD/8vHw//Lx8P/z8fD/8vHw//Lx8P/z8vH/8/Hx//Lx8P/y8fD/8vHw//Lx8f/y8fD/8vDv//Hw7//x7+//8e/u//Hu7v/x7u3/8e7t//Hu7f/x7e3/8e3t//Dt7P/v7Ov/7+vq/+7q6f/u6uj/7ejn/+zn5f/r5uX/6uTj/+nk4v/n4uD/5uHf/+Pe3P/i3Nz/39rZ/9/a2v/f2tr/4Nva/+Pe3P/m4t7/5d/c/9LMyv+2r6//qKGi/4+Jif+mn57/ycPC/97Z1//h3dv/3dnX/9LOy/+4s7L/amlq/6Gbmf+3sK7/wbu5/87Ix//d19b/9vHv/+Pd3P+0r6//n5qa/8C6t//Vz83/5N/d/+vm5P/RzMv/qqWk/6mkof/Iwr7/y8TB/8G7t//GwL3/39nX/+zn5P/Tzsv/q6ak/5qVkv+moJz/ta+q/7Suqf+9t7L/08zI/+Te2v/q5eH/5+Pf/9/Z1f/Jw7//sayn/6KdmP+YlI7/lZGL/5SPiv98fX3/fH19/3x9ff99fX3/fX19/31+fv9+fn7/fn9//35/f/9+f3//fn+A/36AgP9+gID/f4CA/3+BgP9/gYD/f4GB/3+Bgf+AgYL/gIKC/4CCgv+AgoP/gYOD/4KEg/+ChIT/g4SF/4SGhf+BhIP/wcC9/+vl4f/s5+P/7ejl//Dq5//u6OX/7ejk/+zm4//e2dX/5+Le//Lu6v/q5eD/497Z/9/a1f/j3tn/4d3X/+Pe2f/r5uL/7urm//Ds6P/y7ev/8ezs//Hs7P/x7ez/8e3s//Lu7f/x7u3/8u/u//Lv7v/y7u3/8e7t//Hv7v/y7+7/8e/u//Lv7v/y7+//8vDv//Lw7//x8O//8fDu//Hw7v/x7+7/8e7t//Hv7v/x7u3/8O3s/+/q6f/u6uj/7unp/+/r6f/v7Ov/8O7s//Hv7v/y8e//8vHv//Lw7//y8O//8/Dw//Lx8P/z8fD/8vHw//Lx8P/y8fH/8vHw//Py8f/z8vH/8vLw//Py8f/y8fD/8/Lw//Ly8f/y8fD/8vHx//Lx8f/y8fD/8vHw//Lx8P/x8PD/8fDv//Hw7v/x8O7/8e/u//Hu7f/x7u3/8e7t//Ht7f/w7ez/8Ozs/+/r6//u6+r/7uno/+3o5//t6Ob/6+fl/+rl5P/p5OL/6ePi/+ji4P/m4OD/5d/e/+Lc3P/h29z/4dzc/+Pe3f/l4d//6eXh/+fj3//RzMr/trCv/6Odnf+SjIv/urOy/9rT0v/o5OH/7eno/+jk4v/c2Nb/vrm2/29tb/+jnZv/w7y5/7u3tP/Tzcv/z8nH/+Xf3f/28O7/29XV/62oqf+inZ3/xr+9/9zW1P/p5eL/5N/d/723t/+jn53/urSx/9HKx//Nx8P/w726/8rEwf/j3dr/5N7b/8G8uf+hm5n/npmV/7Grpv+1r6n/uLKt/8vFwP/f2dX/5+Le/+fj3v/g29f/y8XB/66opP+hnJf/mJSO/5SPiv+Uj4r/fX19/319ff99fX3/fX59/31+fv9+fn7/fn5+/35/f/9+f3//fn+A/36AgP9/gID/f4CA/3+AgP9+gID/f4GB/3+Bgf9/gYH/gYKC/4GCgv+BgoP/goOD/4KDhP+Cg4T/gYSE/4OEhf+Fhob/gYOD/7a1sf/o497/6+bi/+7p5f/v6ub/7ujk/+3o5P/h29j/39rW//Hs6f/t6OT/5d/c/9rV0P/e2tX/5uHb/+Pf2v/l4d3/7Ojj/+/r5//x7On/8e3s//Lt7f/x7e3/8u7t//Lu7f/y7+7/8u/u//Lv7v/y7+7/8e/u//Lw7//y8O//8u/u//Lw7//y8O//8vDv//Lw7//y8O//8fDv//Lx7//y8O7/8e/u//Hv7v/x7+3/8e/u//Du7P/v6+r/7uvp/+7q6v/v6+r/8Ozr//Du7f/x7+7/8vHv//Lx8P/y8fD/8vHw//Lx8P/z8fD/8/Hx//Py8f/z8vH/8/Hx//Py8f/y8fH/8/Lx//Ly8f/y8vD/8vLw//Lx8P/y8fD/8vHw//Lx8f/y8fD/8vHw//Lx8P/x8O//8vHw//Lw7//x8O//8e/u//Hw7v/x7+7/8O7t//Hu7f/x7u3/8O3s//Ds7P/w7Oz/7+vq/+/r6v/u6+n/7enn/+zo5//t6Ob/6+bk/+rm5P/o4+L/6OLh/+Xf3//j3d3/4dvc/+Lc3P/k393/6OPh/+nl4f/o5OD/087M/7izsv+gm5z/mZSU/8fBv//e2Nb/5+Ph/+/s6v/s6Of/4t7c/8TAvf90cnP/n5mY/9LLyf++uLb/zMbE/9TOy//Ry8r/6+Xk//Pu7P/Vz8//q6Wm/6mkpP/Qy8j/5N/d/+jj4f/Uzs3/raem/6qlov/Evrv/z8jF/8/Jxf/Hwr7/0szJ/+Ld2f/Vz8z/r6mm/5yXlP+ppJ//tK6p/7Wwqv/Fv7r/2tXQ/+Xg3f/m4t7/4NvX/87Iw/+tp6L/nJiT/5eTjv+Tj4r/k46J/319ff99fX3/fX19/31+fv99fn7/fX5+/35/f/9+f3//fn+A/36AgP9+gID/foCA/3+AgP9/gYH/f4GB/3+Bgf9/goH/f4KC/4GCgv+BgoL/gYKD/4GCg/+Cg4P/goSE/4KEhf+DhYX/hIaH/4CDg/+ioqD/5N/a/+zn4v/t6OT/7+rm/+7n5P/o4t//3NfT/+rl4f/x7Oj/5+Le/9zW0//e2tX/5eHc/+bi3f/m4d3/6eTg/+3o5f/v6+n/8ezr//Ht7f/y7e3/8u7t//Lu7v/x7u3/8u/t//Lv7v/y7+7/8vDu//Lw7//y8O//8vDv//Lv7v/y8O//8vDv//Lw7//y8O//8vDv//Hw7//y8O//8fDu//Hw7v/x8O7/8e/u//Lv7v/w7u3/7+vq/+7q6f/u6un/7uvq/+/s6//w7ez/8e/t//Lw7//y8e//8vHw//Lx8P/y8fD/8vHw//Px8P/y8fD/8vHw//Px8f/z8vH/8/Lx//Py8f/z8vH/8/Px//Pz8f/z8vH/8/Lw//Py8f/z8vH/8/Hx//Py8f/z8fH/8vHw//Px8P/y8fD/8vDv//Hw7//x8e//8e/u//Hv7v/x7+7/8O7u//Du7f/w7e3/7+zs/+/s6//v6+r/7+vq/+3p6P/s6Of/7Ojm/+vm5P/q5uT/6eTj/+jj4v/m4OD/493d/+Pc3f/j3d3/5uHf/+nl4f/r5+T/6+bi/9XQzv+5tbT/op6f/52Zmf/FwL7/2dTT/+bh3//x7er/7uvp/+fj4f/LxsX/fHp7/5WRkP/X0M7/zsjG/8fBv//Uzs3/zcjH/9XPzv/v6ej/8Ovp/9HLy/+opKT/sayr/9rU0v/o4+H/4dza/8K7u/+qpaP/ubSw/8bBvv/LxcL/y8XC/8zGw//Y0s//29bS/764tf+inJn/op6Z/7Grpv+0rqn/wbu1/9XPyv/j3tn/5uHd/+Hb1//Nx8L/rqmj/5qWkf+Wko7/ko2J/5OOif99fX3/fX1+/31+fv99fn7/fn5+/35/f/9+f3//f3+A/3+AgP9+gID/f4CA/3+AgP9/gIH/f4GB/3+Bgf+AgYH/f4KC/4CCgv+BgoL/gYKC/4KCg/+Cg4P/goOD/4GEhP+DhIX/hIWF/4SGhv+ChIT/lJWU/93Y1P/r5eD/7enk/+zo4//r5uL/4t3Z/+Lc2f/x6+j/7efk/9/a1//f2db/6+fj/+bh3P/p5OD/6OTg/+vm4v/u6uf/8ezq//Ht7P/y7u3/8+7u//Lu7v/y7u3/8u/u//Lw7//x8O//8vDv//Lw7//x8O//8vDv//Lw7//y8O//8vHw//Lw7//y8PD/8vDv//Lw8P/y8fD/8fDv//Hw7//x8O//8fDv//Lw7//x8O//8e/u/+/t7P/u6+r/7urp/+/r6v/w7ez/8O3s//Hv7v/y8O//8vHw//Lx7//z8vD/8vHw//Lx8P/z8vH/8/Hx//Px8f/z8vH/8/Lx//Py8v/z8vH/8vLx//Py8f/z8/H/8/Px//Py8f/z8vH/8/Lx//Px8f/z8fH/8vHw//Py8f/y8fH/8vHw//Hx7//y8e//8vHv//Lx7//x8O//8e/u//Hv7v/x7+7/8e7t//Dt7f/w7ez/8Ozs/+/r6v/u6+n/7uvp/+3p5//s6Of/6ubl/+rm5P/p5OP/5+Hh/+Pe3v/j3d3/5N7f/+ji4f/r5uP/7Ojl/+vn5P/X09H/u7e3/6mlpf+hnJz/v7q5/9LMzP/j3t3/8e3r//Ds6v/r5+X/0s3L/4SBgv+Nion/zcbE/9jS0P/Pycf/1M7N/9TOzf/KxMT/29XV//Dr6f/s5uX/ysTE/6ijo/++uLf/4dzZ/+fh4P/Uzc3/ta+u/7Swrf/Hw7//ycTA/8jBv//Hwb7/0MvH/9nT0P/NyMT/rKek/6GcmP+spqL/sayn/7u2sf/Szcf/4tzY/+Xg3P/h3Nf/zcfD/6ulof+ZlZD/lZGN/5CMiP+TjYj/fX1+/31+fv99fn7/fX5+/35/f/9+f3//fn9//39/f/9/gID/f4CA/3+AgP9/gIH/f4GB/3+Bgf9/gYH/gIGB/3+Bgv9/goL/gYKC/4GCg/+Cg4P/gYOD/4GEhP+ChIT/g4SF/4OFhf+Ehof/g4WF/4uNi//Tz8v/7Obi/+rl4P/p5OD/6+Xh/97Y1f/q5uH/8uzo/+fh3f/c1tP/7enl/+zo5f/m4d3/6uXh/+nl4v/s6OT/7+vp//Hs6//y7e3/8u7u//Lu7v/y7u7/8u/v//Lv7//y8O//8e/v//Hw7//x8O//8fDv//Lw7//y8fD/8vDw//Lw7//y8PD/8vHw//Lw7//y8PD/8/Hw//Lx8P/y8fD/8vDv//Hw7//y8PD/8vDv//Hv7v/w7ez/7+zr/+/r6v/v6+r/7+zr//Dt7P/x7+7/8vDv//Lx8P/z8fD/8/Hw//Lx8P/y8vD/8/Lx//Py8f/z8fH/8/Lx//Py8f/z8vL/8/Ly//Py8f/z8vL/8/Py//Py8f/z8vH/8/Lx//Py8f/z8vH/8/Ly//Py8f/y8fD/8/Hx//Px8f/y8fH/8vHw//Lx8P/y8e//8fDv//Hw7//x8O//8e/u//Hv7v/w7u3/8O3s//Dt7P/v7Ov/7+vq/+3q6P/t6Of/7ejn/+vn5f/q5eT/6uXk/+fi4f/k3t7/5d/f/+bf4P/p4uL/7Ojm/+3p5//t6eb/29fV/7u2t/+tqan/paGh/7m1tP/Mx8b/39rZ//Ds6v/x7ez/7uro/9nV0/+MiYn/ioaG/8O8u//Uzc3/2NLR/9bQzv/a1NP/083M/87Jx//i3Nr/8Ovq/+bg3//Aurv/qaOk/8rDwv/n4N//39nY/8O+vv+zr63/wr25/83HxP/Jw8D/w767/8nCv//Uzsr/0cvI/7iyr/+ln5v/qqSg/66ppP+2sKv/zcfC/97Z1f/l4Nz/4NvX/83Hw/+rpaD/mZSQ/5WRjf+QjIf/k42I/31+fv99fn7/fn5+/35/f/9+f3//fn9//35/f/9/gID/f4CA/3+AgP9/gIH/f4GB/4CBgf9/gYL/f4GC/4CBgv9/goL/f4KC/4CCgv+BgoP/gYOD/4KDhP+Bg4T/goOE/4OEhf+DhYX/hIaG/4SGhv+Gh4f/y8fD/+vl4P/k39v/6+bi/+fg3P/g29j/8e3p/+/q5v/e2dX/5+Lf//Ht6v/n49//5+He/+vn5P/s6OT/7urn//Ds6//x7u3/8u7u//Lv7v/z7+//8u/v//Lw8P/y7+//8vDw//Lx8P/y8fD/8vDv//Lx8P/y8e//8vHw//Lx8P/z8fD/8/Hw//Px8P/y8PD/8/Hw//Lx8P/y8fD/8vDw//Hw7//x8O//8vHv//Lw7//x7+//8O7t/+/r6//u6+r/7uvq/+/s6//w7e3/8e7u//Lw7//y8fD/8vHw//Lx8P/z8vD/8vLx//Px8f/z8vH/8/Hx//Lx8P/z8fH/8/Ly//Py8v/z8vL/8/Ly//Py8f/z8vH/8/Lx//Ly8f/z8vH/8/Ly//Py8f/z8vH/8/Hx//Px8f/z8fH/8/Lx//Px8f/y8fD/8vDv//Hw7//y8O//8fDv//Hw7//x7+7/8O7u//Du7f/w7ez/7+zs/+/s6//v6+r/7urp/+7q6f/t6ef/7Ofm/+vm5f/p4+P/5uDg/+Xf4P/m4eH/6ePj/+3o5//v6+n/7uro/+Le3P/BvLz/sKys/6yoqP+5tbX/ysTE/97Y1//x7ev/8/Du//Ds6v/h3Nv/lpOU/4aCgv/Burr/0cvL/9LMzP/Uz83/2NLR/9nU0//Uzs3/1c/O/+fh4P/w6un/4Nra/7q0tf+vqar/1M7N/+Xf3f/W0M//u7a1/7ezsf/JxMD/zMbC/8fAvf/Evbr/zcfE/9LMyf/Au7f/qaSg/6mkof+wqqX/s62o/8nDvv/c19L/4tzY/+Da1//Mx8P/qaOg/5iUj/+VkYz/kIyH/5OOiP99fn7/fn5//35/f/9+f3//fn9//35/f/9/f4D/f4CA/3+AgP9/gIH/f4GB/3+Bgf+AgYH/gIGC/3+Bgv+AgYL/gIKC/4CCgv9/goP/gIOD/4CDhP+Ag4T/goOE/4OEhf+DhIX/g4WF/4SFhv+Fh4f/goWF/768uf/m4Nz/5d/c/+3n4//h3Nf/6OLf//Pu6v/m4d3/497b//Lt6v/t6OT/4NvX/+fi4P/s6OT/7enm/+/r6f/w7ez/8e7t//Lu7v/y7+//8u/v//Lw7//y8PD/8vDw//Lw8P/y8fD/8vHw//Lx8f/y8fD/8/Hw//Py8f/y8fD/8/Hw//Lx8P/y8fD/8vHx//Lx8P/z8fH/8/Hx//Lx8P/y8fD/8vHw//Lx8P/y8fD/8vDv//Hv7v/v7ez/7+zr/+/s6//w7ez/8O7t//Hv7v/y8O//8vDw//Px8f/z8vH/8/Lx//Py8f/y8fH/8/Lx//Px8f/z8fH/8/Lx//Py8f/z8vL/9PPy//Ty8v/z8vL/9PPy//Py8v/z8/H/8/Lx//Py8f/y8vH/8/Ly//Py8f/z8vH/8/Lx//Py8f/y8fH/8/Lx//Lx8P/y8fD/8vHw//Hw7//x8O//8fDv//Hv7v/x7u7/8e7u//Dt7f/w7ez/7+zr/+7r6v/t6ej/7eno/+zn5v/q5uX/6uTj/+jj4v/o4uH/6OLj/+rl5f/v6+n/8Ozr//Ds6v/o5OP/zsrK/7iztP+yra3/v7q6/8vFxf/d19b/8O3r//Tx8P/y7u3/6OTj/6Kfn/+EgIH/uLKy/9XPzv/X0tL/0MrL/9HLzP/Vz8//1tDQ/9XPzv/a1dP/6+Tk/+7p6P/a1NT/ta6v/7eysf/a1dP/493c/8/Jyf+1sbD/vLe1/8vFwf/LxcH/xb66/8fAvf/Qysb/x8K+/7CrqP+qpKD/sqyn/7KtqP/Fv7r/2tTQ/+Lc2P/d2NT/ycTA/6einv+Xk4//lJCL/5GNiP+Uj4r/fn5//35/f/9+f3//fn9//35/f/9+f4D/f4CA/3+AgP9/gIH/f4CB/3+Bgf9/gYH/gIGB/4CBgv+AgYL/gIGC/4CCgv+AgoL/gYKD/4GDg/+Bg4P/gYSE/4KEhf+ChIT/g4SF/4SEhf+DhYf/hYeI/4GEhP+sq6n/4tzZ/+bh3f/r5eH/4NvX/+/q5v/w6ub/4t3Z/+/q5//x7On/4NrX/9rV0v/q5eL/7ejm/+7q6P/w7Oz/8e7t//Lv7v/z7+//8/Dv//Lw7//y8PD/8vDw//Px8P/y8PD/8vDw//Lx8P/y8fD/8vHw//Lx8P/y8fD/8vHw//Lx8P/y8fD/8/Hw//Px8f/z8fH/8/Hx//Px8f/y8PD/8vDw//Lx8P/y8fD/8vHw//Hw7//x7+7/7+3s/+/s6//u7Ov/8Ozs//Dt7f/x7u7/8e/v//Lw8P/y8fD/8/Lx//Py8f/z8vH/8/Lx//Px8f/z8vH/8/Hx//Px8f/z8fH/9PLy//Py8v/08vL/9PLy//Py8f/z8/L/8/Ly//Py8v/z8vH/8/Lx//Px8f/z8fH/8/Hx//Px8f/z8fH/8vHx//Lx8P/y8fD/8vDw//Lw7//x8O//8fDv//Hw7//x7+//8O7t//Dt7f/w7e3/7+zr/+/r6//v6+v/7urp/+7p6f/t6ej/6+fl/+vm5f/p4+P/6OLj/+nj5P/q5OT/7+vq//Ht7P/x7ez/7ejn/9vW1v/FwMH/v7q7/8bAwf/Nx8f/3tjX//Ds6v/18vD/8+/v/+7q6P+xrq7/h4OF/7awsP/JxMP/3NbV/9vV1f/Uzs7/087N/9LMzP/TzMz/1c/P/97Z2f/r5uX/7Obl/9TNz/+zra7/v7q6/9zW1f/e19b/ycPC/7m0sv/Dvbv/y8XC/8jCv//Gv7z/ysTA/8nDwP+3sa7/rKWi/7Cqpv+0rqr/wry3/9fQzP/f2db/3tjU/8fBvP+kn5v/l5OP/5SPi/+RjIj/lI+K/35/f/9+f3//fn9//35/f/9+f4D/f4CA/3+AgP9/gID/f4CB/3+Bgf9/gYH/gIGC/4CBgv+AgYL/gIKC/4CCgv+AgoP/gIKD/4GCg/+Cg4P/gYOE/4KEhP+DhIX/g4SE/4SEhf+DhIb/hIaG/4WHiP+ChIX/nZ2c/93Y1f/r5eH/5+Hd/+bg3P/z7un/6OLe/+nk4P/z7ur/49/b/9rV0v/c19T/6+bk/+7q5//v6un/8Ozs//Hu7f/y7+//8vDv//Lw8P/y8fD/8/Hx//Px8f/z8fH/9PLy//Px8f/z8vH/8/Lx//Py8f/z8fH/8/Lx//Py8f/z8fH/8vHx//Lx8f/z8fH/8/Hx//Py8f/z8fH/8vHx//Lx8f/y8fH/8vHw//Ly8f/y8fD/8e/v//Du7f/v7Oz/7+zs/+/s7P/w7e3/8e/u//Lv7//y8PD/8/Hx//Px8f/z8vH/8/Lx//Py8f/z8vH/8/Hx//Px8f/z8fH/9PLy//Py8f/z8vL/8/Ly//Py8v/z8/L/8/Ly//Py8v/z8vH/8/Lx//Py8v/z8/L/8/Lx//Py8f/z8vH/8/Ly//Py8f/z8fH/8/Lx//Lx8f/y8fD/8vHw//Lx8P/x8O//8vDv//Lw7//x7+7/8e7u//Hu7v/v7Oz/7+zr/+7r6v/t6un/7eno/+zo5//s5+b/6+bl/+rl5f/q5uX/6+bm/+/r6v/y7u3/8u7t/+7q6f/g29v/zMfI/8jCxP/Jw8X/zsfI/+DZ2P/u6uj/9PHw//Tx8P/y7u3/wsC//4aEhP+3srL/xb+//9PNzf/e2Nj/3dfX/9nT1P/Y0tL/1M3O/87Iyf/Uzs7/4tzb/+3n5v/p4uP/zsfI/7awsf/HwsH/3NXU/9XQzv/Gv77/v7m3/8fAvv/Jw8D/x8K+/8fBvv/GwL3/vLay/6+qpv+vqaX/s66p/8G7t//W0Mv/3dfT/9rV0f/Ev7v/op6a/5WSjv+Tj4v/ko6K/5WQi/9+f3//fn9//35/f/9+f4D/f4CA/3+AgP9/gID/f4CB/4CBgf9/gYH/gIGB/4CBgv+AgYL/gIKC/4CBg/+AgYL/gIKD/4GDg/+BgoP/gYOE/4KDhP+ChIT/goSF/4OEhf+DhYX/hIWG/4SGhv+Fh4j/hIWH/5OTk//Y09D/7ujk/+Te2//s5+P/8Ovn/+bg3P/x6+f/5eDc/+Hc2f/i3Nn/3dbV/+7o5//v6en/7+vr//Ht7f/y7u3/8fDv//Lx8P/y8fD/8vHw//Lx8P/z8fH/8/Hx//Px8f/z8fH/8/Hx//Px8f/z8vH/8/Lx//Py8f/z8vH/8/Lx//Py8f/z8vH/8/Lx//Px8f/z8fH/8/Hx//Px8f/z8fH/8vHx//Px8f/z8vH/8vHw//Hw7//x7+7/7+3s/+/t7P/v7Oz/8O3t//Hv7//y7+//8/Hw//Px8f/z8vH/8/Lx//Py8v/z8vL/8/Lx//Py8f/z8vH/8vHw//Py8f/08vL/9PLy//Ty8v/08vL/9PLy//Tz8v/z8vL/8/Py//Py8v/z8vL/8/Ly//Py8v/z8vH/8/Hx//Px8f/z8fL/8/Hx//Px8f/y8fH/8vHw//Lx8P/y8fD/8vDw//Hv7//x7+//8e7u//Du7f/w7u3/8O3t/+/s7P/u6+v/7uvq/+7q6f/s6Of/7Ofn/+vm5v/q5uX/6ubl/+zn5//v6+v/8u7t//Pv7v/w6+v/497e/83Iyv/Iw8T/ycLE/9HLy//k3t3/7+vp//Tx7//18vH/9PDv/9LPzv+Gg4T/saur/8rDw//Mxsb/2NLS/97Y2P/b1db/29XW/9zW1v/X0dH/zsnJ/9TOzv/j3dz/6+Tk/+Td3v/IwcP/ubO1/87Ix//Y0dD/0szL/8XAvv/Dvbr/xsG9/8XAvf/Iwr//x8C9/7y2s/+xq6j/sauo/7Otqv++uLT/1M3J/9zX0//Y0s//vrm1/5+bmP+Vko7/k4+L/5SQi/+WkYz/fn9//39/f/9/f4D/f4CA/3+AgP9/gID/f4CA/3+Bgf+AgYH/gIGB/4CBgv+AgoL/gIKC/4GCgv+AgoP/gIKD/4GCg/+Ag4T/gIOD/4GDhP+Cg4T/goSE/4OEhf+DhYX/goWF/4SFhv+Ehof/hYeI/4WHh/+MjY3/087M/+7n5P/k3tv/8ezo/+vm4f/s5uL/7Ofi/+Da1//v6eb/3tjV/+Db2f/w6+r/7+rr//Hs7P/x7u7/8e/v//Hw8P/y8fH/8/Lx//Py8f/z8vH/8/Lx//Py8f/08vL/9PLy//Py8v/z8vH/9PLy//Ty8v/z8vH/8/Ly//Py8f/z8vH/8/Lx//Py8f/z8vL/8/Ly//Py8v/z8fH/8/Lx//Py8f/z8vH/8/Hx//Lx8P/y8PD/8e/u/+/t7f/w7e3/8O3t//Dt7f/x7u//8u/v//Lw8P/z8fH/8/Lx//Py8v/z8vL/8/Lx//Py8f/z8vH/8/Lx//Lx8P/y8fH/8/Lx//Py8v/z8fL/9PLy//Ty8v/08vL/9PPy//Tz8v/08/L/9PPy//Pz8v/08/L/8/Ly//Py8f/z8vL/9PLy//Py8f/z8vH/8/Hx//Lx8P/y8fD/8vHw//Lx8P/y8O//8fDv//Hv7//x7+//8e7u//Dt7f/v7Oz/7+zs/+7r6//u6+r/7enp/+zo6P/s6Of/6+bm/+zn5v/t6Oj/8Ovr//Lu7f/z7+//8e3s/+Xg4P/Qy8z/ysTF/8nBw//Uzc7/5uDg/+7q6f/08O//9vPy//Xx8P/h3d3/ioaI/6Odnv/PyMj/0MnJ/9HLy//c1tb/3tjY/9zW1v/b1tX/29XW/9nT0//SzMz/2NLS/+Pd3f/o4uH/3dfX/8S+v//Aurr/z8nI/9TOzf/Pysf/x8LA/8O+u//Ev7z/xL+7/8fBvv/Burf/s62q/7GrqP+1r6z/vbaz/9HKxv/a09D/1dDN/7q1sf+cmJb/lJCN/5SQjP+VkYz/lpGN/3+AgP9/f4D/f4CA/3+AgP9/gID/f4CA/3+Bgf+AgYH/gIGC/4CCgv+AgoL/gIKC/4GCg/+BgoP/gYKD/4GCg/+Bg4P/gYOE/4CDhP+Bg4T/goOE/4KEhf+BhYX/goWF/4OGhv+DhYb/hIaH/4SGiP+Gh4j/iYqK/8/Lyf/t5uP/6OLe//Lt6P/o49//7+rm/+Te2v/t5+P/7Obi/9vU0f/n4uD/8Ozq//Ds6//x7e3/8u7v//Lw7//y8fH/8/Lx//Py8f/z8vH/8/Lx//Ty8v/08vL/9PLy//Ty8v/08vL/9PLy//Ty8v/z8vL/9PLy//Py8v/z8vL/8/Py//Py8v/z8vH/8/Ly//Py8v/z8vL/8/Hy//Py8v/z8fH/8/Lx//Py8f/z8fD/8vHw//Hw7//w7+7/8O7t//Dt7f/w7e3/8e7v//Lv8P/y8PD/8vDw//Px8f/z8vH/8/Ly//Ty8v/z8vH/8/Lx//Py8f/y8fH/8vDw//Px8f/z8fH/8/Hx//Py8v/z8vL/8/Ly//Py8f/z8vH/8/Ly//Py8f/z8vH/8/Lx//Py8v/08vL/8/Hy//Px8v/z8vL/9PLy//Px8f/y8fH/8/Hx//Px8P/y8fD/8fDv//Hw7//y8O//8e/v//Hu7v/w7u7/8O3t/+/s7P/u6+v/7uvq/+3q6f/t6un/7enp/+zo5//s6Of/7enp//Ds6//y7+7/9PHw//Lu7v/p5OT/0szO/8rExf/IwsL/2NLR/+nj4//u6un/8u7t//bz8v/28vH/6+fn/5OPkf+SjY7/zsfH/9XPz//Ry8v/1c/P/93X1//e2Nj/3tjY/9vV1v/Z09P/2dPT/9bP0P/a1NT/5N3d/+Td3f/Vz9D/xb+//8jCwf/Pycj/z8nH/87Jx//Iw8D/w726/8G7uf/Dvrr/w726/7exrv+xq6f/t7Gt/8G7tv/PycX/19HN/9HLx/+zrqv/m5eU/5SRjf+Vko3/l5OO/5WRjP9/gID/f4CA/3+AgP9/gID/f4CA/3+Agf+AgYH/gIGC/4CCgv+AgoL/gIKC/4CCg/+Bg4P/gYKD/4GChP+Bg4P/gYKD/4GDhP+Bg4T/gYOE/4GEhP+ChIX/goWF/4OFhv+Ehob/g4aG/4aGh/+Eh4j/hoiJ/4aIif/JxsP/6+Th/+zm4//u6OT/6+Xi/+rk4f/o49//7+vn/+DZ1f/g2db/7Ofm//Dr6//w7e3/8u7t//Lv7//y8PD/8/Hx//Py8f/z8vH/8/Ly//Pz8v/08vL/9PLy//Ty8v/08vL/8/Ly//Py8v/z8vL/9PLy//Py8v/z8vL/8/Lx//Py8f/z8vH/8/Ly//Py8f/z8vL/8/Ly//Ty8v/z8vL/8/Ly//Py8f/z8fH/8/Hx//Lx8P/x8PD/8e/u//Du7f/w7u7/8O3t//Hu7v/y7+//8vDw//Px8f/z8fH/8/Ly//Py8v/z8vH/8/Lx//Ly8f/z8vH/8/Lx//Py8f/z8fH/8/Hx//Px8f/z8vL/8/Ly//Ty8v/z8vL/8/Ly//Py8v/z8vL/9PPy//Pz8v/08/L/9PLy//Py8v/z8vL/9PLy//Py8v/z8fH/8vHx//Lx8P/y8fD/8vHw//Lx8P/y8fD/8fDv//Hv7//x7+7/8e7u//Hu7v/w7e3/7+zs/+/s6//t6un/7enp/+3p6f/s6ej/7Ono/+3p6f/w7Oz/8u7u//Pw7//z7+7/6ubm/9XQ0P/Jw8T/ycHD/9zV1P/q5uX/7unp//Ds6//18vH/9vPy//Lv7v+hnp//gXx9/8W+vf/b1NT/2dLT/9LMzf/X0dL/3djX/93Y1//f2Nj/29XV/9nT0//Z0tP/2dLT/9vU1f/g2tr/3tfY/8/Jyv/HwcD/zMbF/8zGxP/NyMX/zsjF/8nEwf/CvLn/wLq3/8G7t/+7tbH/s6yp/7Suq//Aurb/z8rF/9TPy//MxsP/rqmm/5mVkf+VkY7/lpKN/5iUj/+WkY3/f4CA/3+AgP9/gID/f4CA/3+Agf+AgYH/gIGB/4CBgv+AgoL/gYKC/4CCg/+Bg4P/gYOD/4GDhP+Bg4T/gYOE/4GDhP+Cg4T/goOE/4KEhf+BhIX/goWF/4OFhv+EhYb/g4aG/4OHh/+Fh4f/hYeJ/4eJiv+Eh4f/wb26/+rj3//u6OX/6+Xh/+vm4v/m4Nz/8Ozn/+fi3f/g2tb/6OPh/+/q6f/x7Oz/8e7u//Lu7v/y7+//8/Hx//Py8f/z8vH/8/Ly//Pz8v/08/L/9PPy//Pz8v/08/L/8/Ly//Ty8v/08vL/9PLy//Ty8v/z8vL/8/Ly//Py8f/y8vH/8vHx//Ly8f/y8vH/8/Lx//Py8f/z8vH/8/Lx//Px8f/z8fH/9PLy//Px8f/y8fD/8vDw//Hw7//w7+7/8O7t/+/t7f/w7+7/8fDv//Lw8P/z8fD/8/Hx//Px8f/08vL/8/Ly//Py8f/y8fH/8/Lx//Py8f/y8fH/8vHw//Lx8f/z8vH/8/Lx//Py8v/08vP/9PPz//Tz8v/z8vL/8/Ly//Pz8v/z8/L/8/Ly//Pz8v/z8vH/9PLy//Ty8v/z8vL/8/Ly//Px8f/z8fH/8/Lx//Lx8P/y8fD/8vHv//Hw7//x8O//8fDv//Hv7v/x7u7/7+3s/+/t7P/v7Oz/7uvr/+7r6v/t6un/7erp/+zp6P/u6un/8Ozr//Lw7v/08vH/9PHw/+3q6f/Y09T/ysTF/8rDxP/f2dn/7ejn/+3p6f/v6+v/8/Hv//Xz8v/38/L/s7Cw/3Vxcv+2rq//1tDQ/97Z2P/Z09P/1M7O/9rV1f/e2dn/3dfX/93Y1//a1dX/2NPT/9nU0//c1tf/29XV/9zW1v/Y0dH/zMfG/8zGxf/LxsT/ysTC/8vGxP/LxsL/x8K//8K8uf+/urb/ubOw/7ewrf+0r6v/v7m2/83Iw//SzMj/xb+8/6ikof+ZlZH/l5KP/5mUj/+ZlJD/lZGM/3+AgP9/gID/f4CA/3+Agf+AgYH/gIGB/4CBgv+AgoL/gYKC/4GCgv+BgoP/gYOD/4GDg/+Bg4T/goOE/4GDhP+Cg4T/goOE/4KEhf+ChIX/goSF/4OFhv+Dhob/g4aH/4OGh/+Eh4f/hYeI/4WHif+HiYr/hIaH/7e1s//q5OH/7+nm/+rl4f/n4t7/6+fj/+3p5P/i3dn/5eDc/+7q6P/w7Ov/8e3s//Hu7v/y7+//8vDw//Lx8f/z8vH/8/Ly//Py8v/08/L/9PPy//Tz8v/08/P/9PPy//Tz8v/08/L/8/Ly//Ty8v/08vL/8/Ly//Py8v/08/L/8/Py//Pz8v/z8/L/8/Py//Py8f/z8/L/8/Py//Py8v/08vL/9PLy//Py8v/z8vH/8vHw//Hw8P/x8O//8e/u//Dv7v/w7u3/8O/u//Hv7//y8O//8vDw//Px8f/z8fH/8/Ly//Py8v/z8vL/8vLx//Py8f/z8vH/8vLx//Lx8P/y8fD/8/Lx//Px8f/z8vL/8/Ly//Py8v/z8/L/8/Ly//Py8v/z8vL/8/Py//Pz8v/08/L/8/Ly//Ty8v/z8vH/8/Ly//Lx8f/z8fH/8vHx//Lx8f/y8fD/8fHv//Hx8P/x8O//8fDv//Hw7//x7+7/8e7u//Du7f/w7ez/7+zs/+/s6//u7Ov/7uvq/+3r6v/s6en/7erq/+/s6//y7+7/9PLw//Tx8P/u6+r/2tXW/8vFxv/KxMX/4dvb/+7q6f/v6+r/7+rq//Lv7v/18/H/+Pb0/8rHx/9ybnD/pp+g/9HLzP/d19f/3dfY/9fR0f/W0dH/3djX/+Da2v/c2Nj/2tXV/9rV1P/Z1NP/2tXU/93X1//b1dX/19DR/9DKyv/Oycj/z8rI/8nEwv/IwsD/yMPA/8nEwP/Ev7v/w766/7u1sv+2sK3/uLKv/8G7uP/LxsL/z8nG/7+5tv+koJ3/mJWR/5eTj/+alZD/mpaR/5WRjP9/gID/f4CA/3+Agf9/gIH/gIGB/4CBgf+AgYL/gYKC/4GCgv+BgoP/gYOD/4GDg/+Bg4T/gYOE/4KDhP+ChIT/goOE/4KEhf+ChIX/g4WF/4OFhv+DhYb/hIaG/4OGhv+Dh4f/hYaH/4WHiP+FiIj/h4mK/4SGhv+sq6r/6+Xi/+7o5f/q5OD/5+He//Dr6P/m4dz/39rV/+nl4f/w7en/8O7r//Dt6//y7u7/8u/v//Px8P/z8fH/8/Ly//Tz8v/08/L/9PPy//Tz8v/08/L/9PPy//Pz8v/08/L/9PPy//Py8v/08vL/9PPy//Tz8v/08/L/8/Py//Py8v/z8/L/8/Ly//Py8v/z8/L/8/Py//Tz8v/08/L/9PLy//Py8v/z8vL/8/Ly//Py8v/z8fH/8fDw//Hw7//x7+//8e/u//Dv7v/x7+//8vDv//Lx8P/z8fH/8/Lx//Py8f/z8vL/8/Ly//Py8f/z8vL/8/Ly//Py8f/y8fH/8vHx//Py8f/z8vH/8/Ly//Pz8v/08/L/9PPz//Tz8v/z8/L/8/Ly//Pz8v/z8/L/8/Py//Pz8v/08/L/9PPy//Ty8v/z8vL/8/Ly//Py8f/y8fH/8vLx//Lx8P/y8fD/8vHw//Hx8P/x8O//8vDv//Hw7//x7+//8e7u//Dt7f/v7ez/7+3s/+7r6v/u6+r/7erq/+7r6v/w7Oz/8vDu//Ty8f/08vH/8O7s/+Db2//Mx8f/zMbH/+Pd3f/w6+v/7+zs/+/r6v/x7u3/9PPx//b08v/h3dz/fXl7/4+Jiv/LxMT/29bW/+Da2v/b1tb/1tDQ/9jT0//f2tr/4dvb/93Y1//Z1NT/2tXV/9nT0//a1NT/3dfX/9vU1P/SzM3/zsjI/8/KyP/Pysf/y8XD/8bBvv/GwL3/xb67/8O8uf+/ubX/ubOw/7mzr//Evbr/y8XC/8rFwf+5tLD/oZ2a/5iVkf+YlJH/m5eS/5qWkf+VkYz/f4CA/3+AgP+AgYH/gIGB/4CBgf+AgYH/gIGC/4GCgv+BgoP/gYOD/4GDg/+Bg4T/goSE/4KEhP+ChIT/goSE/4KEhf+DhIX/g4SF/4OFhv+DhYb/hIWH/4OGh/+Eh4f/hIeH/4WHiP+FiIj/hYmI/4eKiv+Eh4f/o6Oi/+vl4f/t5+T/5+Hd/+vm4//t6OT/4dzY/+Tg2//u6+f/7uzn//Hw7P/x7+z/8e7t//Lv7//y8fD/8/Lx//Py8v/08vL/9PPy//Pz8v/08/L/9PTy//T08//09PL/9PTy//Tz8v/08/P/9PPz//Tz8//08/L/9PPy//Tz8v/z8/L/8/Py//Tz8v/z8/L/8/Py//Pz8v/z8/L/8/Py//Py8v/z8vL/9PLy//Py8f/z8fH/8vHw//Lx8P/y8fD/8O/u//Dw7//x8O//8fDu//Hw7//y8fD/8/Lx//Py8f/z8vH/8/Lx//Py8v/z8vL/8vLx//Ly8f/y8vH/8vLx//Ly8P/z8vH/8/Lx//Py8f/08/L/8/Ly//Tz8v/08/L/8/Py//Pz8v/z8/L/8/Py//Tz8v/z8/L/8/Py//Pz8v/z8vL/8/Ly//Py8f/z8vH/8vHx//Ly8f/y8fH/8vHw//Hx7//x8O//8vHv//Hw7//x8O//8O/u//Dv7v/w7e3/7+3s/+/s7P/u6+v/7uzr/+7s6//u7Ov/8O3s//Lw7v/08/H/9PPx//Lw7v/j39//zsnK/8zHx//i3Nz/7+zr/+/t7P/u6+r/8O3s//Ty8P/18/H/8O3r/5mVlv93c3P/wLm5/9rU1f/g2tv/39ra/9fS0v/V0ND/29bV/+Hc3P/f2tr/3djX/9jU1P/Z1NP/2NPS/9rV1P/c19b/19HR/87Jyf/Nx8b/zsnH/87Jxv/KxcL/xcG9/8K9uf/Dvrn/v7q2/7u2sf+7trL/xL+7/8vFwv/GwLz/tK+r/6CcmP+ZlpL/mZaS/5qWkv+alpH/lZGM/3+AgP+AgYH/gIGB/4CBgf+AgYH/gYKC/4GCgv+BgoL/gYOD/4GDg/+Bg4P/gYSE/4KEhP+ChIT/goSF/4KEhf+DhYX/g4WF/4OFhv+EhYb/hIWG/4SGh/+Eh4f/hYeH/4OHiP+Eh4j/hYeJ/4WJif+Hior/hYeH/52enP/p49//6+bi/+Xg3P/u6eb/5eHc/+Lf2v/p5eD/8O3q/+7r6P/x7uv/8vDt//Hu7f/x8O//8vHw//Ty8f/z8/L/9PPy//Tz8v/08/P/9PPz//T08//08/P/9PTz//Tz8v/08/L/9PPy//Tz8v/08/L/9PPy//Pz8v/08/L/9PPy//Tz8//08/L/9PPy//Pz8v/09PL/9PPy//Tz8v/08/L/9PPz//Tz8v/08/L/8/Ly//Py8f/y8vH/8vHw//Hw8P/w8O//8fDv//Hw7//y8O//8vHw//Py8f/z8vL/9PPy//Py8v/z8vL/8/Py//Py8f/y8vH/8/Py//Ly8f/y8fD/8vHw//Py8f/z8vH/8/Ly//Py8v/z8vL/9PPz//Tz8v/z8/L/8/Py//Pz8v/z8/L/8/Py//Pz8v/z8/L/8/Ly//Py8v/z8vH/8vHx//Lx8f/y8fD/8vHw//Lx8P/y8fD/8fHv//Hw7//x8O//8fDv//Hv7v/y8O//8e7u//Du7f/w7e3/7uzr/+7s6//u6+r/7uzq/+/t7P/y8O7/9PLw//Tz8f/z8e//6eXk/9LOzv/Mx8j/4Nvb/+/r6v/w7e3/7+zs//Ht7P/08vD/9PPx//Ty8P+/u7v/bmtr/6qlpf/Y09P/4t3d/+Lc3f/b1tb/087O/9fS0v/e2dn/4d3c/+Db2v/a1tX/2NPT/9bS0f/Y0tL/2tXU/9rU1P/Tzc3/zcfG/83Hxf/NyMX/y8fE/8rFwf/Cvbr/wLy4/765tf++uLT/vbez/8O+uf/Iwr7/wbu3/66qpv+empb/m5eT/5yYk/+alpL/mZWQ/5WRjf+AgYH/gIGB/4CBgf+AgYH/gIKC/4GCgv+BgoL/gYOD/4GDg/+Cg4P/goOE/4KEhP+ChIT/goSF/4KEhf+ChYX/g4WF/4OFhv+DhYb/hIaG/4SGh/+Fhof/hIeI/4SHiP+EiIj/hYiI/4WIiP+GiIn/h4qK/4aIiP+YmZj/5eDc/+jj3v/n4t7/6+bj/+Lc2f/n4t7/7Ojk//Lw7f/v6+n/8e7s//Px7//y7+7/8fDu//Ly8P/08vL/9PLy//Tz8//08/L/9PPz//Tz8//08/P/9PTz//T08//09PL/8/Ty//Tz8v/08/L/9PPy//Tz8v/08/L/9PPy//Tz8v/z8vL/8/Py//T08//z8/L/8/Py//Pz8f/08/L/8/Py//Tz8v/08/L/8/Ly//Py8v/z8vH/8vLx//Lx8f/y8fH/8fHw//Dw7v/y8e//8vHw//Lx8P/z8vH/8/Ly//Py8v/08/L/9PPy//Py8v/z8vL/8/Py//Ly8f/z8vH/8vLx//Ly8f/z8/H/8/Py//Pz8v/z8vL/8/Ly//Tz8v/08/L/8/Py//Pz8v/z8/L/9PPy//Pz8v/z8/L/8/Py//Tz8v/z8vL/8/Ly//Py8v/z8vH/8/Hx//Lx8P/y8PD/8fHw//Hw7//x8O//8fHv//Hw7//x8O//8fDv//Dv7v/v7e3/8O7t/+/t7P/v7Oz/7uzr/+3s6//v7ez/8fDu//Tz8P/19PH/9PLw/+zp6P/Y1NT/zcnJ/93Y2f/v6+r/8e7t//Dt7P/w7e3/8/Hw//X08v/18/H/3NjX/399ff+LiIj/0MrK/+Ld3f/l4OD/3tnZ/9bR0f/Uz9D/2dTU/97a2f/i3tz/39va/9vX1v/X09L/1M/P/9fS0f/a1dP/2NPS/9DLy//NyMb/y8bD/8rFwv/KxsL/xsG9/8K9uf+9uLT/vLiz/8C7tv/Dvrr/xsC8/724tP+sp6P/npqW/5uXk/+bl5P/m5eS/5iUj/+UkY3/gIGB/4CBgf+AgYH/gIKC/4GCgv+BgoL/gYKC/4GDg/+Cg4P/goOE/4KEhP+ChIT/goSF/4KFhf+ChYX/g4WF/4OFhv+Dhob/hIaG/4SGh/+Ehof/hYeH/4SHh/+Fh4j/hIiI/4WIif+GiIn/homJ/4eLiv+GiYn/lpiW/+Ld2f/n4d3/6+Xi/+fi3v/k39v/6eTg/+/s6P/08u//8O3r//Lv7f/z8fD/8vDv//Hv7v/y8fD/8/Py//Tz8v/08/P/9PPz//Tz8//09PP/9PTz//T08//09PP/9PTz//T08//08/L/9PPy//Tz8//08/P/9PPz//Pz8v/z8/L/9PPz//Tz8//z9PL/8/Py//T08v/09PL/9PTy//T08//08/L/9PPy//Tz8//08/L/8/Ly//Py8v/z8vH/8vLx//Lx8P/x8e//8vHw//Hx7//y8fD/8/Lx//Py8v/08vL/9PPz//Tz8v/08/L/8/Py//Ly8f/y8vH/8vLx//Ly8f/y8fD/8vLx//Ly8f/z8vL/8/Py//Py8v/08/L/9PPz//Pz8v/z8/L/8/Ly//Pz8v/z8/L/8/Py//Pz8v/z8vH/8/Py//Ly8f/z8vH/8vHx//Lx8f/z8fH/8vHw//Lx8P/x8e//8fHv//Hx7//x8e//8fDv//Lw7//x8O//8e/u//Du7f/v7Ov/7uzs/+/t7P/t6+r/7+3s//Dv7f/z8vD/9fTx//Tz8f/v7ev/3tra/9DLzP/b1tf/7eno//Hu7f/w7ez/8O3t//Px7//19PL/9fTy/+jm5P+npaX/dXNz/7y3t//f2tr/5uLh/+Pe3v/Z1NT/1M7P/9jT0//b19b/39ra/97a2f/d2dj/3NfW/9fT0v/Uz87/1dDQ/9nT0v/Uzs7/0MvJ/83Ixf/JxMH/yMPA/8XAvf/Ev7v/wLu3/7y3sv++ubX/w766/8K9uP+4s6//qaWg/6Ccl/+dmZX/m5eT/5uXk/+Xk4//lJGN/4CBgf+AgYH/gYKC/4GCgv+BgoL/gYKC/4GCg/+Cg4P/goOD/4KDhP+ChIT/goSE/4OEhf+DhYX/g4WF/4OFhv+DhYb/hIaG/4SGh/+Ehof/hYeH/4WHh/+Fh4j/hYeI/4WIif+GiIn/homJ/4aJif+Hior/homJ/5SWlf/f2tX/5d/b/+zo5P/j3dr/5uHd/+jj4P/x7+z/9PHv//Hu7P/y7u3/8/Hv//Ty8f/x8O7/8vHw//Tz8v/08/L/9PPz//Tz8//09PP/9PTz//T08//09PP/9PXz//T08v/09PP/9PTz//T08//09PP/9PPz//T08//08/P/9PPy//Pz8v/z8/L/9PPz//T08//09PP/9PTz//T08//09PP/9PPz//Tz8//08/L/9PPy//Tz8v/z8vL/8/Ly//Py8f/z8vH/8vHw//Hx7//x8e//8/Lx//Pz8v/z8/L/9PPz//Tz8//08/P/9PPy//Tz8v/z8vL/8/Lx//Ly8f/y8vH/8vLx//Lx8P/y8fD/8/Ly//Pz8v/08/L/9PPz//Tz8v/08/L/9PPz//Pz8v/z8/L/9PPy//Pz8f/z8/L/8/Py//Pz8v/z8/L/9PLy//Py8v/z8vH/8vHw//Lx8P/y8fD/8fDv//Hw7//x8O//8fHv//Lx8P/y8fD/8vHv//Hw7//w7+7/7+3s/+7s7P/v7ez/7uzr/+/t7P/w7+7/8/Hv//X08f/08/H/8e/u/+Th4P/Tzs//2NTU/+nl5f/w7ez/8O3s//Dt7f/y8e//9PTy//X18v/t7Ov/y8jH/4F/gP+cmJf/2tXV/+bi4f/n4uP/39ra/9TOz//Uz87/2tXV/97Z2f/g29r/3djX/9vW1f/Z1dT/19LR/9TPzv/U0M7/1dDP/9HMy//Mx8X/y8XC/8rEwf/EwLz/wr25/8C7tv+/urX/vbiz/8G8t/+/urX/trGs/6ejnv+fm5f/npqV/5yZlP+cmJT/lpOP/5SRjf+AgoL/gYKC/4GCgv+BgoL/gYKC/4GDg/+Cg4P/goOD/4KDhP+ChIT/g4SE/4OEhf+DhYX/g4WF/4OFhv+Dhob/hIaG/4SGh/+Eh4f/hYeI/4WHiP+Fh4j/hYeJ/4aHif+FiIn/hoiJ/4eJiv+HiYr/h4uL/4eKiv+SlJT/2tXR/+bg3P/r5uL/497Z/+nj4P/r5uP/9PLv//Ty8P/y7+7/8+/u//Lx7//08/H/8/Hw//Hx7//08/L/9PPz//Tz8//09PP/9PPz//T08//19PT/9fT0//T08//19PP/9PXz//T08//09PP/9PTz//T08//09PP/9PPz//Tz8//08/P/9PPz//Tz8//09PP/9PTz//T08v/09PP/9PTz//T08//08/P/9PPy//Tz8v/08/P/8/Ly//Py8v/y8fH/8vLx//Lx8P/y8vD/8vLw//Ly8P/z8vH/8/Py//Tz8//08/P/9PPz//Tz8v/08/L/8/Py//Py8v/y8vH/8/Lx//Ly8P/y8vD/8vLx//Ly8f/z8/L/8/Py//Tz8v/z8/L/8/Ly//Py8v/z8/L/9PPy//Pz8v/z8/L/8/Py//P08v/z8/L/8/Py//Py8f/y8fD/8vHx//Lx8f/y8fD/8fDv//Hw7//x8O//8PDv//Hw7//x8O//8vHw//Lx7//x8O//8O/u/+/t7f/u7Ov/7uzs/+7s6//u7Ov/8O7t//Lx8P/08/L/9fTx//Lx7//p5+b/2tbW/9jT0//m4uL/7+zr//Ht7f/w7u3/8fDu//Tz8f/19fL/8vHv/9nW1f+ppqb/fnx8/8fCwf/l4eH/6eTk/+Tf3//Z09P/0cvM/9bR0f/c19b/39ra/97a2f/b19b/29bW/9jU0v/W0M//1M/P/9POzf/Uzs3/zcjG/8nFwv/KxcP/xcG9/8O+u/+9ubX/vbm0/766tf+/urX/uraw/7KtqP+no5//oJyY/56alf+dmZX/m5eT/5WSjv+UkY3/gYKC/4GCgv+BgoL/gYKC/4GCg/+Cg4P/goOD/4KDhP+ChIT/goSE/4OEhf+DhIX/g4WF/4OFhv+DhYb/hIaG/4SGh/+Ehof/hIaH/4WHiP+Fh4j/hYeJ/4WHif+GiIn/hoiJ/4aJiv+HiYr/h4mK/4iKi/+Iior/j5GR/9PPzP/o49//6eTg/+fi3v/p5OH/7uvn//Xy8f/08vD/8u/v//Pv7//y8PD/9PLx//Ty8f/x8O//9PLy//T08//08/P/9fTz//X09P/19PT/9PTz//X09P/19PT/9PTz//T08//09PP/9PTz//T08//09PP/9PTz//Tz8//08/P/9PPz//Tz8//08/P/9PPz//Tz8//09PP/9PTz//T08//09PP/9PTz//T08//08/L/9PPz//Tz8//z8vL/8/Lx//Py8v/z8vH/8/Lx//Lx8f/x8fD/8vLx//Py8f/08/L/9PPz//Tz8v/08/P/9PPz//Tz8//z8vL/8/Ly//Ly8f/y8vH/8vLx//Ly8f/y8vH/8/Lx//Py8v/z8/L/8/Py//Pz8v/08/L/9PPy//Ty8v/z8/L/8/Py//Pz8v/z8/L/8/Py//Pz8v/z8/L/8/Lx//Ly8f/y8fH/8vHw//Lx8P/x8fD/8fDv//Hw7//x8O//8vHv//Lx8P/y8fD/8vHw//Hw7//x7+7/7+3s/+/t7P/u7Ov/7+3s//Du7v/x8O//9PPx//X08v/08/H/7evp/97a2//Y1NT/497e/+3q6f/w7e3/8O7t//Lv7//08vH/9fTy//T08v/k4eD/wr6+/4iHh/+dmZj/4Nzb/+rm5f/p5OT/39rb/9HMzf/RzM3/2tXV/97Z2v/f2tr/29fW/9nU1P/a1dX/19HR/9TPzv/Tzsz/0c3L/8/KyP/LxsT/yMLA/8S/vP/Cvbr/v7u3/7u2s/+8uLT/vbiz/7izrv+uqqX/paGd/6Gdmf+empb/npqW/5uXkv+UkY3/lJKN/4GCgv+BgoL/gYKC/4GDg/+Cg4P/goOD/4KDhP+ChIT/goSE/4OEhP+DhIX/g4WF/4OFhv+EhYb/hIaG/4SGh/+Ehof/hIeH/4WHh/+FiIj/hoeI/4aIif+GiIn/hoiJ/4aJiv+HiYr/h4mK/4eKi/+Ii4v/iYuL/4yPjv/LyMb/6+bj/+jj3//r5uL/6eTh//Lv7f/18/D/9fLx//Pw8P/z7+//8/Hw//Ty8f/08/L/8vHw//Py8f/09PP/9PTz//X08//19PT/9fT0//X09P/19PT/9fX0//X19P/19PT/9PTz//T08//09PP/9PTz//X09P/09PP/9fTz//X08//09PP/9PPz//T08//09PP/9PT0//T08//09PP/9PTz//T08//09PP/9PTz//Tz8//08/P/9PLy//Pz8v/z8vL/8/Ly//Py8v/z8vL/8vLx//Pz8v/08/L/9PPy//Tz8v/08/P/9PPz//Tz8//08/L/8/Ly//Py8v/z8/L/8/Py//Hx8f/x8fD/8vLx//Py8f/z8vL/8/Py//Tz8//08/L/9PPz//Py8v/z8vL/9PPy//Pz8v/z8/L/8/Py//Pz8v/z8/L/8/Ly//Py8f/y8fH/8vHx//Lx8f/x8PD/8vDw//Hw7//y8e//8vHw//Lx8P/y8fD/8/Lx//Py8f/x8O//8fDv//Du7f/w7e3/7+3s/+7s6//w7u7/8vHw//Py8f/09PL/9PTy//Du7f/l4uH/29fX/+Dc3P/r5+f/8O3s//Du7f/y7+//8/Hw//Tz8v/08/L/7uzr/8zIyP+sqKn/gn9//8bBv//q5eT/7Ojn/+fi4//Y1NX/zsjJ/9LNzf/c19f/4tzc/97Z2f/b1tX/2NPS/9fT0v/W0dD/0s3M/9LNy//Pysf/zMfF/8rEwv/Ev7z/wLu4/8C7t/+7t7P/urax/7m1sP+0sKv/rKmj/6ainf+hnZn/npqW/56alv+ZlZH/lpKO/5WRjv+BgoL/gYKD/4KCg/+Cg4P/goOD/4KDg/+Cg4T/g4SE/4OEhP+DhIX/g4WF/4OFhv+EhYb/hIaG/4SGh/+Ehof/hIaH/4WHiP+Fh4j/hYeI/4aIif+GiIn/hoiJ/4aIiv+HiYr/h4mK/4eJi/+Iiov/iIuM/4mMjP+JjYz/xcPB/+zo5P/o49//7Ojk/+vm4//08vD/9fLx//Xy8//08fH/8vDw//Py8f/08/L/9fPy//Py8f/z8vH/9fTz//T08//19PT/9fT0//X19P/19PT/9fT0//X19P/19fT/9fT0//X09P/19PT/9fT0//X09P/09PP/9PTz//T08//09PP/9PTz//T08//09PT/9PT0//T08//09PP/9PT0//X09P/19PT/9fT0//T08//08/P/9PPz//Tz8v/08/P/8/Ly//Py8v/z8/L/8/Ly//Py8f/z8vL/8/Py//Pz8v/09PP/9PTz//T08//08/P/9PPz//Py8v/z8vL/8vLy//Py8v/y8vH/8vHx//Lx8f/y8vH/8/Lx//Ly8v/z8vL/9PPy//Tz8v/08/L/9PPz//Py8v/z8/L/8/Py//Pz8v/z8/L/8/Ly//Py8f/y8fH/8vHx//Lx8f/x8O//8fDw//Lw8P/x8O//8vHw//Hw7//x8fD/8vHw//Lx8P/y8fH/8vHw//Lw7//w7u7/7+3t/+/u7f/u7Ov/8O7t//Hw7//z8fH/9PPy//Xz8v/x8O//6ufm/9/b2v/f29r/6uXl/+/s6//w7u3/8fDv//Px8P/18/P/9fTz//Py8f/c2dj/vrm6/5iUlf+alZX/4t3c/+3p6P/r6Of/497f/9TP0P/NyMn/1dDQ/97Y2f/g2tv/3NfX/9nU1P/V0ND/19LR/9TPzv/SzMv/z8nH/8vGw//KxcL/xsG+/8C7uP+9ubX/uray/7m1sP+2sq7/s6+q/6unov+loZz/oZ2Z/52alv+dmpX/mJWQ/5eTj/+VkY3/goKD/4KDg/+Cg4P/goOD/4KDhP+ChIT/g4SE/4OEhP+DhIX/g4WF/4OFhf+EhYb/hIWG/4SGh/+Ehof/hYaH/4WHh/+Fh4j/hYeI/4aIiP+GiIn/hoiJ/4aIif+HiYr/h4mK/4eJi/+IiYv/iIqL/4mLjP+KjI3/iIuM/8LAvv/s5+T/6eTg/+zn5P/u6ef/9fPy//Xy8v/18vL/9PHx//Lw8P/z8fH/8/Ly//X08//08/L/8/Hx//T08//19PP/9fT0//X09P/19PT/9fT0//X09P/19PT/9fT0//X09P/19PT/9PTz//T08//09PP/9PTz//T08//09PP/9PPz//Tz8//08/P/9PPz//T09P/09PT/9PTz//T09P/09PT/9PT0//X09P/19PT/9PT0//T08//08/L/9PLy//Ty8v/z8vL/9PPz//Tz8v/z8/L/8/Ly//Pz8v/z8/L/9PPy//Tz8//08/P/9PPz//Tz8//08/P/9PPz//Pz8v/z8vL/8/Ly//Lx8f/y8fD/8vLx//Ly8f/z8vH/8/Ly//Pz8v/08/P/8/Ly//Py8v/z8vL/9PPy//Pz8//z8/L/8/Py//Pz8v/z8/L/8vLx//Ly8f/y8fD/8vHw//Lw8P/x8PD/8fDv//Hv7//x8PD/8fDw//Lx8P/y8vH/8/Lx//Py8f/y8fD/8e/u//Du7f/w7u3/8O3t//Dt7f/x7+7/8/Hx//Tz8v/19PL/8/Lx/+7r6v/j4OD/39vb/+fj4//v6+v/8O7t//Hv7v/z8PD/9PLx//Xz8//08vH/6ebm/8jExP+2sbH/kIyN/8K8u//t6ef/7urq/+rm5f/c19j/z8nK/9DLzP/Z1NP/3tjY/97Y2P/b1tb/19LS/9XQz//Uz87/0s7N/8/KyP/Lx8P/ycTB/8fCv//BvLn/vbi1/7izsP+2sa7/s6+r/7Crp/+qpaH/pqKd/6GdmP+empb/nJmU/5eUkP+Wk47/lZKN/4KDg/+Cg4P/goOD/4KDg/+Cg4T/goSE/4OEhP+DhIX/g4WF/4OFhf+EhYb/hIWG/4SGh/+Ehof/hYaH/4WHiP+Fh4j/hYeI/4aIif+GiIn/hoiJ/4aIiv+GiIr/h4mK/4eJiv+Iiov/iIqL/4iKjP+Ji43/io2O/4iLi//BwL7/6+bi/+rl4v/r5+P/8O3r//Xz8//18vL/9fPz//Ty8v/z8PD/9PLy//Ty8v/19PT/9fPz//Lx8f/08/P/9fTz//X09P/19fT/9fT0//X19P/19PT/9fT1//X09P/19PT/9fT0//X09P/19PT/9fT0//X09P/09PP/9PTz//T08//08/P/9PTz//X09P/19PT/9PT0//X09P/09PP/9fT0//X09P/19PT/9fT0//T08//09PP/9PPz//Tz8//08/P/9PPz//Tz8//08/L/8/Pz//Py8v/z8/L/9PPz//Tz8//08/P/9PPz//Tz8//08/P/9PPz//Tz8//08/P/8/Ly//Lx8v/y8vH/8vHx//Lx8f/y8vH/8/Lx//Py8f/z8/L/9PPy//Ty8v/z8/L/8/Ly//Ty8v/z8vL/8/Ly//Py8v/z8vL/8/Lx//Ly8f/y8vH/8vHw//Hx8P/x8O//8vDw//Hw7//x8O//8vDw//Hw7//x8O//8vHw//Py8f/z8vH/8vHw//Lw7//w7+7/8O7u//Dv7f/v7u3/8e/v//Lx8P/08vL/9fPy//Tz8v/w7u3/6OTk/+Hd3f/l4uH/7urq//Du7f/w7u7/8vDw//Px8f/18/L/9PLx//Dt7P/a1db/wLq7/66qqv+dmJj/39rZ/+/r6v/u6un/5uHi/9bR0v/Nx8j/1M7O/9zW1v/d2Nj/3NfW/9jT0//X0tH/087N/9HMzP/Qy8r/zcjF/8fCv//Hwr//wb26/765tv+5tLH/tLCt/7Gtqf+uqaX/p6Of/6Ofm/+gnZj/npqW/5qWkv+XlI//lpOO/5WSjf+Cg4P/goOD/4KDhP+Cg4T/goSE/4OEhP+DhIT/g4SF/4OFhf+EhYb/hIWG/4SGhv+Ehof/hYaH/4WGiP+Fh4j/hYeI/4WHiP+Gh4n/hoiJ/4aIif+HiYr/h4mK/4eJi/+Hiov/iIqL/4iKjP+Ji4z/iYuN/4qMjv+Ii4z/w8HA/+rl4v/r5+P/6+bk//Pv7v/18/L/9PPy//Tz8//08vL/8/Hx//Px8f/08vL/9fTz//X08//y8vH/9PPz//X09P/19PT/9fX0//X19P/19PT/9fX0//X19f/19PT/9fT0//X09f/19PT/9fT0//X09P/19PT/9fT0//X09P/19PT/9fT0//X09P/19PT/9fT0//X09P/19PT/9fT0//X09P/19PT/9PT0//X09P/19PT/9PTz//T08//19PP/9fPz//Xz8//08/P/9PPz//Tz8//08/P/8/Py//Pz8v/08/P/9fT0//X08//19PP/9PPz//Tz8//08vL/9PPz//Tz8//z8vL/8/Ly//Ly8f/y8vH/8vHx//Ly8f/z8vH/8/Ly//Pz8v/z8/L/9PLz//Tz8//z8vP/8/Ly//Ty8v/z8vL/8/Py//Py8f/y8fH/8/Lx//Lx8P/x8fD/8fDw//Hw7//x7+//8fDw//Lw8P/y8PD/8vDv//Lx8P/z8vH/8/Lx//Py8f/y8fD/8fDv//Dv7v/w7u7/7+3t//Du7v/y8O//9PLx//Tz8v/08/L/8vHv/+zp6P/k4N//5ODg/+vo6P/w7u3/8O7u//Hv7//z8fH/9fPz//Xz8v/y7+7/5+Pj/87Jyf/Dvr//pqKj/7q2tf/t6en/7erq/+vm5v/g29z/087P/8/Jyv/X0dL/3NfX/93Y2P/a1dT/1tDR/9XQ0P/Tzcz/zsnJ/83IyP/Jw8L/xL+8/8C7uP+8t7T/ubWx/7WwrP+wq6j/q6ik/6ikoP+inpr/n5uX/52alv+YlpH/lZOP/5eUj/+Sj4v/goOD/4KDhP+Cg4T/goSE/4OEhP+DhIT/g4SE/4OFhf+EhYb/hIWG/4SGhv+Ehob/hIaH/4WGiP+Fh4j/hYeI/4aHiP+Gh4n/hoiJ/4eIif+HiYn/h4mK/4eKiv+Hior/iIqL/4iKi/+Iioz/iYqM/4qLjf+LjY7/iIuM/8LAv//q5OL/6ubj/+vn5P/z8fD/9fPz//Tz8v/18/P/9fPz//Px8f/08vL/9PLz//Xz8//19PT/8/Lx//Pz8v/19PT/9fT0//X19P/19fT/9fX0//X19P/19PT/9fT0//X09P/19PT/9fT0//X09P/09PT/9fT0//X09P/19PT/9PT0//T09P/09PP/9fP0//X09P/19PT/9fP0//T09P/19PT/9fT0//T09P/09PT/9PTz//X09P/08/P/9fT0//Xz8//08/P/9PPz//Tz8//08/P/9PPz//Ty8//z8vL/9PPz//Tz8//08/P/9PTz//Tz8//08/P/9PPz//Tz8//z8vL/8/Ly//Py8v/z8vL/8vHx//Lx8P/y8vH/8vLx//Py8v/z8/L/8/Ly//Px8v/z8vL/8/Ly//Px8v/z8vL/8/Ly//Py8v/z8vH/8vLx//Ly8f/y8fD/8fDw//Hw8P/x8O//8O/v//Dv7//x8PD/8fDw//Hw7//y8PD/8/Hx//Py8f/z8vH/8/Hx//Lx8P/x8O//8O/u/+/u7v/w7u7/8e/v//Px8f/08/L/9PPy//Py8P/u6+v/5uPj/+Th4P/q5ub/8O3t//Hu7v/x7+//8vDw//Ty8v/08/L/8vDv/+vn5//f2tr/zcjJ/8bCwv+mo6P/2NTT/+7r6v/s6Oj/5uDh/9rU1f/Uzs//087P/9nT1P/b1dX/29bV/9nU0//Uz8//087N/8/Lyf/Nx8b/yMPB/8bBvv/BvLn/u7e0/7izsP+zr6v/sKun/6unov+mop7/op6a/5+bl/+bmJT/mJWR/5aTjv+Vko3/kI2K/4KDg/+Cg4T/g4OE/4OEhP+DhIT/g4SF/4OFhf+EhYX/hIWG/4SGhv+Ehob/hIaH/4WGh/+Fh4j/hYeI/4aHiP+Gh4n/hoiJ/4aIiv+GiYr/h4mK/4eJi/+Hior/h4qL/4iKi/+Iiov/iIuM/4mLjf+KjI3/i42P/4iLjP+/vb3/6uTi/+rl4v/t6Ob/9PPx//Tz8v/08/P/9fPz//Xz8//z8fH/9PLy//Tz8//08/P/9fTz//Tz8v/08vL/9fTz//X09P/19fT/9fT0//X19P/19fT/9fT1//X09f/19PX/9fT0//X09P/19PT/9fT0//X09P/19PT/9PT0//X09P/19PT/9fT0//X09P/19PT/9fT0//X09P/19PT/9fT0//X09P/19PT/9fT0//X19P/09PT/9fT0//T08//19PT/9fT0//Xz9P/19PT/9PT0//X09P/08/T/9PPz//Tz8//09PP/9PTz//Tz8//09PT/9PPz//Tz8//08/P/9PPz//Py8//z8vL/8/Ly//Lx8f/y8fH/8vLx//Py8v/z8vL/8/Py//Tz8v/z8vL/8/Ly//Py8v/08vP/9PPz//Pz8v/z8/L/8/Ly//Py8f/y8vH/8vLx//Lx8P/y8PD/8vHw//Hw8P/x7+//8vDw//Lw8P/x8O//8vHx//Px8f/z8vH/9PPy//Py8f/z8vD/8fDw//Hw7//w7+7/7+7u//Hv7//z8fH/9PLy//Xz8v/08/L/8O/u/+rn5//l4uL/6OXl/+7s6//w7+7/8O7t//Hv7v/z8fH/9fPy//Px8P/u6uv/5uLi/9/b2//Rzc3/vru7/7Owr//p5eT/7ejo/+rl5f/h3Nz/2dPU/9bQ0P/Y0tP/29XV/9nU1P/Z1NP/19LR/9POzf/Qy8n/zcjG/8nEwf/Ev7z/wby5/7y3tP+3s7D/tK+s/66ppv+rp6L/pqKe/6Gdmf+fm5f/m5iU/5eUkP+WlI//ko+L/4+Mif+Dg4T/g4SE/4OEhP+DhIT/g4SF/4OEhf+EhYX/hIWF/4SGhv+Ehob/hIaH/4WGh/+Fh4f/hYeI/4aGiP+Gh4j/hoeJ/4aIif+GiIr/h4mK/4eJiv+HiYr/h4qL/4iKi/+Iiov/iIuM/4mLjP+Ji43/ioyN/4yNj/+Hioz/urm5/+nk4v/p5OL/7uro//Tz8v/19PP/9PPz//X08//18/P/8/Hx//Ty8v/z8vL/9PPz//X09P/18/P/9PLy//X09P/19fT/9fX0//X19P/19fT/9fX0//X09P/19PT/9fT0//X09P/19PT/9fT0//X09P/19PT/9fX0//T09P/09PT/9fT0//X09P/19PT/9fT0//Tz8//19PT/9fT0//Xz9P/19PT/9PT0//T08//09PT/9PTz//T08//19PT/9PTz//Tz9P/18/T/9PP0//Xz9P/08/T/9PPz//T08//09PP/9PTz//T08//09PT/9PP0//Tz8//08/P/9PPz//Tz8//08vP/8/Ly//Py8v/y8vH/8vHx//Hx8P/y8fH/8/Lx//Py8v/08/L/9PPy//Px8f/z8vL/8/Hx//Py8v/z8vL/8/Ly//Ly8f/y8vH/8vLx//Lx8P/x8PD/8fDw//Lw8P/w7+//8O/v//Hw8P/x8O//8e/v//Hw7//z8fH/8/Hx//Ty8f/z8/H/8/Lx//Lx8P/x8O//8e/v//Du7v/x7+7/8vDw//Py8f/08/L/9PPz//Lx8P/t6+r/5+Tk/+jl5P/t6ur/8O/t//Hu7f/x7u7/8/Dw//Ty8v/08vH/8O3t/+nl5f/r5+f/3NjX/9TQ0P+0sLH/ycXE/+7q6P/r5ub/5eDg/97Z2f/a1NX/2NPT/9nU1P/c1db/19PS/9bR0f/V0M//0s3L/83Ixv/JxcL/xsG+/8C8uP+7trT/trGu/7Ouq/+uqqb/qaWh/6ahnf+hnpr/nZqW/5mXk/+WlJD/lZKO/5GPiv+Miob/g4SE/4OEhP+DhIT/g4SF/4OFhf+DhYX/hIWF/4SFhv+Ehob/hIaH/4WGh/+Fh4f/hYeI/4WHiP+Fh4j/hoiJ/4aIif+GiIn/h4mK/4eJiv+HiYr/h4qL/4iKi/+Iiov/iIuM/4mLjP+Ji43/iYyN/4qMjf+MjpD/iIqL/7W1tP/p5OL/6ePh/+/s6//z8/L/9PPz//Tz8v/19PP/9fPz//Px8f/08vL/9PLy//Xz8//19PT/9fTz//Tz8v/19PP/9fT0//X19P/19fT/9fX0//X19P/19fT/9fT0//X09P/19PT/9fX1//X19P/19PT/9fT0//X09P/09PT/9PT0//X09P/09PT/9fT0//X09P/19PT/9fT0//X09P/19PT/9fT0//T08//09PT/9PT0//T19P/09PP/9PTz//X08//19PT/9PTz//Tz8//09PP/9PPz//Tz8//19PT/9PPz//Tz8//08/P/9PTz//Tz8//08/P/9PPz//Tz8//08/P/9PPz//Tz8//z8vL/8vHx//Lx8f/x8fD/8fHw//Ly8f/z8vL/8/Py//Py8v/z8vH/8/Ly//Py8v/z8vL/8/Ly//Py8f/y8fH/8vHx//Lx8P/x8fD/8vHw//Lx8P/x8fD/8fDv//Hv7//x7+//8fDv//Lw8P/y8PD/8vHx//Py8f/08/L/9PPz//Tz8v/z8vH/8vDv//Hw7//w7+7/8e/v//Lw8P/z8vH/9PPz//Xz8//08vL/8O7u/+rn5//o5eX/7Onp//Du7f/x7+7/8e7u//Lv7//08/H/9PPx//Lv7//p5ub/7urq/+rn5//Z1tb/08/P/6+srP/d2Nf/7urp/+nk5P/i3d3/3NfX/9zX1//b1tX/29bV/9nV1P/W0tH/1M/N/9DMy//Oycf/ycTC/8XAvv/Bvbr/vbi0/7ezr/+xran/rqqm/6qmov+joJz/oZ2Z/52Zlf+ZlpL/l5SQ/5OQjP+SkIv/hYSB/4OEhP+DhIT/g4SF/4OEhf+DhYX/hIWF/4SFhv+Ehob/hIaG/4WGh/+Fh4f/hYeH/4WHiP+Fh4j/hoiI/4aIif+GiIn/h4iJ/4eJiv+HiYr/h4mL/4iKi/+Iiov/iIuL/4iLjP+Ji4z/iYyN/4mMjf+KjI3/jI6P/4iKi/+ur67/6ePh/+jj4f/x7uz/9PPx//X08//09PP/9fTz//X08//z8vH/9PPy//Tz8v/18/P/9vT0//b09P/08/P/9PTz//X09P/19fT/9fX0//X19P/19fT/9fX1//X19f/29fX/9fX0//X09P/19PT/9fT0//X09P/19PT/9fT0//X19P/19fT/9fX0//X19P/19PT/9fT0//X09P/18/T/9fT0//X09P/19PT/9PT0//X09P/19fT/9fX0//X19P/19fT/9PT0//X09P/19PT/9PT0//Tz8//09PT/9PTz//T08//09PP/9PPz//T08//09PP/9PTz//T08//08/P/9PPz//Tz8//08vP/9PPz//Py8v/z8vL/8/Ly//Ly8f/y8vH/8/Ly//Py8f/z8vL/8/Ly//Ly8f/z8fH/8/Ly//Py8v/z8vH/8/Ly//Ly8f/y8vH/8vHx//Ly8P/x8fD/8fDv//Hw8P/x7+//8e/v//Hv7//x8O//8vHw//Lx8f/z8vH/8/Lx//Py8v/08/L/8/Ly//Py8f/y8fD/8fDv//Dv7v/x8O//8vHw//Ty8v/18/P/9PPy//Lx8P/t6ur/6ebm/+vo6P/v7ez/8e/u//Du7f/x7u7/8/Hw//Tz8v/z8fD/6+jo/+zp6P/y7+7/5OHg/9/b2v/Kxsb/trOy/+nl4//q5uX/5uLh/+Lc3f/c19j/3dfX/9zX1//a1NT/2NPS/9XQ0P/RzMv/zsnH/8rGxP/EwL3/wb25/725tf+3s6//s66r/62ppf+ppKH/pKGd/6CcmP+cmJX/mZaS/5WTj/+TkIv/kZCM/3t7ef+DhIT/g4SF/4OEhf+DhYX/g4WF/4SFhf+EhYb/hIaG/4WGh/+Fhof/hYeH/4WHh/+Fh4j/hoiI/4aIif+GiIn/hoiJ/4eJiv+HiYr/h4mL/4eKi/+Iiov/iIqL/4iLjP+Ii4z/iYyM/4mMjf+JjI3/ioyN/4yOj/+Ii4z/qKmo/+fh3//o4+H/8e/u//Pz8f/19PP/9fTz//X08//19PP/8/Lx//Tz8v/08/L/9PPy//X09P/29PT/9PTz//T08//19fT/9fX0//X19P/19fT/9fX0//b19f/19fT/9fX1//X19P/19PX/9fT0//X09P/19fT/9fX0//X09P/19PT/9fX0//T08//09PT/9fT0//X09P/19PT/9PT0//X09P/08/T/9fT0//X09P/19PT/9PT0//T19P/19PT/9PTz//Tz8//09PP/9PTz//Tz8//09PP/9PP0//T09P/09PT/9PPz//Tz8//09PP/9PTz//T08//09PP/9PPz//Tz8//08/P/9PPz//Py8v/z8vL/8/Ly//Py8f/y8vH/8vHx//Ly8f/y8vH/8/Py//Py8f/y8vH/8/Lx//Lx8f/y8fH/8/Lx//Ly8f/z8vH/8vHw//Hx8P/x8fD/8fHw//Hw7//x8O//8e/v//Dv7//x8O//8fDw//Lw8P/y8PD/8vHw//Py8f/08/L/9PPy//Tz8v/z8vH/8vHw//Hw7//x8O//8fDv//Lx8P/08vL/9PPz//Tz8//z8vH/7+7t/+vo6P/r6Of/7u3s//Hv7v/x7+7/8O7t//Lw7//08/L/8/Lx/+3q6v/p5ub/8e/u/+/s6//j397/5uLh/7y5uf/Hw8L/7ejn/+bi4v/k39//4dzc/93Y2f/d19j/29bW/9jU0//W0ND/0s7N/87JyP/LxsT/xsG+/8G8uP+8uLT/t7Ou/7Kuqv+tqaX/qaSg/6Sfm/+fnJj/m5iV/5iVkv+UkYz/lJKN/4qIhf91dXT/g4SE/4OEhf+DhIX/g4WF/4SFhf+EhYb/hIWG/4SGhv+Fhof/hYeH/4WHh/+Fh4j/hYiI/4aIiP+GiIj/hoiJ/4aJiv+HiYr/h4mK/4eJiv+Hiov/iIqL/4iKjP+Ii4z/iYuM/4mMjf+JjI3/io2N/4qNjv+Mjo//iYyN/6Kjo//j3tv/6ePh//Pw7//08/L/9fT0//X19P/19fP/9fTz//Ly8f/08/H/9PPy//Xz8v/29PP/9vX0//X08//19PP/9fX0//X19P/19fT/9fX0//X19f/19fT/9vX0//b19P/19fT/9vX1//X19P/19fT/9fX0//X19P/19fT/9fX0//X19P/19fT/9PX0//X19P/19fT/9fX0//X09P/09PT/9PT0//T08//09PT/9PT0//T09P/09PP/9PTz//T09P/09PT/9PT0//T08//09PP/9PT0//Tz8//08/P/8/Pz//Tz8//09PP/9PTz//T08//08/P/9PPz//T08//08/P/9PPz//Py8v/z8/L/9PPz//Py8v/z8vH/8vHx//Ly8f/y8vH/8/Px//Pz8v/z8vH/8/Lx//Py8f/z8vH/8/Lx//Py8f/z8vH/8vHx//Lx8P/x8fD/8fHw//Hx8P/x8fD/8fDv//Hw7//x8O//8fDv//Hw7//y8PD/8vHw//Py8f/z8vH/9PPy//Tz8v/08/L/8/Py//Ly8f/y8fD/8fDv//Hw7//y8PD/8/Lx//Py8f/08/L/9PPy//Hw8P/t7Ov/6+jo/+7s6//w7+3/8e/u//Du7f/x7+7/9PLx//Ty8f/u6+v/6ebm/+/s7P/y8O//7Ono/+fk4v/l4eD/t7S0/9nW1P/r5ub/5eDg/+Le3f/g29v/3djY/9vW1v/Z1NT/1tHR/9POzf/Py8n/ysbD/8fCv//Bvbn/vLi0/7azrv+zrqr/ramk/6ikof+kn5v/npuY/5qXlP+XlZH/lJGN/5WSjf9+fXv/dHRz/4OEhf+DhIX/g4WF/4OFhf+EhYX/hIWG/4SGhv+Fhob/hYaH/4WHh/+Fh4j/hYeI/4aIiP+GiIn/hoiJ/4aIif+HiYr/h4mK/4eJiv+Hiov/iIqL/4iKi/+Ii4z/iIuM/4mMjP+JjIz/iYyN/4mNjf+KjY7/jI6P/4mMjf+bnZ7/39rY/+rl4//y8fD/8/Py//X09P/19fP/9fT0//X08//y8vD/9PPy//X08v/09PP/9fT0//b19f/19PP/9fTz//X09P/19fT/9fX1//X19f/19vX/9fb0//b19f/29fT/9fX0//X19P/19fT/9fX0//X19P/19fX/9fX0//X19P/19fT/9fX0//X19P/19fT/9fX0//X19P/09PT/9fT0//X09P/09PT/9PTz//Tz9P/09PP/9fT0//T09P/19fP/9PTz//T09P/09PP/9PT0//T08//09PT/9PTz//T08//09PP/9PPz//T08//09PP/8/Pz//T08//08/P/9PPz//Tz8//08/L/9PPz//Tz8v/z8vL/8/Lx//Ly8f/y8vH/8fHw//Ly8f/y8vH/8vLx//Ly8f/y8fD/8vHw//Lx8P/y8fD/8vHx//Py8f/y8fH/8vHw//Lx8P/x8fD/8fHw//Hw7//w8O7/8O/u//Hw7//x8O//8vDv//Lx8P/y8fD/8vHw//Py8f/08/L/9PPy//Tz8v/z8/H/8vLw//Ly8P/y8fD/8vHw//Py8f/z8vL/9PPy//Tz8v/z8vH/8O/u/+zq6f/t6+r/8O/t//Hv7v/w7u3/7+7s//Px8P/08/L/8O7t/+rm5v/s6en/8u/u//Hu7f/q5+b/7ero/97c2v+4trb/5eDg/+jj4v/j397/4dzc/97Z2f/d2Nj/29bV/9fS0f/Uz87/z8vJ/8vHxP/Gwr//wr66/725tf+3s67/sq6q/62ppf+no5//op6b/56al/+ZlpP/lpOP/5WTjv+Liof/dXV0/3R2dP+DhIX/g4SF/4SFhf+EhYX/hIWG/4SGhv+Ehob/hYaH/4WHh/+Fh4f/hYeI/4aIiP+GiIj/hoiJ/4aIif+GiYn/h4mK/4eJiv+Hior/h4qL/4iKi/+Iioz/iIuM/4iLjP+JjIz/iYyN/4mMjf+JjY3/io2O/4uOj/+KjY7/lpiY/9nU0//s5+b/8vDv//Pz8v/19PT/9fX0//X19P/19PP/8vHw//Py8f/19PP/9PTz//X09P/29fT/9vX0//X09P/19PT/9fX0//X19P/19fX/9vb1//X19f/19fX/9vX0//X19P/19fX/9fX1//X09P/19fT/9fT0//X19P/19fT/9fX0//X19P/19fT/9PX0//X19P/09PT/9fT0//T08//19PT/9PT0//T09P/09PT/9PT0//T09P/09PP/9PTz//T08//09PP/9PTz//T08//09PP/9PTz//Tz8//08/P/9PPz//Tz8//09PP/9PTz//P08//z9PP/8/Py//T08//09PP/9PPy//Py8v/z8vL/8/Lx//Py8f/z8vH/8vHx//Hx8P/x8fD/8vLx//Pz8v/y8vH/8vHw//Hx8P/y8fD/8fHw//Hx8P/y8fD/8vLx//Lx8f/x8fD/8fHw//Hw7//w8O//8PDv//Dw7//x8O7/8fDv//Lx8P/y8fD/8vHw//Px8f/z8vH/8/Py//Tz8v/08/P/8/Py//Ly8P/y8vD/8vHw//Lx8P/y8fH/8/Lx//Py8f/08/L/9PPy//Lx8P/u7Ov/7Ovq/+/u7f/x7+7/8O/t/+/u7P/y8O//9PLx//Hv7v/r6Oj/6+fn//Du7f/y8O//8O3s/+zp6P/z8O7/0s/O/8C9vP/p5eT/5ODf/+Pe3f/f2tr/3djY/9zX1v/Z1NT/1dDP/8/Lyf/MyMX/x8PA/8K+uv+8uLT/uLSv/7Kuqf+sqKP/p6Of/6Gemv+cmpX/mJWR/5WTjv+TkI3/fH17/3R0c/90dXT/g4WF/4SFhf+EhYX/hIWG/4SFhv+Ehob/hYaG/4WGh/+Fh4f/hYeH/4aHiP+GiIj/hoiJ/4aIif+HiYn/h4mK/4eJiv+Hior/h4qL/4iKi/+Iioz/iIqM/4iLjP+Ji4z/iYyN/4mMjf+JjY3/io2N/4qOjv+Ljo//io6P/5CUlP/Tz83/7ejn//Lw7//08/L/9vX0//b19P/19fT/9fTz//Hy8P/08/L/9PXz//T08//19fT/9vX1//b19P/19PT/9fT0//X19P/19fT/9fX1//X19f/19vX/9vb1//X29P/19fT/9fX1//X19P/29fX/9vX1//X19f/19fX/9fX0//X19P/19fX/9fX0//T19P/19fT/9fX0//T19P/19fT/9fX0//X09P/09fT/9PT0//T09P/09PT/9PTz//T08//09PT/9PX0//T19P/09PT/9PTz//T08//08/P/9fT0//Tz8//08/P/9PPz//T08//09PP/9PTz//T08//z9PP/9PTz//T08//z8/L/8/Py//Pz8v/z8vL/8vHx//Lx8f/y8fD/8fHw//Ly8f/y8vH/8vLx//Hx7//x8O//8fHw//Lx8P/y8fD/8fHw//Hx8P/x8fD/8fDw//Hx8P/w8O//8fDv//Hx7//w8O7/8PDu//Hw7//x8O//8vHw//Lx8P/y8fH/8/Lx//Py8f/z8/L/8/Py//T08v/z8/H/8/Lx//Ly8P/y8vD/8vHw//Py8f/z8vH/9PLy//Tz8v/z8vH/8O/u/+7t7P/w7+3/8fDv//Hw7//v7u3/8fDv//Py8f/y8O//7erq/+vn5//u6+r/8O3s//Du7f/w7ev/7uzq//Lv7f/GxML/ycbF/+nl4v/i3tz/4dzb/9/a2v/c19f/2tTU/9bRz//Rzcv/zcnG/8fDwP/Dv7v/vbm1/7ezrv+xrqj/q6ij/6ajn/+hnpn/m5mV/5aUkP+Vk4//hoWD/3V1df90dXX/dHV0/4OEhf+EhYX/hIWF/4SFhv+Ehob/hIaG/4WGhv+Fhof/hYeH/4WHiP+Gh4j/hoiI/4aIif+GiIn/homJ/4eJiv+HiYr/h4qK/4eKi/+Iiov/iIqL/4iLjP+Ii4z/iYuM/4mMjf+JjI3/iY2O/4qNjf+KjY7/i46O/4uOj/+MkZH/zMnH/+7p5//w7+7/9PPz//b19f/19fT/9fT0//X08//y8fD/9PPy//X08//19PP/9fXz//b19P/29fT/9fX0//X09P/19PT/9fX0//b29f/29fX/9vb1//b29f/19vT/9fX1//b19f/29fX/9fX1//X19P/19fT/9fX0//X19P/19fT/9fX0//T19P/19fT/9fX0//X19P/19fT/9fX0//X19P/09PT/9PT0//X09P/19PT/9fX0//T09P/09PP/9PTz//T08//09fP/9PTz//T08//19PT/9PTz//T08//09PT/9PT0//T09P/09PP/9PTz//P08//z8/L/9PTz//T08//09PP/9PTz//Tz8//z8vL/8/Ly//Ly8f/y8vH/8vHx//Hx8P/y8fD/8/Lx//Py8f/y8vD/8fHv//Hx7//y8fD/8vHw//Lx8P/y8fD/8vHw//Hx8P/x8O//8PDv//Dw7v/w8O7/8O/u//Dw7v/x8O//8fDv//Hw8P/y8fD/8vHw//Lx8f/z8vH/8/Py//Pz8v/08/L/8/Py//Pz8f/z8vH/8/Lx//Py8f/z8vH/8/Lx//Py8f/z8vH/8/Ly//Lx8P/v7u3/7+7s//Dv7f/w7+7/8O7t//Du7f/y8e//8fDv/+7r6//r5+f/7Onp//Ds7P/w7ez/8e7t//Dt7P/v7Or/7uvp/7+8uv/Py8n/5+Lh/+Hc2//g29r/3dnY/9rW1P/X09D/0s7M/83Ixv/JxcL/wr66/725tf+3sq7/sK2o/6unov+koJz/n5yY/5mXk/+Vk4//jYyJ/3h5eP91dnX/dHV1/3N0c/+EhYX/hIWF/4SFhf+EhYb/hIaG/4WGhv+Fhof/hYeH/4WHiP+Gh4j/hoiI/4aIiP+GiIn/homJ/4eKif+Hior/h4qK/4iKi/+Iiov/iIqL/4iLjP+Ii4z/iYuM/4mLjP+JjI3/iYyN/4qNjv+KjY7/io6O/4uPj/+Mj5D/io6P/8TDwP/v6uj/8O3s//Tz8//29fX/9fX0//X09P/09PP/8vLw//Tz8v/19PP/9PTz//X19P/29vT/9vX1//X19P/19PT/9fT0//X19f/29fX/9vX1//b29f/29vX/9vb1//b29f/29vX/9fX1//b19f/29fX/9fX1//X19P/19fT/9fT0//X19P/19fT/9fX0//X19P/19fT/9PX0//T09P/09PP/9PT0//T09P/09PT/9PT0//T09P/09PT/9PT0//T18//09fP/9PTz//T18//09PP/9PTz//T08//09PP/9PTz//Tz8//08/P/9PPz//Pz8//09PP/9PTz//T08//z8/L/8/Ty//Tz8v/z8/L/8/Lx//Py8f/z8vH/8vHx//Lx8f/x8fD/8fHw//Lx8P/z8vH/8fHw//Dw7//x8O//8fDw//Lx7//y8e//8fHv//Hw7//x8PD/8fDv//Dw7//w8O7/8PHv//Dw7v/w8O7/8fDv//Lx8P/y8fD/8vHw//Lx8P/y8fH/8vHx//Py8f/08/L/9PPy//Pz8v/z8/H/8/Px//Py8f/z8vH/8/Lx//Lx8P/z8vH/8/Ly//Py8f/z8fH/8fDv//Dv7f/w8O7/8fDu//Dv7v/w7+3/8e/u//Hv7v/u7Ov/7Onp/+3p6f/t6un/7uvq/+/s6//w7uz/7+zq//Du6//p5+T/u7i2/9LOzP/l4N//39va/97a2f/b1tb/19LR/9TPzf/Oycf/ycTC/8O/u/+8ubT/t7Ou/7CsqP+qpqH/pKGc/52alv+XlZH/kY+N/4CAf/92d3b/dnd2/3R1dP9zdHP/hIWF/4SFhv+EhYb/hIaG/4SGhv+Fhof/hYaH/4WHh/+Fh4j/hoeI/4aIif+GiIn/hoiJ/4eJif+HiYr/h4qK/4eKiv+Hiov/iIqL/4iLi/+Ii4z/iYuM/4mLjf+JjI3/iYyN/4mMjf+JjY7/io2O/4qNjv+Ljo//jI+Q/4mNjf+8u7n/7unn/+7r6//19PP/9vX1//b19P/19fT/9fTz//Ly8f/z8/L/9fX0//X08//19fT/9fX1//b19f/29fX/9fX0//X19f/19PT/9vX1//b19f/29fX/9vb1//b19f/29fX/9vX1//b19P/29fX/9fX1//X19f/19fX/9fX0//X19f/19fX/9fX0//X19P/19fT/9fX0//X19P/09PP/9PT0//T09P/09PT/9PT0//T09P/09PT/9PT0//T09P/09PT/9PTz//P08//09PP/9PTz//T08//09PP/9PTz//Tz8//08/P/9PPz//Tz9P/08/P/9PPz//T08//09PP/9PTz//Tz8//z9PP/9PPz//Tz8v/z8/L/8/Lx//Py8v/y8vH/8vHx//Hx8P/y8fD/8/Ly//Ly8f/x8O//8PDv//Lx8P/y8fD/8fDv//Hw7//x8O//8fDw//Hw7//w8O//8PDv//Dv7//v7+7/8PDu//Dv7v/x8O//8fDv//Hw7//y8fD/8vHw//Py8f/z8vH/8/Ly//Tz8v/z8/L/8/Py//Py8v/z8vH/8/Lx//Py8f/y8fH/8/Lx//Py8f/z8fH/8/Hx//Lw7//w7+7/8O7t//Dv7v/w7+3/7+7t/+/u7f/v7ez/7uzr/+3q6f/s6en/7erp/+7r6v/v6+v/7+zr//Ds6//u6+n/7+3q/+bi4P+5trP/0s7M/+Pf3v/e2dj/3NfW/9jT0v/Uz83/0MvI/8nEwv/EwLz/vbq1/7ayrv+vrKf/p6Wg/6Gfmv+bmJT/lJOQ/4yKiP96enr/dnd3/3V2dv90dXX/c3Rz/4SFhv+EhYb/hIWG/4SGhv+Ehob/hYaH/4WHh/+Fh4f/hoeI/4aIiP+GiIn/hoiJ/4eJif+HiYr/h4mK/4eJiv+Hiov/iIqL/4iLi/+Ii4v/iIuM/4mLjP+Ji43/iYyN/4mMjf+JjI7/io2O/4qNjv+Kjo//i46P/4yQkP+IjY3/srOx/+3o5v/u6+r/9fT0//b19f/29fX/9fT0//T09P/z8vH/9PPz//T19P/09PT/9vX0//b19f/29fX/9vX1//X09P/19fT/9fX1//b19f/29fX/9vX1//b29f/29fX/9vb1//b29f/29vX/9fX1//X19f/19fX/9fX0//X19P/19fX/9fT0//X19P/19fX/9fX0//T19P/09fT/9PX0//X09P/19PT/9PT0//X09P/09PT/9PP0//Tz9P/19PP/9PPz//P08//09PT/9PX0//X19P/29vX/9vb1//X19f/29fX/9vX1//b19f/29fX/9fX0//X09P/09PP/9PPz//Pz8//09PP/9PTz//Pz8//z8/L/8/Py//Py8v/y8fH/8vHx//Lx8f/x8PD/8fDw//Ly8f/y8vH/8PDv//Dv7v/w8O//8fDw//Hw7//x8O//8O/u//Dv7//x7+//8O/v//Dv7v/w7+7/8O/u//Dw7v/w8O7/8fDv//Hw7//x8e//8fDw//Lx8P/y8fH/8/Lx//Py8v/z8vL/9PPy//Py8f/z8vH/8/Py//Py8f/y8vH/8vHw//Px8f/z8fH/8vHw//Lx8P/y8PD/8e/u//Dv7v/w7+7/8O/u//Du7f/w7u3/7+3s/+/s7P/t6+r/7erp/+3p6f/t6en/7erp/+3p6f/u6en/7+vp/+3q5//v7On/4+Dd/7m2tf/Oy8n/4d3c/9vX1f/X09H/1M/N/9DLyP/JxMH/w767/724tP+1sq3/raqm/6akn/+fnZj/mJeS/5GPjP+KiIb/eHp5/3V3dv91dnb/dHV0/3N0dP+EhYb/hIWG/4SGhv+Ehob/hYaH/4WGh/+Fh4f/hYeH/4aHiP+GiIj/hoiJ/4eIif+HiYn/h4mK/4eJiv+Hiov/iIqL/4iKi/+Iiov/iIuM/4iLjP+Ji4z/iYyN/4mMjf+JjI7/ioyO/4qNjv+KjY//i46P/4uOj/+MkJH/iY2O/6iqqf/q5eT/7uvp//X19f/29fT/9vX1//X09P/19PT/8/Lx//Tz8//09PT/9fX0//X19P/29fT/9vX1//X19P/29fX/9vX1//X09P/29fX/9vX1//b19f/29vX/9vb1//b19f/29vX/9vX1//X29f/29fX/9fX1//X19P/19fX/9fX0//X09P/19PT/9fX0//X09P/19fT/9fX0//T08//09PT/9fT0//X09P/09PT/9PT0//T09P/09PP/9PT0//X09P/19PT/8/Pz//Ly8f/v7+//7e3t/+vr6//q6ur/6urq/+rp6v/r6uv/7Ovs/+7t7v/w8PD/8vLy//T09P/19fT/9fT0//Tz8//z8/P/8/Py//Pz8v/z8vL/8/Lx//Py8f/y8vH/8vHx//Lx8P/y8fD/8/Ly//Ly8f/w7+//8fDv//Hx8P/y8PD/8fDw//Hw7//w7+//8e/v//Hw7//w7+7/8O/u//Dv7v/w7+7/8O/u//Hw7//x8O//8fHw//Hw7//y8fD/8vHw//Lx8f/z8fH/8/Lx//Py8f/z8vL/8/Lx//Ly8f/y8vH/8vLx//Py8f/y8fH/8vHw//Lx8f/y8fD/8fDv//Hv7//w7u3/7+7t/+/t7f/v7ez/7u3s/+7s6//u7Or/7erp/+zp6P/s6ej/7enp/+zp6P/t6en/7Ono/+zo6P/t6uj/6+jl/+7r6P/k4N7/u7i2/8vHxv/d2df/2NPS/9POzP/Oysf/ycTB/8O+uv+6t7L/s7Cr/6yopP+koJ3/nJqW/5STj/+PjYn/iIiG/3Z3d/92d3b/dHZ1/3R1df9zdHT/hIWG/4SGhv+Ehob/hIaG/4WGh/+Fh4f/hYeH/4aHiP+GiIj/hoiJ/4aIif+HiYn/h4mK/4eJiv+HiYr/h4qL/4iKi/+Iiov/iIuM/4iLjP+Ii4z/iYyN/4mMjf+JjI3/ioyO/4qNjv+KjY7/io2P/4uOj/+Ljo//jJCR/4qOj/+cn5//5N/e/+/s7P/29fX/9vX0//b09P/19PT/9fT0//Tz8//19PP/9fT0//X09P/19fT/9vX1//b19f/29fX/9fX0//X19P/19fX/9vX1//b19f/29vb/9vX1//b19f/29fX/9vb1//b29f/29fX/9vX1//b19f/29fX/9vX1//b19f/29fX/9fT1//X09f/19PX/9PT0//T09P/19fT/9PT0//T09P/19PT/9PTz//T08//19fT/9vX1//Pz8//x8PD/7u7u/+zs7P/s7Oz/7Ozs/+3t7f/u7u7/7+7u/+/u7v/u7u7/7u3t/+3s7P/s6+v/6+rr/+vq6v/r6+v/7e3t//Hw8P/z8/P/9PT0//T08//z8/L/8/Py//Py8v/y8fH/8vHx//Lx8P/x8O//8fDv//Lx8f/y8fH/8O/u//Dv7v/w7+//8fDv//Dw7//w7+7/8O/u//Dv7v/v7u7/8O7u//Du7v/v7u7/7+/u//Dv7v/w7+//8fDv//Hw7//x8e//8vDw//Lx8P/z8fH/8/Hx//Px8f/z8vL/8/Lx//Py8f/z8vH/8/Lx//Py8f/y8fD/8vHw//Lx8P/x8O//8fDv//Hv7v/w7u7/7+3t/+/t7f/v7e3/7u3s/+/s7P/u7Ov/7uvq/+3r6v/t6un/7ero/+zp6P/s6Oj/6ufm/+rm5v/p5eX/6ubm/+zo5v/q5+T/7Ojm/+fj4f++u7r/v7y6/9bSz//Tz8z/zcjF/8jDwP/Cvbn/urWx/7Gtqf+ppaL/oZ6b/5qYlP+SkY3/kI6L/4ODgv91dnX/dnd2/3R2dv90dXX/c3R0/4SFhv+Ehob/hIaG/4WGh/+Fhof/hYeH/4WHiP+Gh4j/hoiI/4aIif+HiIn/h4iJ/4eJiv+HiYr/h4qL/4iKi/+Iiov/iIuL/4iLjP+Ii4z/iYuN/4mMjf+JjI3/iYyN/4qMjv+KjY7/io2P/4uNj/+Ljo//i46Q/4yPkP+Mj5H/kZWV/9fV0//w7ez/9fX1//b19P/29PT/9fT0//b09P/18/T/9fT0//X09P/09PT/9fX1//X19f/19fX/9vX1//b19f/19fT/9fT0//b19f/29fX/9vX1//b19f/29fX/9vX1//b19f/29fX/9vX1//b19f/19fX/9vX1//b19f/29fX/9fX1//b19f/19PX/9fT0//X19P/19PT/9fT0//X19P/09PT/9fT0//X09P/19PX/8/Py//Dw8P/v7u//8PDw//Ly8v/09PT/9fX1//b29v/39/b/9/f2//f39v/39/b/9/f2//f29v/39vb/9vb2//b29f/19PT/8/Lz//Dw8P/v7u7/7u7t/+/u7v/y8fD/9PTz//Tz8//z8vL/8vHx//Lx8f/y8PH/8fDw//Hw8P/y8PH/8/Ly//Lx8P/w7+7/8e/v//Hw7//x8PD/8fDv//Du7v/w7u7/8O7u/+/t7f/v7u3/8O/u//Du7v/w7+7/8O/u//Dv7v/w7+7/8fDv//Hw7//y8PD/8vDw//Lx8f/y8fH/8vHx//Lx8f/y8fH/8vHw//Lx8P/y8fD/8vHw//Lx8P/x8O//8e/v//Du7v/w7+7/8O3t/+/t7f/v7Oz/7uzs/+7s6//u7Ov/7evq/+3q6f/s6un/7Ono/+vo5//r5+b/6+fm/+rm5v/p5eX/6eXl/+nj4//o4+L/6eXk/+rm4//r5+X/6OPh/8PAvf+1srD/ysbD/8/Lx//Hw7//wby4/7q1sf+vqqb/pKGd/52bl/+YlpL/k5GO/5CPjf97e3v/dXd2/3V3dv91dnb/dHV1/3N0dP+EhYb/hIaG/4WGh/+Fhof/hYeH/4WHh/+Fh4j/hoiI/4aIiP+GiIn/h4mJ/4eJif+HiYr/h4mK/4iKi/+Iiov/iIqL/4iLjP+Ii4z/iYuN/4mMjf+JjI3/iYyN/4qMjv+KjY7/io2O/4uNj/+Ljo//i46P/4uPkP+Mj5D/jZGS/4qOj//ExML/8Ozr//X19P/19fT/9fT0//X09P/19PT/9fT0//X09P/19PT/9fT0//X19f/19fT/9fX1//X19P/19fT/9fX1//b19f/29fX/9vb1//b29v/29fb/9vX1//b19f/29fX/9vb1//b19f/29fX/9fT0//X19f/19fX/9vX1//b19f/29fX/9fX1//X19f/19fX/9fT0//X09P/19fT/9fX0//b19f/08/T/8fDx//Hw8P/z8/P/9vX2//b29//29vb/9vb2//b19v/29vX/9vb1//X29f/19vb/9fX1//X19f/19fb/9fX1//b29v/29vb/9vb2//b29v/29vX/9fX1//X19P/z8/L/8fDw//Dw7//y8vH/9PPz//Tz8//z8vH/8vHx//Lw8P/x7/D/8O/v//Lx8f/y8fD/8O/u//Dv7v/x8O//8fDv//Hv7//w7+7/8O7u//Du7v/v7e3/7+3t/+/t7f/w7u7/8O7u//Du7v/w7+7/8PDu//Dv7v/x7+//8vDv//Lw8P/y8PD/8vHx//Lx8f/z8fH/8/Hx//Py8f/y8fH/8vHw//Lx8P/x8O//8fDv//Hv7//w7+7/7+7u/+/t7f/v7e3/7+zs/+7s7P/u6+r/7uvq/+3q6f/t6+r/7erp/+zp6P/r6ej/6+jn/+vn5v/q5ub/6eXk/+jj5P/m4eH/5uHh/+Xh4P/n4+D/6OTh/+jj4P/o4+D/zcnI/7Owrv+9ubb/x8PA/8K9uv+5tbH/rqqm/6Kfm/+cmpb/mJWS/5WTkf+IiIf/dXZ2/3Z4d/91dnf/dXZ2/3R1df90dHT/hIaG/4WGhv+Fhof/hYaH/4WHh/+Fh4j/hoeI/4aIiP+GiIn/homJ/4eJif+HiYr/h4mK/4eJiv+IiYv/iIqL/4iKjP+Ii4z/iYuM/4mMjf+JjI3/iYyN/4mMjv+KjY7/io2O/4qNj/+LjY//i42P/4uOkP+MjpD/jI+Q/46Rkv+Kjo//qqyr/+vo5v/19fT/9fX0//T09P/19PT/9fT0//X09P/19PT/9fT0//X09f/19fX/9fX1//X19P/29fX/9fX0//X19f/29fX/9vX1//b19f/29fX/9vX2//b19f/29fX/9vX1//b29f/29fX/9vX1//b29f/19fX/9vX1//b19f/29fX/9fT1//X09f/19PX/9fT0//X09f/19PT/9fX1//b19f/08/P/8/Py//X09P/29vb/9/b2//b29v/29vb/9vX2//X19v/09fb/9fX2//b29v/49/f/+fn3//v59//6+ff/+vj3//n49v/39/b/9vX2//T09f/09PX/9PT1//X09P/19fX/9fX1//X19f/19fT/8/Pz//Ly8f/z8vL/9PPz//Tz8//z8fL/8fDw//Du7v/x7/D/8/Lx//Hw8P/w7+7/8O/u//Dv7v/x7+//8O/u/+/u7f/w7u3/7+3t/+/t7f/v7e3/7+3t/+/t7f/v7u3/8O7u//Dv7v/w7+7/8O/v//Hw7//x7+//8vDv//Lw8P/y8PD/8vHx//Lw8f/y8fH/8vHw//Lx8P/x8PD/8fDw//Hw7//x7+7/8O/u/+/u7f/v7ez/7uzs/+7r6//u6+v/7evr/+3q6v/t6+n/7erp/+zp6P/s6ej/7Ojn/+vo5//q5ub/6eXk/+jj4//n4uL/5N/g/+Pe3v/h3dz/4t3c/+Pf3f/m4N7/4t3b/+Xg3v/c19X/vbm4/7azsf/BvLr/uLSx/62ppf+hnZr/nJqX/5iWlP+RkI//e318/3Z3d/93d3f/dnZ2/3V2df90dXX/c3R0/4SGhv+Fhof/hYaH/4WHh/+Fh4f/hYeI/4aIiP+GiIj/hoiJ/4eJif+HiYr/h4mK/4eKiv+Iiov/iIqL/4iKjP+Ii4z/iIuM/4mLjf+JjI3/iYyN/4mMjf+JjY7/io2O/4qNjv+LjY//i46P/4uOkP+MjpD/jI6Q/4yPkf+NkJL/jZCS/5OWl//Y1dT/9/b1//T08//09PP/9fT0//X09P/19PT/9fT0//X09P/19PT/9fT1//X19f/19fT/9vX1//X19P/19fT/9fX0//X19f/29fX/9vX2//b29v/29vX/9vb2//b29f/29vb/9vb2//b29f/29fX/9vX1//b19f/29fX/9vX1//b19f/29fX/9vX1//b19f/19PT/9vT1//b19f/09PP/9fT0//f39v/39/b/9/b2//f29v/29vb/9fX2//f29//6+fj//fv3//z69v/39vT/7/Hz/+js8v/j6fD/4ejw/+Tp8P/q7fL/8vP0//j29f/9+vb//vr3//v59//39vb/9PT1//Pz9P/09PT/9PT0//X09P/09PT/9PPz//Pz8v/08/P/9fT0//Tz9P/z8fL/8e/v//Lx8f/x8O//7+3t//Du7v/w7+7/8O/u/+/u7f/v7u3/7+3s/+/t7f/v7e3/7+3t/+/t7f/v7e3/7+7t//Du7f/w7u7/8O/u//Dv7v/x8O//8fDv//Lw7//x8PD/8fDw//Hw8P/y8PD/8vDw//Lx8P/y8fD/8fHw//Hw7//w7+7/8O/u//Du7v/v7e3/7+3s/+/s7P/v7Oz/7uvr/+7r6//t6+v/7erq/+3q6f/t6en/7Ono/+vo5//r6Of/6ubm/+jl5P/n4+P/5uLi/+Pf3//i3d3/4Nva/97a2f/d2Nb/3djW/93X1f/e2Nb/4dzZ/+Pe3P/Py8n/wr68/766t/+pp6T/oJ2b/52bmP+amJX/h4eG/3Z3d/93eHn/dnd3/3Z3d/91dnb/dHV1/3N1df+Fhob/hYaH/4WGh/+Fh4f/hYeI/4aHiP+GiIj/hoiJ/4aIif+HiYn/h4mK/4eJiv+Hiov/iIqL/4iKi/+Iioz/iIqM/4mLjP+Ji43/iYyN/4mMjf+KjY7/io2O/4qNjv+KjY7/i46P/4uOj/+LjZD/jI6Q/4yOkP+Mj5H/jZCR/4+Sk/+Jjo//tra1//X08//09PT/9PPz//X08//19PP/9fP0//X09P/19PT/9fT1//X09f/19fX/9fX0//X19P/29fX/9vX1//b19f/29fX/9vX1//b19f/29fX/9vX2//b19f/29fb/9vX2//b19f/29vX/9vb1//b29f/29fX/9vX1//b19f/29fX/9vX1//b19f/29PT/9fX1//b19f/19PT/9vb2//f39//39/b/9/f2//f29v/19fX/+fj3//37+P/49vX/4+fv/8jW6v+txeX/mbrl/4y05P+GsOT/gq3j/3+q4v9/qeH/hKzh/46x4v+ZuOP/qsPm/8HS6f/b4+7/8fHy//v59v/8+fb/9/b1//Tz9P/z8/P/8/Pz//Tz8//08/L/8/Ly//Ty8v/08/T/9fP0//Ty8v/y8fH/8vHw/+7t7P/u7Oz/7+7t/+/u7f/w7u7/7+3t/+7s7P/u6+z/7uzs/+/s7P/v7e3/7+3t/+/t7f/v7e3/8O7t//Hv7v/w7+7/8e/u//Hv7//x7+//8vDw//Lw8P/y8PD/8vDw//Lw8P/x8PD/8fDw//Hw7//x8O7/8O/u//Dv7v/v7u3/7+3t/+7s7P/u6+v/7urq/+7r6//u6+v/7urq/+3q6v/s6en/7erp/+zq6f/r6Oj/6ufm/+nl5P/o5OP/5uLi/+Xf4P/i3d3/4Nvb/97Z2P/c19b/2tXT/9bQzv/W0M7/1tDO/9jS0P/Z1NL/3NjV/9LNyv+9ubf/tbGv/66qqP+opKH/mpeV/3p8e/93eXn/d3h5/3Z3eP92d3f/dXZ2/3R1df90dHT/hYaH/4WHh/+Fh4f/hYeI/4aHiP+GiIj/hoiJ/4aIif+HiYn/h4mJ/4eJiv+HiYr/iIqL/4iKi/+Iiov/iIuM/4mLjP+Ji4z/iYyN/4mMjf+JjI3/io2O/4qNjv+KjY7/io6P/4uOj/+Ljo//i46Q/4yPkP+Mj5H/jJCR/42Qkf+OkZP/jZGS/5OWl//h4N//+Pf2//Py8f/08/P/9PTz//X09P/19PT/9fT0//X09P/19PT/9fT0//X09f/29fT/9vX1//X19P/19fT/9fX1//X19f/29fX/9vb1//b29v/29vX/9vb1//b19v/29fb/9vb2//b29f/29vX/9vb1//b29f/29vX/9vX1//b19f/19fX/9vX1//f29v/29fX/9/b3//f39//39/f/9/f3//b29v/29/b//fv3/+zt7//I1Of/pL3i/4qv4f9+quL/eajj/32s5/9/ruj/fq3n/3+t5v99rOX/eajj/3al4f92peL/c6Lg/26e3f9tnd3/d6Pd/4yx3/+qw+P/zNjp/+rt8P/6+PT/+/n1//b19P/y8vL/8vLy//Lx8f/z8fH/8/Ly//Tz8v/08/P/8/Pz//Tz8v/w7+7/7evr/+3r6//t7Ov/7+3s/+/t7f/t7Ov/7evr/+7s6//u7Oz/7uzs//Dt7f/v7e3/7+zs/+/t7P/w7u3/8O3t//Hv7v/x7+//8e/u//Hv7//x8O//8vDw//Lw8P/y8PD/8vDw//Lx8P/x8PD/8fDu//Hv7v/w7+7/7+7t/+/t7f/u7ez/7uzs/+7s6//u6+v/7evr/+7r6//t6ur/7erq/+3p6f/r6Oj/6+jn/+rm5v/p5eT/5+Pi/+Xh4f/j3t7/4Nvb/97Z2f/b1tb/2dTT/9XQz//SzMr/0MvI/9LNyv/Szcr/zMfE/9HMyf/Hwr//u7e0/7Guq/+0r63/pqSi/4GDgv92eXn/eHl6/3d4eP92eHf/dnd2/3V2dv90dXX/c3R1/4WGh/+Fh4f/hYeH/4WHiP+Gh4j/hoiI/4aIif+HiIn/h4mJ/4eJiv+Hior/h4qK/4iKi/+Iiov/iIuM/4iLjP+Ji4z/iYuN/4mMjf+JjI3/ioyO/4qNjv+KjY7/io2P/4qOj/+Ljo//i46Q/4uPkP+Mj5D/jI+R/4yQkf+NkJL/jZCS/4+SlP+JjI7/t7e3//n49//y8fH/8/Py//T08v/08/P/9fTz//X09P/19PT/9fT0//X09P/19PT/9vX1//X19P/29fX/9vX1//X19f/29vX/9vb1//b19f/29fX/9vX1//b19v/29vb/9vb2//b29f/29vX/9vb1//X29f/29vX/9vb1//b29f/29fX/9vX1//f29v/39vb/9/b2//j39//39vf/+Pf3//b29v/6+fj/+Pf0/7zL4P+FqNn/f6ng/4Kt5f+Jsuf/iLLm/4Cs5f+Breb/gKzl/32q5P+Areb/gK7l/3yr5P91pOH/dKTg/3al4P90ot//daLf/3im4P91o97/dJ/b/3Wf2f+Ep9n/obrc/8nV5f/t7+///Pn0//j39P/y8vH/8fDw//Lx8P/y8fH/8vDw//Px8f/08vL/8/Lx/+/u7f/s6+r/7Ovq/+zr6v/u7ez/7uzr/+3q6v/t6+r/7evq/+7r6//w7e3/7+3t/+7s7P/v7ez/8O3t/+/t7f/w7u7/8O/u//Hw7//x7+7/8O/v//Hv7//x7+//8fDw//Hw7//x8O//8O/v//Dv7v/v7u7/7+7t/+/u7f/u7ez/7+zs/+7r6//u6+v/7evq/+7r6v/u6ur/7enq/+3p6f/t6ej/6+jo/+vo5//p5uX/6OTj/+bi4f/k4N//4d3d/97Z2f/c1tf/2NPT/9TPzv/Qy8n/y8bE/8zHxP/V0M3/zcjF/8vHw//Pysf/zMjF/7y4tv+WlJP/i4yK/3t+ff93eHn/eHp7/3h5ef93eXj/d3h4/3V3d/91dnb/dHV2/3R1df+Fh4f/hYeH/4WHiP+Gh4j/hoiI/4aIif+GiIn/h4mJ/4eJiv+HiYr/h4qK/4iKiv+Iiov/iIqL/4iLi/+Ii4z/iYuM/4mMjf+JjI3/iYyN/4qMjv+KjY7/io2O/4qNj/+Ljo//i46P/4uPkP+Mj5D/jI+Q/4yQkf+NkJH/jZCS/42Rkv+OkZL/jZGS/5OWl//j4+L/9/b1//Ly8P/z8/L/9PPy//Tz8//08/P/9fT0//X09P/29PT/9fT0//X19P/29fX/9vX1//X19f/19vX/9fX1//b19f/29fX/9vX1//b19f/29fX/9vX1//b29f/29vX/9vX1//b29f/29vX/9vb1//b29f/29vX/9vX1//b29f/39vb/9/b2//j39//49/f/+Pf3//b29v/8+/n/6ert/5Gr0f9undn/dKXh/3yp4v+DreT/h7Hm/4Ou5P98qOL/favk/3um4f97pt//gq7l/4Kv5v9+rOX/dqbi/3Gh3/9wn97/b5/d/3Ge2/90odz/e6be/3uj2/92ntf/cpvV/2uW0v9plND/ep/R/6a82v/a4Oj/+Pby//n28//y8fH/8O/u//Hv7//x8O//8e/v//Hw7//x7+//8O/v/+/t7f/r6un/7evq/+7s6//s6un/6+no/+zq6f/u6+v/7+zs/+/s7P/u6+v/7uzr/+/s7P/v7ez/8O7t//Du7f/x7u3/8e7u//Hv7v/x7+7/8e/v//Hv7//w7+//8O7u//Dv7v/w7+7/7+7u/+/u7f/v7ez/7+3s/+7s7P/u7Ov/7uzr/+/s6//u6+v/7uvr/+3q6v/t6un/7Ono/+vn5v/q5ub/6eXk/+fj4v/k4N//4tzd/9/a2v/c19f/2NPT/9POzf/Oycj/yMTC/8bBv//Szcr/087M/8S/vP/RzMj/2dTR/767uP+Iioj/enx8/3d6ev94e3v/eXt8/3l6ev94eXn/d3h5/3Z4eP91d3f/dXZ2/3R1dv9zdXX/hYeH/4WHiP+Gh4j/hoiI/4aIif+GiIn/h4iJ/4eJif+HiYr/h4qK/4eKiv+Iiov/iIqL/4iLi/+Ii4z/iYuM/4mLjP+JjI3/iYyN/4mMjv+KjY7/io2O/4qNjv+Kjo//i46P/4uOj/+Lj5D/jI+Q/4yPkP+MkJH/jZCR/42Qkv+NkJL/jpGT/4+TlP+Kjo//srS0//b19P/x8fD/8vLx//Py8v/08/L/9PPy//Tz8//19PP/9fT0//X09P/19fT/9vX1//X19P/19fT/9fX1//X19P/29fT/9vX1//b19f/29vX/9vb1//b29f/29fX/9vX1//b29f/29vX/9vX1//b29f/29vX/9vb1//b29f/39vb/9/b2//j39//49/b/+Pf3//f29v/6+vn/6ers/3+axP9rmtj/d6bh/3Sj3v90o97/eafh/3+t5P99quH/dqTe/3qo4P92oNv/eaLa/36q4v+BruX/f63m/3eo4/9vot//a53c/22e3P9smdf/bpjU/3We1/94oNj/dp3X/3Oa0/9xmdL/bZjS/2WSzv9djMr/Z5DI/5Ks0f/Q1+P/9/Xy//n28//v7+7/7+7t//Du7v/w7u3/8O7t//Hv7//y8O//7evq/+zr6v/t7Ov/6+no/+ro5//r6ej/7erp/+7r6//u7Ov/7uvr/+3r6//u7Ov/7uzs/+/t7P/w7e3/8O7t//Du7f/v7e3/8O7t//Du7v/w7u3/7+7t//Du7v/v7u3/7+7t/+/t7f/v7ez/7+zs/+7s6//t7Ov/7evq/+3r6v/t6un/7erp/+3p6f/t6en/7Ojo/+vn5//r5+b/6eXk/+jk4//l4OD/4t3d/9/a2v/c19b/19LS/9TOz//Oycf/x8PA/8G9u//KxcP/2NPS/8fDwP/LxsP/3tnW/7Syr/+AgoH/en19/3x/f/97fX3/ent8/3l7e/94eXv/d3l5/3d5ef92eHj/dnd3/3V3d/90dnb/c3V1/4WHiP+Gh4j/hoiI/4aIif+GiIn/hoiJ/4eJif+HiYr/h4mK/4eKiv+Iior/iIqL/4iKi/+Ii4v/iIuM/4iLjP+JjI3/iYyN/4mMjf+KjI7/io2O/4qNjv+KjY7/io6P/4uOj/+Lj4//i4+Q/4uPkP+Nj5H/jZCR/4yQkf+NkJL/jZCS/46Rkv+OkpP/kJOV/4+Sk//P0M//9/b1//Dv7v/z8vH/8/Px//Pz8v/08/P/9PPz//X08//19PT/9fT0//b19P/19fT/9fX0//X19P/29vX/9vb1//b29P/29vX/9vb1//b29f/29vX/9vX1//b19f/29fX/9fX1//X19f/29vX/9vb1//b29f/29vX/9/f2//f39v/49/f/+Pf3//f29v/39/f/9/b0/4SXu/9tl9D/eqjh/3Oj3f9zot7/dKTf/3al4P94p+D/cqDa/3Og2/95pt7/cZvW/3Sd1v91otv/eabg/3io4v9zpeD/baHe/2mc2/9qmtn/bJvY/2qU0f9rkcz/b5XO/3GX0P9xl9D/b5fP/2+Y0f9wmdH/bpjQ/2uVzf9jjcn/Z47G/4+qz//P1+L/9vPv//Tx7//t7Oz/7+3t//Du7f/v7u3/7+7t/+/t7P/v7u3/7+/t/+3r6//p5+b/6ujn/+zq6f/t6+v/7uzr/+3r6v/t6+r/7evq/+7r6//u7Oz/8O3s/+/t7P/v7ez/7+3s//Dt7f/v7ez/7+3s/+/t7P/w7ez/7+zs/+/s6//u7Ov/7uzr/+7s6//t6+r/7evq/+3r6v/s6un/7erp/+zp6f/s6ej/7Ojo/+vn5//q5ub/6eXl/+fj4//l4eH/497e/9/b2v/c19b/2NPS/9PPzv/Nycf/x8LA/766uP/Dvrz/1dDO/8/Lyf/Qzcr/39vY/6mopf96fXz/e39+/31/f/97fX7/en19/3p8fP95env/eHp7/3h5ev93eXn/dnh4/3V3d/91d3f/dHZ2/3R1df+Gh4j/hoiI/4aIiP+GiIn/hoiJ/4eJif+HiYr/h4mK/4eJiv+Hior/iIqL/4iKi/+Iiov/iIuM/4iLjP+Ji4z/iYyM/4mMjf+JjI3/io2O/4qNjv+KjY7/io2P/4uOj/+Ljo//i46P/4uPkP+Lj5D/jI+Q/4yQkf+NkJH/jZCS/42Qkv+OkZL/jpKT/5CTlf+OkpP/lpiZ/9jY1//z8/H/8O/u//Lx8P/z8vH/8/Py//T08//19PP/9fT0//X09P/19fT/9fX0//X19P/19fT/9fX0//b29P/29fX/9vb1//b29f/29vX/9vb1//b19f/29fX/9vX1//b19f/29fX/9vX1//b19f/29vX/9vb1//f39v/39/b/+Pf3//j39//19fX////8/6qyxf9Yd7D/gKzg/3ek3f94pt//dqbg/3en4P91pN7/cZ/Z/2uZ1P9wntj/dKHa/22Y0/9tltD/bZjT/2uZ1f9qmdf/aJnX/2ea2P9mmdj/ZpbX/2iX1f9mkc7/YonE/2CEv/9ih8H/ZYvE/2iPx/9sk8v/bpbN/3CYz/9xmM7/bZXM/2uTyf9hicL/YIi//4+oy//a3uP/9/Tw//Du7f/u7Oz/8O3t/+/t7f/u7Ov/7uzr//Dv7v/v7u3/6ejn/+jm5f/q6Oj/7Orp/+7r6//u7Ov/7erq/+3q6v/t6+r/7uvr/+7s6//u7Ov/7uzr/+7s6//u7Ov/7uvr/+/s6//u6+v/7uvq/+7r6v/u6+r/7erq/+zq6f/t6un/7Onp/+zp6P/s6Oj/6+jn/+vn5//r5+f/6+fm/+rm5f/p5eX/6eXk/+fj4//l4eD/4t7e/9/b2v/b19f/2NPT/9POzf/MyMb/xcC+/765t/++urj/zMfF/9LNy//c2Nb/3drZ/52dm/94fHv/fICA/3t/f/97fn7/en19/3p8ff96e3z/eXt7/3h6e/94enr/d3l5/3Z4ef92eHj/dXd3/3R2dv90dXX/hoiI/4aIiP+GiIn/hoiJ/4aIif+HiYn/h4mK/4eJiv+Hior/iIqL/4iKi/+Iiov/iIuL/4iMjP+Ii4z/iYyM/4mMjf+JjI3/ioyN/4qNjv+KjY7/io2O/4qOj/+Ljo//i46P/4uPkP+Lj5D/jI+Q/4yQkf+NkZH/jZCR/42Rkv+NkZL/jpGS/46Rkv+PkZP/kJOV/42Rkv+Ul5j/ysvK/+7t7P/y8fD/8fHv//Pz8f/08/L/9PTz//X08//19PT/9fT0//X19P/19fX/9fX1//b19P/19vT/9vb1//X29P/29vX/9vb1//b29f/29vX/9vX1//b19f/19fX/9fX1//b19f/19vX/9vb1//b39f/39/b/+Pf2//f39v/39vb/+fj4/+zt7f9RZJD/ZYi//3yn3P95pt3/eKbf/3mp4f93pt7/cZ/Z/2iW0f9lks7/bpzW/26b1v9nkc3/ZY3J/2GLyP9fisj/XovK/1yMzP9fj8//YpPT/2KU0v9hkdD/YY3K/1yEwP9Xe7T/VHav/1Z5sf9bfrb/Yoa9/2mOxf9tkcf/bpPI/26Tx/9skMT/ao3B/2WLwP9bgrv/aIu9/7C/0//w7uz/8/Du/+3r6//v7ez/7u3s/+3s6//t7Or/7+7s/+7t6//p6Ob/6Ofl/+vp6P/t6+v/7uvr/+zq6v/s6en/7Orp/+3q6v/u6+v/7evq/+3r6f/t6+r/7uvq/+3r6v/u6+r/7uvq/+3r6v/t6ur/7enp/+3p6f/r6ej/7Ono/+zp6P/r6Oj/6+jn/+rn5v/p5uX/6eXk/+jk4//o4+P/5+Li/+bh4f/k4N//4d3d/97a2v/b19f/19PT/9PPzv/MyMb/xcC+/765t/+6tbP/xMC8/9PPzf/k4N7/0M7M/4+Qj/94e3v/fICB/3t/f/96f37/en59/3p9ff96fX3/eXx8/3l7e/94e3r/d3p6/3Z5ef92eHj/dXd4/3V3d/9zdnb/c3Z1/4aIiP+GiIn/hoiJ/4aJif+HiYn/h4mK/4eJiv+HiYr/iIqK/4iKi/+Iiov/iIqL/4iLjP+Ii4z/iYuM/4mMjP+JjI3/iYyN/4qMjv+KjY7/io2O/4qNjv+Kjo//i46P/4uOj/+LjpD/jI+Q/4yQkf+MkJH/jJCR/42Qkf+NkZL/jZGS/46Rkv+OkpP/jpKT/4+SlP+Pk5X/jZGT/42Rkv+vsbD/29va//Hx7//z8vH/8vLx//T08//19PP/9fT0//X09P/19fT/9fX0//X19P/19fT/9fX0//b19P/29vT/9vX0//b29f/29fX/9vX1//b19f/19fT/9fX1//b19f/29fX/9vb1//X19P/29vX/9/f2//f39v/39/b/9PX0/////f+utcP/MEmB/2+VzP93odf/eKTa/3uo3/94pt7/cqDa/2eV0P9hjMj/Yo7K/2eU0f9lkc3/YInF/12Ewf9ZgL3/V3+8/1aAv/9VgcD/WYbG/1yMzP9djc3/XIrK/1yIxv9agb3/U3aw/0xtpf9MbKT/T2+n/1V2rv9afLP/YYS6/2WHvf9jhrv/YYS4/2CDuP9fgbb/YoO1/2KEuP9egbf/iaDE/9ve4//38+//7evr/+3r6v/u7Ov/7ezr/+zq6f/t7Or/7ezq/+vp5//q6Of/7evq/+7r6//s6un/6+no/+zq6f/t6+r/7erp/+3r6v/t6+r/7evp/+3q6f/t6un/7erp/+3q6f/s6ej/7Onp/+zp6P/r6Oj/6+jo/+zp6P/r6Oj/6ujn/+rn5v/p5uX/5+Tj/+Xh4f/m4eH/5uLh/+bh4f/k4N//4dzc/9zY2P/Z1NT/19LS/9TQz//QzMn/yMPB/7y4tf+6tbL/wLu4/9fT0P/l4uD/wb+//4aIiP96fX3/fYGB/3t/f/97fn7/eX5+/3l9ff96fX3/eXx9/3l8fP95e3v/eHt7/3h6ev92enn/dnl5/3Z4eP91d3f/dHZ3/3N2df+GiIj/hoiJ/4aIif+HiYn/h4mJ/4eJiv+HiYr/h4mK/4eKi/+Iiov/iIqL/4iLi/+Ii4z/iIuM/4mMjP+JjIz/iYyN/4qNjf+KjY7/io2O/4qNjv+KjY//i46P/4uOj/+LjpD/i4+Q/4yQkP+LkJD/jJCR/4yRkf+NkJL/jZCS/42Rkv+OkZP/jpKT/46Sk/+PkpP/jpKT/4+Tlf+PlJX/i5CR/5WZmf+7vLv/6Obm//X08v/y8vH/9PPy//X08//19PP/9fT0//X09P/19PT/9fX0//X19P/19vT/9vX0//b19P/29fT/9vX0//X19f/19fX/9fX0//X19P/19fT/9vX1//b19f/19fX/9vb1//f39v/39/b/9/f2//X19P////z/c3+c/zZSjf9wmdL/cpvS/3ag1/93o9r/cp/Y/2yZ0/9ijcj/XIbC/2CMyP9ij8v/XonF/1uDwP9WfLn/VXu2/1R6t/9Wfbr/Vn+8/1aBwP9Xg8L/WIbF/1qIxv9ahMH/WH+6/1B0rf9IaaH/R2ad/0dlnf9KaqH/UHGo/1R1rP9Yea7/Wnyw/1h5rf9Wd6z/Vner/1FwpP9ceqz/YYCx/119sf9uirj/vsbW//Tw7P/u6+r/6+np/+3r6v/t6+r/7Oro/+zr6f/u7Or/6+nn/+zq6f/t6+r/7Onp/+vo6P/r6ej/7Orp/+zp6f/t6ur/7Orp/+zp6P/r6ej/7Ono/+zp6P/r6ej/7Ono/+vo5//r6Oj/6+jo/+vo5//r6Oj/6+jo/+vo5//p5uX/6OXk/+Xi4f/k4eD/5eHg/+bi4f/m4uH/4t7d/9zY1//W0tL/087O/9PPzv/U0M7/zcnH/8C9uf+3s7D/wr67/97b2P/e3Nn/sbCu/4GEhP97fn//fYCB/3t/f/97f3//e35+/3p+fv95fX7/en18/3l9fP95fHz/eXt7/3h7e/94enr/d3p6/3Z5ef91eHj/dHh4/3R2d/9zdnb/hoiJ/4aIif+HiIn/h4mJ/4eJiv+HiYr/h4mK/4eKiv+Iiov/iIqL/4iKi/+Ii4z/iIuM/4iLjP+JjIz/iYyN/4mMjf+KjI3/io2O/4qNjv+KjY7/io6P/4uOj/+Ljo//i4+Q/4uPkP+Mj5D/jI+R/4yQkf+MkJH/jZCS/42Rkv+NkZL/jpGT/46Sk/+OkpP/jpKU/4+SlP+Pk5T/j5OV/5GVlv+PlJX/jJGR/6Cjo//Y2Nf/9PPy//Ly8P/z8vH/9PPy//Tz8//19PP/9fT0//X08//19PT/9fX0//X19P/19fT/9fX0//X19P/19fT/9fX0//X19P/19fT/9fX0//b19P/29fX/9vX1//b29f/29vX/9/f2//b29f/39/X/9PXz/1FhiP9IaaX/cp7X/22Vzf9xm9H/c5zU/22Y0v9kj8n/XobB/12FwP9dicT/XIfE/1qDwP9YgLz/WH65/1Z7tf9We7b/Vnu3/1Z+uf9Xf7v/WIG+/1iEwv9ZhcL/WoTA/1Z8t/9Qc6z/SWqh/0ZlnP9FZJv/Rmac/0hnnf9Na6L/T22i/1FwpP9ScaX/UnKl/1Fxo/9QbqH/U3Gj/1Ryo/9Zdqb/XXyt/159r/+ZqsX/6Ofm/+/s6v/q6Oj/7erq/+3r6v/r6ej/6+no/+3s6//t6+r/7evq/+zq6f/r6Of/6+no/+zo6P/s6ej/7Ono/+vp6P/r6Of/6+nn/+vo5//r6Of/6+jn/+vo5//r5+b/6+fn/+ro5//r5+f/7Ojo/+vo6P/r5+f/6OXk/+bj4f/j4N//4+Df/+Tg4P/n4+L/5uLh/+Hc3P/X09L/zsrJ/83JyP/Uz87/1NDP/8XCwP+5trP/zMjF/+De3P/R0M3/oaGf/36BgP98f4D/fYCB/3x/gP98f3//e35//3t+f/96fn3/eX1+/3l9ff94fXz/eHx8/3h7e/94e3v/eHp7/3d5ev92eXn/dXl5/3V3eP90dnf/c3Z2/4aIif+HiIn/h4mJ/4eJiv+HiYr/h4mK/4eJiv+Iior/iIqL/4iKi/+Iiov/iIuL/4iLjP+Ii4z/iYuN/4mMjf+JjI3/io2O/4qNjv+KjY7/io2P/4uOj/+Ljo//i46P/4uPkP+Mj5D/jI+R/4yQkf+MkJH/jZCR/42Rkv+NkZL/jZGS/46Sk/+OkpP/jpKT/46SlP+OkpT/j5OU/4+SlP+Pk5X/kZSW/5KWl/+NkZP/k5eX/8bGxv/x7+7/9PLx//Lw7//z8vH/9PLy//Tz8v/08/L/9PPy//X08//19PP/9fTz//X09P/19fT/9fX0//X19P/19fT/9fX0//X19P/29fT/9vX0//b19f/29fX/9vb1//f39v/29vX/+vr4/+Xn6P9AU4D/W4C8/3Ke1v9qkcn/bZPL/2yUzf9nkMv/YIjD/1yCvP9dhb//XIbD/1mDwP9agr7/WYG7/1l/uP9Yfbf/WH21/1Z7tf9WfLb/VXu1/1h+uv9Zg7//WoTA/1qEv/9Xfrj/UnWt/0xspP9JaJ//RWOa/0Ril/9FYpf/RmSY/0lnmv9LaZz/S2mc/0xqnf9Napz/TGma/0xpm/9PbJz/UGyc/1Nwof9Ydqb/UXGn/3qRuP/a2t//8u3q/+nn5//t6un/7erq/+vp6P/r6ej/7uzq/+3r6v/r6ej/6+jn/+rn5//s6en/7Onp/+zp6P/r6Oj/6+jn/+rn5v/q5+b/6ufm/+rn5v/q5+f/6efm/+rn5//q5ub/6+jn/+vo6P/s6Oj/6ubm/+bj4v/i397/4Nzc/+Le3v/l4eD/6OTj/+bh4f/d2Nj/zsrJ/8XBwP/Mx8b/1dDQ/83JyP+/u7r/1dLQ/9jX1f+6ubb/lZaU/3yAgP98gIH/fYCB/32Agf98f4D/e39//3t+gP96fn//en5+/3p9fv96fX7/eH18/3h9ff94fHz/eXt7/3h6ev93enr/dnl5/3V4ef91eHj/dHd3/3R2dv+GiIn/h4mJ/4eJif+HiYr/h4mK/4eJiv+Hior/iIqL/4iKi/+Iiov/iIuL/4iLjP+Ii4z/iIuM/4mMjf+JjI3/iYyN/4qNjv+KjY7/io2O/4qOj/+Ljo//i46P/4uOkP+Mj5D/jI+R/4yPkf+Mj5H/jJCR/42Qkf+NkZL/jZGS/46Skv+OkpP/jpKT/46Sk/+PkpT/j5KU/4+TlP+Pk5T/j5OV/4+Tlf+QlJX/kZWX/4+Ulf+NkpP/sbOz/+Xj4v/z8fD/7+3t//Du7f/y8fD/8/Ly//Tz8v/08/L/9PTz//X08//19PP/9fTz//X08//19PP/9fT0//X09P/19fT/9fX0//b19P/29fX/9vb1//b29f/39vb/9vX1//38+v/X2t7/PVGC/2yTy/9wnNP/aI3F/2mPxf9oj8j/ZIrE/16Dvf9dgrv/XoXA/1yGwf9ahL//WoG8/1yCvP9bgLn/Wn63/1d7tP9VebH/VHiw/1R4sf9We7X/WH+5/1d/u/9Yf7n/V3y2/1J1rv9Nb6f/SWig/0Zlm/9EYZb/RF+T/0Nfkf9EYZP/R2SX/0hmmP9IZZf/SGSV/0hklP9HY5L/SWSU/0pmlf9LZ5j/Tmqa/1Vyov9PbqT/ZYGu/8vQ2f/z7ur/6efn/+zp6P/s6en/6+nn/+ro5//t6+r/7Onp/+ro5//q5+f/6+jo/+vo5//r6Of/6ubm/+nm5v/p5uX/6ebl/+rn5v/q5+b/6ufm/+nm5f/p5uX/6ufm/+vn5//r5+f/6+fn/+fk4//j39//39rb/97b2//i3t7/5uLi/+jk5P/i3t7/1tHR/8fDwf/AvLr/zMjG/8/Kyv/NyMf/29nX/87Lyv+op6X/io2M/3yAgf99gYL/fYGC/32Agf98gIH/fH+A/3t/gP97f3//en5//3p+f/96fn7/en1+/3h9ff95fXz/eXx8/3h7e/94e3v/d3p6/3Z6ef92eHn/dXh4/3R3d/90dnb/hoiJ/4eJif+HiYn/h4mK/4eJiv+Hior/iIqK/4iKi/+Iiov/iIqL/4iLjP+Ii4z/iYuM/4mLjP+JjI3/iYyN/4mMjf+KjY7/io2O/4qNjv+Ljo//i46P/4uOkP+LjpD/jI+Q/4yPkf+MkJH/jJCR/42Qkv+NkJL/jZGS/42Rkv+OkZL/jpKT/46Sk/+OkpP/j5KU/4+SlP+Pk5T/j5OU/4+Tlf+Pk5X/kJSV/5CUlf+RlZb/kZWW/4yRkv+cn5//ysrK/+zp6f/w7u7/7evr//Du7v/z8vH/9PPy//Tz8//09PP/9fTz//X08//19PP/9fTz//X09P/19PT/9fX0//b19P/29fT/9vX0//b19f/39vX/9/b2//X19P///fv/zdDX/z5Uhv90ndT/bpfO/2eLwv9ojML/Z4zE/2CEvf9dgbr/X4O9/1+Hwf9eh8L/XIW//12CvP9cgrv/XIC4/1p+t/9YerP/VHev/1N2rv9Sda7/VHix/1V7tP9Xfrj/WH+4/1d9tf9Ud6//Tm+n/0trof9GY5n/Ql+T/0JekP9CXY//QlyP/0Nekf9EYJL/RWCS/0Rej/9FYJD/RWCQ/0Rfjv9EXo7/RWCP/0ZikP9IY5L/UGyb/05toP9deqn/wcfT//Lu6v/o5ub/6ujn/+vo6P/q6Of/6+jn/+3q6f/r6ej/6ufn/+vn6P/s6Oj/6+fn/+nm5v/o5eX/5+Tj/+jk5P/p5eX/6eXk/+nl5f/n5OT/6eXk/+nm5v/q5ub/6+fn/+nm5f/l4uL/4dzd/9zX2P/d2dr/49/f/+fj4//l4eH/3djX/83JyP/AvLv/vbm4/8nEw//Z1dT/2tfW/7i3tv+ZmZj/hYiI/32Bgv9/g4P/foKD/32Bgv99gIL/fICB/3yAgP98f4D/e3+A/3t+f/96fn//en5+/3l9fv94fX3/eX19/3l8fP94e3z/eHt7/3d6ev92enr/dXl5/3V4eP90d3j/c3Z2/4aIif+HiYn/h4mK/4eJiv+HiYr/h4qK/4iKiv+Iiov/iIqL/4iKi/+Iioz/iIuM/4mLjP+Ji4z/iYuN/4mMjf+JjI7/io2O/4qNjv+Kjo//i46P/4uOj/+LjpD/i46Q/4yPkP+Mj5H/jI+R/42Pkf+NkJL/jZCS/42Rkv+OkZP/jpGT/46Sk/+OkpP/jpKT/4+SlP+PkpT/j5KU/4+TlP+PkpX/j5OV/5CTlf+Qk5X/kJSV/5CUlv+Slpf/jpOV/46Sk/+oqqv/1NPU/+/s7P/w7e3/7uvr//Hv7//08/L/9PPy//Tz8v/19PP/9PTz//X08//19PT/9fT0//X09P/19PT/9vT0//b09P/29fX/9vX1//f29f/19fT///77/8jL1P9BV4r/dZ/W/2yUyv9oi7//aIm+/2WHvf9hgrn/YIC5/2GEvv9fiMP/X4jC/12Evv9cgrv/XIC5/1t/t/9afbX/V3qy/1Z3r/9Tda3/UHKp/1Byqv9Sda3/VXqz/1Z8tf9We7T/VXmw/1Bxqf9La6D/SGWZ/0Rgk/9CXY//Ql2P/0Jdj/9CXI7/QlyN/0Jcjf9CXI3/QFqK/0Fbi/9AWon/QVuK/0Fbiv9BW4n/RF6L/0ZhkP9LZ5f/Tmyf/1Zzpf+2v87/8ezo/+fk5P/q5ub/6ufn/+nn5v/q5+f/7Ono/+rn5//q5+f/6+fn/+nl5f/o5OT/5+Tk/+bi4v/n4uL/5+Tj/+fj4//n5OP/5+Tk/+jk5P/o5eX/6ebl/+nl5P/n4+P/49/f/9zX2P/Y09X/29fY/+Pe3//l4eH/4dzc/9XR0P/Hw8H/vbm3/8bBwP/a1tX/xsTC/5ydnP+Hior/gYSF/3+ChP+AhIX/f4OE/36Cg/99gYL/fYGC/32Bgf98gIH/fH+B/3t/f/97fn//e35//3p9fv95fX7/eX1+/3h9ff94fHz/eXt8/3l7e/92enr/dnp6/3V5ef90eHj/dHd4/3N2d/+HiIn/h4mK/4eJiv+HiYr/h4mK/4eKiv+Iiov/iIqL/4iKi/+Ii4z/iIuM/4mLjP+Ji4z/iYyN/4mMjf+JjI7/ioyO/4qNjv+KjY//io6P/4uOj/+Ljo//i4+Q/4yPkP+Mj5D/jI+R/42Qkf+NkJH/jZCS/42Rkv+NkZL/jpGT/46Rk/+OkpP/jpKT/4+Sk/+PkpT/j5KU/4+TlP+Pk5T/j5OV/4+Tlf+Qk5X/kJSV/5CUlf+QlJX/kJSW/5GVl/+SlZf/jZKT/5GVlv+wsbL/29nZ//Lv7//x7u7/7+3t//Py8f/08/L/9PPy//Tz8v/19PP/9fTz//X08//19PT/9fT0//X09P/29fT/9vX1//f29v/39fX/9fT0///++//GytP/QlqN/3Oe1/9rkMb/aoq8/2yJu/9nhrr/ZIO4/2KDu/9ghcD/X4fD/16GwP9ehL3/XoS9/16Cuv9afbX/V3qx/1R3r/9Tdaz/UHGp/1Bxp/9Ob6X/UHGo/1J0q/9VeLD/Vnmy/1R2rv9Sc6r/TGuh/0lmmf9HYpT/RF6R/0Fdjv9AW4z/QVuM/0Fai/8/WYn/P1iJ/z1Xh/8+V4f/PVeG/zxWg/88VoP/PVeF/z1XhP9AWoj/Q16N/0hklP9Map3/UG6i/6q1yP/u6ub/5eLi/+jl5P/p5uX/6OXk/+nn5v/s6un/7Onp/+ro5//p5eX/5+Tk/+bi4//l4eL/5eLh/+Xi4v/m4uL/5uPi/+bj4v/m4uL/6OTj/+fk4//n4+P/5OHg/+Dc3P/Z1NX/1tHS/9rV1v/h3Nz/497e/93Z2P/Oysr/wb28/8/Lyf/W0tH/rKyr/4uNjf+Dhoj/gYSG/4GEhv+AhIb/f4OF/3+DhP9+goP/foKD/32Bgv99gYH/fYCB/3yAgf98f4D/e3+A/3t/gP96fn//en5//3l9fv95fX3/eHx9/3h8fP94e3v/d3p7/3Z6ev91eXn/dXh5/3R4eP90d3f/h4iJ/4eJif+HiYr/h4mK/4eKiv+Hiov/iIqL/4iKi/+Iiov/iIuM/4mLjP+Ji4z/iYuM/4mLjf+JjI3/ioyO/4qNjv+KjY7/io2P/4qOj/+Ljo//i46Q/4uPkP+Mj5D/jI+R/4yPkf+Nj5H/jY+S/42Qkv+NkJL/jZGS/46Rk/+OkZP/jpKT/46Sk/+PkpP/j5KU/4+SlP+Pk5T/j5OU/4+Slf+QkpX/kJOV/5CTlf+QlJX/kJSV/5CUlv+QlJb/kZWW/5KWl/+RlZf/jZGT/5KWmP+ztbb/393d//Lv7//x7+//8e/v//Tz8v/08/L/9PPy//X08//19PP/9fTz//X08//19PP/9vT0//b09P/39vX/9vX1//X09P/9/Pn/y83W/0hgkv90n9f/ao7C/22Kuf9tiLj/aYS3/2eFuP9ihLz/X4bB/1+Iw/9ghsD/YIW+/12Cuv9afrb/Vniv/1N1rP9Rcqr/T3Gn/05uov9Lap//Smid/0troP9PbqX/UnSr/1R2rf9Sc6r/TW+k/0tqn/9JZZn/RGCS/0Jdj/9BW43/QVqM/z5XiP8+V4j/P1eH/zxVhP88VYT/OlOC/zpTgf86UoD/OVJ//zlSf/85U3//OVKA/zxWhf8/Wor/RWKS/0pomv9GZpv/prHE/+3o5P/k4eH/5+Tk/+fk5P/n5OT/6ufm/+vp6f/r6Oj/6OXl/+bj4//l4eL/49/f/+Tg4P/k4eD/5OHh/+Th4P/k4eD/5OHg/+Xi4v/k4eH/49/f/+Dc2//c19f/1dDR/9TP0P/Z1NX/39ra/97a2v/Rzc3/zcrJ/9nV1P/Mycj/np+e/4SHiP+Dhoj/goWI/4KEh/+Ag4b/gIOF/3+Dhf9/goX/foKE/36Cg/9+goP/fYGC/32Agv98gIH/fH+B/3t/gP97foD/en5//3p9f/95fX7/eX19/3l8ff94fHz/eHt8/3d7e/93enr/dnl6/3Z4eP90d3j/dHd2/4eJif+HiYr/h4mK/4eJiv+Hior/iIqL/4iKi/+Iiov/iIuL/4iLjP+Ji4z/iYuM/4mLjP+JjI3/iYyN/4qMjv+KjY7/io2O/4qNj/+Ljo//i46P/4uOkP+Lj5D/jI+Q/4yPkf+Mj5H/jZCR/42Qkv+NkJL/jZCS/46Rk/+OkZP/jpGT/46Sk/+OkpP/jpKU/4+SlP+PkpT/j5OU/4+TlP+Pk5X/kJOV/5CTlf+Qk5X/kJSV/5CUlv+QlJb/kJSW/5CVlv+QlZb/kZWX/5KWmP+QlZf/jJCS/5SYmv+3t7n/39zd//Du7v/y8O//8vHw//Px8P/z8vH/9PPy//T08//19PP/9fTz//X09P/29PT/9/b1//f19f/19PT//Pr4/9TW2/9QaZn/dqDX/2uNv/9vibb/b4i2/2yHt/9mhLj/YIW+/2GKxf9hicP/YYfA/2CFvf9dgbr/WXuz/1J0qv9Pb6X/TWyh/0xroP9Lap7/S2ic/0llmf9JZZn/S2md/05upP9Scqn/UHCm/05tof9Map7/R2SX/0Rgk/9EXY//QVqM/z9YiP89VoX/PFaF/zxUg/88VIL/OlGA/zpRgP84UH//N098/zdPff81TXn/NU16/zZPff83UH3/OFOB/z1Ziv9CX5D/RWOV/0Zlmv+vt8f/6+fj/+Lf4P/m4+L/5+Tj/+fk4//q5+f/6+no/+nm5v/m4+P/4+Df/+Le3v/g3N3/4t7f/+Le3v/i3t7/4t7e/+He3v/h3t7/4t7e/9/a2//a1db/19LT/9PP0P/Szc//19LT/9vW1v/V0ND/2tbW/9zZ1/+3trX/j5GR/4SIiP+Dh4n/g4aI/4KFh/+BhIb/gYSG/4CDhf+Ag4X/f4KF/3+DhP9+goP/fYGD/32Bgv98gYL/fICB/3yAgf97f4D/e3+A/3t+f/96fX//en1+/3l9fv94fH3/eXx8/3h7fP93e3v/dnp6/3d5ef91eHn/dXh4/3R3d/+HiYn/h4mK/4eJiv+Hior/h4qK/4iKi/+Iiov/iIqL/4iLjP+Ii4z/iYuM/4mLjP+JjI3/iYyN/4mMjf+KjI7/io2O/4qNjv+KjY//i46P/4uOj/+Lj5D/jI+Q/4yPkP+Mj5H/jJCR/42Qkf+NkJL/jZCS/46Qkv+OkZP/jpGT/46Rk/+OkpP/jpKT/4+SlP+PkpT/j5KU/4+TlP+Pk5T/j5KV/5CTlf+Qk5X/kJOV/5CTlf+QlJb/kJSW/5CUlv+QlJb/kJWW/5CVlv+QlZb/kZWX/5KWmP+QlJf/i5CS/5SYmv+1t7f/3tzd//Lv7//08vL/8fDv//Hw7v/z8vH/9fTz//X08//18/L/9fPz//f29v/39vX/9fT0//n49v/h4eX/YHim/3Sf1f9qi73/cIi0/3GJtf9uiLf/Y4W7/1+Gwf9fiMP/X4bA/2GGv/9hhLv/W3uz/1Nyp/9Nap7/SWSX/0Vfkf9FX5H/RF2O/0Ndjf9FYJH/R2KT/0llmP9KZpr/TWqe/01soP9LaZz/SWaZ/0dklv9DXpD/QFyM/z9Zif89Vob/O1SE/ztTgv87U4H/OlKA/zdPff83T33/N098/zVNef8zTHj/NEx3/zNKdv8ySnb/Mkt4/zNOe/81UX//OlaG/0Bcjv9DYZX/TGmd/73Czf/q5eP/4t/f/+Xi4f/l4uP/5+Tj/+nm5f/q5+f/5+Pj/+Hd3f/f29v/3dna/9/b3P/g3d3/3tvb/93Z2f/d2dj/3trZ/93Z2v/Z1tX/1NDR/9TQ0P/Tzs//0cvM/9LNzv/b19b/5OHh/9HOzf+goaD/hYmJ/4OHif+EiIn/g4eI/4KGh/+ChYf/gYSH/4GEhv+Ag4b/gIOF/3+Chf9/goT/foKD/36Cg/99gYP/fYGC/3yAgf98gIH/e3+A/3t/gP97fn//en5//3l+fv95fX7/eHx9/3l8fP94e3z/d3t7/3Z7ev93eXr/dXh5/3V3eP91d3f/h4mJ/4eJiv+HiYr/h4qK/4eKi/+Iiov/iIqL/4iLi/+Ii4v/iYuM/4mLjP+Ji4z/iYyN/4mMjf+KjI3/io2O/4qNjv+KjY//i46P/4uOj/+Ljo//i4+Q/4yPkP+Mj5H/jI+R/4yQkf+NkJL/jZCS/42Qkv+OkJL/jpGT/46Rk/+OkZP/jpKT/46Sk/+PkpT/j5KU/4+TlP+Pk5T/j5OU/4+Tlf+Qk5X/kJOV/5CTlf+Qk5X/kJSW/5CUlv+QlJb/kJSW/5CVlv+QlZb/kJWW/5CVlv+QlZf/kZWX/5KWmP+QlJf/ipCS/5WZmv+2t7j/2tnZ//Hv7v/18/L/8O7t//Hw7//08/P/9fPy//Xy8v/29fX/9/b2//b19P/39fX/8O7u/3iOtv9xnNP/Z4m9/3GHsv90irP/bYi5/2KHvv9gicT/YYvF/2CIwP9gg7n/YX+z/1p3q/9RbJ7/SWSV/0Rej/9AWon/QVqI/0FZh/8/WIX/PlaF/z5Whv9AWYr/RV+Q/0lllv9KaJr/Smib/0hll/9GYZL/Q12O/z5XiP89Vob/PFSE/zpSgv86UoD/OVF+/zhQff84T3z/NU16/zRMeP8zS3f/M0p3/zJJdP8wR3L/L0dx/y5Gcf8vSHT/MUt2/zRPff85VYX/P1yO/0NimP9ZdaX/ztDV/+fj4f/g3t7/4+Hg/+Xi4f/m4+L/6ebl/+jl5f/i3t//29jY/9vW1//b2Nj/3NjY/9rW1v/Z1dX/2dTU/9rV1f/Y1NX/1dHR/9HOzf/Qy8z/z8vL/9bS0v/i3t7/3tra/7e1tv+OkJD/hIiJ/4WJiv+EiIn/g4eI/4OHiP+Chof/gYWH/4GFh/+BhIb/gISG/4CDhf9/g4X/f4KE/36ChP99goT/fYGD/32Bgv98gYL/fICB/3t/gP97f4D/e36A/3p+f/96fX7/eX1+/3l9ff94fH3/eHt8/3d7e/93env/d3l6/3Z5ef91eHj/dHd3/4eJiv+HiYr/h4mK/4eKiv+Iiov/iIqL/4iKi/+Ii4v/iIuM/4mLjP+Ji4z/iYyM/4mMjf+JjI3/io2O/4qNjv+KjY7/i42P/4uNj/+Ljo//i46Q/4uPkP+Mj5D/jI+R/4yQkf+NkJH/jZCS/42Qkv+NkZL/jpGS/46Rk/+OkZP/jpGT/46Sk/+OkpT/j5KU/4+SlP+Pk5T/j5OU/4+Tlf+Pk5X/kJOV/5CTlf+QlJX/kJSW/5CUlv+QlJb/kJSW/5CVlv+QlZb/kJWW/5CVlv+QlZb/kJWX/5CVl/+QlZf/kZWX/5KWmf+PlJf/i5GU/5KXmP+sr6//2NfX//Px8f/y8O//7u3s//Lx8P/08vL/9PPz//f29f/29fT/9vT1//n39f+PosX/bpjS/2aIvP9yiLD/dImy/2qIuv9iicL/YozG/2CJwv9fg7r/ZYO2/2J+r/9bdqj/VW+h/0xllv9CW4r/PlWC/z1Sfv89VID/PVWC/z5Wg/89VIH/OlJ//ztTgf9BWon/RWCP/0dik/9FYZL/Q16O/0Baiv89VoT/OlOC/zhPfv84T33/OE99/zdOe/82TXr/NUx5/zRLd/8zSXX/Mkh0/zBHcv8vRnH/L0Zw/y1Ebv8qQmv/KkJs/y1GcP8wS3f/NVB+/zpWh/9EYZP/Q2KZ/2yDrP/d29r/4d/d/+De3f/i397/4+Hg/+Xi4f/m4+P/5eLh/9zY2P/V0tL/1tPT/9jU1f/W0tP/1M/Q/9TPz//U0ND/0s7O/9HOzv/Qzcz/0s7O/+Dc3P/h3t3/vr29/5iZmf+FiIr/hYmL/4aJi/+FiIr/hIeJ/4OHif+Dh4j/goaI/4KGh/+BhYf/gYSG/4CEhv+Ag4X/gIOF/3+Dhf9/goT/foKE/36Bg/99gYL/fIGB/3yAgf98gIH/e3+A/3p/f/96fn//en5//3l9fv95fX3/eXx9/3h8fP93e3z/d3t7/3Z5ev91eXn/dXh4/3R3d/+HiYr/h4mK/4eJiv+Hiov/iIqL/4iKi/+Iiov/iIuL/4iLjP+Ji4z/iYyM/4mMjf+JjI3/iYyN/4qNjv+KjY7/io2O/4uNj/+Ljo//i46Q/4uOkP+Lj5D/jI+R/4yPkf+MkJH/jZCR/42Qkv+NkZL/jZGS/46Rk/+OkZP/jpGT/46Sk/+OkpP/jpKU/4+SlP+Pk5T/j5OU/4+TlP+Pk5X/kJOV/5CTlf+Qk5X/kJSV/5CUlv+Qk5b/kJSW/5CUlv+QlZb/kJWX/5CVl/+QlZf/kJWX/5CVl/+QlZf/kJWX/5CVl/+QlZf/kZWY/5KWmf+Qlpj/jJKU/5GWl/+ytLX/397d//Lw7//v7Oz/7+3s//Lw8P/29PT/9vT0//X09f/++/f/p7fT/2uVz/9khr3/c4iw/3CHs/9lh7z/Y4zE/2OKxP9ghL3/ZYO2/2eDs/9jf7D/YHuu/1h0qP9OaZ7/RV6P/z9Vgv89U3//OlB8/ztRff86UHz/OU56/zdOev85T3z/PFOA/z9Xhf9AWon/QluK/z5Xhv88VYP/OVF+/zhQff81TXr/Nk16/zVMeP80THj/NUt3/zNIdf8xSHP/MUdz/zFGcv8wRnL/LkRu/y1DbP8qQGn/Jz5m/yg9Zf8qQWr/LUZx/y9Kd/81UYH/OleK/0VhlP9BYJj/hJSy/+Tf2//c2dj/3tzb/+Dd3P/h3t3/4t/e/+Pg4P/f29v/0s/O/9DNzP/Sz8//0s7P/87Kyv/Oycr/0c3N/9HNzv/PzMv/2dXV/+Xi4f/Pzcz/np+f/4SIif+EiIr/hoqM/4aJi/+FiYr/hIiK/4SHif+Dh4n/g4eI/4KGiP+Chof/gYWH/4GFhv+AhIb/gISG/4CDhf9/g4X/f4KE/36Cg/9+gYP/fYGC/3yBgv98gYL/fICB/3t/gP97f3//en5//3p+f/95fX7/eX19/3l8ff94fHz/eHt8/3d7e/93enr/dXl5/3V4ef90eHj/h4mK/4eJiv+Hior/h4qL/4iKi/+Iiov/iIqL/4iLi/+Ii4z/iYuM/4mMjP+JjI3/iYyN/4mMjf+KjY7/io2O/4qNj/+Ljo//i46P/4uOkP+LjpD/jI+Q/4yPkf+Mj5H/jZCR/42Qkf+NkJL/jZGS/46Rkv+OkZP/jpGT/46Rk/+OkpP/jpKT/4+SlP+PkpT/j5OU/4+TlP+Pk5T/j5OV/4+Tlf+Qk5X/kJSV/5CUlv+QlJb/kJSW/5CUlv+QlJb/kJWW/5CVl/+RlZf/kJWX/5CVl/+QlZf/kJWX/5CVl/+QlZf/kJWX/5CVmP+QlZj/kZaY/5KXmf+Qlpn/jJKU/5Wam/+7vL3/4uHg//Du7f/u7ev/8fDv//X19P/19fX//vz4/77K3f9nkcz/ZIe9/3GHr/9phbX/YYe//2KKw/9iiMD/ZoW5/22It/9qhrX/ZIK2/19/t/9Xd7D/UG2l/0hilv9AWIj/PlWC/zxTf/86T3v/OU55/zdMdv82S3T/Nkt1/zVMdv82TXj/OVB7/zpRfv85UX7/OE98/zZNef80THf/M0p1/zJJdP8zSXT/Mkl0/zFHc/8xR3L/MUdy/y9Fcf8uRG//LUNu/yxCbP8sQmr/KT9n/yY7Yv8kOF//Jj1l/ypDbf8sRXL/MEt7/zZSg/89WIv/Q16S/zxaj/+gqLn/4t3a/9nX1v/c2tn/3drZ/9/c2v/e29v/3NrZ/9XR0f/Lx8f/y8fH/83Jyf/Kxsb/zsrK/9HNzf/Szs7/39vb/93a2f+2trb/jZCQ/4SIif+Hi4z/h4qM/4aJi/+GiYv/hYiK/4SIiv+Eh4n/g4eJ/4OHiP+Choj/goaI/4KFh/+BhYf/gYSG/4CEhv+AhIX/gIOF/3+Dhf9/goT/foKD/32Bg/99gYL/fICB/3yAgf98gID/e39//3p+f/96fn//eX5//3l9fv95fX3/eHx9/3h7fP93e3v/d3p6/3Z5ef91eHn/dHd4/4eJiv+Hior/iIqK/4eKi/+Iiov/iIqL/4iKi/+Ii4z/iIuM/4mMjP+JjI3/iYyN/4mNjf+KjY3/io2O/4qNjv+KjY//i46P/4uOj/+LjpD/i4+Q/4yPkP+Mj5H/jJCR/42Qkf+NkZH/jZGS/42Rkv+OkZL/jpGT/46Sk/+OkpP/jpKT/46SlP+PkpT/j5KU/4+TlP+Pk5T/j5OV/4+Ulf+QlJX/kJSV/5CUlf+QlJb/kJSW/5CUlv+QlJb/kJSW/5CUl/+QlZf/kJWX/5CVl/+QlZf/kJaX/5CVl/+QlZf/kJWX/5CVl/+QlZf/kJWY/5CVmP+QlZj/kJaY/5KXmf+Plpj/i5KU/5ednv+6vb3/4eDf//Lw8P/29fX/9PPz//z59//S2OP/Z47J/2WIvf9wh7H/YoO5/2GIwP9ji8T/ZYm+/26Luf9uirf/Zoa5/2GDu/9cfrj/V3iy/1FvqP9IY5n/QluN/z1VhP87Un7/OU56/zVKdP81SnL/Mkdw/zFGb/8wRW3/L0Vt/zFHcf8xSHL/Mklz/zFHcv8wR3H/MUhy/zBHcv8vRnD/L0Zw/y9FcP8vRnD/L0Vw/y9Fb/8uQ2//LkNu/ytBbP8qQGr/Kj9n/yc8Y/8kOFz/IjZc/yM5Yf8mPmf/KEJu/ytFdP8wSnr/NlCC/zlUhv84VIf/QFmH/7y9w//d2db/19TU/9nX1v/Z1tb/2dbW/9jU0//U0M//zcnI/8TAwP/GwsL/yMTE/9DMzP/W09L/3NnY/8LBwP+Ym5v/hImK/4aKjP+Hi4z/hoqL/4aJi/+FiYv/hYmL/4WIiv+EiIn/hIeJ/4OHif+Dh4n/g4eI/4KHiP+Chof/gYaH/4GFhv+BhYb/gISF/4CDhf9/g4T/f4KE/36ChP9+gYP/fYGC/32Bgv98gIH/fICB/3t/gP97f4D/en5//3l+f/95fX7/eX19/3h8ff94e3z/d3t7/3d6e/92eXn/dnh5/3V4eP+HiYr/h4qK/4iKi/+Iiov/iIqL/4iLi/+Ii4v/iIuM/4mLjP+JjIz/iYyN/4mMjf+KjI3/io2N/4qNjv+KjY7/i46P/4uOj/+LjpD/i46Q/4yPkP+Mj5D/jI+R/4yQkf+NkJH/jZCS/42Qkv+NkZH/jpGS/46Rk/+OkZP/jpKT/46Sk/+OkpT/j5KU/4+SlP+Pk5T/j5OU/4+Tlf+Pk5X/j5OV/5CUlf+QlJX/kJSW/5CUlv+QlJb/kJSW/5CVlv+QlZf/kJWX/5GVl/+RlZf/kZWX/5CVl/+QlZf/kJWX/5CVmP+Qlpj/kJWY/5CVmP+QlZj/kJWY/5CVmP+QlZj/kJaY/5GXmv+OlZj/i5KT/5icnf++wMD/6+rq//j29v/z8fH/6+rq/3WUwv9ihLr/bYay/2CEvP9iicL/Y4rD/2eHuv9vi7j/aIi6/2aIv/9hhb//XH+5/1V1rv9ScKf/Smac/0Fajf87UoL/Nkx3/zVKc/80SXL/M0dv/zFFbP8tQWn/Kz9l/yo+Zf8pPmb/K0Bn/yo/Z/8qQGj/K0Fp/ypAav8qQGn/KkBp/ypAaf8rQmv/LEJs/y1DbP8sQmz/K0Fs/ytAav8rQGv/Kj9o/yg7ZP8mOmD/IDVY/x4yVv8hNlz/Izpj/yM7Z/8mP2z/KkJw/y9Hdv8wSnr/NE18/y5Ief9TZYj/0c7N/9bT0v/T0dD/1NHQ/9LPz//Szs7/z8vK/8nFxf/Cvr7/vru6/8vHx//b2Nj/09HQ/6qrq/+HjI3/hImK/4eMjf+Gi4z/hoqL/4aKi/+Giov/hYmL/4WJiv+FiYr/hYiK/4SIif+Eh4n/g4eI/4OHiP+Choj/goaH/4KGh/+BhYb/gYSG/4CEhf+AhIX/gIOE/3+DhP9+goP/foKD/32Bgv98gYL/fICB/3uAgf97f4D/e39//3p+f/96fn//eX5//3l9fv94fH3/eHx8/3d7e/93e3v/dnp6/3Z4ef91eHj/h4mK/4eKiv+Iiov/h4qL/4iKi/+Ii4v/iIuM/4iLjP+Ji4z/iYyN/4mMjf+JjI3/iYyN/4qNjv+Kjo7/io6P/4uOj/+Ljo//i46Q/4uPkP+Mj5D/jI+R/4yPkf+MkJH/jZCS/42Qkv+NkZL/jZGS/46Skv+OkZP/jpKT/46Sk/+PkpP/jpKU/4+SlP+PkpT/j5OU/4+TlP+PlJX/j5SV/5CUlf+QlJX/kJSV/5CUlv+QlJb/kJSW/5CUlv+QlZb/kJWX/5CVl/+QlZf/kJWX/5GVmP+Qlpf/kJaX/5CWmP+Qlpj/kJaY/5CWmP+QlZj/kJWY/5CVmP+QlZj/kJWY/5CWmP+Qlpn/kZeZ/5GYmv+Qlpj/i5KT/5+jpP/T09L/8O/v//bz8f+ptcj/Wnqr/2uIt/9hhr7/YYjB/2CHv/9oiLn/bIq5/2iLwP9kiML/XIC5/1Z2rv9Oa6L/Smaa/0Rekv89VYb/Nk14/zFHcP8uQ2v/LUFo/ys/Zv8rP2X/Kz5j/yo9Yf8nOV//JDdd/yQ4Xv8jN13/JDhf/yQ4YP8jOWD/JTtj/yU7Yv8mPGP/Jz1k/yg+Zv8qQGj/K0Bq/ypAav8qP2j/Kj9p/yg+Z/8nO2P/JThd/yAzVv8cL1L/HTNY/yA2Xv8gN2D/IThj/yU9af8pQW7/K0Jv/ytDb/8vSHT/JD9v/258lP/Y1NH/zMrK/8vJyf/LyMf/ysfH/8nHxf/FwcD/ure2/8O+vv/Y1dX/ycfH/5+hof+Fiov/h4yN/4iNjv+Hi4z/houM/4aLjP+Gi4v/hoqL/4aJi/+FiYr/hYmK/4WIiv+EiIn/hIiJ/4OHif+Dh4j/g4eI/4KGiP+Bh4f/gYWG/4GFhv+BhYb/gISF/4CDhf9/g4T/foKD/36Cg/99gYL/fYGC/3yBgf98gID/e4CA/3t/gP96f3//en5//3p+f/95fX7/eHx9/3h8fP93e3z/d3t7/3Z5ev92eHn/dXh4/4eJiv+Hior/h4qL/4iKi/+Iiov/iIuL/4iLjP+Ji4z/iYuM/4mMjf+JjI3/iYyN/4qNjv+KjY7/io2O/4qOj/+Ljo//i46P/4uPkP+Mj5D/jI+Q/4yPkf+MkJH/jZCR/42Qkv+NkZL/jZGS/42Rkv+OkpP/jpGT/46Sk/+OkpP/jpKT/46SlP+PkpT/j5OU/4+TlP+Pk5X/j5OV/4+Ulf+QlJX/kJSV/5CUlv+QlJb/kJSW/5CUlv+QlZb/kJWX/5CVl/+QlZf/kJWX/5CVl/+QlZj/kJaY/5CWmP+Qlpj/kJaY/5CWmP+Qlpj/kJWY/5CVmf+QlZj/j5WY/4+VmP+Plpj/kJaZ/5CWmf+Qlpn/kJeZ/5KYm/+PlZf/jpSV/7W3t//i4eH/7+zr/4yduP9ggrb/Y4jA/2OJxP9ih8D/Z4a2/2iIu/9hhL3/XH+4/1V2r/9RbqT/RmCT/z9YiP86UoP/MUZz/yo+aP8oO2L/KDti/yk7Yf8nOl7/Jjhb/yY4Wv8lNln/JDZZ/yE0WP8eMVX/HjFV/x4xV/8fMlj/HzNZ/x8zWv8gNVv/Ijdd/yQ5X/8lOmL/Jzxk/yk9Zv8pPmj/KD1n/yk9Z/8nPGX/Jjph/yQ2XP8gMlT/Gy1P/xswVP8cMlj/GzJZ/xwzXP8fN2H/Iztl/yQ7Zf8lPGb/Jj1p/yhBbP8iO2f/gYma/9DMyv/Bv7//w8C//8LAvv/Avrz/v7y7/7aysv/JxcX/uLe3/5qcnf+IjI7/iY2P/4iNjv+Hi43/h4uM/4aLjP+Gi4z/hoqL/4aKi/+FiYv/hYmL/4WJiv+FiIr/hIiK/4SIif+Dh4n/g4eI/4OHiP+Choj/goaH/4GGh/+ChYb/gYWG/4CEhf+AhIX/f4OE/3+ChP9+goP/fYGC/32Bgv98gIH/fICB/3uAgP97f4D/en9//3p+f/95fn//eX1+/3l8ff94fH3/d3t8/3d7e/92enr/dnl5/3V4eP+Hior/h4qK/4iKi/+Iiov/iIqL/4iLjP+Ii4z/iYuM/4mLjP+JjI3/iYyN/4mMjf+KjY7/io2O/4qNjv+Kjo7/i46P/4uPj/+Lj5D/jI+Q/4yPkf+Mj5H/jI+R/42Qkf+NkJL/jZGS/42Rkv+NkpL/jpKS/46Sk/+OkpP/jpKT/4+SlP+PkpT/j5KU/4+TlP+Pk5X/j5OV/4+T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i/+Ii4z/iIuM/4mLjP+JjI3/iYyN/4mMjf+KjI7/io2O/4qNjv+KjY//i42P/4uOj/+LjpD/i4+Q/4yPkP+Mj5D/jI+R/4yQkf+NkJH/jZCS/42Qkv+NkZL/jpGT/46Rk/+OkZP/jpKT/46SlP+PkpT/j5KU/4+TlP+Pk5T/j5OV/4+Tlf+Pk5X/j5OV/5CUlv+QlJb/kJSW/5CUlv+QlJb/kJWX/5CVl/+QlZf/kJWX/5CVl/+QlZf/kJWY/5CVmP+QlZj/kJWZ/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaZ/5GWmf+Qlpr/kZea/5CWmv+Qlpr/kZaa/5CWmv+TmJj/dYil/1mBv/9jf6z/XXGW/1hvmf9adaP/YXyu/1pyof9PZpL/SmCK/0FVff89T3T/Okts/zlLb/8+Unr/Oktv/zJAYP8uO1j/LThS/y86U/8sNUv/MjpO/zQ7S/87RFn/Mj1a/yIvTf8hLUr/GydD/xYhO/8VITr/FB84/w8aMv8OGjP/EB46/xIhPv8VJEP/FyhI/xorTf8bLlH/HzFV/yAzWP8fMlf/ITRY/yEyVP8fL07/GCZB/xUjP/8SID3/Dx05/w8dN/8RHjj/DBkw/xomPP9RWmf/g4mN/5CVl/+KkJP/iY6R/4uPkv+Lj5P/ipCS/4uPkv+KjpH/iY6Q/4mNkP+JjpD/iI2P/4mNj/+JjY//iI2P/4iMjv+IjI7/iIyO/4iLjf+Hi43/h4uN/4eLjP+Gioz/hoqM/4aKi/+FiYv/hYmK/4WIiv+EiIr/hIeJ/4OHif+Dhoj/goWI/4KFiP+BhYf/gYWH/4CFhv+AhIX/gISF/3+DhP9/g4T/foKD/32Bg/99gYL/fICC/3yAgf98f4H/e3+A/3t/gP96f3//en5//3l+fv95fX3/eHx9/3d7fP93env/dnp6/3Z5ef+Iiov/iIqL/4iLi/+Ii4v/iIuM/4iLjP+Ji4z/iYyN/4mMjf+JjI3/ioyN/4qNjv+KjY7/io2O/4uNj/+Ljo//i46Q/4uPkP+Mj5D/jI+R/4yPkf+MkJH/jZCR/42Qkv+NkJL/jZGS/46Rk/+OkZP/jpGT/46Sk/+OkpT/j5KU/4+SlP+Pk5T/j5OU/4+Tlf+Pk5X/j5OV/5CTlf+QlJb/kJSW/5CUlv+QlJb/kJSX/5CUl/+QlZf/kJWX/5CVmP+QlZj/kJWY/5CVmP+QlZj/kJWY/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaa/5CWmv+Qlpr/kJaa/5CWmv+Qlpr/kJaa/5CWmv+Qlpr/kZaY/2eCrP9de6z/ZXyl/2eGuv9si8D/a4m//26Kwv9vib7/Y3qs/193qf9NYpD/TWKP/01jkP9LYIz/SF2K/0FUfv88Tnb/OEhu/zdHav8yP1//LztW/zA7Vf8yPFT/OUNZ/0VPaP84RGH/JzNR/yIuS/8dKkb/FiI7/xMfN/8VIDn/Eh42/w4bNf8RHzv/FCNC/xYmRv8YKUr/GyxP/xwuUv8eMFb/IDJX/x8xVv8hMVT/Hy5M/xglP/8TITz/ER85/xAeNv8PGzP/Cxgu/zZAT/92fYP/kJaY/4uRk/+IjpH/io+S/4uQkv+LkJL/i4+T/4qPkv+Kj5H/io6R/4mOkP+KjpD/iY6Q/4iOj/+JjY//io2Q/4mNj/+JjY//iIyO/4iMjv+Ii47/h4uN/4eLjf+Hi43/hoqM/4aKjP+Giov/hYmL/4WJi/+FiYr/hIiK/4SHif+Dh4n/g4aJ/4KGif+Choj/goWH/4GFh/+BhYb/gISG/3+Ehf9/g4T/f4OE/36Cg/99gYP/fYGC/32Bgv98gIH/fICB/3t/gP97f4D/en5//3p+f/95fn7/eX1+/3h8ff94e3z/d3t7/3d6e/92eXr/iIqL/4iKi/+Ii4v/iIuM/4iLjP+Ii4z/iYuM/4mMjf+JjI3/iYyN/4qNjf+KjY7/io2O/4qNj/+LjY//i46P/4uOkP+Lj5D/jI+Q/4yPkf+Mj5H/jJCR/42Qkf+NkJL/jZGS/46Rkv+OkZP/jpGT/46Rk/+OkZP/j5KU/4+SlP+PkpT/j5OU/4+Tlf+Pk5X/j5OV/4+Tlf+Pk5X/kJSW/5CUlv+QlJb/kJSW/5CUl/+QlJf/kJWX/5CVl/+QlZj/kJWY/5CVmP+Qlpj/kJWY/5CWmf+QlZn/kJWZ/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaZ/5CWmf+Qlpr/kJaa/5CWmv+Qlpr/kJaa/5CWmv+Ql5r/kZea/4uTm/9je6T/ZX6p/2mIvv9xk8r/eZrS/3SUzv92lM7/epXM/3iRxP9uhrr/YHis/2B4rf9hea3/WnGk/09llf9JXo3/RlqK/0JWhP8+UXz/OUpy/zVDZf8vPFv/MT5b/zE8WP86RWD/RE5p/z1IZf8rN1X/Iy9O/yAsSf8XIz3/Eh03/xQfOf8VIDz/ER44/xEgPf8WJUP/GChI/xosTv8bLVD/HS9U/x8xVv8fMVX/HzBS/x8uS/8ZJT7/EyA4/xEeN/8OGzX/Eh40/1dfaf+OlJf/jJOV/4eOkf+Kj5L/ipCT/4uQk/+LkJL/i5CS/4yPk/+Lj5L/io+R/4qOkf+JjpH/io6R/4qOkP+JjpD/io6Q/4qNj/+JjY//iY2P/4iMjv+IjI7/iIuO/4iLjv+Hi43/h4uN/4eKjP+Gioz/hoqM/4aKi/+FiYv/hYmK/4SIiv+Eh4n/g4eJ/4OGif+Dhoj/goaI/4KFh/+BhYf/gYSG/4CEhv+AhIX/f4OE/3+DhP9+goP/foGD/32Bgv99gYL/fICC/3yAgf97f4D/e3+A/3p/f/96fn//en5+/3l9fv95fH3/eHx8/3d7fP93enr/dnl6/4iKi/+Iiov/iIqM/4iLjP+Ii4z/iYuM/4mLjP+JjI3/iYyN/4mMjf+KjI7/io2O/4qNjv+KjY//i42P/4uOj/+LjpD/i46Q/4yPkP+Mj5H/jI+R/4yQkf+NkJL/jZCS/42Rkv+OkZL/jpGT/46Rk/+OkZP/jpGT/4+SlP+PkpT/j5KU/4+TlP+Pk5T/j5OV/4+Tlf+Pk5X/kJOV/5CUlv+Qk5b/kJSW/5CUl/+QlJf/kJSX/5CVl/+QlZf/kJWX/5CVmP+QlZj/kJaY/5CVmP+QlZn/kJWZ/5CVmf+Qlpn/kJaZ/5CWmv+Qlpn/kJaZ/5CWmf+Qlpn/kJaa/5CWmf+Qlpn/kJaa/5CWmv+Rlpr/kJaa/5CWmv+Qlpr/kJaa/5KYmv+Fjpn/ZHyk/2mJv/9wksv/epvU/3qb1f96mdX/fZvY/32Z0/9/mdD/fJXM/2+Hvv9of7f/aYK6/2B4sP9WbqX/TmSa/0hek/9KYZX/R12Q/0JWhf85SXL/MkJm/zFAYf8xP17/NUJf/zlFYP8/Smb/P0po/y87Wf8kME//ICxJ/xolQP8THzj/Eh87/xcjP/8UID3/FCI//xgnRv8ZKkz/GyxO/xwuUv8dMFT/HzFU/x8vUP8gLkr/GSU8/xMeNv8NGjP/Gyc+/251fP+SmJr/ipCT/4qPk/+KkZP/ipCS/4qQk/+LkJP/i5CT/4uQkv+Lj5L/i4+S/4qPkv+Kj5H/io+R/4qOkf+KjpD/io6Q/4mOkP+JjpD/iY2P/4mNj/+JjY//iIyO/4iMjv+Ii47/h4uN/4eLjf+Gioz/hoqM/4aKjP+GiYv/hYmL/4WJiv+EiIr/hIeJ/4OHif+Dhon/g4aI/4KGiP+ChYf/gYWH/4GFhv+AhIb/gISF/3+Dhf9/g4T/foKE/36Cg/99gYL/fYGC/3yAgf98gIH/e3+B/3t/gP97f3//en5//3p+fv95fX3/eX19/3h8fP93e3z/d3p7/3Z5ev+Iiov/iIqL/4iLjP+Ii4z/iIuM/4mLjP+Ji4z/iYyN/4mMjf+JjI3/io2O/4qNjv+KjY7/io2P/4uOj/+Ljo//i46Q/4uOkP+Mj5D/jI+R/4yQkf+MkJH/jZCS/42Qkv+NkZL/jpGS/46Rk/+OkZP/jpGT/46RlP+PkpT/j5KU/4+SlP+Pk5T/j5OU/4+Tlf+Pk5X/j5OV/5CUlf+QlJb/kJSW/5CUl/+QlJf/kJSX/5CVl/+QlZf/kJWX/5CVmP+QlZj/kJaY/5CWmP+Qlpn/kJaZ/5CWmf+Qlpn/kJaa/5CWmv+Qlpr/kJaa/5CWmv+Ql5n/kJaZ/5CWmv+Qlpr/kJaa/5CWmv+Qlpr/kJaa/5CWmv+Qlpr/kJaa/4+Vmv+SmJn/coGa/2eEt/9vkMr/dpfS/3mc1/96m9b/fp3a/3uZ2P9+m9j/fZnV/3qUzv90jcX/b4jB/2uFwf9ed7X/WXKu/1Jrpv9JYJr/RVyU/0hglv9IX5L/Q1mJ/zdKdf8xQGX/MUBi/zJBYP8zQF3/OERg/z5IZf8/S2n/MT5c/yUxUP8hLEn/GiZC/xQgO/8THzv/GCRA/xYjQP8WJUP/GSlK/xorTP8bLVD/HS5S/x0vU/8fMFH/Ii9K/xklO/8OGjH/Gyc9/3h+hP+UmZv/iI+T/4qRlP+LkJT/ipGU/4qRk/+KkJP/i5CT/4uQk/+LkJL/i4+S/4uOkv+Lj5L/io+S/4qOkf+KjpH/io6Q/4qOkP+KjpD/iY6P/4mOj/+JjY//iI2P/4iMjv+IjI7/iIuO/4eLjf+Hi43/hoqN/4aKjP+Gioz/hYmL/4WJi/+FiYr/hIiK/4SIif+Dh4n/g4eJ/4OGiP+ChYj/goWI/4GFh/+BhYb/gYSG/4CEhf9/g4T/f4OE/36ChP9+goP/fYGC/32Bgv98gIL/fICB/3x/gf97f4D/e3+A/3p+f/96fn//eX1+/3l9ff94fH3/d3t8/3d6e/92enr/iIqL/4iKi/+Ii4v/iIuM/4iLjP+Ii4z/iYuM/4mMjf+JjI3/iYyN/4qNjv+KjY7/io2O/4qNj/+Ljo//i46P/4uOkP+LjpD/jI6Q/4yPkf+MkJH/jJCR/42Qkv+NkZL/jZGS/46Rk/+OkZP/jpGT/46Rk/+OkpT/j5KU/4+SlP+PkpT/j5OU/4+Tlf+Pk5X/j5OV/5CTlf+QlJX/kJSW/5CUlv+Qk5b/kJSX/5CUl/+QlJf/kJSX/5CVmP+QlZj/kJWY/5CWmP+Qlpn/kJaZ/5CWmf+Qlpn/kJWZ/5CWmv+Qlpr/kJaa/5CWmv+Qlpr/kJea/5CWmv+Ql5r/kJaa/5CWmv+Qlpr/kJaa/5CWmv+Qlpr/kZaa/4+Vmv+UmJr/fIeZ/2B7q/9vkMj/dJbQ/3ea1f93mtX/eZrV/3yc2P97mdf/eZfX/3qX1f96lM//covE/22Fv/9ogsD/XHa3/1dwrv9SbKn/T2ik/0Zdlf9DWY//SWGX/0hglf88UX//M0Rs/zBAY/8vPl//MD9e/zNBXv81Ql7/OUVj/z5JaP81QmD/JzRS/yEtS/8bJkL/FSE8/xQhPf8YJUP/GSZF/xgmRv8aKkr/GixO/xwtUP8dL1L/HzBR/yMvSf8WIjf/Ex40/291fP+UmJv/iY6T/4qRlf+LkZT/i5GU/4qRlP+LkZP/ipCT/4qRk/+KkJP/i5CT/4uQk/+Kj5H/i4+R/4qPkv+LjpH/i46R/4qPkf+KjpD/io6Q/4mOj/+JjY//iY2P/4mNj/+IjI7/iIyO/4iLjv+Hi43/h4uN/4aKjf+Gioz/hoqM/4WJi/+FiYv/hYmK/4SIiv+EiIn/g4eJ/4OHif+Dhoj/goWI/4KFh/+BhYf/gYSH/4CEhv+AhIX/f4OF/3+DhP9+goT/foKD/32Bg/99gYL/fICB/3yAgf98f4H/e3+A/3t/gP96fn//en5+/3l9fv95fX3/eHx9/3h7fP93env/dnp6/4iKi/+Ii4v/iIuL/4iLjP+Ii4z/iIuM/4mLjP+JjI3/iYyN/4mMjf+KjY7/io2O/4qNjv+KjY//i46P/4uOj/+LjpD/jI+Q/4yPkP+Mj5H/jJCR/4yQkf+NkJL/jZCS/42Rkv+OkZL/jpGT/46Sk/+OkpP/j5KU/4+SlP+PkpT/j5OU/4+TlP+Pk5X/j5OV/4+Tlf+PlJX/kJSV/5CUlv+QlJb/kJSW/5CUl/+QlJf/kJWX/5CVl/+QlZj/kJWY/5CVmP+Qlpj/kJaY/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaZ/5CWmv+Qlpr/kJaa/5CWmv+Qlpr/kJea/5CXmv+Ql5r/kJaa/5CWmv+Qlpr/kZaa/5CWmv+SmJv/h4+a/192of9oiL3/cpTN/3SWz/93mtX/cpTO/3OUzv92l9H/eJfT/3SR0P9vi8n/dI3I/3OKwP9nfbX/X3aw/1lvqv9Va6T/TmSe/0lgmP9GW5H/QFaI/0BWiv9IX5T/QliI/zVIcf8xQmb/Lz9h/zA/X/8wPl3/MD5b/zI+XP82QmH/O0hn/zZDYv8pNVX/Ii5M/xonRP8XIz//FSI//xkmRf8aKEf/GChH/xorTP8bLU//HS5R/x8wUf8jMEn/EBwx/1lha/+Rl5n/iY+S/4uRlf+LkZX/i5GU/4uRk/+KkZP/i5GT/4uQk/+KkZP/ipGT/4uQk/+LkJP/ipCS/4qQkv+Lj5L/i4+S/4qOkf+KjpH/io6Q/4mOkP+JjpD/iY6P/4iNj/+IjY//iIyO/4iMjv+IjI7/h4uO/4eLjf+Hio3/hoqM/4aKjP+Fiov/hYmL/4WJiv+EiYr/hIiJ/4OHif+Dh4n/g4eI/4KGiP+Chof/goWH/4GFh/+BhIb/gISF/3+Dhf9/g4T/foOE/36Cg/99gYL/fYGC/32Agf98gIH/fICB/3t/gP97f4D/en9//3p+f/95fX7/eX19/3h8fP94fHz/d3t7/3d6ev+Hiov/iIqL/4iLi/+Ii4z/iIuM/4iLjP+Ji4z/iYyN/4mMjf+JjI3/io2O/4qNjv+KjY7/io2P/4uOj/+Ljo//i46Q/4yPkP+Mj5H/jI+R/4yPkf+MkJH/jZCS/42Rkv+NkZL/jpGS/46Rk/+OkZP/jpKT/4+SlP+PkpT/j5KU/4+SlP+Pk5X/j5OV/4+Tlf+Pk5X/j5SV/4+Ulv+QlJb/kJSW/5CUlv+QlJb/kJSX/5CVl/+QlZf/kJWY/5CVmP+Qlpj/kJaY/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaa/5CVmf+Qlpr/kJaa/5CWmv+Ql5r/kJea/5CXmv+Ql5r/kJea/5GWmv+Rl5r/jpSZ/2N4nf9ffLD/bo/G/3KTy/93mdH/cZPN/26Pyv9wks7/bY3K/2yKxv9mgbr/WnGo/1Nnmv9PYpL/RleH/0VXiP9DVYb/Q1aH/0RXiP9AU4T/PVGB/zxQfv83Snf/PlKB/0JXhf86TXj/MUJn/y8/Y/8uPV//LT1d/y88W/8vPFn/Mj5d/zVBYf85Rmb/NUNi/yk2Vf8hLUz/GyhF/xglQf8WJEL/GihH/xkoSP8ZKUr/HC1P/x4uUv8hMlL/GylD/z1HVP+NlJb/iI+T/4uRlP+MkZX/i5GV/4uRlP+LkZT/i5GU/4uRk/+LkZP/i5GT/4qRkv+LkJL/i5CS/4qQkv+KkJL/i4+R/4qPkf+Kj5H/io6R/4qOkP+JjpD/iY6Q/4mOj/+IjY//iI2P/4iNjv+IjI7/iIyO/4eLjv+Hi43/hoqM/4aKjP+Gioz/hYqL/4WJi/+FiYv/hImK/4SIiv+EiIn/g4eJ/4OHiP+Dhoj/goaI/4KFh/+BhYf/gYSG/4CEhf9/hIX/f4OE/36DhP9+goP/foKD/32Bgv99gIL/fICB/3yAgf98f4D/e3+A/3t+f/96fn7/en1+/3l9ff94fHz/eHx8/3d7e/93enr/h4qL/4iKi/+Ii4v/iIuM/4iLjP+Ii4z/iYuM/4mMjf+JjI3/iYyN/4qNjv+KjY7/io2O/4qNj/+Ljo//i46P/4uOkP+Mj5D/jI+Q/4yPkf+Mj5H/jJCR/42Qkv+NkZL/jZGS/46Rkv+OkZP/jpGT/46Sk/+PkpT/j5KU/4+SlP+Pk5T/j5OU/4+Tlf+Pk5X/j5OV/4+Ulf+PlJb/j5SW/5CUlv+QlJb/kJSW/5CVl/+QlZf/kJWX/5CVmP+QlZj/kJWY/5CWmP+Qlpn/kJaZ/5CWmf+Qlpn/kJaa/5CWmf+Qlpn/kJaa/5CWmv+Qlpn/kJaa/5CWmf+Qlpr/kJaa/5CXmv+Ql5r/kJea/5CXmv+Qlpr/k5iZ/2p9m/9YdKj/Zoa7/2uNxP9wkcj/cpTN/3GRyv9wkMr/a4vI/2OAvf9ddq3/VWuc/0pdif87S3L/NERp/zA+YP8uPGH/MD9n/zdGcf83R3P/OUp3/zlKdv83SXT/N0l0/zRFbv84SnP/O012/zBCaP8vQGP/LT1f/y4+Xv8sO1r/Ljta/y48Wv8wPVz/Mj9f/zZDYv80QWH/KTZV/yAtTP8aKET/GCVC/xcmRP8aKUj/GSlK/xorTf8eL1D/IC9Q/yg0S/99hIf/jJOV/4mQk/+KkpT/jJKU/4yRlf+LkZT/i5GU/4uRlP+LkZP/i5GT/4uRkv+LkZP/ipGS/4uRkv+KkJL/ipCS/4uPkv+Kj5H/io+R/4qPkf+KjpD/iY6Q/4mOkP+Jjo//iI2P/4iNj/+IjY7/iIyO/4eMjv+Hi47/h4uN/4aLjf+Gioz/hoqM/4WKi/+FiYv/hYmK/4SJiv+EiIr/hIiJ/4OHif+Dhoj/g4aI/4KGiP+Chof/gYWH/4GFhv+AhIb/gISF/3+DhP9/g4T/foKD/32Cg/99gYL/fYGC/3yAgf98gIH/e3+A/3t/gP96f3//en5//3p9fv95fX3/eH19/3h8fP93e3v/d3p6/4eKi/+Iiov/iIuL/4iLjP+Ii4z/iIuM/4mLjP+JjI3/iYyN/4mMjv+KjY7/io2O/4qNjv+Kjo//i46P/4uOj/+Lj5D/jI+Q/4yPkf+Mj5H/jI+R/4yQkf+NkJL/jZGS/42Rkv+OkZL/jpKT/46Sk/+OkpP/jpKT/4+SlP+PkpT/j5KU/4+TlP+Pk5X/j5OV/4+Tlf+PlJX/j5SW/5CUlv+QlJb/kJSW/5CVl/+QlZf/kJWX/5CVl/+QlZj/kJWY/5CVmP+Qlpj/kJaZ/5CWmf+Qlpn/kJeZ/5CXmv+Qlpn/j5aa/5CWmv+Qlpr/kJaa/5CWmf+Qlpn/kJaa/5CXmv+Ql5r/kJea/5CXmv+Plpr/lJqa/3aEmf9Tb6H/XXuw/2eIvv9qi8P/b5HK/2+Ryv9zk8z/bo7J/2F9tf9VbJ7/S2GM/0RWff9EVnz/P05x/zdGZP8uOlj/MD1d/zA+Yf8uPWH/Lj1h/zFBZ/8zQ2v/NEZu/zVGbv80RGr/MEFl/zVHbf8zRWv/Lz9i/y09YP8uPV7/LDtb/yw7Wv8sOlj/LDta/y89XP8wPV3/M0Bf/zNAYP8pNlb/IC1L/xooRf8YJkT/GCdG/xoqSv8bK0z/Hi5Q/xoqSv9VX23/lJmY/4mQkv+KkpT/i5KU/4uSlP+MkZX/jJGU/4yRlP+MkZP/jJGU/4uRk/+LkZP/i5GT/4qRkv+KkZL/i5CS/4uQkv+LkJL/io+R/4mPkf+JjpH/iY6Q/4qOkP+JjpD/iY6P/4iOj/+IjY//iI2P/4iNjv+HjI7/h4yO/4eLjf+Gi43/hoqM/4aKjP+Giov/hYmL/4WJi/+EiYr/hImK/4SIif+DiIn/g4eI/4OHiP+Choj/goaH/4GFh/+BhYb/gISG/4CEhf9/g4X/f4OE/36Cg/9+goP/fYKC/32Bgv98gYH/fICB/3t/gP97f4D/e39//3p+fv96fn7/eX1+/3l9ff94fHz/d3t7/3Z6ev+Hiov/iIqL/4iLi/+Ii4z/iIuM/4iLjP+Ji4z/iYyN/4mMjf+JjI3/io2O/4qNjv+KjY7/io6O/4uOj/+Ljo//i4+Q/4yPkP+Mj5D/jI+R/4yQkf+NkJH/jZCS/42Qkv+NkZL/jZGS/46Rk/+OkZP/jpKT/46Sk/+PkpT/j5KU/4+TlP+Pk5T/j5OV/4+Tlf+Pk5X/j5SV/4+Ulv+QlJb/kJSW/5CUlv+QlZb/kJWX/5CVl/+QlZf/kJWY/5CVmP+Qlpj/kJaY/5CWmf+Plpn/j5aZ/5CWmf+Qlpr/kJaa/5CWmf+Qlpn/j5aZ/5CWmv+Qlpr/kJaa/5CWmv+Qlpr/kJea/5CXmv+Plpr/k5ma/4KNmP9VcJ//V3Om/159sv9nh77/bI3E/2qMxv9vkcv/cZDL/2eDt/9edqT/U2iU/05ii/9LXoj/SVyG/0RWf/89THL/Okht/zlJbf81RGb/MUBh/zE+Xv8yQGP/MUFl/zFCZv8zQmf/M0Jm/zBAZP8xQmX/NEVq/y4/Y/8uPl//LDxd/y08XP8tO1r/LDlY/ys6Wf8sOlr/LTtb/y88XP8xP17/MT5e/yk1Vf8fLUv/GihH/xgoRf8aKUn/HCtM/x4uTv8aKkn/Z294/5SYmf+KkZP/i5KV/4uSlf+MkpX/i5KV/4ySlP+MkZT/jJGU/4uRlP+LkZP/i5GT/4uRk/+KkZP/ipGT/4qQkv+KkJL/ipCS/4qQkf+Jj5H/iY+R/4mOkP+JjpD/iY6Q/4mOkP+JjY//iI2P/4iNj/+IjY7/h4yO/4eMjf+Hi43/houN/4aKjP+Gioz/hoqM/4WJi/+FiYv/hImK/4SJiv+EiIn/g4iJ/4OHif+Dh4j/goaI/4KGh/+ChYf/gYWG/4GFhv+AhIX/f4OE/3+DhP9+goP/fYKC/32Bgv99gYL/fICB/3yAgf98gID/e3+A/3t/f/96fn//en5+/3l9fv95fX3/eHx8/3d7e/92env/h4qL/4iKi/+Iiov/iIuM/4iLjP+Ii4z/iYuM/4mMjf+JjI3/iYyN/4qNjv+KjY7/io2O/4qOj/+Ljo//i46P/4uOkP+Mj5D/jI+Q/4yPkf+Mj5H/jZCR/42Qkv+NkJL/jZGS/42Rkv+OkZL/jpKT/46Sk/+OkpP/j5KU/4+SlP+Pk5T/j5OU/4+Tlf+Pk5X/j5OV/4+Ulf+QlJb/kJSW/5CUlv+QlZb/kJWW/5CVl/+QlZf/kJWX/5CVmP+QlZj/kJaY/5CWmf+Qlpn/kJaZ/4+Wmf+Qlpn/kJaZ/5CWmf+Ql5r/kJaa/5CWmv+Qlpr/kJaa/5CWmv+Qlpr/kJaa/5CXmv+Ql5n/kZia/4uTmP9dc53/VHGk/1t4qP9igLT/ZYa9/2uNxf9vkMn/cpPM/2mFu/9og7X/aoS5/2d/vP9hdrv/YnS4/19wsv9YZ6n/U2Ck/0xanP9GU5D/QEyB/z1LeP86SHD/OEdq/zVEZf81Q2X/NEJl/zJBZf8zQmX/MkJk/zJDZv8xQmb/LT1g/yw8Xv8tPFz/LjtZ/ys4V/8pOFf/KjlZ/yw6Wv8uOln/Ljxa/zE+XP8wPVz/JzVT/x8sS/8bKkj/GShH/xsrS/8eLUz/GypJ/2tyfP+Sl5j/ipGU/4uSlf+LkpX/jJKU/4ySlf+MkpX/jJGU/4uRlP+LkpT/i5GU/4uRk/+LkZP/ipGT/4uRk/+KkZL/ipCS/4qQkv+Kj5H/iY+R/4mPkf+JjpH/iI6Q/4mOkP+JjpD/iY6P/4iNj/+IjY//h42O/4eMjv+HjI7/h4uN/4aLjf+Gi4z/hoqM/4aKjP+Fiov/hYmL/4SJiv+EiIr/hIiK/4OIif+Dh4j/goeI/4KGiP+Chof/gYaH/4GFhv+AhIb/gISF/4CDhf9/g4T/foKD/36Cg/99gYL/fYGC/3yBgf98gIH/fICA/3t/gP97f3//en5//3p+fv95fX7/eX19/3h8fP94e3z/d3t7/4eKi/+Iiov/iIuL/4iLjP+Ii4z/iIuM/4mLjP+JjI3/iYyN/4mMjf+KjY7/io2O/4qNjv+Kjo//i46P/4uOj/+Lj5D/i4+Q/4yPkP+Mj5H/jI+R/4yQkf+NkJL/jZCS/42Rkv+NkZL/jpGS/46Sk/+OkpP/jpOT/4+SlP+Pk5T/j5OU/4+TlP+Pk5X/j5OV/4+Tlf+PlJX/kJSW/4+Ulv+PlZb/kJWW/5CVlv+PlZf/kJWX/5CVl/+QlZj/kJWY/5CVmf+Qlpj/kJaZ/5CWmf+Plpn/kJaZ/5CXmf+Ql5r/kJea/5CWmf+Qlpr/kJaa/5CWmf+Qlpn/kJaa/5CXmv+Ql5r/kJeZ/5KYmf9mepj/U2+j/1l1pf9eear/ZIS6/2aIwf9sjsj/dpfP/3COw/9vi8H/bofL/26Azv9tfc3/bXrN/2hyyf9gasD/W2S4/2Frvv9cZ7n/UFut/0RMl/87RIX/OkZ//zxKef87SXD/Okhp/zZEZP8xP2H/MUFj/zJCZv8xQWT/MkNm/y9AY/8uPmH/LDtc/y05WP8rOFb/KjhX/yk4WP8rOlr/LDlZ/y06WP8uO1n/MD1b/zA9W/8lMlH/HixK/xspSf8cK0v/Hi1M/xwrSf9vdn7/kZeX/4uSk/+Mk5X/i5KU/4uSlP+MkpX/i5KV/4ySlf+LkpT/i5GU/4uRlP+LkZT/i5GT/4qRk/+KkZP/ipGS/4qQkv+KkJL/iZCR/4mQkf+Jj5H/iY+R/4iOkP+IjpD/iY6Q/4mNj/+IjY//ho6P/4eNj/+HjY7/h42O/4eMjf+Gi43/houN/4aKjP+Gioz/hYmL/4WJi/+EiYr/hIiK/4SIiv+DiIn/g4iJ/4OHiP+Ch4j/goaH/4KGh/+BhYf/gYSG/4CEhv+Ag4X/f4OE/36ChP9+goP/fYKD/32Bgv98gYH/fICB/3yAgP97f4D/e39//3p+f/96fn//eX1+/3l9ff94fHz/d3t8/3d7e/+Hior/iIqL/4iLi/+Ii4z/iIuM/4iLjP+Ji4z/iYyN/4mMjf+JjI3/io2O/4qNjv+KjY7/io6P/4qOj/+Ljo//i4+Q/4uPkP+Mj5D/jI+R/4yQkf+MkJH/jZCS/42Qkv+NkZL/jZGS/46Rkv+OkZL/jpKT/46Sk/+OkpP/j5KU/4+TlP+Pk5T/j5OV/4+Tlf+Pk5X/j5SV/4+Ulf+PlJb/j5SW/5CVlv+PlZb/j5WX/4+Vl/+QlZf/kJWY/4+VmP+Qlpj/j5aY/5CWmf+Qlpn/j5aZ/4+Wmf+Plpn/kJaZ/4+Xmf+Qlpr/kJaa/5CWmv+Qlpr/kJaa/5CWm/+Ql5r/j5aa/5Samv92hZj/UW2f/1ZypP9adaT/Yn+x/2WGvv9nicX/c5XQ/3WUy/9yj8X/cYrM/2p50P9uetX/gYvc/5Ca4f+Kk9//e4Ta/3N70v9+htf/c37R/19pxP9NVrH/QUua/zhEiP82QXv/N0Jz/zlHbv84Rmj/NEJi/y8/Yf8zQ2f/M0Nn/zBAZP8xQmb/L0Bk/yw8Xf8tOln/KzdV/ys4V/8qN1f/Kzpa/y07W/8tOln/LTpZ/y06Wf8vPVv/LTlY/yIwTv8dLEr/HCtK/x4uTf8dLEr/cXl//5CXl/+LkZT/jJOV/4uSlP+MkpT/i5KU/4uSlP+LkpX/i5KU/4uSlP+LkZT/i5GU/4uRk/+LkZP/ipGS/4qQkv+KkJL/ipCS/4mQkv+JkJL/iI+R/4mPkf+IjpD/iI6Q/4mOkP+JjpD/iI2P/4iNj/+HjY//h4yO/4eMjv+GjI3/houN/4aLjf+Gi4z/hoqM/4WJi/+FiYv/hImK/4SJiv+EiYr/g4iJ/4OHiP+Dh4j/goeH/4KGh/+BhYf/gYWH/4GFhv+AhIX/gISF/3+DhP9/goT/foKD/32Cg/99gYL/fIGB/3yAgf98gID/e3+A/3t/f/96fn//en5+/3l+fv95fX3/eHx8/3h8e/93e3v/h4qK/4iKi/+Iiov/iIuM/4iLjP+Ii4z/iYyM/4mMjf+JjI3/iYyN/4mNjv+KjY7/io2O/4qOj/+Ljo//i4+P/4uPkP+Lj5D/jI+Q/4yQkf+Mj5H/jJCR/42Qkf+NkJL/jZGS/42Rkv+OkZL/jpKT/46Sk/+OkpP/jpKU/4+TlP+Pk5T/j5OU/4+Tlf+Pk5X/j5OV/4+Ulf+PlJb/j5SW/4+Vlv+PlZb/j5WX/4+Vl/+PlZf/kJaX/5CVmP+QlZj/j5aY/5CWmf+Qlpn/kJaZ/4+Wmf+Ql5n/kJeZ/5CXmv+Ql5n/kJea/5CXmv+Qlpr/kJaa/5CXmv+Ql5v/kJaa/5KYmv+JkZj/WXKc/1Rwo/9UcKD/Xnuq/2WFuv9pjMX/cZPP/3ia1P90kcj/b4jJ/2t9zf91gdf/lJzk/7K47f+6wOz/sbfq/6Kn6f+boej/pars/46U4/9ze9r/Y2vM/1Nctv9FT6D/PEWH/zU+dv8zPW3/N0Ru/zZFZ/8wP2H/MkFk/zZHbP8xQ2n/MUJo/zBBZv8sPF7/LDpZ/yw5Vv8rOFj/KjhX/yo6Wv8tPFz/Lz5d/y07Wv8sOVn/LTpY/y87Wf8pNlT/Hy1L/x0sS/8eLUz/Hi1K/3N6gP+Plpf/i5KU/4yTlf+Mk5b/jJOV/4uTlf+Lk5T/jJKU/4uSlP+LkpT/i5GU/4uRk/+LkZP/ipGT/4qRk/+JkZL/iZCS/4qQkv+KkJL/iZGR/4mPkf+Jj5H/iI6Q/4iOkP+IjpD/iI6Q/4iNkP+IjY//h42P/4eNjv+HjI7/hoyN/4eLjf+Gi43/hoqN/4aKjP+FiYz/hYmL/4WJi/+EiIr/hIiK/4OIif+DiIj/g4eI/4OHiP+Ch4f/goaH/4GFh/+BhYb/gISG/4CDhf9/g4T/foOE/36Cg/99goP/fYGC/32Bgv98gIH/fICB/3uAgP97f4D/en9//3p+f/95fn7/eX19/3h8ff94fHz/d3t7/4eKi/+Hiov/iIqL/4iLi/+Ii4z/iIuM/4mMjP+JjI3/iYyN/4mMjf+KjY7/io2O/4qNjv+KjY//io6P/4uOj/+LjpD/i4+Q/4yPkP+Mj5H/jJCR/4yQkf+NkJH/jZCS/42Qkv+NkZL/jpGS/46Rk/+OkpP/jpKT/46Sk/+Pk5T/j5OU/4+TlP+Pk5X/j5OV/4+Tlf+PlJX/j5SW/5CUlv+PlJb/j5SW/4+Vlv+PlZf/j5WX/5CVl/+QlZj/j5WY/5CVmP+PlZj/kJWZ/5CWmf+Qlpn/kJaZ/4+Wmf+Qlpr/kJaZ/4+Wmv+Qlpn/kJaZ/5CXmv+Ql5r/kJea/5CWmv+Sl5n/a32Y/1Jvo/9UcKL/VnGi/158sP9lh8D/b5PN/3qe1v96mtH/bojI/2h7yv9tfdH/ipPc/6Gl5P+eoOr/kZTt/4iO6v9+h+H/cn3V/3uE1/99hOP/cnjk/2tx3f9kbM7/VVq4/0pQoP89RIb/Nz92/zM9bf80Qmn/M0Fk/zE/Yf82SG7/OEtz/zFDav8xQmf/LT5h/yw7Wv8qN1X/KzhY/yo4WP8qOVr/LTxc/zA/Xv8wPV7/LTpa/yw4V/8sOVf/LDlY/yUyUP8eLEr/Hy1N/x8uS/91e4L/kJaY/4uSlP+Mk5X/jJOV/4ySlv+LkpX/i5KV/4uSlf+LkpT/jJGU/4uRlP+LkZT/i5GU/4qRk/+KkJP/iZCT/4mQkv+KkJL/ipCS/4mQkf+Jj5H/iY+Q/4iOkP+IjpD/iI6Q/4eOkP+IjZD/iI2P/4eNjv+HjI7/hoyO/4aMjf+Gi43/houM/4aKjP+Gioz/hYqL/4WJi/+FiYv/hIiK/4SIiv+DiIn/g4eJ/4OHiP+Ch4j/goaH/4KGh/+BhYf/gYWG/4GEhv+AhIX/f4OE/3+DhP9+goP/foKD/32Bgv99gYL/fIGB/3yAgf97gID/e39//3p/f/96fn//eX5+/3l9ff94fH3/eHt8/3d7e/+Hior/h4qL/4iKi/+Ii4v/iIuM/4iLjP+Ji4z/iYyN/4mMjf+JjI3/io2O/4qNjv+KjY7/io2P/4uOj/+Ljo//i46Q/4uPkP+Mj5D/jI+Q/4yQkf+NkJH/jJCR/42Qkv+NkJL/jZGS/46Rkv+OkZP/jpGT/46Sk/+OkpT/j5OU/4+TlP+Pk5T/j5OV/4+Tlf+Pk5X/j5OV/4+Ulv+PlJb/j5SW/4+Ulv+PlJf/j5WX/5CVl/+QlZf/kJWY/4+VmP+QlZj/kJWZ/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/j5aa/4+Wmv+Qlpn/kJaZ/5CXmv+Ql5r/kZea/5GWmv+TmJr/hIyX/1h0pf9Wcqb/Um6f/1l2qP9ff7f/aYzJ/3ib1f9/oNX/d5TM/2p/zP9redL/cX7Y/3eA3v9vd97/W17S/0tOvv9DS67/SVSg/15rpf9WY6H/bnmu/19rs/9cZcD/X2bN/1tfy/9UWLj/Sk6f/z9Gif83P3f/Mj1r/zI/Zv8wP2L/M0Nq/zxQe/82SnT/MUNq/y9AZf8rO13/KDVT/yo3Vv8rOVn/Kjla/ys7Xf8vP2D/M0Fi/y8+Xv8rOVj/KTdW/ys5V/8rOFX/IC5M/x8uTP8gLkz/dnyD/5CWmP+LkZX/jJOW/4ySlf+MkpX/i5OV/4uSlf+LkpX/i5KV/4uSlP+LkZT/i5GU/4uRlP+LkZP/ipCT/4mQkv+JkJP/ipCS/4qQkv+JkJL/iY+R/4mPkf+Ij5H/iI6Q/4iOkP+Hjo//h42P/4iNkP+HjY//h4yO/4eMjv+GjI3/houN/4aLjf+Gi4z/hYqM/4WKjP+FiYv/hYmL/4SIiv+EiIr/hIiJ/4OHif+Dh4j/goeI/4KGiP+Chof/gYaH/4GFh/+AhIb/gISF/3+DhP9/g4T/foKD/36Cg/99gYL/fYGC/3yAgf98gIH/e4CA/3t/gP96f3//en5//3l9fv95fX3/eXx9/3h7fP93e3v/h4qL/4iKi/+Iiov/iIuL/4iLjP+Ii4z/iYuM/4mMjf+JjI3/iYyN/4qNjv+KjY7/io2O/4qNj/+Ljo//i46P/4uPkP+Lj5D/jI+Q/4yPkf+MkJH/jZCR/42Qkv+NkJL/jZCS/42Rkv+OkZL/jpGT/46Rk/+OkpP/jpKT/4+SlP+Pk5T/j5OU/4+Tlf+Pk5X/j5OV/4+Tlf+PlJb/j5SW/4+Ulv+PlJf/j5SX/4+Vl/+QlZf/kJWY/5CVmP+QlZj/j5WY/5CWmf+Plpn/kJaZ/5CWmf+Qlpn/kJaZ/5CWmv+Qlpr/kJaZ/4+Wmv+Qlpr/kJaa/5GXm/+Rl5v/lJiY/2yBo/9Wdq3/U26h/1Nwpf9aeKz/ZIbA/26T0f99ntj/fZvR/3aQ0P9xgdf/bHfh/3qJ5f97jNb/e4nM/3SFu/9qeKX/h5nF/36Qv/9hcav/XGun/2+Asf9peaj/Q1CJ/yMtdf8xNob/QEOd/0dLof9FSpn/Q0mO/zpCef8yPmv/MkFq/y4/Zv86TXf/P1R//zZKcv8wQmn/LT9j/yg2VP8nNFH/Kzpa/yo5Wv8pOVz/Lj5h/zBAY/8xQGD/Ljxc/yo4V/8qN1b/LDlW/yYzT/8fLkv/IS9M/3Z8gv+Rlpj/i5GV/4ySlv+Mkpb/jJKV/4ySlf+MkpX/i5KV/4uSlf+LkpT/i5KU/4uRlP+KkZP/i5GU/4uRlP+KkJP/iZCT/4mQkv+JkJL/iZCS/4qPkf+Jj5H/iY6R/4iOkP+IjZD/iI2P/4iNkP+IjZD/h42P/4eMjv+HjI7/houN/4aLjf+Gi43/houM/4aKjP+Fiov/hYmL/4WJi/+EiIr/hIiK/4SIiv+Dh4n/g4eI/4KHiP+Choj/goaH/4KGh/+BhYb/gIWG/4CEhf9/g4T/f4OE/36ChP9+goP/fYGC/32Bgv98gIH/fICB/3uAgP97f4D/e39//3p+fv95fX7/eX19/3l8ff94e3z/d3t7/4eKi/+Iiov/iIqL/4iLi/+Ii4z/iIuM/4iLjP+JjI3/iYyN/4mMjv+KjY7/io2O/4qNjv+KjY//i46P/4uOkP+Lj5D/jI+Q/4yPkP+Mj5H/jJCR/4yQkf+NkJH/jZCS/42Qkv+NkJL/jZGS/46Rk/+OkZP/jpKT/46Sk/+OkpT/j5OU/4+TlP+Pk5X/j5OV/4+Tlf+Pk5X/j5OW/4+Ulv+PlJb/j5SX/4+Ul/+PlZf/kJWX/5CVmP+QlZj/kJWY/5CVmP+Qlpj/kJaY/5CVmf+Qlpn/kJaZ/4+Wmv+Qlpr/j5aa/4+Wmv+Qlpn/kJeZ/5CXmv+Rl5r/lJmZ/4WQnv9efbT/WXWo/1Bwqf9ScKT/XXyx/2WIxP9yltP/d5nS/3qWzv9yhdH/eofk/4qb5f+rxOb/vtvp/9nq8P/T6fH/0Oby/87m8//I4+7/r8vg/8DX6P/A2Ob/xdzk/4+mwP94h6n/fo2m/0VOd/8nLmP/UF+T/y80b/8wNnb/OEJ6/zVCcv8wQGn/MUJq/0BUf/9AVYD/NEdy/y9BaP8rOVj/JTFM/yk3V/8tPF//Kjlc/yw8YP8vP2P/MUFi/zFAYP8tOln/KTZV/yo4Vv8pNlL/IS9L/yAuS/91e4L/kZaY/4qRlf+Lkpb/jJKV/4ySlf+MkpX/jJKV/4uSlf+LkpT/i5KU/4uRlP+LkZT/i5GU/4qQlP+KkJT/iZCT/4qQk/+JkJL/iJCS/4iPkf+Ij5H/iY6R/4iOkP+Ij5H/iY6Q/4iOkP+IjY//h42P/4eMj/+HjI7/h4yO/4aLjf+Gi43/houN/4aLjP+Gioz/hYqL/4WJi/+FiYv/hIiK/4SIiv+EiIr/g4eJ/4OHiP+Dh4j/goaI/4KGh/+Bhof/gYWG/4CEhv+AhIX/f4OE/3+DhP9+goP/foKD/32Bgv99gYL/fICB/3yAgf97gID/e3+A/3t/f/96fn7/en5+/3l9ff94fH3/eHx8/3d7e/+Hiov/h4qL/4iKi/+Ii4z/iIuM/4iLjP+IjIz/iYyN/4mMjf+JjI3/io2O/4qNjv+KjY7/io2P/4uOj/+LjpD/i4+Q/4yPkP+Mj5H/jI+R/4yQkf+MkJH/jZCS/42Qkv+NkJL/jZGS/42Qkv+OkZP/jpGT/46Sk/+OkpT/jpKU/4+SlP+Pk5T/j5OV/4+Tlf+Pk5X/j5OV/4+Ulv+Pk5b/j5SW/5CUlv+QlJf/j5WX/5CVl/+QlZf/kJWY/5CVmP+QlZj/j5WY/5CVmf+Qlpn/kJWZ/5CWmv+Qlpr/kJaa/5CWmf+Qlpr/kJaZ/4+Wmv+Plpr/kJea/5KXmP9thrD/Xn2y/1Vwn/9LYo7/U2+i/2GBuP9oisT/bZHM/3ma0P9whMn/anXT/5Cf4v/D2+n/wd3u/7nX7v/Z6vP/x9zv/9Pi8P/S5fD/uNXo/5m82v+/1uj/vNLi/7bM2f+Vssr/s8XV/6m+zP+Dm7H/bYij/4Cds/8zQFn/Iy1R/zI9fP8uN3T/NUNx/y9Aaf83S3X/RVuI/zpOev8wQ2v/Lj5i/yYyTf8kMU//Kzte/yo6XP8oOVz/Kzxg/y4/Y/8xQGL/Lz1d/yo4V/8pN1X/LDlU/yQxTf8gLkv/dHqB/5GWmP+KkZX/i5KV/4uSlv+Mkpb/jJOV/4uSlf+LkpX/i5KV/4uSlP+KkZT/i5GV/4uRlP+KkJP/ipCT/4mRk/+JkJP/io+T/4mQkv+IkJH/iI+R/4iPkf+Ij5H/iI+Q/4iOkf+JjpD/iI2Q/4iNj/+HjI//h4yO/4eMjv+GjI7/houN/4aLjf+Gi4z/hoqM/4WKjP+FiYv/hYmL/4SJiv+EiIr/hIiK/4OHif+Dhon/g4eI/4KGiP+Chof/gYWH/4GFhv+BhYb/gISF/3+EhP9/goT/foKE/36Cg/9+gYP/fYGC/3yAgf98gIH/fICA/3t/gP97f3//en5//3p+fv95fX3/eXx8/3h8fP93e3v/h4qK/4eKi/+Iiov/iIuM/4iLjP+Ii4z/iYyM/4mMjf+JjI3/iY2O/4qNjv+KjY7/io2P/4qOj/+Ljo//i46Q/4uOkP+Mj5D/jI+R/4yPkf+MkJH/jJCR/42Qkf+NkJL/jZGS/42Rkv+OkZP/jpGT/46Rk/+OkZP/jpKT/46SlP+PkpT/j5OU/4+TlP+Pk5X/j5OV/4+Tlf+Pk5b/j5SW/4+Ulv+QlJf/kJSX/4+Ul/+QlZf/kJWY/5CVmP+QlZj/kJaY/4+WmP+PlZn/kJaZ/5CWmv+Qlpr/kJaZ/5CWmv+Qlpr/kJaa/5CWmv+Qlpn/j5aa/5OXmP+BjqL/Xn+2/1l2pf9KW3z/RlqD/119tv9ee7D/aYe9/3SVzv9sgL7/TFWh/0pSj/+ovdH/udPt/8Lc8f+OreX/zNzu/42o4v+wweL/zuLs/5u82f9cfrD/lrPP/63N3f+iwc7/Y4Gp/4mgvf+btMT/aYek/2eJp/9xk6v/SF1//0NVbf83Smj/ExtN/yQvYf8yQGz/L0Jr/0BWgv8/U37/NUlz/zJFbf8pN1X/ICxF/yY1Vf8pOFv/JTVY/yc4XP8sPmH/L0Bj/zBAYf8sOlr/KTZV/yw5VP8oNVD/IjBM/3R6gP+Rlpf/i5GU/4uSlf+Lkpb/jJKW/4ySlv+MkpX/i5KV/4uSlf+LkpT/i5GU/4uRlP+KkZT/ipGU/4qRlP+KkJP/ipCT/4mQk/+JkJL/iI+S/4iPkf+Jj5H/iY+R/4iPkf+JjpD/iY6Q/4iOkP+IjY//h42P/4eMjv+HjI7/hoyO/4aLjf+Gi43/houM/4aKjP+Fioz/hYmL/4WJi/+EiYr/hIiK/4SIiv+Eh4n/g4eJ/4OHiP+Choj/goaH/4KFh/+BhYb/gYWG/4CEhf+Ag4X/f4OE/3+ChP9+goP/foGD/32Bgv98gIH/fICB/3uAgP97f4D/e39//3p+f/96fn7/eX19/3h8ff94fHz/d3t7/4eKiv+Hiov/iIqL/4iLjP+Ii4z/iIuM/4mMjf+JjI3/iYyN/4mNjv+KjY7/io2O/4qNj/+Ljo//i42P/4uNkP+LjpD/jI+Q/4yPkf+Mj5H/jI+R/4yQkf+NkJH/jZCS/42Rkv+NkZL/jpGS/46Qk/+OkZP/jpGT/46SlP+OkpT/j5KU/4+TlP+Pk5X/j5OV/4+Tlf+Pk5X/j5OW/4+Ulv+QlJb/kJOX/5CUl/+QlJf/kJWX/5CVmP+QlZj/kJaY/5CWmP+Qlpj/kJWZ/5CVmf+RlZr/kJWa/5CVmv+Qlpr/kJaa/5CWmv+Qlpr/kJaa/5CWmf+Qlpj/aYWw/1l3q/9Tbpn/TWui/1l6tP9aeK3/U22f/1x2qf9Zb6D/LDVg/w8VNv8cKD3/aYGo/22Guv97lsP/TGGl/2h7rP9PZKH/WWqZ/11umf9FVYj/NUF1/0FRf/9Sb5X/VXiW/y1CdP9BWIb/Z4Wi/zdQef8yTXX/WnuY/zRNef88UnX/PVBq/wwYLv8KECj/HSVN/y4+af81SXH/QFR9/zlNdv81Snb/L0Fn/yErQv8iL0v/KThY/yU0Vf8jNFj/Kjpf/y0+Yf8vQGL/Lj1d/yk3V/8qOFT/KzhS/yIwS/9zeYH/kZaX/4qRlf+KkZX/jJGV/4ySlv+LkpX/i5KV/4uSlf+LkpX/i5GV/4uRlf+KkZT/ipGT/4qRk/+KkJP/ipCU/4qQk/+JkJP/iZCS/4mPkv+Jj5L/iY+R/4mPkf+JjpH/iI6Q/4iOkP+IjpD/h42P/4eMj/+HjI7/h4yO/4eLjv+Gi43/houN/4aLjf+Gioz/hYqM/4WKi/+FiYv/hIiK/4SIiv+EiIr/g4eJ/4OGif+Dhoj/goaI/4KGiP+Bhof/gYWG/4GFhv+AhIb/gIOF/3+DhP9/goT/foKD/36Bg/99gIL/fICB/3yAgf97f4D/e3+A/3t/f/96fn//en5+/3l9ff94fH3/eHx8/3h7e/+Hiov/h4qL/4iKi/+Ii4z/iIuM/4iLjP+JjI3/iYyN/4mMjf+KjY7/io2O/4qNjv+KjY//i46P/4uOj/+LjpD/i46R/4yPkP+Mj5H/jI+R/4yPkf+MkJH/jZCR/42Qkv+NkJL/jZGS/46Rk/+OkZP/jpGT/46Sk/+OkpT/jpKU/46SlP+Pk5T/j5OV/4+Tlf+Pk5X/j5OV/4+Ulv+QlJb/kJSW/5CUl/+QlJf/kJSX/5CVmP+QlZj/kJWY/5CVmP+QlZn/kJaY/5CWmf+Qlpn/kJWa/5CWmf+Qlpr/kJaa/5CWmv+Qlpr/kJaa/4+Wmv+Sl5j/gpCg/1p6r/9Xcp//TGyk/0lpp/9XdKn/WnWn/0BUf/80Q2v/FiJE/wcQK/8VID//LTpm/0NRiP9LWJD/S1mU/1Zgl/9RXZj/UFqV/0tWk/9CTY3/PUiH/zM+ev8vNWz/LTRn/y43Y/8xN2P/LTZh/y84X/8iK1X/JS9Y/zhHa/8rOWX/Jy9a/yApS/8HDib/AwcR/wIGE/8UHjv/KThe/zpNc/87Tnf/Nkt4/zNJdf8pNVH/IyxD/yk3V/8nNVX/ITFT/yc4W/8rPF//LT5h/y4+YP8rOlr/KThU/yw5U/8jMUz/cXh//5GWmP+KkJX/i5KW/4ySlv+Mkpb/jJKV/4uSlf+LkpX/i5KU/4uRlf+LkZX/i5GU/4qRlP+KkZP/ipCU/4uQlP+KkJP/ipCT/4mQk/+Jj5L/iI+S/4iPkf+Jj5H/iY6R/4iOkP+IjpD/iI6Q/4iNj/+HjY//h4yP/4eMj/+HjI7/houO/4aLjf+Gi43/hoqM/4WKjP+Fiov/hYmL/4SJiv+EiIr/hIiK/4SHif+Dh4n/g4eI/4KGiP+Choj/gYaH/4GFhv+BhYb/gISF/4CDhf9/g4T/f4KE/36Cg/9+gYP/fYGC/32Agv98gIH/fICA/3t/gP97f3//en5//3p+fv95fX3/eXx9/3h8fP93e3v/h4qK/4iKi/+Iiov/iIuM/4iLjP+Ii4z/iYyN/4mMjf+JjI3/io2O/4qNjv+KjY7/io2P/4uOj/+Ljo//i46Q/4uOkP+Mj5D/jI+R/4yPkf+Mj5H/jJCR/42Qkf+NkJL/jZGS/42Rkv+NkZL/jpGT/46Rk/+OkZP/jpGT/46SlP+OkpT/j5KU/4+Tlf+Pk5X/j5OV/4+Tlf+PlJb/j5SW/5CUlv+QlJf/kJSX/5CUl/+QlJf/kJWY/5CVmP+Qlpj/kJaZ/5CWmP+Qlpn/kJaZ/5CWmf+QlZn/kJWa/5CVmf+QlZn/kJWZ/5CWmv+Qlpr/k5iZ/3CGqP9Vc6b/U2+h/z9dl/88UoP/UGaU/z5Sf/8tPmL/Kjha/0BQef9WbqP/YHi4/2V+wv9ger//YXm8/2qDxf9thcb/c4nJ/22Dxv9ofsb/bIPJ/2h/xf9ZbbT/RVaf/zlMjP8xRH//MEB1/y47a/8tOWP/Ljhg/y83Xv8wOF7/NDte/y40Wf8jKEj/FRs4/woOI/8FBg//AQEI/w4WLf8tPmL/O010/zVLdf83T37/LkBo/ycxSf8nM1L/KTdX/yEvUP8jM1b/Kjpd/ys8X/8tPmD/LDtb/yk3VP8sOVP/JTJM/3B3f/+Rlpj/i5GV/4ySlv+MkZb/jJGW/4ySlf+LkpX/i5KV/4uSlP+LkZT/i5KV/4uRlf+LkZT/ipGU/4qRlP+KkJP/io+T/4qQk/+Kj5P/iY+S/4mPkv+Ij5H/iI+R/4mOkf+IjpH/iI6Q/4iOkP+IjY//h4yP/4eMj/+Hi4//h4uO/4aLjv+Gi43/houN/4aLjP+Fioz/hYqL/4WJi/+EiYv/hIiK/4SHiv+Eh4n/g4eJ/4OGiP+ChYj/goaH/4KFh/+BhYf/gYWG/4CEhf+AhIX/f4OE/3+ChP9+goP/foGD/32Bgv99gIL/fICB/3x/gP97f4D/e39//3p+f/96fn7/eX19/3h8ff94fHz/d3t7/4eKi/+Iiov/iIuL/4iLjP+Ii4z/iIuM/4mMjf+JjI3/iYyN/4qNjv+KjY7/io2O/4qNj/+Ljo//i46P/4uOkP+Lj5D/jI+Q/4yPkf+Mj5H/jI+R/4yQkf+NkJH/jZCS/42Rkv+NkZL/jZGS/46Rk/+OkZP/jpGT/46Sk/+OkpT/jpKU/4+SlP+Pk5X/j5OV/4+Tlf+Pk5X/j5SW/4+Ulv+QlJb/kJSX/5CUl/+QlZf/kJWY/5CVmP+QlZj/kJWY/5CWmf+Qlpn/kJaZ/5CWmf+Plpn/kJWa/5CWmv+Qlpn/kJaZ/5GVmv+Qlpr/kpaZ/4+WnP9ge6j/V3Wo/0lnoP8lOWr/N0ly/0ZZfv8lM1b/HStK/zlIav9PY43/W3Wp/199tf9nicj/Wn29/1x6uf9ph8L/cY7H/4Ca0v+Ko93/haHe/3yZ2P9zjM3/dI/O/22Jyv9jfsD/TWeo/zhQjv8xSIL/L0R4/y1Bdf8tQHH/LT1p/yw6Yf8vO2D/MDxg/y46XP8rNlX/IixK/xUdMf8LEyP/Ex83/yk5WP8wQ2f/NEl0/y1Cbv8pN1n/JjNS/yw6Wv8mMlH/IC9R/yc4W/8pO17/Kzxe/yw8Xf8pOFb/LDlT/yYyTP9wd3//kZeY/4uRlf+MkpX/i5KV/4ySlv+MkpX/i5KV/4uSlf+LkpT/i5KU/4uRlP+LkZT/ipGV/4qRk/+KkJT/ipGT/4qQk/+JkJP/io+S/4qPkv+Kj5L/iY+S/4iPkf+JjpH/iI6Q/4iOkP+IjpD/h42P/4eNj/+HjY//h4yO/4eMjv+Hi47/houN/4aLjf+Gi4z/hYqM/4WKi/+FiYv/hYmL/4SIiv+EiIr/hIiJ/4OHif+Dh4j/g4aI/4KGiP+Chof/gYWH/4GFhv+AhIX/f4SF/3+DhP9+g4T/foKD/36Bg/99gYL/fICB/3yAgf98gID/e3+A/3t/f/96fn//en5+/3l9ff95fH3/eHx8/3d7e/+Hiov/iIqL/4iKi/+Ii4z/iIuM/4iLjP+Ji4z/iYyN/4mMjf+JjY7/io2O/4qNjv+Kjo//i46P/4uOj/+LjpD/i4+Q/4yPkP+Mj5H/jI+R/4yPkf+MkJH/jZCR/42Qkv+NkZL/jZGS/42Rkv+OkZP/jpGT/46Rk/+OkZP/jpKU/46SlP+OkpT/j5OU/4+Tlf+Pk5X/j5OV/4+Ulv+PlJb/j5SW/5CUlv+QlJf/kJSX/5CUmP+QlJj/kJWY/4+VmP+Qlpj/kJaZ/5CWmv+Qlpn/kJaZ/5CWmf+Qlpn/j5aZ/5CWmf+Qlpr/kJaa/5SYmf+Ej5//Wneo/1d2rf9AW5P/ER9F/zVEZv9GWYD/L0Bg/y4+YP8/Unf/R1uF/1Zvnv9gfbL/Wneu/1l4sv9Ycqb/VW2c/1tzo/9qgrL/Y3ms/2B4r/9ddrD/YXiy/2Z+tv9jerD/U2me/zpMe/8tQnD/LEBv/yY4Yv8oO2j/Jztn/yc5Yv8kM1j/JTNY/yg3W/8iL07/JTJQ/x0nQP8VHzP/Dxkp/w0VJP8WJDz/IC5H/yQxTf8pPWf/LD5m/yc1Vv8rOVn/KTZT/x8tTP8lNVb/KDlb/yk6Xf8sPF3/KTlX/yo4Uv8nM0z/b3d+/5GXmf+LkZT/jJKW/4ySlv+MkpX/jJGW/4ySlf+MkpX/i5KV/4uSlP+KkZT/ipGU/4qRlP+KkZP/ipGT/4qRk/+JkJP/iZCS/4mPk/+Kj5L/io+R/4mPkv+Ij5H/h4+R/4iPkf+IjpD/iI6Q/4eNj/+HjY//h4yP/4eMjv+HjI7/h4uO/4aLjf+Gi43/hoqM/4WKjP+Fiov/hYmL/4SJi/+EiYr/hIiK/4SIif+Dh4n/g4eI/4KGiP+Chof/goWH/4GFh/+BhYb/gISF/4CEhf9/g4T/foOD/36Cg/9+goL/fYGC/3yBgf98gIH/fH+B/3t/gP97f3//en5//3p+fv95fX3/eHx9/3h8fP93e3v/h4qL/4eKi/+Ii4v/iIuM/4iLjP+Ii4z/iYuN/4mMjf+JjI3/iY2O/4qNjv+KjY7/io6O/4qOj/+Ljo//i46Q/4uPkP+Mj5D/jI+R/4yPkf+Mj5H/jJCR/4yQkf+NkJL/jZGS/42Rkv+NkZL/jpGT/46Rk/+OkpP/jpKU/46SlP+OkpT/jpKU/4+Tlf+Pk5X/j5OV/4+Tlf+PlJb/j5SW/5CUlv+QlJf/kJSX/5CVl/+QlZf/kJWY/5CVmP+PlZj/kJaZ/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaZ/5CWmf+Qlpr/kJaa/5CWmv+UmJn/d4ii/1h4rv9YebT/RWCX/xEdP/8kME3/UWiT/0pfh/9UapH/XXSg/1lwn/9feq7/ZYO5/2R/sv9nhLn/WHKm/2B4qP9edKL/Znyr/1pwnv9QZJD/UGWS/2B2qP9ccqP/SVyI/zdHb/8rO2P/IDJa/yc4Yv8gMVr/ITNa/yAwV/8jNFn/JDNW/yQzVv8kMlP/HixK/xwnQf8RGi7/DRYn/w4YKP8RGy3/Ex0w/xUhNP8lNlX/KTxi/y5Bav8oN1n/Kzpa/yo4Vv8hL03/IzJT/yc4Wv8oOVv/Kztc/yk5V/8pN1H/JzRN/252fv+Rl5j/i5GU/4ySlf+MkpX/jJKV/4ySlv+MkpX/i5KV/4uSlf+LkpT/ipGU/4qRlP+KkZT/iZGT/4qRk/+KkJP/iZCS/4mQk/+Jj5L/iY+S/4mPkv+Jj5H/iI+R/4iPkf+Ij5H/iI6Q/4iOkP+HjY//h42P/4eMj/+HjI7/h4yO/4eLjv+Gi43/houN/4aKjP+Fioz/hYqL/4WJi/+FiYv/hImK/4SIiv+EiIn/g4eJ/4OHiP+Dhoj/goaI/4KFh/+BhYf/gYWG/4CEhv+AhIX/f4OE/3+DhP9+goP/foGC/32Bgv98gIH/fICB/3x/gf97f4D/e39//3p+f/96fn7/eX19/3l8ff94fHz/eHt7/4eKi/+Hiov/h4qL/4iLjP+Ii4z/iIuM/4iLjP+JjI3/iYyN/4mNjv+KjY7/io2O/4qOjv+Kjo//i46P/4uOkP+Lj5D/jI+Q/4yPkP+Mj5H/jI+R/4yQkf+NkJH/jZCS/42Qkv+NkZL/jZGS/46Rk/+OkZP/jpKT/46Sk/+OkpT/jpKU/46SlP+Ok5X/j5OV/4+Tlf+PlJX/j5SW/4+Ulv+PlJb/j5SW/5CVl/+QlZf/kJWX/5CVmP+QlZj/kJWY/5CVmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaZ/5CWmv+Qlpr/kZaZ/2uBpP9ZerT/XH+8/09tp/8nOWj/CxUv/zdKcv9SaJb/Xnak/2uGu/9vjcb/bY3J/26Pyv9ykcn/cY/F/2aEu/9mgLT/Ynel/2F2pv9pf67/Y3ik/1Zrmv9dcaH/U2iX/0NVfv81RGj/Kzti/yM1XP8iMlj/HS5U/x4uVP8jMlj/ITBU/yU1Wv8lNVr/JTRX/yQzVP8dKkb/HSlE/xonQf8dKkX/Gic//yIvSP8hMEr/IzRV/yo8ZP8wQ2z/Kztd/ys6Wv8qOVf/JDJQ/yIxUv8nN1n/JzdZ/yo6Wv8qOlf/KTdR/yYzTf9udn3/kJeY/4uRlf+Mkpb/i5KV/4uSlf+MkpX/jJKV/4uSlf+LkpX/i5KU/4uRlP+KkZT/ipGT/4qRk/+KkZT/iZGT/4qRk/+JkJP/ipCT/4mQkv+Ij5L/iY+R/4mPkf+Jj5H/iI+R/4iOkP+IjpD/h46P/4eNj/+HjY//h4yO/4eMjv+Gi47/houN/4aLjf+Gioz/hYqM/4WKi/+FiYv/hImL/4SJiv+EiIr/hIiJ/4OHif+Dh4j/g4aI/4KGiP+Chof/gYWH/4GFhv+AhIX/gISF/3+DhP9+g4T/foKD/32Cgv99gYL/fICB/3yAgf98gIH/e3+A/3t/f/96fn7/en5+/3l9ff95fXz/eHx8/3d7e/+Hior/h4qL/4iKi/+Ii4z/iIuM/4iLjP+Ji4z/iYyN/4mMjf+JjI7/io2O/4qNjv+Kjo//io6P/4uOj/+LjpD/i4+Q/4uPkP+Mj5H/jI+R/4yPkf+MkJH/jZCR/42Qkv+NkZL/jZGS/42Rkv+OkZP/jpKT/46Sk/+OkpP/jpKU/46SlP+OkpT/j5OU/4+Tlf+Pk5X/j5SV/4+Ulv+PlJb/j5SW/4+Vl/+QlZf/kJWX/5CVmP+QlZj/kJWY/5CVmP+QlZn/j5aZ/4+Wmf+Qlpn/kJaZ/5CWmv+Qlpn/kJaZ/5CWmv+Plpr/kZaa/4yTmv9gfKr/XIG+/1+FxP9afbv/RWGc/xorVf8MFzP/M0Nv/0xklv9deLT/bIzO/3WX2f94mt7/ep3d/3aX1v9ujMf/Yn21/1xzp/9acaP/W2+d/1dplf9IW4j/O014/y4/Yv8gL07/HCpK/xgnSP8XJkn/GShL/xspTP8bKk7/HitQ/x8uUv8iMln/IjJY/yY2Xf8kNVz/JjZc/yQ1Wv8oOFz/LD1g/y0/Yv8wQmX/JDVX/yg7YP80SXP/MUNo/zA/X/8tPV3/KzlY/yY1U/8jMlP/KDdX/yc4V/8oOFj/KTlW/yk3Uf8mM03/bnd//5CWmP+KkJT/i5KV/4uSlf+MkpX/i5KV/4uSlf+LkpX/i5GV/4uSlP+KkZT/ipGU/4qRlP+KkZP/ipGU/4qRk/+KkJP/iZCT/4qPkv+JkJL/iI+R/4mPkf+Jj5H/iI+R/4iOkP+IjpD/iI6Q/4eOj/+Hjo//h42P/4eMjv+HjI7/houN/4aLjf+Gi43/hoqM/4WKjP+Fiov/hYmL/4WJi/+EiYr/hIiK/4SIif+DiIn/g4eI/4KHiP+Choj/goWH/4GFh/+BhYb/gISF/3+Ehf9/hIT/f4OE/36Cg/99goP/fYGC/32Bgf98gIH/fICA/3t/gP97f3//en5+/3p+fv95fX3/eX19/3h8fP94e3v/h4mK/4eKi/+Hiov/iIuL/4iLjP+Ii4z/iIuM/4mMjf+JjI3/iYyO/4qNjv+KjY7/io2O/4qOj/+Ljo//i46P/4uPkP+Lj5D/jI+Q/4yPkf+Mj5H/jJCR/4yQkf+NkJL/jZCS/42Rkv+NkZL/jZGS/46Rk/+OkpP/jpKT/46SlP+OkpT/jpKU/46TlP+Pk5X/j5OV/4+Tlf+PlJb/j5SW/4+Ulv+PlZb/j5WX/5CVl/+QlZj/kJWY/5CVmP+Qlpj/kJWZ/5CVmP+Plpn/kJaZ/5CWmf+Plpr/kJaZ/5CWmf+Plpr/j5Wa/5GWmf+AjZ3/XH62/2OKyP9kis3/ZYnL/1l8u/9AWpX/GihQ/wsVM/82R3L/VW6o/2eGx/93l9j/fp7h/3yd4P9si8//VG+q/0Naj/87Tn3/QlN//01fi/9JW4f/Pk55/zdHb/8nNFX/CBEk/wIJGf8FDiT/DBYw/w8bOP8THj3/FiFB/xcjRf8YJUb/GylO/x4sU/8iMlv/IzVg/yY5Zf8mOGP/Kjxo/zJFcf8vQmr/Jzlg/y5Ba/85Tn3/Nklz/zRGaf8wQGL/Lj5e/yw8W/8nN1X/JDNS/yc2Vv8mN1b/JjhX/yg4Vf8oNlD/JjNN/211fv+Qlpf/iZCT/4uRlP+LkZT/i5KU/4uSlP+LkpT/i5GV/4uSlf+LkZT/i5GU/4qRlP+KkZT/ipGT/4qQk/+KkJL/iZCS/4mPkv+Jj5L/iZCS/4iPkf+Jj5H/iI+R/4mPkf+IjpH/iI6Q/4eOkP+HjY//h42P/4eNjv+HjI7/hoyO/4aLjf+Gi43/houN/4aKjP+Fioz/hYqL/4WJi/+EiYr/hImK/4SIif+DiIn/g4eJ/4OHiP+Choj/goaH/4KGh/+BhYf/gYWG/4CEhf9/hIX/f4OE/36DhP9+goP/fYKC/32Bgv98gYH/fICB/3yAgP97f4D/e39//3p+f/96fX7/eX19/3l9ff94fHz/eHt7/4eKiv+Hiov/h4qL/4eLi/+Ii4z/iIuM/4mLjP+JjI3/iYyN/4mMjf+KjY7/io2O/4qNjv+Kjo//io6P/4uOj/+Lj5D/i4+Q/4yPkP+Mj5H/jI+R/4yQkf+NkJH/jZCS/42Qkv+NkZL/jZGS/42Skv+OkpP/jpKT/46Sk/+OkpT/jpKU/46SlP+PkpX/j5OV/4+Tlf+Pk5X/j5SW/4+Ulv+PlJb/j5WX/4+Vl/+QlZf/kJWY/5CVmP+QlZj/kJWY/5CVmP+PlZn/kJaZ/5CWmv+Qlpn/kJaZ/5CXmf+Qlpn/j5aa/4+Vmv+Sl5j/coel/16Gw/9ok9T/bpfa/26U1/9micv/UnGw/0BXj/8dK1X/FCBE/0pgk/9ohsL/dZTT/3+d3P9tiMb/VWun/zdKf/82SXn/R12O/1hxq/9eebX/V2+m/05hlP9JWYb/RlN5/zhDZP8eJ0H/ChIn/wQLHf8EChv/BQwh/w0WL/8SHDv/Ex8//xMfPv8VIkP/HS1T/yI1Yf8lOWj/Kj5u/yxAb/8oOmT/Kjpj/zlNff9DWo7/QFWG/zpNd/82SG3/M0Rm/zBAYf8uPl7/KjpZ/yc2Vf8nNlb/JjZV/yY2Vv8nN1T/KDZR/yU0Tv9sdH3/jpSW/4eOkv+KkZP/i5KU/4uSlP+LkZX/i5KU/4uRlf+LkZX/i5GU/4uRlP+KkZT/i5GU/4qRlP+KkZP/iZGT/4qQk/+KkJP/iZCS/4mQkv+Jj5L/iY+S/4iPkf+IjpH/iI6Q/4iOkP+HjpD/h46Q/4eOj/+HjY7/h42O/4eMjv+GjI3/houN/4aLjf+Gioz/hYqM/4WKi/+FiYv/hImL/4SJiv+EiIr/g4iJ/4OIif+Dh4j/goeI/4KGiP+Chof/gYWH/4GEhv+AhIX/gISF/3+DhP9/g4T/foKD/32Cgv99gYL/fIGB/3yAgf97gID/e3+A/3t/f/96fn//en5+/3l9ff95fX3/eHx8/3h7e/+HiYr/h4qL/4eKi/+Hiov/iIuM/4iLjP+Ii4z/iYyN/4mMjf+JjI3/iY2O/4qNjv+KjY7/io6P/4qOj/+Ljo//i46Q/4uPkP+Lj5D/jI+Q/4yPkf+MkJH/jJCR/42Qkv+NkJL/jZGS/42Rkv+NkZL/jZKT/46Sk/+OkpP/jpKT/46SlP+OkpT/j5OU/4+Tlf+Pk5X/j5OV/4+Ulv+PlJb/j5SW/4+Vlv+PlZf/j5WX/5CVmP+QlZj/kJaY/5CVmP+QlZn/j5WZ/5CWmf+Plpn/kJaZ/5CWmf+Qlpn/j5aZ/4+Wmf+Qlpn/i5Oa/2WEtP9nkdH/bpve/3Oe4f92nN//cZbb/1+AyP9Oaqz/PVSN/yAwYv8mOGr/W3ar/3aVz/91k9D/YoTI/2GFyf9mhsn/aInN/2mO0v9ojdP/YoXM/1t5vv9Ra6z/S2Gc/0VWh/9BTnn/QlB7/zxLdv8yP2P/KTNS/ygxT/8uOVv/LDlf/xciQv8MGDL/EBs6/xopT/8iNWP/Jzxt/yg9bf8nOmb/MkZz/0VckP9KYJf/RlyS/0FWiP87T3v/Nkhw/zRGa/8wQmT/Lj9g/ys6Wv8oOFf/KDhX/yY2Vf8mNlX/JzZT/yk3U/8kM0//anJ9/5Wamv+OlZb/jZOV/4mQk/+KkZT/i5KU/4uSlP+LkZX/ipKU/4qRlP+KkZT/ipGU/4qRlP+KkZT/iZGT/4mRk/+JkJL/ipCS/4mQkv+IkJL/iY+S/4mPkf+Ij5H/iI6R/4iOkf+IjpD/h46Q/4eNkP+HjY//h42O/4eMjv+HjI7/h4yN/4aLjf+Gi43/hoqM/4WKjP+FiYv/hYmL/4WJiv+EiIr/hIiJ/4OIif+Dh4n/g4eI/4KGiP+Chof/gYaH/4GFh/+BhYb/gISF/4CEhf9/g4T/foOE/36Cg/99goL/fYGC/3yBgf98gIH/e4CA/3t/gP97f3//en5//3p+fv95fX3/eX19/3h8fP94fHz/homK/4eKiv+Hiov/h4qL/4iLjP+Ii4z/iIuM/4mMjf+JjI3/iYyN/4mMjv+KjY7/io2O/4qOj/+Kjo//io6P/4uPkP+Lj5D/i4+Q/4yPkP+Mj5H/jJCR/4yQkf+MkJH/jZCS/42Qkv+NkZL/jZKS/42Sk/+OkpP/jpKT/46SlP+OkpT/jpKU/46SlP+Pk5X/j5OV/4+Tlf+PlJb/j5SW/4+Vlv+PlZf/kJWX/4+Vl/+Qlpj/kJWY/5CWmP+Qlpn/kJaZ/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaZ/4+Wmf+Plpn/kpeY/3aOtP9fhsD/bJfX/3Wi5P96pOb/gKbl/3+j5P9vk9n/W3zF/0pmqf87UpH/L0R+/0Vdk/9ti8H/dJjb/3uh6P+Dp+v/f6bp/3Ob4/90m+H/f6Tk/3eb3v9ni9L/WHrD/1Rxtf9LYp7/QlSK/z1Pgv8+UYb/Q1iN/0NVi/9BUoX/QVGB/z5Mef8rOWP/CBIu/w8cOf8cLFH/IjRf/yM3Y/8rPmz/P1aN/09oov9QaqX/TWWg/0hgl/9CWIr/P1OA/zhMdv81SG7/MURm/y5AYf8sPVz/KTlZ/yc4V/8mNlX/JjVT/yc0Uv8oNlL/IzJP/11mc/9weIL/ZW99/3uDiv+Plpb/i5OU/4qRlP+LkpX/i5KV/4qSlP+KkZT/ipGU/4qRlP+KkZT/ipGU/4mRk/+KkZP/iZCT/4mQkv+JkJP/iZCS/4mPkv+Jj5L/iI6R/4iOkf+IjpD/iI6Q/4iOkP+HjY//h42P/4eNj/+HjY7/h4yO/4aMjf+Gi43/houN/4aKjP+Fiov/hYmL/4WJi/+EiYr/hIiK/4SIif+DiIn/g4iJ/4OHiP+Choj/goaH/4KGh/+BhYb/gIWG/4CEhf+AhIX/f4OE/36ChP9+goP/fYKC/32Cgv98gYH/fIGB/3yAgP97gID/e3+A/3p+f/96fn7/eX1+/3l9ff94fHz/eHx8/4aJiv+Hiov/h4qL/4eKi/+Ii4z/iIuM/4iLjP+JjI3/iYyN/4mMjf+JjI7/io2O/4qNjv+KjY//io6P/4qOj/+LjpD/i4+Q/4uPkP+Lj5D/jI+R/4yPkf+MkJH/jJCR/42Qkv+NkJL/jZGS/42Rkv+NkZP/jZGT/46Sk/+OkpP/jpKU/46SlP+Ok5T/j5OV/4+Tlf+Pk5X/j5SW/4+Ulv+PlJb/j5WX/4+Vl/+PlZf/kJWY/5CWmP+QlZj/kJWZ/5CWmf+Qlpn/kJaZ/5CWmf+Qlpn/kJaZ/5CWmf+Plpr/kJaY/42Wov9rj8r/X4jC/2+a2v96peb/gqvp/4yw6/+Iq+j/fJ7i/3CR1v9aesH/SWWs/z9Ym/9MZKD/ZYG9/3Wd5P+AqO3/kLDt/4ir7P97ouf/j7Dr/6nC8P+kve7/h6bj/2qN1P9efcX/VXC0/0tjof9CV5D/QFWN/0Rblf9IXpr/Q1mV/z9SiP8+TXz/Lz5u/xAbPP8QHj3/IjJc/yU3Y/8xRnj/RV2Z/1ZwsP9adbT/V3Gw/1Nuqv9KYpv/Q1mN/0BVg/85Tnn/Nklw/zJEZ/8vQGH/LD5e/yo7Wv8oOVj/JjZU/yU1U/8mNFL/JzVR/yg2Uv8gL03/FCVM/x0wWP8qOmD/Ul11/4iPk/+NlJb/i5GU/4uSlf+LkpT/i5GV/4uRlP+KkZT/i5GU/4qRk/+KkZP/ipGT/4mQk/+JkJL/iZCS/4mQkf+Ij5H/iY+S/4iPkf+IjpH/iI6R/4iOkP+IjpD/h42Q/4eNj/+HjY7/h4yO/4eMjv+GjI3/houN/4aLjf+Fioz/hYqM/4WJi/+FiYv/hImK/4SIiv+EiIn/g4iJ/4OHif+Dh4j/goeI/4KGh/+Bhof/gYWG/4GFhv+AhIX/gIOF/3+DhP9+goT/foKD/32Cgv99gYL/fIGB/3yAgf98gID/e4CA/3t/f/96fn//en5+/3l9fv95fX3/eHx8/3h8fP+HiYr/h4qK/4eKi/+Hiov/iIuL/4iLjP+Ii4z/iYuN/4mMjf+JjI3/iYyN/4mNjv+KjY7/io2O/4qOj/+Kjo//i46P/4uOkP+Lj5D/i4+Q/4yPkP+Mj5H/jJCR/4yQkf+NkJL/jZCS/42Qkv+NkZL/jZGT/42Rk/+NkpP/jpKT/46SlP+OkpT/jpKU/46Tlf+Pk5X/j5OV/4+Ulv+PlJb/j5SX/4+Ul/+PlZf/j5WX/4+VmP+Qlpj/j5WY/5CWmP+QlZn/kJaZ/5CWmf+QlZn/kJaZ/4+Wmf+Qlpn/j5aa/5GWl/+Klqf/aZDN/2KNyP9wnNz/fKjo/4iv6/+Rs+3/mbbs/5Ww6P+HpOH/dJPU/2F/xP9QbrT/SmWr/2J9v/9xmN7/daDs/32i6f97ouf/dJ3l/4Wq6v+uxvH/usvx/6S67P96mt7/YIHL/1d1vf9MZ6v/R1yY/0FWjv9FXJn/S2Sj/0dhov9BV5L/OUl9/y8+bv8UIUT/GyxR/y1Bcv86UYf/TGWk/1l2uf9ifsH/Yn6//1p2tv9XcbD/Tmei/0hglf9CWYn/PVJ+/zhLc/80RWn/L0Fh/y0/X/8qO1r/JzhY/yY2Vf8mNVT/JTRR/yYzUP8nNFD/GCVE/w8dPv8ZKk//IDFZ/yEzXv9EUnL/h46S/4yTlf+LkpT/i5KV/4uSlf+LkZT/ipGU/4uRlP+KkZP/ipGU/4mQk/+JkJP/iZCT/4mQkv+IkJL/iI+S/4iPkv+Ij5H/iI6R/4iOkP+IjpD/iI2Q/4eNkP+HjY//h42P/4eMjv+GjI7/hoyN/4aLjf+Gi4z/hYqM/4WKi/+FiYv/hYmL/4SJiv+EiIr/hIiK/4OIif+Dh4n/g4eI/4KGiP+Choj/goaH/4GFhv+BhYb/gISF/4CDhf9/g4T/foKE/36Cg/99gYL/fYGC/3yBgf98gIH/fICA/3uAgP97f3//en5//3p9f/96fX3/eX19/3l8ff94fHv/homK/4eKi/+Hiov/h4qL/4iLjP+Ii4z/iIuM/4iLjP+JjI3/iYyN/4mMjv+KjY7/io2O/4qNjv+KjY//io6P/4uOj/+LjpD/i4+Q/4uPkP+Mj5H/jI+R/4yQkf+MkJH/jJCS/42Qkv+NkJL/jZGS/42Rk/+NkZP/jZKT/46Sk/+OkpT/jpKU/46SlP+Ok5T/jpOV/4+Tlf+Pk5b/j5SW/4+Ulv+PlJf/j5SX/4+Vl/+QlZf/j5WY/5CVmP+QlZj/kJWZ/5CWmf+QlZn/kJWZ/5CVmf+PlZn/j5WZ/4+Vmv+Qlpj/i5Wg/2iNx/9kkc7/cZzb/3um5/+Ir+z/mrnv/5657v+huez/nLXo/46p4f9+nNn/aonN/1R0v/9Ucr3/cpLU/3Ca5f9ul+T/cJnj/26X4f9xmeX/kLDt/6zC8f+ctez/cpTc/1+BzP9VdL3/TWis/0Zemv9CWZL/SWGf/0xmqv9MZqv/RV2e/ztPiP8tPGr/HCpP/zJIe/9DW5j/VXCy/2F+w/9riMv/aofK/2eExv9hf77/WXW1/1Ntqf9JYZr/RFyP/z5Tgf84S3T/NEZq/y9BYv8tPl3/Kjpa/yc4WP8nN1f/JjVW/yQzUP8kMU3/JjJN/xsnQ/8LFjP/Dho6/xMiR/8gMVn/IDRi/1Vhev+Qlpb/ipKU/4uSlf+MkZX/i5GV/4uRlP+LkZT/i5GU/4qQlP+JkJP/iZCT/4mQkv+Jj5L/iY+S/4iPkv+Jj5H/iI+R/4iOkf+IjpH/iI6Q/4iNkP+HjZD/h42P/4eMj/+HjI7/hoyO/4aLjf+Gi43/houM/4aKjP+Fiov/hYmL/4WJi/+EiIr/hIiK/4SIiv+Dh4n/g4eJ/4OHiP+Choj/goaH/4KGh/+BhYb/gYWG/4CEhf+AhIX/f4OE/36ChP9+goP/fYGC/32Bgv98gYH/fICB/3uAgf97f4D/e39//3p+f/96fn7/en19/3l9ff95fHz/eHx8/4aJiv+Hior/h4qL/4eKi/+Ii4v/iIuM/4iLjP+Ii4z/iYyN/4mMjf+JjI3/iYyO/4qNjv+KjY7/io2P/4qOj/+Ljo//i46Q/4uOkP+Lj5D/i4+Q/4yPkf+Mj5H/jJCR/4yQkf+NkJL/jZCS/42Rkv+NkZL/jZGT/42Rk/+OkpP/jpKT/46SlP+OkpT/jpKU/46Tlf+Pk5X/j5OW/4+Tlv+PlJb/j5SX/4+Ul/+QlZf/j5WX/5CVmP+QlZj/kJWY/5CVmP+QlZn/j5WZ/4+VmP+PlZn/kJWZ/4+Vmf+PlZn/kZaX/4eSof9mi8X/ZZLP/3Cc2v96pub/ia/s/5288f+owPL/qsHw/6K56/+bs+f/j6rh/4Gf3f9vkNX/X4LM/2KCyv9xlNn/bpbd/3CY4P9wmuH/b5ji/3qg6P+MrOv/hKXm/2iM1/9cfsr/VnO8/0xnq/9DWpb/QFaN/0lin/9NaKv/Tmis/0ljpf8+U4z/KThi/zNFdv9MZqb/X32//2yKzf9ykNP/cZDT/2+Nz/9rh8j/XHm6/1p1tv9Ub67/TWeg/0Zfkv8/VIP/OU12/zRHbP8wQWP/LT1e/yk5Wf8nOFn/JjdY/yc2Vv8kM0//JDFM/yQxTP8eK0f/DBYv/wcRKv8MGTj/FidN/xwwWv8xQmn/hYuR/4yUlf+LkpX/i5KV/4uSlf+LkZT/ipCU/4qQlP+KkZT/iZCT/4mQk/+JkJL/iY+S/4mPkv+Ij5L/iI+R/4iPkf+IjpH/iI6Q/4iOkP+IjZD/h42Q/4eNj/+HjI//h4yO/4aMjv+Gi43/houN/4aLjP+Fioz/hYqM/4WJi/+FiYv/hIiK/4SIiv+EiIn/g4eJ/4OHif+Ch4j/goaI/4KGh/+Bhof/gYWG/4GFhv+AhIX/f4OF/3+DhP9+goT/foKD/32Bg/99gYL/fICB/3yAgf98gID/e3+A/3t/f/96fn//en5+/3p9fv95fX3/eHx8/3h8fP+GiYr/h4mK/4eKi/+Hiov/iIqL/4iLjP+Ii4z/iIuM/4mMjf+JjI3/iYyN/4mMjf+KjY7/io2O/4qNj/+KjY//io6P/4uOkP+LjpD/i4+Q/4uPkP+Mj5H/jI+R/4yPkf+Mj5H/jJCS/42Qkv+NkJL/jZGS/42Qk/+NkZP/jZGT/46SlP+OkpT/jpKU/46SlP+OkpX/jpOV/4+Tlf+Pk5b/j5OW/4+Tlv+PlJf/j5SX/4+Vl/+QlZj/kJWY/4+VmP+QlZj/kJWY/4+VmP+PlZj/j5SY/4+UmP+PlJn/j5SZ/5GWlv+CkKv/ZYzK/2WRzv9qmNj/dqTk/4mw7f+hvvL/q8Tz/63E8f+kvO3/oLjq/5ix5v+RrOX/hKPh/3ub3f9xk9n/cpXY/3KY2v9ul97/cpzi/2+Y4v9xmOX/eJzm/3OX4f9pjNj/XX7I/1RyuP9JYqT/QVmS/z5Uif9EXJP/SGGa/0Nblf89Vo7/MER2/zdLff9Tba3/aobJ/3SR0v94ltX/e5nY/3qY2P9xkNL/ZILG/197v/9deLr/V3Ky/05opP9GXpP/QFaF/ztOef80Rmz/L0Bi/y09Xv8oOln/JzhY/yY3WP8nN1f/IzJN/yMwSv8jL0n/HixI/w0YMv8IEiv/DBc1/xUmS/8XKlL/HC9Z/2tzgv+Rl5j/ipGU/4uSlf+LkpT/ipGU/4uRlP+LkZT/ipCT/4mQk/+JkJP/iY+S/4mPkv+Jj5L/iI+R/4iPkf+Ij5H/iI6R/4iOkf+IjZD/h42Q/4eNkP+HjI//h4yP/4eMjv+Gi47/houN/4aLjf+Gi4z/hYqM/4WKi/+FiYv/hImL/4SIiv+EiIr/hIeJ/4OHif+Dh4n/goaI/4KGiP+Chof/gYaH/4GFhv+BhYb/gISF/3+Dhf9/goT/foKE/36Bg/99gYP/fYGC/3yAgf98gIH/e4CA/3t/gP97f3//en5//3p+fv95fX3/eX19/3h8fP94e3v/h4mK/4eJiv+Hiov/h4qL/4iLi/+Ii4z/iIuM/4iLjP+JjI3/iYyN/4mMjf+JjI3/iY2O/4qNjv+KjY//io2P/4qOj/+Ljo//i46Q/4uPkP+Lj5D/jI+Q/4yPkf+Mj5H/jJCR/4yQkv+NkJL/jZGS/42Rkv+NkZP/jZGT/42Rk/+OkpP/jpKU/46SlP+OkpT/jpOV/46Tlf+Pk5X/j5OW/4+Ulv+PlJb/j5SX/4+Ul/+PlJf/j5SX/4+Vl/+PlZf/j5WY/5CVmP+QlZj/j5WY/4+VmP+PlJj/j5SY/4+Vmf+RlZT/fpK3/2SLy/9kkMz/aJjY/2+d4P+Cqun/nr7y/6vE8/+uxPL/qsLx/6K77f+Wsur/lLDo/4+r5v+Jp+T/hqbj/4Sm4/95oOD/bprg/3Gc4/9wmuT/bZbl/3GX5f90meL/aIzX/1x9x/9TcLf/SGGj/0Jak/87Uoj/OU+D/zlNf/8xRHb/Kz5w/zdOhP9UcK//Z4TI/3OR1P98mdn/g57c/4Kf3P98mtr/dZTV/22Mz/9nhsj/YH7A/1h0tf9Qaqb/R2GW/z9Wh/84THj/M0Vr/y5AYv8rPF3/KTpb/yc4Wf8nN1j/JjdW/yMxTP8jMEn/Ii9J/x8uSv8KFSz/ChQt/wwZN/8RIEH/DRk3/wweRv9DTmr/kZaW/4qRlP+LkZX/i5GU/4uSlP+LkZT/i5GU/4qQk/+KkJP/iZCT/4mQk/+Jj5P/iY+S/4iPkv+Ij5L/iI6R/4iOkf+IjpH/iI6Q/4iNkP+IjZD/h42P/4eMj/+HjI//houO/4aLjf+Gi43/hoqM/4WKjP+Fiov/hYmL/4WJi/+EiIr/hIiK/4SIiv+Dh4r/g4eJ/4KGiP+Choj/goaH/4GFh/+BhYb/gISG/4CEhf9/g4X/f4OE/36ChP9+goP/fYGD/32Bgv98gIL/fICB/3uAgf97f4D/e39//3p/f/96fn7/eX19/3l9ff94fHz/eHt8/4eJiv+Hior/h4qL/4eKi/+Hiov/iIuM/4iLjP+Ii4z/iYuM/4mMjf+JjI3/iYyN/4mMjv+KjI7/ioyO/4qNj/+Kjo//i46P/4uOkP+LjpD/i4+Q/4uPkP+Mj5H/jI+R/4yQkf+MkJH/jZCS/42Qkv+NkJL/jZCT/42Qk/+NkZP/jZKT/46SlP+OkpT/jpKU/46TlP+Ok5X/jpOV/46Tlf+Pk5b/j5OW/4+Tl/+PlJf/j5SX/4+Ul/+PlZj/kJWX/4+VmP+QlZj/j5WY/5CVmP+PlZj/jpSY/46UmP+PlZn/kJSV/3uUw/9hhsf/Yo3K/2aX2P9snOD/fqjo/5m78P+nwvL/qsPy/6fB8f+iu+//lrPr/5ay6/+Sr+n/kK7n/4up5f+JqOP/e5/g/22b4f9wneP/cJvl/26Z5v9ym+j/dJrj/2yP2f9df8r/U3C4/0pjpP9DW5b/PFKJ/zVLfv8vQ3P/L0Jy/zRJff9FX57/YX/B/3GOz/94ldb/fpvc/3+c3P+Fod//fZzb/3WW2P9vkNP/Z4jL/2GAw/9ad7j/UW2o/0dhmP8+VYf/Nkt2/zBCaP8uQWP/Kzxe/yk6W/8oOVj/JzhY/yU2VP8iMEv/IzBK/yEvSf8gME//Bgwd/wUMIP8QHj//Cxcy/wMIG/8KFjn/JDNZ/4OJjv+NlJb/i5GU/4uRlP+LkZT/i5GU/4qQlP+KkJP/io+T/4mPk/+JkJP/iY+T/4mPkv+Ij5L/iI+R/4iOkf+IjpH/iI6Q/4iOkP+HjZD/h42P/4eMj/+Hi47/h4uO/4aLjv+Gi43/houN/4WKjP+Gioz/hYqL/4WJi/+FiYv/hIiK/4SIiv+Eh4n/g4eJ/4OGiP+Choj/goaI/4KGh/+BhYf/gYWG/4CEhv+AhIX/gIOF/3+DhP9+goT/foGD/32Bg/99gYL/fICB/3yAgf98f4D/e3+A/3t/f/96fn//en5+/3l9ff95fX3/eHx8/3h7e/+HiYr/h4qK/4eKi/+Hiov/h4qL/4iLi/+Ii4z/iIuM/4iLjP+IjI3/iYyN/4mMjf+JjI3/iY2O/4qNjv+KjY//io6P/4uOj/+LjpD/i46Q/4uPkP+Lj5D/jI+R/4yPkf+MkJH/jJCR/4yQkv+NkJL/jZCS/42Rkv+NkZP/jZGT/42Sk/+OkpP/jpKU/46SlP+OkpT/jpOV/46Tlf+Ok5X/jpOW/4+Tlv+PlJf/j5SX/4+Ul/+PlJf/j5SX/4+Vl/+QlZj/j5WY/4+VmP+QlZj/j5WX/4+UmP+PlJj/j5WY/4+UmP92lM7/XYHB/2CLyP9lldf/bJ3h/4Kt6/+au/D/or/y/5+88P+bue7/mLbu/5Wz7f+Vsuz/lbLr/5Wy6v+TsOf/jqzl/4Kk4v9umeH/bpzk/22b5f9vnOf/daDp/3Wd5f9rkdz/X4LN/1JwuP9HYaP/QVmT/ztTiv81S3//Mkh8/zNJe/86UYf/S2am/2SDxP9yktL/epnZ/36c3P9/nt7/f5/f/3yc3P95mtr/dJbW/2uMzv9hgcT/WHW3/01opP9AWI7/OlGB/zVKdP8uQmn/LUBl/ys8X/8qO13/KDlY/yc2Vf8kNVH/Ii9K/yIwSv8gLUj/IjRU/w0YMP8CBx3/CBAq/wUMIf8ECBv/Bw8q/xIkT/9ob3z/j5SU/4mQk/+LkZT/i5GU/4qRlP+LkJP/i5CT/4qQk/+JkJP/io+T/4mPk/+Jj5L/iY+S/4iPkf+IjpH/iI6R/4iOkf+IjZD/h42Q/4eNj/+HjI//h4yP/4eMj/+Gi47/houN/4aLjf+Gioz/hYqM/4WKi/+FiYv/hYmL/4SIiv+EiIr/hIeJ/4OHif+Dh4n/goaI/4KGiP+Chof/gYWH/4GFhv+AhIb/gISF/3+Dhf9/g4T/foKE/36Cg/99gYP/fYGC/32Agv98gIH/fICA/3t/gP97f3//en5//3p+fv95fX3/eX19/3h8fP94e3v/h4mK/4eJiv+Hiov/h4qL/4eKi/+Iiov/iIuM/4iLjP+Ii4z/iIyM/4mMjf+JjI3/iYyO/4mMjv+KjY7/io2P/4qNj/+Ljo//i46P/4uOkP+Lj5D/i4+Q/4yPkf+Mj5H/jJCR/4yQkf+MkJL/jZCS/42Qkv+NkJP/jZGT/42Rk/+NkZP/jZKU/46SlP+OkpT/jpKU/46TlP+Ok5X/jpOV/46Tlv+Pk5b/j5OW/4+Tl/+PlJf/j5SX/4+Ul/+OlJf/kJSX/4+VmP+PlZf/j5SY/4+Ul/+PlJf/jpSY/4+Ulv+NlaD/bI7U/1R1tf9hi8n/ZJTW/2yd4P9/qun/lLfv/5298v+auu//k7Xu/4qu7P+Lruv/jbDr/5Gy6/+Ytuz/l7Tr/5a06/+Pruf/d53k/2uZ5f9vn+n/c6Hq/3yn6v99pOf/bZXe/1+Fz/9Sc7v/SWSm/0FZlf88VYz/OVGG/zRLgf8ySYH/QVqW/1VytP9nhsj/c5PT/3eY2f95mtv/eJnb/3ia3P91l9r/dJbX/3OW1P9qjM7/YIHF/1Rytv9KZaP/QlqS/zpShP81SXb/MERs/y5BZ/8qPWH/Kztd/yc3Vv8mNVP/IzJO/yAvSf8jMUz/Hi1J/x8wUP8cLVD/CRMt/wcOJv8FCR7/BQkc/wUKIP8LG0b/TFZw/46Skv+Ij5P/i5GU/4uRlP+LkZT/ipCU/4uQk/+KkJP/iY+S/4qPkv+Jj5L/iY+S/4iPkv+Ij5H/iI6R/4iOkf+IjpD/h46Q/4iNkP+HjY//h4yP/4eLj/+Hi47/houO/4aLjf+Gi43/hoqM/4WKjP+Fiov/hYmL/4WJiv+EiIr/hIiK/4SHiv+Dh4n/g4aJ/4OGiP+ChYj/goaH/4GFh/+BhYb/gISG/4CEhf9/g4X/f4OE/36Cg/9+gYP/fYGC/32Agv98gIH/fICB/3x/gP97f4D/e35//3p+f/96fn7/eX19/3l9ff94fHz/eHt7/4aJiv+HiYr/h4qK/4eKi/+Hiov/h4qL/4iLi/+Ii4z/iIuM/4iLjP+IjI3/iYyN/4mMjf+JjI7/io2O/4qNj/+KjY//io6P/4uOj/+LjpD/i46Q/4uPkP+Lj5D/i4+R/4yPkf+MkJH/jJCR/4yQkv+MkJL/jZCS/42Rk/+NkZP/jZGT/42Rk/+NkpT/jpKU/46SlP+OkpT/jpOV/46Tlf+Ok5X/jpOW/4+Tlv+Pk5b/j5SX/4+Ul/+PlJf/j5SX/4+Ul/+PlZf/j5WX/4+UmP+PlJf/jpSY/46UmP+Pk5P/iJev/1qA0v9JZqT/YozJ/2aV1v9tnd7/eKXm/4St6v+Jrur/i7Hq/4mv6v+Irur/g6vq/4Go6P+Gren/iq7r/5Kz7f+Wtu7/lLPs/4Wo6f9tmeX/bp7o/3mn7P9/quv/ganp/3Wd4f9iitL/VnnA/01prv9EXpz/PleP/zhQhP80TYL/OVGO/01pqf9aer//ZYfN/2+S0/9uk9T/a4/S/2uP1P9rj9T/b5PV/3GU1P9wk9L/ao7P/2CCxv9Yeb3/TWuu/0Zhnf88VYr/Nkx6/zFGcf8vQmr/Kz1i/yk6XP8mNlT/JTNR/yEwTP8fL0n/IjFN/xwrRv8eLk7/HS5T/xkoSP8IDyf/BQoe/wUKH/8FCiD/ChY//zFAZv+JjY7/ipCT/4qQlP+KkZT/i5GU/4qQk/+KkJL/ipCS/4mQkv+Jj5L/iY+S/4mPkv+IjpH/iI6R/4iOkf+IjpH/iI6Q/4iNkP+IjZD/h42P/4eMj/+HjI7/h4yO/4aLjv+Gi43/hoqN/4aKjP+Fioz/hYqL/4WJi/+FiYr/hIiK/4SIiv+Eh4n/g4eJ/4OHiP+Dhoj/goaI/4KFh/+BhYf/gYWG/4CEhv+AhIX/f4OE/3+DhP9+goP/foKD/32Bgv99gYL/fICB/3yAgf98f4D/e3+A/3t/f/96fn//en5+/3l9ff95fH3/eHx8/3h7e/+HiYr/h4mK/4eKiv+Hiov/h4qL/4eKi/+Ii4v/iIuM/4iLjP+Ii4z/iIyM/4mMjf+JjI3/iY2O/4qNjv+KjY7/io2P/4qOj/+Ljo//i46Q/4uOkP+Lj5D/i4+Q/4uPkf+MkJH/jJCR/4yQkf+MkJL/jJCS/42Qkv+NkZL/jZGT/42Rk/+NkZP/jZKT/42SlP+NkpT/jpKU/46TlP+Ok5X/jpOV/46Tlf+Ok5b/j5OW/4+Tl/+PlJf/j5SX/4+Ul/+PlJf/jpSX/4+Vl/+PlZf/jpSX/4+UmP+OlJj/j5KR/36XxP9GbMX/Rl+a/2CKx/9mldf/bp/g/3el5f9+qef/gqvm/4Co4v94n9r/d5nV/3mb1v9+n9j/hKje/4Op4/+Dq+n/g6vr/4mu7f+Mr+7/eqTp/2uc5v92puv/gq7t/4Kr6v94oOP/Y4zV/1d6w/9Na7H/R2Ki/z1Vjv8xSX3/Nk+H/0Nfn/9UdLj/YYTI/2GHz/9ehMz/YIXK/2KHyv9ihsr/Y4jL/2iNzv9pjs7/ZYrN/2OIyv9dgsT/Vnm8/01tsP9FYp7/PViN/zVNfv8xSHT/LkNr/yo9Yv8oOlr/JTRS/yQyT/8fLkv/Hi5K/yEwTf8ZKET/HzBQ/x0tT/8WI0D/Bgsf/wUKH/8HDST/BQsj/woWO/8dL13/eH6F/46Tlf+Jj5P/ipCT/4qRk/+LkJP/ipCT/4qQkv+JkJL/io+S/4mPkv+Jj5L/iY+R/4iOkf+IjpH/iI6R/4iOkP+IjpD/h42Q/4eNj/+HjI//h4yO/4eMjv+Gi47/houN/4aKjf+Fioz/hYqM/4WKi/+FiYv/hImK/4SIiv+EiIn/hIeJ/4OHif+Dhoj/goaI/4KGiP+ChYf/gYWH/4GFhv+AhIb/gISF/3+Dhf9/g4T/foKD/36Cg/99gYL/fYGC/3yAgf98gIH/e3+A/3t/gP97f3//en5//3p+fv95fX3/eX19/3h8fP94e3v/h4mK/4eJiv+Hior/h4qL/4eKi/+Hiov/iIqL/4iLjP+Ii4z/iIuM/4iMjP+IjI3/iYyN/4mNjf+JjY7/io2O/4qNj/+KjY//io6P/4uOkP+LjpD/i4+Q/4uPkP+Lj5H/jI+R/4yQkf+MkJH/jJCS/4yQkv+NkJL/jZGS/42Rk/+NkZP/jZGT/42Rk/+NkpT/jZKU/42SlP+Ok5T/jpOV/46Tlf+Ok5X/jpOW/46Tlv+PlJb/j5SW/4+Ul/+OlJf/j5SX/46Ul/+OlZf/j5WX/4+Ul/+OlJf/jpSX/42Slf9tj9D/MFGs/0demf9gicT/YZDS/2WU2P9wnd7/c5/d/2yV0/9ehcP/Vnu8/1Bxsv9Maab/S2We/1Rsov9kfa//co/C/3eb2P94o+b/fajr/4Kr6/9wn+b/baHo/32s7v+HsO7/e6Tm/2iR1/9ZfMX/TWqw/0Jcmv80S4L/Mkl//z5Xk/9NbK7/V3zB/1d8wf9ZfsD/XX/A/2CAvv9hf7n/XHm0/1Vzrv9Vcq7/VXOv/1V1tP9Yebr/Vni5/1JztP9La6r/Q2Gc/zxXjv83T4L/Mkh2/yxCa/8pPWH/JzdX/yU0Uf8iMEz/HS1J/x4uTP8dLUv/FCM9/x4uS/8iM1P/Dxcu/wMHGP8HDSP/CA4n/wYMJv8KEjT/FSda/2JqfP+QlZb/iY+S/4qQk/+KkZP/i5GU/4uRlP+KkJP/ipCS/4mPkv+Jj5L/iY+S/4mPkf+IjpH/iI6R/4iOkf+IjpD/iI6Q/4eNkP+HjY//h4yP/4eMjv+HjI7/houN/4aLjf+Gio3/hoqM/4WKjP+Fiov/hYmL/4SJiv+EiYr/hIiK/4SIif+Dh4n/g4eI/4OGiP+Choj/goaH/4GFh/+BhYb/gISG/4CEhf9/g4X/f4OE/36Cg/9+goP/fYGC/32Bgv98gIH/fICB/3x/gP97f4D/e35//3p+fv96fn7/eX19/3l9ff94fHz/eHt7/4eJiv+HiYr/h4qK/4eKi/+Hiov/h4qL/4iKi/+Ii4z/iIuM/4iLjP+Ii4z/iIyN/4mMjf+JjI3/iY2O/4mNjv+KjY//io6P/4qOj/+Kjo//i46Q/4uPkP+Lj5D/i4+Q/4uPkf+MkJH/jJCR/4yQkf+MkJL/jJCS/42Rkv+NkZP/jZGT/42Rk/+NkZP/jZKT/42SlP+NkpT/jpKU/46TlP+Ok5X/jpOV/46Tlf+Ok5b/j5SW/4+Ulv+PlJb/j5SX/4+Ul/+PlJf/jpSX/46Ul/+OlJf/jpSX/4+Ulf+Jk5//XYXV/yE7lf9OZZ7/YYnD/2KQ0v9hkNT/Y5DT/2WPz/9mjsv/X4fF/1V8vf9SeLr/S26u/0Bfnv86V5P/MkuF/zdNhP9NZJf/YoC4/22W1/9zouX/dKPm/26g5/94qO3/iLHv/4Or6f9rlNn/WHvE/0llqP85Uoz/MEd9/zRMg/9AW5b/R2an/0Zppv9Sbqb/XHSo/1Zwo/9IYJP/PlWE/zJJeP8rQnH/K0Bu/y5BbP80SHT/PFOF/0Fdk/9FZJ3/QF6Y/z1bk/86Voz/NU2A/zBHdf8sQWn/Kj1h/yU2V/8jM1D/Hi1J/x0tSv8cLUv/GipH/xMhOv8dLkv/GypJ/wcMHv8GDCH/ChQv/wsVMv8HDyv/Bw8u/xEjVP9CT2z/jZKS/4iPkv+Jj5L/ipCS/4iPkf+IjpH/iY+R/4qQkv+Kj5L/iY+S/4mPkf+Jj5H/iI6R/4iOkf+IjpH/iI6Q/4eOkP+HjY//h42P/4eNj/+HjI7/h4yO/4aLjf+Gi43/houN/4aKjP+Fioz/hYmL/4WJi/+EiYr/hIiK/4SIiv+DiIn/g4eJ/4OHiP+Choj/goaI/4KGh/+BhYf/gYWG/4CEhv+AhIX/f4OF/36DhP9+goP/foKD/32Bgv99gYL/fICB/3yAgf97f4D/e3+A/3t/f/96fn//en5+/3l9ff95fH3/eHx8/3h7e/+HiYr/h4mK/4eKiv+Hiov/h4qL/4eKi/+Iiov/iIuM/4iLjP+Ii4z/iIyM/4iMjf+JjI3/iY2N/4mNjv+JjY7/io2O/4qNj/+Kjo//io6P/4qOj/+LjpD/i4+Q/4uPkP+Lj5H/jJCR/4yQkf+MkJL/jJGS/4yQkv+NkZL/jZGT/42Rk/+NkZP/jZGT/42Sk/+NkpT/jZKU/42SlP+Ok5T/jpOV/46Ulf+Ok5X/jpOV/46Tlv+OlJb/j5OW/4+Ulv+OlJf/j5SX/4+Vl/+OlZf/jpSX/46VmP+PlJP/iZap/1V90v8aMYb/TmSe/1+GwP9dicr/WIDA/1mCwf9chsf/W4XI/2qT0f98otv/iave/4am1v95lsj/ZIG3/0djnv9AWZD/Rl+T/1Zxp/9xkMn/bJbX/22e4f9wouf/caPr/4ez8P+Lsuz/cZnb/1l8xP9CXJz/M0uA/zNLfv80TIH/N1CF/zhQhP9JXo//Wm+e/1Fomf9EW43/PFOG/zNMf/8sR3z/J0B1/yE3Z/8aLlb/GilM/x8wU/8nPmn/L0t7/zNPgf8zTn//MUx+/y5IeP8rQ2//K0Fp/yk9Yf8mN1f/IC9M/xwsSf8dLUr/GytJ/xcnQv8PHDH/GytI/xYmRP8EChv/BhAo/w8fQP8QIEH/CxY3/wYOLf8RHkz/Kjlg/36Dhv+Jj5H/iY+R/4iOkP+HjY//iI+Q/4iOkP+Ij5H/ipCS/4mPkv+Jj5H/iI+R/4iOkf+IjpH/iI6R/4iOkP+HjpD/h42P/4eNj/+HjY//h42O/4eMjv+Gi43/houN/4aKjP+Gioz/hYqM/4WKi/+FiYv/hImK/4SJiv+EiYr/g4iJ/4OHif+Dh4j/goeI/4KGiP+ChYf/gYWH/4GFhv+AhIb/gISF/3+Ehf9+g4T/foKD/36Cg/99gYL/fYGC/3yAgf98gIH/e3+A/3t/gP97fn//en5+/3p9fv95fX3/eX19/3h8fP94e3z/homK/4eJiv+HiYr/h4qL/4eKi/+Hiov/h4qL/4iKi/+Ii4z/iIuM/4iLjP+IjI3/iIyN/4mMjf+JjI3/iY2O/4qNjv+KjY//io6P/4qOj/+Kjo//i46Q/4uPkP+Lj5D/i4+R/4yQkf+MkJH/jJCR/4yQkv+MkJL/jZGS/42Rkv+NkZP/jZGT/42Rk/+NkZP/jZKU/42SlP+NkpT/jZKU/46TlP+Ok5T/jpOV/46Tlf+Ok5X/jpOW/46Ulv+OlJb/jpSW/4+Ul/+OlJf/jpSX/46Ul/+NlJf/j5SS/4iXrP9Mc8j/Fi2A/0tfm/9hhbz/Yo7L/051tP9CX5T/Ql6P/1Fzrf9sjcT/cI7A/2eBsf9uiLf/cIiz/1xznv9HXIv/P1aH/z9Yjv9TbqH/Yn+w/2+Vz/9pldj/cKHm/3Kj6f+MtvH/mbzv/3Wc2/9VeL3/QFqU/zRLfP8xSHf/LENx/yU8av81THv/UmiX/2iBtf9shbf/cIi5/2qEuP9he6//Wnar/0llm/86VYn/Mkl4/ys/aP8lN1v/HzBS/x8vUf8kOWD/KUJu/ypFdP8qRXX/KUFt/yk/Z/8oO1//JDZU/x0tSf8cLEn/HCxI/xgoRP8TIDj/CxUl/xspRf8cLEv/DRgx/w4cO/8aLVH/FCVK/w4bPf8FDSv/EBxF/x0uW/9lbHb/ipCR/4eOkP+IjZD/ipCS/4qQkv+Jj5H/iI6Q/4mPkv+Jj5L/iY+R/4mPkf+IjpH/iI6R/4iOkP+IjpD/iI2Q/4eNj/+HjY//h4yO/4aMjv+HjI7/houN/4aLjf+Gioz/hoqM/4WKjP+FiYv/hYmL/4SJiv+EiIr/hIiK/4OIif+Dh4j/g4eI/4KGiP+Chof/goaH/4GFh/+BhYb/gISG/4CEhf9/g4X/foOE/36Cg/9+goP/fYGC/32Bgf98gIH/fICB/3uAgP97f4D/e39//3p+f/96fn7/eX19/3l9ff94fHz/eHt7/4aJiv+HiYr/h4mK/4eKiv+Hiov/h4qL/4eKi/+Hiov/iIuM/4iLjP+Ii4z/iIyM/4iMjf+JjY3/iY2N/4mNjv+Jjo7/io6O/4qNj/+Kjo//io6P/4qOkP+LjpD/i4+Q/4uPkf+Lj5H/jJCR/4yR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kP+IjpD/iI2Q/4iNkP+HjY//h42P/4eMjv+HjY7/h4yO/4aLjf+Gi43/houM/4WKjP+Fioz/hYmL/4WJi/+EiYr/hIiK/4SIif+DiIn/g4iJ/4KHiP+Choj/gYeH/4GGh/+BhYf/gIWG/4CEhv9/hIX/f4OE/36ChP9+goP/fYGD/32Bgv98gYH/fICB/3yAgP97f4D/e39//3t/f/96fn7/en1+/3l9ff95fX3/eXx8/3h7e/+GiYn/homK/4eJiv+HiYr/h4qK/4eKiv+Hiov/h4qL/4eKi/+Iioz/iIuM/4iLjP+Ii4z/iIyN/4iMjf+JjI7/iY2O/4mNjv+JjY7/io2O/4qOj/+Kjo//io6Q/4uOkP+Lj5D/i4+Q/4uPkf+Lj5H/jJCR/4yQkv+MkJL/jJGS/4yRkv+MkZP/jZGT/42Rk/+NkZP/jZGU/42SlP+NkpT/jZKU/42SlP+Nk5X/jpOV/46Tlf+Ok5X/jpOV/46Tlf+Ok5X/jpOW/46Tlf+NkpX/jZKV/4ySlf+KkJT/h42P/2Nziv9GZKr/Nkdw/0Zcfv9bfrf/YIK8/2GDvP9gg7//W367/1x/vP9UdbL/R2ej/z5ak/85VYv/Mk2B/y1Iff8wSn//N1GI/z5ak/9EYp3/TW6s/1V3uP9Xerv/XIDB/1p9vf9TdLL/TGun/0Vhm/86VIz/Lkh6/yU7Z/8dMVj/FidL/xIjRv8WKU7/FixS/xEjRP8uQGP/Rlh8/1VniP9PYoT/NUls/yg6XP8jN1j/Gy9R/xcrTf8fNFv/Jz1p/yc8Zf8nOmD/KDpf/yk8X/8nO13/JTlZ/yM2Vf8bK0f/GypG/xwqRv8ZKEP/Eh4x/wsRHP8IDBL/CAwT/w0UIP8MFCj/Dxw7/xgoTf8fL1L/ER07/wcOKP8OGT//HjBd/yEmLP8lKCr/W2Bj/4aLjf+HjI7/iY+R/4mPkf+Jj5H/iY+R/4mOkP+IjpD/iI6Q/4iOkP+IjpD/iI2Q/4iNkP+IjY//h42P/4eMj/+HjI7/h4yO/4aMjf+Gi43/houM/4aKjP+Fioz/hYqL/4WJi/+FiYr/hIiK/4SIiv+EiIn/g4eJ/4OHif+Ch4j/goaI/4KGh/+Bhof/gYWG/4CFhv+AhIX/f4OF/3+DhP9+goT/foKD/32Bg/99gYL/fICB/3yAgf98gID/e3+A/3t/f/96fn//en5+/3p9fv95fX3/eX19/3h8fP94e3v/hoiJ/4aJif+GiYr/h4mK/4eJiv+Hior/h4qK/4eKi/+Hiov/h4qL/4iKi/+Ii4z/iIuM/4iLjf+IjI3/iIyN/4mNjv+JjY7/iY2O/4qNj/+KjY//io6P/4qOkP+LjpD/i4+Q/4uPkP+Lj5H/i4+R/4yQkf+MkJL/jJCS/4yRkv+MkZL/jJGT/4yRk/+NkZP/jZGT/42Rk/+NkZT/jZKU/42SlP+NkpT/jZKV/42Tlf+Nk5T/jpOV/42TlP+Ok5X/jpOV/42Slv+OkpX/jZKV/4ySlf+Kj5H/ipCT/2txdf9DR0r/NTtC/yctNv9FW33/TGWP/1Zyov9nhLX/a4m8/2aHwP9ggrz/WXm0/1V1sP9Rbqb/Smef/0Jfmf8+W5X/PlqS/z9Yjv9HYZX/S2id/1Rzrv9fgL3/YYTD/2KGxf9egcH/WHm6/1JwsP9Maqf/Q16Y/ztVif8vRXT/JTpj/x0vU/8XKE3/FCdN/xgtVf8dM1z/Gi5V/yA0W/8xRXD/O1B+/zRNff8tRXP/JTtm/yU8Zv8qQXD/K0Fw/ypAa/8rPmb/LD5i/ys8Xf8oOFb/IjFL/yExTf8dL0z/GytG/xwrSP8cKkb/GShC/xIdMP8KEBr/BwsT/wgME/8KDRT/BgoR/wQKGv8KFTP/FydL/xglSP8UIUH/HzJf/xklQf8XGBn/Gh0f/09TVP9+goP/h4uO/4iNkP+Jj5H/iY6R/4mPkf+Jj5D/iI6Q/4iOkP+IjpD/iI2Q/4iNkP+IjY//iI2P/4eMj/+HjI//h4yO/4eMjv+GjI3/houN/4aLjf+Fioz/hYqL/4WKi/+FiYv/hYmL/4SIiv+EiIr/hIiJ/4OHif+Dh4n/goeI/4KGiP+Chof/gYaH/4GFhv+AhYb/gISF/3+Dhf9/g4T/foKE/36Cg/99gYL/fYGC/3yAgv98gIH/e4CA/3t/gP97f3//e35//3p+fv96fX7/eX19/3l8ff94fHz/eHt7/4aIif+GiYn/homK/4aJiv+HiYr/h4qK/4eKiv+Hiov/h4qL/4eKi/+Iiov/iIuM/4iLjP+Ii43/iIyN/4iMjf+JjY7/iY2O/4mNjv+JjY7/io6P/4qOj/+KjpD/i46Q/4uPkP+Lj5D/i4+R/4uPkf+LkJH/jJCS/4yQkv+MkJL/jJGS/4yRkv+NkZP/jZGT/42Rk/+NkZP/jZKU/42SlP+NkpT/jZKU/42SlP+NkpT/jZKU/42SlP+NkpX/jZKV/46Tlf+Ok5X/jpKV/42RlP+LkJP/h42Q/3h+gf9XW17/HSEk/xsfIv8cISj/Qld5/0xkiv9IXYL/QlR2/0xfg/9bc57/XXak/1dwoP9NaJj/SGCR/0Fai/8+WIr/O1OD/z1VgP9FXIT/RlyE/0tllP9Zd7D/ZYbC/2yPzP9sj87/ao3N/2OFxv9bfb3/WXq4/1Nxrf9IY5z/PlWG/zFFbf8nOFz/HzJU/xotT/8ZK1D/GC1S/yA1Xv8qQm//Mkt8/zdRhP84VIf/OFSI/zZQg/8zSnr/M0p3/zJIc/8xRnD/LUBl/yw8W/8iMEv/GSU7/xsnP/8fLUn/HCxI/xwrSP8cK0n/GypG/xkoQ/8UIDT/CxId/wgMFP8HChH/BwsR/wcKEP8CAwX/AwUQ/woSK/8SH0L/GitT/xUjQ/8JCg//ERIS/wgJCv8fICH/WFpc/4aLjf+IjpD/iY+R/4mOkP+JjpD/iY+Q/4iOkP+IjZD/iI2P/4iNkP+IjY//iI2P/4iNj/+HjY//h4yP/4eMjv+HjI7/houN/4aLjf+Gioz/hYqM/4WKi/+FiYv/hYmL/4WJi/+EiIr/hIiK/4SIif+Dh4n/g4eJ/4KHiP+Choj/goaH/4GGh/+BhYb/gISG/4CEhf9/g4X/f4OE/36ChP9+goP/fYGD/32Bgv98gIH/fICB/3t/gP97f4D/e39//3p+f/96fn7/en1+/3l9ff95fH3/eHx8/3h7e/+GiIn/hoiJ/4aJif+GiYr/h4mK/4eJiv+HiYr/h4qK/4eKi/+Hiov/iIqL/4iLjP+Iioz/iIuM/4iLjf+IjI3/iYyO/4mNjv+JjY7/iY2O/4qNj/+Kjo//io6P/4qOkP+LjpD/i46Q/4uPkf+Lj5H/i4+R/4yQkf+MkJL/jJCS/4yQkv+MkZL/jJGT/42Rk/+NkZP/jZGT/42RlP+NkZT/jZGU/42RlP+NkpT/jZKU/42SlP+NkpT/jZKV/42SlP+NkpT/jZKV/46SlP+NkZT/io+S/2lucv8fIyb/ICIm/xgbHv8UFxn/HSMs/0hfhv9LZIv/UGiM/0xefv8xPVb/N0Nb/ztGXv8yPVT/LjhP/yg0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jv+HjI7/h4yO/4eLjv+Hi47/hoqN/4aLjf+Gioz/hYqM/4WKi/+FiYv/hYmL/4SJiv+EiIr/hIiJ/4OHif+Dhon/g4aI/4KGiP+ChYj/gYaH/4GFh/+AhYb/gISG/4CEhf9/g4T/foOE/36Cg/99gYP/fYGC/32Agv98gIH/fICB/3t/gP97f4D/e39//3p+f/96fn7/eX1+/3l9ff95fHz/eHt8/3h7e/+GiIn/hoiJ/4aIif+GiYn/homK/4aJiv+HiYr/h4mK/4eKiv+Hiov/h4qL/4eKi/+Ii4z/iIuM/4iLjP+Ii43/iYyN/4mMjv+JjI7/iY2O/4mNjv+KjY//io6P/4qOj/+KjpD/i46Q/4uPkP+Lj5H/i4+R/4uPkf+Lj5H/jJCS/4yQkv+MkJL/jJCS/4yRkv+MkZP/jJGT/4yRk/+MkZP/jJGT/42RlP+NkZP/jJGT/4yRlP+MkZP/jJGT/4uRk/+KkJL/jZKU/4SJiv9lam3/Y2ls/0BER/8aHSD/Dg8S/wwOEf8ICQn/HiUx/1Bto/9hg73/bpLL/195o/9keJn/an6d/19uif9VYXr/UFty/01Ybv9RXHP/UmB7/1Vkg/9wgqf/g5nC/4yo1f+UseP/nbjn/6G76v+Ytef/mrfo/5q35/+Ws+X/k7Dj/5Ox5f+Hp+H/eJnW/3GQy/9uibz/WW+a/0hXeP83QFX/KC06/x8kLf8aHST/GBsj/w8SGP8LDhT/Cw4U/w4SGf8QFSH/GSQ1/xgiM/8TGyv/FB0u/x8sRf8eL0v/IC9M/x4tS/8cK0n/Hi1K/x8sS/8dLEn/Hy1M/x4sS/8dLEr/GCdA/w8ZKf8IDBX/BQkO/wMGCf8DBAf/AwID/wICA/8CAgL/AQAC/wEAAf8BAAH/AQEB/wEBAf8CAwP/AAAA/yMjJP9rbnD/b3J1/4OHif+JjZD/iIyP/4iMj/+IjY//iI2P/4iNj/+HjY7/iIyP/4eMjv+HjI7/h4yO/4eMjv+Hi47/houN/4aLjf+Gio3/hoqM/4WKjP+FiYv/hYmL/4SJiv+EiIr/hIiK/4SIif+Dh4n/g4eJ/4OGiP+Choj/goaI/4GFh/+BhYf/gYWG/4CEhf9/hIX/f4OE/36DhP9+goP/fYGD/32Bgv99gIL/fICB/3yAgf97f4D/e3+A/3p+f/96fn//en1+/3l9fv95fX3/eXx8/3h7fP94e3v/hoiJ/4aIif+GiIn/homJ/4aJiv+GiYr/h4mK/4eJiv+Hior/h4qL/4eKi/+Hiov/h4qM/4iKjP+Ii4z/iIuN/4mMjf+JjI7/iYyO/4mNjv+JjY7/iY2P/4qOj/+Kjo//io6P/4uOkP+Lj5D/i46R/4uPkf+Lj5H/i4+R/4uQkv+MkJL/jJCS/4yQkv+MkZL/jJGT/4yRk/+MkZP/jZGT/4yRk/+MkJP/jJGT/4yRk/+MkZP/jJGT/4yRk/+LkJL/h4yO/4eMjv9+g4X/NTo//0lNUf8jJyr/BwkN/wsMD/8KDA7/DAwO/yQsO/9PbaP/W325/2ySz/9wltD/bo/D/3SUxP97mcj/hp/K/4GYwf+Gmr//iJ3D/4Wcw/+Npc//nLTf/6C65P+euuf/ob3o/6C96/+hvOz/nbrq/5256v+Ztuj/mLXm/5az5P+Ztuf/ka/l/4am3/+AoNj/epjO/3KOwf9geKn/UGSK/0NQbP84Q1v/MDtQ/yUuQf8hKTr/HSY1/yIqO/8gKTr/Hig4/xwmOf8WHzH/Fh8w/x4qQf8mN1f/IzZZ/yAyUv8cK0n/HixL/x8tS/8fLUv/Hi1M/x8tS/8eLEr/Hy1L/xgnP/8NFiT/Bw0U/wUIDv8DBQj/AgQG/wICA/8CAQL/AQEC/wAAAf8BAAH/AQAB/wEBAv8BAQH/AgMD/wUGBv8tLS7/Tk9R/2ZpbP+Dh4n/hIiL/4iMj/+HjI//h42P/4iNj/+IjY//iI2O/4eMjv+HjI7/h4yO/4eMjv+HjI7/h4uO/4eKjf+Gi43/hoqM/4aKjP+Fioz/hYmL/4WJi/+EiYr/hIiK/4SIiv+EiIn/g4eJ/4OHif+Choj/goaI/4KGh/+ChYf/gYWG/4CFhv+AhIb/f4SF/3+DhP9+g4T/foKD/32Bg/99gYL/fICC/3yAgf98f4H/e3+A/3t/gP97fn//en5+/3p9fv95fX3/eX19/3l8fP94e3z/eHt7/4aIiP+GiIn/hoiJ/4aIif+GiYn/homK/4aJiv+HiYr/h4mK/4eKiv+Hiov/h4qL/4eKi/+Ii4z/iIqM/4iLjf+IjI3/iYyN/4mMjv+JjY7/iY2O/4mNjv+KjY//io6P/4qOj/+KjpD/io6Q/4uOkP+Lj5H/i46R/4uPkf+Lj5H/i5CS/4uQ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jP+Gi4z/hoqM/4aKjP+FiYv/hYmL/4SJi/+EiIr/hIiK/4SIif+DiIn/g4eJ/4KHiP+Choj/goaH/4KGh/+BhYf/gYWG/4GFhv+AhIb/f4SF/3+Dhf9+g4T/foOD/32Cg/99gYL/fYGC/3yAgf98gIH/fH+A/3t/gP97f3//en5//3p9fv95fX3/eX19/3l8fP94e3v/eHt7/3d6ev+Fh4j/hoeI/4aIiP+GiIn/hoiJ/4aIif+GiIn/homJ/4aJiv+HiYr/h4mK/4eKiv+Hiov/h4qL/4iLjP+Ii4z/iIuM/4iLjf+IjI3/iYyN/4mMjf+JjI7/iY2O/4mNjv+Jjo//io6P/4qOj/+Kjo//io+Q/4qPkP+Kj5D/i4+R/4uPkf+Lj5H/i4+R/4uQkf+LkJL/i5CS/4uQkv+LkJL/i5CS/4uQkf+LkJH/i5CR/4uQkf+Lj5H/iY2P/4SIiv90eXz/KS0w/xMWGv8RFBj/DxMX/wgLDv8MDhD/Cw0P/wkNEP8YHB//Hyg4/z9bjv9Webn/VXu//1yHzf9lj9L/b5bW/3ic2P9+odv/g6bf/4ep4f+Nr+X/jrDn/5Gz6f+Wtuv/mLfr/5q47P+auev/nLrr/5u56f+Xtuf/kbHl/4qs4/+Dpt//fZ/Z/3ma1v9ylNH/bI3M/2SHx/9gg8X/XYHE/1l8v/9Xer7/VHe6/01vsf9Iaqr/QGGg/zlXk/82UYv/NEyE/y9Hfv8vR3z/LER4/ypCdf8pP2//JTpl/yI2W/8fMlP/Hi9O/x8wUP8fME//IDBQ/x8wT/8eLUv/FiI6/w8ZKf8JDxr/CA4W/wQJDP8DBwn/AgQE/wEBAf8BAQH/AQEB/wEAAP8BAAD/AQEB/wEAAP8BAAD/AQEB/wECAv8CAwP/BQUF/wcICP8FBgb/CwwM/ygpKf9qbW//goWH/4mMjv+IjI7/hYmL/4eLjf+IjY7/hYmL/4eMjf+HjI3/houN/4aLjf+Gi4z/houM/4aKjP+Fioz/hYmL/4WJi/+FiYv/hIiK/4SIiv+DiIn/g4iJ/4OHif+Ch4j/goeI/4KGh/+Chof/gYaH/4GFhv+AhYb/gISF/4CEhf9/g4T/foOE/36Cg/99goP/fYKC/32Bgv98gYH/fICB/3t/gP97f4D/e35//3p+f/96fX7/eX1+/3l8ff95fHz/eHt8/3h7e/94env/hYeH/4aHiP+Gh4j/hoiI/4aIif+GiIn/hoiJ/4aIif+GiYn/h4mK/4eJiv+Hior/h4qL/4eKi/+Hiov/h4uL/4iLjP+Ii4z/iIuN/4iMjf+JjI3/iYyO/4mNjv+JjY7/iY2O/4mNj/+Kjo//iY6P/4qOj/+KjpD/io6Q/4qPkP+Lj5D/i4+R/4uPkf+Lj5H/i5CR/4uQkf+LkJH/i5CR/4uQkf+LkJH/i5CR/4uPkf+Jjo//i4+R/4aLjf+Ch4n/SE1R/xYaIP8PEhb/BggJ/wkMDv8JDA//DA4R/woNDv8NERP/Fhkc/yMrPP9CXY7/U3W1/1h7v/9ch83/Z5HU/3KZ1/96ntn/faDa/4Om3v+JquL/jq7k/5Sy5/+Ts+f/lrXp/5q46v+ZuOr/mbjq/5256v+buOn/lbTm/5Gx5P+Lq+L/gaPd/3ib1/90ltL/aozJ/2aHxf9ggcD/XH29/1l7vP9XeLr/U3a3/09xs/9HZ6n/QWCh/z1bmv83VZH/MUyG/zBJgP8tRnz/LER5/ypCdv8pQXP/KD1t/yY7Zv8jN13/IDFT/x8vT/8fMFD/Hy9P/yAwT/8eLk3/FyZB/xAcMf8MFCT/CA4X/wYLEf8DBgv/AgQF/wECAv8BAQH/AQEB/wAAAf8AAAH/AQEB/wIBAv8DAgP/AgIC/wEBAv8BAQL/AgID/wQEBf8EBQb/BAUF/wsMDP8DAwP/QURF/3p9f/+Giov/io6P/4iLjf+EiYv/hYqM/4WJi/+HjI7/houN/4aLjP+Gi4z/hoqM/4aKjP+Gioz/hYqL/4WJi/+FiYv/hImK/4SIiv+EiIn/g4iJ/4OHif+Dh4j/goeI/4KGiP+Chof/gYaH/4GFh/+BhYb/gYSG/4CEhf9/hIX/f4OE/36DhP9+goP/fYKD/32Bgv99gYH/fICB/3yAgP97f4D/e39//3t+f/96fn7/en1+/3l9ff95fH3/eXx8/3h7fP94e3v/eHp6/4WHh/+Fh4j/hoeI/4aIiP+GiIj/hoiJ/4aIif+GiIn/homJ/4aJiv+GiYr/h4mK/4eKiv+Hiov/h4qL/4eLi/+Ii4z/iIuM/4iLjP+Ii43/iIyN/4iMjf+IjI7/iYyO/4mNjv+Jjo//iY6P/4qOjv+Kjo//io6P/4qOkP+Kj5D/i4+Q/4uPkf+Lj5H/i4+R/4uPkf+LkJH/i5CR/4uQkf+LkJH/i5CR/4uQkf+Kj5H/iIyN/4aLjP+IjY//cHV4/zE3PP8zOD3/EhUY/xMWGv8KDRH/CQsM/wwPEf8MDxL/DA4Q/xETFf8iKjn/QVuI/1FztP9Ver7/XojN/2qT1f9ymdj/d5zY/3yg2/+Cpd3/h6rh/4yt4/+RseX/k7Ln/5i26P+VtOj/mrfp/5m36P+Ytuj/l7Xm/5Gx5f+NruP/i6zh/4Gi2/92mdb/bpHQ/2mLyP9jhMH/Xn6+/1x8vP9be7r/Vne3/1Bwsv9La63/RWSl/z5dm/86WJX/NlOP/zFNh/8vSoL/Lkh//ytDef8rQnX/KkBx/yg+bP8mPGf/ITZb/yAyVP8fMFH/HzBQ/x8vTv8eLk3/GShE/xMhOP8LFCT/CA0X/wcME/8FCA7/AgUH/wEDA/8BAQH/AQEB/wAAAP8AAQD/AgMD/wMDA/8EBAT/BAQF/wICAv8CAgP/AgED/wICAv8DBAT/AwQE/wgICf8MDQ7/AAAA/y4wMf97gIH/gISF/4aKi/+IjI7/h4uN/4WJi/+Hi43/h4uN/4aLjP+Gi4z/houM/4aLjP+Gi4z/hoqL/4WKi/+FiYv/hYmL/4SJiv+EiIr/hIiK/4OIif+Dh4n/g4eI/4KHiP+Ch4j/goaH/4GGh/+Bhob/gYWG/4CEhv+AhIX/f4OF/3+DhP9+goT/foKD/32Cgv99gYL/fIGB/3yAgf98gID/e3+A/3t/f/96fn//en5+/3p9fv95fX3/eXx9/3l8fP95e3z/eHt7/3h7ev+Fhof/hYeH/4WHiP+Fh4j/hoiI/4aIiP+GiIj/hoiJ/4aIif+GiYn/homK/4aJiv+HiYr/h4qK/4eKi/+Hiov/h4uL/4eLjP+Ii4z/iIuN/4iMjf+IjI3/iIyN/4iMjf+JjY7/iY2O/4mNjv+Jjo//io+P/4qOj/+Kjo//io+Q/4qPkP+Kj5D/io+Q/4uPkf+Lj5H/i4+R/4uPkf+LkJH/i5CR/4uQkf+KkJH/io+Q/4qPkP+Gi43/gYWH/290d/8lKy//HiMo/wsOEP8PEhb/CQwR/wsOEP8MDhH/Cg0P/wkMDv8RExX/GyIr/z5VfP9RdLX/U3i7/2GJzP9pktT/cZjX/3me2v95ntr/gKXd/4Km3/+KrOP/j6/k/5W05/+at+j/mbbo/5i16P+Ztuj/lLPn/5Kx5f+QsOT/i6zi/4ip3/99oNr/d5vW/2uPzf9nicf/X4G//15+u/9be7n/WHi3/1R0tf9ObrH/Rmap/0Njo/88W5r/N1WS/zRRjP8xTof/LkqC/y5JgP8sRXr/LEN2/ytBcf8pPm3/JTxm/yI2XP8gMVT/Hi9P/x8wT/8dLUv/GyxI/xYlPv8PGy//CA8Z/wcLE/8GCRD/BAcL/wEEBP8BAgL/AQEB/wEBAf8AAQD/AgMC/wECAf8EBQT/BAUE/wQEBf8CAwP/AQIC/wICAv8CAgL/AgMD/wECAv8GBwf/CgsL/wgKCf9AREX/eX5//4CFhf+Hi4z/iIyN/4eLjf+Hi43/h4uN/4aLjf+Gi4z/hoqM/4aKjP+Gioz/hYuL/4WKi/+Fiov/hYmL/4WJiv+EiIr/hIiK/4SIif+DiIn/g4eJ/4KHiP+Ch4j/goeH/4GGh/+Bhof/gYaG/4CFhv+AhIb/gISF/3+Dhf9/g4T/foKE/36Cg/99gYL/fYGC/3yBgf98gIH/fICA/3t/gP97f3//en5//3p+fv96fX7/eX19/3l8ff95fHz/eXt7/3h7e/94e3r/hYaH/4WHh/+Fh4f/hYeI/4aHiP+GiIj/hoiI/4aIif+GiIn/hoiJ/4aJif+GiYr/homK/4eJiv+Hiov/h4qL/4eLi/+Hi4z/h4uM/4iLjP+Ii43/iIuN/4iMjf+IjI3/iYyO/4mNjv+JjY7/iY6O/4mOj/+Jjo//io6P/4qOkP+KjpD/io+Q/4qPkP+Kj5H/i4+R/4qPkf+Kj5H/i4+R/4qQkf+LkJH/ipCQ/4qPkP+JjpD/io+Q/4CEhv9rcHT/OkBF/yInLf8XHCH/EhYZ/w0PFP8RFRr/Cw4R/wgKDP8KDQ7/CwwO/xgcI/88UnX/U3a0/1R4uf9hiMr/apLT/2+W1f92nNn/e6Dc/36k3v+EqOH/i67l/5Cy5v+Xtuj/m7fp/5256f+duer/mLbo/5a05/+Us+f/kLDk/4+v4/+KquH/gaPc/3ea1v9tkc//ZYfG/2CBwP9bfLv/W3u5/1Z1tf9UdLT/Tm6w/0ZmqP9AX6D/O1qY/zZTj/8zUIr/MU2G/y9Kg/8uSID/Lkd8/yxCdv8rQXP/KkBv/yU7Zf8iNVv/HzFT/x4vUP8dL07/GyxJ/xkpRP8RHzX/ChQk/wkOF/8IDRT/BQkN/wQHCf8DAwT/AQEC/wAAAf8BAQH/AgMC/wIDA/8CAwL/BAUF/wcICP8DBAT/AwME/wMDBP8CAgP/AQEB/wMDA/8DBAT/BwgI/w0ODv8lJyf/XGFi/3yAgf+IjI3/iIyN/4eLjf+Hi43/houM/4aLjf+Gioz/hoqM/4aKjP+Gioz/hYqL/4WKi/+Fiov/hYqK/4WJi/+EiYr/hIiK/4SIiv+DiIn/g4eJ/4OHif+Ch4j/goeI/4KGh/+Bhof/gYaG/4GFhv+AhYb/gISF/4CEhf9/g4X/f4OE/36Cg/99goP/fYGC/32Bgv98gIH/fICB/3t/gP97f3//e39//3p+fv96fn7/en19/3l9ff95fH3/eXx8/3h7e/94env/d3p6/4WGh/+Fh4f/hYeH/4WHiP+Fh4j/hYeI/4aIiP+GiIj/hoiJ/4aIif+GiYn/homJ/4aJiv+GiYr/h4qK/4eKi/+Hiov/h4uL/4eLjP+Hi4z/iIuM/4iLjf+Ii43/iIyN/4iMjv+JjI7/iY2O/4mOjv+Jjo7/iY6P/4qOj/+Kjo//io6Q/4qPkP+Kj5D/io+Q/4qPkP+Kj5D/io+R/4qPkf+Kj5H/ipCR/4qPkP+KkJH/ipCR/4WKi/+Ch4j/dXp8/zI2O/8eIyn/HSIo/x0iKP8TFhr/DhIW/wwQEv8NEBP/BggK/wgJCv8ZHSP/Ok1t/1FzsP9UeLn/X4XG/2mR0v9vltb/cZfX/3ac2v96od7/gafh/4uu5f+Rsuj/mrjr/5266/+euer/nrrq/5m36v+Xtuj/lLPm/5Ky5v+Or+T/h6jg/4Ok3f97ntj/cJPR/2WIyP9ihcP/X3++/1x9vf9Zerr/VXW2/05usf9HZ6v/Pl+g/zpZmf83VJH/Mk+J/zFOh/8xTYb/L0qC/y5HfP8sRHf/K0J0/ypBcP8lOmX/ITRb/x4wVP8cLk//HC1N/xorSf8WJj//Dhou/wwVIv8KEBj/CQ4S/wgLD/8CBAX/AgMD/wQFBf8CAgL/AAEA/wECAv8BAgL/BQUF/wMEBP8GBwf/BAQF/wMEBP8EBAX/AwME/wICAv8DAwP/AwMD/xYXF/8nKir/RUlJ/3B1dv97f4D/iIyM/4eLjf+Hi43/h4uN/4aKjP+Gioz/hoqM/4aKjP+Gioz/hYqL/4WKi/+Fiov/hYqL/4WJi/+FiYr/hImK/4SIiv+EiIr/g4eJ/4OHif+Ch4j/goeI/4KGiP+Bhof/gYaH/4GGhv+AhYb/gIWG/4CFhf9/hIX/f4OE/36DhP9+goP/fYKD/32Bgv98gYL/fICB/3yAgP97gID/e3+A/3t/f/96fn7/en5+/3p9ff95fH3/eXx8/3l7fP94e3v/eHp6/3d6ev+Ehob/hYaH/4WHh/+Fh4f/hYeI/4WHiP+Fh4j/hoiI/4aIif+GiIn/hoiJ/4aIif+GiYr/homK/4aJiv+Giov/h4qL/4eKi/+Hi4v/h4uM/4eLjP+Ii4z/iIuN/4iMjf+IjI3/iYyO/4mNjv+JjY7/iY2P/4mNj/+Jjo//io6P/4qOj/+KjpD/io6Q/4qOkP+Kj5D/io6Q/4qPkP+Kj5H/io+Q/4qPkP+Kj5D/io+Q/4eMjf+DiIn/eH1+/zU4O/8YHCH/Jywy/xccIf8VGSD/Excd/wwOE/8JCw7/DRAT/wgLDf8ICgv/Cw0P/zJBW/9Ob6n/U3e3/1+Exf9mj9D/bJPU/26U1v9ymdn/eJ/d/36k4f+IrOT/kbLn/5e26f+eu+v/oLvs/5u36f+Zt+n/l7bp/5a16P+Rsuf/ja7k/4ao4P+Fpt//ep3Z/3KV0v9pjcz/YITD/2OFw/9fgMD/W3u8/1Z3uf9PcLT/R2it/z5eov88W5v/NVKQ/zNPi/8wTIX/MEuE/y5If/8sRXr/LER4/ytCdP8qQHD/JDlm/yE1Xf8eMVX/GixP/xkrTP8YKUf/EiA5/xAdMP8KERz/Cg8V/wYKDv8FBwn/BQUG/wYGB/8DBAT/AwMD/wEBAf8CAwP/AwME/wYGBv8EBgX/BAQE/wICAv8EBAX/BQUG/wQEBf8CAgP/BQQG/wQEBf8MDQ7/HB4f/0pOT/9scXP/en5//4aLjP+Gi4z/houN/4aLjP+Gioz/hoqM/4aKjP+Gioz/hoqM/4aKi/+Fiov/hYmL/4WJi/+EiYr/hImK/4SIiv+EiIr/g4iJ/4OHif+Dh4n/goeI/4KGiP+Choj/gYaH/4GFh/+BhYb/gIWG/4CEhf9/hIX/f4SF/3+DhP9+goT/foKD/32Bg/99gYL/fIGC/3yAgf98gID/e3+A/3t/f/97fn//en5+/3p+fv96fX3/eX19/3l8fP95e3v/eHt7/3h6ev93enr/hYaG/4WGh/+Fhof/hYeH/4WHh/+Fh4j/hYeI/4WHiP+GiIn/hoiJ/4aIif+GiIn/hoiJ/4aJiv+GiYr/homL/4eKi/+Hiov/h4qL/4eKi/+Hi4z/h4uM/4eLjP+Ii43/iIyN/4iMjf+IjI7/iY2O/4mNjv+Jjo//iY6P/4mOj/+Kjo//io6P/4qOkP+KjpD/io6Q/4qOkP+KjpD/io6Q/4qPkP+Kj5D/io+Q/4iMjf+Jjo//g4iJ/1BWWP8cICX/HSAk/xcaH/8WGh//DhEW/woNEf8OERX/CAsO/wQGB/8DBQb/CQwN/wsNDv8kMEH/TWyh/1Z5uP9Zf8L/YorM/2eP0f9qktT/bJTW/3Kb2/96od//hKnj/46w5v+Wten/mrjq/5y56/+cuOr/nLjp/5i26f+Tsuf/kLHm/4yt5P+HqOH/gqPd/3qc2f9zltP/a43M/2SHxv9jhcT/XX6//1h6u/9Wd7n/UXG2/0horf9AYKP/O1qa/zVSkP8xTYj/LUmA/y1Ifv8rRXr/K0V5/yxFev8pQXT/KUBw/yU6aP8fNF3/HC9U/xkrTf8XKUn/FSVE/xIhO/8QHC7/CREa/wkOE/8FCAv/BwgJ/wcICf8FBQb/BAUF/wIDA/8CAgP/BAQF/wICAv8EBAX/BAQF/wUFBf8FBQb/AwMD/wQEBf8FBQb/AgID/wUEBf8CAQP/ExMV/xYXGP88QEH/XWJk/3d9fv+Fiov/hYuL/4aKjP+Gioz/hoqM/4aKjP+Gioz/homM/4WKi/+FiYv/hYmL/4WJi/+FiYv/hImK/4SJiv+EiYr/hIiJ/4OIif+Dh4n/g4eI/4KHiP+Choj/goaH/4GFh/+BhYf/gIWG/4CFhv+AhYX/gISF/3+EhP9/g4T/foKD/36Cg/99gYL/fYGC/3yAgf98gIH/fH+A/3t/gP97f3//e39//3p+fv96fX7/eX19/3l8ff95fHz/eHt7/3h6e/94enr/eHl6/4SGhv+Fhof/hYaH/4WGh/+Fh4f/hYeH/4WHiP+Fh4j/hYeI/4WIiP+GiIn/hoiJ/4aIif+GiYr/homK/4aJiv+GiYv/hoqL/4aKi/+Hiov/h4qM/4eLjP+Hi4z/iIuN/4iLjf+IjI3/iIyO/4iNjv+JjY7/iY2O/4mNj/+Jjo//iY6P/4mOj/+Kjo//io6Q/4qOkP+KjpD/io6Q/4qOkP+KjpD/io6Q/4mOkP+KjpD/iI2O/4GHiP9GS0//LDE2/xwfI/8KDhL/GRwj/xgdJP8MDxT/CQwP/wkMD/8FBgj/AwQE/wQFBv8JCw3/ICcy/0VhkP9UeLj/WX/B/1yEyP9ii8//YozQ/2eQ0/9ul9j/d57d/3+k4P+HquT/j7Dm/5Sy5/+Usuf/lrTo/5a06P+WtOf/krLn/42t5P+Jq+L/hafh/4Ci3f97ndn/dJbU/2yOzf9micj/XoDC/1p8vv9Yebv/U3W3/05vtP9FZqz/QGGk/zhWl/81UY//L0uF/yxIf/8sRn3/K0V6/ypEef8rRHj/KkJ1/yc+b/8jOmf/HTNd/xgtU/8XKkz/FShH/xMkQv8QHzj/DRcn/wsRGv8GCg7/BQgJ/wkJCf8ICAn/BgcH/wYGBv8FBQX/BAMF/wUEBf8EBAX/AwQE/wMDBP8FBQX/BQUG/wICA/8EBAX/BAQE/wMDBP8CAgP/BAQF/wUFBv8ODxD/Oj0+/zg8Pv92e3z/g4eJ/4KHif+Fioz/hoqM/4aKjP+Gioz/hoqL/4aKi/+FiYv/hYmL/4WJi/+FiYv/hYmK/4SJiv+EiIr/hIiJ/4OIif+Dh4n/g4eJ/4OHiP+Choj/goaI/4GGh/+BhYf/gYWH/4CFhv+AhIb/gISF/3+Ehf9/g4T/foKE/36Cg/9+goP/fYGC/32Bgv98gIH/fICB/3uAgP97f4D/e39//3p+fv96fn7/en1+/3l9ff95fHz/eXx8/3h7e/94e3v/eHl6/3d5ef+Ehob/hYaG/4WGh/+Fhof/hYaH/4WHh/+Fh4f/hYeI/4WHiP+Fh4j/hYiJ/4aIif+GiIn/hoiJ/4aIiv+GiYr/homK/4aKi/+Giov/h4qL/4eKi/+Hioz/h4uM/4iLjf+Ii43/iIyN/4iMjf+IjI7/iIyO/4mNjv+JjY//iY2P/4mOj/+Jjo//iY6P/4qOj/+Kjo//io6Q/4qOkP+KjpD/io6Q/4qOkP+KjpD/iY6Q/4mOkP+Bhoj/XWNm/xgcIP8dIif/IScu/xYaIf8dIir/HyMp/wUHCv8GCAv/BgcK/wYHCf8JCw3/BwkL/xQXHf83TXH/UHS0/1h8vv9agMf/W4TK/16Hzf9hjNH/aZLV/3Wc3P9/pOD/g6fh/4eq4/+NruX/kLDm/5Ox5v+RsOX/kK/m/4yt5P+HqOH/hqfh/4Gj3v98n9v/dZjX/3OV0/9rjcz/Y4bG/1x/wP9afL3/VXe7/1Bytf9MbbH/R2is/0Bgo/86WZr/NlSR/zBMhv8tSYH/K0R5/yhCdv8oQXb/KEB0/yg/cv8nPm//Izpo/xsyXP8WLFD/FShL/xMlRf8QIT7/Dhwz/wwVI/8HDBT/BAYI/wUGBv8HBwj/AwME/wYHB/8EBAX/BwYI/wwMEP8GBQf/BQUG/wQEBf8DAwP/BQUF/wQEBP8EBQX/BAQF/wIDA/8BAQH/AgIC/wQEBf8DAwX/BwgJ/xETFP8bHR7/XWBi/4KHiP+EiIr/hoqM/4aKi/+Giov/hoqL/4WJi/+FiYv/hYmL/4WJi/+FiYv/hYmK/4SJiv+EiIr/hIiK/4OIif+Dh4n/g4eJ/4OHiP+Ch4j/goaI/4KGiP+BhYf/gYWH/4GEhv+AhIb/gISF/3+Ehf9/g4X/f4OE/36ChP9+goP/fYGC/32Bgv98gIL/fICB/3yAgf97f4D/e3+A/3t+f/96fn//en1+/3l9fv95fH3/eXx8/3l8fP94e3v/eHp7/3d5ev93eXn/hIaG/4WGhv+Fhof/hYaH/4WGh/+Fhof/hYeH/4WHh/+Fh4j/hYeI/4WHiP+FiIn/hYiJ/4WIif+GiIr/hoiK/4aJiv+GiYr/homL/4aKi/+Hiov/h4qM/4eLjP+Hi4z/iIuN/4iLjf+IjI3/iIyO/4iMjv+JjI7/iY2O/4mNjv+JjY//iY6P/4mOj/+Jjo//iY6P/4mOj/+Kjo//io6P/4qNkP+KjpD/io6Q/4mOj/+Jjo//h4uN/36ChP9laWv/NTo9/yYrMf8bHyb/HSEo/xsfJf8XGiD/EhUa/wUHCf8HCAv/BwkK/woMD/8PERP/Hyk8/0lrpv9Uebz/VXzD/1eAx/9YgMj/XojO/2ON0v9slNf/eZ7d/4Gl4f+Ep+L/hqji/4mq4/+LrOP/i6zj/42t5P+JquP/hqfh/4Kl4P9+od3/eZzZ/3SX1v9wk9L/Z4nJ/2KFxv9afL7/VHa5/1R2uf9Ob7P/SWqt/0Zoqv8/YKL/Olqa/zRRjv8vSoT/LEd+/ylDd/8mP3P/Jj9y/yY/cf8kPG7/JDxu/yI5af8bMlv/FitQ/xMnSf8QIkL/Dh87/w0ZLP8IDxr/BwsR/wYHCP8EBgb/BwgJ/wgJCf8DAwP/CQkK/wsMD/8MDA//CQgL/wUEBv8EBAX/BAQF/wMDA/8EBAX/BAQE/wICA/8DAwT/AgMD/wMDA/8EBAT/BAMG/wsLDf8nKSr/BAUG/0hLTv+IjI3/homL/4aJi/+GiYv/homL/4WJi/+FiYv/hYmL/4WJi/+FiYv/hYmL/4WJiv+EiIr/hIiK/4SIiv+DiIn/g4eJ/4OHif+Ch4j/goaI/4KGiP+BhYf/gYWH/4GFh/+BhYb/gISG/4CEhf9/hIX/f4OE/36DhP9+goP/foKD/32Bgv99gYL/fICB/3yAgf98f4H/e3+A/3t/gP96fn//en5+/3p9fv95fX3/eXx9/3l8fP95e3z/eHt7/3h6e/93eXr/d3l5/4SFhv+EhYb/hIaG/4WGh/+Ehof/hYaH/4WGh/+Fhof/hYeH/4WHiP+Fh4j/hYeI/4WIif+FiIn/hYiJ/4aIiv+GiYr/homK/4aJiv+Giov/h4qL/4eKi/+Hioz/h4uM/4eLjP+Hi43/iIuN/4iMjf+IjI7/iIyO/4mNjv+JjY7/iY2P/4mNj/+JjY//iY2P/4mOj/+Jjo//iY6P/4mNj/+JjY//iY2P/4mNj/+JjY//iY2P/4mNj/+HjI3/goeI/1JWWP8aHyP/Excd/xQYHP8TFRv/FBcc/xIUGf8GBwr/BAYI/wcJCv8JCw7/CAoN/wwQFv82TXj/T3K0/1R5v/9Xf8b/WH/H/1iAyP9fiM7/Z5DU/22U1/91ndz/faLf/4Cj3/+Cpd//hKbg/4Sn4P+Fp+H/hKfh/4Om4P+Ao97/eZ3b/3WZ2P9xlNP/a47O/2SHyP9ggsP/V3q8/1Jzt/9PcbX/Sm2w/0Zoq/9AYqT/PF2e/zdWlv80UY//L0uF/ytFe/8nQXT/JT1w/yU+b/8jO2z/Ijtr/yE6av8eNmT/GTBa/xQqT/8QJEX/DyE//w0bM/8KEiD/BQoT/wQGCf8EBQb/BAUF/wIDA/8EBAT/BAQE/wcHCP8GBwn/BgcJ/wUFB/8EBAX/BAQF/wQEBf8DAgP/BAQF/wMEBP8DBAT/BAQF/wQEBf8DBAT/AwMD/wQDBf8MDA7/HyAi/wUFB/9XWl3/homL/4WJi/+FiYv/hYmL/4WJi/+FiYv/hYmL/4WJi/+FiYv/hYmK/4WIiv+EiIr/hIiK/4SIiv+EiIn/g4eJ/4OHif+Dh4j/goeI/4KGiP+Chof/gYaH/4GFh/+BhYb/gISH/4CEhv9/hIX/f4OF/3+DhP9+goT/foKD/32Cg/99gYL/fYGC/3yAgf98gIH/fH+A/3t/gP97foD/e35//3p9f/96fX7/eX19/3l8ff95fHz/eHt8/3h7e/94enr/eHl6/3d5ef+EhIX/hIWG/4SFhv+Ehob/hIaG/4SGh/+Ehof/hIaH/4WGh/+Fh4f/hYeI/4WHiP+Fh4j/hYeJ/4WIif+FiIn/hoiK/4aJiv+GiYr/homL/4aKi/+Giov/h4qL/4eKjP+Hi4z/h4uM/4iLjf+Ii43/iIuO/4iLjv+IjI7/iYyO/4mNjv+JjY7/iY2P/4mNj/+JjY//iY2P/4mNj/+JjY//iY2P/4mNj/+JjI//iY2P/4mNj/+IjY7/iIyO/4OHif9vdXf/Jyww/xMVGv8SFRr/DRAU/woMEP8UFxz/GBsh/wgKDf8FBgj/BQYI/wkLDf8HCQv/FyE0/z9clf9Lbq//VHm+/1d/xv9ZgMf/W4LJ/2GJz/9nj9P/bpbX/3Ob2v93ndv/eZ3b/3me2/96n9v/faLd/4Gk3/9/ot3/eZ3a/3OX1/9tkdP/bJDQ/2aJy/9egcT/WHy+/1J0tv9Nb7P/Smuw/0dprf9CZKf/P2Ci/ztanP83Vpf/NVOP/y1Jgf8pRHr/Jj9z/yI7bP8iOmr/IDhn/yA5af8eN2X/GzNf/xgwWv8TKE7/DyFA/wwcN/8IFCb/BQwW/wMHC/8FBgj/BgcI/wgJCf8DAwP/AgIC/wMEBP8FBgb/Dg4R/w4OE/8GBgn/BAQF/wUEBv8FBQb/AQEC/wMDA/8DAwP/BQYG/wUFBv8EBAX/AwMD/wICAv8DAwP/DAwO/w4PEP8QERP/cnV3/4aJi/+FiYv/hYmL/4WJi/+FiYv/hYmL/4WJi/+FiYv/hYmK/4WIiv+EiIr/hIiK/4SIiv+EiIn/g4eJ/4OHif+Dh4j/goeI/4KHiP+Choj/gYaH/4GGh/+BhYf/gIWG/4CEhv+Ag4b/f4OF/3+DhP9+goT/foKE/36Cg/99goL/fYGC/3yAgf98gIH/fH+A/3x/gP97f4D/e35//3p+f/96fX7/en1+/3l8ff95fHz/eXx8/3l7fP94e3v/eHp6/3d5ef93eXn/g4WF/4SFhv+EhYb/hIWG/4SGhv+Ehob/hIaG/4SGh/+Ehof/hIaH/4WHiP+Fh4j/hYeI/4WHiP+Fh4n/hYiJ/4WIif+GiIr/homK/4aJi/+GiYv/hoqL/4eKi/+Hioz/h4uM/4eLjP+Hi43/iIuN/4iMjf+Ii47/iIyO/4iMjv+IjY7/iY2O/4mNjv+JjY7/iY2P/4mNj/+JjY//iY2P/4mNj/+JjY//iY2P/4mNj/+IjY//iI2O/4aKjP+DiIn/eoCC/zc8Qf8RFBj/DxEV/w8SF/8LDRH/CAoO/wsNEP8MDhP/Cg0Q/woND/8ICQv/BwkL/wUHCv8eLEr/NlCC/0Vmov9Pc7X/V33A/1uCx/9dhcr/YIjN/2WM0f9rktT/bpXW/3CX2P9xmNj/cpjX/3Wb2v94nNv/eJza/3aa2P9wldX/a5DS/2WKzf9hhcf/Wn3B/1R4u/9Qc7b/S2+y/0hqrv9DZan/QGKl/z5foP85WZn/NVWT/zBOiv8rSID/KUV6/yQ+cP8fOWj/HTZk/xw1Y/8dNWL/GTFd/xcwWv8ULFb/DyVJ/wwdOv8IFSr/BQwY/wMGDP8CAwX/BAUG/wQEBf8DBAT/AwQE/wMDA/8EBAT/BQYH/wwMDv8HBwn/BQYI/wUFBv8FBQb/AwME/wIBAv8DAwT/AgID/wMDBP8EBQX/BAQF/wMDBP8DAwP/BgYH/wMDBP8AAAD/Nzk8/36BhP+ChYj/hYmL/4WIi/+FiYv/hYmL/4WJi/+FiYr/hYmK/4WJiv+EiIr/hIiK/4SIiv+Eh4r/g4iJ/4OHif+Dh4n/goeI/4KHiP+Choj/goaH/4GGh/+BhYf/gYWG/4CEhv+AhIb/f4SF/3+Dhf9/g4T/foKE/36Cg/99goP/fYGC/32Bgv98gIH/fICB/3x/gP98f4D/e3+A/3t+f/96fn//en1+/3l9fv95fH3/eXx8/3h8e/94e3v/eHp6/3d6ev93eXn/d3l5/4SFhf+EhYX/hIWG/4SFhv+EhYb/hIaG/4SGhv+Ehob/hIaH/4SGh/+Eh4f/hYeI/4WHiP+Fh4j/hYeI/4WHif+Fh4n/hYiK/4aIiv+GiYr/homL/4aKi/+Giov/h4qM/4eKjP+Hi4z/h4uM/4eKjf+Ii43/iIuN/4iLjf+IjI7/iIyO/4iMjv+JjY7/iY2O/4mNjv+JjY7/iY2P/4mNj/+JjI//iIyO/4iMjv+IjI7/iIyO/4iMjv+Choj/hYqM/zg9QP8KDhL/Cw8S/xodIv8WGR3/DRAU/w0PFP8JCw7/Cw0Q/wkLDv8LDhL/BwoM/wgKDf8HCQz/DBEa/xkmQP8oPGL/MEdz/0Jgmf9Sd7f/WH/C/12Dx/9ehcr/ZIvO/2WN0P9mjtH/aJDS/2yU1P9xl9b/dJjY/3SY1/9wlNX/bJDR/2aKzf9egsf/WH3B/1R4vP9OcbX/Sm2x/0hrr/9DZqr/P2Gi/z1fn/85WZn/NFOR/zJQi/8tS4P/Kkd+/yZAdP8fOWr/HDVk/xszYP8YMFr/Fi5W/xQsU/8QJkr/DCBA/wobN/8HEyf/BAoW/wEECv8CAwX/AgID/wEAAf8BAQL/BQUG/wMDA/8DBAT/AwME/wQEBf8GBwf/BwcI/wYGCP8ICAv/BgYI/wICA/8CAgP/AgID/wMDBP8DAwT/AwME/wMEBP8EBAX/CAkJ/xITFf8vMDL/PT5A/1hbXf9mamz/fICC/4WJi/+EiIr/hImK/4WJiv+FiYr/hYmK/4WJiv+FiIr/hIiK/4SIiv+Eh4r/hIeJ/4OHif+Dh4n/g4eI/4KGiP+Choj/goaI/4GGh/+Bhof/gYWH/4CFhv+AhIb/gIOF/3+Dhf9/g4T/foKE/36ChP99goP/fYKD/32Bgv99gYL/fICB/3yAgf97f4D/e3+A/3t+f/96fn//en1//3p9fv95fH3/eXx9/3l7fP94e3v/eHt7/3h6ev93enr/d3l5/3d5ef+EhYX/hIWF/4SFhv+EhYb/hIWG/4SFhv+EhYb/hIaG/4SGh/+Ehof/hIaH/4SGh/+Eh4f/hYeI/4WHiP+Fh4j/hYiJ/4WIiv+FiIr/hoiK/4aJiv+GiYv/hoqL/4aKi/+Hiov/h4qM/4eLjP+Hi4z/h4uN/4iLjf+IjI3/iIyN/4iMjf+IjI7/iIyO/4iMjv+IjI7/iI2O/4iNjv+IjY7/iI2O/4iNjv+IjI7/iIyO/4aKjP+EiIr/hIiK/3V5e/8bICT/LTI3/xkdIv8OEhX/Cg0P/xwfJf8TFhr/Cw0Q/w8RFv8QExf/DhEW/woMEP8LDRH/DREW/wgLEf8MEBr/FR8z/xUgNv8iNVv/N1GB/0RimP9RdLH/VXu8/1Z9wf9chcn/YYjM/2KLzf9jjM7/aI/R/2uR0v9qkND/aY/P/2aNzf9fg8b/WX7B/1B1uf9Mb7T/SGmu/0NlqP9BY6X/PmGh/zpbmv83V5T/NFOO/zJRiP8tSX//K0h9/yZDdv8gO2z/GzZl/xkyX/8VLFX/ESdK/w0gP/8MHDb/BxQm/wYPH/8ECxf/AwcP/wMFCv8BAgP/AQIC/wMCA/8BAQL/AgID/wICA/8GBwf/CwwN/wcICP8DBAT/AwQE/wQFBf8GBgf/AwQE/wQDBP8DAwT/AgID/wIBAv8BAQL/AwMD/wUGBv8DBAT/CQoL/yUoKf8wMzX/UVRW/2tvcf9qbW//cHR2/32BhP+AhIb/hIeK/4SIiv+EiYr/hIiK/4SIiv+EiIr/hIiK/4SIiv+EiIn/hIiJ/4OHif+Dh4n/g4eJ/4KHiP+Choj/goaI/4GGh/+Bhof/gYWH/4CFhv+AhYb/gISG/4CEhf9/g4X/f4OE/36ChP9+goT/fYGD/32Bgv98gYL/fICB/3yAgf97f4D/e3+A/3t/gP97fn//en5//3p9fv96fX7/eXx9/3l8ff95e3z/eHt7/3h6e/94enr/d3l6/3d4ef92eHj/g4SF/4SEhf+EhYX/hIWG/4SFhv+EhYb/hIWG/4SFhv+Ehob/hIaH/4SGh/+Ehof/hIeH/4SHiP+Fh4j/hYeI/4WHif+FiIn/hYiJ/4WIiv+GiYr/homK/4aJi/+Giov/hoqL/4eKjP+Hi4z/h4uM/4eLjP+Hi43/iIuN/4iLjf+IjI3/iIyN/4iMjf+IjI7/iIyO/4iNjv+IjY7/iI2O/4iMjv+IjI7/iIyO/4iMjv+IjI7/hYmL/4WJi/96foH/LTI3/zI4Pf8aHiH/Fxse/w8TFv8WGR7/EhYa/w4SFv8RFBr/EBMX/w4RFv8QExj/DA8T/wkMEf8LDxX/Cw8V/w0SGv8PFR//DxYk/xchN/8gME3/MERs/zxWhv9GZZv/TW+q/1R5uP9bgcL/YIbI/2KKzP9iisz/Y4vN/2KJyv9ghcX/WHy8/1N2t/9LbrD/RWWl/0FhoP88W5r/OFeU/zZVj/8yUYr/MU6G/y9KgP8rR3r/KEJ0/yI8a/8eN2T/FzBb/xMqU/8PJEb/Chs2/wgUKP8FDhz/AwkR/wMIDf8DBwz/AgQI/wMEB/8EBQb/AQEB/wEBAf8BAQH/AgIC/wICA/8BAQL/BAUF/wkKC/8LDA3/BwgJ/wMDA/8CAgL/AQIC/wMDBP8EBAT/BAQE/wIBAv8CAQL/BAMF/wMDBP8FBQb/AwUF/wcICf8lKCr/SUxO/2BkZf9jZmn/cXV3/3+Dhf+BhIf/hIeJ/4SHif+EiIr/hIiK/4SIiv+EiIr/hIiK/4SIif+EiIn/hIiJ/4OHif+Dh4n/g4eJ/4OGiP+Choj/goaI/4KGh/+Bhof/gYaH/4GFh/+AhYb/gIWG/4CEhv9/hIX/f4OF/3+DhP9+goP/fYKD/32Bg/99gYL/fIGC/3yAgf98gIH/e3+A/3t/gP97f3//en5//3p+fv96fX7/en19/3l8ff95e3z/eHt8/3h7e/94env/d3p6/3d5ev93eXn/dnh4/4OEhf+DhIX/g4SF/4OFhf+DhYX/hIWG/4SFhv+EhYb/hIWG/4SGhv+Ehob/hIaH/4SGh/+Ehof/hIeI/4SHiP+Eh4n/hYiJ/4WIif+FiIr/hYiK/4WJiv+GiYr/homL/4aKi/+Giov/hoqM/4eKjP+Hi4z/h4uM/4eLjP+Ii43/iIuN/4iMjf+IjI3/iIyN/4iMjv+IjI7/iIyO/4iMjv+IjI7/iIyO/4iMjv+IjI7/h4yO/4iMj/+FiYv/hoqM/2xwcv8WGR3/Cw8S/xccH/8YHCH/Fxsg/xQZHf8VGB3/FBcd/xQYHv8RFRr/EhYc/wsOFP8LDhP/DxIY/w0RF/8MEBX/Cg4S/woNEv8KDhP/Cg4V/xAWI/8YITX/HyxG/yo7Xf83T3z/RGGW/09vqP9UdbH/V3m2/1Z4tf9Vd7T/VHSu/0xpoP9GYpn/QF2T/zVRhP8xToP/Lkp//yxKfv8pRnr/JD9x/yVBcf8hO2n/HzZh/xovVf8VKEn/DyFA/wwdOf8IFiz/BQ4e/wQLFf8CBw3/AgUJ/wMFB/8EBQf/AwQF/wMDBP8DBAT/AwQE/wICAv8BAQH/AgIC/wEBAf8BAQH/AQEB/wEBAv8BAQH/AgMD/wQFBv8CAwP/AwQE/wICAv8CAgP/AwQE/wMDA/8DAgP/BQcH/wYICf8EBQb/AwQF/wQFBv8LDQ7/LjIz/0BDRf9maWr/en1//3+DhP+AhIX/g4aJ/4SIi/+EiIr/hIiK/4SIiv+EiIr/hIiK/4SIif+EiIn/g4iJ/4OIif+Dh4n/g4eJ/4OHiP+Ch4j/goaI/4KGiP+Chof/gYaH/4GFh/+AhYb/gIWG/4CEhv9/hIX/f4SF/3+DhP9+goT/foKE/36Cg/99gYP/fYGC/3yBgf98gIH/e4CA/3t/gP97f3//en5//3p+f/96fn7/en1+/3l9ff95fH3/eXt8/3h7fP94e3v/eHp7/3d6ev93eXn/d3h5/3d4eP+DhIT/g4SF/4OEhf+DhYX/g4WF/4OFhf+DhYb/g4WG/4SFhv+DhYb/hIaG/4SGhv+Ehof/hIaH/4SGh/+Eh4j/hIeI/4WHif+Fh4n/hYiJ/4WIif+FiIr/homK/4WJiv+Giov/hoqL/4aKi/+Hioz/h4qM/4eLjP+Hi4z/h4uM/4eLjf+Hi43/iIyN/4iMjf+IjI3/iIyN/4iMjf+IjI7/iIyO/4iMjf+IjI3/h4yN/4eMjv+Hi47/iIyO/4WJiv+Choj/aW1w/09TV/8lKy//Exgc/w0RFf8QFBj/DA8T/xIVGv8UFx3/Fxsh/xYaIP8RFBr/DA4U/xAUGv8OERf/CQwQ/wkNEv8HCw//BQgM/woNEf8ICw3/CQwP/woOFf8OExz/FR4y/x0tSv8nO13/LkNp/zJGbP83TnX/OU51/ztSff83S2//MUZs/yk7Xv8gMlT/GSxQ/xgtUP8WK0//GC5V/xUsU/8TKEr/ESNB/wwbNP8KFSf/CBMi/wUOGv8DCRH/BAgN/wMGCP8DBAX/AwQF/wICAv8DAwT/BQYG/wUFBv8DBAT/AwQE/wQEBP8EBAT/BAUF/wMDA/8CAgL/AgEC/wICAv8DAwT/AgIC/wMDA/8DBAT/BAUF/wUHCP8JCgz/BAUG/wMEBP8DAwT/AwMF/wYJCv8GCAr/BAUG/wQGB/8DBAX/DxES/ywxM/9CRkj/c3Z3/4CDhf+ChYb/g4iJ/4SIiv+Eh4r/hIiK/4SIiv+EiIr/hIiK/4SIif+EiIn/g4iJ/4OIif+Dh4n/g4eJ/4OHiP+Ch4j/goaI/4KGiP+Choj/gYaH/4GFh/+BhYb/gIWG/4CFhv+AhIX/f4SF/3+Ehf9+g4T/foOE/36Cg/99goL/fYGC/3yBgv98gIH/fICB/3uAgP97f4D/e39//3p+f/96fn7/en1+/3l9ff95fH3/eXx8/3l7fP94e3v/eHp7/3h6ev93enr/d3l5/3d4eP92eHj/g4SE/4OEhP+DhIT/g4SF/4OEhf+DhYX/g4WF/4OFhv+DhYb/g4WG/4OFhv+Dhob/g4aH/4SGh/+Ehof/hIaH/4SHiP+Eh4j/hIeJ/4SIif+FiIn/hYiK/4WIiv+FiYr/hYmK/4aJi/+Giov/hoqL/4aKi/+Gioz/h4qM/4eLjP+Hi4z/h4uN/4eLjf+Hi43/h4yN/4iMjf+IjI3/iIyN/4iMjf+HjI3/h4yN/4eMjf+Hi43/h4uN/4eLjf+Hi4z/hIiK/4SJi/9QVVj/Gx8k/zY8QP8YHiH/EhYa/xkeI/8UGR3/FRke/xgbIf8OERX/DRAU/xIUGv8KDRL/Cw4S/w4RFv8JDA//BgoN/wcJDP8HCQv/BggJ/wYHCf8GCAv/CQsP/wkME/8NEh3/DhYl/xQdLv8RGyv/FSAy/xwnOv8cJzv/GSQ2/xYiNP8PGSn/ChQj/wgRI/8JEiP/CBIi/wgTJf8GEST/BxEi/wgQHv8IDRf/Cg0U/wUIDP8DBgj/AwQF/wMEBP8DBAT/BAQF/wMDBP8BAgL/AwMD/wMEBP8CAwL/AgMD/wQFBf8GBwb/AgMC/wIDA/8DBAT/AwQE/wMDBP8CAgL/AQIC/wQEBf8DBAT/BQYG/wcJCf8FBQb/BwgJ/wYHCf8CAwP/BAUF/wQFBv8FCAn/BggK/wQGCP8FBgj/BQUH/xgbHf8tMTP/V1pc/3p+f/+Dh4j/g4eI/4OHiP+EiIr/hIiK/4SIiv+EiIr/hIiK/4SIif+EiIn/g4iJ/4OIif+Dh4n/g4eI/4OHiP+Ch4j/goeI/4KGiP+Choj/gYaH/4GGh/+BhYf/gIWG/4CFhv+AhYb/f4SF/3+Ehf9+g4T/foOE/36Dg/9+goP/fYGC/32Bgv98gYL/fICB/3yAgf97f4D/e3+A/3t/f/96fn//en5+/3p9fv95fX3/eXx9/3l8fP94e3z/eHt7/3h6e/93enr/d3l5/3d5ef92eHj/dnh4/4ODhP+DhIT/g4SE/4OEhP+DhIX/g4SF/4OEhf+DhYX/g4WF/4OFhv+DhYb/g4WG/4OGhv+Dhob/g4aH/4OGh/+Eh4j/hIeI/4SHiP+Eh4j/hYiJ/4WIif+FiIn/hYiK/4WJiv+FiYr/homL/4aKi/+Giov/hoqL/4aKi/+Hioz/h4uM/4eLjP+Hi4z/h4uN/4eLjf+Hi43/h4yN/4eMjf+HjIz/h4yN/4eMjf+HjI3/h4uN/4eLjf+Hi43/hoqM/4WJi/+Gi43/a3By/zk9Qf8/REj/HyUp/xofJP8ZHSH/EBQY/xIWGv8SFRn/EBMX/w4QFf8WGR//DxIX/woNEf8NERX/BAcI/wgLDf8GCQv/BQcH/wgKC/8ICQr/Cw0Q/wsOEv8ICg7/BwsQ/wkNE/8HDBL/CA0S/wwQF/8LDxb/DA8V/xAUGv8IDRL/CAsR/wsPFf8EBw3/BwsS/wgNFf8FCA//BAcM/wgLEP8KDRL/CQwR/wwQFf8ICw7/BAUG/wMDA/8CAgL/AQEC/wMDA/8DAwT/AQIC/wIDA/8FBgb/BAUE/wMEBP8DBAP/BAUF/wMDA/8BAQH/AwQE/wQEBP8GBgf/BAQF/wICAv8DAwP/AwME/wQEBP8DBAP/AwUF/wcICf8GCAn/AgQD/wMDA/8GBgj/BgcI/wUGB/8FBwj/BgcJ/wQFBv8XGhv/RUlK/2tvcf97f4D/h4uL/4KGh/+Dh4j/hIiK/4SIiv+EiIr/hIiJ/4OIif+EiIn/hIiJ/4OIif+Dh4n/g4eI/4OHiP+Ch4f/goaI/4KGiP+Choj/gYaH/4GGh/+BhYf/gIWG/4CFhv+AhYb/f4SF/3+Ehf9/g4T/foOE/36Dg/9+goP/fYKD/32Bgv99gYL/fIGB/3yAgf97gID/e3+A/3t/f/96f3//en5//3p+fv95fX3/eX19/3l8ff95fHz/eHt7/3h6e/94enr/d3l6/3d5ef93eHn/dnh4/3Z3d/+ChIT/g4SE/4OEhP+DhIT/g4SE/4OEhP+DhIX/g4SF/4OFhf+DhYX/g4WG/4OFhv+DhYb/g4aG/4OGhv+Dhof/hIeH/4SHiP+Eh4j/hIeI/4SHif+Eh4n/hYiJ/4WIif+FiYr/hYmK/4WJiv+Giov/hoqL/4aKi/+Giov/hoqL/4eKjP+Hi4z/h4uM/4eLjP+Hi4z/h4uN/4eLjf+Hi43/h4yN/4eMjf+HjI3/h4yN/4eLjf+Hi43/h4uN/4aLjP+Fi4z/hYqM/4WKi/91e33/SE1Q/zI4PP8mLTH/ERYZ/w8TF/8WGh7/ERQX/xEUGP8VGR7/EBMY/xcaIP8UFxz/Cw8S/wkMDv8KDA7/BQcI/wcKCv8GCAj/DA4Q/wsOEP8KDQ//CAsN/wYIC/8ICg3/BgkM/wQHCf8JDA7/BgkL/w8SF/8MDxH/BQgK/wYICv8MDhH/BggL/wkKDP8HCQz/BwkM/wUHC/8NERX/DRAV/xAVG/8LDxP/BQgK/wUGB/8CBAT/AQEB/wECAf8CAgL/AwME/wMDA/8CAgL/AwMD/wUGBv8HCAj/BAQE/wMEA/8DBAT/AgMD/wYGBv8FBQb/BwcI/wQFBf8DAwT/AgIC/wECAv8DAwP/AgMD/wIDA/8FBwf/BQcH/wIDAv8DAwP/BAUG/wQFBv8ICQn/DA0P/wkKDf8NEBL/Jikr/1teYP9yd3j/fIGC/4OHiP+Dh4f/hImK/4SIif+EiIn/hIiJ/4SIif+EiIn/g4eJ/4OHif+Dh4n/g4eJ/4OHiP+CiIj/goeI/4KHiP+Choj/gYaH/4GGh/+BhYf/gYWH/4CFhv+AhYb/gISG/3+Ehf9/hIX/foSE/36DhP9+g4P/foKD/32Cgv99gYL/fIGC/3yAgf98gIH/e3+A/3t/gP96f3//en5//3p+fv95fX7/eX59/3l9ff95fHz/eHt8/3h7e/94env/d3p6/3d5ev93eXn/d3h4/3Z3eP92d3f/goOD/4KDhP+Cg4T/goSE/4KEhP+DhIT/g4SE/4OEhf+DhIX/g4WF/4OFhf+DhYb/goWG/4OFhv+Dhob/g4aH/4OGh/+Ehof/hIeI/4SHiP+Eh4j/hIeJ/4SIif+FiIn/hYiK/4WIiv+FiYr/hYmK/4WJiv+Gior/hoqL/4aKi/+Giov/hoqM/4aKjP+Hioz/h4uM/4eLjP+Hi4z/h4uM/4eLjP+HjIz/h4uM/4eLjf+Hi43/h4uN/4eLjf+Gi4z/houN/4WJi/9/hIb/fIGE/2Noa/9IT1H/GyAk/w8TFv8TFxr/Fxoe/xMWG/8SFhn/Fhof/xQXG/8aHSP/Fhoe/wsOEP8NDxP/BggJ/wgKCv8ICgv/BAYG/w4PEf8ZGx7/Cw0P/woND/8ICgz/BQcI/wcKDP8EBQb/CAoL/woMDv8KDA7/BgkK/wIEBP8HCQr/BwgJ/wUHCP8ICgz/BgcI/wYHCv8JCw//DRAV/xAUGf8OEhf/CQwR/wUIC/8HCQr/BAYG/wMEA/8BAQH/AQIC/wIDAv8DBAT/BAQF/wECAv8DBAT/BQYG/wQFBP8FBgb/AgMD/wMDA/8DBAT/BQUF/wQFBf8FBQX/BAUG/wMEBf8DBAT/AwME/wMEBP8CAwP/AgQE/wIDAv8CAgL/AgIC/wMEA/8FBgb/BAUG/wQFBv8KDA3/JSgq/1RYWv9scXL/fYKD/4OIif+DiIn/hImK/4SIiv+EiIn/hIiJ/4OIif+Eh4n/g4eJ/4OHif+Dh4n/g4eJ/4OHiP+Ch4j/goeI/4KHiP+Chof/gYaH/4GGh/+BhYb/gYWH/4CFhv+AhYb/gISG/3+Ehf9/hIX/f4OF/36DhP9+g4P/fYKD/32Cgv99gYL/fIGC/3yBgf98gIH/fICB/3t/gP97f4D/en5//3p+fv95fn7/eX1+/3l9ff95fHz/eHx8/3h7e/94e3v/eHp6/3d6ev93eXn/dnh5/3Z4eP92d3f/dXd3/4KDg/+Cg4P/goOE/4KDhP+Cg4T/goSE/4KEhP+ChIT/g4SF/4OEhf+DhYX/goWF/4OFhv+DhYb/g4aG/4OGh/+Dh4f/g4aH/4SHiP+Eh4j/hIeI/4SHiP+Eh4n/hIiJ/4WIif+FiIr/hYmK/4WJiv+Fior/hYqK/4aKi/+Giov/hoqL/4aKi/+Giov/hoqL/4aKjP+Hioz/h4uM/4aLjP+Gi4z/h4uM/4eLjP+HjIz/h4uM/4eLjP+Gi4z/houM/4aKjP+Ch4j/hImL/4GGiP9la27/XmVo/zc9Qf8XHB//DxIV/xAUF/8LDhH/DhEV/xQXHP8RFBn/DxIW/w4RFf8SFRj/DRAS/wwND/8KDQ7/BggH/wYHB/8MDg7/DRAR/wkLDP8LDQ//CQsN/wYHCP8DBQX/BgcI/wgJC/8ICgz/BgkJ/wIEBP8DBAT/BwkJ/wUHCP8FBgb/CAoL/wgJC/8KDA7/DhAU/w8RFv8MDhH/DRAU/w4SFv8JCw7/BQcH/wcICP8FBgb/AwQE/wICAv8CAgH/AgID/wMDBP8DAwT/AwMD/wECAv8BAgL/BQYG/wQFBP8CAwP/BAQE/wcHB/8DAwP/AwQE/wUGB/8GCAn/BQYI/wMEBP8EBAX/AwQE/wQFBf8CAwP/AgIC/wIDA/8EBAT/BQYI/wQFB/8ZGx3/LTAz/yAjJf9aXWD/e4CB/36ChP+DiIr/hImK/4OIif+DiIn/hIiJ/4OIif+DiIn/g4eJ/4OHif+Dh4n/g4eJ/4OHiP+Ch4j/goeI/4KHiP+Ch4j/goaH/4GGh/+Bhof/gYWG/4GFhv+AhYb/gISG/4CEhf9/hIX/f4OF/36DhP9+g4T/foOD/32Dg/99goP/fYKC/3yBgv98gYH/e4CB/3t/gP97f4D/e39//3p+f/96fn//eX5+/3l9ff95fX3/eXx8/3h8fP94e3v/eHp7/3d6ev93eXr/d3l5/3Z4eP92d3j/dXd3/3V2dv+Cg4P/goOD/4KDg/+Cg4P/goOE/4KDhP+Cg4T/goSE/4KEhP+ChIX/goSF/4OFhf+DhYb/g4WG/4OFhv+DhYb/g4aH/4OGh/+Dhof/g4aH/4SHiP+Eh4j/hIeJ/4SHif+EiIn/hIiJ/4WIif+FiIr/hYmK/4WJiv+FiYr/hYqK/4aKi/+Giov/hoqL/4aKi/+Gioz/hoqM/4aKjP+Gioz/houM/4aLjP+Hi4z/houM/4aLjP+Gi4z/houM/4aLjP+EiYr/hIiJ/4SJi/9/hIb/Ymdq/0RITP8tMTX/ERYa/xgdIf8VGRz/DhEV/xQYHP8XGyH/FBgd/xkdI/8UFhv/EhQY/woMDv8LDA7/CQsN/wkKC/8JCgr/DA4P/wgKC/8PERL/DRAR/woND/8HCQr/CAkK/wgJC/8HCAn/BgcI/wYHCP8FBgb/CQoL/wsNDv8KDAz/CAkJ/woMDP8HBwj/BgcH/woMDv8OEBT/EBMX/xQYHf8NERb/CAoN/wgJCf8GCAj/BgYH/wMFBf8EBQX/BQUF/wQEBP8DAwT/AgID/wMCA/8CAgP/BAQE/wQEBP8DAwP/BQUF/wUFBf8FBgb/BAUF/wMEBf8FBQf/BgcI/wQFBv8EBQb/BQYH/wICAv8DAwT/AwQF/wMEBP8DBQX/AwQE/wYHCf8VGBn/QERG/19kZ/9gZWb/bnN1/4OHif+BhYf/goaI/4SIiv+DiIn/g4iJ/4OIif+Dh4n/g4eJ/4OHif+Dh4n/g4eJ/4OHiP+Ch4j/goaI/4KGiP+Choj/gYaH/4GGh/+Bhof/gYWG/4CFhv+AhYb/gISG/4CEhv9/hIX/f4SF/3+DhP9+g4T/foOE/32Cg/99goP/fYGC/3yBgv98gYH/fIGB/3uAgf97f4D/e3+A/3p+f/96fn//en1+/3l9fv95fX3/eXx9/3h8fP94e3v/eHt7/3d6ev93enr/d3l5/3Z5ef92eHj/dnd3/3V2d/90dnb/gYKC/4KCg/+Cg4P/goOD/4KDg/+Cg4P/goOE/4KDhP+ChIT/goSE/4KEhf+ChIX/g4SF/4KFhv+DhYb/g4WG/4OGh/+Dhof/g4aH/4OGh/+Dhoj/g4aI/4SHiP+Eh4j/hIeJ/4SHif+EiIn/hYiJ/4WIiv+FiYr/hYmK/4WJiv+FiYr/hYmL/4aKi/+GiYv/homL/4aKi/+Giov/hoqM/4aKjP+Gioz/hoqM/4aLjP+Gi4z/houM/4aKjP+Gioz/hIiK/4KGiP+Gi4z/YWVo/1NXWv8kJyv/Cw4S/xAUGP8UGR3/Fxwg/xMXG/8UGBz/GR0j/xEVGf8TFRr/Fxgd/xIUGP8JCw7/CwwP/w4PEf8ODxH/CgsM/w4QEf8NDg//DxES/w4PEf8LDRD/CQsN/woMD/8MDRD/BQYH/wUGBv8FBQb/CQoL/w4PEP8JCwz/BwgI/wkKC/8ICgr/CgsM/wgJCv8MDQ7/CAkK/wYICv8LDA//CgwO/wsMD/8LDQ7/DA4Q/wsND/8GBwf/BggI/wgKC/8GBwj/BgYH/wQEBf8DBAT/BAQF/wQEBP8DBAT/AgMD/wYGB/8EBQX/BggI/wYHCP8CAwP/BgYI/wYHCP8EBQb/BwcJ/wUGCP8DAwT/BAQF/wQEBP8DBQX/BggJ/wMEBf8MDg//ISUn/0lNUP9nbG//cnd5/36ChP+EiIn/hIeJ/4GFh/+EiIn/g4eJ/4OHif+DiIn/g4iJ/4OHif+Dh4n/g4eI/4OHiP+Choj/goaI/4KGiP+Choj/gYaH/4GGh/+Bhof/gYWG/4CFhv+AhYb/gIWG/4CEhv9/hIX/f4SF/3+DhP9/goT/foKE/32Cg/99goP/fYKD/3yBgv98gYL/fICB/3yAgf97gID/e3+A/3t/f/96fn//en1+/3p9fv95fX3/eHx9/3h8ff94fHz/eHt7/3d7e/93enr/d3l6/3Z5ef92eHn/dnh4/3V3d/91dnf/dHZ2/4GCgv+BgoP/gYKD/4GDg/+Cg4P/goOD/4KDg/+Cg4T/goOE/4KEhP+ChIX/goSF/4KEhf+ChYX/goWG/4KFhv+DhYb/g4aH/4OGh/+Dhof/g4aH/4OGiP+Dhoj/hIeI/4SHiP+Eh4n/hIeJ/4SIif+FiIn/hYiK/4WJiv+FiYr/hYmK/4WJiv+FiYr/hYmL/4aJi/+GiYv/hoqL/4aKi/+Giov/hoqL/4aKjP+Gioz/hoqM/4aLjP+Fioz/hYqL/4WJi/+BhYb/h4uM/1leYP9QVFj/Jysv/x8kKf8hJiz/Exgc/xIWGv8QFRn/FRke/xMXG/8RExf/ExUZ/wsNEP8KDA//EhMW/xobH/8NDhD/DxAS/w4PEP8ODxD/DxES/w0PEP8SExX/Fxod/xodIv8RExf/CAkK/wUGB/8HCAj/BQUG/wsLDP8PEBL/CwwM/wsMDP8GBwf/CAkK/woLDP8JCQr/CgsM/wkJC/8HCAj/CAgJ/wwMDv8ICQv/CgwO/wwND/8JCgv/CQsM/wgKCv8JCw3/DA8S/wcICv8GBgj/AgID/wQFBv8DAwT/AgID/wIDA/8EBAT/AwQE/wUGBv8FBgf/AwQF/wYHCP8GBwj/BAUG/wYHB/8FBQb/BAQF/wUFB/8FBQb/BQUG/wYICf8CBAT/CQsM/w4QEv8QEhT/UFRX/32Bg/+EiIn/hIiK/4SHiv+Dh4n/g4eJ/4OHif+Dh4n/g4eJ/4OHif+Dh4n/g4eI/4OHiP+Ch4j/goaI/4KGiP+Choj/goaH/4GGh/+BhYf/gIWH/4CFhv+AhYb/gIWG/4CEhv9/hIX/f4SF/3+Dhf9/g4T/foOE/36Cg/99goP/fYKD/32Bgv98gYL/fIGC/3yAgf97gID/e3+A/3t/gP96fn//en5//3p9fv95fX7/eXx9/3h8ff94fHz/eHt8/3h7e/93env/d3p6/3d5ef92eXn/dnh4/3Z4eP91d3f/dHZ2/3R1df+BgoL/gYKC/4GCg/+BgoP/gYKD/4GDg/+Cg4P/goOD/4KDhP+Cg4T/goOE/4KEhP+ChIX/goSF/4KEhf+ChYb/goWG/4OFhv+DhYb/g4aH/4OGh/+Dhof/g4aI/4OGiP+Eh4j/hIeI/4SHif+Eh4n/hIiJ/4SIif+EiIn/hIiK/4WJiv+FiYr/hYmK/4WJiv+FiYv/hYmL/4WJi/+FiYv/hYmL/4aKi/+Fiov/hoqL/4WKi/+Giov/hYqL/4WKi/+Giov/goaI/4GFh/9xdHf/TVBU/yEkKP8bHiP/Fhke/w0QFP8XGyD/FBcc/xgcIf8XGh7/EhQY/xQWGv8RExb/ExUZ/w0PEv8QERP/Dg8R/wkKC/8ODxD/ExQV/wwNDv8MDQ7/EhQW/xIVF/8NDxH/Fhgc/w8QEv8FBgf/BQUG/wcHCP8EBQX/DA0O/woLDP8JCQr/DQ0O/wkJCv8EBQT/CgoL/wcHCP8JCQv/CQkK/wgICf8ICAr/BgYH/wcHCP8GBgf/CgsL/w4PEP8LDA//Cw0P/wwOEP8JCgz/CQoN/wYHCf8HCQv/BgYI/wMEBP8EBAT/AgMD/wQEBf8EBAT/BAUF/wYGCP8EBQb/BgcI/wcICf8EBQf/BQUH/wQFBv8DBAX/AwQF/wUGBv8GCAr/BQcI/wIDA/8ODxD/BAYH/0dLTf+Dh4j/hIeJ/4SHif+Eh4n/g4eJ/4OHif+Dh4n/g4eJ/4OHif+Dh4j/g4eI/4OHiP+Ch4j/goaI/4KGiP+Choj/goaH/4GFh/+BhYf/gYWH/4CFh/+AhYb/gIWG/4CEhv9/hIX/f4SF/3+Dhf9/g4T/foOE/36ChP9+goP/fYKD/32Bgv98gYL/fIGC/3yAgf98gIH/e3+A/3t/gP97f4D/en5//3p+f/95fX7/eX19/3l8ff94fHz/eHt8/3h7e/93env/d3p6/3d5ev93eXn/dnh5/3Z4eP91d3f/dXd3/3R2dv90dXX/gYKC/4GCgv+BgoL/gYKC/4GCg/+BgoP/gYOD/4GDg/+Cg4T/goOE/4KDhP+Cg4T/goSF/4KEhf+ChIX/goWG/4KFhv+ChYb/g4WG/4OFhv+Dhof/g4aH/4OGh/+Dhoj/g4aI/4SGiP+Dh4j/hIeJ/4SHif+Eh4n/hIiJ/4SIif+EiIr/hImK/4WJiv+FiYr/hYmK/4WJiv+FiYr/hYmL/4WJi/+FiYv/hYmL/4WJi/+FiYv/hYqL/4WJi/+FiYv/hYqL/4OHif+ChYf/foKE/3F1d/9OUVT/Kiww/ygsMf8oLTP/Jiow/xQYHP8VGBz/FBcc/w8RFf8RExf/FBYa/w4QE/8QERT/Fxgb/xARFP8MDQ//CwwN/w4OD/8PERL/Dg8Q/w8REv8WGBv/Fhca/xgaHf8VFxn/BgYH/wgICv8HBwj/CgkL/wwMDf8IBwn/BwcI/wkKCv8JCgr/DA0O/w4PEP8ODg//DA0O/w0ND/8ICAr/CAgJ/wcHCP8EBAX/BwcI/wYHCP8LDA3/Dg8R/woMDv8MDhH/DQ8S/wYICv8LDRH/Cw0R/wUHCf8FBQf/AwME/wMDBP8DAwP/BAQF/wQFBf8DBAT/BgYH/wUFBv8DBQX/BQYI/wMEBf8DAwX/BAQG/wQEBf8FBgj/CAoL/wUHCP8JCgz/ERMV/xETFf9pbXD/gIOE/4OHif+Dhon/g4eJ/4OHif+Dh4n/g4eJ/4OHif+Dh4j/g4eI/4KHiP+Ch4j/goaI/4KGiP+Chof/goWH/4GFh/+BhYf/gYWH/4GEh/+AhYb/gISG/4CEhv9/hIX/f4SF/3+Ehf9/g4T/foOE/36ChP9+goP/fYGD/32Bg/99gYL/fIGC/3yAgf98gIH/e4CB/3t/gP97f4D/en9//3p+f/96fX7/eX1+/3l8ff95fH3/eHt8/3h7fP93env/d3p7/3d6ev93eXr/dnl5/3Z4eP92eHj/dXd3/3V2d/90dnb/dHV1/4GCgv+BgoL/gYKC/4GCgv+BgoL/gYKC/4GCg/+Bg4P/gYOD/4GDg/+Cg4T/goOE/4KEhf+ChIX/goSF/4KEhf+ChYb/goWG/4KFhv+ChYb/goaH/4OFh/+Dhof/g4aH/4OGh/+Dhoj/g4eI/4OHif+Eh4n/hIeJ/4SIif+EiIn/hIiJ/4SIif+EiIr/hIiK/4SIiv+FiIr/hYiK/4WJiv+FiYv/hYmL/4WJi/+FiYv/hYmL/4WJi/+FiYv/hYmL/4WJi/+FiYv/g4aI/4aJi/+Ag4X/dXl7/2FkaP9KTlP/Jiow/xgdIv8ZHCD/FRgc/xEUGP8RExb/ERMW/xkcH/8OERT/DQ4R/wwOEf8MDhD/CwsM/wsLDf8NDQ//ERIU/xASE/8MDA3/Dg8R/xgaHP8REhT/CwsM/wsKC/8JCQr/BgYH/wYGB/8KCgv/CgoL/wYGB/8CAwP/BgYG/w4OD/8ODxD/Dg8Q/xESE/8QERL/CwsN/wYGB/8CAgP/BAQE/wUFBv8EBQb/CAgK/wgJCf8GBgf/CgsN/woLDf8PERb/CQoN/wwOEf8LDRH/BwkM/wQEBf8EBQb/BwcJ/wcICv8FBgf/BAUF/wUFBf8EBQX/AgMD/wQEBf8DBAX/BgYI/wUFBv8FBQb/BggK/wYICv8FBgj/BwkK/wwOEf9NUVP/foGC/4KFh/+Dh4n/g4eJ/4OHif+Dh4n/g4eJ/4OHif+Dh4j/g4eI/4KGiP+Choj/goaI/4KGh/+Chof/gYaH/4GFh/+BhYf/gYWH/4GFh/+AhYb/gISG/4CEhv9/hIX/f4SF/3+Dhf9+g4T/foOE/36DhP9+goP/fYKD/32Cg/99gYL/fIGC/3yBgv98gIH/e4CB/3uAgP97f4D/en9//3p+f/96fn7/en1+/3l9ff95fH3/eHx9/3h7fP94e3z/d3p7/3d6e/93eXr/dnl5/3Z4ef92eHj/dXd4/3V3d/91dnf/dHV2/3R1df+BgYL/gYGC/4CBgv+BgoL/gYKC/4GCgv+BgoL/gYKD/4GDg/+Bg4P/gYOE/4KDhP+Cg4T/goOE/4KDhf+Cg4X/goSF/4KEhv+ChYb/goWG/4KFhv+DhYb/g4aH/4OGh/+Dhof/g4aH/4OGiP+Dhoj/g4aI/4SHiP+Eh4n/hIeJ/4SIif+EiIn/hIiJ/4SIif+EiIr/hIiK/4SIiv+FiIr/hYiK/4WIiv+FiYv/hYiL/4WJi/+FiYv/hYmL/4WJi/+FiYv/hYmL/4WIiv+Dh4n/g4eJ/32Bg/9+gYP/dnl8/1peYv8+Qkb/Jiku/xYZHf8TFRn/Gx4j/xMWGv8OERT/ERQY/wwOEf8UFRj/CgsN/wkJCv8QDxL/Dw8Q/wsMDf8OEBH/GRod/xESFP8JCgv/CAkK/woKC/8JCAn/CwsM/xAPEf8HBwf/CQkK/wYGBv8FBgb/BgYH/wMDBP8FBQX/CAkJ/w4PEP8MDA7/CQoL/woKDP8FBQb/BAQF/wQEBf8GBgf/BQUG/wYFBv8JCgv/CQoK/w0OEP8MDRD/ExYb/w8QFP8LDA//Cw0Q/wUGB/8EBQb/BAUG/wsMD/8ICQz/BQYI/wUGB/8GCAn/BQYH/wUGB/8EBQb/BQYI/wUGCP8GBgn/CQkN/wwOEP9DRkn/R0pM/0xOT/9sb3D/f4OE/4GFhv+EiIn/g4eJ/4OHif+Dh4n/g4aJ/4OGif+Dhoj/g4aI/4OGiP+Choj/goaI/4KGh/+Chof/gYaH/4GFh/+BhYf/gYWG/4GFhv+AhIb/gISG/4CEhv9/hIX/f4OF/3+Dhf9/g4T/foOE/36DhP9+goP/fYKD/32Cg/99gYL/fYCC/3yAgv98gIH/fH+B/3t/gP97f4D/e3+A/3p/f/96fn//en5+/3l9fv95fH3/eXx9/3h7fP94enz/eHp7/3d6ev93eXr/d3h5/3Z4ef92eHj/dnh4/3V3d/91d3f/dXZ2/3R1dv90dXX/gIGB/4CBgf+AgYL/gIGC/4CCgv+AgoL/gYKC/4GCgv+BgoP/gYOD/4GDg/+Bg4P/gYOE/4KDhP+Cg4T/goSF/4KEhf+ChIX/goWG/4KEhv+ChYb/goWG/4KFh/+ChYf/g4aH/4OGh/+Dhof/g4aI/4OGiP+Dh4j/g4eI/4OHif+Eh4n/hIeJ/4SIif+EiIn/hIiJ/4SIiv+EiIr/hIiK/4WIiv+FiIr/hYiK/4WJi/+FiYv/hYmL/4WJi/+FiYv/hYmL/4WJi/+FiYr/hYmK/4SJiv+Dhoj/gYSG/4GFhv97f4H/bG9y/09TV/8kKCv/GRwh/xkdIv8RFRj/DA8S/xkbH/8QExb/DA8R/woKDP8ODxH/CwsN/w0ND/8REhT/EBET/w4QEf8MDQ3/BwgI/wkJCv8NDg//DQ4P/wgICP8JCQn/BwcI/wsLDP8KCgz/Dg4P/wkKC/8FBgf/CQkK/w8QEP8SExX/GBkc/w8QEf8MDQ7/CQkK/wcHCP8GBgf/BAQE/wQEBP8HBwj/CwwN/wsLDf8KCgv/DxAS/woLDf8MDhD/Cw0P/wcICf8GBwn/BwgK/wgJC/8GBwj/BQcI/wYHCf8GBwn/BggJ/wUHCf8HCQz/BAUH/wYHCP8FBgj/BQUI/w0OEf8qLC7/am1v/3R3eP+BhIX/hYiJ/4KGhv+AhIX/gYWG/4OHiP+Dh4j/g4eI/4OGiP+Dhon/g4aI/4KGiP+Choj/goaI/4KGh/+Chof/gYaH/4GFh/+BhYf/gYWG/4GFhv+AhIb/gISG/4CEhv9/hIb/f4OF/3+Dhf9/g4T/foOE/36DhP9+goP/fYKD/32Cg/99gYL/fYGC/3yAgv98gIH/fICB/3uAgf97f4D/e3+A/3p/gP96fn//en5+/3l9fv95fX3/eXx9/3h8fP94e3z/eHt8/3d6e/93env/d3l6/3Z5ef92eHn/dnh4/3V4eP91d3f/dXd3/3V2dv90dXb/dHV1/4CBgf+AgYH/gIGB/4CBgf+AgYL/gIGC/4CBgv+AgoL/gYKC/4GCg/+Bg4P/gYOD/4GDhP+Bg4T/gYOE/4KDhf+ChIX/goOF/4KEhf+ChIb/goWG/4KFhv+ChYb/goWG/4KGh/+Dhof/g4aH/4OFiP+DhYj/g4aI/4OGiP+Dhoj/g4eJ/4OHif+EiIn/hIiJ/4SIif+EiIn/hIiJ/4SIiv+Eh4r/hIiK/4WIiv+FiIr/hYiK/4WIiv+FiYr/hYmK/4WJiv+FiYr/hYmK/4WJiv+EiIr/gYWH/4SGiP+BhIb/gIOF/3d7ff9iZmj/NDc6/x0gJf8XGh//FBgb/xkcIP8SFRj/ExUZ/xETF/8REhX/EBEU/woKDP8JCQv/EhIV/xcYGv8KCw3/CAkK/w8QEf8NDg//CwsM/xITFP8HCAj/BgYH/wcHCP8LCwz/FhYY/xAQEv8MDA7/CAkK/wgJCf8JCQr/Dg8R/xocHv8UFRf/CAkK/wsLDP8JCQv/BwcI/wUFBf8EBAX/BwgJ/wYGB/8EBQX/BAUF/wYHCP8KDA3/CgsM/wcICf8EBQX/BgYH/wUGCP8ICg3/CgsP/wQGBv8GBwn/BQYH/wcICf8FBgb/BggJ/wUHCf8FBwj/CAkM/wcIC/8MDhH/QEJE/3V3ef95fH7/goWH/4CDhP+AhIX/gYWG/4CDhf+Chof/g4eI/4OGiP+Dhoj/goaI/4KGiP+Choj/goaI/4KFh/+Bhof/gYWH/4GFh/+BhYf/gYWG/4CFhv+AhYb/gISG/4CEhv9/g4X/f4OF/3+Dhf9+g4T/foKE/36Cg/9+goP/fYKD/32Cg/99gYL/fYGC/3yBgv98gIL/fH+B/3t/gf97f4D/e3+A/3p/gP96fn//en5+/3p+fv95fX7/eX19/3l8ff94fHz/eHt8/3d6e/93env/d3l6/3d5ev92eHn/dnh5/3Z4eP91d3f/dXd3/3V2dv90dnb/dHV1/3N1df+AgID/gIGB/4CBgf+AgYH/gIGB/4CBgf+AgYL/gIKC/4CCgv+BgoL/gYKD/4GCg/+Bg4P/gYOE/4GDhP+Bg4T/goOF/4KEhf+Cg4X/goSF/4KEhv+ChYb/goWG/4KFhv+ChYb/goWH/4KGh/+Dhof/g4aH/4OGiP+Dhoj/g4aI/4OHiP+Dh4j/g4eJ/4OHif+Eh4n/hIiJ/4SIif+EiIn/hIiK/4SIiv+FiIr/hYiK/4WIiv+FiYr/hYmK/4WJiv+FiYr/hYmK/4WJiv+FiYr/hIiJ/4OGh/+GiYv/hIiK/4GFh/94fH//bnF0/0tOUf8dIST/Gh0h/x8jJ/8dIST/EhUY/xIUF/8SExX/DQ8R/w8QE/8SExX/FBUY/wsMDf8ODxH/DQ4P/wcICP8UFRb/ERIU/xYXGf8TFBb/BAUF/wUFBv8JCQr/CgoL/w4PEf8NDQ7/CwsM/wgICf8LDA3/CwwN/xARE/8LDAz/DQ4P/w8QEf8MDQ7/CQoK/wgICf8MDA7/CAgJ/wUFBv8HBwj/BgcI/wQFBf8ICQr/BwgJ/wQFBv8HBwj/BwgI/wcICf8FBgf/AwME/wYHCf8ICQr/BgYH/wMEBP8FBwj/BQcI/wcJC/8FCAr/BQcK/wUHCv8RExb/Gx4g/0ZKS/98f4H/gYSF/3+ChP+ChYf/gYSF/4CEhf+Choj/goaI/4KGiP+Choj/goaI/4KGiP+Choj/goaI/4KGh/+ChYf/gYWH/4GFh/+BhYb/gYWG/4CFhv+AhYb/gISG/4CEhf9/hIX/f4SF/3+Dhf9/g4X/foOE/36ChP9+goP/fYKD/32Cg/99gYL/fIGC/3yBgv98gYH/fICB/3uAgf97gIH/e3+A/3t/gP96f3//en5//3p+f/95fn7/eX1+/3l9ff94fH3/eHt8/3h7e/93env/d3p6/3d5ev92eXn/dnh5/3Z4ef92eHj/dXd4/3V3d/91dnb/dHZ2/3R1df9zdHT/gICA/4CAgP+AgIH/gIGB/4CBgf+AgYH/gIGB/4CBgf+AgYL/gIKC/4CCgv+AgoL/gYKD/4GDg/+Bg4T/gYOE/4GDhP+Bg4X/gYOF/4GEhf+BhIX/gYSG/4KFhv+ChYb/goWG/4KFhv+ChYf/goWH/4KGh/+Dhof/g4aH/4OGiP+Dhoj/g4eI/4OHiP+Dh4j/hIeJ/4OHif+EiIn/hIiJ/4SIif+EiIn/hIiK/4SIiv+EiIr/hYiK/4WIiv+EiYr/hImK/4SJiv+FiYr/hImK/4SIiv+EiIr/hIiK/4OHif+ChYj/fYCD/3V5e/9tcXT/VFhc/y4xNf8jKC3/GR4j/xgbIf8JDA7/DA4P/wkLDf8LDA3/DxAS/xQVGP8HCAn/DAwN/wwNDv8NDg//DA0O/w0OD/8YGRv/ExUV/wkJCf8KCgv/CwsL/woLC/8MDQ7/CwsM/w8QEP8MDA3/DQ0O/w8QEP8PERH/CwsM/xASEv8ODxD/DxAR/w4ND/8IBwn/Fxgb/wwMDf8ICAn/CwwN/wQFBv8EBAX/BgcH/wYHB/8FBgb/BgcH/wQFBf8GBwj/BQUG/wQEBf8FBgb/BgYI/wQDBP8EBQX/CgwO/wgKC/8GCAr/DxMW/xQXGv8qLjD/IyYp/yQmKP9na2z/gIOE/4OGiP+ChYj/gYSG/4KGiP+Dh4n/goaI/4KGiP+Choj/goaI/4KGiP+Choj/goaI/4KGh/+ChYf/gYWH/4GFh/+BhYb/gIWG/4CFhv+AhIb/gISG/3+Ehf9/hIX/f4OF/3+Dhf9/g4T/foKE/36ChP9+goT/fYKD/32Cg/99gYL/fIGC/3yBgv98gYH/fIGB/3yAgf97gID/e3+A/3t/gP96f3//en5//3p+f/95fX7/eX1+/3l9ff94fH3/eHx8/3h7fP93e3v/d3p6/3d5ev92eXn/dnl5/3Z4ef92eHj/dXd4/3V3d/91dnf/dHZ2/3R1dv90dXX/c3R0/4CAgP9/gID/f4CA/3+Agf+AgIH/gIGB/4CBgf+AgYH/gIGC/4CBgv+AgoL/gIKC/4CCgv+AgoP/gYOD/4GDhP+Bg4T/gYOE/4GDhf+BhIX/gYSF/4GEhf+BhIX/gYWG/4KFhv+ChYb/goWG/4KFh/+ChYf/goaH/4OGh/+Dhof/g4aI/4OGiP+Dh4j/g4eI/4OHiP+Dh4n/g4eJ/4SIif+EiIn/hIiJ/4SIif+EiIr/hIiK/4SIiv+EiIr/hIiK/4SIiv+EiIr/hIiK/4SJiv+EiIr/hIiK/4SIiv+EiIn/g4eJ/4SIiv99gIP/en6A/3N3ef9JTVD/LzQ4/xkeI/8YHCH/EBMW/w8SFP8VFxn/ExUY/xETFv8QERP/EhMV/w4OEP8TFBb/DxES/wwMDv8NDg//Dg4O/wkKCf8KCwv/ERES/wgICf8MDAz/ERES/xMUFv8WFxn/ERES/xAQEf8KCwv/CwwM/w0ODv8NDg//CwwM/w0ODv8KCwz/CQkL/xAREv8QEBL/Dg4Q/w8QE/8ICQv/BgcH/wYHB/8ICQr/BQYG/wUFBf8DAwT/BQUG/wQFBf8JCw3/BgcI/wUFBv8GBwj/BwgJ/wYHCf8PERT/Jiot/y4yNf9XW13/aW5v/1lcXv9SVVf/f4KE/4KGh/+Choj/goaI/4KGiP+ChYf/goaH/4KGiP+Chof/goaI/4KGh/+Chof/goaH/4KGh/+BhYf/gYWH/4GFh/+BhYb/gYWG/4CEhv+AhIb/gISF/3+Ehf9/hIX/f4SF/3+DhP9/g4T/foOE/36ChP9+goT/fYGD/32Cg/99gYL/fIGC/3yBgv98gYL/fIGB/3uAgf97gIH/e4CA/3t/gP97f4D/en5//3p+f/96fn7/eX1+/3l9ff95fX3/eH19/3h8fP93e3v/d3t7/3d6ev93eXr/dnl6/3Z4ef92eHj/dnd4/3V3d/91d3f/dXZ3/3R2dv90dXX/c3R1/3N0dP9/gID/f4CA/3+AgP9/gID/f4CA/3+AgP9/gIH/gIGB/4CBgf+AgYH/gIGC/4CCgv+AgoL/gIKC/4CCg/+AgoP/gYOE/4GDhP+Bg4T/gYOF/4GEhf+BhIX/gYSF/4GEhf+BhYb/goWG/4KFhv+ChYb/goWG/4KFh/+Chof/g4aH/4KGiP+Dhoj/g4aI/4OHiP+Dh4j/g4eI/4OHif+Dh4n/hIiJ/4SIif+EiIn/hIiJ/4SIif+EiIr/hIiK/4SIiv+EiIr/hIiK/4SIiv+EiIr/hIiK/4SJiv+EiIn/hIiJ/4OIif+Dh4n/g4eI/3+Ehf9+goP/ZWlr/01RVf8oLTD/Excb/x4iJ/8aHSH/Fxod/xMWGf8XGRz/DxAS/xITFP8REhX/ERIT/xQWGP8TFRf/EBIT/wsNDf8KDAv/CQoK/xASE/8MDQ3/ERIT/xEREv8KCwz/DQ0O/woKC/8MDQ3/DxAR/wsNDv8MDw//CQoL/woLC/8JCgr/DA0O/wwMDP8JCQr/CwwN/woKC/8VFhn/ExUY/wkKC/8KDA3/CAkK/wgJCv8FBwb/CAkK/wYHCP8HCQr/BwkK/wcJC/8HCAn/CAkL/wYHCf8KDA//DhAT/1BTVf9HS03/ZGhp/3p/f/9/goT/gISE/4GFhv+Chof/goaI/4KGiP+Chof/goWH/4KFh/+Chof/goaH/4GGh/+Chof/goaH/4GGh/+BhYf/gYWH/4GFh/+BhYb/gIWG/4CEhv+AhIb/gISF/3+Ehf9/hIX/f4OF/3+DhP9+g4T/foOE/36Cg/9+goP/fYKD/32Cg/99gYP/fYGC/3yBgv98gYL/fIGB/3uAgf97gIH/e4CA/3t/gP97f3//en9//3p+f/96fn//eX1+/3l9fv95fX3/eHx9/3h8fP93e3z/d3t7/3d6ev93enr/dnl5/3Z5ef92eHn/dnh4/3V3eP91d3f/dXZ3/3R2dv90dXb/dHV1/3N0dP9zdHP/f39//3+AgP9/gID/f4CA/3+AgP9/gID/f4CA/3+AgP9/gYH/f4GB/4CBgf+AgYL/gIKC/4CCgv+AgoL/gIKD/4CDg/+Bg4T/gYOE/4GDhP+Bg4T/gYSF/4GEhf+BhIX/gYSF/4GFhv+BhYb/goWG/4KGhv+Chof/goWH/4KGh/+Chof/goaH/4KGiP+Choj/g4eI/4OHiP+DiIj/g4eI/4OIif+DiIn/g4iJ/4SIif+EiIn/hIiJ/4SIif+EiIn/hIiJ/4SIif+EiIr/hIiK/4SIif+EiIn/hIiJ/4SIif+DiIn/g4iJ/4SIif+BhIb/foKD/3l9f/9qbXD/WV1g/zU6Pf8WGh3/GR0h/xUaHv8bHyT/ExUY/wsMDv8MDQ3/ERIV/xESFP8ZGh3/DxET/xASFP8NDg//CwwM/wgJCf8SExX/DxAR/wgJCf8ODxD/CgsL/wwMDf8ICAn/CAgJ/xISE/8NDg//BgcI/wYICP8NDw//Cw0N/wsMDf8LDAz/BgYH/woLDP8NDg//EhMV/w4PEf8NDxD/CwwN/w0PEP8LDQ7/CQsN/wwPEf8ICwz/CQwO/wQGB/8LDhD/BggK/wsND/8KDA7/FBca/zAyNP80Njf/TE9Q/2tub/9+goP/fIGB/4GGh/+Bhof/goaH/4KFh/+ChYj/goWH/4KFh/+ChYf/goaH/4KGh/+Chof/gYaH/4GGh/+Bhof/gYaH/4GFhv+BhYb/gIWG/4CEhv+AhIb/gISF/3+Ehf9/hIX/f4OF/3+DhP9+g4T/foOE/36DhP9+g4P/fYKD/32Cg/99gYL/fYGC/3yBgv98gYL/fICB/3uBgf97gIH/e4CA/3uAgP97gID/en9//3p/f/96fn//en5+/3l9fv95fX3/eXx9/3h8fP94fHz/eHt7/3d7e/93e3r/dnp6/3Z5ef92eXn/dnh4/3V4eP91d3j/dXd3/3V2dv90dnb/dHV1/3N1df9zdHT/cnNz/39/f/9/f3//f3+A/3+AgP9/gID/f4CA/3+AgP9/gID/f4CA/3+Bgf9/gYH/f4GB/3+Bgf9/gYL/gIKC/4CCgv+AgoP/gIKD/4CDhP+Bg4T/gYOE/4GDhP+BhIX/gYSF/4GEhf+BhIX/gYWF/4GFhv+BhYX/goWG/4KFhv+ChYf/goaH/4KGh/+Chof/goaH/4KGiP+Dh4j/g4eI/4OHiP+Dh4j/g4eI/4OHif+Dh4n/g4eJ/4SIif+EiIn/hIiJ/4SIif+EiIn/hIiJ/4SIif+EiIn/hIiJ/4SIif+DiIn/g4iJ/4OIif+Dh4n/hIeJ/3+Dhf9/g4X/d3t9/3R4ef9gZGb/ICMl/xAUGP8aHSL/ExYZ/xkcIf8SFBj/EhMW/w4QEv8OEBP/DA0P/xETFf8bHSD/DhAS/wgJCf8LDA3/DA4O/wwNDv8PEBH/CwwN/woLC/8PEBL/DA0O/wgJCf8KCwv/CAkJ/wcICP8JCQr/Cw0O/wsMDP8ICAn/CgsL/wgICf8EBAT/BwgJ/wwND/8NDg//DA4P/wkKC/8QEhT/CQsN/wkMDf8ICgv/CQwN/w0QE/8JDA7/Cw8R/wkLDv8PEhX/DA8R/xMWGP9fYmT/ODs8/0xPUP+ChYb/gISF/4KGiP+BhYf/gYaH/4KGh/+Chof/goaH/4KGh/+Chof/gYaH/4KGh/+BhYf/gYWH/4GGh/+BhYf/gYWG/4GFhv+BhYb/gIWG/4CEhv+AhIX/gISF/3+Ehf9/g4X/f4OF/36DhP9+g4T/foOE/36Cg/9+goP/fYKD/32Cg/99gYL/fYGC/3yBgv98gYL/fICB/3yAgf97gIH/e4CA/3uAgP97f3//en9//3p/f/96fn7/eX5+/3l+fv95fX3/eX19/3h8ff94fHz/eHt8/3d7e/93enr/d3p6/3Z5ef92eXn/dnh4/3Z4eP91d3f/dXd3/3V3d/90dnb/dHZ2/3R1df9zdXX/c3R0/3Jzc/9+f3//fn9//39/f/9+f3//fn9//3+AgP9/gH//f4CA/3+AgP9/gID/f4GB/3+Bgf9/gYH/f4GB/3+Cgv9/goL/gIKC/4CCg/+AgoP/gIOD/4CDhP+Ag4T/gYOE/4GDhP+BhIX/gYSF/4GFhf+BhYX/gYWG/4GFhv+BhYb/goWG/4KFhv+Chof/goaH/4KGh/+Chof/goaH/4KGiP+Ch4j/g4eI/4OHiP+DiIj/g4eI/4OHiP+Dh4n/g4eJ/4OHif+Dh4n/g4iJ/4SIif+DiIn/g4iJ/4OIif+DiIn/g4iJ/4OIif+Dh4n/g4eJ/4OHif+Dh4n/gYWG/3+Dhf98gIH/dHl6/2hsbv86PkD/Jysu/xwgI/8fIyf/Fhgb/xASFP8KCw7/EBEU/xUXGv8XGRz/ExUY/xIWF/8LDQ7/FRga/w8SFP8NDxD/EBMU/wsNDv8REhT/CwwM/wkKCv8LCwz/CgsM/woMDf8KCwz/CAkJ/wgKCv8ICgr/CgsL/wYHBv8HCAj/BwgJ/wkKC/8HBwj/Cw0O/xASFP8OEBH/CQoM/wcKDP8ICwz/Cg0O/wgLDP8LDhD/DhIU/wsOEP8KDhH/EhYY/x8jJv8YGx3/ODo8/0FERv9vcnP/gYWG/4KGh/+Chof/goaH/4KGh/+Chof/goaH/4KGh/+Chof/goWH/4KFh/+BhYf/gYWH/4GFh/+BhYf/gYWH/4CGhv+AhYb/gIWG/4CEhv+AhIX/gISF/3+Ehf9/g4X/f4OF/36DhP9+g4T/foOE/36DhP99g4P/fYOD/32Cg/99goL/fYGC/3yBgv98gYL/fICB/3yAgf97gIH/e4CA/3uAgP96gID/eoB//3p/f/96f37/en5+/3l+fv95fX7/eX19/3h9ff94fHz/eHx8/3d7fP93e3v/d3p7/3Z6ev92eXn/dnl5/3V4eP91eHj/dXd3/3V3d/91dnb/dHZ2/3R1dv9zdXX/c3R0/3JzdP9yc3P/fn9//35/f/9+f3//fn5//35/f/9+f3//f39//3+AgP9/gID/f4CA/3+AgP9/gIH/f4GB/3+Bgf9/gYH/f4GC/4CCgv+AgoL/gIKD/4CCg/+AgoP/gIOE/4CDhP+Bg4T/gIOE/4CEhf+BhIX/gYSF/4GEhf+BhYX/gYWG/4GFhv+ChYb/goWG/4KFh/+ChYf/goaH/4KGh/+Chof/goaI/4KHiP+Ch4j/g4eI/4OHiP+Dh4j/g4eI/4OHiP+Dh4n/g4eJ/4OHif+Dh4n/g4eJ/4OHif+Dh4n/g4iJ/4OHif+Dh4n/g4eI/4OHiP+Dh4j/goeI/4OHif+Choj/f4OE/3h8fv9ydnj/cXZ4/1FVWP82Oz3/Gx4i/xodIf8TFRn/ERMW/xESFf8SFRf/FBca/w8SFf8QExT/ERQW/xEUF/8OERH/GBse/w8SFP8MDg//EBIU/wkLC/8QERP/ExUW/xASFP8PERL/Cw0N/w0PEP8LDA3/DhES/wwPEP8JCwz/BwgI/wkKC/8KCwz/CgsM/w4PEf8ICgr/CQoM/woMD/8LDhH/CgwO/woNDv8JDA7/CQsO/wsOEf8RFBf/ERUX/zU5O/8yNjn/TE9R/2pub/9xdHX/eX1+/4GFhv+Bhof/gYaG/4GGh/+Bhof/goaH/4GFh/+Bhof/gYaH/4KFh/+BhYf/gYWH/4GFh/+BhYf/gYWG/4CFhv+AhYb/gIWF/4CEhv+AhIX/gISF/3+Ehf9/g4X/f4OF/36DhP9+g4T/foOE/36DhP9+goP/fYKD/32Cgv99goL/fIGC/3yBgv98gYL/fIGB/3yAgf97gIH/e4CA/3uAgP97f4D/en9//3l/f/96f3//en5+/3l+fv95fX7/eX19/3l9ff94fH3/eHx8/3h7fP93e3v/d3p7/3d6ev92enn/dnl5/3Z4eP91eHj/dXh3/3V3d/91d3f/dHZ2/3R2dv90dXX/c3V1/3N0dP9yc3P/cnNz/35/f/9+f3//fn9//35/f/9+gH//fn9//35/f/9+f3//f39//36AgP9/gID/f4CA/3+Agf9/gYH/f4GB/3+Cgf9/goL/f4KC/3+Cgv+AgoP/gIKD/4CCg/+AgoP/gIOE/4CDhP+Ag4T/gISF/4CEhf+BhIX/gYSF/4GEhf+BhYb/gYWG/4GFhv+BhYb/goWG/4KFh/+ChYf/goaH/4KGh/+Chof/goeH/4KHiP+Dh4j/g4eI/4OHiP+Dh4j/g4eI/4OHiP+Dh4j/g4eJ/4OHiP+Dh4j/g4eI/4OIiP+DiIj/g4eI/4OHiP+Dh4j/goeI/4KGiP+Choj/goWH/4SIif9+goP/dnp8/3R5ev9YXV7/RktN/yMnKv8ZHSH/EBMW/xUXGv8UFxr/DA0R/xETFv8VGBv/ERMX/xcaH/8QExX/DxIV/xQYHP8RFRj/FBca/w4REv8RExX/ERQV/wsOD/8RExX/ERMU/xETFP8SFBb/DQ8Q/wwPEP8MDg7/Cg0O/wcJCf8KDA3/CQoL/wkKC/8LDhD/CQsN/woMDv8ICgz/CAsN/wwQEv8PEhX/DRAR/wkMDv8UGBr/Gh4g/zQ3Of9fY2T/YWVm/25xc/9zdnf/eXx+/4GEh/+BhYf/gYWH/4GGh/+Bhof/gYaH/4GGh/+BhYf/gYaH/4GGh/+BhYf/gYWH/4GFh/+BhYf/gYWG/4CFhv+AhYb/gIWG/4CFhv+AhIX/f4SF/3+Ehf9/g4X/f4OF/36DhP9+g4T/foOE/36ChP99goP/fYKD/32Cg/99goL/fYKC/3yBgv98gYL/fIGB/3yAgf98gIH/e4CB/3uAgP97f4D/en9//3p/f/96f3//eX9+/3l+fv95fn7/eX19/3h9ff94fH3/eHx8/3h7fP93e3v/d3p7/3d6ev92enr/dnl5/3Z5ef91eHj/dXh3/3V3d/91d3f/dHZ2/3R2dv90dXX/dHV1/3N1dP9ydHT/cnNz/3Jzcv9+f37/fn9+/35/f/9+f3//fn9//35/f/9+f3//fn9//35/f/9+f3//f4CA/3+AgP9/gID/f4CB/3+Bgf9/gYH/f4GB/3+Bgv9/goL/f4KC/4CCg/+AgoP/gIKD/4CChP+Ag4T/gIOE/4CDhP+AhIT/gISE/4GEhf+BhIX/gYSF/4GFhf+BhYb/gYWG/4GFhv+BhYb/goWH/4KFh/+Chof/goaH/4KGh/+Chof/goeH/4KGh/+Choj/goaI/4KGiP+Dh4j/g4eI/4OHiP+Choj/goeI/4OHiP+Ch4j/goeI/4KHiP+Ch4j/goeI/4KHiP+Choj/goaI/4KGh/+AhIb/gISG/4CEhf94fH7/dHh4/2BkZf9GS03/MTU5/y4yNf8uMjX/MTU3/ysvMv8rLjH/Ky8y/xEUGP8OERP/DxIW/xMXGv8SFRn/ERUY/xETFv8UGBr/ERQW/w4SFP8PEhX/DxEU/w8SFf8SFBj/ERMW/w4RE/8NERP/EBQW/wsOEP8LDhD/Cw0P/w0PEf8KCw3/CQoM/wwOEP8LDRD/CQwO/wsND/8UGBv/DhEU/x8jJf8QExX/ICQm/ygsLf9oa2z/eX19/3+DhP99gYL/fYGC/36ChP+AhIb/gYWH/4GFh/+BhYf/gYWH/4GGh/+BhYf/gYWH/4GGh/+BhYf/gYWH/4GFh/+BhYf/gYWG/4CFhv+AhIb/gISG/4CEhv+AhIX/f4SF/3+Ehf9/hIX/f4OF/3+DhP9+g4T/foOE/36ChP9+goP/fYKD/32Cg/99goP/fYKC/3yBgv98gYL/fIGB/3yBgf98gIH/e4CB/3t/gP97f4D/en+A/3p/f/96f3//eX5//3l+fv95fn7/eX1+/3l9ff94fX3/eHx8/3h8fP94e3z/d3t7/3d6e/93enr/dnl6/3Z5ef92eHj/dnh4/3V4d/91d3f/dXd3/3R2dv90dnX/dHV1/3R1df9zdHT/c3R0/3Jzc/9xc3L/fX5+/31+fv99fn7/fX5+/35/f/9+f3//fn9//35/f/9+f3//fn9//35/f/9+gID/fn+A/3+AgP9/gIH/foCB/3+Bgf9/gYH/f4GC/3+Bgv9/goL/f4KD/3+Cg/+AgoP/gIKD/4CDg/+Ag4T/gIOE/4CDhP+Ag4T/gISE/4GEhf+BhIX/gYSF/4GEhv+BhIb/gYWG/4GFhv+BhYf/gYWH/4KGh/+Chof/goaH/4KGh/+Chof/goaH/4KGh/+Choj/goaH/4KGiP+Choj/goaI/4KGiP+Choj/goaI/4KHiP+Choj/goaI/4KGiP+Choj/goaI/4KGh/+Chof/gYWG/36ChP+BhIb/gISF/36Cg/95fX7/cnd4/0xQU/9NUVT/PUJE/05RU/9FSEv/LDA0/x0hJf8YGyD/Fhke/xATF/8aHiL/GRwh/w4QE/8VGBv/ExYZ/wwPEf8QExX/DxEU/wsOEf8QFBf/FBcb/w0PEv8OERT/FBcb/wwQE/8NERP/EBQW/w0PEv8SFRj/ExYY/wwOEP8KDA7/EhQY/w8SFv8aHB7/QUVI/y4xM/8+QUP/W15f/19jZP9vcnP/foGB/32Bgf+Ag4T/gIOF/3+Ehf9/g4X/f4OF/4GEhv+BhYf/gYWH/4GFh/+BhYf/gYWH/4GFh/+BhYf/gYWG/4GFhv+BhYb/gYWG/4CFhv+AhIb/gISG/4CEhv9/hIX/f4SF/3+Ehf9/hIX/f4OE/3+DhP9+g4T/foOE/36ChP9+goP/fYKD/32Cg/99gYP/fYGC/3yBgv98gYL/fIGC/3yBgf97gIH/e4CB/3uAgP97f4D/e3+A/3p+gP96fn//en5//3l+fv95fn7/eX1+/3l9ff94fX3/eH18/3h8fP94fHz/d3t7/3d7e/93env/dnl6/3Z5ev92eHn/dXh4/3V4eP91d3f/dXd3/3R3dv90dnb/dHZ1/3R1df9zdXX/c3R0/3N0dP9yc3P/cXJy/31+fv99fn7/fX5+/31+fv99fn7/fX5+/31+fv9+fn//fn9//35/f/9+f3//fn9//36AgP9/gID/f4CA/36Agf9+gIH/f4GB/3+Bgf9/gYL/f4GC/3+Bgv9/goL/f4KC/3+Cg/9/goP/gIOD/4CDhP+Ag4T/gISE/4CDhP+AhIX/gISF/4CEhf+AhIX/gYSG/4GEhv+BhIb/gYWG/4GFhv+BhYb/gYWH/4GFh/+Chof/goaH/4KGh/+Chof/goaH/4KGh/+Chof/goWH/4KGh/+Chof/goaI/4KGh/+Choj/goaH/4KGiP+Choj/goaH/4KGh/+Chof/goWH/4KGh/+AhIb/f4KE/4GFhv+Bhof/f4KE/3h8ff9aX2H/bnN1/11hY/9HS0z/ZWlq/0dLTv9DR0r/Jisv/yImKv8gJCf/GBsf/yUpLP8YGh3/Jyot/xcbH/8PExb/ERUY/woND/8JCw3/DxIU/xYZHv8SFRn/ExUZ/xIVGf8NEBT/Fhof/xcbIP8QFBf/Ki4x/yQoLP8UFxr/DQ8T/xYZHf8VGBz/Oj1A/2ptbv9+gYH/f4GB/3+Cgv9/goP/f4SE/4KGhv+ChYb/gYSF/4CEhv+AhIb/gISG/4GFh/+BhIb/gYWH/4GFh/+BhYf/gYWH/4GFh/+BhYb/gYWH/4GFhv+AhYb/gIWG/4CEhv+AhIb/gISF/4CEhf+AhIX/f4SF/3+Ehf9/g4X/f4OF/3+DhP9+g4T/foOE/36ChP9+goP/fYKD/32Cg/99gYP/fYGD/3yBgv98gYL/fIGC/3yAgf98gIH/e4CB/3uAgP97f4D/en+A/3p/gP96f3//en5//3p9fv95fn7/eX1+/3l9ff94fX3/eHx9/3h8fP94fHz/d3t7/3d7e/93env/d3p6/3Z5ev92eXn/dnh5/3V4eP91d3f/dXd3/3R3d/90dnb/dHZ2/3R1df9zdXX/c3V0/3N0dP9yc3P/cnNz/3Fycv99fX3/fX1+/31+fv99fn7/fX5+/31+fv9+fn7/fn5+/31+f/9+f3//fn9//35/f/9+f4D/fn+A/36AgP9+gID/foCB/36Agf9/gYH/f4GB/3+Bgv9/gYL/f4GC/3+Bg/9/goL/f4KD/3+Cg/9/goP/gIKD/3+DhP+Ag4T/gIOE/4CDhP+AhIX/gISF/4CEhf+AhIX/gYSG/4GEhv+BhIb/gYWG/4GFhv+BhYb/gYWG/4GFh/+BhYf/gYaH/4KGh/+BhYf/goaH/4KGh/+Chof/goaH/4KGh/+Chof/goaH/4KGh/+Chof/goaH/4KGh/+Chof/goaH/4KGh/+Bhof/goaI/4GEhv9/goT/foKE/3+DhP+Bhof/dXh6/1ldX/9eYWP/a25v/3h8ff9jZmj/ODw//y4yNf8oLDD/NTk7/xseIP8iJSf/REZJ/0xPUv8iJSj/Fhkd/w4SFv8MDxH/DA4R/w0QE/8QExb/Fxsf/xkcH/8hJCf/Gx4h/x8jJ/8eIyj/Njs+/y0yNf85PkD/RklM/y0vMf8JCw7/Ky4w/2ttb/97fX7/e35//3x/gf97f4H/gYSF/36Bgv+AhIX/goaG/4GFhv+BhYb/gYSG/4GFhv+BhYb/gYWG/4GFh/+BhYf/gYWH/4GFh/+BhYb/gIWG/4CFhv+AhYb/gISG/4CEhv+AhIb/gISG/4CEhf9/hIX/f4SF/3+Dhf9/g4X/f4OE/36DhP9+g4T/foKE/36ChP9+goP/fYKD/32Cg/99gYP/fYGD/3yBgv98gYL/fIGC/3yAgf97gIH/e4CB/3uAgP97f4D/en+A/3p/f/96fn//en9//3p+f/95fn7/eX1+/3l9ff94fX3/eH19/3h8fP94fHz/d3t7/3d7e/93e3v/d3p6/3d6ev92eXr/dnl5/3Z4eP91d3j/dXd3/3R2d/90dnb/dHZ2/3R1df9zdXX/c3V1/3N0dP9yc3T/cnNz/3Fycv9xcnL/fX19/319ff99fX3/fX59/31+fv99fn7/fX5+/31+fv99fn7/fX9+/35+f/99f3//fn9//35/gP9+f4D/foCA/36AgP9+gIH/foCB/36Agf9+gYH/f4GC/3+Bgv9/gYL/f4GC/3+Bgv9/gYP/f4GD/3+Cg/9/goP/f4KE/4CChP+Ag4T/gIOE/4CDhP+Ag4X/gISF/4CEhf+AhIX/gISF/4GEhv+BhIb/gYSG/4GEhv+BhYb/gYWG/4GFhv+BhYf/gYWG/4GFh/+BhYf/gYWH/4GEh/+BhYf/gYWH/4KFh/+BhYf/goaH/4KGh/+Bhof/goaH/4GGh/+BhYf/gYWH/4GFh/+ChYf/goWH/4GFh/+BhIb/fYGD/4GFhv9/g4T/d3t8/3yAgf9/goT/foGC/0dKTf9NUFL/T1NV/zo8Pv89P0H/YWNl/21wcv9cYGP/Ki0w/xQYG/8bHyL/Fhod/yksL/8qLDD/NTg7/0FERv89QUP/MjU4/yosL/8qLTH/RktO/0RJS/9BRUf/XmJk/11gYf9ucXP/WVxe/21vcP9/gYL/f4KD/4GDhP+Ag4T/fYGC/4GFhv+AhIX/fYGC/4GGhv+BhYb/gYWG/4CEhv+BhIb/gYSG/4CEhv+BhIb/gYWG/4CFhv+AhYb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIX/gISF/4CDhf9/g4X/f4OF/3+Dhf9+g4X/foOE/36DhP9+g4T/foKE/32ChP99goP/fYKD/32Cg/99gYP/fYGC/3yBgv98gIL/fICC/3yAgf98gIH/e4CB/3uAgf97f4D/en+A/3p/gP96f3//en5//3p+f/95fX7/eX1+/3l8ff95fX3/eHx9/3h8ff94fHz/d3x8/3d7e/93e3v/d3p7/3Z6ev92eXn/dnl5/3Z4eP91eHj/dXd4/3V2d/90dnb/dHZ2/3R2df9zdXX/c3V1/3N0dP9ydHT/cnNz/3Fzc/9xcnL/cXFx/319ff99fX3/fX19/319ff99fX7/fX59/31+fv99fn7/fX5+/31+fv99f37/fX5//35/f/9+f4D/fn+A/35/gP9+gID/foCA/36AgP9+gID/foCB/36Agf9+gYH/f4GB/3+Bgv9/gYL/f4GC/3+Bg/9/gYP/f4KD/3+Cg/9/goP/f4KE/3+DhP+Ag4T/gIOE/4CDhf+Ag4X/gISF/4CEhf+AhIX/gISG/4GEhv+BhIb/gYWG/4GFhv+BhYb/gYWG/4GFhv+BhYb/gYWG/4GFh/+BhYf/gYWH/4GFh/+BhYf/gYWH/4GFh/+BhYf/gYWH/4GFh/+BhYf/gYWH/4GFh/+BhYf/gYWH/4GFh/+BhYf/gYWH/4GFh/+BhYf/gYWH/36Cg/9+goP/gISF/3+DhP99gIH/bHBx/3J2d/+Ag4T/goWG/3l9ff9tcHH/ZGdp/1JVWP8qLzH/HyMm/xgaHP9NUFL/Vllb/11gYf9gY2X/YGNk/1FUVv8/QkX/Nzs+/0BER/9GSk3/XF9h/2JlZf9ydXb/en5+/3+Cg/+ChYb/gIOE/4CDhP+Dhof/gISF/3+DhP+AhYb/gYWG/36Cg/+AhIX/gYWG/4GEhv+BhYb/gYSG/4CEhv+AhIb/gISG/4GEhv+AhYb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIX/f4SF/3+Ehf9/hIX/f4OF/3+Dhf9/g4T/f4OE/36DhP9+goT/foKE/36ChP9+goP/fYKD/32Cg/99gYL/fIGC/3yBgv98gYL/fIGC/3yAgv98gIH/e4CB/3uAgf97f4D/e3+A/3p/gP96f3//en5//3p+f/95fn7/eX1+/3l9fv95fX7/eH19/3h8ff94fHz/eHt8/3d7fP93e3v/d3t7/3d6ev92eXr/dnl5/3Z5ef91eHj/dXd4/3V3eP90dnf/dHZ2/3R2dv90dXX/c3V1/3N0dP9zdHT/cnRz/3Jzc/9yc3P/cXJy/3Fycf98fX3/fH19/3x9ff98fX3/fH19/319ff99fX3/fX5+/31+fv99fn7/fX5+/31+fv99f3//fX9//35+f/99f4D/fn+A/35/f/9+gID/foCB/36Agf9+gIH/foCB/36Agf9+gIH/foGB/3+Bgv9/gIL/f4CC/3+Bg/9/goP/f4KD/3+Cg/9/goT/f4OE/3+DhP+Ag4T/gIOE/4CDhf+Ag4X/gIOF/4CDhf+Ag4X/gISF/4CEhf+AhIb/gYSG/4GFhv+BhIb/gYWG/4GFhv+BhYb/gYWG/4GEhv+BhYf/gYWG/4GFh/+BhYf/gYSH/4GFh/+BhYf/gYWH/4GFh/+BhYf/gYWH/4GFh/+BhYf/gYSH/4GEh/+BhYf/gYWH/4KFh/99gYP/gISF/4KGh/+Bhof/gYSF/4GEhf+ChYb/f4KD/36Bgv99gIH/dnl6/3F0df9mamz/UlZZ/zU5PP9KTU//Z2ts/2xwcv9na2z/bHBx/3Z5ev9ydnj/bnJ0/2Nnaf9WWl3/b3N1/1teYP9pbW//foKD/3+Cg/9+gYL/f4KE/3+Cg/9/goP/gYWG/4GEhv+AhIb/gISG/4GEhv99gYP/gYSG/4GFhv+AhYb/gISG/4CEhv+AhIb/gISG/4CEhv+Ag4b/gISG/4CDhv+Ag4b/gISF/4CEhf+AhIX/f4SF/3+Ehf9/g4X/f4OF/3+DhP9/g4T/foOE/36ChP9+goT/foKE/32Cg/99goP/fYKD/32Cg/99gYP/fYGC/3yBgv98gYL/fICC/3yAgf98f4H/e4CB/3uAgf97f4D/e3+A/3p/gP96f3//en5//3p+f/95fn7/eX5+/3l9fv95fX3/eHx9/3h8ff94e3z/eHt8/3d7fP93e3v/d3t7/3d6e/92enr/dnp6/3Z5ef92eHn/dXh4/3V3eP90dnf/dHZ3/3R2dv90dXb/c3V1/3N1dP9zdHT/cnR0/3Jzc/9yc3P/cXJy/3Fycv9wcXH/fHx8/3x9ff98fX3/fH19/3x9ff98fX3/fH19/3x9ff99fn7/fX5+/31+fv99fn7/fX5//31+f/99f3//fX5//35/f/9+f4D/fn+A/36AgP9+gID/foCA/36AgP9+gIH/foCB/36Agf9+gYH/foCC/3+Bgv9/gYL/f4GD/3+Cg/9/gYP/f4KD/3+Cg/9/goP/f4KE/3+DhP+Ag4T/gIOE/4CDhf+Ag4X/gISF/4CDhf+AhIX/gISF/4CEhv+AhIX/gISG/4CEhv+BhIb/gISG/4GEhv+BhYb/gYSG/4GEhv+BhIb/gYSG/4GFh/+BhYb/gYWG/4GFh/+BhYf/gYWH/4GFhv+BhYb/gYWG/4GFh/+BhIf/gYWH/4GFh/+BhYf/gYWH/4GFh/+BhYb/gYWG/4GFhv+BhYb/gYWG/4KFhv+ChYf/gYSF/3+Cg/+Ag4T/dXl6/3V4ev95fX7/eHx9/3p+f/97foD/fYGC/3V6e/92enz/en6A/3l9f/9zd3n/aW1v/2Vpa/9vc3X/fYGC/32Agv+AhIX/f4OF/36Cg/9+gYL/f4OE/4GEhv+BhIb/gISG/4GEhv9/g4X/f4KE/4GFh/+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+Ag4X/gISG/4CEhv+AhIb/gISF/4CEhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+DhP9+g4T/foKE/36ChP9+goT/foKE/32ChP99goP/fYGD/32Bg/99gYP/fYGC/3yBgv98gYL/fIGC/3yAgf98gIH/e4CB/3t/gf97f4D/e3+A/3p/gP96f4D/en9//3p+f/95fn//eX5+/3l9fv95fX7/eH19/3h8ff94fHz/eHx8/3h7fP93e3v/d3t7/3d6e/93enr/dnp6/3Z5ef91eHn/dXh4/3V3eP91d3f/dHZ3/3R2dv90dnb/c3V1/3N1df9zdHT/c3R0/3J0c/9yc3P/cXNy/3Fycv9wcXH/cHFx/3x8fP98fHz/fHx9/3x9ff98fX3/fH19/3x9ff98fX3/fH19/319ff99fn7/fX5+/31+fv99fn//fX5//31/f/99f3//fX9//31/gP9+f4D/fn+A/36AgP9+gID/foCA/36Agf9+gIH/foCB/36Agv9+gIL/foGC/36Bgv9+gYL/foGD/3+Cg/9/goP/f4KD/3+ChP9/goT/f4OE/4CDhP9/goT/f4KE/4CDhf+Ag4X/gIOF/4CEhf+AhIX/gISF/4CEhf+AhIX/gISF/4CEhv+AhIb/gISG/4GEhv+BhIb/gYSG/4GEhv+BhIb/gYWG/4GFhv+BhYb/gYWG/4GFhv+BhYb/gYWG/4GFhv+BhYf/gYWH/4GFhv+BhYf/gYWH/4GFh/+BhYf/gYWH/4GFhv+BhYb/gYWG/4GFhv+BhYb/goWH/4KFh/9/goP/fYCB/36Bgv96fn//gIOF/4CDhP+AhIX/gISG/36ChP9+goP/fICB/3p+gP96fn//e3+B/32Agv97f4H/foKE/36Cg/9+goP/f4SF/4CEhv+BhIb/gYWG/4CEhv+AhIb/gYSG/4CEhv+AhIb/gISG/4GEhv+AhIb/gISG/4CEhv+AhIb/gIWG/4CEhf+AhIX/gISF/4CEhv+AhIX/gIOF/4CDhf9/g4X/f4OF/3+Dhf9/g4X/f4OE/3+DhP9+g4T/foKE/36ChP9+goT/foKD/36Cg/99goP/fYKD/32Bg/98gYL/fIGC/3yBgv98gYL/fICC/3yAgf97gIH/e4CB/3t/gf97f4H/e36A/3p+gP96fn//en5//3p+f/96fn//eX5+/3l+fv95fX7/eH19/3h8ff94fH3/eHt8/3h7fP93e3z/d3t7/3d6e/93env/dnp6/3Z5ef92eXn/dXh4/3V4eP91d3f/dHd3/3R2d/90dnb/dHV2/3N1df9zdHX/c3R0/3J0dP9yc3P/cXNz/3Fycv9xcnL/cHFx/3BxcP97fHz/e3x8/3t8fP98fHz/fHx8/3x8ff98fHz/fH19/3x9ff98fX3/fX19/31+fv99fn7/fX5+/31+f/99fn//fX5//31/f/99f3//fX+A/31/gP99f4D/fYCA/32AgP9+gID/foCB/36Agf9+gIH/foCB/36Agv9+gIL/foGC/36Bgv9+gYL/f4GD/3+Cg/9/goP/f4KD/3+Cg/9/g4P/f4KE/3+ChP+Ag4T/gIOF/4CDhP+Ag4X/gIOF/4CDhf+AhIX/gISF/4CEhf+AhIX/gISF/4CEhf+AhIX/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gIWG/4CFhv+AhIb/gYSG/4GEhv+BhIb/gYSG/4GFhv+BhYf/gYWH/4GFhv+BhYb/gYWG/4GFhv+BhYb/gYWG/4GFhv+BhIb/gYWG/36ChP98f4H/en5//32Bg/+AhIX/gYSG/4CEhv+AhIX/gISF/4GFhv+BhYb/gISG/4GFh/+BhIf/gIOF/36ChP9/g4T/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+Ag4b/gIOG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISF/4CEhf+AhIX/f4SF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4T/foOE/36DhP9+g4T/foOE/36ChP9+goT/fYKD/32Cg/99gYP/fYGD/32Bg/98gYL/fIGC/3yBgv98gYL/fICC/3uAgf97gIH/e4CB/3uAgP97f4D/en+A/3p+gP96f3//en5//3p+f/96fn//eX5+/3l+fv95fX7/eH19/3h8ff94fHz/eHx8/3h7fP93e3z/d3t7/3d6e/93env/dnp6/3Z5ef92eXn/dXh5/3V4eP91d3j/dHd3/3R2d/90dnb/dHV2/3N1df9zdXX/c3R0/3J0dP9yc3P/cXNz/3Fycv9xcnL/cHJy/3Bxcf9vcHD/e3t8/3t8fP97fHz/e3x8/3t8fP97fHz/e3x8/3t8fP98fX3/fH19/3x9ff98fn3/fX5+/31+fv99fn7/fX5//31+f/99f3//fX9//31/f/99f3//fX+A/31/gP99gID/fYCA/36AgP9+gIH/foCB/36Agf9+gIH/foGB/36Bgv9+gYL/foGC/36Bgv9+goL/foKD/3+Cg/9+goP/f4KD/3+Cg/9/goT/f4OE/3+DhP9/g4T/f4OE/3+Dhf9/g4X/f4OF/4CEhf+AhIX/gISF/4CEhP+AhIX/gISF/4CEhf+AhIX/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+BhIb/gYSG/4GEhv+AhYb/gYWG/4GFhv+BhYb/gYWG/4GFhv+BhYb/gYWG/4KGh/+Chof/gYWG/32Bg/99gYP/f4OE/4GFh/+AhIb/foKE/4CEhf+AhIb/gISG/4CFhv+AhIb/gISG/4GEhv+BhIb/gYSG/4GEhv+BhIb/gYSH/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIX/f4SF/3+Ehf9/hIX/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4T/foOE/36DhP9+g4T/foKE/36ChP99goP/fYKD/32Cg/99gYP/fYGD/32Bg/98gYL/fIGC/3yAgv98gIL/fICB/3uAgf97gIH/e4CB/3uAgP97gID/en+A/3p/gP96f3//en5//3p+f/96fn//eX5+/3l+fv95fX7/eH19/3h9ff94fH3/eHx8/3d8fP93e3z/d3t7/3d6e/93env/dnp6/3Z5ev92eXn/dXl5/3V4ef91eHj/dXd3/3R3d/90dnb/dHZ2/3N1df9zdXX/c3R1/3J0dP9ydHT/cnNz/3Fzcv9xcnL/cXJy/3Bxcf9vcXD/b3Bw/3t7e/97e3v/e3x8/3t8fP97fHz/e3x8/3t8fP97fHz/fHx8/3x9ff98fX3/fH19/3x+ff98fn7/fX5+/31+fv99fn7/fX5//31+f/99f3//fX9//31/gP99f4D/fX+A/31/gP99gID/foCA/36Agf9+gIH/foCB/36Agf9+gIH/foCC/36Bgv9+gYL/foGC/36Bgv9+goL/foKD/36Cg/9/goP/f4KD/3+Cg/9/goT/f4KE/3+ChP9/goT/f4OE/3+DhP9/g4T/f4OE/3+Dhf9/g4X/gIOF/4CDhf+Ag4X/gIOF/4CDhf+AhIX/gISF/4CEhf+AhIX/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gIWG/4CFhv+AhYb/gIWG/3+DhP+AhIX/f4OF/32Bgv9/g4X/gYWG/4GFhv+AhIb/gYSH/4GFh/+AhIb/gISG/4CEhv+AhIb/gIWG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/f4OF/3+Ehf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4T/f4OE/36DhP9+g4T/foOE/36ChP9+goT/foKE/32Cg/99goP/fYKD/32Cg/99gYP/fYGC/3yBgv98gYL/fIGC/3yBgv98gIL/e4CB/3uAgf97gIH/e4CB/3uAgP97f4D/en+A/3p/gP96f3//en5//3p+f/95fn//eX5+/3l9fv95fX7/eH19/3h9ff94fH3/d3x8/3d7fP93e3v/d3t7/3d7e/93env/d3p6/3Z5ev92eXr/dXl5/3V4ef91eHj/dXd3/3R3d/90dnb/dHZ2/3N1dv9zdXX/c3R1/3N0dP9yc3T/cnNz/3Fzc/9xcnL/cXJy/3Bycf9wcXH/b3Fw/29wcP97e3v/e3t7/3t7e/97e3v/e3x8/3t8fP97fHz/e3x8/3t8fP97fXz/fH19/3x9ff98fX3/fH1+/3x+fv98fn7/fX5+/31+f/99fn//fX5//31/f/99fn//fX9//31/f/99f4D/fX+A/32AgP99gID/fYCA/36Agf9+gIH/foCB/36Agf9+gIH/foGC/36Bgv9+gYL/foGC/36Bgv9+goL/foKD/36Cg/9+goP/f4KD/3+ChP9/goT/f4KE/3+ChP9/g4T/f4OE/3+DhP9/g4T/f4OE/3+DhP9/g4X/f4OF/3+Dhf9/g4X/gIOF/3+Dhf+AhIX/gISF/4CEhf+AhIX/gISF/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CFhv+AhIb/foKE/3+DhP9/g4X/gISF/4CEhv+AhIb/f4SG/4CEhv9/hIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv9/hIb/f4SF/3+Ehf9/hIX/f4SF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OE/36Dhf9+g4X/foOE/36DhP9+g4T/foKE/36ChP9+goT/foKE/32Cg/99goP/fYKD/32Cg/99gYP/fIGC/3yBgv98gYL/fIGC/3yBgv98gIL/fICC/3uAgf97gIH/e4CB/3uAgP96f4D/e3+A/3p/gP96f3//en5//3p+f/96fn//eX5+/3l9fv95fX7/eH19/3h9ff94fH3/eHx8/3d8fP93e3z/d3t7/3d6e/93env/dnp6/3Z6ev92eXr/dnl5/3V4ef91eHj/dXd4/3R3d/90d3f/dHZ2/3R2dv90dXX/c3V1/3N0dP9zdHT/cnN0/3Jzc/9xcnL/cXJy/3Bxcf9wcXH/cHFw/29wcP9ucG//ent7/3p7e/96e3v/ent7/3p7e/97e3v/ent7/3t8fP97fHz/e3x8/3t9fP98fX3/fH19/3x9ff98fX7/fH1+/3x+fv98fn7/fH5+/3x+fv98fn//fX5//31/f/99f3//fX9//31/f/99f4D/fYCA/32AgP99gID/fYCB/32Agf99gIH/foCB/32Agf9+gIH/fYGC/36Bgv9+gYL/foKC/36Cgv9+goP/foKD/36Cg/9+goP/foKD/36Cg/9/goT/f4KE/3+ChP9/g4T/f4OE/3+DhP9/g4T/f4OE/3+DhP9/g4T/f4OE/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4SF/4CEhf+AhIX/gISF/4CEhf+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gIWG/4CFhv+AhYf/gISG/4CEhv+AhIf/gIWG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CEhv+AhIb/gISG/4CFhv+AhIb/gISG/4CEhv+AhIb/gISG/3+Ehv9/hIX/f4SF/3+Ehf9/hIX/f4SF/3+Ehf9/hIX/f4SF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/foOF/36DhP9+g4T/foOE/36DhP9+g4T/foOE/36DhP9+g4T/foKE/36ChP99goT/fYKD/32Cg/99goP/fYKD/32Cg/98gYP/fIGC/3yBgv98gYL/fIGC/3yBgv98gIL/e4CB/3uAgf97gIH/e4CB/3uAgP96f4D/en+A/3p/gP96f3//en9//3l+f/95fn//eX5+/3l9fv95fX7/eH19/3h9ff94fH3/eHx8/3d8fP93e3z/d3x7/3d7e/92e3v/dnp6/3Z6ev92eXr/dXl5/3V4ef91eHj/dXh4/3R3d/90d3f/dHZ2/3R2dv9zdnX/c3V1/3N1df9ydHT/cnR0/3Jzc/9xc3P/cXJy/3Bycf9wcXH/cHFx/29wcP9ucHD/bm9v/3p7ev96e3v/ent7/3p7e/96e3v/ent7/3p7e/96e3v/e3x8/3t8fP97fHz/e318/3t9ff98fX3/fH19/3x9fv98fX7/fH5+/3x+fv98fn7/fX5+/3x+f/99fn//fX5//3x/f/98f3//fX9//31/f/99f4D/fX+A/31/gP99gID/fYCB/32Agf99gIH/fYCB/32Agf99gIH/fYGC/36Bgv9+gYL/foGC/36Bgv9+gYP/foKD/36Cg/9+goP/foKD/36Cg/9+goP/foKE/36ChP9+goT/foKE/3+ChP9/g4T/f4OE/3+DhP9/g4T/f4OE/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/hIX/f4SF/3+Ehf+AhIX/f4SF/4CEhf+AhIX/gISF/4CEhf+AhIb/gISG/4CEhv+AhIb/f4SF/3+Ehf9/hIX/f4SF/4CEhv9/hIb/f4SG/3+Ehv9/hIb/f4SG/3+Ehv+AhIb/f4SG/3+Ehv9/hIX/f4SF/3+Ehv9/hIb/f4SF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/36DhP9/g4X/f4OF/36Dhf9/g4T/foOE/36DhP9+goT/foKE/36ChP9+goT/foKE/36ChP9+goT/foKE/32ChP99goP/fYKD/32Cg/99goP/fYGD/32Bg/98gYP/fIGC/3yBgv98gYL/fIGC/3yAgv97gIH/e4CB/3uAgf97gIH/e4CB/3t/gf96gID/en+A/3p/gP96f4D/eX5//3l+f/95fn7/eX5+/3l9fv95fX7/eH19/3h8ff94fH3/eHx8/3d8fP93e3z/d3t7/3d7e/92enr/dnp6/3Z6ev92eXr/dnl5/3V5ef91eXn/dXh4/3V3eP90d3f/dHd3/3R2dv9zdnX/c3V1/3N1dP9zdHT/cnR0/3Jzc/9xc3P/cXJy/3Fycv9wcXH/cHFx/29xcP9vcHD/bm9v/25vbv96enr/enp6/3p6ev96e3v/ent7/3p7e/96e3v/ent7/3p7e/97fHz/e3x8/3t8fP97fHz/e319/3x9ff98fX3/fH19/3x9fv98fX7/fH1+/3x+fv98fn7/fH5//3x+f/98fn//fH9//3x/f/99f3//fX+A/31/gP99f4D/fX+A/31/gP99gID/fYCB/32Agf99gIH/fYCB/32Bgf99gYH/fYGB/36Bgv9+gYL/foGC/36Bgv9+gYL/foGD/36Bg/9+goP/foKD/36Cg/9+goP/foKD/36Cg/9+goP/foOD/36ChP9+g4T/foOE/3+DhP9/g4T/f4OE/3+DhP9/g4T/f4OF/3+Dhf9/g4X/f4OF/3+Ehf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4SF/3+Ehf9/hIX/f4SF/3+Ehf9/hIX/f4SF/3+Ehf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/hIX/f4SF/3+Ehf9/hIX/f4SF/3+Ehf9/hIX/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/foOF/36Dhf9+g4T/foOE/36DhP9+g4T/foKE/36ChP9+goT/foKE/36ChP9+goT/foKE/32ChP99goP/fYKE/32Cg/99goP/fYKD/32Cg/99gYP/fYGD/3yBg/98gYL/fIGC/3yBgv98gYL/fIGC/3uAgv97gIH/e4CB/3uAgf97gIH/e3+B/3t/gP96f4D/en+A/3p/gP96f3//en5//3l+f/95fn//eX5+/3l+fv95fX7/eH19/3h8ff94fH3/eHx9/3d8fP93e3z/d3t7/3d7e/92env/dnt6/3Z6ev92enr/dnl5/3Z5ef91eHj/dXh4/3V3eP90d3f/dHd3/3R2dv9zdnb/c3V1/3N1df9zdXT/cnR0/3J0dP9yc3P/cXNy/3Fycv9wcXH/cHFx/29xcP9vcHD/b3Bw/25vb/9ub2//enp6/3l6ev96enr/enp6/3p6ev96e3v/ent7/3p7e/96e3v/ent7/3t8fP97fHz/e3x8/3t8fP97fX3/e319/3t9ff98fX3/fH19/3x9fv98fX3/fH5+/3x+fv98fn7/fH5//3x+f/98fn//fH9//31/f/99f3//fX9//31/gP99f4D/fX+A/32AgP99gID/fYCB/32Agf99gIH/fYCB/32Agf99gYH/fYGC/32Bgv99gYL/foGC/36Bgv9+gYL/foGD/36Bg/9+goP/foKD/36Cg/9+goP/foKD/36Cg/9+goP/foKD/36Cg/9+goT/foKE/36ChP9/g4T/f4OE/3+DhP9/g4T/f4OE/3+DhP9/g4T/f4OE/3+DhP9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Ehf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9+g4X/f4OF/36Dhf9+g4T/foOE/36DhP9+g4T/foOE/36DhP9+goT/foKE/36ChP9+goT/foKE/36ChP99goT/fYKD/32Cg/99goP/fYKD/32Cg/99goP/fYKD/32Cg/99gYP/fIGD/3yBg/98gYL/fIGC/3yBgv98gYL/e4CC/3uAgf97gIH/e4CB/3uAgf97gIH/e4CB/3t/gP96f4D/en+A/3p/gP96f3//eX5//3l+f/95fn//eX5+/3l+fv95fX7/eH19/3h9ff94fH3/eHx8/3d8fP93e3z/d3t8/3d7e/92env/dnp6/3Z6ev92enr/dnl5/3Z5ef91eHn/dXh4/3V4eP91d3j/dHd3/3R2dv90dnb/c3V2/3N1df9zdXX/cnR0/3J0dP9yc3P/cXNz/3Fycv9wcnH/cHFx/29xcP9vcHD/b3Bw/25wb/9tb27/bW5u/3l6ev95enr/eXp6/3l6ev95enr/enp6/3p6ev96e3v/ent7/3p7e/96e3v/e3x8/3t8fP97fHz/e3x8/3t9ff97fX3/e319/3t9ff98fX3/fH1+/3x9fv98fn7/fH5+/3x+fv98fn7/fH5+/3x+f/98f3//fH9//31/f/99f3//fX+A/31/gP99f4D/fX+A/31/gP99gIH/fYCB/32Agf99gYH/fYCB/32Bgf99gYH/fYGC/36Bgv9+gYL/foGC/36Bgv9+gYL/foGC/36Bg/9+gYP/foKD/36Cg/9+goP/foKD/36Cg/9+goP/foKD/36ChP9+goT/foKE/36ChP9+goT/foKE/36DhP9/g4T/f4OE/3+DhP9/g4T/f4OE/3+DhP9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9/g4X/f4OF/3+Ehf9/hIX/f4OF/3+Dhf9/g4X/f4OF/3+Dhf9+g4X/f4OF/3+Dhf9/g4X/f4OF/36Dhf9+g4X/foOE/36DhP9+g4X/foOF/36DhP9+g4T/foOE/36DhP9+g4T/foOE/36DhP9+g4T/foOE/36DhP9+g4T/foKE/36ChP99goT/fYKE/32Cg/99goT/fYKD/32Cg/99goP/fYKD/32Cg/99goP/fYKD/32Bg/98gYP/fIGD/3yBgv98gYL/fIGC/3yBgv98gYL/e4CC/3uAgf97gIH/e4CB/3uAgf97gIH/e4CA/3qAgP96f4D/en+A/3p/gP96f3//en5//3l+f/95fn//eX5+/3l+fv95fX7/eH19/3h9ff94fH3/eHx8/3d8fP93e3z/d3t8/3d7e/92env/dnp6/3Z6ev92enr/dnl5/3V5ef91eXn/dXh5/3V4eP91eHf/dHd3/3R3d/90dnb/dHV2/3N2dv9zdXX/c3R0/3J0dP9ydHP/cXNz/3Fycv9xcnL/cHFx/3Bxcf9vcXD/b3Bw/29wcP9ub2//bW9u/21ubv95enn/eXp6/3l6ev95enr/eXp6/3l6ev95enr/enp6/3p7e/96e3v/ent7/3p7e/96e3z/enx8/3t8fP97fHz/e3x9/3t9ff97fX3/e319/3t9ff97fX3/fH1+/3x9fv98fn7/fH5+/3x+fv98fn7/fH5//3x/f/98fn//fH9//3x/f/98f4D/fX+A/3x/gP99f4D/fX+A/31/gP99gID/fYCB/32Agf99gIH/fYCB/32Agf99gYH/fYCC/32Bgv99gYL/fYGC/32Bgv99gYL/fYGC/32Bgv99gYL/fYKD/32Bg/9+gYP/fYGD/36Cg/9+goP/foKD/36Cg/9+goP/foKE/36ChP9+goT/foOE/36ChP9+g4T/foOE/36DhP9+g4T/foOE/36DhP9+g4T/foOE/36DhP9+g4T/foOE/36DhP9+g4T/foOE/36DhP9+g4T/foOE/36DhP9+g4T/foOE/36DhP9+g4T/foOE/36DhP9+g4T/foOE/36DhP9+g4T/foOE/36DhP9+goT/foOE/36ChP9+goT/foKE/36ChP9+goT/foKE/32ChP99goP/fYKD/32Cg/99goP/fYKD/32Cg/99goP/fYKD/32Bg/99gYP/fYGD/32Bg/98goP/fIKD/3yBg/98gYL/fIGC/3yBgv98gYL/fIGC/3yAgv98gIL/e4CB/3uAgf97gIH/e4CB/3uAgf97gIH/e4CA/3p/gP96f4D/en+A/3p/gP96fn//en5//3l+f/95fn//eX5+/3l9fv95fX7/eH19/3h9ff94fX3/eHx9/3d8fP93e3z/d3t8/3d7e/92env/dnp6/3Z6ev92enr/dnl6/3Z5ef91eXn/dXh5/3V4eP91eHj/dHd4/3R3d/90dnf/dHZ2/3R1dv9zdXX/c3V1/3J0dP9ydHP/cXNz/3Fzc/9xcnL/cHJx/3Bxcf9wcXH/b3Fw/29wcP9vcG//bm9v/21ubv9tbm3/eXl5/3l5ef95eXn/eXl6/3l6ef95enr/eXp6/3l6ev96env/ent7/3p7e/96e3v/ent7/3p7fP96fHz/e3x8/3t8fP97fH3/e3x9/3t9ff97fX3/e319/3t9ff98fX7/fH1+/3x9fv98fn7/fH5+/3x+fv98fn7/fH5+/3x+f/98fn//fH9//3x/f/98f3//fH+A/31/gP99f4D/fX+A/31/gP98gID/fYCB/32Agf99gIH/fYCB/32Agf99gIH/fYCB/32Agv99gIL/fYCC/32Bgv99gYL/fYGC/32Bgv99gYL/fYGC/32Bgv99gYP/foGD/36Bg/9+gYP/foKD/36Cg/9+goP/foKD/36Cg/9+goT/foKD/36ChP9+goT/foKE/36ChP9+goT/foKE/36ChP9+goT/foKE/36ChP9+goT/foKE/36ChP9+goT/foKE/36DhP9+goT/foKE/36ChP9+goT/foKE/36ChP9+goT/foKE/36ChP9+goT/foKE/36ChP9+goT/fYKE/36ChP9+goT/foKE/36ChP9+goT/fYKE/32Cg/99goP/fYKD/32Cg/99goP/fYGD/32Bg/99gYP/fYGD/32Bg/99gYP/fYGD/32Bg/98gYP/fIGD/3yBgv98gYL/fIGC/3yBgv98gYL/fIGC/3yAgv97gIL/e4CB/3uAgf97gIH/e4CB/3t/gf97gIH/en+A/3p/gP96f4D/en+A/3p/gP96fn//en5//3l+f/95fn//eX5+/3l9fv95fX7/eH19/3h9ff94fH3/eHx8/3d8fP93fHz/d3t8/3d7e/93e3v/dnp7/3Z6ev92enr/dnl6/3V5ev91eXn/dXl5/3V4eP91eHj/dXd4/3R3d/90dnf/dHZ2/3R2dv9zdXX/c3V1/3N0df9ydHT/cnN0/3Fzc/9xcnL/cHJy/3Bxcf9wcXH/b3Fx/29wcP9vcHD/bm9v/21vb/9tbm7/bG5t/3h5ef94eXn/eHl5/3h5ef94eXn/eHl5/3l6ev95enr/eXp6/3p6ev96e3r/ent7/3p7e/96e3v/ent7/3p8fP96fHz/enx8/3t8fP97fHz/e3x9/3t9ff97fX3/e319/3t9ff97fX3/fH1+/3x9fv98fX7/fH5+/3x+fv98fn7/fH5//3x+f/98fn//fH5//3x/f/98f3//fH+A/3x/gP99f4D/fH+A/32AgP99gID/fYCA/32Agf99gIH/fYCB/32Agf99gIH/fYCB/32Agf99gIH/fYCC/32Agv99gIL/fYGC/32Bgv99gYL/fYGC/32Bgv99gYL/fYGD/32Bg/9+gYP/fYGD/36Bg/99gYP/foKD/36Cg/9+goP/foKD/36Cg/9+goT/foKE/36ChP9+goT/foKE/36ChP9+goT/foKE/36ChP9+goT/foKE/36ChP9+goT/foKE/36ChP9+goT/foKE/32ChP99goT/fYKE/32ChP99goT/fYKE/32Cg/99goP/fYKD/32Cg/99goP/fYKD/32Cg/99goP/fYKD/32Bg/99gYP/fYGD/32Bg/99gYP/fYGD/3yBg/98gYP/fIGD/3yBg/98gYP/fIGD/3yBgv98gYL/fIGC/3yBgv98gYL/fIGC/3yBgv98gYL/fICC/3uAgv97gIH/e4CB/3uAgf97gIH/e4CB/3t/gP97f4D/en+A/3p/gP96f4D/en9//3p/f/96f3//eX5//3l+f/95fn7/eX5+/3l9fv95fX7/eH19/3h9ff94fH3/eHx9/3d8fP93fHz/d3t8/3d7e/93env/dnp7/3Z6ev92enr/dnl6/3Z5ev91eXn/dXh5/3V4eP91eHj/dXd4/3R3d/90d3f/dHZ2/3N2dv9zdXX/c3V1/3N0df9ydHT/cnN0/3Fzc/9xc3P/cXJy/3Bycv9wcXH/cHFx/29xcP9vcHD/bm9w/25vb/9ub27/bW5u/2xtbf94eXn/eHl5/3h5ef94eXn/eHl5/3h5ef95eXn/eXp6/3l6ev95enr/enp6/3p6e/96e3v/eXt7/3p7e/96e3v/ent7/3p8fP96fHz/e3x8/3t8fP97fHz/e3x9/3t9ff97fX3/e319/3t9ff98fX7/fH1+/3x+fv98fX7/fH5+/3x+fv98fn//fH5//3x+f/98fn//fH5//3x/f/98f4D/fH+A/31/gP99f4D/fX+A/32AgP99gID/fYCA/32Agf99gIH/fYCB/32Agf99gIH/fYCB/32Agf99gIH/fYCB/32Agf99gIL/fYGC/32Bgv99gYL/fYGC/32Bgv99gYL/fYGC/32Bg/99gYP/fYGD/32Bg/99gYP/fYGD/32Bg/99goP/fYKD/36Cg/99goP/fYKD/36Cg/9+goP/foKD/32Cg/9+goP/foKD/36Cg/99goP/foKD/32Cg/99goP/fYKD/32Cg/99goP/fYKD/32Bg/99goP/fYKD/32Cg/99goP/fYKD/32Cg/99gYP/fYGD/32Bg/99gYP/fYGD/32Bg/99gYP/fYGD/32Bg/98gYP/fIGD/3yBgv98gYL/fIGC/3yBgv98gYL/fIGC/3yBgv98gYL/fICC/3yBgv98gYL/fICC/3yAgv98gIL/e4CB/3uAgf97gIH/e4CB/3uAgf97gIH/e3+B/3t/gP97f4D/en+A/3p/gP96f4D/en+A/3p+f/96fn//eX5//3l+fv95fn7/eX5+/3l9fv95fX7/eH19/3h9ff94fH3/eHx9/3d8fP93e3z/d3t8/3d7e/92e3v/d3p7/3Z6ev92enr/dnl6/3Z5ev92eXn/dXl5/3V4ef91eHj/dXd4/3V3d/90d3f/dHZ3/3R2dv9zdXb/c3V1/3N0df9ydHT/cnR0/3Jzc/9xc3P/cXJy/3Bycv9wcXH/cHFx/3Bxcf9vcXD/bnBw/25vb/9ub2//bW9u/21ubv9sbW3/eHh4/3h4eP94eXn/eHl5/3h5ef94eXn/eHl5/3h6ef95enr/eXp6/3l6ev95enr/eXp6/3p6e/96e3v/ent7/3p7e/96e3v/ent7/3p8fP96fHz/e3x8/3t8fP97fHz/e3x9/3t8ff97fH3/e319/3t9ff97fX7/fH1+/3x9fv98fn7/fH5+/3x+fv98fn7/fH5//3x+f/98fn//fH9//3x/f/98f3//fX9//3x/gP98f4D/fH+A/32AgP99gID/fX+A/32AgP98gIH/fICB/3x/gf98gIH/fICB/32Agf99gIH/fYCB/32Agf99gIL/fYCC/32Agv99gIL/fYCC/32Bgv99gYL/fYGC/32Bgv99gYL/fYGC/32Bgv99gYP/fYGD/32Bg/99gYP/fYGD/32Bg/99gYP/fYGD/32Bg/99gYP/fYGD/32Bg/99gYP/fYKD/32Cg/99goP/fYKD/32Bg/99gYP/fYGD/32Bg/99gYP/fYGD/32Bg/99gYP/fYGD/32Bg/99gYP/fYGD/32Bg/99gYP/fYGC/32Bg/99gYP/fIGC/3yBgv98gYL/fIGC/3yBgv98gYL/fIGC/3yBgv98gYL/fIGC/3yBgv98gIL/fICC/3yAgv98gIL/fICC/3yAgf97gIH/e4CB/3uAgf97gIH/e4CB/3uAgf97gIH/e3+A/3p/gP96f4D/en+A/3p/gP96f4D/en5//3p+f/96fn//eX5//3l+fv95fn7/eX1+/3l9fv95fX7/eX19/3h9ff94fH3/eHx9/3h8fP93e3z/d3t8/3d7e/92e3v/dnp6/3Z6ev92enr/dnl6/3Z5ef91eXn/dXh5/3V4eP91eHj/dXd4/3V3d/90d3f/dHZ3/3R2dv90dnb/c3V1/3N1df9zdHT/cnR0/3JzdP9xc3P/cXJz/3Fycv9wcnL/cHFx/3Bxcf9vcXH/b3Bw/25wb/9ub2//bW9v/21ubv9sbm3/bG1t/3d4eP93eHj/eHh4/3h5eP94eXj/eHl5/3h5ef94eXn/eXl5/3l6ev95enr/eXp6/3l6ev95enr/eXp6/3p6e/96e3v/ent7/3p7e/96e3v/ent8/3p7fP96fHz/enx8/3t8fP97fHz/e3x9/3t8ff97fX3/e319/3t9ff97fX7/fH1+/3x9fv98fn7/fH5+/3x+fv98fn7/fH5//3x+f/98fn//fH5//3x/f/98f3//fH9//3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3x/gP98f4H/fICB/3yAgf98gIH/fICB/3yAgf99gIH/fYCB/32Agf99gIL/fYCC/32Agv99gIL/fYGC/32Bgv99gYL/fYGC/32Bgv99gYL/fYGC/32Bgv99gYL/fYGC/32Bg/99gYL/fYGD/32Bg/99gYP/fYGD/32Bg/99gYP/fYGD/32Bg/99gYP/fYGC/32Bg/99gYP/fYGD/32Bg/99gYL/fYGD/3yBgv98gYL/fIGC/3yBgv98gYL/fIGC/3yBgv98gYL/fIGC/3yBgv98gYL/fIGC/3yBgv98gIL/fICC/3yAgv98gIL/fICC/3yAgf97gIH/fICB/3uAgf97gIH/e4CB/3uAgf97gIH/e4CB/3uAgf97gIH/e3+B/3t/gf97f4D/e3+A/3p/gP96f4D/en+A/3p/gP96f3//en5//3p+f/95fn//eX5//3l+fv95fX7/eX1+/3l9fv95fX3/eH19/3h8ff94fH3/eHx9/3h8fP93e3z/d3t8/3d7e/92env/dnp6/3Z6ev92enr/dnl6/3Z5ef92eXn/dXh5/3V4eP91eHj/dXd4/3V3d/90d3f/dHZ3/3R2dv90dnb/c3V1/3N1df9zdHX/c3R0/3JzdP9yc3P/cXNz/3Fycv9wcnL/cHFx/3Bxcf9vcXH/b3Bw/29wcP9ub2//bm9v/21vbv9tbm3/bG1t/2ttbP93eHj/d3h4/3d4eP94eHj/eHl4/3h5eP94eXn/eHl5/3h5ef95eXn/eXp5/3l6ef95enr/eXp6/3l6ev95enr/ent6/3p7e/96e3v/ent7/3p7e/96e3v/ent7/3p7e/96fHz/enx8/3t8ff97fH3/e3x9/3t8ff97fX3/e319/3t9ff97fX3/fH1+/3x+fv98fn7/fH5+/3x+fv98fn//fH5//3x+f/98fn//fH5//3x/f/98f3//fH9//3x/f/98f4D/fH+A/3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3yAgP98gIH/fICB/3yAgf99gIH/fYCB/32Agf99gIH/fYCC/32Agv99gIL/fYCC/32Bgv99gYL/fYGC/32Bgv99gYL/fYGC/32Bgv99gYL/fYGC/32Bgv99gYL/fYGC/32Bgv99gYL/fYGC/32Bgv99gYL/fYGC/32Bgv99gYL/fIGC/3yBgv98gYL/fIGC/3yBgv98gYL/fIGC/3yBgv98gYL/fIGC/3yBgv98gYL/fICC/3yAgv98gIL/fICC/3yAgv98gIL/fICC/3yAgv98gIH/e4CB/3uAgf97gIH/e4CB/3uAgf97gIH/e4CB/3uAgf97f4H/e4CB/3t/gf97f4H/e3+B/3t/gP96f4D/en+A/3p/gP96f4D/en+A/3p/gP96fn//en5//3p+f/95fn//eX5//3l+fv95fX7/eX1+/3l9fv95fX3/eH19/3h8ff94fH3/eHx8/3h7fP93e3z/d3t8/3d7e/93env/dnp6/3Z6ev92eXr/dnl5/3Z5ef91eXn/dXh5/3V4eP91eHj/dXd4/3V3eP91d3f/dHd3/3R2d/90dnb/dHZ2/3N1df9zdXX/c3R0/3J0dP9yc3P/cXNz/3Fyc/9xcnL/cHJy/3Bxcf9vcXH/b3Bw/29wcP9ucG//bm9v/21vbv9tbm7/bG5t/2xubf9rbWz/d3h3/3d4d/93eHj/d3h4/3d4eP93eHj/d3h4/3h5eP94eXj/eHl5/3h5ef94eXn/eHl5/3h5ef95enr/eXp6/3l6ev95enr/eXp6/3l6e/95e3v/ent7/3p7e/96e3v/ent7/3p7e/96fHz/enx8/3t8fP97fHz/e3x9/3t8ff97fX3/e319/3t9ff97fX3/fH1+/3x9fv98fn7/fH5+/3x+fv98fn7/fH5//3x+f/98fn//fH5//3x+f/98f3//fH9//3x/f/98f3//fH9//3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3yAgP98gIH/fICB/3yAgf98gIH/fICB/3x/gf98gIH/fYCB/32Agf98gIL/fICB/3yAgf98gIL/fICC/3yAgv98gIL/fICC/3yAgv98gIL/fICC/3yAgv98gIL/fIGC/3yAgv98gYL/fIGC/3yBgv98gYL/fIGC/3yAgv98gIL/fICC/3yAgv98gIL/fICC/3yAgv98gIL/fICC/3yAgv98gIH/fICC/3yAgv98gIL/fICB/3uAgf97gIH/e4CB/3uAgf97gIH/e4CB/3uAgf97gIH/e4CB/3uAgf97gIH/e4CB/3uAgf97f4H/e3+B/3t/gf97f4D/e3+A/3p/gP96f4D/en+A/3p/gP96f4D/en5//3p+f/96fn//eX5//3l+f/95fn//eX1+/3l9fv95fX7/eX19/3h9ff94fH3/eHx9/3h8ff94fHz/eHx8/3d7fP93e3v/d3t7/3d7e/93env/dnp6/3Z6ev92eXr/dnl5/3Z5ef91eXn/dXh5/3V4eP91eHj/dXd4/3V3d/90d3f/dHZ3/3R2d/90dnb/dHV2/3N1dv9zdXX/c3R0/3J0dP9yc3T/cnNz/3Fzc/9xcnL/cHJy/3Bxcv9wcXH/b3Fw/29wcP9ucHD/bm9v/25vbv9tbm7/bW5u/2xubf9sbW3/a21s/3d3d/93d3f/d3h3/3d4d/93eHf/d3h4/3d4eP93eHj/eHl4/3h5eP94eXn/eHl5/3h5ef94eXn/eHl5/3l6ev95enr/eXp6/3l6ev95enr/eXp6/3l6ev96e3v/ent7/3p7e/96e3v/ent7/3p8fP96e3z/e3x8/3t8fP97fHz/e3x9/3t8ff97fX3/e319/3t9ff98fX3/fH1+/3x+fv98fX7/fH5+/3x+fv98fn7/fH5+/3x+f/98fn//fH5//3x+f/98fn//fH5//3x/f/98f3//fH9//3x/f/98f4D/fH+A/3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3x/gf98gIH/fICB/3yAgf98gIH/fICB/3yAgf98gIH/fICB/3yAgf98gIH/fICB/3yAgf98gIH/fICB/3yAgf98gIH/fICC/3yAgv98gIL/fICC/3yAgv98gIL/fICC/3yAgv98gIL/fICB/3yAgv98gIL/fICC/3yAgv98gIL/fICC/3yAgv98gIL/e4CB/3yAgv98gIH/fICB/3uAgf97gIH/e4CB/3uAgf97gIH/e4CB/3uAgf97gIH/e4CB/3t/gf97f4H/e4CB/3t/gf97f4H/e3+A/3t/gf97f4D/e3+A/3t/gP97f4D/en+A/3p/gP96f4D/en+A/3p/gP96fn//en5//3p+f/96fn//eX5//3l+f/95fn7/eX1+/3l9fv95fX7/eX19/3h9ff94fH3/eHx9/3h8ff94fHz/eHx8/3d7fP93e3v/d3t7/3d6e/93env/d3p6/3Z6ev92eXr/dnl5/3Z5ef91eXn/dXh5/3V4eP91eHj/dXd4/3V3d/90d3f/dHZ3/3R2d/90dnb/dHV2/3N1df9zdXX/c3V1/3N0dP9yc3T/cnNz/3Fzc/9xcnP/cXJy/3Bxcv9wcXH/cHFx/29wcP9vcHD/bm9v/25vb/9ub27/bW5u/21ubf9sbW3/a21s/2tsbP92d3f/dnd3/3d3d/93d3f/d3h3/3d4d/93eHf/d3h4/3d4eP93eHj/d3h4/3h5eP94eXj/eHl5/3h5ef94eXn/eHl5/3l5ef95eXr/eXp6/3l6ev95enr/eXp6/3l6e/95env/ent7/3p7e/96e3v/ent7/3p7fP96e3z/e3x8/3t8fP97fHz/e3x9/3t9ff97fX3/e319/3t9ff97fX3/fH1+/3x9fv98fX7/fH5+/3x+fv98fn7/fH5+/3x+fv98fn7/fH5//3x+f/98fn//fH5//3x+f/98fn//fH5//3x+f/98fn//fH9//3x/f/98f4D/fH+A/3x/gP98f4D/fH+A/3x/gP98f4D/fH+B/3x/gf98f4H/fH+B/3yAgf98gIH/fICB/3yAgf98gIH/fICB/3yAgf98gIH/fICB/3yAgf98gIH/fICB/3yAgf98gIH/fICB/3yAgf98gIH/fICB/3yAgf98gIH/fICB/3yAgf98gIH/fICB/3yAgf97gIH/e4CB/3uAgf97gIH/e4CB/3uAgf97gIH/e4CB/3uAgf97gIH/e4CB/3t/gf97f4H/e3+B/3t/gf97f4H/e3+B/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3p/gP96f4D/en+A/3p+gP96foD/en+A/3p+f/96fn//en5//3p+f/96fn//eX5//3l+fv95fn7/eX1+/3l9fv94fX7/eH19/3h8ff94fH3/eHx9/3h8fP93e3z/d3t8/3d7e/93e3v/d3t7/3d6e/92env/dnp6/3Z6ev92eXr/dnl5/3Z5ef91eXn/dXh5/3V4eP91eHj/dXd4/3V3d/90d3f/dHd3/3R2dv90dnb/dHV2/3N1df9zdXX/c3R1/3N0dP9ydHT/cnNz/3Jzc/9xcnP/cXJy/3Fycv9wcXH/cHFx/29wcP9vcHD/bm9v/25vb/9tb2//bW5u/21ubf9sbm3/bG1s/2tsbP9rbGz/dnd2/3Z3dv92d3b/dnd3/3Z3d/92d3f/dnd3/3d4d/93eHf/d3h4/3d4eP93eHj/d3h4/3h5eP94eXn/eHl5/3h5ef94eXn/eHl5/3l6ev95enr/eXp6/3l6ev95enr/eXp6/3l6ev95enr/ent7/3p7e/96e3v/ent7/3p7fP97e3z/enx8/3t8fP97fHz/e3x9/3t8ff97fX3/e319/3t9ff97fX3/fH19/3t9fv98fX7/fH1+/3x9fv97fn7/fH5+/3x+fv97fn7/fH5+/3x+fv98fn//fH5//3x+f/98fn//fH5//3x+f/98fn//fH9//3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3x/gP98f4D/fH+B/3x/gf98f4H/fICB/3yAgf98gIH/fICB/3yAgf98gIH/fICB/3yAgf98gIH/fICB/3yAgf98gIH/fICB/3yAgf97gIH/fICB/3uAgf97gIH/e4CB/3uAgf97gIH/e4CB/3uAgf97gIH/e4CB/3uAgf97gIH/e3+B/3t/gf97f4H/e3+A/3t/gf97f4D/e3+A/3t/gf97f4D/e3+A/3t/gP97f4D/en+A/3p/gP96f4D/en+A/3p/gP96f4D/en+A/3p/gP96fn//en5//3p+f/96fn//en5//3p+f/95fn//eX5+/3l9fv95fX7/eX1+/3l9fv94fX3/eH19/3h8ff94fH3/eHx8/3h7fP93e3z/d3t8/3d7e/93e3v/d3t7/3d6ev92enr/dnp6/3Z6ev92eXr/dnl5/3Z5ef91eXn/dXh5/3V4eP91eHj/dXd4/3R3d/90d3f/dHd3/3R2dv90dnb/dHZ2/3N1df9zdXX/c3R1/3N0dP9ydHT/cnN0/3Jzc/9yc3P/cXJy/3Fycv9wcnH/cHFx/29wcf9vcHD/b3Bw/25vb/9ub2//bW9u/21ubv9tbm3/bG1t/2xsbP9rbGz/amxr/3Z2dv92d3b/dnd2/3Z3d/92d3f/dnd3/3Z3d/92d3f/d3h3/3d4d/93eHf/d3h4/3d4eP93eHj/eHl4/3h5ef94eXn/eHl5/3h5ef94eXn/eXl5/3l6ev95enr/eXp6/3l7ev95enr/eXp6/3l6ev96e3v/ent7/3p7e/96e3v/ent8/3p8fP96fHz/e3x8/3t8fP97fH3/e3x9/3t9ff97fX3/e319/3t9ff97fX3/e319/3t9fv97fX7/e31+/3t9fv97fX7/e35+/3t+fv97fn7/e35+/3t+fv97fn//fH5//3x+f/98fn//fH5//3x+f/98fn//fH9//3x/f/98f3//fH+A/3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3x/gf98f4D/fH+A/3x/gP98f4D/fH+B/3x/gf98gIH/fH+B/3x/gf98f4H/fH+B/3yAgf98gIH/fICB/3uAgf97gIH/e4CB/3uAgf97gIH/e4CB/3uAgf97gIH/e3+B/3t/gf97f4H/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP96f4D/en+A/3p/gP96f4D/en+A/3p/gP96f4D/en9//3p/f/96fn//en5//3p+f/96fn//en5//3l+f/95fn//eX5+/3l9fv95fX7/eX1+/3l9ff94fX3/eHx9/3h8ff94fHz/eHx8/3d7fP93e3z/d3t8/3d7e/93e3v/d3p7/3Z6e/92enr/dnp6/3Z6ev92eXr/dnl5/3Z5ef91eHn/dXh4/3V4eP91eHj/dXd4/3V3d/90d3f/dHd3/3R2dv90dnb/c3Z2/3N1df9zdXX/c3R1/3N0dP9ydHT/cnN0/3Jzc/9yc3P/cnNy/3Fycv9xcnL/cHFx/3Bxcf9vcHD/b3Bw/25wb/9ub2//bm9v/21ubv9sbm7/bG5t/2xtbf9sbWz/a2xs/2psa/92dnX/dnZ2/3Z3dv92d3b/dnd2/3Z3dv92d3b/dnd3/3Z3d/92d3f/dnd3/3d4d/93eHj/d3h4/3d4eP94eHj/eHl4/3h5ef94eXn/eHl5/3h5ef95eXn/eHl6/3l6ev95enr/eXp6/3l6ev95enr/eXp6/3p7e/96env/ent7/3p7e/96e3v/ent7/3p7fP97fHz/e3x8/3t8fP97fHz/e3x9/3t8ff97fH3/e319/3t9ff97fX3/e319/3t9ff97fX3/e319/3t9fv97fX7/e31+/3t+fv97fX7/e35+/3t+fv97fn7/e35+/3t+f/97fn//e35//3t+f/98fn//e35//3t+f/98f3//fH9//3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3x/gP98f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3p/gP96f4D/en+A/3p/gP96f3//en5//3p+f/96f3//en5//3p+f/96fn//en5//3p+f/96fn//eX5+/3l+fv95fn7/eX1+/3l9fv95fX7/eX1+/3h9ff94fH3/eHx9/3h8fP94fHz/d3x8/3d7fP93e3z/d3t7/3d7e/93env/d3p7/3Z6ev92enr/dnp6/3Z5ev92eXr/dnl5/3Z5ef91eHn/dXh4/3V4eP91eHj/dXd4/3R3d/90d3f/dHd3/3R2dv90dnb/c3V2/3N1dv9zdXX/c3V1/3N0df9zdHT/cnR0/3Jzc/9yc3P/cXNz/3Fycv9xcnL/cHJx/3Bxcf9vcXD/b3Bw/29wcP9ub2//bm9v/21vbv9tbm7/bG5t/2xtbf9sbWz/a2xs/2pra/9qa2r/dXZ1/3Z2df92dnb/dnd2/3Z3dv92d3b/dnd2/3Z3dv92d3f/dnd3/3Z3d/93eHf/d3h3/3d4eP93eHj/d3h4/3d4eP94eXj/eHl5/3h5ef94eXn/eHl5/3h5ef95eXn/eXp5/3l6ef95enr/eXp6/3l6ev95enr/enp7/3l6e/96e3v/ent7/3p7e/96e3v/ent8/3p8fP96fHz/e3x8/3t8fP97fHz/e3x8/3t8ff97fH3/e319/3t9ff97fX3/e319/3t9ff97fX3/e319/3t9ff97fX7/e31+/3t9fv97fX7/e35+/3t+fv97fn7/e35+/3t+f/97fn//fH5//3x+f/97fn//e35//3x/f/98fn//fH9//3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3x/gP98f4D/fH+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP96f4D/en+A/3p/gP96f4D/en9//3p/f/96fn//en5//3p+f/96fn//en5//3p+f/96fn//en5//3p+f/96fn//eX5+/3l9fv95fX7/eX1+/3l9fv95fX7/eX19/3h9ff94fH3/eHx9/3h8fP94fHz/d3x8/3d7fP93e3z/d3t7/3d7e/93e3v/d3p7/3Z6ev92enr/dnp6/3Z6ev92eXr/dnl5/3Z5ef91eXn/dXh4/3V4eP91eHj/dXd4/3R3d/90d3f/dHZ3/3R2dv90dnb/dHZ2/3N1dv9zdXX/c3V1/3N1dP9zdHT/cnR0/3Jzc/9yc3P/cXNz/3Fycv9xcnL/cXJy/3Bxcf9wcXH/b3Bw/29wcP9ub2//bm9v/25vb/9tbm7/bW5t/2xtbf9sbW3/a2xs/2tsbP9qa2v/aWtq/3V2df91dnX/dnZ2/3Z2df92dnb/dnd2/3Z3dv92d3b/dnd2/3Z3dv92d3f/dnd3/3d3d/93eHf/d3h4/3d4eP93eHj/d3h4/3d4eP94eXn/eHl5/3h5ef94eXn/eHl5/3l5ef94eXn/eXl6/3l6ev95enr/eXp6/3l6ev95enr/eXp7/3p6e/96e3v/ent7/3p7e/96e3v/ent8/3p8fP96fHz/e3x8/3t8fP97fHz/e3x8/3t8fP97fH3/e3x9/3t8ff97fH3/e319/3t9ff97fX3/e319/3t9ff97fX3/e31+/3t9fv97fX7/e35+/3t+fv97fn7/e35+/3t+fv97fn//e35//3t+f/97fn//e35//3t+f/97fn//fH9//3x/f/98f3//e39//3x/f/97f3//e39//3t/gP97f4D/e3+A/3t/gP97f3//e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP97f4D/e3+A/3t/gP96f3//en+A/3p/f/96f3//en9//3p/f/96f3//en5//3p+f/96fn//en5//3p+f/96fn//en5//3p+f/96fn//en5//3p+f/96fn//eX5//3l+fv95fn7/eX1+/3l9fv95fX7/eX1+/3l9fv95fX7/eX19/3h9ff94fH3/eHx9/3h8fP94fHz/d3x8/3d7fP93e3v/d3t7/3d7e/93env/dnp7/3Z6ev92enr/dnp6/3Z6ev92eXr/dnl5/3Z5ef91eXn/dXh4/3V4eP91eHj/dXh4/3V3d/90d3f/dHd3/3R2d/90dnb/dHZ2/3R1df9zdXX/c3V1/3N1df9zdHT/cnR0/3J0dP9yc3P/cnNz/3Fzc/9xcnL/cXJy/3Bycf9wcXH/cHFx/29wcP9vcHD/bm9v/25vb/9tbm7/bW5u/21ubf9sbW3/a21s/2tsbP9qbGv/amtq/2prav91dXT/dXZ1/3V2df92dnX/dnZ1/3Z2dv92dnb/dnd2/3Z3dv92d3b/dnd3/3Z3d/92d3f/d3d3/3d4d/93eHj/d3h4/3d4eP93eHj/eHh4/3h4ef94eXn/eHl5/3h5ef94eXn/eHl5/3l5ef95eXn/eXp6/3l6ev95enr/eXp6/3p6ev96enr/ent7/3p7e/96e3v/ent7/3p7e/96e3v/ent7/3p7fP96fHz/enx8/3t8fP97fHz/e3x8/3t8fP97fHz/e3x8/3t8fP97fH3/e3x9/3t9ff97fX3/e319/3t9ff97fX3/e319/3t9fv97fX7/e31+/3t+fv97fX7/e31+/3t+fv97fn7/e35+/3t+f/97fn//e35//3t+f/97fn//e35//3t+f/97fn//e39//3t/f/97f3//e39//3t/f/97fn//e35//3t+f/97fn//e35//3t+f/97fn//e35//3t+f/97fn//e39//3t/f/97f3//en9//3t+f/97fn//e35//3p+f/96fn//en5//3p+f/96fn//en5//3p+f/96fn//en5//3p+f/96fn//en5//3p+f/96fn//en5//3p+f/96fn//en5//3p+fv95fn7/eX5+/3l9fv95fn7/eX1+/3l9ff95fX7/eX19/3l9ff95fH3/eX19/3h8ff94fH3/eHx9/3h8fP94fHz/d3t8/3d7e/93e3v/d3t7/3d7e/93env/d3p7/3Z6ev92enr/dnl6/3Z5ev92eXn/dnl5/3Z5ef91eXn/dXh4/3V4eP91eHj/dXd4/3V3d/91d3f/dHd3/3R2dv90dnb/dHZ2/3R2dv9zdXb/c3V1/3N1df9zdHT/c3R0/3J0dP9yc3T/cnNz/3Jzc/9xcnP/cXJy/3Fycv9wcXH/b3Fx/29wcP9vcHD/b29v/25vb/9ub2//bW5u/21ubv9sbW3/bG1t/2xtbf9rbGz/amxr/2prav9pamr/dXZ0/3V2df91dnX/dXZ1/3V2df91dnb/dnZ2/3Z3dv92d3b/dnd2/3Z3dv92d3f/dnd3/3Z3d/92eHf/d3h3/3d4d/93eHj/d3h4/3d4eP94eHj/eHl4/3h5ef94eXn/eHl5/3h5ef94eXn/eHl5/3l6ev95enr/eXp6/3l6ev95enr/eXp6/3p6e/96e3v/ent7/3p7e/96e3v/ent7/3p7e/96e3v/ent7/3p8fP96fHz/enx8/3p8fP96fHz/enx8/3p8fP97fHz/e3x8/3t8fP97fH3/e3x9/3t9ff97fX3/e319/3t9ff97fX3/e319/3t9fv97fX7/e31+/3t9fv97fX7/e35+/3t+fv97fn7/e35+/3t+fv97fn//e35//3t+f/97fn//e35//3t+f/97fn//e35//3t+f/97fn//e35//3t+f/97fn//e35//3t+f/97fn//e35//3p+f/96fn//en5//3p+f/96fn//en5//3p+f/96fn//en5//3p+f/96fn//en5//3p+f/96fn//en5//3p+f/96fn//en5//3p+f/96fn//en5//3p+f/96fn//en5//3p+fv96fn7/en5+/3p+fv96fn7/en5+/3l+fv95fX7/eX1+/3l9fv95fX7/eX19/3l9ff95fH3/eX19/3h9ff94fH3/eHx8/3h8fP94fHz/eHx8/3d8fP93e3v/d3t7/3d7e/93e3v/d3p7/3Z6ev92enr/dnp6/3Z6ev92eXn/dnl5/3Z5ef92eXn/dXl4/3V4eP91eHj/dXh3/3V3d/91d3f/dHd3/3R2d/90dnf/dHZ2/3N2dv9zdnb/c3V1/3N1df9zdXX/c3R0/3N0dP9ydHT/cnNz/3Jzc/9yc3P/cXJy/3Fycv9xcnL/cHFx/29xcP9vcHD/b3Bv/25wb/9ub2//bm9u/21ubv9tbm3/bG1t/2xtbP9rbWz/a2xr/2pra/9qa2r/aWpq/3V1dP91dnT/dXZ1/3V2df91dnX/dXZ1/3V2df92dnb/dnZ1/3Z3dv92d3b/dnd2/3Z3d/92d3f/dnd3/3d3d/93eHf/d3h3/3d4eP93eHj/eHh4/3d4eP94eXj/eHl5/3h5ef94eXn/eHl5/3h6ef94enn/eXp5/3l6ev95enr/eXp6/3l6ev95enr/enp6/3p7e/96e3v/ent7/3p7e/96e3v/ent7/3p7e/96e3v/ent8/3p7e/96fHv/ent7/3p7e/96e3z/enx8/3p8fP96fHz/e3x8/3t8fP97fH3/e319/3t9ff97fX3/e319/3t9ff97fX3/e319/3t9ff97fX3/e31+/3t9fv97fn7/e35+/3t+fv97fn7/e35+/3t+fv97fn7/e35+/3t+f/97fn//e35+/3t+f/97fn7/e35+/3t+fv97fn7/e35//3p+f/97fn//e35+/3p+fv96fn//en5//3p+f/96fn7/en5//3p+f/96fn//en5+/3p+fv96fn7/en5+/3p+f/96fn//en5//3p+f/96fn7/en5//3p+fv96fn7/en5+/3p+fv96fn//en5+/3p+fv96fn7/en5+/3p+fv96fn7/en5+/3l9fv95fn7/eX1+/3l9fv95fX7/eX19/3l9ff95fX3/eH19/3l8ff94fH3/eHx8/3h8fP94fHz/eHt8/3d7fP93e3v/d3t7/3d7e/93e3v/d3p7/3d6ev92enr/dnp6/3Z6ef92eXn/dnl5/3Z5ef92eXn/dXl4/3V4eP91eHj/dXh4/3V4d/91d3f/dHd3/3R3d/90dnb/c3Z2/3N2dv9zdXX/c3V1/3N1df9ydXX/c3R0/3N0dP9ydHT/cnN0/3Jzc/9yc3P/cXNy/3Fycv9xcnL/cHFx/3Bxcf9vcXD/b3Bw/25wb/9ub2//bm9u/21ubv9tbm7/bG5t/2xtbf9sbWz/a2xs/2pra/9qa2r/aWpp/2lqaf91dnT/dXZ0/3V2dP91dnX/dXZ1/3V2df91dnX/dnZ1/3Z3dv92d3b/dnd2/3Z3dv92d3b/dnd3/3Z3d/92d3f/dnd3/3Z4d/93eHf/d3h4/3d4eP93eHj/d3h4/3h5eP94eXn/eHl5/3h5ef94eXn/eHl5/3l5ef95eXn/eXp5/3l6ev95enr/eXp6/3l6ev96enr/ent7/3p7e/96e3v/ent7/3p7e/96e3v/ent7/3p7e/96e3v/ent7/3p7e/96e3v/ent7/3p7e/96fHz/enx8/3p8fP97fHz/e3x8/3t8ff97fH3/e319/3t9ff97fX3/e319/3t9ff97fX3/e319/3t9ff97fX3/e31+/3t+fv97fn7/e35+/3t+fv97fn7/fH5+/3t+fv97fn7/e35+/3t+fv97fn7/e35+/3t+fv97fn7/en5+/3p+fv96fn7/en5+/3p9fv96fn7/en5+/3p+fv96fn7/en5+/3p+fv96fn7/en5+/3p+fv96fn7/en5+/3p+fv96fn7/en5+/3p+fv96fn7/en5+/3p+fv96fn7/en5+/3p+fv96fn7/en5+/3p+fv96fn7/en5+/3p+fv96fX7/en1+/3l9fv95fX7/eX1+/3l9fv95fX3/eX19/3l9ff94fH3/eHx9/3h8ff94fHz/eHx8/3h8fP94fHz/eHx8/3h7fP93e3v/d3t7/3d7e/93e3v/d3t6/3d6ev92enr/dnp6/3Z6ev92eXn/dnl5/3Z5ef92eXn/dnl4/3V5eP91eHj/dXh4/3V4eP91d3f/dHd3/3R3d/90d3b/dHZ2/3R2dv90dnX/c3V2/3N1df9zdXX/c3V0/3N0dP9zdHT/cnR0/3Jzc/9yc3P/cnNz/3Fycv9xcnL/cXFx/3Bxcf9wcXH/b3Bw/29wb/9vcG//bm9v/21ubv9tbm7/bW5t/2xtbf9rbWz/a2xs/2tsa/9qa2v/ampq/2lqaf9pamj/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA	t	\N	\N	\N	\N	d420bd02d05720dba409581511429085746d2a370d297a22ebc61f7b98701c00	2026-06-03 19:10:06.382+03
35	Martin	Manampisoa	manampisoa.m@zurcher.edu.mg	$2a$12$OE4cVskCPeldcxLba.o0r.TC/5g2b7zasFBphio5lxJjbq6sffH9e	admin	\N	\N	\N	\N	t	2026-06-02 18:33:38.3+03	2026-06-02 18:42:41.10928+03	\N	t	\N	\N	\N	\N	\N	\N
\.


--
-- Name: favoris_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favoris_id_seq', 2, true);


--
-- Name: filieres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.filieres_id_seq', 547, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 168, true);


--
-- Name: options_reponses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.options_reponses_id_seq', 121, true);


--
-- Name: parcours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.parcours_id_seq', 491, true);


--
-- Name: profils_academiques_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profils_academiques_id_seq', 34, true);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 26, true);


--
-- Name: recommendation_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recommendation_rules_id_seq', 1, false);


--
-- Name: recommendations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recommendations_id_seq', 242, true);


--
-- Name: sessions_test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sessions_test_id_seq', 39, true);


--
-- Name: sessions_test_multi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sessions_test_multi_id_seq', 47, true);


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.settings_id_seq', 1, true);


--
-- Name: test_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_questions_id_seq', 145, true);


--
-- Name: testimonials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.testimonials_id_seq', 1, false);


--
-- Name: tests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tests_id_seq', 20, true);


--
-- Name: universites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.universites_id_seq', 420, true);


--
-- Name: user_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_settings_id_seq', 24, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 37, true);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: favoris favoris_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoris
    ADD CONSTRAINT favoris_pkey PRIMARY KEY (id);


--
-- Name: filieres filieres_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key UNIQUE (code);


--
-- Name: filieres filieres_code_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key1 UNIQUE (code);


--
-- Name: filieres filieres_code_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key10 UNIQUE (code);


--
-- Name: filieres filieres_code_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key100 UNIQUE (code);


--
-- Name: filieres filieres_code_key101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key101 UNIQUE (code);


--
-- Name: filieres filieres_code_key102; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key102 UNIQUE (code);


--
-- Name: filieres filieres_code_key103; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key103 UNIQUE (code);


--
-- Name: filieres filieres_code_key104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key104 UNIQUE (code);


--
-- Name: filieres filieres_code_key105; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key105 UNIQUE (code);


--
-- Name: filieres filieres_code_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key11 UNIQUE (code);


--
-- Name: filieres filieres_code_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key12 UNIQUE (code);


--
-- Name: filieres filieres_code_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key13 UNIQUE (code);


--
-- Name: filieres filieres_code_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key14 UNIQUE (code);


--
-- Name: filieres filieres_code_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key15 UNIQUE (code);


--
-- Name: filieres filieres_code_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key16 UNIQUE (code);


--
-- Name: filieres filieres_code_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key17 UNIQUE (code);


--
-- Name: filieres filieres_code_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key18 UNIQUE (code);


--
-- Name: filieres filieres_code_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key19 UNIQUE (code);


--
-- Name: filieres filieres_code_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key2 UNIQUE (code);


--
-- Name: filieres filieres_code_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key20 UNIQUE (code);


--
-- Name: filieres filieres_code_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key21 UNIQUE (code);


--
-- Name: filieres filieres_code_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key22 UNIQUE (code);


--
-- Name: filieres filieres_code_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key23 UNIQUE (code);


--
-- Name: filieres filieres_code_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key24 UNIQUE (code);


--
-- Name: filieres filieres_code_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key25 UNIQUE (code);


--
-- Name: filieres filieres_code_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key26 UNIQUE (code);


--
-- Name: filieres filieres_code_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key27 UNIQUE (code);


--
-- Name: filieres filieres_code_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key28 UNIQUE (code);


--
-- Name: filieres filieres_code_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key29 UNIQUE (code);


--
-- Name: filieres filieres_code_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key3 UNIQUE (code);


--
-- Name: filieres filieres_code_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key30 UNIQUE (code);


--
-- Name: filieres filieres_code_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key31 UNIQUE (code);


--
-- Name: filieres filieres_code_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key32 UNIQUE (code);


--
-- Name: filieres filieres_code_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key33 UNIQUE (code);


--
-- Name: filieres filieres_code_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key34 UNIQUE (code);


--
-- Name: filieres filieres_code_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key35 UNIQUE (code);


--
-- Name: filieres filieres_code_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key36 UNIQUE (code);


--
-- Name: filieres filieres_code_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key37 UNIQUE (code);


--
-- Name: filieres filieres_code_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key38 UNIQUE (code);


--
-- Name: filieres filieres_code_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key39 UNIQUE (code);


--
-- Name: filieres filieres_code_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key4 UNIQUE (code);


--
-- Name: filieres filieres_code_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key40 UNIQUE (code);


--
-- Name: filieres filieres_code_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key41 UNIQUE (code);


--
-- Name: filieres filieres_code_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key42 UNIQUE (code);


--
-- Name: filieres filieres_code_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key43 UNIQUE (code);


--
-- Name: filieres filieres_code_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key44 UNIQUE (code);


--
-- Name: filieres filieres_code_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key45 UNIQUE (code);


--
-- Name: filieres filieres_code_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key46 UNIQUE (code);


--
-- Name: filieres filieres_code_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key47 UNIQUE (code);


--
-- Name: filieres filieres_code_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key48 UNIQUE (code);


--
-- Name: filieres filieres_code_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key49 UNIQUE (code);


--
-- Name: filieres filieres_code_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key5 UNIQUE (code);


--
-- Name: filieres filieres_code_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key50 UNIQUE (code);


--
-- Name: filieres filieres_code_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key51 UNIQUE (code);


--
-- Name: filieres filieres_code_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key52 UNIQUE (code);


--
-- Name: filieres filieres_code_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key53 UNIQUE (code);


--
-- Name: filieres filieres_code_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key54 UNIQUE (code);


--
-- Name: filieres filieres_code_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key55 UNIQUE (code);


--
-- Name: filieres filieres_code_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key56 UNIQUE (code);


--
-- Name: filieres filieres_code_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key57 UNIQUE (code);


--
-- Name: filieres filieres_code_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key58 UNIQUE (code);


--
-- Name: filieres filieres_code_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key59 UNIQUE (code);


--
-- Name: filieres filieres_code_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key6 UNIQUE (code);


--
-- Name: filieres filieres_code_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key60 UNIQUE (code);


--
-- Name: filieres filieres_code_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key61 UNIQUE (code);


--
-- Name: filieres filieres_code_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key62 UNIQUE (code);


--
-- Name: filieres filieres_code_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key63 UNIQUE (code);


--
-- Name: filieres filieres_code_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key64 UNIQUE (code);


--
-- Name: filieres filieres_code_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key65 UNIQUE (code);


--
-- Name: filieres filieres_code_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key66 UNIQUE (code);


--
-- Name: filieres filieres_code_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key67 UNIQUE (code);


--
-- Name: filieres filieres_code_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key68 UNIQUE (code);


--
-- Name: filieres filieres_code_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key69 UNIQUE (code);


--
-- Name: filieres filieres_code_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key7 UNIQUE (code);


--
-- Name: filieres filieres_code_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key70 UNIQUE (code);


--
-- Name: filieres filieres_code_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key71 UNIQUE (code);


--
-- Name: filieres filieres_code_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key72 UNIQUE (code);


--
-- Name: filieres filieres_code_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key73 UNIQUE (code);


--
-- Name: filieres filieres_code_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key74 UNIQUE (code);


--
-- Name: filieres filieres_code_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key75 UNIQUE (code);


--
-- Name: filieres filieres_code_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key76 UNIQUE (code);


--
-- Name: filieres filieres_code_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key77 UNIQUE (code);


--
-- Name: filieres filieres_code_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key78 UNIQUE (code);


--
-- Name: filieres filieres_code_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key79 UNIQUE (code);


--
-- Name: filieres filieres_code_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key8 UNIQUE (code);


--
-- Name: filieres filieres_code_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key80 UNIQUE (code);


--
-- Name: filieres filieres_code_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key81 UNIQUE (code);


--
-- Name: filieres filieres_code_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key82 UNIQUE (code);


--
-- Name: filieres filieres_code_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key83 UNIQUE (code);


--
-- Name: filieres filieres_code_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key84 UNIQUE (code);


--
-- Name: filieres filieres_code_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key85 UNIQUE (code);


--
-- Name: filieres filieres_code_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key86 UNIQUE (code);


--
-- Name: filieres filieres_code_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key87 UNIQUE (code);


--
-- Name: filieres filieres_code_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key88 UNIQUE (code);


--
-- Name: filieres filieres_code_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key89 UNIQUE (code);


--
-- Name: filieres filieres_code_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key9 UNIQUE (code);


--
-- Name: filieres filieres_code_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key90 UNIQUE (code);


--
-- Name: filieres filieres_code_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key91 UNIQUE (code);


--
-- Name: filieres filieres_code_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key92 UNIQUE (code);


--
-- Name: filieres filieres_code_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key93 UNIQUE (code);


--
-- Name: filieres filieres_code_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key94 UNIQUE (code);


--
-- Name: filieres filieres_code_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key95 UNIQUE (code);


--
-- Name: filieres filieres_code_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key96 UNIQUE (code);


--
-- Name: filieres filieres_code_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key97 UNIQUE (code);


--
-- Name: filieres filieres_code_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key98 UNIQUE (code);


--
-- Name: filieres filieres_code_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_code_key99 UNIQUE (code);


--
-- Name: filieres filieres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: options_reponses options_reponses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options_reponses
    ADD CONSTRAINT options_reponses_pkey PRIMARY KEY (id);


--
-- Name: parcours parcours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parcours
    ADD CONSTRAINT parcours_pkey PRIMARY KEY (id);


--
-- Name: profils_academiques profils_academiques_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profils_academiques
    ADD CONSTRAINT profils_academiques_pkey PRIMARY KEY (id);


--
-- Name: profils_academiques profils_academiques_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profils_academiques
    ADD CONSTRAINT profils_academiques_user_id_key UNIQUE (user_id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: recommendation_rules recommendation_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendation_rules
    ADD CONSTRAINT recommendation_rules_pkey PRIMARY KEY (id);


--
-- Name: recommendations recommendations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_pkey PRIMARY KEY (id);


--
-- Name: sessions_test_multi sessions_test_multi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions_test_multi
    ADD CONSTRAINT sessions_test_multi_pkey PRIMARY KEY (id);


--
-- Name: sessions_test sessions_test_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions_test
    ADD CONSTRAINT sessions_test_pkey PRIMARY KEY (id);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: test_questions test_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_questions
    ADD CONSTRAINT test_questions_pkey PRIMARY KEY (id);


--
-- Name: testimonials testimonials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testimonials
    ADD CONSTRAINT testimonials_pkey PRIMARY KEY (id);


--
-- Name: tests tests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);


--
-- Name: universites universites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.universites
    ADD CONSTRAINT universites_pkey PRIMARY KEY (id);


--
-- Name: user_settings user_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_settings
    ADD CONSTRAINT user_settings_pkey PRIMARY KEY (id);


--
-- Name: user_settings user_settings_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_settings
    ADD CONSTRAINT user_settings_user_id_key UNIQUE (user_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_email_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key1 UNIQUE (email);


--
-- Name: users users_email_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key10 UNIQUE (email);


--
-- Name: users users_email_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key100 UNIQUE (email);


--
-- Name: users users_email_key101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key101 UNIQUE (email);


--
-- Name: users users_email_key102; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key102 UNIQUE (email);


--
-- Name: users users_email_key103; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key103 UNIQUE (email);


--
-- Name: users users_email_key104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key104 UNIQUE (email);


--
-- Name: users users_email_key105; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key105 UNIQUE (email);


--
-- Name: users users_email_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key11 UNIQUE (email);


--
-- Name: users users_email_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key12 UNIQUE (email);


--
-- Name: users users_email_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key13 UNIQUE (email);


--
-- Name: users users_email_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key14 UNIQUE (email);


--
-- Name: users users_email_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key15 UNIQUE (email);


--
-- Name: users users_email_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key16 UNIQUE (email);


--
-- Name: users users_email_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key17 UNIQUE (email);


--
-- Name: users users_email_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key18 UNIQUE (email);


--
-- Name: users users_email_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key19 UNIQUE (email);


--
-- Name: users users_email_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key2 UNIQUE (email);


--
-- Name: users users_email_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key20 UNIQUE (email);


--
-- Name: users users_email_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key21 UNIQUE (email);


--
-- Name: users users_email_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key22 UNIQUE (email);


--
-- Name: users users_email_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key23 UNIQUE (email);


--
-- Name: users users_email_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key24 UNIQUE (email);


--
-- Name: users users_email_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key25 UNIQUE (email);


--
-- Name: users users_email_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key26 UNIQUE (email);


--
-- Name: users users_email_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key27 UNIQUE (email);


--
-- Name: users users_email_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key28 UNIQUE (email);


--
-- Name: users users_email_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key29 UNIQUE (email);


--
-- Name: users users_email_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key3 UNIQUE (email);


--
-- Name: users users_email_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key30 UNIQUE (email);


--
-- Name: users users_email_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key31 UNIQUE (email);


--
-- Name: users users_email_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key32 UNIQUE (email);


--
-- Name: users users_email_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key33 UNIQUE (email);


--
-- Name: users users_email_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key34 UNIQUE (email);


--
-- Name: users users_email_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key35 UNIQUE (email);


--
-- Name: users users_email_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key36 UNIQUE (email);


--
-- Name: users users_email_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key37 UNIQUE (email);


--
-- Name: users users_email_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key38 UNIQUE (email);


--
-- Name: users users_email_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key39 UNIQUE (email);


--
-- Name: users users_email_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key4 UNIQUE (email);


--
-- Name: users users_email_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key40 UNIQUE (email);


--
-- Name: users users_email_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key41 UNIQUE (email);


--
-- Name: users users_email_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key42 UNIQUE (email);


--
-- Name: users users_email_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key43 UNIQUE (email);


--
-- Name: users users_email_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key44 UNIQUE (email);


--
-- Name: users users_email_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key45 UNIQUE (email);


--
-- Name: users users_email_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key46 UNIQUE (email);


--
-- Name: users users_email_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key47 UNIQUE (email);


--
-- Name: users users_email_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key48 UNIQUE (email);


--
-- Name: users users_email_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key49 UNIQUE (email);


--
-- Name: users users_email_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key5 UNIQUE (email);


--
-- Name: users users_email_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key50 UNIQUE (email);


--
-- Name: users users_email_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key51 UNIQUE (email);


--
-- Name: users users_email_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key52 UNIQUE (email);


--
-- Name: users users_email_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key53 UNIQUE (email);


--
-- Name: users users_email_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key54 UNIQUE (email);


--
-- Name: users users_email_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key55 UNIQUE (email);


--
-- Name: users users_email_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key56 UNIQUE (email);


--
-- Name: users users_email_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key57 UNIQUE (email);


--
-- Name: users users_email_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key58 UNIQUE (email);


--
-- Name: users users_email_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key59 UNIQUE (email);


--
-- Name: users users_email_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key6 UNIQUE (email);


--
-- Name: users users_email_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key60 UNIQUE (email);


--
-- Name: users users_email_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key61 UNIQUE (email);


--
-- Name: users users_email_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key62 UNIQUE (email);


--
-- Name: users users_email_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key63 UNIQUE (email);


--
-- Name: users users_email_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key64 UNIQUE (email);


--
-- Name: users users_email_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key65 UNIQUE (email);


--
-- Name: users users_email_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key66 UNIQUE (email);


--
-- Name: users users_email_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key67 UNIQUE (email);


--
-- Name: users users_email_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key68 UNIQUE (email);


--
-- Name: users users_email_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key69 UNIQUE (email);


--
-- Name: users users_email_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key7 UNIQUE (email);


--
-- Name: users users_email_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key70 UNIQUE (email);


--
-- Name: users users_email_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key71 UNIQUE (email);


--
-- Name: users users_email_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key72 UNIQUE (email);


--
-- Name: users users_email_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key73 UNIQUE (email);


--
-- Name: users users_email_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key74 UNIQUE (email);


--
-- Name: users users_email_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key75 UNIQUE (email);


--
-- Name: users users_email_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key76 UNIQUE (email);


--
-- Name: users users_email_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key77 UNIQUE (email);


--
-- Name: users users_email_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key78 UNIQUE (email);


--
-- Name: users users_email_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key79 UNIQUE (email);


--
-- Name: users users_email_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key8 UNIQUE (email);


--
-- Name: users users_email_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key80 UNIQUE (email);


--
-- Name: users users_email_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key81 UNIQUE (email);


--
-- Name: users users_email_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key82 UNIQUE (email);


--
-- Name: users users_email_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key83 UNIQUE (email);


--
-- Name: users users_email_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key84 UNIQUE (email);


--
-- Name: users users_email_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key85 UNIQUE (email);


--
-- Name: users users_email_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key86 UNIQUE (email);


--
-- Name: users users_email_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key87 UNIQUE (email);


--
-- Name: users users_email_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key88 UNIQUE (email);


--
-- Name: users users_email_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key89 UNIQUE (email);


--
-- Name: users users_email_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key9 UNIQUE (email);


--
-- Name: users users_email_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key90 UNIQUE (email);


--
-- Name: users users_email_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key91 UNIQUE (email);


--
-- Name: users users_email_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key92 UNIQUE (email);


--
-- Name: users users_email_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key93 UNIQUE (email);


--
-- Name: users users_email_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key94 UNIQUE (email);


--
-- Name: users users_email_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key95 UNIQUE (email);


--
-- Name: users users_email_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key96 UNIQUE (email);


--
-- Name: users users_email_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key97 UNIQUE (email);


--
-- Name: users users_email_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key98 UNIQUE (email);


--
-- Name: users users_email_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key99 UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: notifications_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_user_id ON public.notifications USING btree (user_id);


--
-- Name: notifications_user_id_read; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notifications_user_id_read ON public.notifications USING btree (user_id, read);


--
-- Name: user_settings_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_settings_user_id ON public.user_settings USING btree (user_id);


--
-- Name: favoris favoris_filiere_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoris
    ADD CONSTRAINT favoris_filiere_id_fkey FOREIGN KEY (filiere_id) REFERENCES public.filieres(id) ON UPDATE CASCADE;


--
-- Name: favoris favoris_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoris
    ADD CONSTRAINT favoris_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: filieres filieres_universite_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.filieres
    ADD CONSTRAINT filieres_universite_id_fkey FOREIGN KEY (universite_id) REFERENCES public.universites(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: options_reponses options_reponses_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options_reponses
    ADD CONSTRAINT options_reponses_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: parcours parcours_filiere_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parcours
    ADD CONSTRAINT parcours_filiere_id_fkey FOREIGN KEY (filiere_id) REFERENCES public.filieres(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: profils_academiques profils_academiques_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profils_academiques
    ADD CONSTRAINT profils_academiques_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: recommendations recommendations_filiere_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_filiere_id_fkey FOREIGN KEY (filiere_id) REFERENCES public.filieres(id) ON UPDATE CASCADE;


--
-- Name: recommendations recommendations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendations
    ADD CONSTRAINT recommendations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sessions_test_multi sessions_test_multi_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions_test_multi
    ADD CONSTRAINT sessions_test_multi_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(id) ON UPDATE CASCADE;


--
-- Name: sessions_test_multi sessions_test_multi_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions_test_multi
    ADD CONSTRAINT sessions_test_multi_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sessions_test sessions_test_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions_test
    ADD CONSTRAINT sessions_test_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: test_questions test_questions_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_questions
    ADD CONSTRAINT test_questions_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON UPDATE CASCADE;


--
-- Name: test_questions test_questions_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_questions
    ADD CONSTRAINT test_questions_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_settings user_settings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_settings
    ADD CONSTRAINT user_settings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict ngoODTCZuYv5cYMouQLWpe4eyefziGLuxbSeajkNqtur0D5rNaI6w6iunT8b9pi

