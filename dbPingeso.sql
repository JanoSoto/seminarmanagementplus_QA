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
    rut_alumno character varying(20) NOT NULL,
    id_plan_activo bigint
);


ALTER TABLE public.alumno OWNER TO postgres;

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
    id_semestre character varying(15) NOT NULL,
    id_tema integer NOT NULL,
    fecha_correccion character varying(15),
    fecha_entrega_correccion character varying(15),
    fecha_entrega_correccion2 character varying(15),
    fecha_correccion2 character varying(15)
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
    fecha_revision character varying(15),
    tipo_revision integer,
    id_revisora integer NOT NULL,
    id_propuesta integer NOT NULL,
    id_semestre character varying(15) NOT NULL,
    id_tema integer,
    fecha_entrega_revision character varying(15),
    fecha_revision2 character varying(15),
    fecha_entrega_revision2 character varying(15),
    fecha_publicacion_consejo character varying(15),
    fecha_termino_publicacion_consejo character varying(15)
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
    fechahora date,
    financiamiento character varying(255),
    imagen bytea,
    institucionorigen character varying(255),
    invitadoapellido character varying(255),
    invitadocargo character varying(255),
    invitadocomentarios character varying(255),
    invitadocorreo character varying(255),
    invitadonombre character varying(255),
    lugar character varying(255),
    nombreproyecto character varying(255),
    origensolicitud character varying(255),
    proyectovinculado character varying(255),
    publicoobjetivo character varying(255),
    region character varying(255),
    resumen character varying(255),
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
    resenabibliografica character varying(255),
    telefono character varying(255)
);


ALTER TABLE public.expositor OWNER TO postgres;

--
-- Name: historial; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE historial (
    descripcion character varying(200),
    fecha_historial character varying(15),
    id_entidad character varying(20),
    tipo_historial integer,
    id_historial integer NOT NULL
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
    alumno_id character varying(20),
    plan_id bigint,
    activo boolean
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
    id_correctora integer NOT NULL,
    rut_profesor character varying(20) NOT NULL,
    rol_correccion integer,
    nota_correccion_informe real,
    nota_correccion_defensa real
);


ALTER TABLE public.profe_correccion OWNER TO postgres;

--
-- Name: profe_propuesta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE profe_propuesta (
    id_propuesta integer NOT NULL,
    rut_profesor character varying(20) NOT NULL,
    rol_guia integer,
    nota_guia_informe real,
    nota_guia_defensa real,
    fecha_revision character varying(15)
);


ALTER TABLE public.profe_propuesta OWNER TO postgres;

--
-- Name: profe_revision; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE profe_revision (
    id_revisora integer NOT NULL,
    rut_profesor character varying(20) NOT NULL,
    rol_revision integer,
    fecha_revision character varying(15)
);


ALTER TABLE public.profe_revision OWNER TO postgres;

--
-- Name: profesor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE profesor (
    contrato integer,
    tipo_profesor integer,
    jerarquia_categoria integer,
    maximo_guias integer,
    rut_profesor character varying(20) NOT NULL,
    esta_seminar boolean,
    puede_guiar integer,
    puede_corregir integer,
    alias character varying(30)
);


ALTER TABLE public.profesor OWNER TO postgres;

--
-- Name: propuesta; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE propuesta (
    nombre_propuesta character varying(400),
    fecha_propuesta character varying(15),
    id_propuesta integer NOT NULL,
    id_semestre character varying(15) NOT NULL,
    id_revisora integer,
    rut_alumno character varying(20) NOT NULL,
    magister boolean,
    pet boolean
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
    id_semestre character varying(15) NOT NULL
);


ALTER TABLE public.semestre OWNER TO postgres;

--
-- Name: semestre_actual; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE semestre_actual (
    semestre_actual character varying(15) NOT NULL
);


ALTER TABLE public.semestre_actual OWNER TO postgres;

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
    nombre_tema character varying(400),
    fecha_tema character varying(15),
    estado_tema integer,
    id_tema integer NOT NULL,
    id_correctora integer,
    id_semestre character varying(15) NOT NULL,
    id_revisora integer NOT NULL,
    fecha_siac character varying(15),
    fecha_real character varying(15),
    semestre_termino character varying(15),
    precierre character varying(15),
    precerrado boolean
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
    id_tipo bigint NOT NULL,
    nombre_tipo character varying(20) NOT NULL
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
    nombre_tipo character varying(255) NOT NULL
);


ALTER TABLE public.tipousuario OWNER TO postgres;

--
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    rut_usuario character varying(20) NOT NULL,
    uid character varying(20) NOT NULL,
    nombre_usuario character varying(50),
    segundo_nombre_usuario character varying(50),
    apellido_usuario_paterno character varying(50),
    apellido_usuario_materno character varying(50),
    mail_usuario character varying(100),
    telefono_usuario character varying(20),
    direccion_usuario character varying(100),
    activo boolean
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- Name: usuario_tipo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario_tipo (
    id_tipo bigint NOT NULL,
    rut_usuario character varying(20) NOT NULL
);


