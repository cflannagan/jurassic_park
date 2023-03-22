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
-- Name: dinosaur_classification; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.dinosaur_classification AS ENUM (
    'carnivore',
    'herbivore'
);


--
-- Name: power_classification; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.power_classification AS ENUM (
    'ACTIVE',
    'DOWN'
);


--
-- Name: check_cage_id(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.check_cage_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      DECLARE
        dinosaur_type TEXT;
        power_status TEXT;
        capacity INTEGER;
        occupancy INTEGER;
      BEGIN

        -- we only care about various checks below if "new" cage_id isn't null and it's a new value
        IF NEW.cage_id IS NOT NULL AND OLD.cage_id IS DISTINCT FROM NEW.cage_id THEN
          -- Make note of new dino type, cage power_status & capacity and number of dinos already in cage
          SELECT species.dinosaur_type INTO dinosaur_type FROM species WHERE species.id = NEW.species_id;
          SELECT cages.power_status INTO power_status FROM cages WHERE cages.id = NEW.cage_id;
          SELECT cages.capacity INTO capacity FROM cages WHERE cages.id = NEW.cage_id;
          SELECT COUNT(*) INTO occupancy FROM dinosaurs WHERE cage_id = NEW.cage_id;

          -- The cage must be powered on
          IF power_status = 'DOWN' THEN
            RAISE EXCEPTION 'Cannot add dinosaur to a powered down cage';
          END IF;
          -- Cage must not be at capacity already
          IF occupancy = capacity THEN
            RAISE EXCEPTION 'Cannot add dinosaur to cage already at capacity';
          END IF;
          -- If it's a carnivore, it can only go into cage with others of same species.
          IF dinosaur_type = 'carnivore'
            AND EXISTS (SELECT * FROM dinosaurs WHERE cage_id = NEW.cage_id AND species_id != NEW.species_id) THEN
            RAISE EXCEPTION 'Cannot add carnivore dinosaur to a cage with different species';
          END IF;
          -- if it's a herbivore, it can only go into cage with other herbivores.
          IF dinosaur_type = 'herbivore' AND
            EXISTS (
              SELECT * FROM dinosaurs JOIN species ON dinosaurs.species_id = species.id WHERE cage_id = NEW.cage_id
                AND species.dinosaur_type = 'carnivore') THEN
            RAISE EXCEPTION 'Cannot add herbivore dinosaur to a cage with carnivore dinosaurs';
          END IF;
        END IF;
        RETURN NEW;
      END;
      $$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: cages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cages (
    id bigint NOT NULL,
    capacity integer DEFAULT 1 NOT NULL,
    power_status public.power_classification DEFAULT 'DOWN'::public.power_classification NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: cages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cages_id_seq OWNED BY public.cages.id;


--
-- Name: dinosaurs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dinosaurs (
    id bigint NOT NULL,
    name character varying NOT NULL,
    species_id bigint NOT NULL,
    cage_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: dinosaurs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dinosaurs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dinosaurs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dinosaurs_id_seq OWNED BY public.dinosaurs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: species; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.species (
    id bigint NOT NULL,
    name character varying NOT NULL,
    dinosaur_type public.dinosaur_classification NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: species_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.species_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: species_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.species_id_seq OWNED BY public.species.id;


--
-- Name: cages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cages ALTER COLUMN id SET DEFAULT nextval('public.cages_id_seq'::regclass);


--
-- Name: dinosaurs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dinosaurs ALTER COLUMN id SET DEFAULT nextval('public.dinosaurs_id_seq'::regclass);


--
-- Name: species id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.species ALTER COLUMN id SET DEFAULT nextval('public.species_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: cages cages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cages
    ADD CONSTRAINT cages_pkey PRIMARY KEY (id);


--
-- Name: dinosaurs dinosaurs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dinosaurs
    ADD CONSTRAINT dinosaurs_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: species species_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.species
    ADD CONSTRAINT species_pkey PRIMARY KEY (id);


--
-- Name: index_dinosaurs_on_cage_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dinosaurs_on_cage_id ON public.dinosaurs USING btree (cage_id);


--
-- Name: index_dinosaurs_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_dinosaurs_on_name ON public.dinosaurs USING btree (name);


--
-- Name: index_dinosaurs_on_species_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_dinosaurs_on_species_id ON public.dinosaurs USING btree (species_id);


--
-- Name: index_species_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_species_on_name ON public.species USING btree (name);


--
-- Name: dinosaurs check_cage_id; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER check_cage_id BEFORE INSERT OR UPDATE ON public.dinosaurs FOR EACH ROW EXECUTE FUNCTION public.check_cage_id();


--
-- Name: dinosaurs fk_rails_5f4340d30a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dinosaurs
    ADD CONSTRAINT fk_rails_5f4340d30a FOREIGN KEY (cage_id) REFERENCES public.cages(id);


--
-- Name: dinosaurs fk_rails_eee9cc8237; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dinosaurs
    ADD CONSTRAINT fk_rails_eee9cc8237 FOREIGN KEY (species_id) REFERENCES public.species(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20230321140843'),
('20230321144009'),
('20230321145856'),
('20230321235922');


