--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alumno_id_alumno_seq OWNER TO postgres;

--
-- Name: alumno_id_alumno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE alumno_id_alumno_seq OWNED BY alumno.id_alumno;


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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comision_correctora_id_correctora_seq OWNER TO postgres;

--
-- Name: comision_correctora_id_correctora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comision_correctora_id_correctora_seq OWNED BY comision_correctora.id_correctora;


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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comision_revisora_id_revisora_seq OWNER TO postgres;

--
-- Name: comision_revisora_id_revisora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comision_revisora_id_revisora_seq OWNED BY comision_revisora.id_revisora;


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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.historial_id_historial_seq OWNER TO postgres;

--
-- Name: historial_id_historial_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE historial_id_historial_seq OWNED BY historial.id_historial;


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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logs_logs_id_seq OWNER TO postgres;

--
-- Name: logs_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE logs_logs_id_seq OWNED BY logs.logs_id;


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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profesor_id_profesor_seq OWNER TO postgres;

--
-- Name: profesor_id_profesor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE profesor_id_profesor_seq OWNED BY profesor.id_profesor;


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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.propuesta_id_propuesta_seq OWNER TO postgres;

--
-- Name: propuesta_id_propuesta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE propuesta_id_propuesta_seq OWNED BY propuesta.id_propuesta;


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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_tipo_id_usuario_tipo_seq OWNER TO postgres;

--
-- Name: usuario_tipo_id_usuario_tipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuario_tipo_id_usuario_tipo_seq OWNED BY usuario_tipo.id_usuario_tipo;


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
 SELECT u.uid,
    t.nombre_tipo,
    t.pass
   FROM usuario u,
    usuario_tipousuario ut,
    tipousuario t
  WHERE (((u.rut_usuario)::text = (ut.usuario_rut_usuario)::text) AND (ut.tipos_id_tipo = t.id_tipo));


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

COPY alumno (id_alumno, id_plan_activo, version_plan_activo, rut_usuario) FROM stdin;
1	3	2	176767901
2	1	1	178608975
9	\N	\N	70629054
16	\N	\N	170493125
\.


--
-- Name: alumno_id_alumno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('alumno_id_alumno_seq', 16, true);


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

COPY asociado (idasociado, nombreasociado, idcategoria_idcategoria) FROM stdin;
1	HÉCTOR ANTILLANCA ESPINA	1
2	GONZALO ACUÑA LEIVA	1
3	MAX CHACÓN PACHECO	1
4	FERNANDO CONTRERAS BOTTO	1
5	ROBERTO GONZALÉZ IBÁÑEZ 	1
6	NICOLÁS HIDALGO CASTILLO	1
7	MARIO INOSTROZA PONTA	1
8	JL JARA 	1
9	ERIKA ROSAS OLIVOS 	1
10	EDMUNDO LEIVA LOBOS	1
11	MAURICIO MARÍN CAIHUÁN 	1
12	ROSA MUÑOZ CALANCHIE	1
13	VÍCTOR PARADA DAZA	1
14	FERNANDO RANNOU FUENTES	1
15	MÓNICA VILLANUEVA ILUFI	1
16	CAROLINA BONACIC CASTRO	1
17	SERGIO A. VELASTIN	1
18	CEII 	3
19	GNU USACH 	3
20	CITIAPS	5
21	EQUIFAX	2
\.


--
-- Data for Name: carrera; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY carrera (id, nombre) FROM stdin;
1	INGENIERÍA CIVIL EN INFORMÁTICA
2	INGENIERÍA  DE EJECUCIÓN EN COMPUTACIÓN E INFORMÁTICA
\.


--
-- Data for Name: categoriaaevento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categoriaaevento (idcategoria, nombrecategoria) FROM stdin;
1	Académico Jornada Completa
2	Empresa
3	Grupo de Interes
4	Egresado
5	Unidad Universitaria
\.


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

COPY comision_correctora (id_correctora, fecha_correccion, fecha_correccion2, fecha_entrega_correccion, fecha_entrega_correccion2, id_semestre, id_tema) FROM stdin;
\.


--
-- Name: comision_correctora_id_correctora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comision_correctora_id_correctora_seq', 2, true);


--
-- Data for Name: comision_revisora; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comision_revisora (id_revisora, fecha_entrega_revision, fecha_entrega_revision2, fecha_publicacion_consejo, fecha_revision, fecha_revision2, fecha_termino_publicacion_consejo, tipo_revision, id_propuesta, id_semestre, id_tema) FROM stdin;
\.