ALTER TABLE public.usuario_tipo OWNER TO postgres;


--
-- Name: usuario_tipousuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario_tipousuario (
    usuario_rut_usuario character varying(255) NOT NULL,
    tipos_id_tipo bigint NOT NULL
);


ALTER TABLE public.usuario_tipousuario OWNER TO postgres;



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
    version integer,
    anio integer,
	resolucion integer,
	anio_resolucion integer,
	planificado boolean,
    planestudio_id bigint
);


ALTER TABLE public.versionplan OWNER TO postgres;

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
-- Name: id_propuesta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY propuesta ALTER COLUMN id_propuesta SET DEFAULT nextval('propuesta_id_propuesta_seq'::regclass);


--
-- Name: id_tema; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tema ALTER COLUMN id_tema SET DEFAULT nextval('tema_id_tema_seq'::regclass);


--
-- Data for Name: asociado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY asociado (idasociado, nombreasociado, idcategoria_idcategoria) FROM stdin;
\.


--
-- Data for Name: alumno; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY alumno (rut_alumno, id_plan_activo) FROM stdin;
\.


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

COPY checklisteventos (idchecklist, adm_expositor, agenda_institucional, confimacion_inscritos, cupos, diinf_medios, evento_facebook, evento_twitter, facebook, linkedin, lugar, noticia_web_diinf, publicar_calendario, publicar_web, publico_objetivo, publico_usach, radio_usach, redes_usach, twitter, url_corta) FROM stdin;
\.


--
-- Data for Name: comision_correctora; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comision_correctora (id_correctora, id_semestre, id_tema, fecha_correccion, fecha_entrega_correccion, fecha_entrega_correccion2, fecha_correccion2) FROM stdin;
\.


--
-- Name: comision_correctora_id_correctora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comision_correctora_id_correctora_seq', 242, true);


--
-- Data for Name: comision_revisora; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comision_revisora (fecha_revision, tipo_revision, id_revisora, id_propuesta, id_semestre, id_tema, fecha_entrega_revision, fecha_revision2, fecha_entrega_revision2, fecha_publicacion_consejo, fecha_termino_publicacion_consejo) FROM stdin;
\.


--
-- Name: comision_revisora_id_revisora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comision_revisora_id_revisora_seq', 606, true);


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
\.


--
-- Data for Name: historial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY historial (descripcion, fecha_historial, id_entidad, tipo_historial, id_historial) FROM stdin;
\.


