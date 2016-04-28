--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: pingeso; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE pingeso IS 'Base de datos de PINGESO (de los 3 proyectos juntos).';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alumno; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE alumno (
    id_alumno integer NOT NULL,
    id_plan_activo integer,
    version_plan_activo integer,
    rut_usuario character varying(255)
);


ALTER TABLE public.alumno OWNER TO postgres;

--
-- Name: alumno_id_alumno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE alumno_id_alumno_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.alumno_id_alumno_seq OWNER TO postgres;

--
-- Name: alumno_id_alumno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE alumno_id_alumno_seq OWNED BY alumno.id_alumno;


--
-- Name: alumno_id_alumno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('alumno_id_alumno_seq', 34, true);


--
-- Name: asignatura; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE asignatura (
    id bigint NOT NULL,
    codigo character varying(255),
    ejercicios integer,
    laboratorio integer,
    nivel integer,
    nombre character varying(255),
    teoria integer,
    versionplan_id bigint,
    alias character varying(255)
);


ALTER TABLE public.asignatura OWNER TO postgres;

--
-- Name: asignatura_asignatura; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE asignatura_asignatura (
    asignatura_id bigint NOT NULL,
    prerequisitos_id bigint NOT NULL
);


ALTER TABLE public.asignatura_asignatura OWNER TO postgres;

--
-- Name: asignatura_profesor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE asignatura_profesor (
    asignaturas_id bigint NOT NULL,
    profesores_rut_profesor character varying(255) NOT NULL
);


ALTER TABLE public.asignatura_profesor OWNER TO postgres;

--
-- Name: asociado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE asociado (
    idasociado bigint NOT NULL,
    nombreasociado character varying(255) NOT NULL,
    idcategoria_idcategoria bigint
);


ALTER TABLE public.asociado OWNER TO postgres;

--
-- Name: carrera; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE carrera (
    id bigint NOT NULL,
    nombre character varying(255)
);


ALTER TABLE public.carrera OWNER TO postgres;

--
-- Name: categoriaaevento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE categoriaaevento (
    idcategoria bigint NOT NULL,
    nombrecategoria character varying(255)
);


ALTER TABLE public.categoriaaevento OWNER TO postgres;

--
-- Name: checklist; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE checklist (
    id bigint NOT NULL,
    aceptado boolean,
    encuesta_id bigint,
    asignatura_id bigint
);


ALTER TABLE public.checklist OWNER TO postgres;

--
-- Name: checklisteventos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE checklisteventos (
    idchecklist bigint NOT NULL,
    adm_expositor boolean,
    agenda_institucional boolean,
    avisar_cancelacion boolean,
    confimacion_inscritos boolean,
    cupos boolean,
    diinf_medios boolean,
    evento_facebook boolean,
    evento_twitter boolean,
    facebook boolean,
    linkedin boolean,
    lugar boolean,
    noticia_web_diinf boolean,
    publicar_calendario boolean,
    publicar_web boolean,
    publico_objetivo boolean,
    publico_usach boolean,
    radio_usach boolean,
    redes_usach boolean,
    twitter boolean,
    url_corta boolean
);


ALTER TABLE public.checklisteventos OWNER TO postgres;

--
-- Name: comision_correctora; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comision_correctora (
    id_correctora integer NOT NULL,
    fecha_correccion character varying(255),
    fecha_correccion2 character varying(255),
    fecha_entrega_correccion character varying(255),
    fecha_entrega_correccion2 character varying(255),
    id_semestre character varying(255),
    id_tema integer
);


ALTER TABLE public.comision_correctora OWNER TO postgres;

--
-- Name: comision_correctora_id_correctora_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comision_correctora_id_correctora_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.comision_correctora_id_correctora_seq OWNER TO postgres;

--
-- Name: comision_correctora_id_correctora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comision_correctora_id_correctora_seq OWNED BY comision_correctora.id_correctora;


--
-- Name: comision_correctora_id_correctora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comision_correctora_id_correctora_seq', 9, true);


--
-- Name: comision_revisora; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comision_revisora (
    id_revisora integer NOT NULL,
    fecha_entrega_revision character varying(255),
    fecha_entrega_revision2 character varying(255),
    fecha_publicacion_consejo character varying(255),
    fecha_revision character varying(255),
    fecha_revision2 character varying(255),
    fecha_termino_publicacion_consejo character varying(255),
    tipo_revision integer,
    id_propuesta integer,
    id_semestre character varying(255),
    id_tema integer
);


ALTER TABLE public.comision_revisora OWNER TO postgres;

--
-- Name: comision_revisora_id_revisora_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comision_revisora_id_revisora_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.comision_revisora_id_revisora_seq OWNER TO postgres;

--
-- Name: comision_revisora_id_revisora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comision_revisora_id_revisora_seq OWNED BY comision_revisora.id_revisora;


--
-- Name: comision_revisora_id_revisora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comision_revisora_id_revisora_seq', 12, true);


--
-- Name: comuna; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comuna (
    comuna_id integer DEFAULT 0 NOT NULL,
    comuna_nombre character varying(20),
    comuna_provincia_id integer
);


ALTER TABLE public.comuna OWNER TO postgres;

--
-- Name: coordinacion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE coordinacion (
    id bigint NOT NULL,
    anio integer,
    cantalumnosestimado integer,
    cantalumnosreal integer,
    semestre integer,
    asignatura_id bigint,
    alias character varying(255)
);


ALTER TABLE public.coordinacion OWNER TO postgres;

--
-- Name: encuesta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE encuesta (
    id bigint NOT NULL,
    anio integer,
    comentario character varying(255),
    semestre integer,
    profesor_rut_profesor character varying(255)
);


ALTER TABLE public.encuesta OWNER TO postgres;

--
-- Name: evento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE evento (
    idevento bigint NOT NULL,
    rsu boolean,
    codigo integer,
    comuna character varying(255),
    cuposdepartamento integer,
    cuposinvitados integer,
    entidadreceptora character varying(255),
    estado character varying(255),
    fechahora timestamp without time zone NOT NULL,
    financiamiento character varying(255),
    imagen bytea,
    institucionorigen character varying(255),
    invitadoapellido character varying(255),
    invitadocargo character varying(255),
    invitadocomentarios character varying(1000),
    invitadocorreo character varying(255),
    invitadonombre character varying(255),
    lugar character varying(255),
    nombreproyecto character varying(255),
    origensolicitud character varying(255),
    proyectovinculado character varying(255),
    publicoobjetivo character varying(255),
    region character varying(255),
    resumen character varying(1000),
    sala character varying(255),
    titulo character varying(255) NOT NULL,
    unidadacademicamayor character varying(255),
    unidadacademicamenor character varying(255),
    idsubtipo_idsubtipo bigint,
    idchecklist_idchecklist bigint
);


ALTER TABLE public.evento OWNER TO postgres;

--
-- Name: evento_asociado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE evento_asociado (
    id bigint NOT NULL,
    idasociado_idasociado bigint,
    idevento_idevento bigint
);


ALTER TABLE public.evento_asociado OWNER TO postgres;

--
-- Name: evento_expositor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE evento_expositor (
    id bigint NOT NULL,
    idevento_idevento bigint,
    idexpositor_idexpositor bigint
);


ALTER TABLE public.evento_expositor OWNER TO postgres;

--
-- Name: expositor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE expositor (
    idexpositor bigint NOT NULL,
    apellido character varying(255),
    correo character varying(255),
    grado character varying(255),
    institucionorigen character varying(255),
    nombre character varying(255),
    pais character varying(255),
    resenabibliografica character varying(1000),
    telefono character varying(255)
);


ALTER TABLE public.expositor OWNER TO postgres;

--
-- Name: historial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE historial (
    id_historial integer NOT NULL,
    descripcion character varying(255),
    fecha_historial character varying(255),
    id_entidad character varying(255),
    tipo_historial integer
);


ALTER TABLE public.historial OWNER TO postgres;

--
-- Name: historial_id_historial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE historial_id_historial_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.historial_id_historial_seq OWNER TO postgres;

--
-- Name: historial_id_historial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE historial_id_historial_seq OWNED BY historial.id_historial;


--
-- Name: historial_id_historial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('historial_id_historial_seq', 2, true);


--
-- Name: horario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE horario (
    id bigint NOT NULL,
    bloque character varying(255),
    tipo character varying(255),
    profesor_rut_profesor character varying(255),
    seccion_id bigint
);


ALTER TABLE public.horario OWNER TO postgres;

--
-- Name: inscripcion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE inscripcion (
    idinscripcion bigint NOT NULL,
    apellido character varying(255),
    carrera character varying(255),
    email character varying(255),
    nombre character varying(255),
    ocupacion character varying(255),
    spam boolean,
    idevento_idevento bigint
);


ALTER TABLE public.inscripcion OWNER TO postgres;

--
-- Name: inscripcionspam; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE inscripcionspam (
    idinscripcion bigint NOT NULL,
    apellido character varying(255),
    carrera character varying(255),
    email character varying(255),
    evento character varying(255),
    nombre character varying(255),
    ocupacion character varying(255),
    spam boolean
);


ALTER TABLE public.inscripcionspam OWNER TO postgres;