--
-- Name: comision_revisora_id_revisora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comision_revisora_id_revisora_seq', 2, true);


--
-- Data for Name: comuna; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comuna (comuna_id, comuna_nombre, comuna_provincia_id) FROM stdin;
1101	Iquique	11
1107	Alto Hospicio	11
1401	Pozo Almonte	14
1402	Camiña	14
1403	Colchane	14
1404	Huara	14
1405	Pica	14
2101	Antofagasta	21
2102	Mejillones	21
2103	Sierra Gorda	21
2104	Taltal	21
2201	Calama	22
2202	Ollagüe	22
2203	San Pedro de Atacama	22
2301	Tocopilla	23
2302	María Elena	23
3101	Copiapó	31
3102	Caldera	31
3103	Tierra Amarilla	31
3201	Chañaral	32
3202	Diego de Almagro	32
3301	Vallenar	33
3302	Alto del Carmen	33
3303	Freirina	33
3304	Huasco	33
4101	La Serena	41
4102	Coquimbo	41
4103	Andacollo	41
4104	La Higuera	41
4105	Paihuano	41
4106	Vicuña	41
4201	Illapel	42
4202	Canela	42
4203	Los Vilos	42
4204	Salamanca	42
4301	Ovalle	43
4302	Combarbalá	43
4303	Monte Patria	43
4304	Punitaqui	43
4305	Río Hurtado	43
5101	Valparaíso	51
5102	Casablanca	51
5103	Concón	51
5104	Juan Fernández	51
5105	Puchuncaví	51
5107	Quintero	51
5109	Viña del Mar	51
5201	Isla de Pascua	52
5301	Los Andes	53
5302	Calle Larga	53
5303	Rinconada	53
5304	San Esteban	53
5401	La Ligua	54
5402	Cabildo	54
5403	Papudo	54
5404	Petorca	54
5405	Zapallar	54
5501	Quillota	55
5502	La Calera	55
5503	Hijuelas	55
5504	La Cruz	55
5506	Nogales	55
5601	San Antonio	56
5602	Algarrobo	56
5603	Cartagena	56
5604	El Quisco	56
5605	El Tabo	56
5606	Santo Domingo	56
5701	San Felipe	57
5702	Catemu	57
5703	Llay Llay	57
5704	Panquehue	57
5705	Putaendo	57
5706	Santa María	57
5801	Quilpué	58
5802	Limache	58
5803	Olmué	58
5804	Villa Alemana	58
6101	Rancagua	61
6102	Codegua	61
6103	Coinco	61
6104	Coltauco	61
6105	Doñihue	61
6106	Graneros	61
6107	Las Cabras	61
6108	Machalí	61
6109	Malloa	61
6110	Mostazal	61
6111	Olivar	61
6112	Peumo	61
6113	Pichidegua	61
6114	Quinta de Tilcoco	61
6115	Rengo	61
6116	Requínoa	61
6117	San Vicente	61
6201	Pichilemu	62
6202	La Estrella	62
6203	Litueche	62
6204	Marchihue	62
6205	Navidad	62
6206	Paredones	62
6301	San Fernando	63
6302	Chépica	63
6303	Chimbarongo	63
6304	Lolol	63
6305	Nancagua	63
6306	Palmilla	63
6307	Peralillo	63
6308	Placilla	63
6309	Pumanque	63
6310	Santa Cruz	63
7101	Talca	71
7102	Constitución	71
7103	Curepto	71
7104	Empedrado	71
7105	Maule	71
7106	Pelarco	71
7107	Pencahue	71
7108	Río Claro	71
7109	San Clemente	71
7110	San Rafael	71
7201	Cauquenes	72
7202	Chanco	72
7203	Pelluhue	72
7301	Curicó	73
7302	Hualañé	73
7303	Licantén	73
7304	Molina	73
7305	Rauco	73
7306	Romeral	73
7307	Sagrada Familia	73
7308	Teno	73
7309	Vichuquén	73
7401	Linares	74
7402	Colbún	74
7403	Longaví	74
7404	Parral	74
7405	Retiro	74
7406	San Javier	74
7407	Villa Alegre	74
7408	Yerbas Buenas	74
8101	Concepción	81
8102	Coronel	81
8103	Chiguayante	81
8104	Florida	81
8105	Hualqui	81
8106	Lota	81
8107	Penco	81
8108	San Pedro de la Paz	81
8109	Santa Juana	81
8110	Talcahuano	81
8111	Tomé	81
8112	Hualpén	81
8201	Lebu	82
8202	Arauco	82
8203	Cañete	82
8204	Contulmo	82
8205	Curanilahue	82
8206	Los Álamos	82
8207	Tirúa	82
8301	Los Ángeles	83
8302	Antuco	83
8303	Cabrero	83
8304	Laja	83
8305	Mulchén	83
8306	Nacimiento	83
8307	Negrete	83
8308	Quilaco	83
8309	Quilleco	83
8310	San Rosendo	83
8311	Santa Bárbara	83
8312	Tucapel	83
8313	Yumbel	83
8314	Alto Biobío	83
8401	Chillán	84
8402	Bulnes	84
8403	Cobquecura	84
8404	Coelemu	84
8405	Coihueco	84
8406	Chillán Viejo	84
8407	El Carmen	84
8408	Ninhue	84
8409	Ñiquén	84
8410	Pemuco	84
8411	Pinto	84
8412	Portezuelo	84
8413	Quillón	84
8414	Quirihue	84
8415	Ránquil	84
8416	San Carlos	84
8417	San Fabián	84
8418	San Ignacio	84
8419	San Nicolás	84
8420	Treguaco	84
8421	Yungay	84
9101	Temuco	91
9102	Carahue	91
9103	Cunco	91
9104	Curarrehue	91
9105	Freire	91
9106	Galvarino	91
9107	Gorbea	91
9108	Lautaro	91
9109	Loncoche	91
9110	Melipeuco	91
9111	Nueva Imperial	91
9112	Padre las Casas	91
9113	Perquenco	91
9114	Pitrufquén	91
9115	Pucón	91
9116	Saavedra	91
9117	Teodoro Schmidt	91
9118	Toltén	91
9119	Vilcún	91
9120	Villarrica	91
9121	Cholchol	91
9201	Angol	92
9202	Collipulli	92
9203	Curacautín	92
9204	Ercilla	92
9205	Lonquimay	92
9206	Los Sauces	92
9207	Lumaco	92
9208	Purén	92
9209	Renaico	92
9210	Traiguén	92
9211	Victoria	92
10101	Puerto Montt	101
10102	Calbuco	101
10103	Cochamó	101
10104	Fresia	101
10105	Frutillar	101
10106	Los Muermos	101
10107	Llanquihue	101
10108	Maullín	101
10109	Puerto Varas	101
10201	Castro	102
10202	Ancud	102
10203	Chonchi	102
10204	Curaco de Vélez	102
10205	Dalcahue	102
10206	Puqueldón	102
10207	Queilén	102
10208	Quellón	102
10209	Quemchi	102
10210	Quinchao	102
10301	Osorno	103
10302	Puerto Octay	103
10303	Purranque	103
10304	Puyehue	103
10305	Río Negro	103
10306	San Juan de la Costa	103
10307	San Pablo	103
10401	Chaitén	104
10402	Futaleufú	104
10403	Hualaihué	104
10404	Palena	104
11101	Coyhaique	111
11102	Lago Verde	111
11201	Aysén	112
11202	Cisnes	112
11203	Guaitecas	112
11301	Cochrane	113
11302	O'Higgins	113
11303	Tortel	113
11401	Chile Chico	114
11402	Río Ibáñez	114
12101	Punta Arenas	121
12102	Laguna Blanca	121
12103	Río Verde	121
12104	San Gregorio	121
12201	Cabo de Hornos	122
12202	Antártica	122
12301	Porvenir	123
12302	Primavera	123
12303	Timaukel	123
12401	Natales	124
12402	Torres del Paine	124
13101	Santiago	131
13102	Cerrillos	131
13103	Cerro Navia	131
13104	Conchalí	131
13105	El Bosque	131
13106	Estación Central	131
13107	Huechuraba	131
13108	Independencia	131
13109	La Cisterna	131
13110	La Florida	131
13111	La Granja	131
13112	La Pintana	131
13113	La Reina	131
13114	Las Condes	131
13115	Lo Barnechea	131
13116	Lo Espejo	131
13117	Lo Prado	131
13118	Macul	131
13119	Maipú	131
13120	Ñuñoa	131
13121	Pedro Aguirre Cerda	131
13122	Peñalolén	131
13123	Providencia	131
13124	Pudahuel	131
13125	Quilicura	131
13126	Quinta Normal	131
13127	Recoleta	131
13128	Renca	131
13129	San Joaquín	131
13130	San Miguel	131
13131	San Ramón	131
13132	Vitacura	131
13201	Puente Alto	132
13202	Pirque	132
13203	San José de Maipo	132
13301	Colina	133
13302	Lampa	133
13303	Tiltil	133
13401	San Bernardo	134
13402	Buin	134
13403	Calera de Tango	134
13404	Paine	134
13501	Melipilla	135
13502	Alhué	135
13503	Curacaví	135
13504	María Pinto	135
13505	San Pedro	135
13601	Talagante	136
13602	El Monte	136
13603	Isla de Maipo	136
13604	Padre Hurtado	136
13605	Peñaflor	136
14101	Valdivia	141
14102	Corral	141
14103	Lanco	141
14104	Los Lagos	141
14105	Máfil	141
14106	Mariquina	141
14107	Paillaco	141
14108	Panguipulli	141
14201	La Unión	142
14202	Futrono	142
14203	Lago Ranco	142
14204	Río Bueno	142
15101	Arica	151
15102	Camarones	151
15201	Putre	152
15202	General Lagos	152
\.


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