--
-- Name: historial_id_historial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('historial_id_historial_seq', 31, true);


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
1	2015-05-12 18:54:29.628449	INFO	managedbeans2.temas.ComisionCorrectora2MB	Se asignó Comisión Correctora al temaQWEQWE	
2	2015-05-12 18:54:29.707257	INFO	managedbeans2.temas.ComisionCorrectora2MB	Ingresó Comisión Correctora al alumno JOAQUÍN OLIVARES DONOSO	
3	2015-05-12 18:54:30.264668	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen	
4	2015-05-12 18:56:05.897161	INFO	managedbeans2.EliminarMB	La propuesta: SDAFASD ha sido eliminada del sistema	
5	2015-05-12 18:56:23.187974	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta propuesta ha sido ingresada al sistema	
6	2015-05-12 18:56:43.644818	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta PROPUESTA ha sido ingresada al sistema	
7	2015-05-12 18:56:58.149105	INFO	managedbeans2.temas.AgregarTemaMB	El tema TEMA ASDF ha sido ingresado al sistema	
8	2015-05-12 18:59:37.521402	INFO	managedbeans2.temas.ComisionCorrectora2MB	Se asignó Comisión Correctora al temaTEMA ASDF	
9	2015-05-12 18:59:37.557771	INFO	managedbeans2.temas.ComisionCorrectora2MB	Ingresó Comisión Correctora al alumno ALFONSO HENRÍQUEZ HANDY	
10	2015-05-12 18:59:37.602292	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen	
11	2015-05-12 19:00:48.351684	INFO	managedbeans2.temas.CalificacionTema2MB	Promedio: 5.5 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado	
12	2015-05-14 19:50:47.553016	INFO	managedbeans2.EliminarMB	La comisión correctora del tema: TEMA ASDF ha sido eliminada del sistema	
13	2015-05-14 19:50:47.808869	INFO	managedbeans2.EliminarMB	El tema TEMA ASDF ha sido eliminado del sistema	
14	2015-05-14 19:50:47.920761	INFO	managedbeans2.EliminarMB	La comisión revisora de la Propuesta: PROPUESTA ha sido eliminada del sistema	
15	2015-05-14 19:50:48.163007	INFO	managedbeans2.EliminarMB	La propuesta: PROPUESTA ha sido eliminada del sistema	
16	2015-05-14 19:51:07.764369	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta prop ha sido ingresada al sistema	
17	2015-05-14 23:18:24.388187	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta PROP ha sido ingresada al sistema	
18	2015-05-14 23:21:47.537029	INFO	managedbeans2.temas.AgregarTemaMB	El tema TEMA PROP ha sido ingresado al sistema	admin
19	2015-05-14 23:55:55.425213	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta ppp ha sido ingresada al sistema	admin
20	2015-05-14 23:56:13.87458	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta PPP ha sido ingresada al sistema	
21	2015-05-14 23:58:52.418257	INFO	managedbeans2.temas.AgregarTemaMB	El tema TEMABAS ha sido ingresado al sistema	
22	2015-05-15 00:00:24.127188	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta asd ha sido ingresada al sistema	
23	2015-05-15 00:02:22.017232	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta ASD ha sido ingresada al sistema	
24	2015-05-15 01:17:34.693661	INFO	managedbeans2.temas.ComisionCorrectora2MB	Se asignó Comisión Correctora al temaTEMA PROP	
25	2015-05-15 01:17:34.848291	INFO	managedbeans2.temas.ComisionCorrectora2MB	Ingresó Comisión Correctora al alumno MANUEL ALEJANDRO ALARCON BELMAR	
26	2015-05-15 01:17:34.981159	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen	
27	2015-05-15 01:20:33.232817	INFO	managedbeans2.temas.ComisionCorrectora2MB	Se asignó Comisión Correctora al temaTEMABAS	admin
28	2015-05-15 01:20:33.299653	INFO	managedbeans2.temas.ComisionCorrectora2MB	Ingresó Comisión Correctora al alumno NAYADA HERNANDEZ OYANEDEL	admin
29	2015-05-15 01:20:33.343982	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comision Correctora: El estado del tema cambió de Vigente con borrador final a En proceso de examen	admin
30	2015-05-15 01:20:33.377505	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen	admin
31	2015-05-15 03:12:59.738292	INFO	managedbeans2.temas.CalificacionTema2MB	Promedio: 5.5 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado	
32	2015-05-15 04:34:46.417983	INFO	managedbeans2.temas.VerTemaMB	Tema SISTEMA WEW PARA AYUDAR A PADRES Y APODERADOS EN LA BUSQUEDA DE COLEGIOS USANDO UN OPEN DATE editado exitosamente	admin
33	2015-05-15 04:35:33.278156	INFO	managedbeans2.temas.VerTemaMB	Tema SISTEMA DE APOYO A LA PLANIFICACIÓN DOCENTE Y MEDICIÓN DEL ESTADO DE AVANCE DE LOS ALUMNOS EN HABILIDADES COGNITIVAS ESPECÍFICAS editado exitosamente	
34	2015-05-15 04:40:55.159584	INFO	managedbeans2.temas.VerTemaMB	Tema DESARROLLO DE API DE VALIDACIÓN MEDIANTE HUELLA DIGITAL EN TARJETAS CON CHIP editado exitosamente	
35	2015-05-15 04:41:27.769991	INFO	managedbeans2.temas.VerTemaMB	Tema DESARROLLO DE PROTOTIPO DE UNA CALCULADORA DE DOSIS PARA EL APOYO DEL ÁREA DE PEDRIATRÍA editado exitosamente	
36	2015-05-15 11:49:02.518014	INFO	managedbeans2.temas.VerTemaMB	Tema TEMABAS editado exitosamente	
37	2015-05-15 12:04:12.315606	INFO	managedbeans2.temas.AgregarTemaMB	El tema TEMA ha sido ingresado al sistema	
38	2015-05-15 12:04:55.866668	INFO	managedbeans2.temas.BorradorFinalMB	El estado del tema seleccionado se modificó a Vigente con borrador final	
39	2015-05-15 12:05:39.670803	INFO	managedbeans2.temas.ComisionCorrectora2MB	Se asignó Comisión Correctora al temaTEMA	
40	2015-05-15 12:05:39.769977	INFO	managedbeans2.temas.ComisionCorrectora2MB	Ingresó Comisión Correctora al alumno HERNANDO ANDRES MANRIQUEZ NAVARRO	
41	2015-05-15 12:05:39.803184	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comision Correctora: El estado del tema cambió de Vigente con borrador final a En proceso de examen	
42	2015-05-15 12:05:39.836466	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen	
43	2015-05-15 12:14:19.758971	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta 123 ha sido ingresada al sistema	
44	2015-05-15 12:16:32.413321	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta 123 ha sido ingresada al sistema	
45	2015-05-15 12:16:58.510399	INFO	managedbeans2.temas.AgregarTemaMB	El tema TEMA111 ha sido ingresado al sistema	
46	2015-05-15 12:20:30.880708	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta 1231212312312 ha sido ingresada al sistema	
47	2015-05-15 12:23:42.203377	INFO	managedbeans2.temas.BorradorFinalMB	El estado del tema seleccionado se modificó a Vigente con borrador final	
48	2015-05-15 18:18:13.276702	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta Propuesta prop ha sido ingresada al sistema	
49	2015-05-15 18:18:33.798935	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta PROPUESTA PROP ha sido ingresada al sistema	admin
50	2015-05-15 18:18:46.290658	INFO	managedbeans2.temas.AgregarTemaMB	El tema TEMA TM ha sido ingresado al sistema	admin
51	2015-05-15 18:19:00.815081	INFO	managedbeans2.temas.BorradorFinalMB	El estado del tema seleccionado se modificó a Vigente con borrador final	admin
52	2015-05-15 18:19:19.990306	INFO	managedbeans2.temas.ComisionCorrectora2MB	Se asignó Comisión Correctora al temaTEMA TM	
53	2015-05-15 18:19:20.043972	INFO	managedbeans2.temas.ComisionCorrectora2MB	Ingresó Comisión Correctora al alumno GONZALO SEBASTIAN ALVARADO REYES	
54	2015-05-15 18:19:20.077224	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comision Correctora: El estado del tema cambió de Vigente con borrador final a En proceso de examen	
55	2015-05-15 18:19:20.099459	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen	
56	2015-05-15 18:19:47.461375	INFO	managedbeans2.temas.CalificacionTema2MB	Promedio: 6.6 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado	admin
57	2015-05-15 18:24:55.953271	INFO	managedbeans2.temas.CalificacionTema2MB	Promedio: 6.6 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado	
58	2015-05-15 18:38:47.637165	INFO	managedbeans2.temas.CalificacionTema2MB	Promedio: 5.5 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado	admin
59	2015-05-15 19:06:08.525712	INFO	managedbeans2.temas.ComisionCorrectora2MB	Se asignó Comisión Correctora al temaTEMA111	
60	2015-05-15 19:06:08.568568	INFO	managedbeans2.temas.ComisionCorrectora2MB	Ingresó Comisión Correctora al alumno JOAQUÍN OLIVARES DONOSO	
61	2015-05-15 19:06:08.601756	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comision Correctora: El estado del tema cambió de Vigente con borrador final a En proceso de examen	
62	2015-05-15 19:06:08.63524	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen	
63	2015-05-15 19:07:53.619963	INFO	managedbeans2.temas.CalificacionTema2MB	Promedio: 5.5 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado	
64	2015-05-16 23:42:41.462987	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA DE ALBERTOX editado exitosamente	
65	2015-05-17 00:06:53.477905	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA111 editado exitosamente	admin
66	2015-05-17 00:08:29.319343	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA DE ALBERTOX editado exitosamente	admin
67	2015-05-17 00:21:33.310955	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA DE ALBERTOX editado exitosamente	
68	2015-05-17 00:35:20.930061	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA DE ALBERTOX editado exitosamente	
69	2015-05-17 00:35:52.828966	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA DE ALBERTOX editado exitosamente	
70	2015-05-17 00:36:08.962615	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA111 editado exitosamente	
71	2015-05-17 00:36:43.087736	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA111 editado exitosamente	
72	2015-05-17 01:02:27.761682	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA DE ALBERTOX editado exitosamente	
73	2015-05-17 01:14:58.467212	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA111 editado exitosamente	
74	2015-05-17 01:27:50.013705	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA DE ALBERTOX editado exitosamente	admin
75	2015-05-17 01:29:01.211823	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA DE ALBERTOX editado exitosamente	
76	2015-05-17 01:29:01.50676	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA DE ALBERTOX editado exitosamente	
77	2015-05-17 01:34:25.223955	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA111 editado exitosamente	
78	2015-05-17 01:34:30.532443	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA DE ALBERTOX editado exitosamente	
79	2015-05-17 01:37:41.071177	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA111 editado exitosamente	
80	2015-05-17 01:57:19.480508	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA DE ALBERTOX editado exitosamente	
81	2015-05-17 01:58:00.397171	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA111 editado exitosamente	
82	2015-05-17 02:01:35.292138	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA111 editado exitosamente	
83	2015-05-17 02:08:41.704525	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA111 editado exitosamente	
84	2015-05-17 02:08:46.931801	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA DE ALBERTOX editado exitosamente	
85	2015-05-17 04:21:53.876743	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA DE ALBERTOX editado exitosamente	admin
86	2015-05-17 04:21:58.298707	INFO	managedbeans2.temas.VerTemaMB	Tema TEMA111 editado exitosamente	
87	2015-05-17 17:30:21.167462	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta propuesta prop1 ha sido ingresada al sistema	
88	2015-05-17 19:17:42.992289	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta PROPUESTA PROP1 ha sido ingresada al sistema	
89	2015-05-17 19:49:37.800429	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta 1231212312312 ha sido ingresada al sistema	
90	2015-05-17 19:53:50.609194	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta prop ejemp ha sido ingresada al sistema	
91	2015-05-17 20:56:36.798003	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 1231212312312 ha sido modificada en el sistema	
92	2015-05-17 20:57:10.460245	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 1231212312312 ha sido modificada en el sistema	
93	2015-05-17 21:06:12.130102	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 1231212312312 ha sido modificada en el sistema	
94	2015-05-17 21:06:22.162396	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 1231212312312 ha sido modificada en el sistema	
95	2015-05-17 21:17:01.28423	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 1231212312312 ha sido modificada en el sistema	
96	2015-05-17 21:20:59.025403	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 1231212312312 ha sido modificada en el sistema	
97	2015-05-17 21:22:27.926114	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA PROP ha sido modificada en el sistema	admin
98	2015-05-17 21:48:02.927573	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 1231212312312 ha sido modificada en el sistema	
99	2015-05-17 21:48:13.23591	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 1231212312312 ha sido modificada en el sistema	
100	2015-05-18 00:39:06.474533	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 1231212312312 ha sido modificada en el sistema	
101	2015-05-18 00:41:26.130068	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 1231212312312 ha sido modificada en el sistema	
102	2015-05-18 01:14:49.056501	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 1231212312312 ha sido modificada en el sistema	
103	2015-05-18 13:08:56.797278	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta 123123 ha sido ingresada al sistema	
104	2015-05-18 13:09:54.983818	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta 123123 ha sido ingresada al sistema	
105	2015-05-18 13:10:33.949133	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 123123 ha sido modificada en el sistema	
106	2015-05-18 13:12:41.15412	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 123123 ha sido modificada en el sistema	
107	2015-05-18 13:12:53.448457	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 123123 ha sido modificada en el sistema	admin
108	2015-05-18 13:20:30.642611	INFO	managedbeans2.EliminarMB	La comisión revisora de la Propuesta: 123123 ha sido eliminada del sistema	
109	2015-05-18 13:20:30.73821	INFO	managedbeans2.EliminarMB	La propuesta: 123123 ha sido eliminada del sistema	
110	2015-05-18 13:23:47.988734	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta asdasdas ha sido ingresada al sistema	
111	2015-05-18 13:33:08.904256	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 1231212312312 ha sido modificada en el sistema	
112	2015-05-18 13:51:30.699942	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta asdasdsdsadsa ha sido ingresada al sistema	
113	2015-05-18 13:52:05.351324	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta ASDASDSDSADSA ha sido ingresada al sistema	
114	2015-05-18 13:52:19.552984	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta ASDASDSDSADSA ha sido modificada en el sistema	
115	2015-05-18 13:52:52.037719	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta ASDASDSDSADSA ha sido modificada en el sistema	
116	2015-05-18 13:55:32.906402	INFO	managedbeans2.temas.AgregarTemaMB	El tema ASDTEMA ha sido ingresado al sistema	
117	2015-05-18 14:23:45.558568	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta 1231212312312 ha sido modificada en el sistema	
118	2015-05-18 14:24:23.645685	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta propuesta ejemplo 2 ha sido ingresada al sistema	
119	2015-05-18 14:24:49.844692	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta PROPUESTA EJEMPLO 2 ha sido ingresada al sistema	admin
120	2015-05-18 14:27:19.89291	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
121	2015-05-18 14:27:28.103532	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
122	2015-05-18 14:27:39.506378	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
123	2015-05-18 14:34:51.811109	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
124	2015-05-18 14:39:21.356331	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
125	2015-05-18 14:45:01.30443	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
126	2015-05-18 14:46:57.95837	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
127	2015-05-18 14:49:33.995392	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
128	2015-05-18 14:55:16.343293	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
129	2015-05-18 14:55:25.314048	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
130	2015-05-18 14:56:07.882176	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
131	2015-05-18 15:01:00.184747	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
132	2015-05-18 15:02:05.277344	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
133	2015-05-18 15:06:26.950038	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	admin
134	2015-05-18 15:12:47.34072	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
135	2015-05-18 15:12:51.829329	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	admin
136	2015-05-18 15:13:54.969069	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
137	2015-05-18 15:27:36.93759	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA EJEMPLO 2 ha sido modificada en el sistema	
138	2015-05-18 15:43:53.70457	INFO	managedbeans2.temas.AgregarTemaMB	El tema TEMA EJEMPLO 2 ha sido ingresado al sistema	
139	2015-05-18 15:44:15.333593	INFO	managedbeans2.temas.BorradorFinalMB	El estado del tema seleccionado se modificó a Vigente con borrador final	
140	2015-05-18 16:33:09.656136	INFO	managedbeans2.temas.ComisionCorrectora2MB	Se asignó Comisión Correctora al temaTEMA EJEMPLO 2	
141	2015-05-18 16:33:09.773584	INFO	managedbeans2.temas.ComisionCorrectora2MB	Ingresó Comisión Correctora al alumno SEBASTIAN ROSENDE PINO	
142	2015-05-18 16:33:09.806807	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comision Correctora: El estado del tema cambió de Vigente con borrador final a En proceso de examen	
143	2015-05-18 16:33:09.840123	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen	
144	2015-05-18 17:48:23.692235	INFO	managedbeans2.temas.ComisionCorrectora2MB	La comision correctora del tema TEMA EJEMPLO 2 ha sido modificada en el sistema	
145	2015-05-18 17:49:56.790496	INFO	managedbeans2.temas.ComisionCorrectora2MB	La comision correctora del tema TEMA EJEMPLO 2 ha sido modificada en el sistema	admin
146	2015-05-18 18:01:41.17838	INFO	managedbeans2.temas.ComisionCorrectora2MB	La comision correctora del tema TEMA EJEMPLO 2 ha sido modificada en el sistema	
147	2015-05-18 18:02:13.270456	INFO	managedbeans2.temas.CalificacionTema2MB	Promedio: 5.5 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado	
148	2015-05-18 18:26:57.29835	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta propuesta con jose luis ha sido ingresada al sistema	admin
149	2015-05-18 18:27:54.563068	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta PROPUESTA CON JOSE LUIS ha sido ingresada al sistema	admin
150	2015-05-18 18:28:19.727264	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA CON JOSE LUIS ha sido modificada en el sistema	admin
151	2015-05-18 18:28:54.655155	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA CON JOSE LUIS ha sido modificada en el sistema	admin
152	2015-05-18 18:30:39.004794	INFO	managedbeans2.temas.AgregarTemaMB	El tema TEMA JOSE LUIS ha sido ingresado al sistema	
153	2015-05-18 18:33:21.65781	INFO	managedbeans2.temas.BorradorFinalMB	El estado del tema seleccionado se modificó a Vigente con borrador final	admin
154	2015-05-18 18:33:49.137428	INFO	managedbeans2.temas.ComisionCorrectora2MB	Se asignó Comisión Correctora al temaTEMA JOSE LUIS	
155	2015-05-18 18:33:49.170071	INFO	managedbeans2.temas.ComisionCorrectora2MB	Ingresó Comisión Correctora al alumno HERNANDO ANDRES MANRIQUEZ NAVARRO	
156	2015-05-18 18:33:49.203333	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comision Correctora: El estado del tema cambió de Vigente con borrador final a En proceso de examen	
157	2015-05-18 18:33:49.22526	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen	
158	2015-05-18 18:34:30.01113	INFO	managedbeans2.temas.ComisionCorrectora2MB	La comision correctora del tema TEMA JOSE LUIS ha sido modificada en el sistema	admin
159	2015-05-18 18:34:50.029026	INFO	managedbeans2.temas.ComisionCorrectora2MB	La comision correctora del tema TEMA JOSE LUIS ha sido modificada en el sistema	
160	2015-05-18 18:40:07.743962	INFO	managedbeans2.profesores.VerProfesorMB	El profesor BRUNO JERARDINO ha sido editado exitosamente	admin
161	2015-05-18 18:44:20.212629	INFO	managedbeans2.temas.CalificacionTema2MB	Promedio: 5.5 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado	
162	2015-05-18 18:52:32.571339	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta propuesta asd ha sido ingresada al sistema	admin
163	2015-05-18 18:53:49.499699	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta PROPUESTA ASD ha sido ingresada al sistema	admin
164	2015-05-18 19:08:39.112539	INFO	managedbeans2.EliminarMB	La comisión correctora del tema TEMA JOSE LUIS ha sido eliminada del sistema	admin
165	2015-05-18 19:08:39.16736	INFO	managedbeans2.EliminarMB	El tema TEMA JOSE LUIS ha sido eliminado del sistema	admin
166	2015-05-18 23:56:10.523296	INFO	managedbeans2.temas.ComisionCorrectora2MB	La comision correctora del tema DISEÑO DE UN SISTEMA QUE PERMITA LA CREACIÓN DE APLICACIONES EDUCATIVAS ha sido modificada en el sistema	
167	2015-05-18 23:56:36.213072	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA ASD ha sido modificada en el sistema	
168	2015-05-19 00:02:41.803012	INFO	managedbeans2.temas.ComisionCorrectora2MB	La comision correctora del tema DISEÑO DE UN SISTEMA QUE PERMITA LA CREACIÓN DE APLICACIONES EDUCATIVAS ha sido modificada en el sistema	
169	2015-05-19 00:03:26.617531	INFO	managedbeans2.temas.ComisionCorrectora2MB	La comision correctora del tema QWEQWE ha sido modificada en el sistema	
170	2015-05-19 00:03:50.756892	INFO	managedbeans2.temas.CalificacionTema2MB	Promedio: 5.5 Se agregaron las notas y el estado del tema seleccionado se modificó a Titulado	
171	2015-05-19 00:04:02.565502	INFO	managedbeans2.temas.VerTemaMB	Tema QWEQWE editado exitosamente	SECRE
172	2015-05-19 00:05:00.665309	INFO	managedbeans2.temas.VerTemaMB	Tema SISTEMA WEB DE APOYO A LA GESTIÓN DE UNA ORGANIZACIÓN COMUNITARIA editado exitosamente	SECRE
173	2015-05-19 00:05:41.88585	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPUESTA ASD ha sido modificada en el sistema	
174	2015-05-19 00:06:12.713682	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta propp ha sido ingresada al sistema	
175	2015-05-19 00:06:30.86327	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta PROPP ha sido ingresada al sistema	
176	2015-05-19 00:06:44.021884	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La comision revisora de la propuesta PROPP ha sido modificada en el sistema	
\.