--
-- Name: logs; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE logs (
    logs_id integer NOT NULL,
    dated timestamp without time zone,
    level character varying(255),
    logger character varying(255),
    message character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.logs OWNER TO postgres;

--
-- Name: logs_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE logs_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.logs_logs_id_seq OWNER TO postgres;

--
-- Name: logs_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE logs_logs_id_seq OWNED BY logs.logs_id;


--
-- Name: logs_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('logs_logs_id_seq', 275, true);


--
-- Name: paramsemestreano; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE paramsemestreano (
    id bigint NOT NULL,
    anoactual integer,
    semestreactual integer
);


ALTER TABLE public.paramsemestreano OWNER TO postgres;

--
-- Name: planes_alumno; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE planes_alumno (
    alumno_id character varying(255) NOT NULL,
    plan_id bigint NOT NULL,
    activo boolean,
    version_plan integer
);


ALTER TABLE public.planes_alumno OWNER TO postgres;

--
-- Name: planestudio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE planestudio (
    id bigint NOT NULL,
    codigo integer,
    jornada integer,
    carrera_id bigint
);


ALTER TABLE public.planestudio OWNER TO postgres;

--
-- Name: profe_correccion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE profe_correccion (
    nota_correccion_defensa double precision,
    nota_correccion_informe double precision,
    rol_correccion integer,
    rut_profesor character varying(255) NOT NULL,
    id_correctora integer NOT NULL
);


ALTER TABLE public.profe_correccion OWNER TO postgres;

--
-- Name: profe_propuesta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE profe_propuesta (
    fecha_revision character varying(255),
    nota_guia_defensa double precision,
    nota_guia_informe double precision,
    rol_guia integer,
    rut_profesor character varying(255) NOT NULL,
    id_propuesta integer NOT NULL
);


ALTER TABLE public.profe_propuesta OWNER TO postgres;

--
-- Name: profe_revision; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE profe_revision (
    fecha_revision character varying(255),
    rol_revision integer,
    rut_profesor character varying(255) NOT NULL,
    id_revisora integer NOT NULL
);


ALTER TABLE public.profe_revision OWNER TO postgres;

--
-- Name: profesor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE profesor (
    id_profesor integer NOT NULL,
    contrato integer,
    jerarquia_categoria character varying(255),
    maximo_guias integer,
    tipo_profesor integer,
    rut_usuario character varying(255)
);


ALTER TABLE public.profesor OWNER TO postgres;

--
-- Name: profesor_id_profesor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE profesor_id_profesor_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.profesor_id_profesor_seq OWNER TO postgres;

--
-- Name: profesor_id_profesor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE profesor_id_profesor_seq OWNED BY profesor.id_profesor;


--
-- Name: profesor_id_profesor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('profesor_id_profesor_seq', 56, true);


--
-- Name: propuesta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE propuesta (
    id_propuesta integer NOT NULL,
    fecha_propuesta character varying(255),
    id_plan integer,
    magister boolean,
    nombre_propuesta character varying(255),
    pet boolean,
    version_plan integer,
    id_revisora integer,
    id_semestre character varying(255),
    rut_alumno character varying(255)
);


ALTER TABLE public.propuesta OWNER TO postgres;

--
-- Name: propuesta_id_propuesta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE propuesta_id_propuesta_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.propuesta_id_propuesta_seq OWNER TO postgres;

--
-- Name: propuesta_id_propuesta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE propuesta_id_propuesta_seq OWNED BY propuesta.id_propuesta;


--
-- Name: propuesta_id_propuesta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('propuesta_id_propuesta_seq', 10, true);


--
-- Name: provincia; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE provincia (
    provincia_id integer DEFAULT 0 NOT NULL,
    provincia_nombre character varying(23),
    provincia_region_id integer
);


ALTER TABLE public.provincia OWNER TO postgres;

--
-- Name: region; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE region (
    region_id integer DEFAULT 0 NOT NULL,
    region_nombre character varying(50)
);


ALTER TABLE public.region OWNER TO postgres;

--
-- Name: seccion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE seccion (
    id bigint NOT NULL,
    codigo character varying(255),
    coordinacion_id bigint
);


ALTER TABLE public.seccion OWNER TO postgres;

--
-- Name: semestre; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE semestre (
    id_semestre character varying(255) NOT NULL,
    fecha_cierre character varying(255),
    fecha_precierre character varying(255)
);


ALTER TABLE public.semestre OWNER TO postgres;

--
-- Name: semestre_actual; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE semestre_actual (
    semestre_actual character varying(255) NOT NULL
);


ALTER TABLE public.semestre_actual OWNER TO postgres;

--
-- Name: sequence; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sequence (
    seq_name character varying(50) NOT NULL,
    seq_count numeric(38,0)
);


ALTER TABLE public.sequence OWNER TO postgres;

--
-- Name: subtipo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE subtipo (
    idsubtipo bigint NOT NULL,
    nombresubtipo character varying(255),
    idtipoevento_idtipoevento bigint
);


ALTER TABLE public.subtipo OWNER TO postgres;

--
-- Name: tema; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tema (
    id_tema integer NOT NULL,
    estado_tema integer,
    fecha_borrador character varying(255),
    fecha_caducado character varying(255),
    fecha_informe_avance character varying(255),
    fecha_real character varying(255),
    fecha_renuncia character varying(255),
    fecha_siac character varying(255),
    fecha_tema character varying(255),
    nombre_tema character varying(255),
    precerrado boolean,
    semestre_termino character varying(255),
    id_correctora integer,
    id_revisora integer,
    id_semestre character varying(255)
);


ALTER TABLE public.tema OWNER TO postgres;

--
-- Name: tema_id_tema_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tema_id_tema_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tema_id_tema_seq OWNER TO postgres;

--
-- Name: tema_id_tema_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tema_id_tema_seq OWNED BY tema.id_tema;


--
-- Name: tipo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo (
    nombre_tipo character varying(255) NOT NULL
);


ALTER TABLE public.tipo OWNER TO postgres;

--
-- Name: tipoevento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipoevento (
    idtipoevento bigint NOT NULL,
    nombretipo character varying(255)
);


ALTER TABLE public.tipoevento OWNER TO postgres;

--
-- Name: tipousuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipousuario (
    id_tipo bigint NOT NULL,
    nombre_tipo character varying(255),
    pass character varying(255)
);


ALTER TABLE public.tipousuario OWNER TO postgres;

--
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    rut_usuario character varying(255) NOT NULL,
    activo boolean,
    apellido_usuario character varying(255),
    direccion_usuario character varying(255),
    mail_usuario character varying(255),
    nombre_usuario character varying(255),
    telefono_usuario character varying(255),
    tema_usuario character varying(255),
    uid character varying(255),
    comuna integer
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- Name: usuario_tipo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario_tipo (
    id_usuario_tipo integer NOT NULL,
    nombre_tipo character varying(255),
    username character varying(255)
);


ALTER TABLE public.usuario_tipo OWNER TO postgres;

--
-- Name: usuario_tipo_id_usuario_tipo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE usuario_tipo_id_usuario_tipo_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.usuario_tipo_id_usuario_tipo_seq OWNER TO postgres;

--
-- Name: usuario_tipo_id_usuario_tipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuario_tipo_id_usuario_tipo_seq OWNED BY usuario_tipo.id_usuario_tipo;


--
-- Name: usuario_tipo_id_usuario_tipo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuario_tipo_id_usuario_tipo_seq', 1, false);


--
-- Name: usuario_tipousuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario_tipousuario (
    usuario_rut_usuario character varying(255) NOT NULL,
    tipos_id_tipo bigint NOT NULL
);


ALTER TABLE public.usuario_tipousuario OWNER TO postgres;

--
-- Name: usuariobytipo; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW usuariobytipo AS
    SELECT u.uid, t.nombre_tipo, t.pass FROM usuario u, usuario_tipousuario ut, tipousuario t WHERE (((u.rut_usuario)::text = (ut.usuario_rut_usuario)::text) AND (ut.tipos_id_tipo = t.id_tipo));


ALTER TABLE public.usuariobytipo OWNER TO postgres;

--
-- Name: usuarioevento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuarioevento (
    id bigint NOT NULL,
    clave character varying(255),
    nombre character varying(255),
    rol character varying(255)
);


ALTER TABLE public.usuarioevento OWNER TO postgres;

--
-- Name: versionplan; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE versionplan (
    id bigint NOT NULL,
    anio integer,
    version integer,
    planestudio_id bigint,
    resolucion integer,
    anio_resolucion integer,
    planificado boolean,
    correlativo integer
);


ALTER TABLE public.versionplan OWNER TO postgres;

--
-- Name: id_alumno; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY alumno ALTER COLUMN id_alumno SET DEFAULT nextval('alumno_id_alumno_seq'::regclass);


--
-- Name: id_correctora; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_correctora ALTER COLUMN id_correctora SET DEFAULT nextval('comision_correctora_id_correctora_seq'::regclass);


--
-- Name: id_revisora; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_revisora ALTER COLUMN id_revisora SET DEFAULT nextval('comision_revisora_id_revisora_seq'::regclass);


--
-- Name: id_historial; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY historial ALTER COLUMN id_historial SET DEFAULT nextval('historial_id_historial_seq'::regclass);


--
-- Name: logs_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY logs ALTER COLUMN logs_id SET DEFAULT nextval('logs_logs_id_seq'::regclass);


--
-- Name: id_profesor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profesor ALTER COLUMN id_profesor SET DEFAULT nextval('profesor_id_profesor_seq'::regclass);


--
-- Name: id_propuesta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY propuesta ALTER COLUMN id_propuesta SET DEFAULT nextval('propuesta_id_propuesta_seq'::regclass);


--
-- Name: id_tema; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tema ALTER COLUMN id_tema SET DEFAULT nextval('tema_id_tema_seq'::regclass);


--
-- Name: id_usuario_tipo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario_tipo ALTER COLUMN id_usuario_tipo SET DEFAULT nextval('usuario_tipo_id_usuario_tipo_seq'::regclass);


--
-- Data for Name: alumno; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO alumno VALUES (22, NULL, NULL, '145010330');
INSERT INTO alumno VALUES (23, NULL, NULL, '138328449');
INSERT INTO alumno VALUES (24, NULL, NULL, '130461786');
INSERT INTO alumno VALUES (26, NULL, NULL, '156203181');
INSERT INTO alumno VALUES (31, NULL, NULL, '70658828');
INSERT INTO alumno VALUES (34, NULL, NULL, '144409558');
INSERT INTO alumno VALUES (27, 3, 2, '175657436');
INSERT INTO alumno VALUES (17, 3, 2, '179043939');
INSERT INTO alumno VALUES (18, 3, 1, '163601311');
INSERT INTO alumno VALUES (21, 3, 2, '169410313');
INSERT INTO alumno VALUES (28, 3, 2, '17490314K');
INSERT INTO alumno VALUES (29, 6, 1, '173865090');
INSERT INTO alumno VALUES (25, 3, 1, '164115267');
INSERT INTO alumno VALUES (20, 1, 3, '158407337');
INSERT INTO alumno VALUES (30, 4, 1, '156232890');
INSERT INTO alumno VALUES (32, 4, 1, '161943177');
INSERT INTO alumno VALUES (33, 1, 1, '136725092');


--
-- Data for Name: asignatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY asignatura (id, codigo, ejercicios, laboratorio, nivel, nombre, teoria, versionplan_id, alias) FROM stdin;
\.


--
-- Data for Name: asignatura_asignatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY asignatura_asignatura (asignatura_id, prerequisitos_id) FROM stdin;
\.


--
-- Data for Name: asignatura_profesor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY asignatura_profesor (asignaturas_id, profesores_rut_profesor) FROM stdin;
\.


--
-- Data for Name: asociado; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO asociado VALUES (1, 'HÉCTOR ANTILLANCA ESPINA', 1);
INSERT INTO asociado VALUES (2, 'GONZALO ACUÑA LEIVA', 1);
INSERT INTO asociado VALUES (3, 'MAX CHACÓN PACHECO', 1);
INSERT INTO asociado VALUES (4, 'FERNANDO CONTRERAS BOTTO', 1);
INSERT INTO asociado VALUES (5, 'ROBERTO GONZALÉZ IBÁÑEZ ', 1);
INSERT INTO asociado VALUES (6, 'NICOLÁS HIDALGO CASTILLO', 1);
INSERT INTO asociado VALUES (7, 'MARIO INOSTROZA PONTA', 1);
INSERT INTO asociado VALUES (8, 'JL JARA ', 1);
INSERT INTO asociado VALUES (9, 'ERIKA ROSAS OLIVOS ', 1);
INSERT INTO asociado VALUES (10, 'EDMUNDO LEIVA LOBOS', 1);
INSERT INTO asociado VALUES (11, 'MAURICIO MARÍN CAIHUÁN ', 1);
INSERT INTO asociado VALUES (12, 'ROSA MUÑOZ CALANCHIE', 1);
INSERT INTO asociado VALUES (13, 'VÍCTOR PARADA DAZA', 1);
INSERT INTO asociado VALUES (14, 'FERNANDO RANNOU FUENTES', 1);
INSERT INTO asociado VALUES (15, 'MÓNICA VILLANUEVA ILUFI', 1);
INSERT INTO asociado VALUES (16, 'CAROLINA BONACIC CASTRO', 1);
INSERT INTO asociado VALUES (17, 'SERGIO A. VELASTIN', 1);
INSERT INTO asociado VALUES (18, 'CEII ', 3);
INSERT INTO asociado VALUES (19, 'GNU USACH ', 3);
INSERT INTO asociado VALUES (20, 'CITIAPS', 5);
INSERT INTO asociado VALUES (21, 'EQUIFAX', 2);


--
-- Data for Name: carrera; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO carrera VALUES (1, 'INGENIERÍA CIVIL EN INFORMÁTICA');
INSERT INTO carrera VALUES (2, 'INGENIERÍA  DE EJECUCIÓN EN COMPUTACIÓN E INFORMÁTICA');


--
-- Data for Name: categoriaaevento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO categoriaaevento VALUES (1, 'Académico Jornada Completa');
INSERT INTO categoriaaevento VALUES (2, 'Empresa');
INSERT INTO categoriaaevento VALUES (3, 'Grupo de Interes');
INSERT INTO categoriaaevento VALUES (4, 'Egresado');
INSERT INTO categoriaaevento VALUES (5, 'Unidad Universitaria');


--
-- Data for Name: checklist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY checklist (id, aceptado, encuesta_id, asignatura_id) FROM stdin;
\.


--
-- Data for Name: checklisteventos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY checklisteventos (idchecklist, adm_expositor, agenda_institucional, avisar_cancelacion, confimacion_inscritos, cupos, diinf_medios, evento_facebook, evento_twitter, facebook, linkedin, lugar, noticia_web_diinf, publicar_calendario, publicar_web, publico_objetivo, publico_usach, radio_usach, redes_usach, twitter, url_corta) FROM stdin;
\.


--
-- Data for Name: comision_correctora; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO comision_correctora VALUES (3, '30/07/2016', '30/07/2016', '31/07/2016', '31/07/2016', '1/2014', 10);
INSERT INTO comision_correctora VALUES (4, '07/06/2016', '07/06/2016', '08/06/2016', '08/06/2016', '1/2014', 11);
INSERT INTO comision_correctora VALUES (5, '21/07/2016', '21/07/2016', '22/07/2016', '22/07/2016', '1/2014', 7);
INSERT INTO comision_correctora VALUES (6, '15/09/2016', '15/09/2016', '16/09/2016', '16/09/2016', '2/2014', 9);
INSERT INTO comision_correctora VALUES (7, '22/09/2016', '22/09/2016', '23/09/2016', '23/09/2016', '2/2014', 6);
INSERT INTO comision_correctora VALUES (8, '18/08/2016', '18/08/2016', '19/08/2016', '19/08/2016', '2/2014', 12);
INSERT INTO comision_correctora VALUES (9, '27/05/2016', '27/05/2016', '28/05/2016', '28/05/2016', '2/2014', 5);


--
-- Data for Name: comision_revisora; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO comision_revisora VALUES (3, NULL, NULL, '20/04/2016', NULL, NULL, '21/04/2016', 2, 1, '1/2014', 3);
INSERT INTO comision_revisora VALUES (4, NULL, NULL, '28/04/2016', NULL, NULL, NULL, 1, 2, '1/2014', 4);
INSERT INTO comision_revisora VALUES (5, NULL, NULL, '01/05/2016', NULL, NULL, NULL, 1, 3, '1/2014', 5);
INSERT INTO comision_revisora VALUES (6, NULL, NULL, '25/05/2016', NULL, NULL, NULL, 1, 4, '1/2014', 6);
INSERT INTO comision_revisora VALUES (7, NULL, NULL, '04/05/2016', NULL, NULL, '25/05/2016', 2, 5, '1/2014', 7);
INSERT INTO comision_revisora VALUES (8, NULL, NULL, '01/06/2016', NULL, NULL, NULL, 1, 6, '1/2014', 8);
INSERT INTO comision_revisora VALUES (9, NULL, NULL, '30/04/2016', NULL, NULL, '03/05/2016', 2, 7, '1/2014', 9);
INSERT INTO comision_revisora VALUES (10, NULL, NULL, '10/07/2016', NULL, NULL, '19/07/2016', 2, 8, '1/2014', 10);
INSERT INTO comision_revisora VALUES (11, NULL, NULL, '01/06/2016', NULL, NULL, '02/06/2016', 2, 9, '1/2014', 11);
INSERT INTO comision_revisora VALUES (12, NULL, NULL, '29/06/2016', NULL, NULL, '30/06/2016', 2, 10, '1/2014', 12);


--
-- Data for Name: comuna; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO comuna VALUES (1101, 'Iquique', 11);
INSERT INTO comuna VALUES (1107, 'Alto Hospicio', 11);
INSERT INTO comuna VALUES (1401, 'Pozo Almonte', 14);
INSERT INTO comuna VALUES (1402, 'Camiña', 14);
INSERT INTO comuna VALUES (1403, 'Colchane', 14);
INSERT INTO comuna VALUES (1404, 'Huara', 14);
INSERT INTO comuna VALUES (1405, 'Pica', 14);
INSERT INTO comuna VALUES (2101, 'Antofagasta', 21);
INSERT INTO comuna VALUES (2102, 'Mejillones', 21);
INSERT INTO comuna VALUES (2103, 'Sierra Gorda', 21);
INSERT INTO comuna VALUES (2104, 'Taltal', 21);
INSERT INTO comuna VALUES (2201, 'Calama', 22);
INSERT INTO comuna VALUES (2202, 'Ollagüe', 22);
INSERT INTO comuna VALUES (2203, 'San Pedro de Atacama', 22);
INSERT INTO comuna VALUES (2301, 'Tocopilla', 23);
INSERT INTO comuna VALUES (2302, 'María Elena', 23);
INSERT INTO comuna VALUES (3101, 'Copiapó', 31);
INSERT INTO comuna VALUES (3102, 'Caldera', 31);
INSERT INTO comuna VALUES (3103, 'Tierra Amarilla', 31);
INSERT INTO comuna VALUES (3201, 'Chañaral', 32);
INSERT INTO comuna VALUES (3202, 'Diego de Almagro', 32);
INSERT INTO comuna VALUES (3301, 'Vallenar', 33);
INSERT INTO comuna VALUES (3302, 'Alto del Carmen', 33);
INSERT INTO comuna VALUES (3303, 'Freirina', 33);
INSERT INTO comuna VALUES (3304, 'Huasco', 33);
INSERT INTO comuna VALUES (4101, 'La Serena', 41);
INSERT INTO comuna VALUES (4102, 'Coquimbo', 41);
INSERT INTO comuna VALUES (4103, 'Andacollo', 41);
INSERT INTO comuna VALUES (4104, 'La Higuera', 41);
INSERT INTO comuna VALUES (4105, 'Paihuano', 41);
INSERT INTO comuna VALUES (4106, 'Vicuña', 41);
INSERT INTO comuna VALUES (4201, 'Illapel', 42);
INSERT INTO comuna VALUES (4202, 'Canela', 42);
INSERT INTO comuna VALUES (4203, 'Los Vilos', 42);
INSERT INTO comuna VALUES (4204, 'Salamanca', 42);
INSERT INTO comuna VALUES (4301, 'Ovalle', 43);
INSERT INTO comuna VALUES (4302, 'Combarbalá', 43);
INSERT INTO comuna VALUES (4303, 'Monte Patria', 43);
INSERT INTO comuna VALUES (4304, 'Punitaqui', 43);
INSERT INTO comuna VALUES (4305, 'Río Hurtado', 43);
INSERT INTO comuna VALUES (5101, 'Valparaíso', 51);
INSERT INTO comuna VALUES (5102, 'Casablanca', 51);
INSERT INTO comuna VALUES (5103, 'Concón', 51);
INSERT INTO comuna VALUES (5104, 'Juan Fernández', 51);
INSERT INTO comuna VALUES (5105, 'Puchuncaví', 51);
INSERT INTO comuna VALUES (5107, 'Quintero', 51);
INSERT INTO comuna VALUES (5109, 'Viña del Mar', 51);
INSERT INTO comuna VALUES (5201, 'Isla de Pascua', 52);
INSERT INTO comuna VALUES (5301, 'Los Andes', 53);
INSERT INTO comuna VALUES (5302, 'Calle Larga', 53);
INSERT INTO comuna VALUES (5303, 'Rinconada', 53);
INSERT INTO comuna VALUES (5304, 'San Esteban', 53);
INSERT INTO comuna VALUES (5401, 'La Ligua', 54);
INSERT INTO comuna VALUES (5402, 'Cabildo', 54);
INSERT INTO comuna VALUES (5403, 'Papudo', 54);
INSERT INTO comuna VALUES (5404, 'Petorca', 54);
INSERT INTO comuna VALUES (5405, 'Zapallar', 54);
INSERT INTO comuna VALUES (5501, 'Quillota', 55);
INSERT INTO comuna VALUES (5502, 'La Calera', 55);
INSERT INTO comuna VALUES (5503, 'Hijuelas', 55);
INSERT INTO comuna VALUES (5504, 'La Cruz', 55);
INSERT INTO comuna VALUES (5506, 'Nogales', 55);
INSERT INTO comuna VALUES (5601, 'San Antonio', 56);
INSERT INTO comuna VALUES (5602, 'Algarrobo', 56);
INSERT INTO comuna VALUES (5603, 'Cartagena', 56);
INSERT INTO comuna VALUES (5604, 'El Quisco', 56);
INSERT INTO comuna VALUES (5605, 'El Tabo', 56);
INSERT INTO comuna VALUES (5606, 'Santo Domingo', 56);
INSERT INTO comuna VALUES (5701, 'San Felipe', 57);
INSERT INTO comuna VALUES (5702, 'Catemu', 57);
INSERT INTO comuna VALUES (5703, 'Llay Llay', 57);
INSERT INTO comuna VALUES (5704, 'Panquehue', 57);
INSERT INTO comuna VALUES (5705, 'Putaendo', 57);
INSERT INTO comuna VALUES (5706, 'Santa María', 57);
INSERT INTO comuna VALUES (5801, 'Quilpué', 58);
INSERT INTO comuna VALUES (5802, 'Limache', 58);
INSERT INTO comuna VALUES (5803, 'Olmué', 58);
INSERT INTO comuna VALUES (5804, 'Villa Alemana', 58);
INSERT INTO comuna VALUES (6101, 'Rancagua', 61);
INSERT INTO comuna VALUES (6102, 'Codegua', 61);
INSERT INTO comuna VALUES (6103, 'Coinco', 61);
INSERT INTO comuna VALUES (6104, 'Coltauco', 61);
INSERT INTO comuna VALUES (6105, 'Doñihue', 61);
INSERT INTO comuna VALUES (6106, 'Graneros', 61);
INSERT INTO comuna VALUES (6107, 'Las Cabras', 61);
INSERT INTO comuna VALUES (6108, 'Machalí', 61);
INSERT INTO comuna VALUES (6109, 'Malloa', 61);
INSERT INTO comuna VALUES (6110, 'Mostazal', 61);
INSERT INTO comuna VALUES (6111, 'Olivar', 61);
INSERT INTO comuna VALUES (6112, 'Peumo', 61);
INSERT INTO comuna VALUES (6113, 'Pichidegua', 61);
INSERT INTO comuna VALUES (6114, 'Quinta de Tilcoco', 61);
INSERT INTO comuna VALUES (6115, 'Rengo', 61);
INSERT INTO comuna VALUES (6116, 'Requínoa', 61);
INSERT INTO comuna VALUES (6117, 'San Vicente', 61);
INSERT INTO comuna VALUES (6201, 'Pichilemu', 62);
INSERT INTO comuna VALUES (6202, 'La Estrella', 62);
INSERT INTO comuna VALUES (6203, 'Litueche', 62);
INSERT INTO comuna VALUES (6204, 'Marchihue', 62);
INSERT INTO comuna VALUES (6205, 'Navidad', 62);
INSERT INTO comuna VALUES (6206, 'Paredones', 62);
INSERT INTO comuna VALUES (6301, 'San Fernando', 63);
INSERT INTO comuna VALUES (6302, 'Chépica', 63);
INSERT INTO comuna VALUES (6303, 'Chimbarongo', 63);
INSERT INTO comuna VALUES (6304, 'Lolol', 63);
INSERT INTO comuna VALUES (6305, 'Nancagua', 63);
INSERT INTO comuna VALUES (6306, 'Palmilla', 63);
INSERT INTO comuna VALUES (6307, 'Peralillo', 63);
INSERT INTO comuna VALUES (6308, 'Placilla', 63);
INSERT INTO comuna VALUES (6309, 'Pumanque', 63);
INSERT INTO comuna VALUES (6310, 'Santa Cruz', 63);
INSERT INTO comuna VALUES (7101, 'Talca', 71);
INSERT INTO comuna VALUES (7102, 'Constitución', 71);
INSERT INTO comuna VALUES (7103, 'Curepto', 71);
INSERT INTO comuna VALUES (7104, 'Empedrado', 71);
INSERT INTO comuna VALUES (7105, 'Maule', 71);
INSERT INTO comuna VALUES (7106, 'Pelarco', 71);
INSERT INTO comuna VALUES (7107, 'Pencahue', 71);
INSERT INTO comuna VALUES (7108, 'Río Claro', 71);
INSERT INTO comuna VALUES (7109, 'San Clemente', 71);
INSERT INTO comuna VALUES (7110, 'San Rafael', 71);
INSERT INTO comuna VALUES (7201, 'Cauquenes', 72);
INSERT INTO comuna VALUES (7202, 'Chanco', 72);
INSERT INTO comuna VALUES (7203, 'Pelluhue', 72);
INSERT INTO comuna VALUES (7301, 'Curicó', 73);
INSERT INTO comuna VALUES (7302, 'Hualañé', 73);
INSERT INTO comuna VALUES (7303, 'Licantén', 73);
INSERT INTO comuna VALUES (7304, 'Molina', 73);
INSERT INTO comuna VALUES (7305, 'Rauco', 73);
INSERT INTO comuna VALUES (7306, 'Romeral', 73);
INSERT INTO comuna VALUES (7307, 'Sagrada Familia', 73);
INSERT INTO comuna VALUES (7308, 'Teno', 73);
INSERT INTO comuna VALUES (7309, 'Vichuquén', 73);
INSERT INTO comuna VALUES (7401, 'Linares', 74);
INSERT INTO comuna VALUES (7402, 'Colbún', 74);
INSERT INTO comuna VALUES (7403, 'Longaví', 74);
INSERT INTO comuna VALUES (7404, 'Parral', 74);
INSERT INTO comuna VALUES (7405, 'Retiro', 74);
INSERT INTO comuna VALUES (7406, 'San Javier', 74);
INSERT INTO comuna VALUES (7407, 'Villa Alegre', 74);
INSERT INTO comuna VALUES (7408, 'Yerbas Buenas', 74);
INSERT INTO comuna VALUES (8101, 'Concepción', 81);
INSERT INTO comuna VALUES (8102, 'Coronel', 81);
INSERT INTO comuna VALUES (8103, 'Chiguayante', 81);
INSERT INTO comuna VALUES (8104, 'Florida', 81);
INSERT INTO comuna VALUES (8105, 'Hualqui', 81);
INSERT INTO comuna VALUES (8106, 'Lota', 81);
INSERT INTO comuna VALUES (8107, 'Penco', 81);
INSERT INTO comuna VALUES (8108, 'San Pedro de la Paz', 81);
INSERT INTO comuna VALUES (8109, 'Santa Juana', 81);
INSERT INTO comuna VALUES (8110, 'Talcahuano', 81);
INSERT INTO comuna VALUES (8111, 'Tomé', 81);
INSERT INTO comuna VALUES (8112, 'Hualpén', 81);
INSERT INTO comuna VALUES (8201, 'Lebu', 82);
INSERT INTO comuna VALUES (8202, 'Arauco', 82);
INSERT INTO comuna VALUES (8203, 'Cañete', 82);
INSERT INTO comuna VALUES (8204, 'Contulmo', 82);
INSERT INTO comuna VALUES (8205, 'Curanilahue', 82);
INSERT INTO comuna VALUES (8206, 'Los Álamos', 82);
INSERT INTO comuna VALUES (8207, 'Tirúa', 82);
INSERT INTO comuna VALUES (8301, 'Los Ángeles', 83);
INSERT INTO comuna VALUES (8302, 'Antuco', 83);
INSERT INTO comuna VALUES (8303, 'Cabrero', 83);
INSERT INTO comuna VALUES (8304, 'Laja', 83);
INSERT INTO comuna VALUES (8305, 'Mulchén', 83);
INSERT INTO comuna VALUES (8306, 'Nacimiento', 83);
INSERT INTO comuna VALUES (8307, 'Negrete', 83);
INSERT INTO comuna VALUES (8308, 'Quilaco', 83);
INSERT INTO comuna VALUES (8309, 'Quilleco', 83);
INSERT INTO comuna VALUES (8310, 'San Rosendo', 83);
INSERT INTO comuna VALUES (8311, 'Santa Bárbara', 83);
INSERT INTO comuna VALUES (8312, 'Tucapel', 83);
INSERT INTO comuna VALUES (8313, 'Yumbel', 83);
INSERT INTO comuna VALUES (8314, 'Alto Biobío', 83);
INSERT INTO comuna VALUES (8401, 'Chillán', 84);
INSERT INTO comuna VALUES (8402, 'Bulnes', 84);
INSERT INTO comuna VALUES (8403, 'Cobquecura', 84);
INSERT INTO comuna VALUES (8404, 'Coelemu', 84);
INSERT INTO comuna VALUES (8405, 'Coihueco', 84);
INSERT INTO comuna VALUES (8406, 'Chillán Viejo', 84);
INSERT INTO comuna VALUES (8407, 'El Carmen', 84);
INSERT INTO comuna VALUES (8408, 'Ninhue', 84);
INSERT INTO comuna VALUES (8409, 'Ñiquén', 84);
INSERT INTO comuna VALUES (8410, 'Pemuco', 84);
INSERT INTO comuna VALUES (8411, 'Pinto', 84);
INSERT INTO comuna VALUES (8412, 'Portezuelo', 84);
INSERT INTO comuna VALUES (8413, 'Quillón', 84);
INSERT INTO comuna VALUES (8414, 'Quirihue', 84);
INSERT INTO comuna VALUES (8415, 'Ránquil', 84);
INSERT INTO comuna VALUES (8416, 'San Carlos', 84);
INSERT INTO comuna VALUES (8417, 'San Fabián', 84);
INSERT INTO comuna VALUES (8418, 'San Ignacio', 84);
INSERT INTO comuna VALUES (8419, 'San Nicolás', 84);
INSERT INTO comuna VALUES (8420, 'Treguaco', 84);
INSERT INTO comuna VALUES (8421, 'Yungay', 84);
INSERT INTO comuna VALUES (9101, 'Temuco', 91);
INSERT INTO comuna VALUES (9102, 'Carahue', 91);
INSERT INTO comuna VALUES (9103, 'Cunco', 91);
INSERT INTO comuna VALUES (9104, 'Curarrehue', 91);
INSERT INTO comuna VALUES (9105, 'Freire', 91);
INSERT INTO comuna VALUES (9106, 'Galvarino', 91);
INSERT INTO comuna VALUES (9107, 'Gorbea', 91);
INSERT INTO comuna VALUES (9108, 'Lautaro', 91);
INSERT INTO comuna VALUES (9109, 'Loncoche', 91);
INSERT INTO comuna VALUES (9110, 'Melipeuco', 91);
INSERT INTO comuna VALUES (9111, 'Nueva Imperial', 91);
INSERT INTO comuna VALUES (9112, 'Padre las Casas', 91);
INSERT INTO comuna VALUES (9113, 'Perquenco', 91);
INSERT INTO comuna VALUES (9114, 'Pitrufquén', 91);
INSERT INTO comuna VALUES (9115, 'Pucón', 91);
INSERT INTO comuna VALUES (9116, 'Saavedra', 91);
INSERT INTO comuna VALUES (9117, 'Teodoro Schmidt', 91);
INSERT INTO comuna VALUES (9118, 'Toltén', 91);
INSERT INTO comuna VALUES (9119, 'Vilcún', 91);
INSERT INTO comuna VALUES (9120, 'Villarrica', 91);
INSERT INTO comuna VALUES (9121, 'Cholchol', 91);
INSERT INTO comuna VALUES (9201, 'Angol', 92);
INSERT INTO comuna VALUES (9202, 'Collipulli', 92);
INSERT INTO comuna VALUES (9203, 'Curacautín', 92);
INSERT INTO comuna VALUES (9204, 'Ercilla', 92);
INSERT INTO comuna VALUES (9205, 'Lonquimay', 92);
INSERT INTO comuna VALUES (9206, 'Los Sauces', 92);
INSERT INTO comuna VALUES (9207, 'Lumaco', 92);
INSERT INTO comuna VALUES (9208, 'Purén', 92);
INSERT INTO comuna VALUES (9209, 'Renaico', 92);
INSERT INTO comuna VALUES (9210, 'Traiguén', 92);
INSERT INTO comuna VALUES (9211, 'Victoria', 92);
INSERT INTO comuna VALUES (10101, 'Puerto Montt', 101);
INSERT INTO comuna VALUES (10102, 'Calbuco', 101);
INSERT INTO comuna VALUES (10103, 'Cochamó', 101);
INSERT INTO comuna VALUES (10104, 'Fresia', 101);
INSERT INTO comuna VALUES (10105, 'Frutillar', 101);
INSERT INTO comuna VALUES (10106, 'Los Muermos', 101);
INSERT INTO comuna VALUES (10107, 'Llanquihue', 101);
INSERT INTO comuna VALUES (10108, 'Maullín', 101);
INSERT INTO comuna VALUES (10109, 'Puerto Varas', 101);
INSERT INTO comuna VALUES (10201, 'Castro', 102);
INSERT INTO comuna VALUES (10202, 'Ancud', 102);
INSERT INTO comuna VALUES (10203, 'Chonchi', 102);
INSERT INTO comuna VALUES (10204, 'Curaco de Vélez', 102);
INSERT INTO comuna VALUES (10205, 'Dalcahue', 102);
INSERT INTO comuna VALUES (10206, 'Puqueldón', 102);
INSERT INTO comuna VALUES (10207, 'Queilén', 102);
INSERT INTO comuna VALUES (10208, 'Quellón', 102);
INSERT INTO comuna VALUES (10209, 'Quemchi', 102);
INSERT INTO comuna VALUES (10210, 'Quinchao', 102);
INSERT INTO comuna VALUES (10301, 'Osorno', 103);
INSERT INTO comuna VALUES (10302, 'Puerto Octay', 103);
INSERT INTO comuna VALUES (10303, 'Purranque', 103);
INSERT INTO comuna VALUES (10304, 'Puyehue', 103);
INSERT INTO comuna VALUES (10305, 'Río Negro', 103);
INSERT INTO comuna VALUES (10306, 'San Juan de la Costa', 103);
INSERT INTO comuna VALUES (10307, 'San Pablo', 103);
INSERT INTO comuna VALUES (10401, 'Chaitén', 104);
INSERT INTO comuna VALUES (10402, 'Futaleufú', 104);
INSERT INTO comuna VALUES (10403, 'Hualaihué', 104);
INSERT INTO comuna VALUES (10404, 'Palena', 104);
INSERT INTO comuna VALUES (11101, 'Coyhaique', 111);
INSERT INTO comuna VALUES (11102, 'Lago Verde', 111);
INSERT INTO comuna VALUES (11201, 'Aysén', 112);
INSERT INTO comuna VALUES (11202, 'Cisnes', 112);
INSERT INTO comuna VALUES (11203, 'Guaitecas', 112);
INSERT INTO comuna VALUES (11301, 'Cochrane', 113);
INSERT INTO comuna VALUES (11302, 'O''Higgins', 113);
INSERT INTO comuna VALUES (11303, 'Tortel', 113);
INSERT INTO comuna VALUES (11401, 'Chile Chico', 114);
INSERT INTO comuna VALUES (11402, 'Río Ibáñez', 114);
INSERT INTO comuna VALUES (12101, 'Punta Arenas', 121);
INSERT INTO comuna VALUES (12102, 'Laguna Blanca', 121);
INSERT INTO comuna VALUES (12103, 'Río Verde', 121);
INSERT INTO comuna VALUES (12104, 'San Gregorio', 121);
INSERT INTO comuna VALUES (12201, 'Cabo de Hornos', 122);
INSERT INTO comuna VALUES (12202, 'Antártica', 122);
INSERT INTO comuna VALUES (12301, 'Porvenir', 123);
INSERT INTO comuna VALUES (12302, 'Primavera', 123);
INSERT INTO comuna VALUES (12303, 'Timaukel', 123);
INSERT INTO comuna VALUES (12401, 'Natales', 124);
INSERT INTO comuna VALUES (12402, 'Torres del Paine', 124);
INSERT INTO comuna VALUES (13101, 'Santiago', 131);
INSERT INTO comuna VALUES (13102, 'Cerrillos', 131);
INSERT INTO comuna VALUES (13103, 'Cerro Navia', 131);
INSERT INTO comuna VALUES (13104, 'Conchalí', 131);
INSERT INTO comuna VALUES (13105, 'El Bosque', 131);
INSERT INTO comuna VALUES (13106, 'Estación Central', 131);
INSERT INTO comuna VALUES (13107, 'Huechuraba', 131);
INSERT INTO comuna VALUES (13108, 'Independencia', 131);
INSERT INTO comuna VALUES (13109, 'La Cisterna', 131);
INSERT INTO comuna VALUES (13110, 'La Florida', 131);
INSERT INTO comuna VALUES (13111, 'La Granja', 131);
INSERT INTO comuna VALUES (13112, 'La Pintana', 131);
INSERT INTO comuna VALUES (13113, 'La Reina', 131);
INSERT INTO comuna VALUES (13114, 'Las Condes', 131);
INSERT INTO comuna VALUES (13115, 'Lo Barnechea', 131);
INSERT INTO comuna VALUES (13116, 'Lo Espejo', 131);
INSERT INTO comuna VALUES (13117, 'Lo Prado', 131);
INSERT INTO comuna VALUES (13118, 'Macul', 131);
INSERT INTO comuna VALUES (13119, 'Maipú', 131);
INSERT INTO comuna VALUES (13120, 'Ñuñoa', 131);
INSERT INTO comuna VALUES (13121, 'Pedro Aguirre Cerda', 131);
INSERT INTO comuna VALUES (13122, 'Peñalolén', 131);
INSERT INTO comuna VALUES (13123, 'Providencia', 131);
INSERT INTO comuna VALUES (13124, 'Pudahuel', 131);
INSERT INTO comuna VALUES (13125, 'Quilicura', 131);
INSERT INTO comuna VALUES (13126, 'Quinta Normal', 131);
INSERT INTO comuna VALUES (13127, 'Recoleta', 131);
INSERT INTO comuna VALUES (13128, 'Renca', 131);
INSERT INTO comuna VALUES (13129, 'San Joaquín', 131);
INSERT INTO comuna VALUES (13130, 'San Miguel', 131);
INSERT INTO comuna VALUES (13131, 'San Ramón', 131);
INSERT INTO comuna VALUES (13132, 'Vitacura', 131);
INSERT INTO comuna VALUES (13201, 'Puente Alto', 132);
INSERT INTO comuna VALUES (13202, 'Pirque', 132);
INSERT INTO comuna VALUES (13203, 'San José de Maipo', 132);
INSERT INTO comuna VALUES (13301, 'Colina', 133);
INSERT INTO comuna VALUES (13302, 'Lampa', 133);
INSERT INTO comuna VALUES (13303, 'Tiltil', 133);
INSERT INTO comuna VALUES (13401, 'San Bernardo', 134);
INSERT INTO comuna VALUES (13402, 'Buin', 134);
INSERT INTO comuna VALUES (13403, 'Calera de Tango', 134);
INSERT INTO comuna VALUES (13404, 'Paine', 134);
INSERT INTO comuna VALUES (13501, 'Melipilla', 135);
INSERT INTO comuna VALUES (13502, 'Alhué', 135);
INSERT INTO comuna VALUES (13503, 'Curacaví', 135);
INSERT INTO comuna VALUES (13504, 'María Pinto', 135);
INSERT INTO comuna VALUES (13505, 'San Pedro', 135);
INSERT INTO comuna VALUES (13601, 'Talagante', 136);
INSERT INTO comuna VALUES (13602, 'El Monte', 136);
INSERT INTO comuna VALUES (13603, 'Isla de Maipo', 136);
INSERT INTO comuna VALUES (13604, 'Padre Hurtado', 136);
INSERT INTO comuna VALUES (13605, 'Peñaflor', 136);
INSERT INTO comuna VALUES (14101, 'Valdivia', 141);
INSERT INTO comuna VALUES (14102, 'Corral', 141);
INSERT INTO comuna VALUES (14103, 'Lanco', 141);
INSERT INTO comuna VALUES (14104, 'Los Lagos', 141);
INSERT INTO comuna VALUES (14105, 'Máfil', 141);
INSERT INTO comuna VALUES (14106, 'Mariquina', 141);
INSERT INTO comuna VALUES (14107, 'Paillaco', 141);
INSERT INTO comuna VALUES (14108, 'Panguipulli', 141);
INSERT INTO comuna VALUES (14201, 'La Unión', 142);
INSERT INTO comuna VALUES (14202, 'Futrono', 142);
INSERT INTO comuna VALUES (14203, 'Lago Ranco', 142);
INSERT INTO comuna VALUES (14204, 'Río Bueno', 142);
INSERT INTO comuna VALUES (15101, 'Arica', 151);
INSERT INTO comuna VALUES (15102, 'Camarones', 151);
INSERT INTO comuna VALUES (15201, 'Putre', 152);
INSERT INTO comuna VALUES (15202, 'General Lagos', 152);


--
-- Data for Name: coordinacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY coordinacion (id, anio, cantalumnosestimado, cantalumnosreal, semestre, asignatura_id, alias) FROM stdin;
\.


--
-- Data for Name: encuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY encuesta (id, anio, comentario, semestre, profesor_rut_profesor) FROM stdin;
\.


--
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY evento (idevento, rsu, codigo, comuna, cuposdepartamento, cuposinvitados, entidadreceptora, estado, fechahora, financiamiento, imagen, institucionorigen, invitadoapellido, invitadocargo, invitadocomentarios, invitadocorreo, invitadonombre, lugar, nombreproyecto, origensolicitud, proyectovinculado, publicoobjetivo, region, resumen, sala, titulo, unidadacademicamayor, unidadacademicamenor, idsubtipo_idsubtipo, idchecklist_idchecklist) FROM stdin;
\.


--
-- Data for Name: evento_asociado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY evento_asociado (id, idasociado_idasociado, idevento_idevento) FROM stdin;
\.


--
-- Data for Name: evento_expositor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY evento_expositor (id, idevento_idevento, idexpositor_idexpositor) FROM stdin;
\.


--
-- Data for Name: expositor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO expositor VALUES (1, 'Chacón', 'max.chacon@usach.cl', 'Ph. D.', 'Universidad de Santiago', 'Max', 'Chile', 'Max Chacón es formado en el Departamento de Ingeniería Eléctrica de nuestra casa de estudios, recibe el título de Ingeniero Civil Electricista el año 1984. Trabaja como ingeniero de telecomunicaciones y como académico del Departamento de Ingeniería Eléctrica de la Universidad de la Frontera en Temuco. En 1989 obtiene el grado de Magíster en Ciencias de la Ingeniería Biomédica, en la Universidad Federal de Rio de Janeiro y en 1996 el grado de Doctor en Ciencias en la misma especialidad y Universidad. Es miembro del Departamento de Ingeniería Informática de la Universidad de Santiago de Chile desde el año 1996. Las principales líneas de investigación se relacionan con minería de datos, informática médica y modelos de sistemas fisiológicos. Actualmente es Profesor Titular y lidera el grupo de investigación multidisciplinario de modelamiento fisiológico del Departamento de Ingeniería Informática.', '');
INSERT INTO expositor VALUES (2, 'Marín', 'mauricio.marin@usach.cl', 'Ph. D.', 'Universidad de Santiago', 'Mauricio', 'Chile', 'Dr. Mauricio Marín es profesor titular del Departamento de Ingeniería Informática de la Universidad de Santiago de Chile, e investigador senior en los laboratorios de Yahoo! Latinoamérica auspiciado por la Universidad de Chile. Posee un PhD. en Informática de la Universidad de Oxford, Reino Unido, un MSc en Ciencias de la Computación de la Universidad de Chile, y una Licenciatura en Ingeniería Eléctrica de la Universidad de Magallanes, Chile. Su trabajo de investigación se centra en la computación paralela y sistemas distribuidos con aplicaciones en motores de búsqueda web. Ha obtenido becas de investigación en el procesamiento de consultas en paralelo sobre las bases de datos distribuidas en espacio métrico y sobre algoritmos paralelos escalables, y en estructuras de datos para la búsqueda de texto e indexación.', '');
INSERT INTO expositor VALUES (51, 'Jara', 'jljara@usach.cl', 'Ph. D.', 'Universidad de Santiago', 'J. L.', 'Chile', 'J.L. Jara obtiene su maestría el año 1997 en la Universidad de Santiago de Chile y su PhD el año 2006 en The University of York, Inglaterra. Es miembro del Departamento de Ingeniería Informática de la Universidad de Santiago de Chile desde el año 1998. Se ha dedicado principalmente a la ingeniería informática y ciencia de la computación aplicada a la biología y medicina. Además ha tenido experiencia en la industria desarrollando aplicaciones de ventas.', '');
INSERT INTO expositor VALUES (52, 'Bonacic', 'carolina.bonacic@usach.cl', 'Ph. D.', 'Universidad de Santiago', 'Carolina', 'Chile', 'Investigadora Asociada en Departamento de Ingeniería Informática de la Universidad de Santiago de Chile. Áreas: Recuperación de Información y Computación Escalable para la Web Proyectos I+D: investigadora principal y directora alterna en proyecto FONDEF CA12I10314 “Procesamiento Masivo de Flujos de Eventos”; investigadora principal proyecto CORFO 13IDL2-18713 "Analizador Social de Correos" Autora de más 10 publicaciones internacionales indexadas en ISI, Scopus, ACM Digital Library, DBLP. http://www.informatik.uni-trier.de/~ley/pers/hd/b/Bonacic:Carolina.html', '');


--
-- Data for Name: historial; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO historial VALUES (1, 'Informe de Avance: El estado del tema cambió de ''Vigente'' a ''Prorrogado''', '08/06/2016', '5', 1);
INSERT INTO historial VALUES (2, 'Informe de Avance: El estado del tema cambió de ''Vigente'' a ''Prorrogado''', '02/07/2016', '12', 1);


--
-- Data for Name: horario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY horario (id, bloque, tipo, profesor_rut_profesor, seccion_id) FROM stdin;
\.


--
-- Data for Name: inscripcion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY inscripcion (idinscripcion, apellido, carrera, email, nombre, ocupacion, spam, idevento_idevento) FROM stdin;
\.


--
-- Data for Name: inscripcionspam; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY inscripcionspam (idinscripcion, apellido, carrera, email, evento, nombre, ocupacion, spam) FROM stdin;
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO logs VALUES (177, '2015-06-22 13:45:27.361971', 'INFO', 'managedbeans.personas.UsuarioMB', 'Se ha agregado al usuario LUIS CELEDÓN', 'nflores');
INSERT INTO logs VALUES (178, '2015-06-22 13:46:17.377767', 'INFO', 'managedbeans.personas.AlumnoMB', 'Se ha agregado el alumno MATIAS NICOLAS FLORES SALAS', 'nflores');
INSERT INTO logs VALUES (179, '2015-06-22 13:50:49.387317', 'INFO', 'managedbeans.personas.ProfesorMB', 'Se ha agregado el profesor SERGIO VELASTIN', '');
INSERT INTO logs VALUES (180, '2015-06-22 13:51:08.925283', 'INFO', 'managedbeans2.profesores.VerProfesorMB', 'El profesor SERGIO VELASTIN ha sido editado exitosamente', '');
INSERT INTO logs VALUES (181, '2015-06-22 13:54:49.772021', 'INFO', 'managedbeans.personas.ProfesorMB', 'Se ha agregado el profesor ANDRÉS RICE', '');
INSERT INTO logs VALUES (182, '2015-06-22 13:55:15.548518', 'INFO', 'managedbeans2.profesores.VerProfesorMB', 'El profesor ANDRÉS RICE ha sido editado exitosamente', '');
INSERT INTO logs VALUES (183, '2015-06-22 13:56:13.155173', 'INFO', 'managedbeans.personas.ProfesorMB', 'Se ha agregado el profesor FERNANDO RANNOU', '');
INSERT INTO logs VALUES (184, '2015-06-22 13:57:28.395332', 'INFO', 'managedbeans.personas.ProfesorMB', 'Se ha agregado el profesor ERIKA ROSAS', '');
INSERT INTO logs VALUES (185, '2015-06-22 13:58:28.156518', 'INFO', 'managedbeans.personas.ProfesorMB', 'Se ha agregado el profesor NICOLAS HIDALGO', '');
INSERT INTO logs VALUES (186, '2015-06-22 13:59:36.483696', 'INFO', 'managedbeans.personas.ProfesorMB', 'Se ha agregado el profesor CAROLINA BONACIC', 'nflores');
INSERT INTO logs VALUES (187, '2015-06-22 14:00:17.114025', 'INFO', 'managedbeans.personas.ProfesorMB', 'Se ha agregado el profesor MAX CHACÓN', 'nflores');
INSERT INTO logs VALUES (188, '2015-06-22 14:00:49.580135', 'INFO', 'managedbeans.personas.ProfesorMB', 'Se ha agregado el profesor MONICA VILLANUEVA', 'nflores');
INSERT INTO logs VALUES (189, '2015-06-22 14:01:20.359344', 'INFO', 'managedbeans.personas.ProfesorMB', 'Se ha agregado el profesor VICTOR PARADA', '');
INSERT INTO logs VALUES (190, '2015-06-22 14:02:38.450126', 'INFO', 'managedbeans.personas.ProfesorMB', 'Se ha agregado el profesor JACQUELINE KOHLER', '');
INSERT INTO logs VALUES (191, '2015-06-22 14:03:16.262585', 'INFO', 'managedbeans2.propuestas.AgregarPropuestaMB', 'La propuesta Propuesta Velastin ha sido ingresada al sistema', 'nflores');
INSERT INTO logs VALUES (192, '2015-06-22 14:04:50.832221', 'INFO', 'managedbeans2.propuestas.ComisionRevisora2MB', 'La propuesta PROPUESTA VELASTIN ha sido ingresada al sistema', '');
INSERT INTO logs VALUES (193, '2015-06-22 14:05:02.737293', 'INFO', 'managedbeans2.propuestas.ComisionRevisora2MB', 'La comision revisora de la propuesta PROPUESTA VELASTIN ha sido modificada en el sistema', '');
INSERT INTO logs VALUES (194, '2015-06-22 14:07:55.152629', 'INFO', 'managedbeans2.temas.AgregarTemaMB', 'El tema TEMA VELASTIN ha sido ingresado al sistema', '');
INSERT INTO logs VALUES (195, '2015-06-22 14:08:48.444965', 'INFO', 'managedbeans2.propuestas.VerPropuestaMB', 'La el nombre de la propuesta ha sido editada exitosamente por PROPUESTA VELASTIN', '');
INSERT INTO logs VALUES (196, '2015-06-22 14:08:52.605027', 'INFO', 'managedbeans2.propuestas.VerPropuestaMB', 'La el nombre de la propuesta ha sido editada exitosamente por PROPUESTA VELASTIN', '');
INSERT INTO logs VALUES (197, '2015-06-22 14:09:27.850848', 'INFO', 'managedbeans2.propuestas.VerPropuestaMB', 'La el nombre de la propuesta ha sido editada exitosamente por PROPUESTA VELASTIN', '');
INSERT INTO logs VALUES (198, '2015-06-22 14:09:39.344416', 'INFO', 'managedbeans2.propuestas.ComisionRevisora2MB', 'La comision revisora de la propuesta PROPUESTA VELASTIN ha sido modificada en el sistema', '');
INSERT INTO logs VALUES (199, '2015-06-22 14:09:50.063983', 'INFO', 'managedbeans2.propuestas.VerPropuestaMB', 'La el nombre de la propuesta ha sido editada exitosamente por PROPUESTA VELASTIN', '');
INSERT INTO logs VALUES (200, '2015-06-22 14:10:10.306754', 'INFO', 'managedbeans2.propuestas.VerPropuestaMB', 'La el nombre de la propuesta ha sido editada exitosamente por PROPUESTA VELASTIN', '');
INSERT INTO logs VALUES (201, '2015-06-22 14:11:23.844366', 'INFO', 'managedbeans2.temas.VerTemaMB', 'Tema TEMA VELASTIN editado exitosamente', '');
INSERT INTO logs VALUES (202, '2015-06-22 14:11:50.267013', 'INFO', 'managedbeans2.temas.BorradorFinalMB', 'El estado del tema seleccionado se modificó a Vigente con borrador final', '');
INSERT INTO logs VALUES (203, '2015-06-22 14:12:25.451032', 'INFO', 'managedbeans2.temas.ComisionCorrectora2MB', 'Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen', '');
INSERT INTO logs VALUES (204, '2015-06-23 13:56:08.318566', 'INFO', 'managedbeans2.SemestreMB', 'Se ha precerrado el semestre, borradores finales entregados luego de esta fecha pasarán a ser del próximo semestre', 'mcarcamo');
INSERT INTO logs VALUES (205, '2015-06-23 13:56:08.482022', 'INFO', 'managedbeans2.SemestreMB', 'Se ha precerrado el semestre, borradores finales entregados luego de esta fecha pasarán a ser del próximo semestre', '');
INSERT INTO logs VALUES (206, '2015-06-23 14:07:00.358191', 'INFO', 'managedbeans2.SemestreMB', 'Estados y semestre modificados, el semestre actual es: 2/2016', '');
INSERT INTO logs VALUES (207, '2015-06-23 14:09:16.129981', 'INFO', 'managedbeans2.SemestreMB', 'Se ha precerrado el semestre, borradores finales entregados luego de esta fecha pasarán a ser del próximo semestre', '');
INSERT INTO logs VALUES (208, '2015-06-23 14:09:26.417506', 'INFO', 'managedbeans2.SemestreMB', 'Estados y semestre modificados, el semestre actual es: 1/2017', '');
INSERT INTO logs VALUES (209, '2015-06-23 14:11:17.996023', 'INFO', 'managedbeans2.SemestreMB', 'Se ha precerrado el semestre, borradores finales entregados luego de esta fecha pasarán a ser del próximo semestre', '');
INSERT INTO logs VALUES (210, '2015-06-23 14:32:44.038013', 'INFO', 'managedbeans2.SemestreMB', 'Estados y semestre modificados, el semestre actual es: 2/2017', '');
INSERT INTO logs VALUES (211, '2015-06-23 14:33:27.561607', 'INFO', 'managedbeans.personas.AlumnoMB', 'Se ha agregado el alumno LUIS CELEDON', '');
INSERT INTO logs VALUES (212, '2015-06-23 14:33:38.620297', 'INFO', 'managedbeans2.alumnos.EditarAlumnoMB', 'El alumno LUIS CELEDON ha sido editado exitosamente', '');
INSERT INTO logs VALUES (213, '2015-06-23 14:33:42.09117', 'INFO', 'managedbeans2.alumnos.EditarAlumnoMB', 'El alumno LUIS CELEDON ha sido editado exitosamente', '');
INSERT INTO logs VALUES (214, '2015-06-23 14:33:50.42891', 'INFO', 'managedbeans.personas.UsuarioMB', 'Se ha editado al usuario LUIS CELEDÓN', '');
INSERT INTO logs VALUES (215, '2015-06-23 14:33:52.46349', 'INFO', 'managedbeans.personas.UsuarioMB', 'Se ha editado al usuario LUIS CELEDÓN', '');
INSERT INTO logs VALUES (216, '2015-06-23 14:37:03.116621', 'INFO', 'managedbeans2.temas.ComisionCorrectora2MB', 'La comision correctora del tema TEMA VELASTIN ha sido modificada en el sistema', '');
INSERT INTO logs VALUES (217, '2015-06-23 14:37:20.295639', 'INFO', 'managedbeans2.temas.CalificacionTema2MB', 'Promedio: 5.3166666 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado', '');
INSERT INTO logs VALUES (218, '2015-06-23 14:37:43.517499', 'INFO', 'managedbeans2.temas.CalificacionTema2MB', 'Promedio: 5.3166666 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado', '');
INSERT INTO logs VALUES (219, '2015-06-23 14:37:49.081961', 'INFO', 'managedbeans2.temas.ComisionCorrectora2MB', 'La comision correctora del tema TEMA VELASTIN ha sido modificada en el sistema', '');
INSERT INTO logs VALUES (220, '2015-06-23 14:41:58.332191', 'INFO', 'managedbeans2.propuestas.AgregarPropuestaMB', 'La propuesta propuesta ejemplo ha sido ingresada al sistema', '');
INSERT INTO logs VALUES (221, '2015-06-23 14:42:52.213702', 'INFO', 'managedbeans2.propuestas.ComisionRevisora2MB', 'La propuesta PROPUESTA EJEMPLO ha sido ingresada al sistema', '');
INSERT INTO logs VALUES (222, '2015-06-23 14:43:12.970382', 'INFO', 'managedbeans2.temas.AgregarTemaMB', 'El tema TEMA EJEMPLO ha sido ingresado al sistema', '');
INSERT INTO logs VALUES (223, '2015-06-23 14:43:22.736915', 'INFO', 'managedbeans2.temas.VerTemaMB', 'Tema TEMA EJEMPLO editado exitosamente', '');
INSERT INTO logs VALUES (224, '2015-06-23 14:43:34.782734', 'INFO', 'managedbeans2.temas.BorradorFinalMB', 'El estado del tema seleccionado se modificó a Vigente con borrador final', '');
INSERT INTO logs VALUES (225, '2015-06-23 14:43:56.096854', 'INFO', 'managedbeans2.temas.ComisionCorrectora2MB', 'Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen', '');
INSERT INTO logs VALUES (226, '2015-06-23 14:44:10.440245', 'INFO', 'managedbeans2.temas.CalificacionTema2MB', 'Promedio: 6.6 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado', '');
INSERT INTO logs VALUES (227, '2015-06-23 14:44:15.525544', 'INFO', 'managedbeans2.temas.VerTemaMB', 'Tema TEMA EJEMPLO editado exitosamente', '');
INSERT INTO logs VALUES (228, '2016-01-12 16:17:07.88939', 'INFO', 'managedbeans2.SemestreMB', 'Se ha precerrado el semestre, borradores finales entregados luego de esta fecha pasarán a ser del próximo semestre', '');
INSERT INTO logs VALUES (229, '2016-01-12 16:20:32.359042', 'INFO', 'managedbeans2.usuarios.VerUsuarioMB', 'Se ha editado al usuario PAMELA AGUIRRE', 'mcarcamo');
INSERT INTO logs VALUES (230, '2016-04-14 18:52:33.679114', 'INFO', 'managedbeans2.usuarios.VerUsuarioMB', 'Se ha editado al usuario JAIME CALGAGNO BASTIDAS', '');
INSERT INTO logs VALUES (231, '2016-04-14 19:01:49.744789', 'INFO', 'managedbeans2.usuarios.VerUsuarioMB', 'Se ha editado al usuario JAIME CALGAGNO BASTIDAS', 'mcarcamo');
INSERT INTO logs VALUES (232, '2016-04-19 19:29:03.079499', 'INFO', 'managedbeans2.temas.AgregarTemaMB', 'El tema TEMA CASO CADUCO ha sido ingresado al sistema', '');
INSERT INTO logs VALUES (233, '2016-04-19 19:40:05.136942', 'INFO', 'managedbeans2.propuestas.ComisionRevisora2MB', 'La comision revisora de la propuesta CASO RENUNCIA ha sido modificada en el sistema', '');
INSERT INTO logs VALUES (234, '2016-04-19 19:41:07.647418', 'INFO', 'managedbeans2.temas.AgregarTemaMB', 'El tema TEMA CASO RENUNCIA ha sido ingresado al sistema', '');
INSERT INTO logs VALUES (235, '2016-04-19 19:48:24.655515', 'INFO', 'managedbeans2.propuestas.ComisionRevisora2MB', 'La comision revisora de la propuesta PROPUESTA CASO PRORROGA ha sido modificada en el sistema', '');
INSERT INTO logs VALUES (236, '2016-04-19 19:48:47.667715', 'INFO', 'managedbeans2.temas.AgregarTemaMB', 'El tema TEMA CASO PRORROGA ha sido ingresado al sistema', '');
INSERT INTO logs VALUES (237, '2016-04-19 19:52:09.779172', 'INFO', 'managedbeans2.propuestas.ComisionRevisora2MB', 'La comision revisora de la propuesta PROPUESTA CASO ENTREGA BORRADOR FINAL ha sido modificada en el sistema', 'mcarcamo');
INSERT INTO logs VALUES (238, '2016-04-19 19:52:34.86588', 'INFO', 'managedbeans2.temas.AgregarTemaMB', 'El tema TEMA CASO ENTREGA BORRADOR FINAL ha sido ingresado al sistema', 'mcarcamo');
INSERT INTO logs VALUES (239, '2016-04-19 19:55:42.747001', 'INFO', 'managedbeans2.temas.AgregarTemaMB', 'El tema TEMA CASO REPRUEBA ha sido ingresado al sistema', '');
INSERT INTO logs VALUES (240, '2016-04-19 20:00:25.611567', 'INFO', 'managedbeans2.temas.AvanceYCaducarMB', 'El estado del tema seleccionado se modificó a Caduco', '');
INSERT INTO logs VALUES (241, '2016-04-19 20:00:49.744618', 'INFO', 'managedbeans2.temas.AvanceYCaducarMB', 'El estado del tema seleccionado se modificó a Caduco por renuncia', '');
INSERT INTO logs VALUES (242, '2016-04-19 20:03:29.067828', 'INFO', 'managedbeans2.propuestas.ComisionRevisora2MB', 'La comision revisora de la propuesta PROPUESTA CASO VIGENTE ha sido modificada en el sistema', '');
INSERT INTO logs VALUES (243, '2016-04-19 20:03:44.742312', 'INFO', 'managedbeans2.temas.AgregarTemaMB', 'El tema TEMA CASO VIGENTE ha sido ingresado al sistema', '');
INSERT INTO logs VALUES (244, '2016-04-19 20:04:06.551012', 'INFO', 'managedbeans2.temas.AvanceYCaducarMB', 'Tema modificado, El estado del tema TEMA CASO PRORROGA se modificó a Prorrogado', '');
INSERT INTO logs VALUES (245, '2016-04-19 20:05:05.929672', 'INFO', 'managedbeans2.temas.BorradorFinalMB', 'El estado del tema seleccionado se modificó a Vigente con borrador final', 'mcarcamo');
INSERT INTO logs VALUES (246, '2016-04-21 17:20:52.687059', 'INFO', 'managedbeans2.temas.AgregarTemaMB', 'El tema TEMA CARRERA 1863 2001.1 ha sido ingresado al sistema', '');
INSERT INTO logs VALUES (247, '2016-04-21 17:48:51.614189', 'INFO', 'managedbeans2.SemestreMB', 'Se ha precerrado el semestre, borradores finales entregados luego de esta fecha pasarán a ser del próximo semestre', '');
INSERT INTO logs VALUES (248, '2016-04-21 17:54:18.017158', 'INFO', 'managedbeans2.temas.AgregarTemaMB', 'El tema TEMA TITULADO ha sido ingresado al sistema', '');
INSERT INTO logs VALUES (249, '2016-04-21 17:54:34.407032', 'INFO', 'managedbeans2.temas.BorradorFinalMB', 'El estado del tema seleccionado se modificó a Vigente con borrador final', '');
INSERT INTO logs VALUES (250, '2016-04-21 17:55:41.064315', 'INFO', 'managedbeans2.temas.ComisionCorrectora2MB', 'Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen', '');
INSERT INTO logs VALUES (251, '2016-04-21 17:56:08.915502', 'INFO', 'managedbeans2.temas.CalificacionTema2MB', 'Promedio: 7.0 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado', 'mcarcamo');
INSERT INTO logs VALUES (252, '2016-04-21 18:08:16.318894', 'INFO', 'managedbeans2.temas.AgregarTemaMB', 'El tema TEMA PROCESO DE EXAMEN ha sido ingresado al sistema', '');
INSERT INTO logs VALUES (253, '2016-04-21 18:08:45.454862', 'INFO', 'managedbeans2.temas.BorradorFinalMB', 'El estado del tema seleccionado se modificó a Vigente con borrador final', '');
INSERT INTO logs VALUES (254, '2016-04-21 18:09:49.968361', 'INFO', 'managedbeans2.temas.ComisionCorrectora2MB', 'Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen', 'mcarcamo');
INSERT INTO logs VALUES (255, '2016-04-21 18:16:46.081322', 'INFO', 'managedbeans2.temas.AgregarTemaMB', 'El tema TEMA VIGENTE PARA PRORROGAR ha sido ingresado al sistema', '');
INSERT INTO logs VALUES (256, '2016-04-21 18:24:33.298625', 'INFO', 'managedbeans2.temas.BorradorFinalMB', 'El estado del tema seleccionado se modificó a Vigente con borrador final', 'mcarcamo');
INSERT INTO logs VALUES (257, '2016-04-21 18:25:25.99363', 'INFO', 'managedbeans2.temas.ComisionCorrectora2MB', 'Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen', '');
INSERT INTO logs VALUES (258, '2016-04-21 18:26:13.794021', 'INFO', 'managedbeans2.temas.CalificacionTema2MB', 'Promedio: 1.0 Se agregaron las notas y el estado del tema seleccionado se modificó a Reprobado', '');
INSERT INTO logs VALUES (259, '2016-04-21 18:30:54.666376', 'INFO', 'managedbeans2.SemestreMB', 'Se ha precerrado el semestre, borradores finales entregados luego de esta fecha pasarán a ser del próximo semestre', '');
INSERT INTO logs VALUES (260, '2016-04-21 18:33:09.288577', 'INFO', 'managedbeans2.temas.BorradorFinalMB', 'El estado del tema seleccionado se modificó a Vigente con borrador final', '');
INSERT INTO logs VALUES (261, '2016-04-21 18:33:42.174693', 'INFO', 'managedbeans2.temas.AvanceYCaducarMB', 'Tema modificado, El estado del tema TEMA VIGENTE PARA PRORROGAR se modificó a Prorrogado', '');
INSERT INTO logs VALUES (262, '2016-04-21 18:35:08.984168', 'INFO', 'managedbeans2.SemestreMB', 'Estados y semestre modificados, el semestre actual es: 2/2014', '');
INSERT INTO logs VALUES (263, '2016-04-21 18:39:38.344802', 'INFO', 'managedbeans2.temas.VerTemaMB', 'Tema TEMA CASO CADUCO editado en el sistema', '');
INSERT INTO logs VALUES (264, '2016-04-21 18:49:05.367524', 'INFO', 'managedbeans2.temas.CalificacionTema2MB', 'Promedio: 7.0 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado', '');
INSERT INTO logs VALUES (265, '2016-04-21 18:54:11.939901', 'INFO', 'managedbeans2.temas.ComisionCorrectora2MB', 'Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen', '');
INSERT INTO logs VALUES (266, '2016-04-21 18:54:46.495795', 'INFO', 'managedbeans2.temas.CalificacionTema2MB', 'Promedio: 7.0 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado', 'mcarcamo');
INSERT INTO logs VALUES (267, '2016-04-21 18:55:59.923863', 'INFO', 'managedbeans2.temas.ComisionCorrectora2MB', 'Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen', '');
INSERT INTO logs VALUES (268, '2016-04-21 18:56:32.781125', 'INFO', 'managedbeans2.temas.CalificacionTema2MB', 'Promedio: 4.0 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado', '');
INSERT INTO logs VALUES (269, '2016-04-21 19:00:36.157711', 'INFO', 'managedbeans2.temas.BorradorFinalMB', 'El estado del tema seleccionado se modificó a Vigente con borrador final', 'mcarcamo');
INSERT INTO logs VALUES (270, '2016-04-21 19:01:12.057817', 'INFO', 'managedbeans2.temas.ComisionCorrectora2MB', 'Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen', 'mcarcamo');
INSERT INTO logs VALUES (271, '2016-04-21 19:01:43.820282', 'INFO', 'managedbeans2.temas.CalificacionTema2MB', 'Promedio: 7.0 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado', '');
INSERT INTO logs VALUES (272, '2016-04-21 19:02:30.3678', 'INFO', 'managedbeans2.temas.BorradorFinalMB', 'El estado del tema seleccionado se modificó a Vigente con borrador final', '');
INSERT INTO logs VALUES (273, '2016-04-21 19:03:21.679571', 'INFO', 'managedbeans2.temas.ComisionCorrectora2MB', 'Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen', '');
INSERT INTO logs VALUES (274, '2016-04-21 19:03:55.7544', 'INFO', 'managedbeans2.temas.CalificacionTema2MB', 'Promedio: 7.0 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado', '');
INSERT INTO logs VALUES (275, '2016-04-26 18:04:26.527381', 'INFO', 'managedbeans2.temas.BorradorFinalMB', 'El estado del tema seleccionado se modificó a Vigente con borrador final', '');


--
-- Data for Name: paramsemestreano; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO paramsemestreano VALUES (1, 2015, 1);


--
-- Data for Name: planes_alumno; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO planes_alumno VALUES ('176767901', 3, true, 2);
INSERT INTO planes_alumno VALUES ('178608975', 1, true, 1);
INSERT INTO planes_alumno VALUES ('176785969', 1, true, 3);
INSERT INTO planes_alumno VALUES ('175657436', 3, true, 2);
INSERT INTO planes_alumno VALUES ('179043939', 3, true, 2);
INSERT INTO planes_alumno VALUES ('163601311', 3, true, 1);
INSERT INTO planes_alumno VALUES ('169410313', 3, true, 2);
INSERT INTO planes_alumno VALUES ('17490314K', 3, true, 2);
INSERT INTO planes_alumno VALUES ('173865090', 6, true, 1);
INSERT INTO planes_alumno VALUES ('164115267', 3, true, 1);
INSERT INTO planes_alumno VALUES ('158407337', 3, true, 1);
INSERT INTO planes_alumno VALUES ('158407337', 1, true, 3);
INSERT INTO planes_alumno VALUES ('156232890', 4, true, 1);
INSERT INTO planes_alumno VALUES ('161943177', 4, true, 1);
INSERT INTO planes_alumno VALUES ('136725092', 1, true, 1);


--
-- Data for Name: planestudio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO planestudio VALUES (1, 1363, 0, 1);
INSERT INTO planestudio VALUES (2, 1973, 1, 1);
INSERT INTO planestudio VALUES (3, 1863, 0, 1);
INSERT INTO planestudio VALUES (4, 1963, 0, 1);
INSERT INTO planestudio VALUES (5, 1353, 0, 2);
INSERT INTO planestudio VALUES (6, 1853, 0, 2);
INSERT INTO planestudio VALUES (7, 1953, 0, 2);
INSERT INTO planestudio VALUES (8, 1983, 1, 2);
INSERT INTO planestudio VALUES (9, 1053, 0, 1);
INSERT INTO planestudio VALUES (10, 1063, 0, 2);


--
-- Data for Name: profe_correccion; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: profe_propuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: profe_revision; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: profesor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO profesor VALUES (34, 0, NULL, 0, 1, '163601311');
INSERT INTO profesor VALUES (35, 1, NULL, 7, 0, '69476376');
INSERT INTO profesor VALUES (36, 1, NULL, 7, 0, '65776545');
INSERT INTO profesor VALUES (37, 0, NULL, 0, 1, '145010330');
INSERT INTO profesor VALUES (38, 0, NULL, 0, 1, '87365867');
INSERT INTO profesor VALUES (39, 0, NULL, 0, 1, '228947512');
INSERT INTO profesor VALUES (40, 0, NULL, 0, 1, '10478450K');
INSERT INTO profesor VALUES (41, 1, NULL, 7, 0, '80796609');
INSERT INTO profesor VALUES (42, 0, NULL, 0, 1, '138328449');
INSERT INTO profesor VALUES (43, 0, NULL, 0, 1, '90070819');
INSERT INTO profesor VALUES (44, 0, NULL, 0, 1, '80004125');
INSERT INTO profesor VALUES (45, 0, NULL, 0, 1, '156232890');
INSERT INTO profesor VALUES (46, 0, NULL, 0, 1, '70658828');
INSERT INTO profesor VALUES (47, 0, NULL, 0, 1, '136725092');
INSERT INTO profesor VALUES (48, 1, NULL, 7, 0, '71531589');
INSERT INTO profesor VALUES (49, 0, NULL, 0, 1, '106025347');
INSERT INTO profesor VALUES (50, 0, NULL, 0, 1, '144409558');
INSERT INTO profesor VALUES (51, 1, NULL, 7, 0, '95794912');
INSERT INTO profesor VALUES (52, 0, NULL, 0, 1, '100234637');
INSERT INTO profesor VALUES (53, 0, NULL, 0, 1, '72595963');
INSERT INTO profesor VALUES (54, 0, NULL, 0, 1, '83978872');
INSERT INTO profesor VALUES (55, 0, NULL, 0, 1, '156203181');
INSERT INTO profesor VALUES (56, 0, NULL, 0, 1, '130461786');


--
-- Data for Name: propuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO provincia VALUES (11, 'Iquique', 1);
INSERT INTO provincia VALUES (14, 'Tamarugal', 1);
INSERT INTO provincia VALUES (21, 'Antofagasta', 2);
INSERT INTO provincia VALUES (22, 'El Loa', 2);
INSERT INTO provincia VALUES (23, 'Tocopilla', 2);
INSERT INTO provincia VALUES (31, 'Copiapó', 3);
INSERT INTO provincia VALUES (32, 'Chañaral', 3);
INSERT INTO provincia VALUES (33, 'Huasco', 3);
INSERT INTO provincia VALUES (41, 'Elqui', 4);
INSERT INTO provincia VALUES (42, 'Choapa', 4);
INSERT INTO provincia VALUES (43, 'Limarí', 4);
INSERT INTO provincia VALUES (51, 'Valparaíso', 5);
INSERT INTO provincia VALUES (52, 'Isla de Pascua', 5);
INSERT INTO provincia VALUES (53, 'Los Andes', 5);
INSERT INTO provincia VALUES (54, 'Petorca', 5);
INSERT INTO provincia VALUES (55, 'Quillota', 5);
INSERT INTO provincia VALUES (56, 'San Antonio', 5);
INSERT INTO provincia VALUES (57, 'San Felipe de Aconcagua', 5);
INSERT INTO provincia VALUES (58, 'Marga Marga', 5);
INSERT INTO provincia VALUES (61, 'Cachapoal', 6);
INSERT INTO provincia VALUES (62, 'Cardenal Caro', 6);
INSERT INTO provincia VALUES (63, 'Colchagua', 6);
INSERT INTO provincia VALUES (71, 'Talca', 7);
INSERT INTO provincia VALUES (72, 'Cauquenes', 7);
INSERT INTO provincia VALUES (73, 'Curicó', 7);
INSERT INTO provincia VALUES (74, 'Linares', 7);
INSERT INTO provincia VALUES (81, 'Concepción', 8);
INSERT INTO provincia VALUES (82, 'Arauco', 8);
INSERT INTO provincia VALUES (83, 'Biobío', 8);
INSERT INTO provincia VALUES (84, 'Ñuble', 8);
INSERT INTO provincia VALUES (91, 'Cautín', 9);
INSERT INTO provincia VALUES (92, 'Malleco', 9);
INSERT INTO provincia VALUES (101, 'Llanquihue', 10);
INSERT INTO provincia VALUES (102, 'Chiloé', 10);
INSERT INTO provincia VALUES (103, 'Osorno', 10);
INSERT INTO provincia VALUES (104, 'Palena', 10);
INSERT INTO provincia VALUES (111, 'Coihaique', 11);
INSERT INTO provincia VALUES (112, 'Aisén', 11);
INSERT INTO provincia VALUES (113, 'Capitán Prat', 11);
INSERT INTO provincia VALUES (114, 'General Carrera', 11);
INSERT INTO provincia VALUES (121, 'Magallanes', 12);
INSERT INTO provincia VALUES (122, 'Antártica Chilena', 12);
INSERT INTO provincia VALUES (123, 'Tierra del Fuego', 12);
INSERT INTO provincia VALUES (124, 'Última Esperanza', 12);
INSERT INTO provincia VALUES (131, 'Santiago', 13);
INSERT INTO provincia VALUES (132, 'Cordillera', 13);
INSERT INTO provincia VALUES (133, 'Chacabuco', 13);
INSERT INTO provincia VALUES (134, 'Maipo', 13);
INSERT INTO provincia VALUES (135, 'Melipilla', 13);
INSERT INTO provincia VALUES (136, 'Talagante', 13);
INSERT INTO provincia VALUES (141, 'Valdivia', 14);
INSERT INTO provincia VALUES (142, 'Ranco', 14);
INSERT INTO provincia VALUES (151, 'Arica', 15);
INSERT INTO provincia VALUES (152, 'Parinacota', 15);


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO region VALUES (1, 'Tarapacá');
INSERT INTO region VALUES (2, 'Antofagasta');
INSERT INTO region VALUES (3, 'Atacama');
INSERT INTO region VALUES (4, 'Coquimbo');
INSERT INTO region VALUES (5, 'Valparaíso');
INSERT INTO region VALUES (15, 'Arica y Parinacota');
INSERT INTO region VALUES (6, 'Libertador Gral. Bernardo O’Higgins');
INSERT INTO region VALUES (7, 'Maule');
INSERT INTO region VALUES (8, 'Biobío');
INSERT INTO region VALUES (9, 'La Araucanía');
INSERT INTO region VALUES (10, 'Los Lagos');
INSERT INTO region VALUES (11, 'Aisén del Gral. Carlos Ibáñez del Campo');
INSERT INTO region VALUES (12, 'Magallanes y de la Antártica Chilena');
INSERT INTO region VALUES (13, 'Metropolitana de Santiago');
INSERT INTO region VALUES (14, 'Los Ríos');


--
-- Data for Name: seccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY seccion (id, codigo, coordinacion_id) FROM stdin;
\.


--
-- Data for Name: semestre; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO semestre VALUES ('2/2014', NULL, NULL);


--
-- Data for Name: semestre_actual; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO semestre_actual VALUES ('1/2014');


--
-- Data for Name: sequence; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sequence VALUES ('SEQ_GEN', 100);


--
-- Data for Name: subtipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO subtipo VALUES (1, 'Ajedrez', 1);
INSERT INTO subtipo VALUES (2, 'Básquetbol', 1);
INSERT INTO subtipo VALUES (3, 'Fútbol', 1);
INSERT INTO subtipo VALUES (4, 'Actividades de Inducción', 3);
INSERT INTO subtipo VALUES (5, 'Ceremonia', 3);
INSERT INTO subtipo VALUES (6, 'Charla', 3);
INSERT INTO subtipo VALUES (7, 'Tenis', 1);
INSERT INTO subtipo VALUES (8, 'Concurso', 3);
INSERT INTO subtipo VALUES (9, 'Lanzamiento de Libros', 3);
INSERT INTO subtipo VALUES (10, 'Presentación artística', 3);
INSERT INTO subtipo VALUES (11, 'Presentación Cultural', 3);
INSERT INTO subtipo VALUES (12, 'Taller', 3);
INSERT INTO subtipo VALUES (13, 'Charla', 2);
INSERT INTO subtipo VALUES (14, 'Coloquio', 2);
INSERT INTO subtipo VALUES (15, 'Congreso', 2);
INSERT INTO subtipo VALUES (16, 'Curso', 2);
INSERT INTO subtipo VALUES (17, 'Encuentro', 2);
INSERT INTO subtipo VALUES (18, 'Feria', 2);
INSERT INTO subtipo VALUES (19, 'Seminario', 2);
INSERT INTO subtipo VALUES (20, 'Taller', 2);


--
-- Data for Name: tema; Type: TABLE DATA; Schema: public; Owner: postgres
--

--
-- Data for Name: tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo (nombre_tipo) FROM stdin;
\.


--
-- Data for Name: tipoevento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipoevento VALUES (1, 'F2: Actividades Deportivas');
INSERT INTO tipoevento VALUES (2, 'F4: Actividades de Difusión científica y tecnológica');
INSERT INTO tipoevento VALUES (3, 'F3: Actividades Artísticas');


--
-- Data for Name: tipousuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipousuario VALUES (1, 'ADMINISTRADOR', 'b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b');
INSERT INTO tipousuario VALUES (3, 'SECRETARIA', 'b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b');


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO usuario VALUES ('96742975', NULL, 'JARA VALENCIA', '', 'jljara@usach.cl', 'JOSÉ LUIS', '', 'usachborde', 'jljara', NULL);
INSERT INTO usuario VALUES ('175658173', NULL, 'BENUSSI PAREDES', '', 'giovanni.benussi@usach.cl', 'GIOVANNI PAOLO', '', 'usachborde', 'gbenussi', NULL);
INSERT INTO usuario VALUES ('118403096', NULL, 'AGUIRRE GUZMÁN', '', '', 'PAMELA ANDREA', '', 'usachborde', 'paguirre', NULL);
INSERT INTO usuario VALUES ('179043939', NULL, 'ABURTO VIVIANS', '', 'DANILO@REQUIES.CL', 'DANILO DANIEL', '', NULL, 'daburto', NULL);
INSERT INTO usuario VALUES ('163601311', NULL, 'ACOSTA JURADO', '', 'CRISTOBAL.ACOSTA@USACH.CL', 'CRISTÓBAL ', '', NULL, 'cacosta', NULL);
INSERT INTO usuario VALUES ('228947512', NULL, 'ACOSTA BARBOSA', '', '', 'KARINA', '', NULL, 'kacosta', NULL);
INSERT INTO usuario VALUES ('69476376', NULL, 'ACUÑA LEIVA', '', '', 'GONZALO', '', NULL, 'gacuna', NULL);
INSERT INTO usuario VALUES ('158407337', NULL, 'ALLENDE REIHER', '', '', 'JOSÉ LUIS', '', NULL, 'jallende', NULL);
INSERT INTO usuario VALUES ('65776545', NULL, 'ANTILLANCA ESPINA', '', '', 'HÉCTOR ', '', NULL, 'hantilla', NULL);
INSERT INTO usuario VALUES ('169410313', NULL, 'ARISMENDI FERRADA', '', '', 'ANDRÉS CRISTIAN', '', NULL, 'aarismendi', NULL);
INSERT INTO usuario VALUES ('145010330', NULL, 'BADILLA HERNÁNDEZ', '', '', 'CRISTIÁN', '', NULL, 'cbadilla', NULL);
INSERT INTO usuario VALUES ('10478450K', NULL, 'CERDA NEUMANN', '', 'GCERDA@UCINF.CL', 'GERARDO ESTEBAN ', '', NULL, 'gcerda', NULL);
INSERT INTO usuario VALUES ('80796609', NULL, 'CHACÓN PACHECO', '', 'MAX.CHACON@USACH.CL', 'MAX', '', NULL, 'mchacon', NULL);
INSERT INTO usuario VALUES ('138328449', NULL, 'CHAMORRO AHUMADA', '', '', 'MARÍA CAROLINA', '', NULL, 'mchamorro', NULL);
INSERT INTO usuario VALUES ('122660133', NULL, 'MUÑOZ MORENO', '', '', 'MARGOT', '', 'usachborde', 'memunoz', NULL);
INSERT INTO usuario VALUES ('128795049', NULL, 'SILVA TRAILLANCA', '', 'ximena.silva@usach.cl', 'XIMENA SOLEDAD', '', 'usachborde', 'xsilva', NULL);
INSERT INTO usuario VALUES ('138396479', NULL, 'SILVA LUQUE', '', 'guacolda.silva@usach.cl', 'GUACOLDA DEL CARMEN', '', 'usachborde', 'gsilval', NULL);
INSERT INTO usuario VALUES ('178338889', true, 'Cárcamo', NULL, NULL, 'Miguel', NULL, 'smoothness', 'mcarcamo', 13101);
INSERT INTO usuario VALUES ('130461786', NULL, 'ZUCCAR PARRINI', '', 'IRENE.ZUCCAR@USACH.CL', 'IRENE ', '', NULL, 'izuccar', NULL);
INSERT INTO usuario VALUES ('164115267', NULL, 'VÁSQUEZ FERNÁNDEZ', '', '', 'RODRIGO DE JESÚS ', '', NULL, 'rvasquez', NULL);
INSERT INTO usuario VALUES ('156203181', NULL, 'SOTO MUÑOZ', '', '', 'LEONARDO HUMBERTO ', '', NULL, 'lhsoto', NULL);
INSERT INTO usuario VALUES ('175657436', NULL, 'FLORES SÁNCHEZ', '', '', 'VICTOR MANUEL', '', NULL, 'vflores', NULL);
INSERT INTO usuario VALUES ('17490314K', NULL, 'FUENZALIDA NAVARRETE', '', '', 'GARY IGNACIO', '', NULL, 'gfuenzalida', NULL);
INSERT INTO usuario VALUES ('173865090', NULL, 'HERNÁNDEZ SÁNCHEZ', '', '', 'MARCIAL NATALINO', '', NULL, 'mnhernandez', NULL);
INSERT INTO usuario VALUES ('156232890', NULL, 'ITURBE ARAYA', '', 'JUAN.ITURBE@USACH.CL', 'JUAN', '', NULL, 'jiturbe', NULL);
INSERT INTO usuario VALUES ('70658828', NULL, 'JERARDINO WIESENBORN', '', 'BRUNO.JERARDINO@USACH.CL', 'BRUNO ', '', NULL, 'bjerardino', NULL);
INSERT INTO usuario VALUES ('161943177', NULL, 'JIMÉNEZ FUENTES', '', '', 'FRANCIA PAZ', '', NULL, 'fjimenez', NULL);
INSERT INTO usuario VALUES ('136725092', NULL, 'KOHLER	CASASEMPERE', '', '', 'JACQUELINE', '', NULL, 'jkohler', NULL);
INSERT INTO usuario VALUES ('144409558', NULL, 'RAMÍREZ SANTIBAÑEZ', '', '', 'CONSUELO', '', NULL, 'cramirezs', NULL);
INSERT INTO usuario VALUES ('95794912', NULL, 'RANNOU FUENTES', '', '', 'FERNANDO ', '', NULL, 'frannou', NULL);
INSERT INTO usuario VALUES ('87365867', NULL, 'CALGAGNO BASTIDAS', '', '', 'JAIME', '', NULL, 'jcalgano', NULL);
INSERT INTO usuario VALUES ('90070819', NULL, 'CONTRERAS SEPÚLVEDA', '', '', 'RICARDO', '', NULL, 'rcontreras', NULL);
INSERT INTO usuario VALUES ('80004125', NULL, 'CORBINAUD PÉREZ', '', '', 'RICARDO OSVALDO', '', NULL, 'rcorbinaud', NULL);
INSERT INTO usuario VALUES ('71531589', NULL, 'MARÍN CAIHUAN', '', '', 'MAURICIO', '', NULL, 'mmarin', NULL);
INSERT INTO usuario VALUES ('106025347', NULL, 'PONCE ARIAS', '', '', 'HÉCTOR', '', NULL, 'hponce', NULL);
INSERT INTO usuario VALUES ('100234637', NULL, 'RONCATTI GUZMÁN', '', '', 'CAROLINA', '', NULL, 'croncatti', NULL);
INSERT INTO usuario VALUES ('72595963', NULL, 'RUIZ BRAND', '', '', 'MARÍA EUGENIA', '', NULL, 'mruiz', NULL);
INSERT INTO usuario VALUES ('83978872', NULL, 'SOLAR FUENTES', '', '', 'MAURICIO', '', NULL, 'msolarf', NULL);


--
-- Data for Name: usuario_tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuario_tipo (id_usuario_tipo, nombre_tipo, username) FROM stdin;
\.


--
-- Name: usuario_tipo_id_usuario_tipo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuario_tipo_id_usuario_tipo_seq', 1, false);


--
-- Data for Name: usuario_tipousuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO usuario_tipousuario VALUES ('178338889', 1);
INSERT INTO usuario_tipousuario VALUES ('96742975', 1);
INSERT INTO usuario_tipousuario VALUES ('175658173', 1);
INSERT INTO usuario_tipousuario VALUES ('118403096', 1);
INSERT INTO usuario_tipousuario VALUES ('122660133', 3);
INSERT INTO usuario_tipousuario VALUES ('128795049', 3);
INSERT INTO usuario_tipousuario VALUES ('138396479', 3);


--
-- Data for Name: usuarioevento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: versionplan; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO versionplan VALUES (18, 1980, 1, 10, 18, 2015, false, 201);
INSERT INTO versionplan VALUES (1, 2012, 3, 1, 1, 2015, false, 201);
INSERT INTO versionplan VALUES (2, 2003, 1, 2, 2, 2015, false, 201);
INSERT INTO versionplan VALUES (3, 2001, 2, 3, 3, 2015, false, 201);
INSERT INTO versionplan VALUES (4, 1990, 2, 4, 4, 2015, false, 201);
INSERT INTO versionplan VALUES (5, 2012, 3, 5, 5, 2015, false, 201);
INSERT INTO versionplan VALUES (6, 2002, 1, 6, 6, 2015, false, 201);
INSERT INTO versionplan VALUES (7, 1990, 2, 7, 7, 2015, false, 201);
INSERT INTO versionplan VALUES (8, 1990, 1, 8, 8, 2015, false, 201);
INSERT INTO versionplan VALUES (9, 2012, 1, 1, 9, 2015, false, 201);
INSERT INTO versionplan VALUES (10, 2012, 2, 1, 10, 2015, false, 201);
INSERT INTO versionplan VALUES (11, 1990, 1, 2, 11, 2015, false, 201);
INSERT INTO versionplan VALUES (12, 2001, 1, 3, 12, 2015, false, 201);
INSERT INTO versionplan VALUES (13, 1990, 1, 4, 13, 2015, false, 201);
INSERT INTO versionplan VALUES (14, 2012, 1, 5, 14, 2015, false, 201);
INSERT INTO versionplan VALUES (15, 2012, 2, 5, 15, 2015, false, 201);
INSERT INTO versionplan VALUES (16, 1990, 1, 7, 16, 2015, false, 201);
INSERT INTO versionplan VALUES (17, 1980, 1, 9, 17, 2015, false, 201);


--
-- Name: alumno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY alumno
    ADD CONSTRAINT alumno_pkey PRIMARY KEY (id_alumno);


--
-- Name: asignatura_asignatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY asignatura_asignatura
    ADD CONSTRAINT asignatura_asignatura_pkey PRIMARY KEY (asignatura_id, prerequisitos_id);


--
-- Name: asignatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY asignatura
    ADD CONSTRAINT asignatura_pkey PRIMARY KEY (id);


--
-- Name: asociado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY asociado
    ADD CONSTRAINT asociado_pkey PRIMARY KEY (idasociado);


--
-- Name: carrera_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY carrera
    ADD CONSTRAINT carrera_pkey PRIMARY KEY (id);


--
-- Name: categoriaaevento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categoriaaevento
    ADD CONSTRAINT categoriaaevento_pkey PRIMARY KEY (idcategoria);


--
-- Name: checklist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY checklist
    ADD CONSTRAINT checklist_pkey PRIMARY KEY (id);


--
-- Name: checklisteventos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY checklisteventos
    ADD CONSTRAINT checklisteventos_pkey PRIMARY KEY (idchecklist);


--
-- Name: comision_correctora_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comision_correctora
    ADD CONSTRAINT comision_correctora_pkey PRIMARY KEY (id_correctora);


--
-- Name: comision_revisora_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comision_revisora
    ADD CONSTRAINT comision_revisora_pkey PRIMARY KEY (id_revisora);


--
-- Name: comuna_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comuna
    ADD CONSTRAINT comuna_pkey PRIMARY KEY (comuna_id);


--
-- Name: coordinacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY coordinacion
    ADD CONSTRAINT coordinacion_pkey PRIMARY KEY (id);


--
-- Name: encuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY encuesta
    ADD CONSTRAINT encuesta_pkey PRIMARY KEY (id);


--
-- Name: evento_asociado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY evento_asociado
    ADD CONSTRAINT evento_asociado_pkey PRIMARY KEY (id);


--
-- Name: evento_expositor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY evento_expositor
    ADD CONSTRAINT evento_expositor_pkey PRIMARY KEY (id);


--
-- Name: evento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT evento_pkey PRIMARY KEY (idevento);


--
-- Name: expositor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY expositor
    ADD CONSTRAINT expositor_pkey PRIMARY KEY (idexpositor);


--
-- Name: historial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY historial
    ADD CONSTRAINT historial_pkey PRIMARY KEY (id_historial);


--
-- Name: horario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY horario
    ADD CONSTRAINT horario_pkey PRIMARY KEY (id);


--
-- Name: inscripcion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY inscripcion
    ADD CONSTRAINT inscripcion_pkey PRIMARY KEY (idinscripcion);


--
-- Name: inscripcionspam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY inscripcionspam
    ADD CONSTRAINT inscripcionspam_pkey PRIMARY KEY (idinscripcion);


--
-- Name: logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (logs_id);


--
-- Name: paramsemestreano_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY paramsemestreano
    ADD CONSTRAINT paramsemestreano_pkey PRIMARY KEY (id);


--
-- Name: planes_alumno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY planes_alumno
    ADD CONSTRAINT planes_alumno_pkey PRIMARY KEY (alumno_id, plan_id);


--
-- Name: planestudio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY planestudio
    ADD CONSTRAINT planestudio_pkey PRIMARY KEY (id);


--
-- Name: profe_correccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY profe_correccion
    ADD CONSTRAINT profe_correccion_pkey PRIMARY KEY (rut_profesor, id_correctora);


--
-- Name: profe_propuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY profe_propuesta
    ADD CONSTRAINT profe_propuesta_pkey PRIMARY KEY (rut_profesor, id_propuesta);


--
-- Name: profe_revision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY profe_revision
    ADD CONSTRAINT profe_revision_pkey PRIMARY KEY (rut_profesor, id_revisora);


--
-- Name: profesor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY profesor
    ADD CONSTRAINT profesor_pkey PRIMARY KEY (id_profesor);


--
-- Name: propuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY propuesta
    ADD CONSTRAINT propuesta_pkey PRIMARY KEY (id_propuesta);


--
-- Name: provincia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY provincia
    ADD CONSTRAINT provincia_pkey PRIMARY KEY (provincia_id);


--
-- Name: region_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY region
    ADD CONSTRAINT region_pkey PRIMARY KEY (region_id);


--
-- Name: seccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY seccion
    ADD CONSTRAINT seccion_pkey PRIMARY KEY (id);


--
-- Name: semestre_actual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY semestre_actual
    ADD CONSTRAINT semestre_actual_pkey PRIMARY KEY (semestre_actual);


--
-- Name: semestre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY semestre
    ADD CONSTRAINT semestre_pkey PRIMARY KEY (id_semestre);


--
-- Name: sequence_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sequence
    ADD CONSTRAINT sequence_pkey PRIMARY KEY (seq_name);


--
-- Name: subtipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY subtipo
    ADD CONSTRAINT subtipo_pkey PRIMARY KEY (idsubtipo);


--
-- Name: tema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tema
    ADD CONSTRAINT tema_pkey PRIMARY KEY (id_tema);


--
-- Name: tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo
    ADD CONSTRAINT tipo_pkey PRIMARY KEY (nombre_tipo);


--
-- Name: tipoevento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipoevento
    ADD CONSTRAINT tipoevento_pkey PRIMARY KEY (idtipoevento);


--
-- Name: tipousuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipousuario
    ADD CONSTRAINT tipousuario_pkey PRIMARY KEY (id_tipo);


--
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (rut_usuario);


--
-- Name: usuario_tipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario_tipo
    ADD CONSTRAINT usuario_tipo_pkey PRIMARY KEY (id_usuario_tipo);


--
-- Name: usuario_tipousuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario_tipousuario
    ADD CONSTRAINT usuario_tipousuario_pkey PRIMARY KEY (usuario_rut_usuario, tipos_id_tipo);


--
-- Name: usuarioevento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarioevento
    ADD CONSTRAINT usuarioevento_pkey PRIMARY KEY (id);


--
-- Name: versionplan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY versionplan
    ADD CONSTRAINT versionplan_pkey PRIMARY KEY (id);


--
-- Name: COMUNA_PROVINCIA_ID; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "COMUNA_PROVINCIA_ID" ON comuna USING btree (comuna_provincia_id);


--
-- Name: PROVINCIA_REGION_ID; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "PROVINCIA_REGION_ID" ON provincia USING btree (provincia_region_id);


--
-- Name: comision_correctora_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX comision_correctora_pk ON comision_correctora USING btree (id_correctora);


--
-- Name: comision_revisora_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX comision_revisora_pk ON comision_revisora USING btree (id_revisora);


--
-- Name: fki_comuna; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_comuna ON usuario USING btree (comuna);


--
-- Name: historial_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX historial_pk ON historial USING btree (id_historial);


--
-- Name: profe_correccion_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX profe_correccion_pk ON profe_correccion USING btree (id_correctora, rut_profesor);


--
-- Name: profe_propuesta_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX profe_propuesta_pk ON profe_propuesta USING btree (id_propuesta, rut_profesor);


--
-- Name: profe_revision_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX profe_revision_pk ON profe_revision USING btree (id_revisora, rut_profesor);


--
-- Name: propuesta_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX propuesta_pk ON propuesta USING btree (id_propuesta);


--
-- Name: relationship_13_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_13_fk ON comision_revisora USING btree (id_semestre);


--
-- Name: relationship_14_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_14_fk ON tema USING btree (id_semestre);


--
-- Name: relationship_15_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_15_fk ON comision_correctora USING btree (id_semestre);


--
-- Name: relationship_16_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_16_fk ON tema USING btree (id_correctora);


--
-- Name: relationship_17_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_17_fk ON comision_correctora USING btree (id_tema);


--
-- Name: relationship_18_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_18_fk ON propuesta USING btree (rut_alumno);


--
-- Name: relationship_19_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_19_fk ON propuesta USING btree (id_revisora);


--
-- Name: relationship_20_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_20_fk ON comision_revisora USING btree (id_propuesta);


--
-- Name: relationship_21_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_21_fk ON comision_revisora USING btree (id_tema);


--
-- Name: relationship_22_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_22_fk ON tema USING btree (id_revisora);


--
-- Name: relationship_23_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_23_fk ON profe_propuesta USING btree (id_propuesta);


--
-- Name: relationship_24_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_24_fk ON profe_propuesta USING btree (rut_profesor);


--
-- Name: relationship_25_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_25_fk ON propuesta USING btree (id_semestre);


--
-- Name: relationship_26_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_26_fk ON profe_correccion USING btree (id_correctora);


--
-- Name: relationship_27_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_27_fk ON profe_correccion USING btree (rut_profesor);


--
-- Name: relationship_2_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_2_fk ON profe_revision USING btree (id_revisora);


--
-- Name: relationship_3_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_3_fk ON profe_revision USING btree (rut_profesor);


--
-- Name: semestre_actual_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX semestre_actual_pk ON semestre_actual USING btree (semestre_actual);


--
-- Name: semestre_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX semestre_pk ON semestre USING btree (id_semestre);


--
-- Name: tema_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX tema_pk ON tema USING btree (id_tema);


--
-- Name: usuario_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX usuario_pk ON usuario USING btree (rut_usuario);


--
-- Name: comuna; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT comuna FOREIGN KEY (comuna) REFERENCES comuna(comuna_id);


--
-- Name: comuna_COMUNA_PROVINCIA_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comuna
    ADD CONSTRAINT "comuna_COMUNA_PROVINCIA_ID_fkey" FOREIGN KEY (comuna_provincia_id) REFERENCES provincia(provincia_id);


--
-- Name: fk_alumno_rut_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY alumno
    ADD CONSTRAINT fk_alumno_rut_usuario FOREIGN KEY (rut_usuario) REFERENCES usuario(rut_usuario);


--
-- Name: fk_asignatura_asignatura_asignatura_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY asignatura_asignatura
    ADD CONSTRAINT fk_asignatura_asignatura_asignatura_id FOREIGN KEY (asignatura_id) REFERENCES asignatura(id);


--
-- Name: fk_asignatura_asignatura_prerequisitos_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY asignatura_asignatura
    ADD CONSTRAINT fk_asignatura_asignatura_prerequisitos_id FOREIGN KEY (prerequisitos_id) REFERENCES asignatura(id);


--
-- Name: fk_asignatura_profesor_asignaturas_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY asignatura_profesor
    ADD CONSTRAINT fk_asignatura_profesor_asignaturas_id FOREIGN KEY (asignaturas_id) REFERENCES asignatura(id);


--
-- Name: fk_asignatura_versionplan_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY asignatura
    ADD CONSTRAINT fk_asignatura_versionplan_id FOREIGN KEY (versionplan_id) REFERENCES versionplan(id);


--
-- Name: fk_asociado_idcategoria_idcategoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY asociado
    ADD CONSTRAINT fk_asociado_idcategoria_idcategoria FOREIGN KEY (idcategoria_idcategoria) REFERENCES categoriaaevento(idcategoria);


--
-- Name: fk_checklist_asignatura_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY checklist
    ADD CONSTRAINT fk_checklist_asignatura_id FOREIGN KEY (asignatura_id) REFERENCES asignatura(id);


--
-- Name: fk_checklist_encuesta_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY checklist
    ADD CONSTRAINT fk_checklist_encuesta_id FOREIGN KEY (encuesta_id) REFERENCES encuesta(id);


--
-- Name: fk_comision_correctora_id_semestre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_correctora
    ADD CONSTRAINT fk_comision_correctora_id_semestre FOREIGN KEY (id_semestre) REFERENCES semestre(id_semestre);


--
-- Name: fk_comision_correctora_id_tema; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_correctora
    ADD CONSTRAINT fk_comision_correctora_id_tema FOREIGN KEY (id_tema) REFERENCES tema(id_tema);


--
-- Name: fk_comision_relations_propuest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_revisora
    ADD CONSTRAINT fk_comision_relations_propuest FOREIGN KEY (id_propuesta) REFERENCES propuesta(id_propuesta) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_comision_relations_semestre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_correctora
    ADD CONSTRAINT fk_comision_relations_semestre FOREIGN KEY (id_semestre) REFERENCES semestre(id_semestre) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_comision_relations_semestre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_revisora
    ADD CONSTRAINT fk_comision_relations_semestre FOREIGN KEY (id_semestre) REFERENCES semestre(id_semestre) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_comision_relations_tema; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_correctora
    ADD CONSTRAINT fk_comision_relations_tema FOREIGN KEY (id_tema) REFERENCES tema(id_tema) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_comision_relations_tema; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_revisora
    ADD CONSTRAINT fk_comision_relations_tema FOREIGN KEY (id_tema) REFERENCES tema(id_tema) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_comision_revisora_id_propuesta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_revisora
    ADD CONSTRAINT fk_comision_revisora_id_propuesta FOREIGN KEY (id_propuesta) REFERENCES propuesta(id_propuesta);


--
-- Name: fk_comision_revisora_id_semestre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_revisora
    ADD CONSTRAINT fk_comision_revisora_id_semestre FOREIGN KEY (id_semestre) REFERENCES semestre(id_semestre);


--
-- Name: fk_comision_revisora_id_tema; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comision_revisora
    ADD CONSTRAINT fk_comision_revisora_id_tema FOREIGN KEY (id_tema) REFERENCES tema(id_tema);


--
-- Name: fk_coordinacion_asignatura_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY coordinacion
    ADD CONSTRAINT fk_coordinacion_asignatura_id FOREIGN KEY (asignatura_id) REFERENCES asignatura(id);


--
-- Name: fk_evento_asociado_idasociado_idasociado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento_asociado
    ADD CONSTRAINT fk_evento_asociado_idasociado_idasociado FOREIGN KEY (idasociado_idasociado) REFERENCES asociado(idasociado);


--
-- Name: fk_evento_asociado_idevento_idevento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento_asociado
    ADD CONSTRAINT fk_evento_asociado_idevento_idevento FOREIGN KEY (idevento_idevento) REFERENCES evento(idevento);


--
-- Name: fk_evento_expositor_idevento_idevento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento_expositor
    ADD CONSTRAINT fk_evento_expositor_idevento_idevento FOREIGN KEY (idevento_idevento) REFERENCES evento(idevento);


--
-- Name: fk_evento_expositor_idexpositor_idexpositor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento_expositor
    ADD CONSTRAINT fk_evento_expositor_idexpositor_idexpositor FOREIGN KEY (idexpositor_idexpositor) REFERENCES expositor(idexpositor);


--
-- Name: fk_evento_idchecklist_idchecklist; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT fk_evento_idchecklist_idchecklist FOREIGN KEY (idchecklist_idchecklist) REFERENCES checklisteventos(idchecklist);


--
-- Name: fk_evento_idsubtipo_idsubtipo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY evento
    ADD CONSTRAINT fk_evento_idsubtipo_idsubtipo FOREIGN KEY (idsubtipo_idsubtipo) REFERENCES subtipo(idsubtipo);


--
-- Name: fk_horario_seccion_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY horario
    ADD CONSTRAINT fk_horario_seccion_id FOREIGN KEY (seccion_id) REFERENCES seccion(id);


--
-- Name: fk_inscripcion_idevento_idevento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY inscripcion
    ADD CONSTRAINT fk_inscripcion_idevento_idevento FOREIGN KEY (idevento_idevento) REFERENCES evento(idevento);


--
-- Name: fk_planes_alumno_plan_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY planes_alumno
    ADD CONSTRAINT fk_planes_alumno_plan_id FOREIGN KEY (plan_id) REFERENCES planestudio(id);


--
-- Name: fk_planestudio_carrera_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY planestudio
    ADD CONSTRAINT fk_planestudio_carrera_id FOREIGN KEY (carrera_id) REFERENCES carrera(id);


--
-- Name: fk_profe_co_relations_comision; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profe_correccion
    ADD CONSTRAINT fk_profe_co_relations_comision FOREIGN KEY (id_correctora) REFERENCES comision_correctora(id_correctora) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_profe_correccion_id_correctora; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profe_correccion
    ADD CONSTRAINT fk_profe_correccion_id_correctora FOREIGN KEY (id_correctora) REFERENCES comision_correctora(id_correctora);


--
-- Name: fk_profe_pr_relations_propuest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profe_propuesta
    ADD CONSTRAINT fk_profe_pr_relations_propuest FOREIGN KEY (id_propuesta) REFERENCES propuesta(id_propuesta) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_profe_propuesta_id_propuesta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profe_propuesta
    ADD CONSTRAINT fk_profe_propuesta_id_propuesta FOREIGN KEY (id_propuesta) REFERENCES propuesta(id_propuesta);


--
-- Name: fk_profesor_rut_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profesor
    ADD CONSTRAINT fk_profesor_rut_usuario FOREIGN KEY (rut_usuario) REFERENCES usuario(rut_usuario);


--
-- Name: fk_propuest_relations_comision; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY propuesta
    ADD CONSTRAINT fk_propuest_relations_comision FOREIGN KEY (id_revisora) REFERENCES comision_revisora(id_revisora) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_propuest_relations_semestre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY propuesta
    ADD CONSTRAINT fk_propuest_relations_semestre FOREIGN KEY (id_semestre) REFERENCES semestre(id_semestre) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_seccion_coordinacion_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY seccion
    ADD CONSTRAINT fk_seccion_coordinacion_id FOREIGN KEY (coordinacion_id) REFERENCES coordinacion(id);


--
-- Name: fk_subtipo_idtipoevento_idtipoevento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subtipo
    ADD CONSTRAINT fk_subtipo_idtipoevento_idtipoevento FOREIGN KEY (idtipoevento_idtipoevento) REFERENCES tipoevento(idtipoevento);


--
-- Name: fk_tema_id_correctora; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tema
    ADD CONSTRAINT fk_tema_id_correctora FOREIGN KEY (id_correctora) REFERENCES comision_correctora(id_correctora);


--
-- Name: fk_tema_id_revisora; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tema
    ADD CONSTRAINT fk_tema_id_revisora FOREIGN KEY (id_revisora) REFERENCES comision_revisora(id_revisora);


--
-- Name: fk_tema_id_semestre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tema
    ADD CONSTRAINT fk_tema_id_semestre FOREIGN KEY (id_semestre) REFERENCES semestre(id_semestre);


--
-- Name: fk_tema_relations_comision; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tema
    ADD CONSTRAINT fk_tema_relations_comision FOREIGN KEY (id_correctora) REFERENCES comision_correctora(id_correctora) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_tema_relations_comision2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tema
    ADD CONSTRAINT fk_tema_relations_comision2 FOREIGN KEY (id_revisora) REFERENCES comision_revisora(id_revisora) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_tema_relations_semestre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tema
    ADD CONSTRAINT fk_tema_relations_semestre FOREIGN KEY (id_semestre) REFERENCES semestre(id_semestre) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_usuario_tipousuario_tipos_id_tipo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario_tipousuario
    ADD CONSTRAINT fk_usuario_tipousuario_tipos_id_tipo FOREIGN KEY (tipos_id_tipo) REFERENCES tipousuario(id_tipo);


--
-- Name: fk_usuario_tipousuario_usuario_rut_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario_tipousuario
    ADD CONSTRAINT fk_usuario_tipousuario_usuario_rut_usuario FOREIGN KEY (usuario_rut_usuario) REFERENCES usuario(rut_usuario);


--
-- Name: fk_versionplan_planestudio_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY versionplan
    ADD CONSTRAINT fk_versionplan_planestudio_id FOREIGN KEY (planestudio_id) REFERENCES planestudio(id);


--
-- Name: planes_alumno_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY planes_alumno
    ADD CONSTRAINT planes_alumno_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES planestudio(id);


--
-- Name: provincia_PROVINCIA_REGION_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincia
    ADD CONSTRAINT "provincia_PROVINCIA_REGION_ID_fkey" FOREIGN KEY (provincia_region_id) REFERENCES region(region_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