COPY expositor (idexpositor, apellido, correo, grado, institucionorigen, nombre, pais, resenabibliografica, telefono) FROM stdin;
1	Chacón	max.chacon@usach.cl	Ph. D.	Universidad de Santiago	Max	Chile	Max Chacón es formado en el Departamento de Ingeniería Eléctrica de nuestra casa de estudios, recibe el título de Ingeniero Civil Electricista el año 1984. Trabaja como ingeniero de telecomunicaciones y como académico del Departamento de Ingeniería Eléctrica de la Universidad de la Frontera en Temuco. En 1989 obtiene el grado de Magíster en Ciencias de la Ingeniería Biomédica, en la Universidad Federal de Rio de Janeiro y en 1996 el grado de Doctor en Ciencias en la misma especialidad y Universidad. Es miembro del Departamento de Ingeniería Informática de la Universidad de Santiago de Chile desde el año 1996. Las principales líneas de investigación se relacionan con minería de datos, informática médica y modelos de sistemas fisiológicos. Actualmente es Profesor Titular y lidera el grupo de investigación multidisciplinario de modelamiento fisiológico del Departamento de Ingeniería Informática.	
2	Marín	mauricio.marin@usach.cl	Ph. D.	Universidad de Santiago	Mauricio	Chile	Dr. Mauricio Marín es profesor titular del Departamento de Ingeniería Informática de la Universidad de Santiago de Chile, e investigador senior en los laboratorios de Yahoo! Latinoamérica auspiciado por la Universidad de Chile. Posee un PhD. en Informática de la Universidad de Oxford, Reino Unido, un MSc en Ciencias de la Computación de la Universidad de Chile, y una Licenciatura en Ingeniería Eléctrica de la Universidad de Magallanes, Chile. Su trabajo de investigación se centra en la computación paralela y sistemas distribuidos con aplicaciones en motores de búsqueda web. Ha obtenido becas de investigación en el procesamiento de consultas en paralelo sobre las bases de datos distribuidas en espacio métrico y sobre algoritmos paralelos escalables, y en estructuras de datos para la búsqueda de texto e indexación.	
51	Jara	jljara@usach.cl	Ph. D.	Universidad de Santiago	J. L.	Chile	J.L. Jara obtiene su maestría el año 1997 en la Universidad de Santiago de Chile y su PhD el año 2006 en The University of York, Inglaterra. Es miembro del Departamento de Ingeniería Informática de la Universidad de Santiago de Chile desde el año 1998. Se ha dedicado principalmente a la ingeniería informática y ciencia de la computación aplicada a la biología y medicina. Además ha tenido experiencia en la industria desarrollando aplicaciones de ventas.	
52	Bonacic	carolina.bonacic@usach.cl	Ph. D.	Universidad de Santiago	Carolina	Chile	Investigadora Asociada en Departamento de Ingeniería Informática de la Universidad de Santiago de Chile. Áreas: Recuperación de Información y Computación Escalable para la Web Proyectos I+D: investigadora principal y directora alterna en proyecto FONDEF CA12I10314 “Procesamiento Masivo de Flujos de Eventos”; investigadora principal proyecto CORFO 13IDL2-18713 "Analizador Social de Correos" Autora de más 10 publicaciones internacionales indexadas en ISI, Scopus, ACM Digital Library, DBLP. http://www.informatik.uni-trier.de/~ley/pers/hd/b/Bonacic:Carolina.html	
\.