--
-- Name: logs_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('logs_logs_id_seq', 176, true);


--
-- Data for Name: paramsemestreano; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY paramsemestreano (id, anoactual, semestreactual) FROM stdin;
1	2015	1
\.


--
-- Data for Name: planes_alumno; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY planes_alumno (alumno_id, plan_id, activo) FROM stdin;
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

COPY profe_correccion (id_correctora, rut_profesor, rol_correccion, nota_correccion_informe, nota_correccion_defensa) FROM stdin;
\.


--
-- Data for Name: profe_propuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY profe_propuesta (id_propuesta, rut_profesor, rol_guia, nota_guia_informe, nota_guia_defensa, fecha_revision) FROM stdin;
\.


--
-- Data for Name: profe_revision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY profe_revision (id_revisora, rut_profesor, rol_revision, fecha_revision) FROM stdin;
\.


--
-- Data for Name: profesor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY profesor (contrato, tipo_profesor, jerarquia_categoria, maximo_guias, rut_profesor, esta_seminar, puede_guiar, puede_corregir, alias) FROM stdin;
\.


--
-- Data for Name: propuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY propuesta (nombre_propuesta, fecha_propuesta, id_propuesta, id_semestre, id_revisora, rut_alumno, magister, pet) FROM stdin;
\.


