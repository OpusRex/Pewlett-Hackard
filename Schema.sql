-- Table: public.departments

-- DROP TABLE public.departments;

CREATE TABLE public.departments
(
    dept_no character varying(4) COLLATE pg_catalog."default" NOT NULL,
    dept_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT departments_pkey PRIMARY KEY (dept_no),
    CONSTRAINT departments_dept_name_key UNIQUE (dept_name)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.departments
    OWNER to postgres;

-- Table: public.dept_emp

-- DROP TABLE public.dept_emp;

CREATE TABLE public.dept_emp
(
    emp_no integer NOT NULL,
    dept_no character varying COLLATE pg_catalog."default" NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL,
    CONSTRAINT dept_emp_pkey PRIMARY KEY (emp_no),
    CONSTRAINT dept_emp_dept_no_fkey FOREIGN KEY (dept_no)
        REFERENCES public.departments (dept_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT dept_emp_emp_no_fkey FOREIGN KEY (emp_no)
        REFERENCES public.employees (emp_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.dept_emp
    OWNER to postgres;

 -- Table: public.dept_manager

-- DROP TABLE public.dept_manager;

CREATE TABLE public.dept_manager
(
    dept_no character varying(4) COLLATE pg_catalog."default" NOT NULL,
    emp_no integer NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL,
    CONSTRAINT dept_manager_pkey PRIMARY KEY (emp_no, dept_no),
    CONSTRAINT dept_manager_dept_no_fkey FOREIGN KEY (dept_no)
        REFERENCES public.departments (dept_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT dept_manager_emp_no_fkey FOREIGN KEY (emp_no)
        REFERENCES public.employees (emp_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.dept_manager
    OWNER to postgres;

-- Table: public.employees

-- DROP TABLE public.employees;

CREATE TABLE public.employees
(
    emp_no integer NOT NULL,
    birth_date date NOT NULL,
    first_name character varying COLLATE pg_catalog."default" NOT NULL,
    last_name character varying COLLATE pg_catalog."default" NOT NULL,
    gender character varying COLLATE pg_catalog."default" NOT NULL,
    hire_date date NOT NULL,
    CONSTRAINT employees_pkey PRIMARY KEY (emp_no)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.employees
    OWNER to postgres;

 -- Table: public.salaries

-- DROP TABLE public.salaries;

CREATE TABLE public.salaries
(
    emp_no integer NOT NULL,
    salary integer NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL,
    CONSTRAINT salaries_pkey PRIMARY KEY (emp_no),
    CONSTRAINT salaries_emp_no_fkey FOREIGN KEY (emp_no)
        REFERENCES public.employees (emp_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.salaries
    OWNER to postgres;       

-- Table: public.titles

-- DROP TABLE public.titles;

CREATE TABLE public.titles
(
    emp_no integer NOT NULL,
    title character varying COLLATE pg_catalog."default" NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL,
    CONSTRAINT titles_pkey PRIMARY KEY (emp_no),
    CONSTRAINT titles_emp_no_fkey FOREIGN KEY (emp_no)
        REFERENCES public.employees (emp_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.titles
    OWNER to postgres;           