--
-- Data for Name: historial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY historial (id_historial, descripcion, fecha_historial, id_entidad, tipo_historial) FROM stdin;
\.


--
-- Name: historial_id_historial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('historial_id_historial_seq', 1, false);


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

COPY logs (logs_id, dated, level, logger, message, user_id) FROM stdin;
177	2015-06-22 13:45:27.361971	INFO	managedbeans.personas.UsuarioMB	Se ha agregado al usuario LUIS CELEDÓN	nflores
178	2015-06-22 13:46:17.377767	INFO	managedbeans.personas.AlumnoMB	Se ha agregado el alumno MATIAS NICOLAS FLORES SALAS	nflores
179	2015-06-22 13:50:49.387317	INFO	managedbeans.personas.ProfesorMB	Se ha agregado el profesor SERGIO VELASTIN	
180	2015-06-22 13:51:08.925283	INFO	managedbeans2.profesores.VerProfesorMB	El profesor SERGIO VELASTIN ha sido editado exitosamente	
181	2015-06-22 13:54:49.772021	INFO	managedbeans.personas.ProfesorMB	Se ha agregado el profesor ANDRÉS RICE	
182	2015-06-22 13:55:15.548518	INFO	managedbeans2.profesores.VerProfesorMB	El profesor ANDRÉS RICE ha sido editado exitosamente	
183	2015-06-22 13:56:13.155173	INFO	managedbeans.personas.ProfesorMB	Se ha agregado el profesor FERNANDO RANNOU	
184	2015-06-22 13:57:28.395332	INFO	managedbeans.personas.ProfesorMB	Se ha agregado el profesor ERIKA ROSAS	
185	2015-06-22 13:58:28.156518	INFO	managedbeans.personas.ProfesorMB	Se ha agregado el profesor NICOLAS HIDALGO	
186	2015-06-22 13:59:36.483696	INFO	managedbeans.personas.ProfesorMB	Se ha agregado el profesor CAROLINA BONACIC	nflores
187	2015-06-22 14:00:17.114025	INFO	managedbeans.personas.ProfesorMB	Se ha agregado el profesor MAX CHACÓN	nflores
188	2015-06-22 14:00:49.580135	INFO	managedbeans.personas.ProfesorMB	Se ha agregado el profesor MONICA VILLANUEVA	nflores
189	2015-06-22 14:01:20.359344	INFO	managedbeans.personas.ProfesorMB	Se ha agregado el profesor VICTOR PARADA	
190	2015-06-22 14:02:38.450126	INFO	managedbeans.personas.ProfesorMB	Se ha agregado el profesor JACQUELINE KOHLER	
191	2015-06-22 14:03:16.262585	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta Propuesta Velastin ha sido ingresada al sistema	nflores
192	2015-06-22 14:04:50.832221	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta PROPUESTA VELASTIN ha sido ingresada al sistema	
193	2015-06-22 14:05:02.737293	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA VELASTIN ha sido modificada en el sistema	
194	2015-06-22 14:07:55.152629	INFO	managedbeans2.temas.AgregarTemaMB	El tema TEMA VELASTIN ha sido ingresado al sistema	
195	2015-06-22 14:08:48.444965	INFO	managedbeans2.propuestas.VerPropuestaMB	La el nombre de la propuesta ha sido editada exitosamente por PROPUESTA VELASTIN	
196	2015-06-22 14:08:52.605027	INFO	managedbeans2.propuestas.VerPropuestaMB	La el nombre de la propuesta ha sido editada exitosamente por PROPUESTA VELASTIN	
197	2015-06-22 14:09:27.850848	INFO	managedbeans2.propuestas.VerPropuestaMB	La el nombre de la propuesta ha sido editada exitosamente por PROPUESTA VELASTIN	
198	2015-06-22 14:09:39.344416	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA VELASTIN ha sido modificada en el sistema	
199	2015-06-22 14:09:50.063983	INFO	managedbeans2.propuestas.VerPropuestaMB	La el nombre de la propuesta ha sido editada exitosamente por PROPUESTA VELASTIN	
200	2015-06-22 14:10:10.306754	INFO	managedbeans2.propuestas.VerPropuestaMB	La el nombre de la propuesta ha sido editada exitosamente por PROPUESTA VELASTIN	
201	2015-06-22 14:11:23.844366	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA VELASTIN editado exitosamente	
202	2015-06-22 14:11:50.267013	INFO	managedbeans2.temas.BorradorFinalMB	El estado del tema seleccionado se modificó a Vigente con borrador final	
203	2015-06-22 14:12:25.451032	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen	
204	2015-06-23 13:56:08.318566	INFO	managedbeans2.SemestreMB	Se ha precerrado el semestre, borradores finales entregados luego de esta fecha pasarán a ser del próximo semestre	mcarcamo
205	2015-06-23 13:56:08.482022	INFO	managedbeans2.SemestreMB	Se ha precerrado el semestre, borradores finales entregados luego de esta fecha pasarán a ser del próximo semestre	
206	2015-06-23 14:07:00.358191	INFO	managedbeans2.SemestreMB	Estados y semestre modificados, el semestre actual es: 2/2016	
207	2015-06-23 14:09:16.129981	INFO	managedbeans2.SemestreMB	Se ha precerrado el semestre, borradores finales entregados luego de esta fecha pasarán a ser del próximo semestre	
208	2015-06-23 14:09:26.417506	INFO	managedbeans2.SemestreMB	Estados y semestre modificados, el semestre actual es: 1/2017	
209	2015-06-23 14:11:17.996023	INFO	managedbeans2.SemestreMB	Se ha precerrado el semestre, borradores finales entregados luego de esta fecha pasarán a ser del próximo semestre	
210	2015-06-23 14:32:44.038013	INFO	managedbeans2.SemestreMB	Estados y semestre modificados, el semestre actual es: 2/2017	
211	2015-06-23 14:33:27.561607	INFO	managedbeans.personas.AlumnoMB	Se ha agregado el alumno LUIS CELEDON	
212	2015-06-23 14:33:38.620297	INFO	managedbeans2.alumnos.EditarAlumnoMB	El alumno LUIS CELEDON ha sido editado exitosamente	
213	2015-06-23 14:33:42.09117	INFO	managedbeans2.alumnos.EditarAlumnoMB	El alumno LUIS CELEDON ha sido editado exitosamente	
214	2015-06-23 14:33:50.42891	INFO	managedbeans.personas.UsuarioMB	Se ha editado al usuario LUIS CELEDÓN	
215	2015-06-23 14:33:52.46349	INFO	managedbeans.personas.UsuarioMB	Se ha editado al usuario LUIS CELEDÓN	
216	2015-06-23 14:37:03.116621	INFO	managedbeans2.temas.ComisionCorrectora2MB	La comision correctora del tema TEMA VELASTIN ha sido modificada en el sistema	
217	2015-06-23 14:37:20.295639	INFO	managedbeans2.temas.CalificacionTema2MB	Promedio: 5.3166666 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado	
218	2015-06-23 14:37:43.517499	INFO	managedbeans2.temas.CalificacionTema2MB	Promedio: 5.3166666 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado	
219	2015-06-23 14:37:49.081961	INFO	managedbeans2.temas.ComisionCorrectora2MB	La comision correctora del tema TEMA VELASTIN ha sido modificada en el sistema	
220	2015-06-23 14:41:58.332191	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta propuesta ejemplo ha sido ingresada al sistema	
221	2015-06-23 14:42:52.213702	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta PROPUESTA EJEMPLO ha sido ingresada al sistema	
222	2015-06-23 14:43:12.970382	INFO	managedbeans2.temas.AgregarTemaMB	El tema TEMA EJEMPLO ha sido ingresado al sistema	
223	2015-06-23 14:43:22.736915	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA EJEMPLO editado exitosamente	
224	2015-06-23 14:43:34.782734	INFO	managedbeans2.temas.BorradorFinalMB	El estado del tema seleccionado se modificó a Vigente con borrador final	
225	2015-06-23 14:43:56.096854	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen	
226	2015-06-23 14:44:10.440245	INFO	managedbeans2.temas.CalificacionTema2MB	Promedio: 6.6 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado	
227	2015-06-23 14:44:15.525544	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA EJEMPLO editado exitosamente	
\.