--
-- Name: propuesta_id_propuesta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('propuesta_id_propuesta_seq', 616, true);


--
-- Data for Name: seccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY seccion (id, codigo, coordinacion_id) FROM stdin;
\.


--
-- Data for Name: semestre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY semestre (id_semestre) FROM stdin;
default
1/2015
1/1990
2/2015
2/2014
1/2011
2/2012
2/2013
1/2012
1/2010
1/2016
2/2011
\.


--
-- Data for Name: semestre_actual; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY semestre_actual (semestre_actual) FROM stdin;
1/2016
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

COPY tema (nombre_tema, fecha_tema, estado_tema, id_tema, id_correctora, id_semestre, id_revisora, fecha_siac, fecha_real, semestre_termino, precierre, precerrado) FROM stdin;
\.


--
-- Name: tema_id_tema_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tema_id_tema_seq', 599, true);


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

COPY tipousuario (nombre_tipo) FROM stdin;
ADMINISTRADOR
COORDINADOR DOCENTE
PROFESOR
SECRETARIA
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuario (rut_usuario, uid, nombre_usuario, segundo_nombre_usuario, apellido_usuario_paterno, apellido_usuario_materno, mail_usuario, telefono_usuario, direccion_usuario, activo) FROM stdin;
\.


--
-- Data for Name: versionplan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY versionplan (id, version, anio, resolucion, anio_resolucion, planificado, planestudio_id) FROM stdin;
1	3	2012	1632	2014	t	1
2	1	2003	2476	2003	t	2
3	2	2001	2389	2001	t	3
4	2	1990	998	1990	t	4
5	3	2012	1638	2014	t	5
6	1	2002	2989	2001	t	6
7	2	1990	6129	2000	t	7
8	1	1990	192	1992	t	8
11	1	1990	1662	1993	f	2
12	1	2001	2389	2001	f	3
13	1	1990	6129	2000	f	4
14	1	2012	8558	2011	f	5
9	1	2012	8552	2011	f	1
10	2	2012	8552	2011	f	1
15	2	2012	8558	2011	f	5
16	1	1990	998	1990	f	7
17	1	1980	2324	1983	f	9
18	1	1980	2324	1983	f	10
\.

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
-- Name: pk_alumno; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY alumno
    ADD CONSTRAINT pk_alumno PRIMARY KEY (rut_alumno);


