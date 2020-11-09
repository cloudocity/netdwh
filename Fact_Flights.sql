-- public.dim_aircrafts definition

-- Drop table

-- DROP TABLE public.dim_aircrafts;

CREATE TABLE public.dim_aircrafts (
	aircraft_code bpchar(3) NOT NULL,
	model text NULL,
	"range" int4 NOT NULL,
	code bigserial NOT NULL DEFAULT nextval('dim_aircrafts_code_seq'::regclass),
	CONSTRAINT dim_aircrafts_pkey PRIMARY KEY (aircraft_code)
);
CREATE INDEX idx_dim_aircrafts_lookup ON public.dim_aircrafts USING btree (aircraft_code);
CREATE UNIQUE INDEX idx_dim_aircrafts_pk ON public.dim_aircrafts USING btree (code);


-- public.dim_airports definition

-- Drop table

-- DROP TABLE public.dim_airports;

CREATE TABLE public.dim_airports (
	airport_code bpchar(3) NOT NULL,
	airport_name text NULL,
	city varchar(255) NULL,
	id bigserial NOT NULL DEFAULT nextval('dim_airports_id_seq'::regclass),
	CONSTRAINT dim_airports_pkey PRIMARY KEY (airport_code)
);
CREATE INDEX idx_dim_airports_lookup ON public.dim_airports USING btree (airport_code, airport_code);
CREATE UNIQUE INDEX idx_dim_airports_pk ON public.dim_airports USING btree (id);


-- public.dim_passengers definition

-- Drop table

-- DROP TABLE public.dim_passengers;

CREATE TABLE public.dim_passengers (
	passenger_id varchar(20) NOT NULL DEFAULT nextval('dim_passengers_id_seq'::regclass),
	passenger_name text NOT NULL,
	contact_data text NULL,
	id bigserial NOT NULL DEFAULT nextval('dim_passengers_id_seq1'::regclass),
	CONSTRAINT dim_passengers_pkey PRIMARY KEY (passenger_id)
);
CREATE INDEX idx_dim_passengers_lookup ON public.dim_passengers USING btree (passenger_id);
CREATE UNIQUE INDEX idx_dim_passengers_pk ON public.dim_passengers USING btree (id);


-- public.dim_tariff definition

-- Drop table

-- DROP TABLE public.dim_tariff;

CREATE TABLE public.dim_tariff (
	fare_conditions varchar(10) NOT NULL,
	id bigserial NOT NULL DEFAULT nextval('dim_tariff_id_seq'::regclass)
);
CREATE INDEX idx_dim_tariff_lookup ON public.dim_tariff USING btree (fare_conditions);
CREATE UNIQUE INDEX idx_dim_tariff_pk ON public.dim_tariff USING btree (id);


-- public.rejected_aircrafts definition

-- Drop table

-- DROP TABLE public.rejected_aircrafts;

CREATE TABLE public.rejected_aircrafts (
	aircraft_code bpchar(3) NOT NULL,
	model text NULL,
	"range" int4 NOT NULL,
	CONSTRAINT rejected_aircrafts_pkey PRIMARY KEY (aircraft_code)
);


-- public.rejected_airports definition

-- Drop table

-- DROP TABLE public.rejected_airports;

CREATE TABLE public.rejected_airports (
	airport_code bpchar(3) NOT NULL,
	airport_name text NULL,
	city varchar(255) NULL,
	CONSTRAINT rejected_airports_pkey PRIMARY KEY (airport_code)
);


-- public.rejected_passengers definition

-- Drop table

-- DROP TABLE public.rejected_passengers;

CREATE TABLE public.rejected_passengers (
	passenger_id varchar(20) NOT NULL,
	passenger_name text NOT NULL,
	contact_data text NULL,
	CONSTRAINT rejected_passengers_pkey PRIMARY KEY (passenger_id)
);


-- public.rejected_tariff definition

-- Drop table

-- DROP TABLE public.rejected_tariff;

CREATE TABLE public.rejected_tariff (
	fare_conditions varchar(10) NOT NULL
);


-- public.fact_flights definition

-- Drop table

-- DROP TABLE public.fact_flights;

CREATE TABLE public.fact_flights (
	flight_id int4 NOT NULL,
	passenger_id int4 NOT NULL,
	actual_departure timestamp NOT NULL,
	actual_arrival timestamp NOT NULL,
	departure_delay int4 NOT NULL,
	delayed_arrival int4 NOT NULL,
	aircraft_id int4 NOT NULL,
	dep_airport_id int4 NOT NULL,
	ar_airport_id int4 NOT NULL,
	tarif_id int4 NOT NULL,
	amount numeric(10,2) NOT NULL,
	CONSTRAINT fact_flights_pkey PRIMARY KEY (flight_id),
	CONSTRAINT fact_flights_aircraft_id_fkey FOREIGN KEY (aircraft_id) REFERENCES dim_aircrafts(code),
	CONSTRAINT fact_flights_ar_airport_id_fkey FOREIGN KEY (ar_airport_id) REFERENCES dim_airports(id),
	CONSTRAINT fact_flights_dep_airport_id_fkey FOREIGN KEY (dep_airport_id) REFERENCES dim_airports(id),
	CONSTRAINT fact_flights_passenger_id_fkey FOREIGN KEY (passenger_id) REFERENCES dim_passengers(id),
	CONSTRAINT fact_flights_tarif_id_fkey FOREIGN KEY (tarif_id) REFERENCES dim_tariff(id)
);