--
-- Name: logs_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('logs_logs_id_seq', 227, true);


--
-- Data for Name: paramsemestreano; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY paramsemestreano (id, anoactual, semestreactual) FROM stdin;
1	2015	1
\.


--
-- Data for Name: planes_alumno; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY planes_alumno (alumno_id, plan_id, activo, version_plan) FROM stdin;
176767901	3	t	2
178608975	1	t	1
176785969	1	t	3
\.


--
-- Data for Name: planestudio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY planestudio (id, codigo, jornada, carrera_id) FROM stdin;
1	1363	0	1
2	1973	1	1
3	1863	0	1
4	1963	0	1
5	1353	0	2
6	1853	0	2
7	1953	0	2
8	1983	1	2
9	1053	0	1
10	1063	0	2
\.


--
-- Data for Name: profe_correccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY profe_correccion (nota_correccion_defensa, nota_correccion_informe, rol_correccion, rut_profesor, id_correctora) FROM stdin;
\.


--
-- Data for Name: profe_propuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY profe_propuesta (fecha_revision, nota_guia_defensa, nota_guia_informe, rol_guia, rut_profesor, id_propuesta) FROM stdin;
\.


--
-- Data for Name: profe_revision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY profe_revision (fecha_revision, rol_revision, rut_profesor, id_revisora) FROM stdin;
\N	0	95794912	1
\N	1	155898712	1
\N	0	155898712	2
\N	1	80796609	2
\.