--
-- Name: pk_comision_correctora; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comision_correctora
    ADD CONSTRAINT pk_comision_correctora PRIMARY KEY (id_correctora);


--
-- Name: pk_comision_revisora; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comision_revisora
    ADD CONSTRAINT pk_comision_revisora PRIMARY KEY (id_revisora);


--
-- Name: pk_historial; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY historial
    ADD CONSTRAINT pk_historial PRIMARY KEY (id_historial);


--
-- Name: pk_profe_correccion; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY profe_correccion
    ADD CONSTRAINT pk_profe_correccion PRIMARY KEY (id_correctora, rut_profesor);


--
-- Name: pk_profe_propuesta; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY profe_propuesta
    ADD CONSTRAINT pk_profe_propuesta PRIMARY KEY (id_propuesta, rut_profesor);


--
-- Name: pk_profe_revision; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY profe_revision
    ADD CONSTRAINT pk_profe_revision PRIMARY KEY (id_revisora, rut_profesor);


--
-- Name: pk_profesor; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY profesor
    ADD CONSTRAINT pk_profesor PRIMARY KEY (rut_profesor);


--
-- Name: pk_propuesta; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY propuesta
    ADD CONSTRAINT pk_propuesta PRIMARY KEY (id_propuesta);


--
-- Name: pk_semestre; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY semestre
    ADD CONSTRAINT pk_semestre PRIMARY KEY (id_semestre);


--
-- Name: pk_semestre_actual; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY semestre_actual
    ADD CONSTRAINT pk_semestre_actual PRIMARY KEY (semestre_actual);


--
-- Name: pk_tema; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tema
    ADD CONSTRAINT pk_tema PRIMARY KEY (id_tema);


--
-- Name: pk_tipo; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo
    ADD CONSTRAINT pk_tipo PRIMARY KEY (id_tipo);


--
-- Name: pk_usuario; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT pk_usuario PRIMARY KEY (rut_usuario);


--
-- Name: pk_usuario_tipo; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuario_tipo
    ADD CONSTRAINT pk_usuario_tipo PRIMARY KEY (rut_usuario,id_tipo);


--
-- Name: planestudio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY planestudio
    ADD CONSTRAINT planestudio_pkey PRIMARY KEY (id);


--
-- Name: seccion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY seccion
    ADD CONSTRAINT seccion_pkey PRIMARY KEY (id);


--
-- Name: subtipo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY subtipo
    ADD CONSTRAINT subtipo_pkey PRIMARY KEY (idsubtipo);


--
-- Name: tipoevento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipoevento
    ADD CONSTRAINT tipoevento_pkey PRIMARY KEY (idtipoevento);