--
-- Data for Name: profesor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY profesor (id_profesor, contrato, jerarquia_categoria, maximo_guias, tipo_profesor, rut_usuario) FROM stdin;
3	1	ASOCIADO	7	0	178338889
9	0	TITULAR	0	1	178608975
10	1	ASOCIADO	7	0	181181486
13	1	TITULAR	7	0	70629054
16	1	ASISTENTE	7	0	120188615
18	0	AYUD. PROF.	0	1	170493125
\.


--
-- Name: profesor_id_profesor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('profesor_id_profesor_seq', 18, true);


--
-- Data for Name: propuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY propuesta (id_propuesta, fecha_propuesta, id_plan, magister, nombre_propuesta, pet, version_plan, id_revisora, id_semestre, rut_alumno) FROM stdin;
\.


--
-- Name: propuesta_id_propuesta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('propuesta_id_propuesta_seq', 1, false);


--
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY provincia (provincia_id, provincia_nombre, provincia_region_id) FROM stdin;
11	Iquique	1
14	Tamarugal	1
21	Antofagasta	2
22	El Loa	2
23	Tocopilla	2
31	Copiapó	3
32	Chañaral	3
33	Huasco	3
41	Elqui	4
42	Choapa	4
43	Limarí	4
51	Valparaíso	5
52	Isla de Pascua	5
53	Los Andes	5
54	Petorca	5
55	Quillota	5
56	San Antonio	5
57	San Felipe de Aconcagua	5
58	Marga Marga	5
61	Cachapoal	6
62	Cardenal Caro	6
63	Colchagua	6
71	Talca	7
72	Cauquenes	7
73	Curicó	7
74	Linares	7
81	Concepción	8
82	Arauco	8
83	Biobío	8
84	Ñuble	8
91	Cautín	9
92	Malleco	9
101	Llanquihue	10
102	Chiloé	10
103	Osorno	10
104	Palena	10
111	Coihaique	11
112	Aisén	11
113	Capitán Prat	11
114	General Carrera	11
121	Magallanes	12
122	Antártica Chilena	12
123	Tierra del Fuego	12
124	Última Esperanza	12
131	Santiago	13
132	Cordillera	13
133	Chacabuco	13
134	Maipo	13
135	Melipilla	13
136	Talagante	13
141	Valdivia	14
142	Ranco	14
151	Arica	15
152	Parinacota	15
\.


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY region (region_id, region_nombre) FROM stdin;
1	Tarapacá
2	Antofagasta
3	Atacama
4	Coquimbo
5	Valparaíso
15	Arica y Parinacota
6	Libertador Gral. Bernardo O’Higgins
7	Maule
8	Biobío
9	La Araucanía
10	Los Lagos
11	Aisén del Gral. Carlos Ibáñez del Campo
12	Magallanes y de la Antártica Chilena
13	Metropolitana de Santiago
14	Los Ríos
\.


--
-- Data for Name: seccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY seccion (id, codigo, coordinacion_id) FROM stdin;
\.


--
-- Data for Name: semestre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY semestre (id_semestre, fecha_cierre, fecha_precierre) FROM stdin;
default	\N	\N
1/2015	\N	\N
1/1990	\N	\N
2/2015	\N	\N
2/2014	\N	\N
1/2011	\N	\N
2/2012	\N	\N
2/2013	\N	\N
1/2012	\N	\N
1/2010	\N	\N
2/2011	\N	\N
1/2016	30/06/2015	26/06/2015
2/2016	30/06/2015	30/06/2015
2/2017	\N	\N
1/2017	30/06/2015	30/06/2015
\.


--
-- Data for Name: semestre_actual; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY semestre_actual (semestre_actual) FROM stdin;
2/2017
\.


--
-- Data for Name: sequence; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sequence (seq_name, seq_count) FROM stdin;
SEQ_GEN	100
\.


--
-- Data for Name: subtipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY subtipo (idsubtipo, nombresubtipo, idtipoevento_idtipoevento) FROM stdin;
1	Ajedrez	1
2	Básquetbol	1
3	Fútbol	1
4	Actividades de Inducción	3
5	Ceremonia	3
6	Charla	3
7	Tenis	1
8	Concurso	3
9	Lanzamiento de Libros	3
10	Presentación artística	3
11	Presentación Cultural	3
12	Taller	3
13	Charla	2
14	Coloquio	2
15	Congreso	2
16	Curso	2
17	Encuentro	2
18	Feria	2
19	Seminario	2
20	Taller	2
\.