--
-- Name: tipousuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipousuario
    ADD CONSTRAINT tipousuario_pkey PRIMARY KEY (nombre_tipo);


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
-- Name: alumno_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX alumno_pk ON alumno USING btree (rut_alumno);


--
-- Name: comision_correctora_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX comision_correctora_pk ON comision_correctora USING btree (id_correctora);


--
-- Name: comision_revisora_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX comision_revisora_pk ON comision_revisora USING btree (id_revisora);


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
-- Name: profesor_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX profesor_pk ON profesor USING btree (rut_profesor);


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
-- Name: relationship_28_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_28_fk ON usuario_tipo USING btree (rut_usuario);


--
-- Name: relationship_29_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX relationship_29_fk ON usuario_tipo USING btree (id_tipo);


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
-- Name: tipo_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX tipo_pk ON tipo USING btree (id_tipo);


--
-- Name: usuario_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX usuario_pk ON usuario USING btree (rut_usuario);


--
-- Name: usuario_tipo_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX usuario_tipo_pk ON usuario_tipo USING btree (rut_usuario, id_tipo);


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
-- Name: fk_asignatura_profesor_profesores_rut_profesor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY asignatura_profesor
    ADD CONSTRAINT fk_asignatura_profesor_profesores_rut_profesor FOREIGN KEY (profesores_rut_profesor) REFERENCES profesor(rut_profesor);


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
-- Name: fk_coordinacion_asignatura_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY coordinacion
    ADD CONSTRAINT fk_coordinacion_asignatura_id FOREIGN KEY (asignatura_id) REFERENCES asignatura(id);


--
-- Name: fk_encuesta_rut_profesor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY encuesta
    ADD CONSTRAINT fk_encuesta_rut_profesor FOREIGN KEY (profesor_rut_profesor) REFERENCES profesor(rut_profesor);


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
-- Name: fk_horario_rut_profesor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY horario
    ADD CONSTRAINT fk_horario_rut_profesor FOREIGN KEY (profesor_rut_profesor) REFERENCES profesor(rut_profesor);


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
-- Name: fk_profe_co_relations_profesor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profe_correccion
    ADD CONSTRAINT fk_profe_co_relations_profesor FOREIGN KEY (rut_profesor) REFERENCES profesor(rut_profesor) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_profe_pr_relations_profesor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profe_propuesta
    ADD CONSTRAINT fk_profe_pr_relations_profesor FOREIGN KEY (rut_profesor) REFERENCES profesor(rut_profesor) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_profe_pr_relations_propuest; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profe_propuesta
    ADD CONSTRAINT fk_profe_pr_relations_propuest FOREIGN KEY (id_propuesta) REFERENCES propuesta(id_propuesta) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_profe_re_relations_comision; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profe_revision
    ADD CONSTRAINT fk_profe_re_relations_comision FOREIGN KEY (id_revisora) REFERENCES comision_revisora(id_revisora) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_profe_re_relations_profesor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY profe_revision
    ADD CONSTRAINT fk_profe_re_relations_profesor FOREIGN KEY (rut_profesor) REFERENCES profesor(rut_profesor) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_propuest_relations_alumno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY propuesta
    ADD CONSTRAINT fk_propuest_relations_alumno FOREIGN KEY (rut_alumno) REFERENCES alumno(rut_alumno) ON UPDATE RESTRICT ON DELETE RESTRICT;


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
-- Name: fk_versionplan_planestudio_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY versionplan
    ADD CONSTRAINT fk_versionplan_planestudio_id FOREIGN KEY (planestudio_id) REFERENCES planestudio(id);


--
-- Name: planes_alumno_alumno_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY planes_alumno
    ADD CONSTRAINT planes_alumno_alumno_id_fkey FOREIGN KEY (alumno_id) REFERENCES alumno(rut_alumno);


--
-- Name: planes_alumno_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY planes_alumno
    ADD CONSTRAINT planes_alumno_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES planestudio(id);


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