--
-- Data for Name: tema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tema (id_tema, estado_tema, fecha_borrador, fecha_caducado, fecha_informe_avance, fecha_real, fecha_renuncia, fecha_siac, fecha_tema, nombre_tema, precerrado, semestre_termino, id_correctora, id_revisora, id_semestre) FROM stdin;
\.


--
-- Name: tema_id_tema_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tema_id_tema_seq', 2, true);


--
-- Data for Name: tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo (nombre_tipo) FROM stdin;
\.


--
-- Data for Name: tipoevento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipoevento (idtipoevento, nombretipo) FROM stdin;
1	F2: Actividades Deportivas
2	F4: Actividades de Difusión científica y tecnológica
3	F3: Actividades Artísticas
\.


--
-- Data for Name: tipousuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipousuario (id_tipo, nombre_tipo, pass) FROM stdin;
1	ADMINISTRADOR	b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b
2	PROFESOR	b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b
3	SECRETARIA	b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b
4	COORDINADOR_OKEVENT	b5bea41b6c623f7c09f1bf24dcae58ebab3c0cdd90ad966bc43a45b44867e12b
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuario (rut_usuario, activo, apellido_usuario, direccion_usuario, mail_usuario, nombre_usuario, telefono_usuario, tema_usuario, uid, comuna) FROM stdin;
181181486	\N	PEREZ	\N		CARLOS	\N	afterwork	cperezr	13101
170493125	\N	AREJULA			NATALIA	\N	\N	narejula	15102
118403096	t	Aguirre	\N	\N	Pamela	\N	\N	paguirre	13101
120188615	\N	BONACIC	\N	\N	CAROLINA	\N	\N	cbonacic	13101
176767901	t	FLORES	\N	\N	MATIAS	\N	\N	nflores	13101
178338889	t	Cárcamo	\N	\N	Miguel	\N	\N	mcarcamo	13101
178608975	t	CELEDÓN	\N		LUIS	32165487	\N	lceledon	13101
179594404	t	Ruiz-Tagle	\N	\N	Benjamin	\N	\N	bruiztagle	13101
70629054	\N	VELASTÍN			SERGIO 		\N	svelastin	13101
\.


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

COPY usuario_tipousuario (usuario_rut_usuario, tipos_id_tipo) FROM stdin;
178338889	1
176767901	1
179594404	4
118403096	4
178608975	1
178608975	3
181181486	1
181181486	3
181181486	2
\.


--
-- Data for Name: usuarioevento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuarioevento (id, clave, nombre, rol) FROM stdin;
\.


--
-- Data for Name: versionplan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY versionplan (id, anio, version, planestudio_id, resolucion, anio_resolucion, planificado, correlativo) FROM stdin;
18	1980	1	10	18	2015	f	201
1	2012	3	1	1	2015	f	201
2	2003	1	2	2	2015	f	201
3	2001	2	3	3	2015	f	201
4	1990	2	4	4	2015	f	201
5	2012	3	5	5	2015	f	201
6	2002	1	6	6	2015	f	201
7	1990	2	7	7	2015	f	201
8	1990	1	8	8	2015	f	201
9	2012	1	1	9	2015	f	201
10	2012	2	1	10	2015	f	201
11	1990	1	2	11	2015	f	201
12	2001	1	3	12	2015	f	201
13	1990	1	4	13	2015	f	201
14	2012	1	5	14	2015	f	201
15	2012	2	5	15	2015	f	201
16	1990	1	7	16	2015	f	201
17	1980	1	9	17	2015	f	201
\.


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

