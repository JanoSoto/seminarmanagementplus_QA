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
    nombre_alumno character varying(50),
    apellido_alumno character varying(50),
    mail_alumno character varying(100),
    telefono_alumno character varying(20),
    rut_alumno character varying(20) NOT NULL,
    direccion_alumno character varying(100),
    id_plan_activo bigint,
    version_plan_activo integer
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
    calendario boolean,
    confimacion_inscritos boolean,
    cupos boolean,
    evento_facebook boolean,
    evento_twitter boolean,
    expositor boolean,
    facebook boolean,
    fecha boolean,
    fotos_evento boolean,
    invitacion_internos boolean,
    linkedin boolean,
    lugar boolean,
    noticia_web_diinf boolean,
    pagina boolean,
    redactar_noticia boolean,
    registrar_otros_medios boolean,
    resena boolean,
    spam_objetivo boolean,
    spam_usach boolean,
    titulo boolean,
    twitter boolean,
    web boolean
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
    email character varying(255),
    nombre character varying(255),
    spam boolean,
    idevento_idevento bigint
);


ALTER TABLE public.inscripcion OWNER TO postgres;

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
    nombre_profesor character varying(50),
    apellido_profesor character varying(50),
    mail_profesor character varying(100),
    telefono_profesor character varying(20),
    tipo_profesor integer,
    maximo_guias integer,
    rut_profesor character varying(20) NOT NULL,
    alias character varying(30),
    jerarquia_categoria character varying(30)
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
    username character varying(20) NOT NULL,
    nombre_usuario character varying(50),
    apellido_usuario character varying(50),
    password character varying(200),
    activo boolean
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- Name: usuario_tipo; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE usuario_tipo (
    id_usuario_tipo integer NOT NULL,
    nombre_tipo character varying(20) NOT NULL,
    username character varying(20) NOT NULL
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
    usuario_username character varying(255) NOT NULL,
    tipos_nombre_tipo character varying(255) NOT NULL
);


ALTER TABLE public.usuario_tipousuario OWNER TO postgres;

--
-- Name: usuariobytipo; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW usuariobytipo AS
 SELECT u.username,
    u.password,
    t.nombre_tipo
   FROM usuario u,
    tipousuario t,
    usuario_tipousuario ut
  WHERE (((u.nombre_usuario)::text = (ut.usuario_username)::text) AND ((t.nombre_tipo)::text = (ut.tipos_nombre_tipo)::text));


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
    version integer,
    anio integer,
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
-- Name: id_usuario_tipo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario_tipo ALTER COLUMN id_usuario_tipo SET DEFAULT nextval('usuario_tipo_id_usuario_tipo_seq'::regclass);


--
-- Data for Name: alumno; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY alumno (nombre_alumno, apellido_alumno, mail_alumno, telefono_alumno, rut_alumno, direccion_alumno, id_plan_activo, version_plan_activo) FROM stdin;
NAYADA  HERNANDEZ OYANEDEL          128516948   \N  \N  \N
HERNANDO ANDRES MANRIQUEZ NAVARRO           173832168   \N  \N  \N
JOAQU�?N OLIVARES DONOSO JOLIVARESD@GMAIL.COM    \N  171818575   \N  \N  \N
SEBASTIAN   ROSENDE PINO    SEBASTIAN666@GMAIL.COM      153179409   \N  \N  \N
MANUEL ALEJANDRO    ALARCON BELMAR  MANUEL.ALARCON@USACH.CL \N  159073122   \N  \N  \N
GONZALO SEBASTIAN   ALVARADO REYES  MAILTO:GONSACOPATA@HOTMAIL.COM  \N  166257344   \N  \N  \N
MAR�?A SOLEDAD   ALVAREZ OPAZO   MAILTO:MARIA.ALVAREZO@USACH.CL  \N  169367353   \N  \N  \N
FABI�?N IGNACIO  ARÉVALO VEL�?SQEZ    FABIAN.AREVALO@USACH.CL \N  17841447K   \N  \N  \N
FABI�?N ESTEBAN  CABELLO DEVIA   MAILTO:FABIAN.CABELLOD@USACH.CL     163235315   \N  \N  \N
SERGIO DANIEL   CORTÉS PÉREZ            171176654   \N  \N  \N
LUIS EDUARDO    D�?AZ PEREIRA    LEDZAID@GMAIL.COM   \N  167535682   \N  \N  \N
HOSSMAN ANDRÉS  ESCOBAR MART�?NEZ    GUTURAL.VOICE@GMAIL.COM \N  179365995   \N  \N  \N
CLAUDIO ANDRÉS  MORALES ARAYA   CLAUDIO.MORALESAR@USACH.CL  \N  171676568   \N  \N  \N
ALEX    POBLETE GONZALEZ    ALEX.POBLETE@GMAIL.COM  \N  150947952   \N  \N  \N
JUAN ANDRÉS REYES RAM�?REZ   JANDRES.RR@GMAIL.COM    \N  136750089   \N  \N  \N
DIEGO IGNACIO   ROJAS BUSTOS    DIEGO.ROJASBU@USACH.CL  \N  174641625   \N  \N  \N
JOHN ISRAEL SALVO REYES JOHN.SALVOR@USACH.CL    \N  16548262K   \N  \N  \N
MAR�?A JOSÉ  TAMAYO LEIVA    MARIA.TAMAYOL@USACH.CL  \N  174115273   \N  \N  \N
FRANCISCO JAVIER    ACUÑA CASTILLO  MAILTO:FRANCISCO.ACUNA@USACH.CL \N  170217535   \N  \N  \N
ANDRES ESTEBAN  ALVAREZ ROMERO  ANDRESWF16@HOTMAIL.COM  \N  161952133   \N  \N  \N
ADOLFO ESTEBAN  DIAZ MORALES    ADOLFO.DIAZ@USACH.CL    \N  169009112   \N  \N  \N
FELIPE ANDRES   FUENTES BRAVO   MAILTO:FELIPE.FUENTESB@USACH.CL \N  167406386   \N  \N  \N
JUAN FRANCISCO  GONZALEZ REYES  MAILTO:JUAN.GONZALEZ@USACH.CL   \N  160707186   \N  \N  \N
YHANN CARLOS    JARA GODOY  YHANN.JARA@USACH.CL \N  172952739   \N  \N  \N
GUSTAVO JAVIER  MEJ�?AS KALVIS           166097401   \N  \N  \N
CARLOS ABRAHAM  MOLINA MUÑOZ    MAILTO:CARLOS.MOLINAM@USACH.CL  \N  167239404   \N  \N  \N
MARIO   MUÑOZ VILLEGAS  MARIO.MUNOZ@USACH.CL    \N  173127677   \N  \N  \N
HÉCTOR  OPAZO ROBLES    HECTOR.OPAZO.R@GMAIL.COM    \N  169091749   \N  \N  \N
HÉCTOR NICOL�?S  POBLETE ROJAS   MAILTO:HECTOR.POBLETE@USACH.CL  \N  166250536   \N  \N  \N
FELIPE ARTURO   REYES ENCINA    FELIPE.REYESE@USACH.CL  \N  171686202   \N  \N  \N
ARMANDO ROJAS MUÑOZ ARMANDO.ROJAS@USACH.CL  \N  173808200   \N  \N  \N
LUZ ESTRELLA    VALENZUELA CABALLERO    MAILTO:LUZ.VALENZUELA@USACH.CL  \N  167858244   \N  \N  \N
RICARDO ADRI�?N  CISTERNA ESPINA RICARDO.CISTERNA@USACH.CL   \N  174846863   \N  \N  \N
LEONARDO    ALLENDES CARVAJAL   LEONARDO.ALLENDES@GMAIL.COM \N  10225225K   \N  \N  \N
SEBASTIAN   CORNEJO BAEZA   SEBASTIAN.CORNEJO@GMAIL.COM \N  100438413   \N  \N  \N
VICTOR  ERICES NEIRA    VERICESN@GMAIL.COM  \N  141359193   \N  \N  \N
AQUILES ESTEBAN GONZALEZ FUENTES    AEGONZALEZ@GMAIL.COM    \N  132978883   \N  \N  \N
JULIO MAURICIO  MUÑOZ ALVAREZ   JULIO.MUNOZ.ALVAREZ@GMAIL.COM   \N  154115919   \N  \N  \N
ALDO CÉSAR  NAVARRETE MUÑOZ ALDO.NAVARRETE@USACH.CL \N  167503004   \N  \N  \N
JAIME HERN�?N    PAVEZ PAVEZ JAIMEPAVEZPAVEZ@GMAIL.COM   \N  151166822   \N  \N  \N
SEBASTI�?N ANDRÉS    SALAZAR SITIC   SEBASTIAN.SALAZARS@USACH.CL \N  153318115   \N  \N  \N
MARIO LUIS  LÓPEZ LANDEZ    MARIOLOPEZLANDES@GMAIL.COM  \N  171885701   \N  \N  \N
GUSTAVO ALBERTO SALVO LARA  GUSTAVO.SALVO@USACH.CL  \N  177402168   \N  \N  \N
MARCO ANTONIO   ACEVEDO BAEZA   MARCO.ACEVEDO@USACH.CL  \N  171233496   \N  \N  \N
MARCO ALEJANDRO BAEZA SALAZAR   MARCO.BAEZA@USACH.CL    \N  176719443   \N  \N  \N
FABI�?N ESTEBAN  CABELLO DEVIA   DANILO.BUSTOS@USACH.CL  \N  175147160   \N  \N  \N
DIEGO NICOL�?S   ESCOBAR LAGOS   DIEGO.ESCOBARLA@USACH.CL    \N  175863419   \N  \N  \N
ALFREDO ESCOBAR REX IVAN.ESCOBAR@USACH.CL   \N  180611843   \N  \N  \N
HUGO  MIGUEL    GARCIA GARCIA   LETHIUS@HOTMAIL.COM \N  161228850   \N  \N  \N
DIEGO SEBASTI�?N GARC�?A MELO DIEGO.GARCIA@USACH.CL   \N  160954361   \N  \N  \N
PABLO IGNACIO   GONZ�?LEZ CANTERGIANI    PABLO.GONZALEZCA@USACH.CL   \N  17080631K   \N  \N  \N
BRYAN   HENR�?QUEZ D�?AZ  B.HENRIQUEZD@GMAIL.COM  \N  164706699   \N  \N  \N
JAVIER  LARA SOTO   DIEGO.FRIEDMAN@GMAIL.COM        172863027   \N  \N  \N
VICTOR  LEBIL LEGUE VICTOR.LEBIL@GMAIL.COM  \N  125011268   \N  \N  \N
JUAN LUIS   MARCHANT AGUILAR    JUANLUISMARCHANT@GMAIL.COM  \N  167441882   \N  \N  \N
WILDER HEBERT   PRADO PACCI WILDERHP@GMAIL.COM  \N  158324954   \N  \N  \N
GONZALO QUEZADA MORAGA  GONZALOQUEZADAM@YAHOO.COM   \N  141459368   \N  \N  \N
BENJAMIN    QUINTANA OVIEDO BENJA.QUINTANA777@GMAIL.COM \N  180486011   \N  \N  \N
MANUEL ALEJANDRO    RUBIO HERRERA   MANUEL.RUBIOH@USACH.CL  \N  174841691   \N  \N  \N
RAFAEL  SOTO GALLARDO   RAFAEL.SOTO@USACH.CL    \N  174135142   \N  \N  \N
JOSHUA  TRONCOSO ESPEJO JOSHUA.TRONCOSO@USACH.CL    \N  170061403   \N  \N  \N
SERGIO FELIPE   VELASCO MOYA    SFVELASCO@GMAIL.COM \N  160158840   \N  \N  \N
MARCELA PAZ SANTANA JARA    MARCELA.SANTANA@USACH.CL    \N  176731303   \N  \N  \N
SEBASTI�?N ALEJANDRO ARAYA MORALES   SEBASTIAN.ARAYAM@USACH.CL   \N  174875642   \N  \N  \N
FABI�?N ANDRÉS   ARISMENDI FERRADA   FABIAN.ARISMENDI@USACH.CL   \N  169410313   \N  \N  \N
RODOLFO CONCHA  HERN�?NDEZ   RGCONCHA@VTR.NET    \N  120101099   \N  \N  \N
LEONARDO    ORTIZ CARTES    LEO9.ORTIZ@GMAIL.COM    \N  11266789K   \N  \N  \N
DELGADO JUAN PADILLA    JUAN.PADILLA@USACH.CL   \N  164182169   \N  \N  \N
SOLANGE ALEGRIA PARADA  SOLANGE.ALEGRIA@GMAIL.COM   \N  143418700   \N  \N  \N
SERGIO  GONZALEZ CELIS  SERGIOP.GONZALEZ@GMAIL.COM  \N  126644930   \N  \N  \N
FELIPE ANDRÉS   NANJARI FUENTES FNANJARI@SANTANDER.CL   \N  155667885   \N  \N  \N
YERKO ESTEBAN   PALMA SERRANO   YERKO.PALMA@USACH.CL    \N  175433406   \N  \N  \N
JOSÉ EDUARDO    PÉREZ MOYA          158433761   \N  \N  \N
PABLO   RIQUELME JOFRE  ROCKELME@GMAIL.COM  \N  121018071   \N  \N  \N
CRISTIAN FELIPE VALDÉS ROMERO   CRISTIAN.VALDESR@USACH.CL   \N  166606322   \N  \N  \N
ANDREA  YAÑEZ GALLEGOS  ANDREAYG@GMAIL.COM  \N  13471476K   \N  \N  \N
ALFONSO HENR�?QUEZ HANDY     12312312    172288987       \N  \N
JOSE    ZUARES NARBONA          123961846   \N  \N  \N
VICTOR  CRESPO ASTUDILLO    SIVCRESPO@GMAIL.COM     11480715K   \N  \N  \N
RODRIGO DE JESÚS     V�?SQUEZ FERN�?NDEZ  MAILTO:RODRIGO.VASQUEZFF@USACH.CL   \N  164115267   \N  \N  \N
IVAN ANDRES ABARCA BAVESTRELLO  IVAN.ABARCA@USACH.CL    \N  173102771   \N  \N  \N
MAURICIO    ACEVEDO C�?CERES MAILTO:MAURICIO.ACEVEDOC@USACH.CL   \N  160193379   \N  \N  \N
JORGE LUIS  ACUÑA ROJAS MAILTO:JORGE.ACUNA@USACH.CL \N  16633277K   \N  \N  \N
GERARDO ROBERTO ALONSO MELLADO  HIALEK@GMAIL.COM    \N  168401795   \N  \N  \N
PAZ CAROLINA    BUSTOS MENA PAZ.BUSTOS.M@GMAIL.COM  \N  174865744   \N  \N  \N
FELIPE IGNACIO  BUSTOS PONCE    FEIPE.BUSTOSP@GMAIL.COM \N  166489229   \N  \N  \N
CARLA SOPHIA    C�?CERES MAURICIO    CARLA.CACERES.M@GMAIL.COM   \N  14059203K   \N  \N  \N
ESTEBAN CAMPOS VALENZUELA   ESTEBAN.CAMPOS@USACH.CL \N  167834566   \N  \N  \N
SALVADOR    CORTÉS CATAL�?N  MAILTO:SALVADOR.CORTESC@USACH.CL    \N  161509299   \N  \N  \N
ANDY CRISTOPHER CULLACHE GARRIDO    MAILTO:ANDY.CULLACHE@USACH.CL   \N  172562752   \N  \N  \N
HÉCTOR ANDRÉS   ECHEVERR�?A QUINTANILLA  HECTOR.ECHEVERRIA@USACH.CL  \N  158896222   \N  \N  \N
ERWIN   FUENTEALBA GUARDIOLA    FUENTEALBA.ERWIN@GMAIL.COM  \N  151765637   \N  \N  \N
FELIPE  GARRIDO FREDES  FELIPE.GARRIDO.F@GMAIL.COM  \N  169428182   \N  \N  \N
ALONSO ALBERTO  GONZALEZ OTAROLA    MAILTO:ALONSO.GONZALEZOT@USACH.CL   \N  154010335   \N  \N  \N
FREDDY ANDRES   GUZMAN TABILO   FREDDY.GUZMAN@USACH.CL  \N  171219698   \N  \N  \N
FRANCISCO ALEXIS    HERN�?NDEZ VILLAGRA  FRANCISCO.HERNANDEZV@USACH.CL   \N  169849900   \N  \N  \N
ENRIQUE CESAR   JOPIA QUILODR�?N MAILTO:ENRIQUEJOPIAQ@GMAIL.COM  \N  157002880   \N  \N  \N
CRISTOPHER ESTEBAN  LEIVA ARAVENA   CRISTOPHER.LEIVAA@GMAIL.COM \N  173796773   \N  \N  \N
GABRIELA VICTORIA   LEÓN FLORES GABRIELA.LEON@USACH.CL  \N  174043221   \N  \N  \N
ALVARO  MALDONADO PINTO ALVARO.MALDONADO1988@GMAIL.COM  \N  169074526   \N  \N  \N
ALVARO IGNACIO  MENDEZ BRINCK   ALVARO.MEDEZB@USACH.CL  \N  16556717K   \N  \N  \N
BRUCE ELDA  MOGOLLONES  ELDAMB@GMAIL.COM    \N  72002393    \N  \N  \N
FABI�?N WILLIAM  MOLINS JARA MAILTO:FWMOLINS@GMAIL.COM   \N  166912644   \N  \N  \N
CHRISTIAN   MONTIEL SIERRALTA   CMONSIER@VTR.NET    \N  107046844   \N  \N  \N
JUAN    NECULQUEO LLANCO    JNECULQUEO@GMAIL.COM    \N  11473909K   \N  \N  \N
CAROLINA FABIOLA    ORREGO VERGARA  CAROLINA.ORREGO.VERGARA@GMAIL.COM   \N  167395333   \N  \N  \N
FELIPE  QUIROZ BECERRA  MAILTO:FELIPE.QUIROZ@GMAIL.COM  \N  139056736   \N  \N  \N
CARLOS ALBERTO  RIVERA VALENZUELA   MAILTO:CARLOS.RIVERA.VALENZUELA@GMAIL.COM   \N  156976261   \N  \N  \N
CÉSAR ANTONIO   SILVA CORNEJO   MAILTO:CESAR.SILVA@USACH.CL \N  166054109   \N  \N  \N
FAVIO ENRIQUE   ZUÑIGA SOTO MAILTO:FAVIO.ZUNIGA@GMAIL.COM   \N  168849516   \N  \N  \N
EDUARDO ALFREDO LAGOS ROSALES   EDUARDO.LAGOS@USACH.CL  \N  173387903   \N  \N  \N
JAVIER ALFONSO  C�?CERES MIÑO    JAVIER.CACERESM@USACH.CL    \N  174112924   \N  \N  \N
VIVIANA ALEJANDRA   CARO CARDENAS   MAILTO:VIVIANA.CARO@USACH.CL    \N  166099838   \N  \N  \N
HÉCTOR OSCIEL   HERRERA VILLAVICENCIO   MAILTO:HETOR.HERRERAVIL@USACH.CL    \N  165707036   \N  \N  \N
BASTIAN ANDRES  CABRERA ESPINOZA    BASTIAN.CABRERA@USACH.CL    \N  174890412   \N  \N  \N
SARAI   MARAMBIO MORALES    SARAI.MARAMBIO@GMAIL.COM    \N  180963820   \N  \N  \N
JEFFERSON ESTEBAN   MORALES DE LA PARRA JEFF_MDE@HOTMAIL.COM    \N  161670960   \N  \N  \N
LUIS FELIPE S�?NCHEZ GUDENSCHWAGER   LUIS.SANCHEZGU@USACH.CL \N  97829736    \N  \N  \N
ESTEBAN OMAR    MANOSALVA RODRIGUEZ MAILTO:ESTEBAN.MANOSALVA@USACH.CL   \N  161163813   \N  \N  \N
SUSANA  PALACIOS PIZARRO    SUSANA.PALACIOS@USACH.CL    \N  16955594K   \N  \N  \N
CHRISTOPHER BAYRON  URRUTIA MESSINA CHRISTOPHER.URRUTIA@USACH.CL    \N  171754755   \N  \N  \N
PATRICIO HERIBERTO  ALVAREZ URZUA   MAILTO:PATRICIO@HOTMAIL.COM \N  163215454   \N  \N  \N
ALEJANDRO ANDRÉS    CONTRERAS ZUÑIGA    MAILTO:ALEJANDRO.CONTRERASZ@USACH.CL    \N  17325752K   \N  \N  \N
MARCIA ANDREA   DUR�?N RIVEROS   MAILTO:MDURANRIV@GMAIL.COM  \N  156612529   \N  \N  \N
GUILLERMO ANTONIO   GAMBOA RAM�?REZ  GUILO32@HOTMAIL.COM     162648640   \N  \N  \N
VICTOR MANUEL   NARANJO PEREZ   MAILTO:VICTOR.NARANJO@USACH.CL  \N  137750406   \N  \N  \N
IV�?N    RIQUELME GAMONAL            92174379    \N  \N  \N
DANILO  ABURTO VIVIANS  DANILO@REQUIES.CL   \N  179043939   \N  \N  \N
JOSÉ LUIS   ALLENDE REIHER  MAILTO:JOSELUISAR20@GMAIL.COM   \N  158407337   \N  \N  \N
FABRIZIO    BARISIONE BISO          150881609   \N  \N  \N
JOSÉ    DE LA FUENTE LORCA  MAILTO:FDELAFUENTE.LC@GMAIL.COM \N  166612799   \N  \N  \N
V�?CTOR MANUEL   FLORES S�?NCHEZ  VICTOR.FLORESS@USACH.CL \N  175657436   \N  \N  \N
CRISTIAN    GIHA SEPULVEDA  MAILTO:CRISTIAN.GIHA@USACH.CL   \N  171464765   \N  \N  \N
RODDY BENJAM�?N  GONZ�?LEZ GARCÉS RODDY.GONZALEZ@USACH.CL \N  171002761   \N  \N  \N
HECTOR ALEXANDER    LAGOS PÉREZ MAILTO:HECTOR.LAGOS@USACH.CL    \N  168396449   \N  \N  \N
FELIPE  TORRES ROJAS            143831639   \N  \N  \N
JUAN PABLO  VERDEJO JORQUERA    JUAN.VERDEJO@USACH.CL   \N  171907233   \N  \N  \N
LUIS ANTONIO    VILLAGR�?N PAREDES   MAILTO:LUIS.VILLAGRAN@GMAIL.COM \N  155648511   \N  \N  \N
SEBASTI�?N SANTIAGO  VIZCAY DERZA    SEBASTIAN.VIZCAY@USACH.CL   \N  171052386   \N  \N  \N
VICTOR MANUEL   BAEZA RAM�?REZ   VBAEZ001@CODELCO.CL \N  142035928   \N  \N  \N
JOSÉ LUIS   CANDIA FIGUEROA JOSELUISCANDIA.F@GMAIL.COM  \N  166171644   \N  \N  \N
SEBASTI�?N GABRIEL   GONZ�?LEZ SALAZAR    METALHYOGA@GMAIL.COM    \N  168401264   \N  \N  \N
RODRIGO ANDRES  HENRIQUEZ RAMOS MAILTO:RODRIGO.HENRIQUEZR@USACH.CL  \N  139047788   \N  \N  \N
MIGUEL ÀNGEL    HERNÀNDEZ PONCE MAILTO:MIGUEL.HERNANDEZP@USACH.CL   \N  173249616   \N  \N  \N
RODRIGO PATRICIO    MIRANDA C�?RDENAS    RODRIGO.MIRANDACA@USACH.CL  \N  170842804   \N  \N  \N
FELIPE ALONSO   MONROY S�?EZ MAILTO:FELIPE.MONROY@USACH.CL   \N  166928370   \N  \N  \N
YANINA ELIZABETH    OVANDO GUERRERO YANINA.OVANDO@USACH.CL  \N  176314141   \N  \N  \N
ALFREDO EDUARDO PLATA ARANCIBIA ALFREDOPLATAA@GMAIL.COM \N  136865250   \N  \N  \N
JAIME   SAEZ POBLETE    JAIME.SAEZ.POBLETE@GMAIL.COM    \N  16171898K   \N  \N  \N
SEBASTIAN IGNACIO   STUARDO VILCHES SEBASTIAN.STUARDO@USACH.CL  \N  166632749   \N  \N  \N
ARNOLDO FABI�?N  VALENZUELA          16939816K   \N  \N  \N
CARLOS MATIAS   VILCHES MANDIOLA    CARLOS.VILCHES@USACH.CL \N  170721993   \N  \N  \N
CARLOS ANDRÉS   PÉREZ ROJAS CARLOS.PEREZRO@USACH.CL \N  181181486   \N  \N  \N
FRANCISCA   ALVAREZ MADRID  F.ALVAREZ.MADRID@GMAIL.COM  \N  158384043   \N  \N  \N
MAR�?A DEL ROSARIO   BERRUETA GONZ�?LEZ   MAILTO:MARI.BERRUETA@HOTMAIL.COM    \N  170508157   \N  \N  \N
MAURICIO LEONEL CARÚS FLORES    MAILTO:MCARUSF@GMAIL.COM    \N  161915602   \N  \N  \N
OSCAR FELIPE    CASTILLO BORQUEZ    MAILTO:STEALTH_ASSASSINS@HOTMAIL.COM    \N  166602181   \N  \N  \N
MAURO   CONTRERAS BEHRENS   MAILTO:MAURO.BEHRENS@GMAIL.COM  \N  170630025   \N  \N  \N
FRANCISCO   D�?AZ GONZ�?LEZ   PANCHOLOLIN@GMAIL.COM   \N  153400253   \N  \N  \N
NIKOL DANIELA   LIBERONA ARAYA  MAILTO:H2ZIRAX@YAHOO.COM    \N  163578476   \N  \N  \N
FERNANDO    MEZA ZAMORA         170256158   \N  \N  \N
EDUARDO ANDRÉS  MIRANDA PEREIRA MAILTO:EDUARDO.MIRANDAPE@USACH.CL   \N  162156055   \N  \N  \N
MARIA CRISTINA  NARANJO ROJAS   MAILTO:MARIA.NARANJO@USACH.CL   \N  165570820   \N  \N  \N
WALDO IGNACIO   ORTEGA OLAVE    MAILTO:WALDOHADES@GMAIL.COM \N  170052781   \N  \N  \N
RODRIGO ARMANDO QUINTEROS MAULEN    RODRIGO.QUINTEROSM@USACH.CL \N  159166422   \N  \N  \N
MANUEL ERNESTO  RAM�?REZ CALDERÓN    MAILTO:MANUEL.ERC@GMAIL.COM \N  172135528   \N  \N  \N
HUMBERTO DAR�?O  RIVERA GUTIERREZ    MAILTO:HUMBERTO.RIVERA@USACH.CL \N  167995314   \N  \N  \N
IVAN    ROJAS MARCHANT  IVAN.ROJAS@USACH.CL \N  141610120   \N  \N  \N
JOSÉ ALEJANDRO  ROJAS RAMOS MAILTO:JOSE.ROJAS.RAMOS@GMAIL.COM   \N  158385686   \N  \N  \N
IGNACIO IVAN    SANCHEZ FABRE   MAILTO:ISANCHEZFABRE@HOTMAIL.COM    \N  171212243   \N  \N  \N
IV�?N ANDRÉS SILVA CORNEJO   IVANSILVAC@GMAIL.COM    \N  160076747   \N  \N  \N
ALEJANDRO ALFREDO   TRUAN GRANDÓN   MAILTO:ALEJANDRO.TRUAN@GMAIL.COM    \N  152509022   \N  \N  \N
GERARDO JORGE   VILLARROEL GONZALEZ VILLARROEL.GJ@GMAIL.COM \N  153877009   \N  \N  \N
EDUARDO ZÚÑIGA JOFRÉ    MAILTO:EDUARDO.ZUNIGA.J@GMAIL.COM   \N  161168440   \N  \N  \N
JOSÉ    CABRERA BRAVO   78349616    \N  184407604   \N  \N  \N
MAURICIO    ASTORGA ORELLANA    ASTORGALORD@GMAIL.COM       169113823   \N  \N  \N
JORGE FRANCISCO CABEZAS MORALES JORGE.CABEZAS@USACH.CL  \N  169561249   \N  \N  \N
FELIPE ALBERTO  OLIVARES GUARDA MAILTO:FELIPE.OLIVARES.GUARDA@GMAIL.COM \N  162430947   \N  \N  \N
FERNANDO EUSEBIO    ORMEÑO CEBALLO  MAILTO:FERNANDO.ORMENO.C@GMAIL.COM  \N  162433903   \N  \N  \N
MANUEL FELIPE   ROJAS MARTINEZ  MAILTO:MANUEL.ROJAS.M@GMAIL.COM \N  162774778   \N  \N  \N
MIGUEL ANGEL    SALOM SALAS MAILTO:MIGUEL.SALOM.S@GMAIL.COM \N  153182051   \N  \N  \N
FERNANDO    CARVAJAL ARAYA  FDOCARVAJAL@GMAIL.COM   \N  10797136K   \N  \N  \N
GERARDO CONTRERAS MARDONES  GERARDO.CM@GMAIL.COM    \N  130555292   \N  \N  \N
JORGE ANDRÉS    MEYNARD PONTANILLA  JORGE.MEYNARD@GMAIL.COM \N  130594220   \N  \N  \N
JUAN CARLOS MONSALVE SAEZ   JCMONSALVE@NEOINGEN.CL  \N  126560028   \N  \N  \N
BRAIHAM TAPIA GONZALEZ  BRAIHAM.TAPIAG@USACH.CL \N  165393678   \N  \N  \N
JUAN OSVALDO    TORRES TOLEDO   MAILTO:JUANO.TORRES@GMAIL.COM   \N  162696513   \N  \N  \N
MATIAS FELIPE   BOBADILLA D�?AZ  MAILTO:MAT.BOBADILLA@GMAIL.COM  \N  173110189   \N  \N  \N
�?LVARO  C�?CERES ULLOA   A.CACERES.U@GMAIL.COM   \N  165385454   \N  \N  \N
FABIAN  CONTRERAS PICHUANTE CONTRERAS.PICHUANTE.FABIAN@GMAIL.COM    \N  163107155   \N  \N  \N
CLAUDIA SILVA MARTINEZ  CLAUDITS@GMAIL.COM  \N  151265588   \N  \N  \N
KARYL ALFREDO   V�?SQUEZ SOL�?S   KARYLVASQUEZ@GMAIL.COM  \N  141749579   \N  \N  \N
IGNACIO JAVIER  VILLARROEL S�?NCHEZ  MAILTO:GATREVOLUTION@GMAIL.COM  \N  167883273   \N  \N  \N
BELGICA  SANHUEZA MONTECINO MAILTO:BELGICA.SAHUEZA@GMAIL.COM    \N  16121874K   \N  \N  \N
FERNANDO    BRICEÑO GÓMEZ           101426750   \N  \N  \N
LUIS ALBERTO    CONTRERAS SALINAS   LUISC.USACH@GMAIL.COM   \N  143771512   \N  \N  \N
RENE    DIAZ PADILLA    RENE.DIAZ@USACH.CL  \N  66163636    \N  \N  \N
DAVID   ESPINOZA ROJAS          166944589   \N  \N  \N
ESTEBAN GONZALEZ RIVEROS    EGON27@GMAIL.COM        143404773   \N  \N  \N
JAVIER  HENRIQUEZ AHUMADA           153150958   \N  \N  \N
JORGE   HERRERA  PINTO  JHERRERAPINTO@GMAIL.COM     132541159   \N  \N  \N
MARCELO MAULÉN MUÑOZ    MARCELO.MAULEN@GMAIL.COM    \N  15890828k   \N  \N  \N
CRISTI�?N    POBLETE VOGT    CRISTIAN.VOGT@GMAIL.COM \N  135486108   \N  \N  \N
JUAN PABLO  REYES SEPÚLVEDA JUAN.P.REYES.S@GMAIL.COM        128773843   \N  \N  \N
JORGE   RIVERA BURGOS   JRIVERA110@GMAIL.COM    \N  139141628   \N  \N  \N
LINO ALFREDO    ROBLEDO CERDA   LINO_ROBLEDO@HOTMAIL.COM    \N  143180646   \N  \N  \N
RICARDO RUBIO RIVEROS   RRUBIO@CODELCO.CL   \N  106677514   \N  \N  \N
CRISTIAN    SILVA PONCE CRISTIAN.SILVAPO@USACH.CL       16178883K   \N  \N  \N
ESTEFANIA PAZ   TEJOS ARAYA MAILTO:ESTEFANIA.TEJOS@USACH.CL \N  167485081   \N  \N  \N
V�?CTOR EZEQUIEL V�?SQUEZ SAAVEDRA    EZEQUIEL77@TUTOPIA.COM  \N  132803188   \N  \N  \N
FELIPE  ALTAMIRANO ABURTO   FELIPE.ALTAMIRANO.PET2012@GMAIL.COM \N  138381072   \N  \N  \N
MARCIAL NATALIO HERN�?NDEZ S�?NCHEZ   MARCIALHS@GMAIL.COM \N  173865090   \N  \N  \N
SEBASTI�?N EDUARDO   MALDONADO DUR�?N SEBMALDO@GMAIL.COM  \N  15068143K   \N  \N  \N
MARIA ESTER SOTO BURGOS MARIASOTO@DELOITTE.COM  \N  139060806   \N  \N  \N
CARLOS  TORRES PEREZ    CARLOS.TORRES@USACH.CL  \N  151737943   \N  \N  \N
ANDREA DEL PILAR    ANTOINE ROJO            156039020   \N  \N  \N
JAINZ DIETRICH JOSE DE LA ROSA DONOSO           138819280   \N  \N  \N
KIRA LESLIE ESPINA SU�?REZ   MAILTO:KIRA.ESPINA@GMAIL.COM    \N  141976974   \N  \N  \N
ESTEBAN GOMEZ LILLO         139371127   \N  \N  \N
JOSÉ LUIS   NÚÑEZ D�?AZ  MAILTO:JOSENUNEZDIAZ@GMAIL.COM  \N  158377365   \N  \N  \N
OSCAR   PINTO SALAZAR           130680526   \N  \N  \N
XIMENA  VASQUEZ TOBAR   XIMENA.VASQUEZ@CARABINEROS.CL       134405155   \N  \N  \N
NICOL�?S ENRIQUE AROS FUENTES    NICOLAS.AROS@USACH.CL   \N  169087350   \N  \N  \N
JAVIER DAVID    BRAVO VALDIVIA  JAVIER.BRAVOV@USACH.CL  \N  173819803   \N  \N  \N
ALVARO  BUSTAMANTE FUENTES  ALVARO.BUSTAMANTE@USACH.CL  \N  169039682   \N  \N  \N
PAZ LETICIA CABEZAS GUERRERO    MAILTO:PAZ.CABEZAS@USACH.CL \N  172552609   \N  \N  \N
CRISTOPHER NELSON   DEL POZO CATALAN    MAILTO:CRISTOPHER.DELPOZO@USACH.CL  \N  172320104   \N  \N  \N
JEAN PIERRE D�?AZ BRAVO  JEAN.DIAZ@USACH.CL  \N  141234153   \N  \N  \N
NICOL�?S ALFONSO GARC�?A OLATE    MAILTO:NICOLAS.GARCIA.O@GMAIL.COM   \N  163867052   \N  \N  \N
JONATHAN ANDRÉS GARRIDO PINTO   MAILTO:BLACK.KAPO@GMAIL.COM \N  16569953K   \N  \N  \N
RODRIGO MUÑOZ LIZAMA    MAILTO:RODRIGO.MUNOZLIZ@USACH.CL    \N  156434027   \N  \N  \N
CLAUDIO NICOL�?S  ROJAS FUENTEALBA   CLAUDIO.ROJASF@YSACH.CL \N  170291220   \N  \N  \N
JAVIER ALEJANDRO    PARRA GARRIDO   JAVIER.PARRA@USACH.CL   \N  172510957   \N  \N  \N
GERARDO DAVID   PEREIRA DE LA HOZ   MAILTO:GERARDO.PEREIRA@USACH.CL \N  159598314   \N  \N  \N
FELIPE JAVIER   PIÑEIRO POBLETE FELIPE.PINEIRO@USACH.CL \N  172974325   \N  \N  \N
CRISTHIAN ANDRES    PLAZA IBARRA    MAILTO:CPLAZA@HOTMAIL.COM       151049486   \N  \N  \N
JORGE BERMECIDES    SALAZAR CASTRO  JORGE.SALAZAR@USACH.CL  \N  170289943   \N  \N  \N
GABRIEL ANTONIO SALAZAR MORENO  GABRIEL.SALAZAR@USACH.CL    \N  173028318   \N  \N  \N
GUILLERMO   SANTANDER LEÓN  GUILLERMO.SANTANDER@GMAIL.COM   \N  166096502   \N  \N  \N
IGNACIO EXEQUIEL    SARAVIA REYES   IGNACIO.SARAVIA@USACH.CL    \N  180762353   \N  \N  \N
PAZ MILLARAY    TOBAR MIRA  MAILTO:PAZ.TOBARM@USACH.CL  \N  170483685   \N  \N  \N
SEBASTI�?N ANTONIO   VALDES DONOSO   SEBASTIAN.VALDESD@USACH.CL  \N  173900996   \N  \N  \N
PABLO IGNACIO   DONOSO CASTRO   PABLO.DONOSOCA@USACH.CL \N  164729931   \N  \N  \N
RENE    CHANDIA NAVARRO RCHN1925@GMAIL.COM  \N  122596451   \N  \N  \N
DANIELA CONSTANZA   QUIROZ CARRASCO MAILTO:DANI.QUIROZ@GMAIL.COM    \N  166570727   \N  \N  \N
ALVARO ALEJANDRO    SALAS AVILA ALVARO.SALAS@USACH.CL   \N  169102627   \N  \N  \N
ROBERTO VALDERRAMA CORTES   RVALDCORT@GMAIL.COM \N  123957016   \N  \N  \N
JOSÉ CRISTÓBAL   ACEVEDO CAVIERES           160319135   \N  \N  \N
JEANS ANDREE     LÓPEZ DUCHENS  MAILTO:JEANS.LOPEZ.D@GMAIL.COM  \N  158932121   \N  \N  \N
FABIAN   TELLO D�?AZ FTELLODIAZ@GMAIL.COM    \N  168036639   \N  \N  \N
ROBERTO AROS ANGULO ROBERTOAROSA@USACH.CL   \N  135237566   \N  \N  \N
DANIEL  BRAVO DIAZ  DANIEL.BRAVO.DIAZ@GMAIL.COM     153447586   \N  \N  \N
CLAUDIO BUSTAMANTE ARRIAGADA    MAILTO:CLAUDIO.BUSTAMANTE.A@GMAIL.COM       159975509   \N  \N  \N
MAURICIO    CAMPOS RIVERA   MACAMPOSR@GMAIL.COM     129799927   \N  \N  \N
GUILLERMO   CANCINO GARATE  GUILLERMO.CANCINO@GMAIL.COM     119905621   \N  \N  \N
RICHARD ALEJANDRO   CASAS FARIAS    RICHARD.CASAS@GMAIL.COM \N  155885173   \N  \N  \N
FRANCISCO JOSE  DIAZ NEIRA  FRANCISCO.DIAZN@USACH.CL    \N  126355971   \N  \N  \N
BLADIMIR ALEXIS FLORES GATICA   BLADIMIR.FLORES@USACH.CL    \N  118425480   \N  \N  \N
CARLOS MANUEL   GARCIA CARRASCO MAILTO:CARLOS.GARCIACA@USACH.CL \N  161173800   \N  \N  \N
ESTEBAN HOLTHEUER ROJAS ESTEBAN.HOLTHEUER@GMAIL.COM \N  169592306   \N  \N  \N
NICOL�?S HUERTA FUENTES  NICOLAS.HUERTA@USACH.CL \N  172683843   \N  \N  \N
FELIPE  LAGOS BECERRA   FLAGOSB@GMAIL.COM       102607376   \N  \N  \N
SERGIO  MIRANDA VALDES  SERGIO.MIRANDA@EQUIFAX.CL       156663859   \N  \N  \N
FELIPE  MOLINA GONZALEZ         155446099   \N  \N  \N
SEBASTIAN   OPAZO PALOMINO  MAILTO:SEBASTIANOPAZO@GMAIL.COM \N  164735737   \N  \N  \N
SEBASTI�?N EMILIO    ORELLANA CASANOVA   SEBASTIAN.ORELLANAC@GMAIL.COM   \N  163549239   \N  \N  \N
BRUCES  PIÑA JARA           141968092   \N  \N  \N
JORGE EDUARDO   REBOLLEDO GONZ�?LEZ  JORGE.REBOLLEDO@USACH.CL    \N  179512130   \N  \N  \N
CARLOS ROBERTO  RIVAS CONEJERO          16375228K   \N  \N  \N
LORETO ISABEL   RODRIGUEZ CORREA    MAILTO:LORETO.RODRIGUEZ@USACH.CL    \N  171663741   \N  \N  \N
LEONARDO    ROJO AHUMADA    LEOROJOAHU@YAHOO.COM    \N  98953051    \N  \N  \N
NELSON ALEJANDRO    ULLOA QUINTANA  NELSON.ULLOA@ENDESA.ES  \N  139147820   \N  \N  \N
RAUL    VARGAS PEREZ    RAUL.VARGAS@VTR.NET     122550915   \N  \N  \N
JAIME   VIDAL OLIVA         126305478   \N  \N  \N
ALVARO  ZUÑIGA CABEZAS  MAILTO:ALVARO.ZUNIGACA@USACH.CL \N  157559281   \N  \N  \N
FERNANDO     GONZ�?LEZ CASTRO    FERNANDO.CONZALEZCAS@USACH.CL,  FERNANDO.GONZALEZCAS@USACH.CL   \N  151138853   \N  \N  \N
CRISTÓBAL ALEJANDRO ACOSTA JURADO   MAILTO:CRISTOBAL.ACOSTA@USACH.CL    \N  163601311   \N  \N  \N
JORGE ANDRES    BOURGUET BARRIGA    MAILTO:JORGECROSS3@HOTMAIL.COM  \N  171679249   \N  \N  \N
CRISTIAN ANDRES BRAVO PETRICIC  MAILTO:CPETRICIC@GMAIL.COM  \N  170215710   \N  \N  \N
CRISTIAN    CORNEJO LUENGO  CRISTIAN.CORNEJO@USACH.CL   \N  175975721   \N  \N  \N
CAMILO  FARF�?N PÉREZ    CAMILO.FARFAN@USACH.CL  \N  171509688   \N  \N  \N
RUBÉN LEANDRO   FIGUEROA NAHUELPI   RUBEN.FIGUEROA@USACH.CL \N  165626826   \N  \N  \N
FELIPE ANTONIO  IRIBARREN VIERTEL   MAILTO:FELIPE.IRIBARREN@GMAIL.COM   \N  161561444   \N  \N  \N
ALDO ALEX   JIMENEZ ALEGRE  MAILTO:ALDO.JIMENEZ.A@GMAIL.COM \N  141645064   \N  \N  \N
CAMILO FABI�?N   MUÑOZ SILVA MAILTO:CAMILO.MUÑOZS@USACH.CL   \N  167891497   \N  \N  \N
MAR�?A JOSÉ  OSORIO SOTO MARIA.OSORIOS@USACH.CL  \N  167998186   \N  \N  \N
FABI�?N ESTEBAN  PARRA MESSINA   MAILTO:FABIAN.PARRAM@USACH.CL   \N  173169906   \N  \N  \N
DANIEL IGNACIO  PAVEZ SANDOVAL  MAILTO:DANIEL.PAVEZ@USACH.CL    \N  164780430   \N  \N  \N
DANIEL ANDRES   SOTO CASTRO DANIEL.SOTO.CASTRO@GMAIL.COM    \N  130597572   \N  \N  \N
IBER SEBASTI�?N  �?LVARES D�?AZ    IBERALVAREZ@YAHOO.ES    \N  154841970   \N  \N  \N
EDISON JOHN ARAYA GONZ�?LEZ  MECI2009@YAHOO.COM  \N  120324314   \N  \N  \N
LEONARDO    CABRERA LOBOS   LCABRERA@AMERICAECONOMIA.COM    \N  159674290   \N  \N  \N
ADRI�?N ERNESTO  CONTRERAS ROMO  MAILTO:ADRIAN.CONTRERAS@USACH.CL    \N  164324206   \N  \N  \N
NICOL�?S EL�?AS   FIGUEROA MATEO  NICOLAS.FIGUEROAMA@USACH.CL \N  163652838   \N  \N  \N
JOSE    GOMEZ JOFRE FELIX_GJ2003@HOTMAIL.COM    \N  134428244   \N  \N  \N
DIEGO ANTONIO   GUTIERREZ MOLINA    MAILTO:DIEGO.GUTIERREZM@USACH.CL    \N  174176264   \N  \N  \N
FELIPE ANTONIO  MACHUCA SAN JUAN    MAILTO:FELIPE.MACHUCA@USACH.CL  \N  170309545   \N  \N  \N
LUIS FRANCISCO  MALDONADO SALAZAR   MAILTO:LUISEVERNET@GMAIL.COM    \N  169847029   \N  \N  \N
CAROLINA ANDREA MART�?NEZ PÉREZ DE ARCE  CMARTINEZP.00@GMAIL.COM,"CAROLINA.MARTINEZP@USACH.CL")  \N  167441823   \N  \N  \N
ALBERTO DANIEL  OCHOA JOHN JUAN MAILTO:DOCHOAJ@GMAIL.COM    \N  174052255   \N  \N  \N
ANDRES  ROJAS PARDO RODRIGO MAILTO:RODRIGO.ROJASP@USACH.CL  \N  173136986   \N  \N  \N
FRANCISCO JAVIER    SAENZ TOBAR MAILTO:SAENZJ@GMAIL.COM \N  163225816   \N  \N  \N
EMILIO  TAPIA SANHUEZA  MAILTO:EMILIO.TAPIA@USACH.CL    \N  168039891   \N  \N  \N
ORLANDO ANDRÉS  VEL�?SQUEZ CÓRDOBA   OVCORDOBA@GMAIL.COM     160081937   \N  \N  \N
PEDRO   VENEGAS SANTIBAÑEZ  PEDRO.VENEGAS@GMAIL.COM \N  141861239   \N  \N  \N
JOSÉ DANIEL ORELLANA NÚÑEZ  JOSE.ORELLANAN@USACH.CL \N  170222156   \N  \N  \N
PAOLA IGNACIA   ARMIJO TORRES   MAILTO:PAOLA.ARMIJO@USACH.CL    \N  167432530   \N  \N  \N
GONZALO CAMILO  D�?AZ CRUZ   MAILTO:GONZALO.DIAZCRU@USACH.CL \N  165319559   \N  \N  \N
HÉCTOR GERARDO  FUENTES GAETE           167485405   \N  \N  \N
NICOLAS GAJARDO AEDO    NICOLAS.GAJARDOA@USACH.CL   \N  169969329   \N  \N  \N
MARCELA PAZ GIL SANHUEZA    MARCELA.GIL@USACH.CL    \N  163219689   \N  \N  \N
MARIANO PATRICIO    GONZALEZ NUÑEZ  MAILTO:MARIANO.G.N@HOTMAIL.COM  \N  167282032   \N  \N  \N
DANIEL  HIDALGO PINTO   DANIEL.HIDALGO@GMAIL.COM        130441793   \N  \N  \N
JUAN ANDRÉS LEVICHE HUILIP�?N    MAILTO:JLEVICHE@GMAIL.COM   \N  164751392   \N  \N  \N
CRISTIAN ANDRÉS LÓPEZ NÚÑEZ CRISTIAN_ALN@HOTMAIL.COM    \N  16612106K   \N  \N  \N
RICARDO LOPEZ SOT   RJLOPEZS@GMAIL.COM  \N  132575568   \N  \N  \N
MIGUEL �?NGEL    MORAGA ALCAINO  MAILTO:MIGMORAGA@GMAIL.COM  \N  166810388   \N  \N  \N
SUN-HO  NOH SUNNOH@GMAIL.COM    \N  145012163   \N  \N  \N
PAULO IGNACIO   PAILLACAR OYARZO    PAULO.PAILLACAR@USACH.CL    \N  167472982   \N  \N  \N
RAFAEL  PALOMINO ROJAS  R.PALOMINO.ROJAS@GMAIL.COM  \N  167116116   \N  \N  \N
SANDRA  SAAVEDA VERGARA S.SAAVEDRA.V@GMAIL.COM  \N  105018274   \N  \N  \N
CLAUDIA ANDREA  SEPÚLVEDA SALFATE   MAILTO:CLAUDIA.SEPULVEDA.S@GMAIL.COM    \N  161240176   \N  \N  \N
DORIS   SOTO AGUIRRE    DORISSOTOA@GMAIL.COM    \N  9998998K    \N  \N  \N
GABRIEL �?NGEL   TAMAYO LEIVA    GABRIEL.TAMAYO@LIVE.CL  \N  176675459   \N  \N  \N
FELIPE  TAPIA ARACENA   FELIPE.TAPIAA@USACH.CL  \N  167463479   \N  \N  \N
JORGE GUILLERMO TOBAR VALLADARES    JORGE.TOBAR@USACH.CL    \N  167460003   \N  \N  \N
JONATHAN    UMAÑA RAM�?REZ   JONATHAN.UMANAR@USACH.CL    \N  164910652   \N  \N  \N
GERARDO URETA QUEVEDO   GURETAQ@GMAIL.COM   \N  83157739    \N  \N  \N
NATALIA VARAS RIVERA    VARASSR@GMAIL.COM   \N  170631129   \N  \N  \N
DAVID IGNACIO   AGUILAR BORNE   DAVID.AGUILAR@USACH.CL  \N  169448264   \N  \N  \N
VICTOR MANUEL   BARRA BUSTAMANTE    MAILTO:BALROG687@GMAIL.COM  \N  164792560   \N  \N  \N
DIEGO ESTEBAN   BERR�?OS AGUIRRE DIEGO.BERRIOS@USACH.CL  \N  174044953   \N  \N  \N
VICENTE BRAVO PRIDA VICENTE.BRAVO@USACH.CL  \N  174424977   \N  \N  \N
JORGE ALBERTO   C�?RCAMO BUSTAMANTE          170505727   \N  \N  \N
ALEX IGNACIO    CARRASCO BARRAS MAILTO:ALEX.CARRASCO@GMAIL.COM  \N  156646636   \N  \N  \N
ALEJANDRO JOSÉ  CISTERNA VILLALOBOS MAILTO:ALEJANDRO.CISTERNA@USACH.CL  \N  167391753   \N  \N  \N
PAULINA B�?RBARA GALLARDO GRANDÓN    PAULINA.GGRANDON@GMAIL.COM  \N  17850620K   \N  \N  \N
CLAUDIO IGNACIO GALLARDO MILLAR MAILTO:CLAUDIO.GALLARDO@USACH.CL    \N  168409974   \N  \N  \N
LUCIANO HIDALGO SEPÚLVEDA   MAILTO:LUCIANO.HIDALGO@USACH.CL \N  167497578   \N  \N  \N
MAURICIO ANDRÉS MATURANA SANDOVAL   MAURICIO.MATURANA@HOTMAIL.COM   \N  167464181   \N  \N  \N
ROBERTO JULIO   MOYA SUAREZ ROBERTO.MOYA.SUAREZ@GMAIL.COM   \N  169197342   \N  \N  \N
CRISTOPHER  MUÑOZ SANDOVAL  TOPHER182@GMAIL.COM \N  167476171   \N  \N  \N
FELIPE  P�?EZ RODR�?GUEZ  FELIPE.PAEZR@HOTMAIL.COM    \N  170286499   \N  \N  \N
JULIO ALEJANDRO PARRAO BUSCHMANN    MAILTO:JPARRAOB@GMAIL.COM   \N  160687975   \N  \N  \N
SIMÓN IGNACIO   RODR�?GUEZ ARANDA    SIMON.RODRIGUEZ@USACH.CL    \N  173093403   \N  \N  \N
NICOLE  SANHUEZA HINOJOSA   NICOLE.SANHUEZA@USACH.CL    \N  176744499   \N  \N  \N
CRISTIAN    SEPÚLVEDA SANCHEZ   CRANSEPULVEDA@GMAIL.COM \N  132527121   \N  \N  \N
NICOL�?S PATRICIO    SOTO CALDERÓN   NICOLAS.SOTOS@USACH.CL      165702867   \N  \N  \N
CÉSAR ANDRÉS    STUARDO MORAGA  MAILTO:CESAR.STUARDO@USACH.CL   \N  162850350   \N  \N  \N
MARCELO VASQUEZ VASQUEZ NYCOMVV@HOTMAIL.COM \N  120472003   \N  \N  \N
CAMILA ALEJANDRA    CASTILLO GUTIÉRREZ  CAMILA.CASTILLO@USACH.CL    \N  174866309   \N  \N  \N
JORGE ANDRÉS ALBERTO    FIGUEROA GONZ�?LEZ   JORGE.FIGUEROAGO@USACH.CL   \N  174256346   \N  \N  \N
ALEX PATRICIO   AHUMADA AHUMADA ALEX.AHUMADA@USACH.CL   \N  172427545   \N  \N  \N
CAMILA FERNANDA TORRES VILLANUEVA   CAMILA.TORRESV@USACH.CL \N  175340718   \N  \N  \N
CAMILO ANDRÉS   CORREA RUZ  CAMILO.CORREA.RUZ@GMAIL.COM \N  174888817   \N  \N  \N
JAIME    S�?EZ POBLETE           16171898k   \N  \N  \N
RODRIGO ANDRÉS  CASTRO SANTANA  MAILTO:RCASTR83@GMAIL.COM   \N  155661569   \N  \N  \N
ROBINSON ALEJANDRO  GARRIDO FIGUEROA    ROBINSON.GARRIDO@GMAIL.COM      134897384   \N  \N  \N
CAROLINA ANDREA MALEBRAN QUIROGA    CAROLINA.MALEBRAN.Q@GMAIL.COM   \N  101489736   \N  \N  \N
RODRIGO HERN�?N  PALMA CONTRERAS RHPALMAC@GMAIL.COM, \N  132601305   \N  \N  \N
NICOLAS CAMILO  ACEITUNO LEIVA  NICOLAS.ACEITUNO@GMAIL.COM  \N  172508782   \N  \N  \N
DANIEL  WLADDIMIRO COTTET   DANIEL.WLADDIMIRO@USACH.CL  \N  182940933   \N  \N  \N
GONZALO ARAYA REYES GARAYA.REYES@GMAIL.COM      153503583   \N  \N  \N
JOSE    CAPDEVILLE PEREZ            101113515   \N  \N  \N
PAOLO ENRIQUE   CEPEDA ROJAS    PCEPEDA@MMM.COM \N  123894960   \N  \N  \N
JULIO   DELGADO PUEBLA  JULIODELGA@GMAIL.COM    \N  142527847   \N  \N  \N
ERICK   HECHT LOPEZ ERICK.HECHT@GMAIL.COM       132136106   \N  \N  \N
FERNANDO    LAZZARICH MEZA          130557333   \N  \N  \N
MAR�?A GABRIELA  LÓPEZ BARRAZUETA    GABRIELA.LOPEZ.B@GMAIL.COM  \N  147365403   \N  \N  \N
JUAN    MOLINA VERA JAMOLINAV@GMAIL.COM     142432722   \N  \N  \N
BERNABE PEREZ PAILLAMIL BERNA@BROWSE.CL     130476716   \N  \N  \N
PABLO   QUIROZ CARREÑO  PBQUIROZ@GMAIL.COM      139368142   \N  \N  \N
ARIEL   SAAVEDRA GAR�?N  MAILTO:ARIEL.SAAVEDRA@USACH.CL  \N  171204593   \N  \N  \N
JUAN    VALENZUELA VENEGAS  JUAN.VALENZUELA@USACH.CL    \N  120580094   \N  \N  \N
PABLO   VILCHES RODRIGUEZ   PABLO.VILCHES@GMAIL.COM     130273513   \N  \N  \N
ALEXIS  Y�?ÑEZ HORMAZ�?BAL            137465493   \N  \N  \N
MIRTA   CHANDIA MARECHAL    MIRTACHANDIA@GMAIL.COM      12236299K   \N  \N  \N
MARCELO CORDERO JULIO   MARCELOCORDEROJULIO@GMAIL.COM       111690871   \N  \N  \N
DANIEL ANDRÉS   NAVARRO BRITO   DANIEL.NAVARRO.BRITO@GMAIL.COM  \N  164273008   \N  \N  \N
HERNAN  OLAVARRIA VENEGAS           141928664   \N  \N  \N
IVAN    PEREZ PANTOJA           118453816   \N  \N  \N
MIGUEL ANGEL    POBLETE ESCALONA    MAPOBLETE2005@GMAIL.COM     126776691   \N  \N  \N
ALEJANDRO   ROMERO POBLETE          07364058K   \N  \N  \N
CARLOS ALFREDO  BARRERA PULGAR  CARLOS.BARRERAP@USACH.CL    \N  17705318K   \N  \N  \N
RODRIGO HERN�?N  CIFUENTES RUIZ  RODRIGO.CIFUENTES@USACH.CL  \N  174859329   \N  \N  \N
ESTEBAN ANDRÉS  CONTARDO PÉREZ  ESTEBAN.CONTARDO@USACH.CL   \N  176233516   \N  \N  \N
AILEEN  ESPARZA VILLAM�?N    AILEEN.ESPARZA@USACH.CL \N  176641959   \N  \N  \N
GARY IGNACIO    FUENZALIDA NAVARRETE    GARY.FUENZALIDA@USACH.CL    \N  17490314K   \N  \N  \N
NICOL�?S EMILIO  MONTENEGRO VARELA   NICOLAS.MONTENEGRO@USACH.CL     180550321   \N  \N  \N
JOSÉ LUIS   VARELA OT�?ROLA  JOSE.VARELA@USACH.CL    \N  176013435   \N  \N  \N
JUAN CARLOS VARGAS GODOY    JUAN.VARGAS@USACH.CL    \N  174269211   \N  \N  \N
MAT�?AS NICOL�?S  GARC�?A VERDUGO  MANIGAVE@GMAIL.COM  \N  175333967   \N  \N  \N
RODRIGO ANDRÉS  MONSALVE LAGOS  RODRIGO.MONSALVEL@USACH.CL  \N  176717890   \N  \N  \N
RODRIGO BARRIENTOS BELTRAN          116474042   \N  \N  \N
IGNACIO JAVIER  ECHEGOYEN BATHICH   MAILTO:IGNACIO.ECHEGOYEN@USACH.CL   \N  17084405K   \N  \N  \N
RUBÉN ANDRÉ ITURRIETA SEPÚLVEDA MAILTO:RUBEN.ITURRIETA@USACH.CL \N  174273944   \N  \N  \N
ALEX CRISTIAN   OBREGÓN GALAZ   MAILTO:ALEXR.67@GMAIL.COM   \N  161280070   \N  \N  \N
JERSON ANTONIO  ORTIZ SILVA MAILTO:JERSON.ORTIZ@GMAIL.COM   \N  161469912   \N  \N  \N
CRISTIAN    ACEVEDO FUENZALIDA  CRISTIAN.ACEVEDO@USACH.CL   \N  169033188   \N  \N  \N
FABI�?N IGNACIO  ACUÑA FLORES    FABIAN.ACUNAF@USACH.CL  \N  166484588   \N  \N  \N
ANDREA CECILIA  ALARCON SOTO    MAILTO:ACAS_MG2004@HOTMAIL.COM  \N  157724282   \N  \N  \N
ALLISON CRISTINA    ALBORNOZ BARRA  MAILTO:ALLISON.ALBORNOZ@GMAIL.COM   \N  156430579   \N  \N  \N
FELIPE ALEXIS   ALFARO MUÑOZ    MAILTO:FELIPE.ALFAROM@USACH.CL  \N  17372098K   \N  \N  \N
LUCIANO ARANCIBIA VALENZUELA    PIERROT.72@GMAIL.COM    \N  173549849   \N  \N  \N
RENÉ PATRICIO   ARNÉS ARNÉS RENE.ARNES@USACH.CL \N  175646736   \N  \N  \N
HANS KEVIN  AUZIAN CASTRO   HANS.AUZIAN@USACH.CL        176683007   \N  \N  \N
HECTOR GUILLERMO    AYET CERNA  HECTOR.AYET@GMAIL.COM   \N  94928400    \N  \N  \N
LUIS    BARASSI MALDONADO   MAILTO:LUIS.BARASSI@USACH.CL    \N  160895683   \N  \N  \N
DANIEL GUSTAVO  BARRIA CONCHA   MAILTO:DANIELBC@GMAIL.COM   \N  153742642   \N  \N  \N
SEBASTI�?N ALEJANDRO BEAS HIDALGO    SEBASTIAN.BEAS@GMAIL.COM    \N  164336646   \N  \N  \N
RODRIGO BRIONES SEPULVEDA   RBRIONES@GMAIL.COM  \N  132455252   \N  \N  \N
JUAN PABLO  CÓRDOBA VARGAS  MAILTO:JUAN.CORDOVA.VARGAS@GMAIL.COM    \N  156394165   \N  \N  \N
CRISTOBAL   DEL FIERRO BERRIOS  CRISTOBAL.DELFIERROB@GMAIL.COM  \N  182100625   \N  \N  \N
DIEGO ESTEVAN   DUR�?N LÓPEZ DIEGO.DURAN@USACH.CL    \N  165308697   \N  \N  \N
MIGUEL ANGEL    ELEMATORE CARRASCO  MIGUEL_ELEMATORE@YAHOO.ES   \N  158323486   \N  \N  \N
JUAN PABLO  FLORES VARGAS   MAILTO:JP.FLORESV@GMAIL.COM \N  166401313   \N  \N  \N
PEDRO ALFONSO   FUENTEALBA MART�?NEZ PAFM2006@GMAIL.COM  \N  90073648    \N  \N  \N
JUAN JOSE   FUENTES GONZALEZ    MAILTO:JUANJOTOPER@HOTMAIL.COM  \N  141871331   \N  \N  \N
ELOY    GALLEGOS OLIVARES   ELOY.GALLEGOS@USACH.CL  \N  166183383   \N  \N  \N
PATRICIO EDUARDO    GARRIDO BARRA   PATRICIOGARRIDOBARRA@GMAIL.COM  \N  173132387   \N  \N  \N
LUIS IGNACIO    GARRIDO PARDO   LUIS.GARRIDOP@USACH.CL  \N  172571182   \N  \N  \N
EDGAR OLADIO    GATICA MARTINEZ EDGAR.GATICA@USACH.CL   \N  171895723   \N  \N  \N
VIVIANA CAROLINA    GONZ�?LEZ HERRERA    VIVIANA.GONZALEZH@USACH.CL  \N  167182952   \N  \N  \N
CAMILO ANDRÉS   HENRIQUEZ MENA  CAMILO.HENRIQUEZ.MENA@GMAIL.COM \N  156491373   \N  \N  \N
LUIS FERNANDO   HERN�?NDEZ HERN�?NDEZ MAILTO:IFHERNANDEZH@GMAIL.COM   \N  154680756   \N  \N  \N
ANTONIO ALESSANDRO  IB�?ÑEZ BENDEZÚ  ANTONIO.IBANEZ@USACH.CL \N  147074220   \N  \N  \N
DIEGO JOSÉ  JAUME GUAZZINI  DIEGO.JAUME@USACH.CL    \N  174025282   \N  \N  \N
CRISTIAN ANDRÉS LARCO LIZAMA    CRISTIAN.LARCO@GMAIL.COM    \N  163589419   \N  \N  \N
SEBASTI�?N   LEIVA GULPPI    MAILTO:SHEBA_LEIVA@HOTMAIL.COM  \N  167454761   \N  \N  \N
JUAN PABLO  LEÓN ARCE   IKERUX@GMAIL.COM    \N  168553439   \N  \N  \N
MIGUEL  MALDONADO ALGUERNA  MAILTO:MIGUEL.MALDONADO@USACH.CL    \N  163725886   \N  \N  \N
MIGUEL �?NGEL    MEJ�?AS S�?EZ MAILTO:MIGUELMEJIAS10@GMAIL.COM \N  164174034   \N  \N  \N
MARTA ISABEL    MENESES SEPULVEDA   MARTA.MENESES@USACH.CL  \N  17414852K   \N  \N  \N
OSCAR ALEJANDRO MOLINA LEIVA    MAILTO:OSCAR.MOLINAL@GMAIL.COM  \N  158369346   \N  \N  \N
CARLOS MANFRED  MORALES GÓMEZ   CMANFREDM@GMAIL.COM \N  141545914   \N  \N  \N
RODRIGO ANDRÉS  MORALES MEDINA          161974579   \N  \N  \N
MARCO   MORALES PINCHEIRA   MARCOMORALESP@GMAIL.COM \N  139154673   \N  \N  \N
CRISTIAN ALEJANDRO  MUÑOZ GUAJARDO  MAILTO:CRISTIAN.MUNOZ.G@HOTMAIL.COM \N  159005577   \N  \N  \N
CARLOS JAVIER   MUÑOZ NAVARRETE CMUNOZN@LIVE.CL \N  120041282   \N  \N  \N
PABLO ANDRÉS    MURGA SALVATIERRA   PABLO.MURGA@USACH.CL        180830936   \N  \N  \N
FABI�?N ANDRÉS   NARANJO BUSTAMANTE  MAILTO:NARANJO.FABIAN@GMAIL.COM \N  161483419   \N  \N  \N
NICOL�?S NAZRÉ   NASER ABARZÚA   NICOLAS.NASER@USACH.CL  \N  177406538   \N  \N  \N
MIGUEL ANGEL    NAVARRO CERECEDA    MAILTO:MIGUEL.NAVARROC@USACH.CL \N  159301567   \N  \N  \N
ALMA    NEGRETE SHEN    ALMANEGRETESHEN@GMAIL.COM   \N  160794321   \N  \N  \N
RODEN   OLIVEROS VIDAL  RODEN.OLIVEROS@USACH.CL \N  169325421   \N  \N  \N
CAROLINA PAZ    OSORIO FAURÉ    MAILTO:CAROLINA_OSORIO_FAURE@HOTMAIL.COM    \N  164730271   \N  \N  \N
JONNATAN WASHINGTON OYARZÚN RODRIGUEZ   MAILTO:JONSXAERO@GMAIL.COM  \N  161989495   \N  \N  \N
CRISTOPHER HERN�?N   PEREIRA SANDOVAL    CRISTOPHER.PEREIRAS@GMAIL. COM  \N  18049152K   \N  \N  \N
CRISTOBAL   PEREZ VASQUEZ   CRISTOBAL.PEREZ@USACH.CL    \N  162121774   \N  \N  \N
PABLO IGNACIO   PULGAR LÓPEZ    PULGAO10@GMAIL.COM  \N  163827255   \N  \N  \N
DANIELA CONSTANZA   QUIROZ CARRASCO DANI.QUIROZ@GMAIL.COM   \N  166570722   \N  \N  \N
RODRIGO RAMIREZ GARZO   RODRIGORAMI@GMAIL.COM   \N  128108408   \N  \N  \N
PRISCILLA   READI ANANIAS   PRISCYREADI@GMAIL.COM   \N  136874667   \N  \N  \N
JOSE MIGUEL REMOLCOY VELASQUEZ  JOSE.REMOLCOYV@USACH.CL \N  16385788K   \N  \N  \N
GONZALO ALEJANDRO   ROCO D�?AZ   MAILTO:GONZALO.ROCO@USACH.CL    \N  167404855   \N  \N  \N
GONZALO ROJAS MONTIEL   GONZALO.ROJASMO@USACH.CL    \N  160265353   \N  \N  \N
RODRIGO SANDOVAL TEJERINA   MAILTO:SANDOVAL622@HOTMAIL.COM  \N  160208619   \N  \N  \N
JOSÉ MANUEL VALDIVIESO OYARCE   MAILTO:JOSE.VALDIVIESOO@GMAIL.COM   \N  158366037   \N  \N  \N
RODRIGO ANDRÉS  Y�?ÑEZ GUTIÉRREZ RODRIGO.YANEZGUSACH.CL  \N  144878552   \N  \N  \N
PEDRO CAMILO    ROJAS BERIESTAIN    PEDRO.ROJASB@USACH.CL   \N  171891841   \N  \N  \N
FELIPE ANDRÉS   VALENZUELA HERN�?NDEZ    FELIPE.VALENZUELAH@USACH.CL \N  169772835   \N  \N  \N
JAVIER ALONSO   CAMPOS OLGU�?N   JAVIER.CAMPOSO@USACH.CL \N  166398703   \N  \N  \N
V�?CTOR  REYES TAPIA         176782765   \N  \N  \N
DIEGO   GÓMEZ LIRA  DIEGOG.ASD@GMAIL.COM    \N  169402035   \N  \N  \N
MIGUEL ANGEL    JARA RODR�?GUEZ  MIGUEL.JARA.RODRIGUEZ@GMAIL.COM \N  170054989   \N  \N  \N
BYRON   LANAS LAFERTTE  BYRON.LANAS@USACH.CL    \N  166078482   \N  \N  \N
MARCELO MADARIAGA MORENO    MARCELO.MADARIAGAM@USACH.CL \N  169033285   \N  \N  \N
DANIEL IGNACIO  QUINTEROS CÉSPEDES  DANIEL.QUINTEROSC@USACH.CL  \N  174276471   \N  \N  \N
PATRICIO ENRIQUE    TOLEDO CHAMORRO PATRICIO.TOLEDO@USACH.CL    \N  170865510   \N  \N  \N
FRANCISCO JAVIER    ABARZA RIFFO    MAILTO:FABARZAR@GMAIL.COM   \N  160080280   \N  \N  \N
MAURICIO ADOLFO ACEVEDO RUBIO   MAURICIO.ACEVEDO@USACH.CL   \N  128712135   \N  \N  \N
VALERIA ANDREA  ASENCIO CUELLAR VALERIA.ASENCIO@USACH.CL    \N  176303034   \N  \N  \N
GONZALO BARRA RIVAS GONZALO.BARRA@USACH.CL  \N  171893798   \N  \N  \N
CRISTIAN    BASTIAS INOSTROZA   CRISTIAN.BASTIAS@GMAIL.COM      130727859   \N  \N  \N
VITTORIO    BERTOLINI ONOFRI    VBERTOLINI@GMAIL.COM    \N  166070201   \N  \N  \N
CAIO FERNANDO   BEZARES MACHADO CAIO.BEZARES@USACH.CL   \N  179475634   \N  \N  \N
DIEGO   CADIZ PAU   DIEGO.CADIZ@USACH.CL    \N  160170166   \N  \N  \N
ANTONIO FIGUEROA SEPULVEDA  ANTONIO.FIGUES@GMAIL.COM    \N  181652497   \N  \N  \N
ALVARO FELIPE   FLORES JIMÉNEZ  MAILTO:AFFLORES@GMAIL.COM   \N  159172090   \N  \N  \N
DIEGO ANTONIO   FLORES SALDAÑO  DIEGOX.LIGHT@GMAIL.COM  \N  158422867   \N  \N  \N
MARIO ANTONIO   GACITÚA LÓPEZ   MAILTO:MARIO.GACITUA.L@GMAIL.COM    \N  169215219   \N  \N  \N
RICARDO GUASCH ZUÑIGA   RGUASCH@GMAIL.COM   \N  153811229   \N  \N  \N
MAXIMILIANO HERN�?NDEZ SAN MART�?N    MAXIMILIANO.HERNANDEZ@USACH.CL  \N  183017578   \N  \N  \N
JULIO ENRIQUE   HINOJOSA GALINDO    KJULIO.HINOJOSA@USACH.CL    \N  174746761   \N  \N  \N
FRANCISCO JAVIER    IBACACHE MUÑOZ  MAILTO:FRANCISCO.IBACACHE.MUNOZ@GMAIL.COM   \N  159598373   \N  \N  \N
RODRIGO AN�?BAL  JARA CARTAGENA  RODRIGO.JARA@USACH.CL   \N  165581555   \N  \N  \N
JORGE ALFREDO   LIZAMA GALARCE  MAILTO:JORGE.LIZAMAG@GMAIL.COM  \N  167959008   \N  \N  \N
CRISTIAN IGNACIO    LOYOLA VALDIVIA CRISTIAN.LOYOLA@USACH.CL    \N  180977104   \N  \N  \N
MARCELO ALEJANDRO   MEIXNER BEJAR   MAILTO:MARCELO.MEIXNER@USACH.CL \N  161365475   \N  \N  \N
SEBASTI�?N LEONARDO  MIRANDA OSORIO  MAILTO:SEBASTIAN.MIRANDAO@USACH.CL  \N  164120538   \N  \N  \N
MAXIMILIANO PABLO   PALERMO MAXIMILIANO.PALERMO@USACH.CL    \N  145981859   \N  \N  \N
SEBASTI�?N ALEJANDRO PARADA RAMOS    MAILTO:SEBASTIAN.PARADA@GMAIL.COM   \N  160186801   \N  \N  \N
IGNACIO PEÑA SEPULVEDA  IGNACIO.PENA87GMAIL.COM \N  166579643   \N  \N  \N
MACARENA    PÉREZ SEPÚLVEDA MACARENA.PEREZ@USACH.CL \N  172717144   \N  \N  \N
SEBASTI�?N   QUEZADA  GONZ�?LEZ   MAILTO:SEBASTIAN.QUEZADAG@USACH.CL  \N  166156971   \N  \N  \N
PEDRO PAULO QUIROZ ARAYA            153480389   \N  \N  \N
VICTOR ROLANDO  RAMOS BENITO    MAILTO:VICTORRAMOSB@GMAIL.COM   \N  164740773   \N  \N  \N
SERGIO  RAMOS COSSIO    SRAMOS.USACH@YAHOO.COM      114651214   \N  \N  \N
CARLOS ROGRIGO  REY BARRA   MAILTO:CARLOS.REYB@USACH.CL \N  173771955   \N  \N  \N
IV�?N    RIQUELME GAMONAL    IGAMONAL@HOTMAIL.COM        092174379   \N  \N  \N
MIGUEL ANGEL    SALAZAR LÓPEZ   MIGUEL.SALAZAR.LOPEZ@GMAIL.COM  \N  166166454   \N  \N  \N
CAMILO IGNACIO  SOTO C�?CERES    CAMILO.SOTO@USACH.CL    \N  169428166   \N  \N  \N
GUSTAVO ARTURO  SOTO CERNA  GUSTAVO.SOTO@USACH.CL   \N  158207664   \N  \N  \N
DIEGO   SOTO JARA   DIEGO.FRIEDMAN@GMAIL.COM    \N  15366708K   \N  \N  \N
SERGIO ANDRÉS   VALENZUELA PÉREZ    MAILTO:SERGIO.VALENZUELAP@GMAIL.COM \N  163905140   \N  \N  \N
MACARENA SOLEDAD    VERGARA CONCHA  MAILTO:MACARENA.VERGARA@USACH.CL    \N  171100062   \N  \N  \N
NICOL�?S ALFREDO ACEVEDO URZÚA   NICOLAS.ACEVEDOU@USACH.CL   \N  173196474   \N  \N  \N
�?LVARO  FELMER PIZARRO          17919998k   \N  \N  \N
ADRI�?N  GARRIDO GOICOVIC    27892430    \N  181724315   \N  \N  \N
SEBASTI�?N   ESCOBAR TRONCOSO    86517264    \N  180628754   \N  \N  \N
EDUARDO  PEÑA ANDRADES  63366169    \N  17962091K   \N  \N  \N
WALESKA ANDREA  CARREÑO ARANDA  ASD@ASD.CL      176744650       \N  \N
GLEN ENRIQUE    CIFUENTES TOR   GLEN.CIFUENTES@GMAIL.COM        167110614       \N  \N
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
1   HÉCTOR ANTILLANCA ESPINA    1
2   GONZALO ACUÑA LEIVA 1
3   MAX CHACÓN PACHECO  1
4   FERNANDO CONTRERAS BOTTO    1
5   ROBERTO GONZALÉZ IB�?ÑEZ     1
6   NICOL�?S HIDALGO CASTILLO    1
7   MARIO INOSTROZA PONTA   1
8   JL JARA     1
9   ERIKA ROSAS OLIVOS  1
10  EDMUNDO LEIVA LOBOS 1
11  MAURICIO MAR�?N CAIHU�?N  1
12  ROSA MUÑOZ CALANCHIE    1
13  V�?CTOR PARADA DAZA  1
14  FERNANDO RANNOU FUENTES 1
15  MÓNICA VILLANUEVA ILUFI 1
16  CAROLINA BONACIC CASTRO 1
17  SERGIO A. VELASTIN  1
18  CEII    3
19  GNU USACH   3
20  CITIAPS 5
21  EQUIFAX 2
\.


--
-- Data for Name: carrera; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY carrera (id, nombre) FROM stdin;
1   INGENIER�?A CIVIL INFORM�?TICA
2   INGENIER�?A  EN EJECUCIÓN INFORM�?TICA
\.


--
-- Data for Name: categoriaaevento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categoriaaevento (idcategoria, nombrecategoria) FROM stdin;
1   Académico Jornada Completa
2   Empresa
3   Grupo de Interes
4   Egresado
5   Unidad Universitaria
\.


--
-- Data for Name: checklist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY checklist (id, aceptado, encuesta_id, asignatura_id) FROM stdin;
\.


--
-- Data for Name: checklisteventos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY checklisteventos (idchecklist, calendario, confimacion_inscritos, cupos, evento_facebook, evento_twitter, expositor, facebook, fecha, fotos_evento, invitacion_internos, linkedin, lugar, noticia_web_diinf, pagina, redactar_noticia, registrar_otros_medios, resena, spam_objetivo, spam_usach, titulo, twitter, web) FROM stdin;
\.


--
-- Data for Name: comision_correctora; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comision_correctora (id_correctora, id_semestre, id_tema, fecha_correccion, fecha_entrega_correccion, fecha_entrega_correccion2, fecha_correccion2) FROM stdin;
1   default 1   \N  \N  \N  \N
2   default 2   \N  \N  \N  \N
4   default 6   \N  \N  \N  \N
5   default 8   \N  \N  \N  \N
6   default 11  \N  \N  \N  \N
7   default 12  \N  \N  \N  \N
8   default 13  \N  \N  \N  \N
9   default 16  \N  \N  \N  \N
10  default 22  \N  \N  \N  \N
11  default 23  \N  \N  \N  \N
12  default 24  \N  \N  \N  \N
13  default 26  \N  \N  \N  \N
14  default 31  \N  \N  \N  \N
15  default 34  \N  \N  \N  \N
16  default 37  \N  \N  \N  \N
17  default 39  \N  \N  \N  \N
18  default 42  \N  \N  \N  \N
19  default 43  \N  \N  \N  \N
20  default 54  \N  \N  \N  \N
21  default 57  \N  \N  \N  \N
22  default 59  \N  \N  \N  \N
23  default 67  \N  \N  \N  \N
24  default 74  \N  \N  \N  \N
25  default 75  \N  \N  \N  \N
26  default 77  \N  \N  \N  \N
27  default 79  \N  \N  \N  \N
28  default 80  \N  \N  \N  \N
29  default 81  \N  \N  \N  \N
30  default 82  \N  \N  \N  \N
31  default 84  \N  \N  \N  \N
32  default 87  \N  \N  \N  \N
33  default 88  \N  \N  \N  \N
34  default 89  \N  \N  \N  \N
35  default 93  \N  \N  \N  \N
36  default 94  \N  \N  \N  \N
37  default 95  \N  \N  \N  \N
38  default 96  \N  \N  \N  \N
39  default 97  \N  \N  \N  \N
40  default 102 \N  \N  \N  \N
41  default 103 \N  \N  \N  \N
42  default 105 \N  \N  \N  \N
43  default 107 \N  \N  \N  \N
44  default 110 \N  \N  \N  \N
45  default 112 \N  \N  \N  \N
46  default 113 \N  \N  \N  \N
47  default 117 \N  \N  \N  \N
48  default 118 \N  \N  \N  \N
49  default 120 \N  \N  \N  \N
50  default 126 \N  \N  \N  \N
51  default 128 \N  \N  \N  \N
52  default 131 \N  \N  \N  \N
53  default 136 \N  \N  \N  \N
54  default 139 \N  \N  \N  \N
55  default 140 \N  \N  \N  \N
56  default 141 \N  \N  \N  \N
57  default 142 \N  \N  \N  \N
58  default 144 \N  \N  \N  \N
59  default 145 \N  \N  \N  \N
60  default 146 \N  \N  \N  \N
61  default 147 \N  \N  \N  \N
62  default 152 \N  \N  \N  \N
63  default 154 \N  \N  \N  \N
64  default 155 \N  \N  \N  \N
65  default 157 \N  \N  \N  \N
66  default 159 \N  \N  \N  \N
67  default 160 \N  \N  \N  \N
68  default 162 \N  \N  \N  \N
69  default 165 \N  \N  \N  \N
70  default 169 \N  \N  \N  \N
71  default 170 \N  \N  \N  \N
72  default 171 \N  \N  \N  \N
73  default 172 \N  \N  \N  \N
74  default 174 \N  \N  \N  \N
75  default 175 \N  \N  \N  \N
76  default 176 \N  \N  \N  \N
77  default 178 \N  \N  \N  \N
78  default 179 \N  \N  \N  \N
79  default 182 \N  \N  \N  \N
80  default 183 \N  \N  \N  \N
81  default 185 \N  \N  \N  \N
82  default 197 \N  \N  \N  \N
83  default 200 \N  \N  \N  \N
84  default 203 \N  \N  \N  \N
85  default 204 \N  \N  \N  \N
86  default 205 \N  \N  \N  \N
87  default 206 \N  \N  \N  \N
88  default 209 \N  \N  \N  \N
89  default 210 \N  \N  \N  \N
90  default 215 \N  \N  \N  \N
91  default 216 \N  \N  \N  \N
92  default 219 \N  \N  \N  \N
93  default 221 \N  \N  \N  \N
94  default 223 \N  \N  \N  \N
95  default 229 \N  \N  \N  \N
96  default 230 \N  \N  \N  \N
97  default 231 \N  \N  \N  \N
98  default 232 \N  \N  \N  \N
99  default 234 \N  \N  \N  \N
100 default 241 \N  \N  \N  \N
101 default 243 \N  \N  \N  \N
102 default 244 \N  \N  \N  \N
103 default 248 \N  \N  \N  \N
104 default 249 \N  \N  \N  \N
105 default 251 \N  \N  \N  \N
106 default 252 \N  \N  \N  \N
107 default 253 \N  \N  \N  \N
108 default 255 \N  \N  \N  \N
109 default 257 \N  \N  \N  \N
110 default 260 \N  \N  \N  \N
111 default 261 \N  \N  \N  \N
112 default 263 \N  \N  \N  \N
113 default 268 \N  \N  \N  \N
114 default 269 \N  \N  \N  \N
115 default 276 \N  \N  \N  \N
116 default 277 \N  \N  \N  \N
117 default 278 \N  \N  \N  \N
118 default 279 \N  \N  \N  \N
119 default 280 \N  \N  \N  \N
120 default 281 \N  \N  \N  \N
121 default 292 \N  \N  \N  \N
122 default 297 \N  \N  \N  \N
123 default 298 \N  \N  \N  \N
124 default 311 \N  \N  \N  \N
125 default 319 \N  \N  \N  \N
126 default 321 \N  \N  \N  \N
127 default 322 \N  \N  \N  \N
128 default 323 \N  \N  \N  \N
129 default 324 \N  \N  \N  \N
130 default 329 \N  \N  \N  \N
131 default 330 \N  \N  \N  \N
132 default 331 \N  \N  \N  \N
133 default 332 \N  \N  \N  \N
134 default 333 \N  \N  \N  \N
135 default 334 \N  \N  \N  \N
136 default 335 \N  \N  \N  \N
137 default 341 \N  \N  \N  \N
138 default 342 \N  \N  \N  \N
139 default 343 \N  \N  \N  \N
140 default 344 \N  \N  \N  \N
141 default 346 \N  \N  \N  \N
142 default 348 \N  \N  \N  \N
143 default 349 \N  \N  \N  \N
144 default 351 \N  \N  \N  \N
145 default 353 \N  \N  \N  \N
146 default 358 \N  \N  \N  \N
147 default 360 \N  \N  \N  \N
148 default 362 \N  \N  \N  \N
149 default 365 \N  \N  \N  \N
150 default 366 \N  \N  \N  \N
151 default 367 \N  \N  \N  \N
152 default 369 \N  \N  \N  \N
153 default 372 \N  \N  \N  \N
154 default 373 \N  \N  \N  \N
155 default 374 \N  \N  \N  \N
156 default 376 \N  \N  \N  \N
157 default 377 \N  \N  \N  \N
158 default 378 \N  \N  \N  \N
159 default 379 \N  \N  \N  \N
160 default 380 \N  \N  \N  \N
161 default 383 \N  \N  \N  \N
162 default 384 \N  \N  \N  \N
163 default 385 \N  \N  \N  \N
164 default 386 \N  \N  \N  \N
165 default 387 \N  \N  \N  \N
166 default 389 \N  \N  \N  \N
167 default 390 \N  \N  \N  \N
168 default 401 \N  \N  \N  \N
169 default 402 \N  \N  \N  \N
170 default 403 \N  \N  \N  \N
171 default 404 \N  \N  \N  \N
172 default 406 \N  \N  \N  \N
173 default 409 \N  \N  \N  \N
174 default 411 \N  \N  \N  \N
175 default 413 \N  \N  \N  \N
176 default 415 \N  \N  \N  \N
177 default 416 \N  \N  \N  \N
178 default 420 \N  \N  \N  \N
179 default 422 \N  \N  \N  \N
180 default 441 \N  \N  \N  \N
181 default 443 \N  \N  \N  \N
182 default 444 \N  \N  \N  \N
183 default 452 \N  \N  \N  \N
184 default 453 \N  \N  \N  \N
185 default 457 \N  \N  \N  \N
186 default 458 \N  \N  \N  \N
187 default 462 \N  \N  \N  \N
188 default 465 \N  \N  \N  \N
189 default 466 \N  \N  \N  \N
190 default 467 \N  \N  \N  \N
191 default 470 \N  \N  \N  \N
192 default 475 \N  \N  \N  \N
193 default 476 \N  \N  \N  \N
194 default 479 \N  \N  \N  \N
195 default 486 \N  \N  \N  \N
196 default 487 \N  \N  \N  \N
197 default 494 \N  \N  \N  \N
198 default 496 \N  \N  \N  \N
199 default 498 \N  \N  \N  \N
200 default 504 \N  \N  \N  \N
201 default 505 \N  \N  \N  \N
202 default 506 \N  \N  \N  \N
203 default 507 \N  \N  \N  \N
204 default 509 \N  \N  \N  \N
205 default 510 \N  \N  \N  \N
206 default 512 \N  \N  \N  \N
207 default 513 \N  \N  \N  \N
208 default 515 \N  \N  \N  \N
209 default 516 \N  \N  \N  \N
210 default 519 \N  \N  \N  \N
211 default 533 \N  \N  \N  \N
212 default 538 \N  \N  \N  \N
213 default 539 \N  \N  \N  \N
214 default 540 \N  \N  \N  \N
215 default 541 \N  \N  \N  \N
216 default 545 \N  \N  \N  \N
217 default 546 \N  \N  \N  \N
218 default 550 \N  \N  \N  \N
219 default 554 \N  \N  \N  \N
220 default 558 \N  \N  \N  \N
221 default 559 \N  \N  \N  \N
222 default 561 \N  \N  \N  \N
223 default 562 \N  \N  \N  \N
224 default 563 \N  \N  \N  \N
225 default 566 \N  \N  \N  \N
226 default 567 \N  \N  \N  \N
227 default 568 \N  \N  \N  \N
228 default 572 \N  \N  \N  \N
229 default 574 \N  \N  \N  \N
230 default 576 \N  \N  \N  \N
231 default 581 \N  \N  \N  \N
232 default 583 \N  \N  \N  \N
235 1/2016  592 26/05/2015  \N  \N  \N
236 1/2016  593 27/05/2015  28/05/2015  \N  \N
237 1/2016  594 15/05/2015  16/05/2015  \N  \N
238 1/2016  596 28/05/2015  29/05/2015  \N  \N
239 1/2016  595 15/05/2015  16/05/2015  \N  \N
240 1/2016  598 20/05/2015  20/05/2015  28/05/2015  28/05/2015
3   default 5   20/05/2015  21/05/2015  21/05/2015  20/05/2015
233 1/2016  7   12/05/2015  20/05/2015  28/05/2015  27/05/2015
242 1/2016  597 08/06/2015  17/06/2015  10/06/2015  08/06/2015
\.


--
-- Name: comision_correctora_id_correctora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comision_correctora_id_correctora_seq', 242, true);


--
-- Data for Name: comision_revisora; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comision_revisora (fecha_revision, tipo_revision, id_revisora, id_propuesta, id_semestre, id_tema, fecha_entrega_revision, fecha_revision2, fecha_entrega_revision2, fecha_publicacion_consejo, fecha_termino_publicacion_consejo) FROM stdin;
    \N  1   1   default 1   \N  \N  \N  \N  \N
    1   122 123 default 122 \N  \N  \N  \N  \N
    1   2   2   default 2   \N  \N  \N  \N  \N
    1   3   3   default 3   \N  \N  \N  \N  \N
    1   123 124 default 123 \N  \N  \N  \N  \N
    1   4   4   default 4   \N  \N  \N  \N  \N
    1   5   5   default 5   \N  \N  \N  \N  \N
    \N  124 125 default 124 \N  \N  \N  \N  \N
    0   6   6   default 6   \N  \N  \N  \N  \N
    1   7   7   default 7   \N  \N  \N  \N  \N
    \N  125 126 default 125 \N  \N  \N  \N  \N
    1   8   8   default 8   \N  \N  \N  \N  \N
    1   9   9   default 9   \N  \N  \N  \N  \N
    1   126 127 default 126 \N  \N  \N  \N  \N
    \N  10  10  default 10  \N  \N  \N  \N  \N
    0   11  11  default 11  \N  \N  \N  \N  \N
    1   127 128 default 127 \N  \N  \N  \N  \N
    1   12  12  default 12  \N  \N  \N  \N  \N
    0   13  13  default 13  \N  \N  \N  \N  \N
    \N  128 129 default 128 \N  \N  \N  \N  \N
    \N  14  14  default 14  \N  \N  \N  \N  \N
    \N  15  15  default 15  \N  \N  \N  \N  \N
    1   129 130 default 129 \N  \N  \N  \N  \N
    \N  16  16  default 16  \N  \N  \N  \N  \N
    \N  17  17  default 17  \N  \N  \N  \N  \N
    1   18  18  default 18  \N  \N  \N  \N  \N
    1   19  19  default 19  \N  \N  \N  \N  \N
    \N  20  20  default 20  \N  \N  \N  \N  \N
    0   21  21  default 21  \N  \N  \N  \N  \N
    \N  22  22  default 22  \N  \N  \N  \N  \N
    1   23  23  default 23  \N  \N  \N  \N  \N
    1   24  24  default 24  \N  \N  \N  \N  \N
    1   25  25  default 25  \N  \N  \N  \N  \N
    0   26  26  default 26  \N  \N  \N  \N  \N
    1   27  27  default 27  \N  \N  \N  \N  \N
    1   28  28  default 28  \N  \N  \N  \N  \N
    1   29  29  default 29  \N  \N  \N  \N  \N
    0   30  30  default 30  \N  \N  \N  \N  \N
    1   31  31  default 31  \N  \N  \N  \N  \N
    1   32  32  default 32  \N  \N  \N  \N  \N
    1   33  33  default 33  \N  \N  \N  \N  \N
    \N  34  34  default 34  \N  \N  \N  \N  \N
    1   35  35  default 35  \N  \N  \N  \N  \N
    1   36  36  default 36  \N  \N  \N  \N  \N
    0   37  37  default 37  \N  \N  \N  \N  \N
    1   38  38  default 38  \N  \N  \N  \N  \N
    0   39  39  default 39  \N  \N  \N  \N  \N
    1   40  40  default 40  \N  \N  \N  \N  \N
    1   41  41  default 41  \N  \N  \N  \N  \N
    1   42  42  default 42  \N  \N  \N  \N  \N
    1   43  43  default 43  \N  \N  \N  \N  \N
    1   44  44  default 44  \N  \N  \N  \N  \N
    1   45  45  default 45  \N  \N  \N  \N  \N
    1   46  46  default 46  \N  \N  \N  \N  \N
    1   47  47  default 47  \N  \N  \N  \N  \N
    1   48  48  default 48  \N  \N  \N  \N  \N
    1   49  49  default 49  \N  \N  \N  \N  \N
    1   50  50  default 50  \N  \N  \N  \N  \N
    1   51  51  default 51  \N  \N  \N  \N  \N
    1   52  52  default 52  \N  \N  \N  \N  \N
    1   53  53  default 53  \N  \N  \N  \N  \N
    0   54  54  default 54  \N  \N  \N  \N  \N
    \N  55  55  default 55  \N  \N  \N  \N  \N
    1   56  56  default 56  \N  \N  \N  \N  \N
    \N  57  57  default 57  \N  \N  \N  \N  \N
    1   58  58  default 58  \N  \N  \N  \N  \N
    1   59  59  default 59  \N  \N  \N  \N  \N
    1   60  60  default 60  \N  \N  \N  \N  \N
    1   61  61  default 61  \N  \N  \N  \N  \N
    1   62  63  default 62  \N  \N  \N  \N  \N
    0   63  64  default 63  \N  \N  \N  \N  \N
    1   64  65  default 64  \N  \N  \N  \N  \N
    1   65  66  default 65  \N  \N  \N  \N  \N
    0   66  67  default 66  \N  \N  \N  \N  \N
    1   67  68  default 67  \N  \N  \N  \N  \N
    1   68  69  default 68  \N  \N  \N  \N  \N
    1   69  70  default 69  \N  \N  \N  \N  \N
    1   70  71  default 70  \N  \N  \N  \N  \N
    0   71  72  default 71  \N  \N  \N  \N  \N
    0   72  73  default 72  \N  \N  \N  \N  \N
    0   73  74  default 73  \N  \N  \N  \N  \N
    1   74  75  default 74  \N  \N  \N  \N  \N
    1   75  76  default 75  \N  \N  \N  \N  \N
    0   76  77  default 76  \N  \N  \N  \N  \N
    0   77  78  default 77  \N  \N  \N  \N  \N
    1   78  79  default 78  \N  \N  \N  \N  \N
    0   79  80  default 79  \N  \N  \N  \N  \N
    0   80  81  default 80  \N  \N  \N  \N  \N
    0   81  82  default 81  \N  \N  \N  \N  \N
    0   82  83  default 82  \N  \N  \N  \N  \N
    1   83  84  default 83  \N  \N  \N  \N  \N
    1   84  85  default 84  \N  \N  \N  \N  \N
    1   85  86  default 85  \N  \N  \N  \N  \N
    0   86  87  default 86  \N  \N  \N  \N  \N
    0   87  88  default 87  \N  \N  \N  \N  \N
    1   88  89  default 88  \N  \N  \N  \N  \N
    1   89  90  default 89  \N  \N  \N  \N  \N
    1   90  91  default 90  \N  \N  \N  \N  \N
    0   91  92  default 91  \N  \N  \N  \N  \N
    0   92  93  default 92  \N  \N  \N  \N  \N
    1   93  94  default 93  \N  \N  \N  \N  \N
    1   94  95  default 94  \N  \N  \N  \N  \N
    1   95  96  default 95  \N  \N  \N  \N  \N
    0   96  97  default 96  \N  \N  \N  \N  \N
    1   97  98  default 97  \N  \N  \N  \N  \N
    1   98  99  default 98  \N  \N  \N  \N  \N
    1   99  100 default 99  \N  \N  \N  \N  \N
    1   100 101 default 100 \N  \N  \N  \N  \N
    \N  101 102 default 101 \N  \N  \N  \N  \N
    1   102 103 default 102 \N  \N  \N  \N  \N
    1   103 104 default 103 \N  \N  \N  \N  \N
    1   104 105 default 104 \N  \N  \N  \N  \N
    1   105 106 default 105 \N  \N  \N  \N  \N
    0   106 107 default 106 \N  \N  \N  \N  \N
    1   107 108 default 107 \N  \N  \N  \N  \N
    1   108 109 default 108 \N  \N  \N  \N  \N
    1   109 110 default 109 \N  \N  \N  \N  \N
    1   110 111 default 110 \N  \N  \N  \N  \N
    0   111 112 default 111 \N  \N  \N  \N  \N
    1   112 113 default 112 \N  \N  \N  \N  \N
    0   113 114 default 113 \N  \N  \N  \N  \N
    0   114 115 default 114 \N  \N  \N  \N  \N
    0   115 116 default 115 \N  \N  \N  \N  \N
    1   116 117 default 116 \N  \N  \N  \N  \N
    0   117 118 default 117 \N  \N  \N  \N  \N
    0   118 119 default 118 \N  \N  \N  \N  \N
    1   119 120 default 119 \N  \N  \N  \N  \N
    1   120 121 default 120 \N  \N  \N  \N  \N
    1   121 122 default 121 \N  \N  \N  \N  \N
    1   130 131 default 130 \N  \N  \N  \N  \N
    1   131 132 default 131 \N  \N  \N  \N  \N
    1   132 133 default 132 \N  \N  \N  \N  \N
    1   133 134 default 133 \N  \N  \N  \N  \N
    1   134 135 default 134 \N  \N  \N  \N  \N
    1   135 136 default 135 \N  \N  \N  \N  \N
    1   136 137 default 136 \N  \N  \N  \N  \N
    1   137 138 default 137 \N  \N  \N  \N  \N
    1   138 139 default 138 \N  \N  \N  \N  \N
    1   139 140 default 139 \N  \N  \N  \N  \N
    1   140 141 default 140 \N  \N  \N  \N  \N
    1   141 142 default 141 \N  \N  \N  \N  \N
    1   142 143 default 142 \N  \N  \N  \N  \N
    1   143 144 default 143 \N  \N  \N  \N  \N
    \N  144 145 default 144 \N  \N  \N  \N  \N
    \N  145 146 default 145 \N  \N  \N  \N  \N
    \N  146 147 default 146 \N  \N  \N  \N  \N
    1   147 148 default 147 \N  \N  \N  \N  \N
    1   148 149 default 148 \N  \N  \N  \N  \N
    1   149 150 default 149 \N  \N  \N  \N  \N
    1   150 151 default 150 \N  \N  \N  \N  \N
    1   151 152 default 151 \N  \N  \N  \N  \N
    1   152 153 default 152 \N  \N  \N  \N  \N
    1   153 154 default 153 \N  \N  \N  \N  \N
    0   154 155 default 154 \N  \N  \N  \N  \N
    1   155 156 default 155 \N  \N  \N  \N  \N
    1   156 157 default 156 \N  \N  \N  \N  \N
    1   157 158 default 157 \N  \N  \N  \N  \N
    1   158 159 default 158 \N  \N  \N  \N  \N
    1   159 160 default 159 \N  \N  \N  \N  \N
    0   160 161 default 160 \N  \N  \N  \N  \N
    1   161 162 default 161 \N  \N  \N  \N  \N
    1   162 163 default 162 \N  \N  \N  \N  \N
    1   163 164 default 163 \N  \N  \N  \N  \N
    1   164 165 default 164 \N  \N  \N  \N  \N
    0   165 166 default 165 \N  \N  \N  \N  \N
    1   166 167 default 166 \N  \N  \N  \N  \N
    1   167 168 default 167 \N  \N  \N  \N  \N
    1   168 169 default 168 \N  \N  \N  \N  \N
    1   169 170 default 169 \N  \N  \N  \N  \N
    1   170 171 default 170 \N  \N  \N  \N  \N
    0   171 172 default 171 \N  \N  \N  \N  \N
    1   172 173 default 172 \N  \N  \N  \N  \N
    1   173 174 default 173 \N  \N  \N  \N  \N
    0   174 175 default 174 \N  \N  \N  \N  \N
    1   175 176 default 175 \N  \N  \N  \N  \N
    1   176 177 default 176 \N  \N  \N  \N  \N
    1   177 178 default 177 \N  \N  \N  \N  \N
    1   178 179 default 178 \N  \N  \N  \N  \N
    1   179 180 default 179 \N  \N  \N  \N  \N
    0   180 181 default 180 \N  \N  \N  \N  \N
    1   181 182 default 181 \N  \N  \N  \N  \N
    0   182 183 default 182 \N  \N  \N  \N  \N
    0   183 184 default 183 \N  \N  \N  \N  \N
    1   184 185 default 184 \N  \N  \N  \N  \N
    \N  185 186 default 185 \N  \N  \N  \N  \N
    1   186 187 default 186 \N  \N  \N  \N  \N
    1   187 188 default 187 \N  \N  \N  \N  \N
    0   188 189 default 188 \N  \N  \N  \N  \N
    1   189 190 default 189 \N  \N  \N  \N  \N
    1   190 191 default 190 \N  \N  \N  \N  \N
    0   191 192 default 191 \N  \N  \N  \N  \N
    1   192 193 default 192 \N  \N  \N  \N  \N
    1   193 194 default 193 \N  \N  \N  \N  \N
    1   194 195 default 194 \N  \N  \N  \N  \N
    \N  195 196 default 195 \N  \N  \N  \N  \N
    0   196 197 default 196 \N  \N  \N  \N  \N
    1   197 198 default 197 \N  \N  \N  \N  \N
    1   198 199 default 198 \N  \N  \N  \N  \N
    1   199 200 default 199 \N  \N  \N  \N  \N
    1   200 201 default 200 \N  \N  \N  \N  \N
    1   201 202 default 201 \N  \N  \N  \N  \N
    1   202 203 default 202 \N  \N  \N  \N  \N
    \N  203 204 default 203 \N  \N  \N  \N  \N
    0   204 205 default 204 \N  \N  \N  \N  \N
    0   205 206 default 205 \N  \N  \N  \N  \N
    0   206 207 default 206 \N  \N  \N  \N  \N
    0   207 208 default 207 \N  \N  \N  \N  \N
    1   208 209 default 208 \N  \N  \N  \N  \N
    0   209 210 default 209 \N  \N  \N  \N  \N
    0   210 211 default 210 \N  \N  \N  \N  \N
    0   211 212 default 211 \N  \N  \N  \N  \N
    0   212 213 default 212 \N  \N  \N  \N  \N
    0   213 214 default 213 \N  \N  \N  \N  \N
    1   214 215 default 214 \N  \N  \N  \N  \N
    0   215 216 default 215 \N  \N  \N  \N  \N
    0   216 217 default 216 \N  \N  \N  \N  \N
    0   217 218 default 217 \N  \N  \N  \N  \N
    \N  218 219 default 218 \N  \N  \N  \N  \N
    0   219 220 default 219 \N  \N  \N  \N  \N
    1   220 221 default 220 \N  \N  \N  \N  \N
    0   221 222 default 221 \N  \N  \N  \N  \N
    1   222 223 default 222 \N  \N  \N  \N  \N
    1   223 224 default 223 \N  \N  \N  \N  \N
    1   224 225 default 224 \N  \N  \N  \N  \N
    0   225 226 default 225 \N  \N  \N  \N  \N
    0   226 227 default 226 \N  \N  \N  \N  \N
    1   227 228 default 227 \N  \N  \N  \N  \N
    1   228 229 default 228 \N  \N  \N  \N  \N
    0   229 230 default 229 \N  \N  \N  \N  \N
    0   230 231 default 230 \N  \N  \N  \N  \N
    1   231 232 default 231 \N  \N  \N  \N  \N
    1   232 233 default 232 \N  \N  \N  \N  \N
    1   233 234 default 233 \N  \N  \N  \N  \N
    0   234 235 default 234 \N  \N  \N  \N  \N
    0   235 236 default 235 \N  \N  \N  \N  \N
    1   236 237 default 236 \N  \N  \N  \N  \N
    1   237 238 default 237 \N  \N  \N  \N  \N
    \N  238 239 default 238 \N  \N  \N  \N  \N
    1   239 240 default 239 \N  \N  \N  \N  \N
    0   240 241 default 240 \N  \N  \N  \N  \N
    \N  241 242 default 241 \N  \N  \N  \N  \N
    \N  242 243 default 242 \N  \N  \N  \N  \N
    0   243 244 default 243 \N  \N  \N  \N  \N
    1   244 245 default 244 \N  \N  \N  \N  \N
    0   245 246 default 245 \N  \N  \N  \N  \N
    \N  246 247 default 246 \N  \N  \N  \N  \N
    0   247 248 default 247 \N  \N  \N  \N  \N
    1   248 249 default 248 \N  \N  \N  \N  \N
    0   249 250 default 249 \N  \N  \N  \N  \N
    1   250 251 default 250 \N  \N  \N  \N  \N
    1   251 252 default 251 \N  \N  \N  \N  \N
    1   252 253 default 252 \N  \N  \N  \N  \N
    1   253 254 default 253 \N  \N  \N  \N  \N
    1   254 255 default 254 \N  \N  \N  \N  \N
    \N  255 256 default 255 \N  \N  \N  \N  \N
    1   256 257 default 256 \N  \N  \N  \N  \N
    0   257 258 default 257 \N  \N  \N  \N  \N
    0   258 259 default 258 \N  \N  \N  \N  \N
    \N  259 260 default 259 \N  \N  \N  \N  \N
    1   260 261 default 260 \N  \N  \N  \N  \N
    1   261 262 default 261 \N  \N  \N  \N  \N
    1   262 263 default 262 \N  \N  \N  \N  \N
    0   263 264 default 263 \N  \N  \N  \N  \N
    0   264 265 default 264 \N  \N  \N  \N  \N
    1   265 266 default 265 \N  \N  \N  \N  \N
    1   266 267 default 266 \N  \N  \N  \N  \N
    1   267 268 default 267 \N  \N  \N  \N  \N
    1   268 269 default 268 \N  \N  \N  \N  \N
    1   269 270 default 269 \N  \N  \N  \N  \N
    1   270 271 default 270 \N  \N  \N  \N  \N
    1   271 272 default 271 \N  \N  \N  \N  \N
    0   272 273 default 272 \N  \N  \N  \N  \N
    0   273 274 default 273 \N  \N  \N  \N  \N
    1   274 275 default 274 \N  \N  \N  \N  \N
    1   275 276 default 275 \N  \N  \N  \N  \N
    0   276 277 default 276 \N  \N  \N  \N  \N
    0   277 278 default 277 \N  \N  \N  \N  \N
    0   278 279 default 278 \N  \N  \N  \N  \N
    1   279 280 default 279 \N  \N  \N  \N  \N
    0   280 281 default 280 \N  \N  \N  \N  \N
    0   281 282 default 281 \N  \N  \N  \N  \N
    1   282 283 default 282 \N  \N  \N  \N  \N
    1   283 284 default 283 \N  \N  \N  \N  \N
    0   284 285 default 284 \N  \N  \N  \N  \N
    1   285 286 default 285 \N  \N  \N  \N  \N
    1   286 287 default 286 \N  \N  \N  \N  \N
    0   287 288 default 287 \N  \N  \N  \N  \N
    1   288 289 default 288 \N  \N  \N  \N  \N
    1   289 290 default 289 \N  \N  \N  \N  \N
    \N  290 291 default 290 \N  \N  \N  \N  \N
    0   291 292 default 291 \N  \N  \N  \N  \N
    1   292 293 default 292 \N  \N  \N  \N  \N
    1   293 294 default 293 \N  \N  \N  \N  \N
    1   294 295 default 294 \N  \N  \N  \N  \N
    \N  295 296 default 295 \N  \N  \N  \N  \N
    1   296 297 default 296 \N  \N  \N  \N  \N
    0   297 298 default 297 \N  \N  \N  \N  \N
    1   298 299 default 298 \N  \N  \N  \N  \N
    1   299 300 default 299 \N  \N  \N  \N  \N
    0   300 301 default 300 \N  \N  \N  \N  \N
    0   301 302 default 301 \N  \N  \N  \N  \N
    1   302 303 default 302 \N  \N  \N  \N  \N
    0   303 304 default 303 \N  \N  \N  \N  \N
    1   304 305 default 304 \N  \N  \N  \N  \N
    1   305 306 default 305 \N  \N  \N  \N  \N
    1   306 307 default 306 \N  \N  \N  \N  \N
    0   307 308 default 307 \N  \N  \N  \N  \N
    0   308 309 default 308 \N  \N  \N  \N  \N
    0   309 310 default 309 \N  \N  \N  \N  \N
    \N  310 311 default 310 \N  \N  \N  \N  \N
    1   311 312 default 311 \N  \N  \N  \N  \N
    1   312 313 default 312 \N  \N  \N  \N  \N
    1   313 314 default 313 \N  \N  \N  \N  \N
    1   314 315 default 314 \N  \N  \N  \N  \N
    1   315 316 default 315 \N  \N  \N  \N  \N
    1   316 317 default 316 \N  \N  \N  \N  \N
    0   317 318 default 317 \N  \N  \N  \N  \N
    0   318 319 default 318 \N  \N  \N  \N  \N
    \N  319 320 default 319 \N  \N  \N  \N  \N
    1   320 321 default 320 \N  \N  \N  \N  \N
    1   321 322 default 321 \N  \N  \N  \N  \N
    \N  322 323 default 322 \N  \N  \N  \N  \N
    1   323 324 default 323 \N  \N  \N  \N  \N
    1   324 326 default 324 \N  \N  \N  \N  \N
    1   325 327 default 325 \N  \N  \N  \N  \N
    0   326 328 default 326 \N  \N  \N  \N  \N
    1   327 329 default 327 \N  \N  \N  \N  \N
    1   328 330 default 328 \N  \N  \N  \N  \N
    0   329 331 default 329 \N  \N  \N  \N  \N
    1   330 332 default 330 \N  \N  \N  \N  \N
    1   331 333 default 331 \N  \N  \N  \N  \N
    \N  332 334 default 332 \N  \N  \N  \N  \N
    1   333 335 default 333 \N  \N  \N  \N  \N
    1   334 336 default 334 \N  \N  \N  \N  \N
    1   335 337 default 335 \N  \N  \N  \N  \N
    0   336 338 default 336 \N  \N  \N  \N  \N
    1   337 339 default 337 \N  \N  \N  \N  \N
    1   338 340 default 338 \N  \N  \N  \N  \N
    0   339 341 default 339 \N  \N  \N  \N  \N
    1   340 342 default 340 \N  \N  \N  \N  \N
    1   341 343 default 341 \N  \N  \N  \N  \N
    0   342 344 default 342 \N  \N  \N  \N  \N
    \N  343 345 default 343 \N  \N  \N  \N  \N
    0   344 346 default 344 \N  \N  \N  \N  \N
    1   345 347 default 345 \N  \N  \N  \N  \N
    1   346 348 default 346 \N  \N  \N  \N  \N
    1   347 349 default 347 \N  \N  \N  \N  \N
    1   348 350 default 348 \N  \N  \N  \N  \N
    \N  349 351 default 349 \N  \N  \N  \N  \N
    0   350 352 default 350 \N  \N  \N  \N  \N
    0   351 353 default 351 \N  \N  \N  \N  \N
    0   352 354 default 352 \N  \N  \N  \N  \N
    0   353 355 default 353 \N  \N  \N  \N  \N
    1   354 356 default 354 \N  \N  \N  \N  \N
    1   355 357 default 355 \N  \N  \N  \N  \N
    1   356 358 default 356 \N  \N  \N  \N  \N
    0   357 359 default 357 \N  \N  \N  \N  \N
    1   358 360 default 358 \N  \N  \N  \N  \N
    0   359 361 default 359 \N  \N  \N  \N  \N
    1   360 362 default 360 \N  \N  \N  \N  \N
    1   361 363 default 361 \N  \N  \N  \N  \N
    1   362 364 default 362 \N  \N  \N  \N  \N
    1   363 365 default 363 \N  \N  \N  \N  \N
    1   364 366 default 364 \N  \N  \N  \N  \N
    1   365 367 default 365 \N  \N  \N  \N  \N
    0   366 368 default 366 \N  \N  \N  \N  \N
    1   367 369 default 367 \N  \N  \N  \N  \N
    1   368 370 default 368 \N  \N  \N  \N  \N
    1   369 371 default 369 \N  \N  \N  \N  \N
    1   370 372 default 370 \N  \N  \N  \N  \N
    1   371 373 default 371 \N  \N  \N  \N  \N
    1   372 374 default 372 \N  \N  \N  \N  \N
    1   373 375 default 373 \N  \N  \N  \N  \N
    0   374 376 default 374 \N  \N  \N  \N  \N
    1   375 377 default 375 \N  \N  \N  \N  \N
    1   376 378 default 376 \N  \N  \N  \N  \N
    \N  377 379 default 377 \N  \N  \N  \N  \N
    1   378 380 default 378 \N  \N  \N  \N  \N
    1   379 381 default 379 \N  \N  \N  \N  \N
    1   380 382 default 380 \N  \N  \N  \N  \N
    0   381 383 default 381 \N  \N  \N  \N  \N
    0   382 384 default 382 \N  \N  \N  \N  \N
    1   383 385 default 383 \N  \N  \N  \N  \N
    1   384 386 default 384 \N  \N  \N  \N  \N
    1   385 387 default 385 \N  \N  \N  \N  \N
    0   386 388 default 386 \N  \N  \N  \N  \N
    1   387 389 default 387 \N  \N  \N  \N  \N
    \N  388 390 default 388 \N  \N  \N  \N  \N
    1   389 391 default 389 \N  \N  \N  \N  \N
    1   390 392 default 390 \N  \N  \N  \N  \N
    1   391 393 default 391 \N  \N  \N  \N  \N
    0   392 394 default 392 \N  \N  \N  \N  \N
    1   393 395 default 393 \N  \N  \N  \N  \N
    1   394 396 default 394 \N  \N  \N  \N  \N
    1   395 397 default 395 \N  \N  \N  \N  \N
    1   396 398 default 396 \N  \N  \N  \N  \N
    1   397 399 default 397 \N  \N  \N  \N  \N
    1   398 400 default 398 \N  \N  \N  \N  \N
    0   399 401 default 399 \N  \N  \N  \N  \N
    0   400 402 default 400 \N  \N  \N  \N  \N
    0   401 403 default 401 \N  \N  \N  \N  \N
    0   402 404 default 402 \N  \N  \N  \N  \N
    \N  403 405 default 403 \N  \N  \N  \N  \N
    0   404 406 default 404 \N  \N  \N  \N  \N
    0   405 407 default 405 \N  \N  \N  \N  \N
    1   406 408 default 406 \N  \N  \N  \N  \N
    1   407 409 default 407 \N  \N  \N  \N  \N
    1   408 410 default 408 \N  \N  \N  \N  \N
    1   409 411 default 409 \N  \N  \N  \N  \N
    0   410 412 default 410 \N  \N  \N  \N  \N
    0   411 413 default 411 \N  \N  \N  \N  \N
    1   412 414 default 412 \N  \N  \N  \N  \N
    1   413 415 default 413 \N  \N  \N  \N  \N
    0   414 416 default 414 \N  \N  \N  \N  \N
    1   415 417 default 415 \N  \N  \N  \N  \N
    1   416 418 default 416 \N  \N  \N  \N  \N
    1   417 419 default 417 \N  \N  \N  \N  \N
    0   418 420 default 418 \N  \N  \N  \N  \N
    1   419 421 default 419 \N  \N  \N  \N  \N
    1   420 422 default 420 \N  \N  \N  \N  \N
    0   421 423 default 421 \N  \N  \N  \N  \N
    1   422 424 default 422 \N  \N  \N  \N  \N
    1   423 425 default 423 \N  \N  \N  \N  \N
    1   424 426 default 424 \N  \N  \N  \N  \N
    1   425 428 default 425 \N  \N  \N  \N  \N
    1   426 429 default 426 \N  \N  \N  \N  \N
    1   427 430 default 427 \N  \N  \N  \N  \N
    \N  428 431 default 428 \N  \N  \N  \N  \N
    1   429 432 default 429 \N  \N  \N  \N  \N
    0   430 433 default 430 \N  \N  \N  \N  \N
    1   431 434 default 431 \N  \N  \N  \N  \N
    1   432 435 default 432 \N  \N  \N  \N  \N
    1   433 436 default 433 \N  \N  \N  \N  \N
    1   434 437 default 434 \N  \N  \N  \N  \N
    1   435 438 default 435 \N  \N  \N  \N  \N
    1   436 439 default 436 \N  \N  \N  \N  \N
    1   437 440 default 437 \N  \N  \N  \N  \N
    1   438 441 default 438 \N  \N  \N  \N  \N
    1   439 442 default 439 \N  \N  \N  \N  \N
    1   440 443 default 440 \N  \N  \N  \N  \N
    1   441 444 default 441 \N  \N  \N  \N  \N
    1   442 445 default 442 \N  \N  \N  \N  \N
    1   443 446 default 443 \N  \N  \N  \N  \N
    1   444 447 default 444 \N  \N  \N  \N  \N
    1   445 448 default 445 \N  \N  \N  \N  \N
    1   446 449 default 446 \N  \N  \N  \N  \N
    1   447 450 default 447 \N  \N  \N  \N  \N
    1   448 451 default 448 \N  \N  \N  \N  \N
    1   449 452 default 449 \N  \N  \N  \N  \N
    1   450 453 default 450 \N  \N  \N  \N  \N
    0   451 454 default 451 \N  \N  \N  \N  \N
    1   452 455 default 452 \N  \N  \N  \N  \N
    0   453 456 default 453 \N  \N  \N  \N  \N
    1   454 457 default 454 \N  \N  \N  \N  \N
    1   455 458 default 455 \N  \N  \N  \N  \N
    1   456 459 default 456 \N  \N  \N  \N  \N
    0   457 460 default 457 \N  \N  \N  \N  \N
    0   458 461 default 458 \N  \N  \N  \N  \N
    1   459 462 default 459 \N  \N  \N  \N  \N
    0   460 463 default 460 \N  \N  \N  \N  \N
    0   461 464 default 461 \N  \N  \N  \N  \N
    0   462 465 default 462 \N  \N  \N  \N  \N
    1   463 466 default 463 \N  \N  \N  \N  \N
    0   464 467 default 464 \N  \N  \N  \N  \N
    1   465 468 default 465 \N  \N  \N  \N  \N
    0   466 469 default 466 \N  \N  \N  \N  \N
    1   467 470 default 467 \N  \N  \N  \N  \N
    1   468 471 default 468 \N  \N  \N  \N  \N
    1   469 472 default 469 \N  \N  \N  \N  \N
    1   470 473 default 470 \N  \N  \N  \N  \N
    0   471 474 default 471 \N  \N  \N  \N  \N
    1   472 475 default 472 \N  \N  \N  \N  \N
    1   473 476 default 473 \N  \N  \N  \N  \N
    1   474 477 default 474 \N  \N  \N  \N  \N
    1   475 478 default 475 \N  \N  \N  \N  \N
    0   476 479 default 476 \N  \N  \N  \N  \N
    1   477 480 default 477 \N  \N  \N  \N  \N
    0   478 481 default 478 \N  \N  \N  \N  \N
    1   479 482 default 479 \N  \N  \N  \N  \N
    1   480 483 default 480 \N  \N  \N  \N  \N
    1   481 484 default 481 \N  \N  \N  \N  \N
    1   482 485 default 482 \N  \N  \N  \N  \N
    1   483 486 default 483 \N  \N  \N  \N  \N
    \N  484 487 default 484 \N  \N  \N  \N  \N
    0   485 488 default 485 \N  \N  \N  \N  \N
    1   486 489 default 486 \N  \N  \N  \N  \N
    1   487 490 default 487 \N  \N  \N  \N  \N
    0   488 491 default 488 \N  \N  \N  \N  \N
    1   489 493 default 489 \N  \N  \N  \N  \N
    1   490 494 default 490 \N  \N  \N  \N  \N
    0   491 495 default 491 \N  \N  \N  \N  \N
    1   492 496 default 492 \N  \N  \N  \N  \N
    1   493 497 default 493 \N  \N  \N  \N  \N
    1   494 498 default 494 \N  \N  \N  \N  \N
    1   495 499 default 495 \N  \N  \N  \N  \N
    0   496 500 default 496 \N  \N  \N  \N  \N
    1   497 501 default 497 \N  \N  \N  \N  \N
    1   498 502 default 498 \N  \N  \N  \N  \N
    0   499 503 default 499 \N  \N  \N  \N  \N
    0   500 504 default 500 \N  \N  \N  \N  \N
    1   501 505 default 501 \N  \N  \N  \N  \N
    1   502 506 default 502 \N  \N  \N  \N  \N
    1   503 507 default 503 \N  \N  \N  \N  \N
    0   504 508 default 504 \N  \N  \N  \N  \N
    1   505 509 default 505 \N  \N  \N  \N  \N
    0   506 510 default 506 \N  \N  \N  \N  \N
    0   507 511 default 507 \N  \N  \N  \N  \N
    1   508 512 default 508 \N  \N  \N  \N  \N
    0   509 513 default 509 \N  \N  \N  \N  \N
    1   510 514 default 510 \N  \N  \N  \N  \N
    1   511 515 default 511 \N  \N  \N  \N  \N
    0   512 516 default 512 \N  \N  \N  \N  \N
    0   513 517 default 513 \N  \N  \N  \N  \N
\N  1   591 597 1/2015  \N  \N  \N  \N  \N  \N
    1   514 518 default 514 \N  \N  \N  \N  \N
\N  1   590 596 1/2015  \N  \N  \N  \N  \N  \N
    0   515 519 default 515 \N  \N  \N  \N  \N
\N  0   592 598 1/2015  \N  \N  \N  \N  \N  \N
    1   516 520 default 516 \N  \N  \N  \N  \N
\N  0   589 595 1/2015  590 \N  \N  \N  \N  \N
    0   517 521 default 517 \N  \N  \N  \N  \N
    0   518 522 default 518 \N  \N  \N  \N  \N
    0   519 523 default 519 \N  \N  \N  \N  \N
    \N  520 524 default 520 \N  \N  \N  \N  \N
    1   521 525 default 521 \N  \N  \N  \N  \N
    0   522 526 default 522 \N  \N  \N  \N  \N
    1   523 527 default 523 \N  \N  \N  \N  \N
    1   524 528 default 524 \N  \N  \N  \N  \N
    1   525 529 default 525 \N  \N  \N  \N  \N
    1   526 530 default 526 \N  \N  \N  \N  \N
    1   527 531 default 527 \N  \N  \N  \N  \N
    1   528 532 default 528 \N  \N  \N  \N  \N
    1   529 533 default 529 \N  \N  \N  \N  \N
    1   530 534 default 530 \N  \N  \N  \N  \N
    1   531 535 default 531 \N  \N  \N  \N  \N
    1   532 536 default 532 \N  \N  \N  \N  \N
    1   533 537 default 533 \N  \N  \N  \N  \N
    1   534 538 default 534 \N  \N  \N  \N  \N
    1   535 539 default 535 \N  \N  \N  \N  \N
    1   536 540 default 536 \N  \N  \N  \N  \N
    1   537 541 default 537 \N  \N  \N  \N  \N
    1   538 542 default 538 \N  \N  \N  \N  \N
    0   539 543 default 539 \N  \N  \N  \N  \N
    1   540 544 default 540 \N  \N  \N  \N  \N
    1   541 545 default 541 \N  \N  \N  \N  \N
    1   542 546 default 542 \N  \N  \N  \N  \N
    1   543 547 default 543 \N  \N  \N  \N  \N
    1   544 548 default 544 \N  \N  \N  \N  \N
    1   545 549 default 545 \N  \N  \N  \N  \N
    0   546 550 default 546 \N  \N  \N  \N  \N
    1   547 551 default 547 \N  \N  \N  \N  \N
    0   548 552 default 548 \N  \N  \N  \N  \N
    1   549 553 default 549 \N  \N  \N  \N  \N
    1   550 554 default 550 \N  \N  \N  \N  \N
    1   551 555 default 551 \N  \N  \N  \N  \N
    1   552 556 default 552 \N  \N  \N  \N  \N
    1   553 557 default 553 \N  \N  \N  \N  \N
    1   554 558 default 554 \N  \N  \N  \N  \N
    0   555 559 default 555 \N  \N  \N  \N  \N
    1   556 560 default 556 \N  \N  \N  \N  \N
    1   557 561 default 557 \N  \N  \N  \N  \N
    0   558 562 default 558 \N  \N  \N  \N  \N
    1   559 563 default 559 \N  \N  \N  \N  \N
    1   560 564 default 560 \N  \N  \N  \N  \N
    \N  561 565 default 561 \N  \N  \N  \N  \N
    \N  562 566 default 562 \N  \N  \N  \N  \N
    0   563 567 default 563 \N  \N  \N  \N  \N
    0   564 568 default 564 \N  \N  \N  \N  \N
    1   565 569 default 565 \N  \N  \N  \N  \N
    0   566 570 default 566 \N  \N  \N  \N  \N
    1   567 571 default 567 \N  \N  \N  \N  \N
    1   568 572 default 568 \N  \N  \N  \N  \N
    1   569 573 default 569 \N  \N  \N  \N  \N
    1   570 574 default 570 \N  \N  \N  \N  \N
    1   571 575 default 571 \N  \N  \N  \N  \N
    0   572 576 default 572 \N  \N  \N  \N  \N
    0   573 577 default 573 \N  \N  \N  \N  \N
    1   574 578 default 574 \N  \N  \N  \N  \N
    1   575 579 default 575 \N  \N  \N  \N  \N
    1   576 580 default 576 \N  \N  \N  \N  \N
    1   577 581 default 577 \N  \N  \N  \N  \N
    1   578 582 default 578 \N  \N  \N  \N  \N
    1   579 584 default 579 \N  \N  \N  \N  \N
    1   580 585 default 580 \N  \N  \N  \N  \N
    1   581 586 default 581 \N  \N  \N  \N  \N
    \N  582 587 default 582 \N  \N  \N  \N  \N
    0   583 588 default 583 \N  \N  \N  \N  \N
    1   584 589 default 584 \N  \N  \N  \N  \N
    1   585 590 default 585 \N  \N  \N  \N  \N
    1   586 591 default 586 \N  \N  \N  \N  \N
    1   587 592 default 587 \N  \N  \N  \N  \N
    1   588 593 default 588 \N  \N  \N  \N  \N
\N  0   594 602 1/2016  592 \N  \N  \N  \N  \N
\N  0   595 603 1/2016  593 \N  \N  \N  \N  \N
21/05/2015  0   596 604 1/2016  594 22/05/2015  \N  \N  \N  \N
30/05/2015  0   597 605 1/2016  595 31/05/2015  \N  \N  \N  \N
18/05/2015  0   599 608 1/2016  \N  19/05/2015  27/05/2015  28/05/2015  \N  \N
19/05/2015  0   606 616 1/2016  \N  20/05/2015  20/05/2015  21/05/2015  \N  \N
18/05/2015  0   598 607 1/2016  596 21/05/2015  27/05/2015  28/05/2015  \N  \N
\N  0   602 612 1/2016  597 \N  \N  \N  \N  \N
13/05/2015  0   603 613 1/2016  598 13/05/2015  21/05/2015  21/05/2015  \N  \N
19/05/2015  0   604 614 1/2016  \N  19/06/2015  20/05/2015  21/05/2015  \N  \N
20/05/2015  2   605 615 1/2016  \N  21/05/2015  20/05/2015  21/05/2015  \N  \N
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

COPY evento (idevento, rsu, codigo, comuna, cuposdepartamento, cuposinvitados, entidadreceptora, estado, fechahora, financiamiento, institucionorigen, invitadoapellido, invitadocargo, invitadocomentarios, invitadocorreo, invitadonombre, lugar, nombreproyecto, origensolicitud, proyectovinculado, publicoobjetivo, region, resumen, sala, titulo, unidadacademicamayor, unidadacademicamenor, idsubtipo_idsubtipo, idchecklist_idchecklist) FROM stdin;
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
Se le asignó Tema. Lo ingresó el usuario admin admin    04/04/2015  167110614   2   1
Ingresó Tema al alumno GLEN ENRIQUE CIFUENTES TORO  04/04/2015  admin   3   2
Se creó el tema, con estado 'Vigente'   14/05/2015  589 1   3
Informe de Avance: El estado del tema cambió de 'Vigente' a 'Prorrogado'    24/04/2015  25  1   4
Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin 12/05/2015  171818575   2   5
Ingresó Comisión Correctora al alumno JOAQU�?N OLIVARES DONOSO   12/05/2015  admin   3   6
Comision Correctora: El estado del tema cambió de 'Vigente con borrador final' a En proceso de examen   12/05/2015  7   1   7
Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin 12/05/2015  172288987   2   8
Ingresó Comisión Correctora al alumno ALFONSO HENR�?QUEZ HANDY   12/05/2015  admin   3   9
Comision Correctora: El estado del tema cambió de 'Vigente con borrador final' a En proceso de examen   12/05/2015  591 1   10
Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin 15/05/2015  159073122   2   11
Ingresó Comisión Correctora al alumno MANUEL ALEJANDRO ALARCON BELMAR   15/05/2015  admin   3   12
Comision Correctora: El estado del tema cambió de 'Vigente con borrador final' a En proceso de examen   26/05/2015  592 1   13
Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin 15/05/2015  128516948   2   14
Ingresó Comisión Correctora al alumno NAYADA HERNANDEZ OYANEDEL 15/05/2015  admin   3   15
Comision Correctora: El estado del tema cambió de 'Vigente con borrador final' a En proceso de examen   27/05/2015  593 1   16
Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin 15/05/2015  173832168   2   17
Ingresó Comisión Correctora al alumno HERNANDO ANDRES MANRIQUEZ NAVARRO 15/05/2015  admin   3   18
Comision Correctora: El estado del tema cambió de 'Vigente con borrador final' a En proceso de examen   15/05/2015  594 1   19
Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin 15/05/2015  166257344   2   20
Ingresó Comisión Correctora al alumno GONZALO SEBASTIAN ALVARADO REYES  15/05/2015  admin   3   21
Comision Correctora: El estado del tema cambió de 'Vigente con borrador final' a En proceso de examen   28/05/2015  596 1   22
Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin 15/05/2015  171818575   2   23
Ingresó Comisión Correctora al alumno JOAQU�?N OLIVARES DONOSO   15/05/2015  admin   3   24
Comision Correctora: El estado del tema cambió de 'Vigente con borrador final' a En proceso de examen   15/05/2015  595 1   25
Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin 18/05/2015  153179409   2   26
Ingresó Comisión Correctora al alumno SEBASTIAN ROSENDE PINO    18/05/2015  admin   3   27
Comision Correctora: El estado del tema cambió de 'Vigente con borrador final' a En proceso de examen   20/05/2015  598 1   28
Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin 18/05/2015  173832168   2   29
Ingresó Comisión Correctora al alumno HERNANDO ANDRES MANRIQUEZ NAVARRO 18/05/2015  admin   3   30
Comision Correctora: El estado del tema cambió de 'Vigente con borrador final' a En proceso de examen   \N  599 1   31
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

COPY inscripcion (idinscripcion, apellido, email, nombre, spam, idevento_idevento) FROM stdin;
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY logs (logs_id, dated, level, logger, message, user_id) FROM stdin;
1	2015-05-12 18:54:29.628449	INFO	managedbeans2.temas.ComisionCorrectora2MB	Se asignó Comisión Correctora al temaQWEQWE
2	2015-05-12 18:54:29.707257	INFO	managedbeans2.temas.ComisionCorrectora2MB	Ingresó Comisión Correctora al alumno JOAQU�?N OLIVARES DONOSO
3	2015-05-12 18:54:30.264668	INFO	managedbeans2.temas.ComisionCorrectora2MB	Comisión ingresada al sistema, el estado del tema seleccionado se modificó a En proceso de examen
4	2015-05-12 18:56:05.897161	INFO	managedbeans2.EliminarMB	La propuesta: SDAFASD ha sido eliminada del sistema
5	2015-05-12 18:56:23.187974	INFO	managedbeans2.propuestas.AgregarPropuestaMB	La propuesta propuesta ha sido ingresada al sistema
6	2015-05-12 18:56:43.644818	INFO	managedbeans2.propuestas.ComisionRevisora2MB	La propuesta PROPUESTA ha sido ingresada al sistema
7	2015-05-12 18:56:58.149105	INFO	managedbeans2.temas.AgregarTemaMB	El tema TEMA ASDF ha sido ingresado al sistema
8	2015-05-12 18:59:37.521402	INFO	managedbeans2.temas.ComisionCorrectora2MB	Se asignó Comisión Correctora al temaTEMA ASDF
9	2015-05-12 18:59:37.557771	INFO	managedbeans2.temas.ComisionCorrectora2MB	Ingresó Comisión Correctora al alumno ALFONSO HENR�?QUEZ HANDY
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
33	2015-05-15 04:35:33.278156	INFO	managedbeans2.temas.VerTemaMB	Tema SISTEMA DE APOYO A LA PLANIFICACIÓN DOCENTE Y MEDICIÓN DEL ESTADO DE AVANCE DE LOS ALUMNOS EN HABILIDADES COGNITIVAS ESPEC�?FICAS editado exitosamente
34	2015-05-15 04:40:55.159584	INFO	managedbeans2.temas.VerTemaMB	Tema DESARROLLO DE API DE VALIDACIÓN MEDIANTE HUELLA DIGITAL EN TARJETAS CON CHIP editado exitosamente
35	2015-05-15 04:41:27.769991	INFO	managedbeans2.temas.VerTemaMB	Tema DESARROLLO DE PROTOTIPO DE UNA CALCULADORA DE DOSIS PARA EL APOYO DEL �?REA DE PEDRIATR�?A editado exitosamente
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
60	2015-05-15 19:06:08.568568	INFO	managedbeans2.temas.ComisionCorrectora2MB	Ingresó Comisión Correctora al alumno JOAQU�?N OLIVARES DONOSO
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
1   2015    1
\.


--
-- Data for Name: planes_alumno; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY planes_alumno (alumno_id, plan_id, activo, version_plan) FROM stdin;
\.


--
-- Data for Name: planestudio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY planestudio (id, codigo, jornada, carrera_id) FROM stdin;
1   1363    0   1
2   1973    1   1
3   1863    0   1
4   1963    0   1
5   1353    0   2
6   1853    0   2
7   1953    0   2
8   1983    1   2
\.


--
-- Data for Name: profe_correccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY profe_correccion (id_correctora, rut_profesor, rol_correccion, nota_correccion_informe, nota_correccion_defensa) FROM stdin;
236 145010330   0   5.5 5.5
236 163601311   1   5.5 5.5
238 162690302   0   6.5999999   6.5999999
238 155560002   1   6.5999999   6.5999999
235 68635926    0   6.5999999   6.5999999
235 162690302   1   6.5999999   6.5999999
237 78132884    0   5.5 5.5
237 155560002   1   5.5 5.5
239 78132884    0   5.5 5.5
239 70658828    1   5.5 5.5
240 120188615   0   5.5 5.5
240 78132884    1   5.5 5.5
233 70658828    0   5.5 5.5
233 120188615   1   5.5 5.5
\.


--
-- Data for Name: profe_propuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY profe_propuesta (id_propuesta, rut_profesor, rol_guia, nota_guia_informe, nota_guia_defensa, fecha_revision) FROM stdin;
1   136711261   0   \N  \N  \N
2   136711261   0   \N  \N  \N
3   136711261   0   \N  \N  \N
4   136711261   0   \N  \N  \N
5   136711261   0   \N  \N  \N
6   136711261   0   \N  \N  \N
8   136711261   0   \N  \N  \N
9   70549123    0   \N  \N  \N
10  70549123    0   \N  \N  \N
11  70549123    0   \N  \N  \N
12  70549123    0   \N  \N  \N
13  70549123    0   \N  \N  \N
14  70549123    0   \N  \N  \N
15  70549123    0   \N  \N  \N
16  70549123    0   \N  \N  \N
17  70549123    0   \N  \N  \N
18  70549123    0   \N  \N  \N
19  70549123    0   \N  \N  \N
20  70549123    0   \N  \N  \N
21  70549123    0   \N  \N  \N
22  70549123    0   \N  \N  \N
23  136934384   0   \N  \N  \N
24  136934384   0   \N  \N  \N
25  136934384   0   \N  \N  \N
26  136934384   0   \N  \N  \N
27  136934384   0   \N  \N  \N
28  136934384   0   \N  \N  \N
29  136934384   0   \N  \N  \N
30  136934384   0   \N  \N  \N
31  136934384   0   \N  \N  \N
32  136934384   0   \N  \N  \N
33  136934384   0   \N  \N  \N
34  136934384   0   \N  \N  \N
35  136934384   0   \N  \N  \N
36  136934384   0   \N  \N  \N
37  136934384   0   \N  \N  \N
38  136934384   0   \N  \N  \N
39  70658828    0   \N  \N  \N
40  70658828    0   \N  \N  \N
41  70658828    0   \N  \N  \N
42  70658828    0   \N  \N  \N
43  70658828    0   \N  \N  \N
44  70658828    0   \N  \N  \N
45  70658828    0   \N  \N  \N
46  70658828    0   \N  \N  \N
47  70658828    0   \N  \N  \N
48  70658828    0   \N  \N  \N
49  120188615   0   \N  \N  \N
50  120188615   0   \N  \N  \N
51  120188615   0   \N  \N  \N
52  120188615   0   \N  \N  \N
53  120188615   0   \N  \N  \N
54  120188615   0   \N  \N  \N
55  120188615   0   \N  \N  \N
56  120188615   0   \N  \N  \N
57  120188615   0   \N  \N  \N
58  120188615   0   \N  \N  \N
59  120188615   0   \N  \N  \N
60  120188615   0   \N  \N  \N
61  120188615   0   \N  \N  \N
62  120188615   0   \N  \N  \N
63  120188615   0   \N  \N  \N
64  120188615   0   \N  \N  \N
65  120188615   0   \N  \N  \N
66  120188615   0   \N  \N  \N
67  120188615   0   \N  \N  \N
68  120188615   0   \N  \N  \N
69  120188615   0   \N  \N  \N
70  120188615   0   \N  \N  \N
71  120188615   0   \N  \N  \N
72  145010330   0   \N  \N  \N
73  145010330   0   \N  \N  \N
74  163601311   0   \N  \N  \N
75  68635926    0   \N  \N  \N
76  68635926    0   \N  \N  \N
77  68635926    0   \N  \N  \N
78  68635926    0   \N  \N  \N
79  68635926    0   \N  \N  \N
80  68635926    0   \N  \N  \N
81  68635926    0   \N  \N  \N
82  68635926    0   \N  \N  \N
83  68635926    0   \N  \N  \N
84  68635926    0   \N  \N  \N
85  78132884    0   \N  \N  \N
86  78132884    0   \N  \N  \N
87  78132884    0   \N  \N  \N
88  78132884    0   \N  \N  \N
89  78132884    0   \N  \N  \N
90  78132884    0   \N  \N  \N
91  78132884    0   \N  \N  \N
92  78132884    0   \N  \N  \N
93  78132884    0   \N  \N  \N
94  78132884    0   \N  \N  \N
95  78132884    0   \N  \N  \N
96  78132884    0   \N  \N  \N
97  78132884    0   \N  \N  \N
98  78132884    0   \N  \N  \N
99  78132884    0   \N  \N  \N
100 78132884    0   \N  \N  \N
101 78132884    0   \N  \N  \N
102 78132884    0   \N  \N  \N
103 78132884    0   \N  \N  \N
104 78132884    0   \N  \N  \N
105 78132884    0   \N  \N  \N
106 78132884    0   \N  \N  \N
107 78132884    0   \N  \N  \N
108 78132884    0   \N  \N  \N
109 78132884    0   \N  \N  \N
110 78132884    0   \N  \N  \N
111 78132884    0   \N  \N  \N
112 78132884    0   \N  \N  \N
113 78132884    0   \N  \N  \N
114 78132884    0   \N  \N  \N
115 78132884    0   \N  \N  \N
116 78132884    0   \N  \N  \N
117 78132884    0   \N  \N  \N
118 78132884    0   \N  \N  \N
119 78132884    0   \N  \N  \N
120 78132884    0   \N  \N  \N
121 78132884    0   \N  \N  \N
122 78132884    0   \N  \N  \N
123 78132884    0   \N  \N  \N
124 162690302   0   \N  \N  \N
125 162690302   0   \N  \N  \N
126 162690302   0   \N  \N  \N
127 155560002   0   \N  \N  \N
128 155560002   0   \N  \N  \N
129 155560002   0   \N  \N  \N
130 155560002   0   \N  \N  \N
131 109857017   0   \N  \N  \N
132 109857017   0   \N  \N  \N
133 109857017   0   \N  \N  \N
134 56369325    0   \N  \N  \N
135 56369325    0   \N  \N  \N
136 56369325    0   \N  \N  \N
137 56369325    0   \N  \N  \N
138 56369325    0   \N  \N  \N
139 56369325    0   \N  \N  \N
140 95794912    0   \N  \N  \N
141 95794912    0   \N  \N  \N
142 95794912    0   \N  \N  \N
143 95794912    0   \N  \N  \N
144 95794912    0   \N  \N  \N
145 95794912    0   \N  \N  \N
146 95794912    0   \N  \N  \N
147 95794912    0   \N  \N  \N
148 95794912    0   \N  \N  \N
149 95794912    0   \N  \N  \N
150 95794912    0   \N  \N  \N
151 95794912    0   \N  \N  \N
152 69476376    0   \N  \N  \N
153 69476376    0   \N  \N  \N
154 69476376    0   \N  \N  \N
155 69476376    0   \N  \N  \N
156 69476376    0   \N  \N  \N
157 69476376    0   \N  \N  \N
158 69476376    0   \N  \N  \N
159 69476376    0   \N  \N  \N
160 69476376    0   \N  \N  \N
161 69476376    0   \N  \N  \N
162 69476376    0   \N  \N  \N
163 69476376    0   \N  \N  \N
164 69476376    0   \N  \N  \N
165 69476376    0   \N  \N  \N
166 65776545    0   \N  \N  \N
167 65776545    0   \N  \N  \N
168 65776545    0   \N  \N  \N
169 65776545    0   \N  \N  \N
170 65776545    0   \N  \N  \N
171 65776545    0   \N  \N  \N
172 65776545    0   \N  \N  \N
173 65776545    0   \N  \N  \N
174 65776545    0   \N  \N  \N
175 65776545    0   \N  \N  \N
176 65776545    0   \N  \N  \N
177 65776545    0   \N  \N  \N
178 65776545    0   \N  \N  \N
179 65776545    0   \N  \N  \N
180 65776545    0   \N  \N  \N
181 65776545    0   \N  \N  \N
182 65776545    0   \N  \N  \N
183 65776545    0   \N  \N  \N
184 65776545    0   \N  \N  \N
185 65776545    0   \N  \N  \N
186 65776545    0   \N  \N  \N
187 65776545    0   \N  \N  \N
188 65776545    0   \N  \N  \N
189 65776545    0   \N  \N  \N
190 65776545    0   \N  \N  \N
191 00  0   \N  \N  \N
192 00  0   \N  \N  \N
193 00  0   \N  \N  \N
194 00  0   \N  \N  \N
195 00  0   \N  \N  \N
196 00  0   \N  \N  \N
197 00  0   \N  \N  \N
198 00  0   \N  \N  \N
199 00  0   \N  \N  \N
200 00  0   \N  \N  \N
201 00  0   \N  \N  \N
202 00  0   \N  \N  \N
203 00  0   \N  \N  \N
204 130461786   0   \N  \N  \N
205 130461786   0   \N  \N  \N
206 130461786   0   \N  \N  \N
207 130461786   0   \N  \N  \N
208 130461786   0   \N  \N  \N
209 130461786   0   \N  \N  \N
210 136725092   0   \N  \N  \N
211 136725092   0   \N  \N  \N
212 136725092   0   \N  \N  \N
213 136725092   0   \N  \N  \N
214 136725092   0   \N  \N  \N
215 136725092   0   \N  \N  \N
216 136725092   0   \N  \N  \N
217 136725092   0   \N  \N  \N
218 63567833    0   \N  \N  \N
219 63567833    0   \N  \N  \N
220 63567833    0   \N  \N  \N
221 63567833    0   \N  \N  \N
222 63567833    0   \N  \N  \N
223 63567833    0   \N  \N  \N
224 63567833    0   \N  \N  \N
225 63567833    0   \N  \N  \N
226 63567833    0   \N  \N  \N
227 63567833    0   \N  \N  \N
228 63567833    0   \N  \N  \N
229 63567833    0   \N  \N  \N
230 63567833    0   \N  \N  \N
231 63567833    0   \N  \N  \N
232 63567833    0   \N  \N  \N
233 63567833    0   \N  \N  \N
234 63567833    0   \N  \N  \N
235 63567833    0   \N  \N  \N
236 96742975    0   \N  \N  \N
237 96742975    0   \N  \N  \N
238 96742975    0   \N  \N  \N
239 96742975    0   \N  \N  \N
240 96742975    0   \N  \N  \N
241 73172713    0   \N  \N  \N
242 73172713    0   \N  \N  \N
243 73172713    0   \N  \N  \N
244 73172713    0   \N  \N  \N
245 73172713    0   \N  \N  \N
246 73172713    0   \N  \N  \N
247 73172713    0   \N  \N  \N
248 73172713    0   \N  \N  \N
249 73172713    0   \N  \N  \N
250 156232890   0   \N  \N  \N
251 156232890   0   \N  \N  \N
252 156232890   0   \N  \N  \N
253 156232890   0   \N  \N  \N
254 156232890   0   \N  \N  \N
255 156232890   0   \N  \N  \N
256 156232890   0   \N  \N  \N
257 156232890   0   \N  \N  \N
258 156232890   0   \N  \N  \N
259 156232890   0   \N  \N  \N
260 156232890   0   \N  \N  \N
261 156232890   0   \N  \N  \N
262 156232890   0   \N  \N  \N
263 156232890   0   \N  \N  \N
264 156232890   0   \N  \N  \N
265 156232890   0   \N  \N  \N
266 156232890   0   \N  \N  \N
267 156232890   0   \N  \N  \N
268 156232890   0   \N  \N  \N
269 156232890   0   \N  \N  \N
270 156232890   0   \N  \N  \N
271 156232890   0   \N  \N  \N
272 156232890   0   \N  \N  \N
273 157762311   0   \N  \N  \N
274 141622404   0   \N  \N  \N
275 141622404   0   \N  \N  \N
276 141622404   0   \N  \N  \N
277 141622404   0   \N  \N  \N
278 59653024    0   \N  \N  \N
279 59653024    0   \N  \N  \N
280 59653024    0   \N  \N  \N
281 59653024    0   \N  \N  \N
282 59653024    0   \N  \N  \N
283 59653024    0   \N  \N  \N
284 59653024    0   \N  \N  \N
285 59653024    0   \N  \N  \N
286 59653024    0   \N  \N  \N
287 59653024    0   \N  \N  \N
288 59653024    0   \N  \N  \N
289 59653024    0   \N  \N  \N
290 59653024    0   \N  \N  \N
291 59653024    0   \N  \N  \N
292 59653024    0   \N  \N  \N
293 59653024    0   \N  \N  \N
294 59653024    0   \N  \N  \N
295 59653024    0   \N  \N  \N
296 59653024    0   \N  \N  \N
297 59653024    0   \N  \N  \N
298 59653024    0   \N  \N  \N
299 59653024    0   \N  \N  \N
300 59653024    0   \N  \N  \N
301 59653024    0   \N  \N  \N
302 59653024    0   \N  \N  \N
303 59653024    0   \N  \N  \N
304 59653024    0   \N  \N  \N
305 59653024    0   \N  \N  \N
306 59653024    0   \N  \N  \N
307 59653024    0   \N  \N  \N
308 59653024    0   \N  \N  \N
309 138328449   0   \N  \N  \N
310 138328449   0   \N  \N  \N
311 138328449   0   \N  \N  \N
312 130438164   0   \N  \N  \N
313 130438164   0   \N  \N  \N
314 130438164   0   \N  \N  \N
315 130438164   0   \N  \N  \N
316 130438164   0   \N  \N  \N
317 130438164   0   \N  \N  \N
318 130438164   0   \N  \N  \N
319 130438164   0   \N  \N  \N
320 130438164   0   \N  \N  \N
321 130438164   0   \N  \N  \N
322 130438164   0   \N  \N  \N
323 130438164   0   \N  \N  \N
324 130438164   0   \N  \N  \N
325 71531589    0   \N  \N  \N
326 71531589    0   \N  \N  \N
327 71531589    0   \N  \N  \N
328 71531589    0   \N  \N  \N
329 71531589    0   \N  \N  \N
330 71531589    0   \N  \N  \N
331 71531589    0   \N  \N  \N
332 71531589    0   \N  \N  \N
333 71531589    0   \N  \N  \N
334 71531589    0   \N  \N  \N
335 71531589    0   \N  \N  \N
336 71531589    0   \N  \N  \N
337 71531589    0   \N  \N  \N
338 71531589    0   \N  \N  \N
339 71531589    0   \N  \N  \N
340 71531589    0   \N  \N  \N
341 71531589    0   \N  \N  \N
342 71531589    0   \N  \N  \N
343 80796609    0   \N  \N  \N
344 80796609    0   \N  \N  \N
345 80796609    0   \N  \N  \N
346 80796609    0   \N  \N  \N
347 80796609    0   \N  \N  \N
348 80796609    0   \N  \N  \N
349 80796609    0   \N  \N  \N
350 80796609    0   \N  \N  \N
351 80796609    0   \N  \N  \N
352 80796609    0   \N  \N  \N
353 80796609    0   \N  \N  \N
354 80796609    0   \N  \N  \N
355 80796609    0   \N  \N  \N
356 80796609    0   \N  \N  \N
357 80796609    0   \N  \N  \N
358 80796609    0   \N  \N  \N
359 80796609    0   \N  \N  \N
360 80796609    0   \N  \N  \N
361 80796609    0   \N  \N  \N
362 80796609    0   \N  \N  \N
363 80796609    0   \N  \N  \N
364 80796609    0   \N  \N  \N
365 80796609    0   \N  \N  \N
366 80796609    0   \N  \N  \N
367 80796609    0   \N  \N  \N
368 80796609    0   \N  \N  \N
369 80796609    0   \N  \N  \N
370 51668316    0   \N  \N  \N
371 51668316    0   \N  \N  \N
372 51668316    0   \N  \N  \N
373 51668316    0   \N  \N  \N
374 51668316    0   \N  \N  \N
375 51668316    0   \N  \N  \N
376 51668316    0   \N  \N  \N
377 51668316    0   \N  \N  \N
378 51668316    0   \N  \N  \N
379 51668316    0   \N  \N  \N
380 51668316    0   \N  \N  \N
381 51668316    0   \N  \N  \N
382 51668316    0   \N  \N  \N
383 51668316    0   \N  \N  \N
384 51668316    0   \N  \N  \N
385 51668316    0   \N  \N  \N
386 51668316    0   \N  \N  \N
387 51668316    0   \N  \N  \N
388 51668316    0   \N  \N  \N
389 51668316    0   \N  \N  \N
390 51668316    0   \N  \N  \N
391 51668316    0   \N  \N  \N
392 51668316    0   \N  \N  \N
393 51668316    0   \N  \N  \N
394 51668316    0   \N  \N  \N
395 51668316    0   \N  \N  \N
396 51668316    0   \N  \N  \N
397 51668316    0   \N  \N  \N
398 51668316    0   \N  \N  \N
399 51668316    0   \N  \N  \N
400 51668316    0   \N  \N  \N
401 58872830    0   \N  \N  \N
402 58872830    0   \N  \N  \N
403 58872830    0   \N  \N  \N
404 58872830    0   \N  \N  \N
405 58872830    0   \N  \N  \N
406 58872830    0   \N  \N  \N
407 58872830    0   \N  \N  \N
408 155898712   0   \N  \N  \N
409 155898712   0   \N  \N  \N
410 128416374   0   \N  \N  \N
411 128416374   0   \N  \N  \N
412 128416374   0   \N  \N  \N
413 128416374   0   \N  \N  \N
414 128416374   0   \N  \N  \N
415 128416374   0   \N  \N  \N
416 128416374   0   \N  \N  \N
417 128416374   0   \N  \N  \N
418 128416374   0   \N  \N  \N
419 128416374   0   \N  \N  \N
420 128416374   0   \N  \N  \N
421 128416374   0   \N  \N  \N
422 128416374   0   \N  \N  \N
423 128416374   0   \N  \N  \N
424 90070819    0   \N  \N  \N
425 90070819    0   \N  \N  \N
426 90070819    0   \N  \N  \N
427 90070819    0   \N  \N  \N
428 90070819    0   \N  \N  \N
429 90070819    0   \N  \N  \N
430 90070819    0   \N  \N  \N
431 90070819    0   \N  \N  \N
432 90070819    0   \N  \N  \N
433 90070819    0   \N  \N  \N
434 141475789   0   \N  \N  \N
435 141475789   0   \N  \N  \N
436 141475789   0   \N  \N  \N
437 141475789   0   \N  \N  \N
438 141475789   0   \N  \N  \N
439 141475789   0   \N  \N  \N
440 141475789   0   \N  \N  \N
441 141475789   0   \N  \N  \N
442 141475789   0   \N  \N  \N
443 141475789   0   \N  \N  \N
444 66348903    0   \N  \N  \N
445 66348903    0   \N  \N  \N
446 66348903    0   \N  \N  \N
447 66348903    0   \N  \N  \N
448 66348903    0   \N  \N  \N
449 66348903    0   \N  \N  \N
450 66348903    0   \N  \N  \N
451 77657495    0   \N  \N  \N
452 77657495    0   \N  \N  \N
453 77657495    0   \N  \N  \N
454 77657495    0   \N  \N  \N
455 77657495    0   \N  \N  \N
456 77657495    0   \N  \N  \N
457 77657495    0   \N  \N  \N
458 77657495    0   \N  \N  \N
459 77657495    0   \N  \N  \N
460 77657495    0   \N  \N  \N
461 77657495    0   \N  \N  \N
462 77657495    0   \N  \N  \N
463 77657495    0   \N  \N  \N
464 77657495    0   \N  \N  \N
465 77657495    0   \N  \N  \N
466 77657495    0   \N  \N  \N
467 77657495    0   \N  \N  \N
468 77657495    0   \N  \N  \N
469 77657495    0   \N  \N  \N
470 77657495    0   \N  \N  \N
471 77657495    0   \N  \N  \N
472 77657495    0   \N  \N  \N
473 77657495    0   \N  \N  \N
474 77657495    0   \N  \N  \N
475 77657495    0   \N  \N  \N
476 77657495    0   \N  \N  \N
477 77657495    0   \N  \N  \N
478 77657495    0   \N  \N  \N
479 77657495    0   \N  \N  \N
480 77657495    0   \N  \N  \N
481 77657495    0   \N  \N  \N
482 77657495    0   \N  \N  \N
483 77657495    0   \N  \N  \N
484 77657495    0   \N  \N  \N
485 77657495    0   \N  \N  \N
486 77657495    0   \N  \N  \N
487 77657495    0   \N  \N  \N
488 77657495    0   \N  \N  \N
489 77657495    0   \N  \N  \N
490 77657495    0   \N  \N  \N
491 77657495    0   \N  \N  \N
492 77657495    0   \N  \N  \N
493 77657495    0   \N  \N  \N
494 77657495    0   \N  \N  \N
495 77657495    0   \N  \N  \N
496 77657495    0   \N  \N  \N
497 77657495    0   \N  \N  \N
498 77657495    0   \N  \N  \N
499 77657495    0   \N  \N  \N
500 77657495    0   \N  \N  \N
501 77657495    0   \N  \N  \N
502 77657495    0   \N  \N  \N
503 77657495    0   \N  \N  \N
504 77657495    0   \N  \N  \N
505 77657495    0   \N  \N  \N
506 77657495    0   \N  \N  \N
507 77657495    0   \N  \N  \N
508 77657495    0   \N  \N  \N
509 77657495    0   \N  \N  \N
510 77657495    0   \N  \N  \N
511 77657495    0   \N  \N  \N
512 77657495    0   \N  \N  \N
513 77657495    0   \N  \N  \N
514 77657495    0   \N  \N  \N
515 77657495    0   \N  \N  \N
516 77657495    0   \N  \N  \N
517 77657495    0   \N  \N  \N
518 77657495    0   \N  \N  \N
519 77657495    0   \N  \N  \N
520 77657495    0   \N  \N  \N
521 77657495    0   \N  \N  \N
522 77657495    0   \N  \N  \N
523 77657495    0   \N  \N  \N
524 77657495    0   \N  \N  \N
525 77657495    0   \N  \N  \N
526 77657495    0   \N  \N  \N
527 77657495    0   \N  \N  \N
528 77657495    0   \N  \N  \N
529 77657495    0   \N  \N  \N
530 77657495    0   \N  \N  \N
531 70629054    0   \N  \N  \N
532 70629054    0   \N  \N  \N
533 70629054    0   \N  \N  \N
534 70629054    0   \N  \N  \N
535 70629054    0   \N  \N  \N
536 70629054    0   \N  \N  \N
537 82230971    0   \N  \N  \N
538 82230971    0   \N  \N  \N
539 82230971    0   \N  \N  \N
540 82230971    0   \N  \N  \N
541 82230971    0   \N  \N  \N
542 82230971    0   \N  \N  \N
543 82230971    0   \N  \N  \N
544 82230971    0   \N  \N  \N
545 82230971    0   \N  \N  \N
546 82230971    0   \N  \N  \N
547 82230971    0   \N  \N  \N
548 82230971    0   \N  \N  \N
549 82230971    0   \N  \N  \N
550 82230971    0   \N  \N  \N
551 82230971    0   \N  \N  \N
552 82230971    0   \N  \N  \N
553 82230971    0   \N  \N  \N
554 82230971    0   \N  \N  \N
555 82230971    0   \N  \N  \N
556 82230971    0   \N  \N  \N
557 82230971    0   \N  \N  \N
558 82230971    0   \N  \N  \N
559 82230971    0   \N  \N  \N
560 82230971    0   \N  \N  \N
561 82230971    0   \N  \N  \N
562 82230971    0   \N  \N  \N
563 82230971    0   \N  \N  \N
564 82230971    0   \N  \N  \N
565 82230971    0   \N  \N  \N
566 82230971    0   \N  \N  \N
567 82230971    0   \N  \N  \N
568 82230971    0   \N  \N  \N
569 82230971    0   \N  \N  \N
570 82230971    0   \N  \N  \N
571 82230971    0   \N  \N  \N
572 82230971    0   \N  \N  \N
573 82230971    0   \N  \N  \N
574 82230971    0   \N  \N  \N
575 82230971    0   \N  \N  \N
576 82230971    0   \N  \N  \N
577 82230971    0   \N  \N  \N
578 82230971    0   \N  \N  \N
579 82230971    0   \N  \N  \N
580 82230971    0   \N  \N  \N
581 82230971    0   \N  \N  \N
582 82230971    0   \N  \N  \N
583 82230971    0   \N  \N  \N
584 82230971    0   \N  \N  \N
585 82230971    0   \N  \N  \N
586 82230971    0   \N  \N  \N
587 82230971    0   \N  \N  \N
588 82230971    0   \N  \N  \N
589 82230971    0   \N  \N  \N
590 156232890   0   \N  \N  \N
591 156232890   0   \N  \N  \N
592 156232890   0   \N  \N  \N
593 130438164   0   \N  \N  \N
595 136711261   0   \N  \N  \N
596 70658828    0   \N  \N  \N
597 136934384   0   \N  \N  \N
598 163601311   0   \N  \N  \N
598 136934384   1   \N  \N  \N
599 136711261   0   \N  \N  \N
607 120188615   0   6.5999999   6.5999999   \N
602 120188615   1   \N  \N  \N
603 120188615   1   \N  \N  \N
603 70658828    0   5.5 5.5 \N
605 68635926    1   \N  \N  \N
602 70658828    0   6.5999999   6.5999999   \N
604 120188615   0   5.5 5.5 \N
605 145010330   0   5.5 5.5 \N
608 120188615   0   \N  \N  \N
608 68635926    1   \N  \N  \N
609 145010330   0   \N  \N  \N
609 78132884    1   \N  \N  \N
611 145010330   0   \N  \N  \N
612 120188615   0   \N  \N  \N
613 78132884    1   \N  \N  \N
613 68635926    0   5.5 5.5 \N
614 78132884    1   \N  \N  \N
7   136711261   0   5.5 5.5 \N
615 120188615   0   \N  \N  \N
614 163601311   0   \N  \N  \N
616 78132884    0   \N  \N  \N
616 162690302   1   \N  \N  \N
\.


--
-- Data for Name: profe_revision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY profe_revision (id_revisora, rut_profesor, rol_revision, fecha_revision) FROM stdin;
589 70549123    0   \N
589 136934384   1   \N
590 68635926    0   \N
590 120188615   1   \N
591 120188615   0   \N
591 136711261   1   \N
592 70658828    0   \N
592 109857017   1   \N
594 163601311   0   \N
594 68635926    1   \N
595 68635926    0   \N
595 78132884    1   \N
596 78132884    0   \N
596 155560002   1   \N
597 70658828    0   \N
597 120188615   1   \N
598 70658828    0   \N
598 145010330   1   \N
599 162690302   0   \N
599 155560002   1   \N
602 163601311   0   \N
602 162690302   1   \N
603 70658828    0   \N
603 162690302   1   \N
604 70658828    0   \N
604 120188615   1   \N
606 145010330   0   \N
606 155560002   1   \N
\.


--
-- Data for Name: profesor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY profesor (contrato, nombre_profesor, apellido_profesor, mail_profesor, telefono_profesor, tipo_profesor, maximo_guias, rut_profesor, alias, jerarquia_categoria) FROM stdin;
1   CAROLINA    BONACIC \N  \N  0   \N  120188615   \N  \N
1   CRISTI�?N    BADILLA \N  \N  0   \N  145010330   \N  \N
1   CRISTÓBAL   ACOSTA  \N  \N  0   \N  163601311   \N  \N
1   EDGARDO SEPÚLVEDA   \N  \N  0   \N  68635926    \N  \N
1   EDMUNDO LEIVA   \N  \N  0   \N  78132884    \N  \N
1   EMIR    MUÑOZ   \N  \N  0   \N  162690302   \N  \N
1   ERIKA   ROSAS   \N  \N  0   \N  155560002   \N  \N
1   FERNANDA    KRI \N  \N  0   \N  109857017   \N  \N
1   FERNANDO    CONTRERAS   \N  \N  0   \N  56369325    \N  \N
1   FERNANDO    RANNOU  \N  \N  0   \N  95794912    \N  \N
1   GONZALO ACUÑA   \N  \N  0   \N  69476376    \N  \N
1   HÉCTOR  ANTILLANCA  \N  \N  0   \N  65776545    \N  \N
1   HÉCTOR  PONCE   \N  \N  0   \N  00  \N  \N
1   IRENE   ZUCCAR  \N  \N  0   \N  130461786   \N  \N
1   JACQUELINE  KOHLER  \N  \N  0   \N  136725092   \N  \N
1   JOSÉ    �?LVAREZ \N  \N  0   \N  63567833    \N  \N
1   JOSÉ LUIS   JARA    \N  \N  0   \N  96742975    \N  \N
1   JUAN    COCKBAINE   \N  \N  0   \N  73172713    \N  \N
1   JUAN    ITURBE  \N  \N  0   \N  156232890   \N  \N
1   JUAN PABLO  RUZ \N  \N  0   \N  157762311   \N  \N
1   LUIS    BERR�?OS \N  \N  0   \N  141622404   \N  \N
1   LUIS    R�?OS    \N  \N  0   \N  59653024    \N  \N
1   MARIA CAROLINA  CHAMORRO    \N  \N  0   \N  138328449   \N  \N
1   MARIO   INOSTROZA   \N  \N  0   \N  130438164   \N  \N
1   MAURICIO    MAR�?N   \N  \N  0   \N  71531589    \N  \N
1   MAX CHACON  \N  \N  0   \N  80796609    \N  \N
1   MÓNICA  VILLANUEVA  \N  \N  0   \N  51668316    \N  \N
1   NÉSTOR  GONZ�?LEZ    \N  \N  0   \N  58872830    \N  \N
1   NICOL�?S HIDALGO \N  \N  0   \N  155898712   \N  \N
1   PAULO   QUINSACARA  \N  \N  0   \N  128416374   \N  \N
1   RICARDO CONTRERAS   \N  \N  0   \N  90070819    \N  \N
1   ROBERTO GONZ�?LEZ    \N  \N  0   \N  141475789   \N  \N
1   ROGERS  ATERO   \N  \N  0   \N  66348903    \N  \N
1   ROSA    MUÑOZ   \N  \N  0   \N  77657495    \N  \N
1   SERGIO  VELASTIN    \N  \N  0   \N  70629054    \N  \N
1   V�?CTOR  PARADA  \N  \N  0   \N  82230971    \N  \N
0   ANDRÉS  RICE            0   \N  70549123    \N  \N
0   ALBERTO CEBALLO ASD@ASD.CL  83340796    0   \N  136711261   \N  \N
0   ARTURO  ALVAREZSDFA \N  12312321    0   7   136934384   \N  \N
0   PROFE   SOR profe@profe.cl  89307940    0   7   176767901   \N  \N
0   BRUNO   JERARDINO   mail@mail.cl    89307940    0   7   70658828    \N  \N
\.


--
-- Data for Name: propuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY propuesta (nombre_propuesta, fecha_propuesta, id_propuesta, id_semestre, id_revisora, rut_alumno, magister, pet) FROM stdin;
SISTEMA WEW PARA AYUDAR A PADRES Y APODERADOS EN LA BUSQUEDA DE COLEGIOS USANDO UN OPEN DATE    20/07/2012  1   default 1   176744650   \N  \N
SISTEMA VACACIONES PROGRESIVAS Y GENERACIÓN DE ALARMAS PARA LA EMPRESA CYSS 22/06/2012  280 default 279 158932121   \N  \N
DESARROLLO DE API DE VALIDACIÓN MEDIANTE HUELLA DIGITAL EN TARJETAS CON CHIP    23/07/2012  2   default 2   167110614   \N  \N
SISTEMA DE APOYO A LA PLANIFICACIÓN DOCENTE Y MEDICIÓN DEL ESTADO DE AVANCE DE LOS ALUMNOS EN HABILIDADES COGNITIVAS ESPEC�?FICAS        3   default 3   172288987   \N  \N
SISTEMA DE COORDINACION Y GESTION DE RESERVA HORARIA PARA EVENTOS Y ACTIVIDADES DEL COLEGIO ALEMAN DE SANTIAGO  20/09/2011  4   default 4   128516948   \N  \N
DISEÑO DE UN SISTEMA QUE PERMITA LA CREACIÓN DE APLICACIONES EDUCATIVAS     5   default 5   173832168   \N  \N
SISTEMA WEB DE APOYO A LA GESTIÓN DE UNA ORGANIZACIÓN COMUNITARIA   20/11/2013  6   default 6   171818575   \N  \N
GENERACIÓN AUTOM�?TICA DE RUTAS CON ENTREGAS PRIORITARIAS        7   default 7   171818575   \N  \N
SOLUCION TECNOLOGICA PARA LA CREACION DE SITIOS WEB Y SU GESTION DE INFORMACION, EN UNA EMPRESA DE SELECCIÓN DE PERSONAL    4/8/2010    8   default 8   153179409   \N  \N
SISTEMA DE ADMINISTRACIÓN PARA LA INFORMACIÓN TRANSPARENTE EN UNA COMUNIDAD DE EDIFICIOS    11/11/2014  9   default 9   159073122   \N  \N
SOFTWARE DE APOYO AL PROCESO ADMINISTRATIVO DE LA EMPRESA OPTICA REAL   20/07/2012  10  default 10  166257344   \N  \N
SISTEMA INFORM�?TICO PARA EL PROCESO DE POSTULACIÓN EN L�?NEA Y POSTERIOR SELECCIÓN DE AYUDANTES DEL DEPARTAMENTO DE INFENIER�?A INFORM�?TICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE    8/8/2012    11  default 11  169367353   \N  \N
SISTEMA INFORM�?TICO PARA LA GESTIÓN DE RECURSOS DEL DEPARTAMENTO DE DEPORTES DE LA UNIVERSIDAD DE SANTIAGO DE CHILE 23/01/2014  12  default 12  17841447K   \N  \N
SISTEMA PARA MONITOREO Y GESTIÓN DE REQUERIMIENTOS E INCIDENTES DE CLIENTES CORPORATIVOS EMPRESA ENTEL, MEDIANTE HERRAMIENTA SPLUNK     13  default 13  163235315   \N  \N
DESARROLLO DE PROTOTIPO DE UNA CALCULADORA DE DOSIS PARA EL APOYO DEL �?REA DE PEDRIATR�?A    18/12/12    14  default 14  171176654   \N  \N
DESARROLLAR JUEGOS PARA CURSO DE ECONOM�?A DE BACHILLER DE TECNOLOG�?A    18/07/2013  15  default 15  167535682   \N  \N
PROTOTIPO FUNCIANAL DE UN SISTEMA BROKER PARA LA EMPRESA SOLINGAS S.A   5/12/2012   16  default 16  179365995   \N  \N
DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA WEB ADMINISTRATIVO Y RESERVAS DE ATENCIÓN EN L�?NEA PARA UNA SERVITECA 14/12/12    17  default 17  171676568   \N  \N
SISTEMA DE EVALUACIÓN INTERACTIVO CON DISPOSITIVOS SMARTPHONE   28/07/2014  18  default 18  150947952   \N  \N
IMPLEMENTACIÓN DE WEB SERVICE PARA INTEGRACIÓN SAP CON PLATAFORMAS WEB  29/07/2013  19  default 19  136750089   \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE TECNOLOG�?AS DE LA INFORMACIÓN EN LA ENSEÑANZA B�?SICA   17/12/12    20  default 20  174641625   \N  \N
AUTOMATIZACIÓN DEL PROCESO PARA VISADO DE PAGO A PROVEEDORES DE LA EMPRESA ENVASES DEL PAC�?FICO (EDELPA)    3/3/2014    21  default 21  16548262K   \N  \N
OBEJTOS DE APRENDIZAJE PARA LA ENSEÑANZA DE LA LENGUA DE SEÑAS CHILENAS PARA NIÑOS CON DISCAPACIDAD AUDITIVA    7/1/2013    22  default 22  174115273   \N  \N
HERRAMIENTA DE SOFTWARE PARA ENTREGA DE INFORMACIÓN TUR�?STICA DIFERENCIADA Y FOCALIZADA EN PERFILES DE TURISTICA        23  default 23  170217535   \N  \N
PROTOCOLO PARA LA INTEROPERACIÓN DE UAVS, MEDIANTE UNA TORRE DE CONTROL VIRTUAL EN UN ESPACIO  AÉREO NO SEGREGADO "OGMIOS"      24  default 24  161952133   \N  \N
IMPLEMENTACIÓN DE ARQUITECTURA BASADA EN SWARM PARA BÚSQUEDA COLABORATIVA MEDIANTE VEH�?CULOS AÉREOS NO TRIPULADOS (UAVS)    14/08/2014  25  default 25  169009112   \N  \N
EVALUACIÓN DEALGORITMOS AEROFOTOGRAMÉTRICOS PARA CORRECCIÓN ORTOGONAL DE IM�?GENES, OBTENIDAS MEDIANTES UAV, USACDAS PARA GENERAR MOSAICOS Y MODELOS 3D  28//12/2012 26  default 26  167406386   \N  \N
DESARROLLO DE SISTEMA DE PLANIFICACIÓN DE MISIÓN Y CONTROL ADAPTIVO EN VUELO PARA EL SISTEMA AEREO ROBOTICO RUAS    23/07/2012  27  default 27  160707186   \N  \N
SOFTWARE PARA PLANIFICACIÓN DE VUELO FOTOGRAMÉTRICO DE UAV EN TERRENOS COMPLEJOS    14/08/2014  28  default 28  172952739   \N  \N
DESARROLLO DE SOFTWARE PARA CONTROL DE PLANES DE VUELO DE SISTEMA ROBÓTICO AÉREO MULTIAGENTE, BASADO EN LA ARQUITECTURA L-ALLIANCE  01/03/13    29  default 29  166097401   \N  \N
IMPLEMENTACIÓN DE ARQUITECTURA MULTIAGENTE L-ALLIANCE PARA EL CONTROL DE COMPORTAMIENTO DE VUELO DE ROBOTS AÉREOS   22/04/2014  30  default 30  166097401   \N  \N
DIFERENCIACIÓN DE VIGOR VEGETATIVO EN CULTIVOS AGR�?COLAS POR MEDIO DEL TRATAMIENTO DE IM�?GENES INFRARROJAS AÉREAS, CAPTURADAS CON UN AVIÓN ROBOTIZADO       31  default 31  167239404   \N  \N
SISTEMA DE DETECCIÓN Y EVASIÓN DE OBST�?CULOS PARA UAV CUADRICOPTERO BASADO EN ARDUPILOT 6/8/2014    32  default 32  173127677   \N  \N
SISTEMA DE DETECCIÓN DE PERSONAS EXTRAVIADAS, POR MEDIO DE RECONOCIMIENTO DE PATRONES EN IMAGÉNES TRANSMITIDAS EN TIEMPO REAL DESDE AVIÓN NO TRIPULADO  01/03/13    33  default 33  169091749   \N  \N
SISTEMA DE APOYO A LA DOCUMENTACIÓN DE IM�?GENES, AUTOMATIZANDO EL RECONOCIMIENTO DE EDIFICIOS Y ESTRUCTURAS 27/07/2012  34  default 34  166250536   \N  \N
UN SISTEMA PARA EL LANZAMIENTO DE SUMINISTROS MÉDICOS DESDE UN VEH�?CULO AÉREO NO TRIPULADO  20/01/2014  35  default 35  171686202   \N  \N
AUTOPILOTO INTEGRADO EN SMARTPHONE PARA VEH�?CULO AÉREO NO TRIPULADO (UAV)   4/8/2014    36  default 36  173808200   \N  \N
SISTEMA DE ORIENTACIÓN DE SERVICIOS TUR�?STICOS PARA DISPOSITIVOS MÓVILES UTILIZANDO REALIDAD AUMENTADA.     37  default 37  167858244   \N  \N
SISTEMA DE SOFTWARE EMBEBIDO EN HARDWARE PARA DETECCIÓN DE FIGURAS HUMANAS DESDE ROBOT AÉREO    23/12/2014  38  default 38  174846863   \N  \N
APLICACIÓN WEB PARA EVALUACIÓN DEL DESEMPEÑO Y AUTOCONSULTA DE RECURSOS HUMANOS 15/01/13    39  default 39  10225225K   \N  \N
DESARROLLO DE UNA PLATAFORMA DE SOFTWARE PARA PRUEBAS DE REGRESIÓN AUTOMATIZADAS DE APLICACIONES WEB USADAS EN EL OBSERVATORIO ALMA 10/7/2013   40  default 40  100438413   \N  \N
UTILIZACIÓN DE UNA METODOLOG�?A �?GIL PARA ENTEL S.A. 19/07/2013  41  default 41  141359193   \N  \N
DESARROLLO DE UNA APLICACIÓN DE PROTOTIPO EN LA WEB USANDO TECNOLOG�?A DE LA NUBE    5/8/2013    42  default 42  132978883   \N  \N
SISTEMA DE APOYO A LA GESTIÓN PARA EL PROCESO DE CERTIFICACIÓN DE SOFTWARE QA   17/07/2013  43  default 43  154115919   \N  \N
UNA APLICACIÓN COLABORATIVA PARA APOYAR EL USO DE LA METODOLOG�?A DE SISTEMAS BLANDOS DE PETER CHECKLAND 18/07/2014  44  default 44  167503004   \N  \N
PREDICCIÓN DE LA RENTABILIDAD DE LOS FONDOS DE PENSIONES UTILIZANDO AUTÓMATAS CELULARES 10/7/2013   45  default 45  151166822   \N  \N
CLASIFICADOR DE PUNTOS SOBRE NUBE DE OBJETOS GENERADA POR SISTEMA LIDAR 16/12/2013  46  default 46  153318115   \N  \N
UNA APLICACIÓN MÓVIL QUE APOYA LA REALIZACIÓN DE LA METODOLOG�?A DE SISTEMAS BLANDOS DE PETER CHECKLAND  19/12/2014  47  default 47  171885701   \N  \N
RECURSO DE APRENDIZAJE DE USABILIDAD WEB: UNA APROXIMACIÓN DESDE LA CUARTA HEUR�?STICA DE NIELSEN    23/12/2014  123 default 122 174112924   \N  \N
PROPUESTA DE MEJORAS METODOLÓGICAS PARA LA GESTIÓN DE LA INCERTIDUMBRE EN PROYECTOS DE SOFTWARE �?GILES DESDE UN ENFOQUE DE SISTEMAS BLANDOS 19/12/2014  48  default 48  177402168   \N  \N
SISTEMA DE SOPORTE A EDUCADORES EN ENTORNOS DE EVALUACIÓN Y APRENDIZAJE DE ALUMNOS CON NECESIDADES EDUCATIVAS ESPECIALES EN �?REAS COGNITIVAS    30/07/2014  49  default 49  171233496   \N  \N
DESARROLLO DE UN SISTEMA PERSONALIZABLE PARA QUE PROFESORES TRABAJEN LA INCLUSIÓN DE ALUMNOS CON NECESIDADES ESPECIALES TRANSITORIAS    4/8/2014    50  default 50  176719443   \N  \N
DESARROLLO DE ESTRATÉGIAS DE PLANIFICACIÓN PARA MOTORES DE BÚSQUEDA VERTICALES      51  default 51  175147160   \N  \N
SOFTWARE DE AGENDA PERSONAL Y ASISTENTE PARA ESTRATEGIAS SOCIALES PARA PERSONAS CON S�?NDROME DE ASPERGER    29/07/2014  52  default 52  175863419   \N  \N
PREDICCION DE LA ESTRUCTURA TRIDIMENSIONAL DE PROTEINAS MEDIANTE CLOUD COMPUTING    23/09/2013  53  default 53  180611843   \N  \N
PREDICCIÓN DE L ESTRUCTURA TRIDIMENSIONAL DE PROTE�?NAS MEDIANTE CLOUD COMPUTING 11/3/2014   54  default 54  180611843   \N  \N
ADAPTACIÓN DE ALGORITMOS DE ORDENAMIENTO A M�?QUINAS DE BÚSQUEDA VERTICALES  19/12/12    55  default 55  161228850   \N  \N
IMPLEMENTACIÓN DE ALGORITMOS DE MEJORA DE CLASIFICACIÓN EXTRA�?DOS DESDE EL ESTADO DEL ARTE  21/08/2014  56  default 56  160954361   \N  \N
ESTUDIO Y AN�?LISIS DE HERRAMIENTAS DE PROCESAMIENTO DE DATOS EN STREAMING   19/12/12    57  default 57  17080631K   \N  \N
DISEÑO E IMPLEMENTACIÓN DE UN FIREWALL EN ALTA DISPONIBILIDAD   18/07/2013  58  default 58  164706699   \N  \N
PROTOTIPO DE SOFTWARE DE COMUNICACIÓN A TRAVÉS DE BLUETOOTH PARA USO COMERCIAL Y SOCIAL 20-12-2012  59  default 59  172863027   \N  \N
APLICACIÓN DE APOYO AL PROCESO DE GESTIÓN DE SERVICIOS DE TALLER    14/08/2014  60  default 60  125011268   \N  \N
SISTEMA DE SEGUIMIENTO DE CLIENTES DE UNA EMPRESA INFORM�?TICA       61  default 61  167441882   \N  \N
SISTEMA DE MONITOREO DE VALORES CR�?TICOS QUE APOYE LA GESTIÓN DE LABORATORIOS CL�?NICOS  12/12/2013  62  default \N  158324954   \N  \N
DESARROLO DE BASE DE DATOS PARA OBSERVATORIOS WEB       63  default 62  141459368   \N  \N
ALGORITMO DE IDENTIFICACIÓN DE L�?DERES DE OPINIÓN EN TWITTER    5/12/2014   64  default 63  180486011   \N  \N
SISTEMA DE UBICACIÓN DEL CENTRO DE MASA EN ADULTOS MAYORES A TRAVÉS DE DISPOSITIVOS MÓVILES 4/8/2014    65  default 64  174841691   \N  \N
SIMULACION DE APLICACIOINES UTILIZADAS EN ESCENARIOS DE EMERGENCIA, DESPLEGADAS SOBRE LA PLATAFORMA S4 ADAPTADA A CELULARES 27/09/2013  66  default 65  174135142   \N  \N
APLICACIÓN ANDROID FISCALIZACIÓN CIUDADANA  7/11/2013   67  default 66  170061403   \N  \N
INSTALACIÓN Y CONFIGURACIÓN DE HERRAMIENTA ORACLE ENTERPRICE GOVERNANCE, RISK AND COMPLIANCE, MÓDULO APPLICATION ACCESS CONTROL GOVERNOR    22/07/2013  68  default 67  160158840   \N  \N
SOFTWARE DE EJERCICIOS DE ESTIMULACIÓN Y EVALUACIÓN COGNITIVA PARA PACIENTES CON PARKINSON  19/12/2014  69  default 68  176731303   \N  \N
SOFTWARE DE EJERCICIOS DE ESTIMULACIÓN Y EVALUACIÓN MOTORA PARA PACIENTES CON PARKINSON 19/12/2014  70  default 69  174875642   \N  \N
DESARROLLO DE API PARA AN�?LISIS DE TÓPICOS EN REDES SOCIALES    22/12/2014  71  default 70  169410313   \N  \N
SISTEMA DE SEGUIMIENTO DE JUICIOS APOYAR LA GESTIÓN DE COBRANZA DE EMPRESA RECOLINE 28/11/2012  72  default 71  120101099   \N  \N
SISTEMA WEB DE APOYO A LAS VENTAS Y SERVICIOS TÉCNICOS DE LA EMPRESA IMPORTADORA NORTE  25/09/2012  73  default 72  11266789K   \N  \N
PROTOTIPO DE UN SISTEMA INFORM�?TICO DE POSTULACIÓN, EVALUAVIÓN Y SELECCIÓN DE AYUDANTE DE DOCENCIA      74  default 73  164182169   \N  \N
SISTEMA DE TRAZABILIDAD COMO APOYO AL PROCESO DE ELABORACIÓN DE JUGO/MOSTO  25/01/13    75  default 74  143418700   \N  \N
SISTEMA DE CONTROL DE ASISTENCIA Y APOYO AL C�?LCULO DE REMUNERACIONES BASADOS EN PRODUCCIÓN 26/12/2012  76  default 75  126644930   \N  \N
DISEÑO E IMPLEMENTACIÓN DE ETL PARA SERVICIOS DE LEASING FINANCIERO Y OPERATIVO 9/9/2014    77  default 76  171676568   \N  \N
CENTRAL DE REPORTES PARA EL �?REA DE RIESGOS DE MERCADO DEL BANCO SANTANDER  3/10/2012   78  default 77  155667885   \N  \N
OBSERVATORIO WEB DE PROYECTOS INNOVADORES EN INFORM�?TICA    21/01/2014  79  default 78  175433406   \N  \N
METODOLOG�?A DE GESTIÓN DE PROCESOS ORIENTADA A LA DETERMINACIÓN Y ADMINISTRACIÓN DE RIESGOS OPERACIONAL EN UNA INSTITUCIÓN BANCARIA 29/06/2012  80  default 79  158433761   \N  \N
IMPLEMENTACIÓN DE BPM PARA LA GESTIÓN DOCUMENTAL DE UN SERVICIO PÚBLICO 11/1/2013   81  default 80  121018071   \N  \N
SISTEMA DE ADMINISTRACIÓN DE CAPACITACIONES PARA EMPRESA CAPACITACIÓN USACH LTDA.   21/11/2013  82  default 81  166606322   \N  \N
INTEGRACIÓN DE PLATAFORMA ERP CORPORATIVA CON LICENCIA MEDICA ELECTRONICA Y REDISEÑO DE PROCESOS ASOCIADOS  18/01/13    83  default 82  13471476K   \N  \N
MODELO DE PROCESOS DE LA OTEC USECAP, SEGÚN NORMAS NCH 2728  E ISO 9001/2008. DESARROLLO DE SISTEMA PARA LA TRAZABILIDAD    20/09/2011  84  default 83  123961846   \N  \N
DETECCIÓN DE LOS ACTOS DEL HABLA DE INDAGACIÓN Y PERSUACIÓN UTILIZANDO EN FRAMEWORK DE EXPERIMENTACIÓN. 24/08/2012  85  default 84  164115267   \N  \N
INTEGRACION DEL CONTROL DE UN PROCESO DE NEGOCIOS DE GENERACION DE NOTICIAS CON LA COLABORACION ENTRE PERIODISTAS UTILIZANDO UNA RED SOCIAL CORPORATIVA 1/10/2013   86  default 85  173102771   \N  \N
INFRAESTRUCTURA EMPRESARIAL PARA OBSERVATORIO DE LA WEB: CASO DE LA GENERACIÓN DE NOTICIAS EN UNA RED SOCIAL CORPORATIVA CON UN PROCESO DE NEGOCIO ASOCIADO 22/08/2014  87  default 86  173102771   \N  \N
SISTEMA DE INFORMACIÓN PARA EL APOYO A LA EVALUACIÓN DE LOCALES PARA EMPRESA TACK S.A       88  default 87  160193379   \N  \N
INFERENCIA DE SOMNOLENCIA AL CONDUCIR UN AUTOMÓVIL MEDIANTE LOS MOVIMIENTOS DE LA CABEZA    24/07/12    89  default 88  16633277K   \N  \N
INCORPORACION DE LA DETECCION DEL BOSTEZO EN UN PROTOTIPO RECONOCEDOR DEL ESTADO DE SOMNOLENCIA EN EL DOMINIO DE LA CONDUCCION DE VEHICULOS 30/09/2013  90  default 89  168401795   \N  \N
FORO WEB CON ENFOQUE DE DI�?LOGO DISTRIBUIDO PARA MANTEKA    23/01/2014  91  default 90  174865744   \N  \N
PORTAL WEB CON RED SOCIAL CORPORATIVA PARA LA ORGANIZACIÓN REASE    14/11/2014  92  default 91  174865744   \N  \N
DISEÑO E IMPLEMENTACION DE UN MODULO DE EVALUACION DE RENDIMIENTO ESCALABLE Y MANTENIBLE PARA UNA RED SOCIAL GENERADORA DE NOTICIAS 14/10/2013  93  default 92  166489229   \N  \N
EVALUACIÓN Y MEJORA DE LA INFRAESTRUCTURA DE UNA RED SOCIAL GENERADORA DE NOTICIAS MEDIANTE MONITORES DE RENDIMIENTO DE SOFTWARE    26/07/2012  94  default 93  166489229   \N  \N
DISEÑO E IMPLEMENTACIÓN DE ALGORITMOS PARALELOS DE RECONTRUCIÓN DE IM�?GENES BASADOS EN EL PARADIGMA "ESPACIO DE DIRECCIONES GLOBALES PARTICIONADO".     143 default 142 166612799   \N  \N
DESARROLLO DE UNA PLATAFORMA DE SOFTWARE PARA LA RECAUDACIÓN EN L�?NEA MODALIDAD PRESENCIAL ENTRE INSTITUCIONES RECAUDADORAS AUTORIZADAS Y LA TESORER�?A GENERAL DE LA REPUBLICA  17/07/2013  95  default 94  14059203K   \N  \N
SISTEMA DE GESTIÓN DE INFORMACIÓN TRANSPARENTE PARA EDIFICIOS DE DEPARTAMENTOS  27/07/2012  124 default 123 159073122   \N  \N
DETECCIÓN DE NIVELES DE ESTRÉS  A TRAVÉS DEL PROCESAMIENTO DE LA VOZ EN TELÉFONOS INTELIGENTES  20/12/2013  96  default 95  167834566   \N  \N
HERRAMIENTA DE EXPERIMENTACIÓN CONFIGURABLE QUE PERMITA  COMPARAR Y PROBAR ALGORITMOS DE RECOMENDACIÓN CON EL FIN DE GENERAR  DISPONIBIZAR SERVICIOS DE RECOMENDACIÓN PARA DISTINTOS TIPOS DE REDES SOCIALES    6/7/0212    97  default 96  161509299   \N  \N
GENERACIÓN ASISTIDA DE DOCUMENTOS COTIDIANOS PARA PERSONAS CON DISCAPACIDAD INTELECTUAL.    20/07/2012  125 default 124 166099838   \N  \N
SOFTWARE COMO LABORATORIO PARA PROBAR Y EVALUAR ALGORITMOS DE RECOMENDACIÓN COLABORATIVA        98  default 97  172562752   \N  \N
PROPUESTA PRUEBA    24/04/2015  595 1/2015  589 176744650   f   \N
DESARROLLO DE HERRAMIENTAS PARA MEDIR COMPETENECIAS EN APRENDIZAJE BASADO EN PROYECTOS  13/08/2014  99  default 98  158896222   \N  \N
DETECCIÓN DE FALLAS EN LA RED DE SUMINISTRO DE BANDA ANCHA UTILIZANDO EL PROTOCOLO RADIUS   24/07/2012  126 default 125 165707036   \N  \N
SOFTWARE DE APOYO EN EL RECONOCIMEINTO DE MENTIRAS EN VICTIMAS DE ABUSO SEXUAL INFANTIL 7/7/2014    100 default 99  151765637   \N  \N
DESARROLLO DE UN SERVICIO DE INTEGRACIÓN PARA ACTUALIZAR SERVICIOS DE RECOMENDACIÓN DE ETIQUETAS EN UNA RED SOCIAL EMPRESARIAL DE NOTICIAS  02/01/03    101 default 100 169428182   \N  \N
LOCALIZACION DISTRIBUIDA DE STREAMS PARA EL PROCESAMIENTO DE EVENTOS EN TIEMPO REAL 23/09/2013  127 default 126 174890412   \N  \N
CONTINUOUSDELIVERY DE SERVICIOS DE RECOMENDACIÓN EN UNA RED SOCIAL EMPRESARIAL DE NOTICIAS  22/05/2014  102 default 101 169428182   \N  \N
DESARROLLO DE UN ETIQUETADOR INTERACTIVO DE DOCUMENTOS DENTRO DE UN PROCESO DE NEGOCIOS DE GENERACIÓN DE NOTICIAS.  7/7/2012    103 default 102 154010335   \N  \N
SISTEMA DE RECOMENDACION Y DIFUSION PARA MOVILES    24/09/2013  128 default 127 180963820   \N  \N
SISTEMA DE ADMINISTRACION AGIL PARA MULTIPLES PROYECTOS 30/09/2013  104 default 103 171219698   \N  \N
SELECCIÓN DE IMPLEMENTACIÓN DE ALGORITMO DE RECOMENDACIÓN BASADO EN TGS EN UNA RED SOCIAL GENERADORA DE NOTICIAS        105 default 104 169849900   \N  \N
MEJORAR LA TOLERANCIA A FALLAS EN UN SISTEMA DE PROCESAMIENTO DE EVENTOS SOBRE DISPOSITIVOS MOVILES 23/09/2013  129 default 128 161670960   \N  \N
ALGORITMO DE RECOMENDACIÓN DE TAGS BASADO EN CLUTERS PARA UNA RED SOCIAL DE NOTICIAS    12/5/2014   106 default 105 169849900   \N  \N
PROTOTIPO DE SUITE AFECTIVA PARA EL ANALISIS DE LA SATISFACCIÓN DEL USUARIO.    s/f 107 default 106 157002880   \N  \N
SISTEMA DE REPUTACIÓN PARA LA RED SOCIAL WAZE   22/12/2014  130 default 129 97829736    \N  \N
AUTOMATIZACION DEL PROCESO DE CONTRATACION DE PROFESORES POR HORA PARA LA FACULTAD DE INGENIERIA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE 30/09/2013  108 default 107 173796773   \N  \N
DESARROLLO DE SISTEMAS WORKFLOW PARA EL PLANTEAMIENTO Y VERIFICACIÓN DE COMPETENCIAS DE MANEJO DE PROYECTOS EN LOS CURSOS DE INGENIER�?A CIVIL INFORM�?TICA   18/08/2014  109 default 108 174043221   \N  \N
DISEÑO MOTODOLÓGICO PARA LA ELABORACIÓN Y DESARROLLO DE SECUENCIAS DE ACTIVIDADES INTERACTIVAS PARA LA ENSEÑANZA DEL CAMPO ADICTIVO EN EL PRIMER CICLO B�?SICO   NO  131 default 130 161163813   \N  \N
RECONOCEDOR DE SONRISAS ANSIOSAS EN SITUACIONES EXPERIMENTALES PARA PESQUISAR ENGAÑO    18/08/2014  110 default 109 169074526   \N  \N
“DESCRIPCIÓN ARQUITECTURAL DE UN SISTEMA GENERADOR DE SERVICIOS DE RECOMENDACIÓN PARA OBSERVATORIOS DE LA WEB�?  23/07/2012  111 default 110 16556717K   \N  \N
SISTEMA PARA GUIAR LA REALIZACIÓN DE ACTIVIDADES ESCOLARES EN CASA  7/1/2012    132 default 131 16955594K   \N  \N
MANUAL PARA SELECCIONAR SUITES BMP CON CRITERIOS DE FUNCIONALIDAD Y USABILIDAD: CASO DE PROCESO DE GENERACIÓN DE NOTICIAS   5/3/2013    112 default 111 72002393    \N  \N
GENERACIÓN DE DATASETS CON ESQUEMA EST�?NDAR PARA ENTRENAR ALGORITMOS DE RECOMENDACIÓN PARA REDES SOCIALES   23/07/2012  113 default 112 166912644   \N  \N
PROTOTIPO FUNCIONAL DE UNA RED SOCIAL VERTICAL PARA EL SOFTWARE GREI    24/07/2012  133 default 132 171754755   \N  \N
SISTEMA DE CONTROL DE CONTRATO CON KANBAN   21/12/12    114 default 113 107046844   \N  \N
DISEÑO Y DESARROLLO DE UN FRAMEWORK DE NOTIFICACIONES V�?A MENSAJER�?A SMS    17/12/12    115 default 114 11473909K   \N  \N
ANALISIS BIOMECANICA DE ANGULOS EN LA SALIDA DE TACOS       134 default 133 163215454   \N  \N
VISUALIZANDO DI�?LOGOS EN COMUNIDADES VIRTUALES DE APRENDIZAJE   6/8/2014    116 default 115 169091749   \N  \N
DESARROLLO DE APLICACIONES WEB PARA ORGANIZACIONES SIN FINES DE LUCRO POR MEDIO DE LA ARQUITECTURA DE LA INFORMACIÓN    21/03/2014  117 default 116 167395333   \N  \N
DESARROLLO DE SISTEMA DE COTIZACIÓN Y DE CONTROL DE EXISTENCIAS PARA LA EMPRESA ALUMAR  19/07/2012  135 default 134 17325752K   \N  \N
CONSTRUCCION DE UNA INFRAESTRUCTURA EMPRESARIAL PARA UN SISTEMA DE GENERACIÓN DE NOTICIAS CON ETIQUETADO SOCIAL EN UNA RED SOCIAL CORPORATIVA   15/11/2012  118 default 117 139056736   \N  \N
INTERACCIÓN DE SERVICIOS POR EL MEDIO DE UNA INFRAESTRUCTURA SOA, PARA REALIZAR RECOMENDACIONES EN UNA INTERNET DE GENERACIÓN DE NOTICIAS       119 default 118 156976261   \N  \N
SISTEMA DE RECONOCIMIENTO Y DIGITALIZACIÓN DE IM�?GENES DE PARTITURAS ESCRITAS A MANO        136 default 135 156612529   \N  \N
ETIQUETADO EMOCIONAL IMPL�?CITO EN REDES SOCIALES DE NOTICIAS    24/07/12    120 default 119 166054109   \N  \N
SELECCIÓN DE PERSONAS BAJO EL ENFOQUE DE LA DIRECCIÓN POR VALORES   24/07/2012  121 default 120 168849516   \N  \N
OBJETIVOS DE APRNEDIZAJE PARA APOYART LA COMPRENSION Y APLICACION DE LA CRIPTOGRAFIA CLASICA        137 default 136 162648640   \N  \N
EL ENFOQUE DI�?LOGO-ACCIÓN: CASO DE LAS ACTAS DIALÓGICAS EN SCRUM USANDO TABLEROS KANBAN 23/12/2014  122 default 121 173387903   \N  \N
SISTEMA DE SEGUIMIENTO A CLIENTES Y DE APOYO A LAS REPARACIONES PARA UN TALLER MEC�?NICO 23/07/12    138 default 137 137750406   \N  \N
SISTEMA DE VISUALIZACION DEL POSICIONAMIENTO GEORREFERENCIAL ON-LINE DE EQUIPOS DE EXTRACCION MINERA    20/09/2011  139 default 138 92174379    \N  \N
ESTRATEGIA DE PARALELIZACION DE SIMULACIONES DE EVENTOS DISCRETOS E INDEPENDIENTES EN GPU   30/09/2013  140 default 139 179043939   \N  \N
RESOLUCIÓN DEL GENERALIZED MINIMUN SPANNING TREE PROBLEM MEDIANTE ALGORITMOS GENÉTICOS      141 default 140 158407337   \N  \N
CARACTERIZACIÓN Y OPTIMIZACIÓN DEL USO DE LA MEMORIA CACHE PARA EL ALGORITMO DE RECONSTRUCCIÓN ESTAD�?STICO DE IM�?GENES MÉDICAS EM-ML.   23/08/10    142 default 141 150881609   \N  \N
UNA ARQUITECTURA DISTRIBUIDA MULTIPLATAFORMA APLICADA A SIMULACIONES MONTE CARLO    1/7/2014    144 default 143 175657436   \N  \N
DISEÑO DE UNA API PARA LA IMPLEMENTACIÓN DE ALGORITMOS ESTAD�?STICOS DE RECONSTRUCCIÓN TOMOGR�?FICA DE IM�?GENES       145 default 144 171464765   \N  \N
MODELACIÓN Y SIMULACIÓN DEL ESC�?NER PET SIEMENS BIOGRAPH    26/12/12    146 default 145 171002761   \N  \N
MODELAMIENTO E IMPLEMENTACION ORIENTADA A OBJETOS DE SIMULACIONES MONTE CARLO CONCURRENTES EN BIOLUMINISCENCIA MEDIANTE EL USO DE LA EXTENSION UC++     147 default 146 168396449   \N  \N
ESTUDIO E IMPLEMENTACIÓN DE ALGORITMOS ESTAD�?STICOS PARALELOS, PARA LA RECONSTRUCCIÓN DE IM�?GENES.  23/08/10    148 default 147 143831639   \N  \N
HERRAMIENTA DE DISEÑO DE OBJETOS Y VISUALIZACIÓN DE RESULTADOS PARA SIMULACIÓN DE CAMPO MAGNÉTICO   7/7/2014    149 default 148 171907233   \N  \N
RECONTRUCCIÓN TOMOGR�?FICA PARALELA PARA UN ESC�?NER PET DE ANIMALES PEQUEÑOS     150 default 149 155648511   \N  \N
SIMULACIÓN MONTE CARLO PARALELA DEL MODELO HEISENBERG PARA SISTEMAS FERROMAGNÉTICOS 20/01/2014  151 default 150 171052386   \N  \N
DESARROLLO Y APLICACIÓN DE MODELO DIN�?MICO EN AMBIENTE REAL DE CONMINUCIÓN PARA ESTIMAR EN LINEA VARIABLES CR�?TICAS DE MOLIENDA SEMIAUTÓGENA    7/9/2012    152 default 151 142035928   \N  \N
PREDICCIÓN DE FENÓMENOS S�?SMICOS EN UN �?REA GEOGR�?FICA DETERMINADA USANDO REDES NEURONALES  26/12/12    153 default 152 166171644   \N  \N
AN�?LISIS COMPARATIVO DE MODELOS NARMA (X) Y NAR (X) USANDO REDES NEURONALES Y SVM SOBRE SISTEMAS CAÓTICOS   28/12/12    154 default 153 168401264   \N  \N
SISTEMA DE PREDICCIÓN DEL TR�?FICO DE UN MOTOR DE BÚSQUEDA WEB       155 default 154 139047788   \N  \N
PREDICCION DE SERIES DE TIEMPO USANDO RN Y SVM      156 default 155 173249616   \N  \N
CONSTRUCCIÓN DE MODELOS PREDICTIVOS PARA EL �?NDICE DE DISPONIBILIDAD DE LOS EQUIPOS MINEROS PESADOS USANDO MODELOS DIN�?MICOS CON RNA Y SVM  22/01/2014  157 default 156 170842804   \N  \N
PREDICCIÓN DE FENÓMENOS S�?SMICOS EN UN �?REA GEOGR�?FICA DETERMINADA USANDO REDES NEURONALES Y M�?QUINAS DE VECTORES DE SOPORTE        158 default 157 166928370   \N  \N
SISTEMA PROTOTIPO DE APOYO A LA ALERTA TEMPRANA DE SISMOS MEDIANTE USO DE HERRAMIENTAS DE INTELIGENCIA COMPUTACIONAL    4/8/2014    159 default 158 176314141   \N  \N
SISTEMA INFORMATICO PARA LA PREDICCIÓN DE FALLAS EN ANTENAS DEL OBSERVATORIO ALMA, UTILIZANDO HERRAMIENTAS DE INTELIGENCIA COMPUTACIONAL    31/07/2013  160 default 159 136865250   \N  \N
DISEÑO Y EVALUACIÓN DE UN MODELO CUANTITATIVO DE ESTIMACIÓN DE COMPONENTES MINERALÓGICOS DE ARCILLAS, A TRAVÉS DEL AN�?LISIS DEL ESPECTROGRAMA DEL INFRARROJO CERCANO (NIR), BASADO EN ALGORTIMOS COMPUTACIONALES, PARA EMPRESAS CUPR�?FERAS. 7/11/2013   161 default 160 16171898K   \N  \N
MODELO DIN�?MICO PARA LA GESTIÓN DE FLOTAS DE PALAS EN FAENAS MINERAS    23/01/2014  162 default 161 166632749   \N  \N
ELABORACIÓN DE CLASIFICADORES PARA DETECCIÓN DE SEÑALES DE TIPO S Y P MEDIANTE REDES NAURONALES Y SVM   7/8/2012    163 default 162 16939816K   \N  \N
ELABORACION DE UN CLASIFICADOR DE SEÑALES SISMOGRAFICAS P Y S MEDIANTE SVM: ESTUDIO DE ALGORITMOS DE FILTRADO Y AUTOSIMILARIDAD 30/09/2013  164 default 163 170721993   \N  \N
CONSTRUCCIÓN DE UN MODELO PARA DETERMINAR VARIABLES DE DISPONIBILIDAD Y TIEMPO ENTRE FALLAS EN EL �?REA DE LA MINER�?A    24/12/2014  165 default 164 181181486   \N  \N
SISTEMA COLABORATIVO WEB PARA EL AN�?LISIS Y EVALUACIÓN DE PLANES ESTRATÉGICOS       166 default 165 158384043   \N  \N
SISTEMA COLABORATIVO DE APOYO AL APRENDIZAJE DE MATEM�?TICAS EN PRIMER AÑO B�?SICO        167 default 166 169367353   \N  \N
DESARROLLO DE UN SISTEMA COLABORATIVO PARA APOYAR EL REFORZAMIENTO DEL IDIOMA INGLÉS EN NIÑOS DE 5Tº AÑO B�?SICO 9/2/2012    168 default 167 170508157   \N  \N
SISTEMA COLABORATIVO PARA LA PLANIFICACIÓN DE PROYECTOS MEDIANTE CARTAS GANTT.      169 default 168 161915602   \N  \N
SISTEMA COMUNICACIÓN MEDIADA COMPUTADOR PARA APOYAR EL A�?NILIS DE TEMAS EN GRUPOS       170 default 169 166602181   \N  \N
SISTEMA DE APOYO AL  AN�?LISIS DE ASUNTOS PARA LA INGENIER�?A DE REQUERIMIENTOS ORIENTADA A ASPECTOS  26/10/2012  171 default 170 170630025   \N  \N
SOFTWARE DE APOYO AL SEGUIMIENTO DEL PLAN ESTRATÉGICO DE LA EMPRESA PÚBLICA EMERES  23/10/2013  172 default 171 153400253   \N  \N
SISTEMA COLABORATIVO PARA APOYAR LA PREPARACIÓN DE ENTREVISTAS Y SU POSTERIOR AN�?LISIS EN EL PROCESO DE CAPTURA DE REQUISITOS.      173 default 172 163578476   \N  \N
SISTEMA COLABORATIVO PARA COMPLEMENTAR LA ENSEÑANZA DE NIÑOS ENTRE PRIMERO Y SEGUNDO B�?SICO EN LA ASIGNATURA DE INGLÉS      174 default 173 170256158   \N  \N
UN MODELO PARA LA ESTIMULACIÓN DEL ESFUERZO EN PROYECTOS DE DESARROLLO DE SOFTWARE.     175 default 174 162156055   \N  \N
DESARROLLO DE UNA GU�?A DE ESTRATEGIAS EN APOYO A LA INGENIER�?A DE REQUISITOS        176 default 175 165570820   \N  \N
GENERACIÓN DE UN JUEGO COLABORATIVO QUE PERMITA EL DESARROLLO DE HABILIDADES METAFONOLÓGICAS EN NIÑOS DE ENTRE 4 Y 6 AÑOS       177 default 176 170052781   \N  \N
SISTEMA WEB Y MOVIL PARA FOMENTAR EL TURISMO    23/09/2013  178 default 177 180486011   \N  \N
SISTEMA DE COORDINACIÓN DE ACTIVIDADES ACADÉMICAS, REGISTRO DE NOTAS Y PLANES DE ESTUDIO PARA UNA ESCUELA DE ENSEÑANZA B�?SICA       179 default 178 159166422   \N  \N
APLICACIÓN PARA MEJORAR EL SEGUIMIENTO DEL RENDIMIENTO Y LA CONDUCTA DE LOS ALUMNOS EN EL AULA DE CLASES        180 default 179 172135528   \N  \N
SISTEMA DE GESTIÓN DE AYUDAS A PROYECTOS E IDEAS (GAPI)     181 default 180 167995314   \N  \N
AUTOMATIZACIÓN DE PROCESOS DE INSPECCIONES DE VEH�?CULOS PARA RSA SEGUROS        182 default 181 141610120   \N  \N
EVALUACIÓN DE LA EFECTIVIDAD DE UNA PROPUESTA DE TOMA DE REQUIRIMIENTOS BASADA EN CIENCIAS SOCIALES.        183 default 182 158385686   \N  \N
EVALUACIÓN DE LA EFECTIVIDAD Y REFORMULACIÓN DE UNA PROPUESTA PARA LA ROMA DE REQUERIMIENTOS APLICADO A UN CASO PR�?CTICO        184 default 183 158385686   \N  \N
METODOLOGIA DE HACKING ETICO PARA APLICACIONES WEB EN PRODUCCION    20/07/2012  185 default 184 171212243   \N  \N
DESARROLLO DE APLICACIÓN COLABORATIVA PARA LA EVALUACIÓN DE USABILIDAD DE SOFTWARE STANDALONE BASADO EN FORMULARIO  22/04/2013  186 default 185 160076747   \N  \N
SISTEMA DE APOYO AL APRENDIZAJE DE LA LECTURA DE LOS NIÑOS      187 default 186 152509022   \N  \N
APLICACIÓN WEB PARA ADMINISTRACIÓN DOCUMENTAL DE VEH�?CULOS  16/12/2013  330 default 328 163652838   \N  \N
HERRAMIENTA DE APOYO A LA DEFINICIÓN DE REQUISITOS, EN LA INGENIER�?A DE SOFTWARE, EXPLOTANDO RECURSOS DE AUDIO  11/1/2013   188 default 187 153877009   \N  \N
EVALUACIÓN Y RECOMENDACIONES DE MEJORAS DE LA USABILIDAD DE BROWSERS WEB PARA USUARIOS ADULTOS MAYORES CON POCA EXPERIENCIA EN EL USO DE COMPUTADORES.      189 default 188 161168440   \N  \N
SISTEMA COOPERATIVO PARA EL DESARROLLO DE INTERFACES GR�?FICAS       190 default 189 184407604   \N  \N
SISTEMA DE APLICACIONES PARA EL APOYO EN LA INTERACCIÓN ANFITRIÓN-AUDIENCIA Y LA GENERACIÓN DE CONTENIDO EN PRESENTACIONES CON PROYECTOR    14/08/2014  191 default 190 169113823   \N  \N
DESARROLLAR UN AMBIENTE WEB QUE PERMITA REPRESENTAR  INFORMACIÓN ASOCIADA AL CRÉDITO HIPOTECARIO UTULIZANDO ORGANIZADORES GR�?FICOS PARA VIRTUALAB - USACH   4/4/2013    192 default 191 169561249   \N  \N
DESARROLLO DE COMPONENTES DE SOFWARE EN HTML 5 QUE IMPLEMENTEN ORGANIZADORES GRAFICOS INTERACTIVOS      193 default 192 169561249   \N  \N
DESARROLLO DE UN AMBIENTE WEB UTILIZANDO ORGANIZADORES GR�?FICOS EN LA REPRESENTACIÓN DE CONTENODOS SOBRE EL INFARTO AGUDO AL MIOCARDIO.     194 default 193 161509299   \N  \N
DESARROLLO DE COMPONENTES DE SOFWARE QUE IMPLEMENTEN ESTRATEGIAS VISUALES PARA LA PRUDUCCIIÓN DE TEXTO ARGUMENTATIVO TIPO ENSAYO DE NIVEL B�?SICO TRES A SEIS.       195 default 194 162648640   \N  \N
DESARROLLO DE COMPONENTES DE SOFWARE PARA LA PRODUCCIÓN DE CUENTOS INFANTILES       196 default 195 154010335   \N  \N
DESARROLLO DE UN AMBIENTE WEB PROTOTIPO QUE PERMITA REPRESENTAR INFORMACIÓN DEL CRÉDITO HIPOTECARIO UTILIZANDO ORGANIZADORES GR�?FICOS.      197 default 196 139047788   \N  \N
DESARROLLO DE COMPONENTES DE SOFTWARE QUE IMPLEMENTEN DIAGRAMAS UTILIZADOS EN LA PLANEACIÓN ESTRATÉGICA.        198 default 197 162430947   \N  \N
DESARROLLO DE COMPONENTES DE SOFWARE PARA LA IMPLEMENTACIÓN DE HERRAMIENTAS QUE FACILITEN LA UTILIZACIÓN DE DIAGRAMAS PARA LA PLANIFICACIÓN DE MARKETING.       199 default 198 162433903   \N  \N
DISEÑO E IMPLEMENTACIÓN DE COMPONENTES DE SOFTWARE VISUALES QUE FACILITEN EL DESARROLLO DE LA HABILIDAD COGNITIVA DE LA CLASIFICACIÓN.      200 default 199 158433761   \N  \N
DESARROLLO DE COMPONENTES DE SOFTWARE QUE IMPLEMENTAN ESTRATEGIAS VISUALES PARA APOYAR LA CONCEPTUALIZACIÓN DE FRACCIONES EN ALUMNOS DE CUARTO B�?SICO.      201 default 200 162774778   \N  \N
DESARROLLO DE COMPONENTES DE SOFTWARE PARA FACILITAR LA PRODUCCIÓN DE TEXTO DISCURSIVO DE ALUMNOS ENTRE 5º Y 8º AÑO DE ENSEÑANZA B�?SICA.        202 default 201 153182051   \N  \N
DESARROLLO DE COMPONENTES VISUALES DE APOYO A COBIT.        203 default 202 160076747   \N  \N
DISEÑO E IMPLEMENTACIÓN DEL SISTEMA CAJA VECINA EN APLICACIONES TRANSACCIONALES DEL BANCO ESTADO    28/11/12    204 default 203 10797136K   \N  \N
SOLUCIÓN BASADA EN ESB PARA MIGRAR SOTWARE LEGADO CRITICO EN EL SISTEMA PÚBLICO 4/1/2013    205 default 204 130555292   \N  \N
PROYECTO INTRANET DE GENDARMER�?A DE CHILE   10/1/2013   206 default 205 130594220   \N  \N
IMPLEMENTACIÓN DE UN TERCER FACTOR DE AUTENTICACIÓN PARA AUTORIZACIÓN DE TRANSACCIONES EN LA BANCA INTERNET 21/11/2012  207 default 206 126560028   \N  \N
DISEÑO E IMPLEMENTACIÓN DEL PORTAL WEB PARA LA MUNICIPALIDAD DE HIJUELAS    5/12/2012   208 default 207 165393678   \N  \N
SISTEMA ONLINE DE ENSEÑANZA DE ESTRATEGIAS ORIENTADO A LOS PADRES PARA APOYAR LAS TAREAS ESCOLARES DE LOS HIJOS 9/2/2012    209 default 208 162696513   \N  \N
SISTEMA DE GESTIÓN PARA EL HUERTO SANTA MERCEDES        210 default 209 173110189   \N  \N
CREACIÓN Y APLICACIÓN DE OBJETOS DE APRENDIZAJES PARA EL APOYO A PROGRAMACIÓN COMPUTACIONAL 14/12/12    211 default 210 165385454   \N  \N
OBTENCIÓN DE LA CARGA ANUAL EQUIVALENTE (CAE) Y CARGA ANUAL EQUIVALENTE VIGENTE (CAEV) UTILIZANDO UN MÉTODO MATEM�?TICO PARA LA EMPRESA PENTAVIDA    30/10/12    212 default 211 161915602   \N  \N
DESARROLLO E IMPLEMENTACIÓN DE LA ESTACIÓN DE TRABAJO EVEREST PARA EL BANCO DE CRÉDITO E INVERSIONES    20/3/13 213 default 212 163107155   \N  \N
CONSTRUCCIÓN Y APLICACIÓN DE OBJETOS DE APRENDIZAJE PARA LA UNIDAD DE AN�?LISIS LÉXICO DE LA ASIGNATURA COMPILADORES 20/01/13    214 default 213 151265588   \N  \N
UN SISTEMA WEB PARA MEJORAR EL RENDIMIENTO DE IMPRESORAS AL ENVIAR TRABAJOS DE IMPRESIÓN MASIVA     215 default 214 141749579   \N  \N
LABORATORIO VIRTUAL DE MATEM�?TICAS "LABMAT3EM" PARA ESTABLECIMIENTOS MUNICIPALIZADOS        216 default 215 167883273   \N  \N
LABORATORIO VIRTUAL DE MATEM�?TICAS "LABMAT3EM" PARA ESTABLECIMIENTOS MUNICIPALIZADOS        217 default 216 167883273   \N  \N
UN SISTEMA DE APOYO AL PROCESO DE TITULACIÓN PARA EL DEPARTAMENTO DE INGENIER�?A INFORM�?TICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE      218 default 217 16121874K   \N  \N
NO HAY INFORMACION      219 default 218 101426750   \N  \N
SISTEMA DE REMUNERACIONES MODULO DE RELIQUIDACIONES 30/11/2012  220 default 219 143771512   \N  \N
SOLUCION INFORMATICA PARA SOLICITUDES DE INSCRIPCIONES DE ASIGNATURAS   4/8/2010    221 default 220 66163636    \N  \N
SISTEMA DE APOYO AL CONTROL DE GASTOS Y VIAJES DE VEH�?CULOS DE SERVICIOS DE TRANSPORTE DE LA EMPRESA TRASANDES S.A  24/09/2013  222 default 221 166944589   \N  \N
SISTEMA WEB DE APOYO A LA GESTON DE ADQUISICIONES DE MATERIALES DE CONSTRUCCION DE LA CONSTRUCCION KOPPMANN 7/4/2011    223 default 222 143404773   \N  \N
SISTEMA WEB DE APOYO A LA ADMINISTRACION DEL GIMNASIO "PUNTO VITAL" 20/09/2011  224 default 223 153150958   \N  \N
SISTEMA DE BUSQUEDA Y VISUALIZACIÓN DE INFORMACIÓN PARA LA BIBLIOTECA CIENT�?FICA DE CONICYT 20/09/11    225 default 224 132541159   \N  \N
SISTEMA DE GESTIÓN DE COMPRA DE VEH�?CULOS Y EQUIPAMIENTOS PARA EMPRESA SALFA RENT   30/11/12    226 default 225 15890828k   \N  \N
ADMINISTRACIÓN Y TRACKING DE ACTIVOSDE UNA EMPRESA DE SERVICIOS DE ARRIENDO DE CONTENEDORAS 23/01/2013  227 default 226 135486108   \N  \N
APLICACIÓN WEB PARA APOYAR LA GESTIÓN DE M�?QUINAS VIRTUALES EN LA EMPRESA ADESSA LTDA.  07/0912 228 default 227 128773843   \N  \N
UN SISTEMA PARA LA GESTION DE FALLAS EN CENTRALES ELECTRICAS    22/05/2012  229 default 228 139141628   \N  \N
UNA HERRAMIENTA DE APOYO A LA EVALUACIÓN DEL CONTROL INTERNO EN COOPERATIVAS DE AHORRO Y CREDITO    30/11/12    230 default 229 143180646   \N  \N
AUTOMATIZACIÓN DE LA INVITACIÓN A OFERTAR EN LICITACIONES DE SAP - SRM EN CODELCO   8/4/2013    231 default 230 106677514   \N  \N
IMPLEMENTACIÓN DE PLATAFORMA DE ALTA DISPONIBILIDAD PARA SISTEMA WEB    26/12/12    232 default 231 16178883K   \N  \N
SISTEMA WEB DE APOYO AL CONTROL ACADÉMICO PARA LA ACADEMIA POLITÉCNICA AERON�?UTICA DE FUERZA AÉREA DE CHILE 11/7/2012   279 default 278 163215454   \N  \N
SISTEMA DE LICENCIAS MEDICAS EN UNA CAJA DE COMPENSACION    4/8/2010    422 default 420 130273513   \N  \N
DESARROLLO UN SISTEMA DE APOYO A LA PLANIFICACION DOCENTE PARA EL DEPARTAMENTO DE INGENIERIA INFORMATICA DE LA FACULTAD DE INGENIERIA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE        233 default 232 167485081   \N  \N
SISTEMA PARA LA ADMINISTRACIÓN DE PROVEEDORES Y PRODUCTOS DE LA MICROEMPRESA FCI LTDA.      234 default 233 166606322   \N  \N
SISTEMA PARA LA CERTIFICACIÓN Y SUPERVISIÓN DE VENTA DE MÚSICA DIGITALIZADA 11/1/2013   235 default 234 132803188   \N  \N
PROPUESTA PRUEBA 2  29/04/2015  597 1/2015  591 172288987   f   \N
SISTEM DE FACTURACIÓN ENTRE SOCIEDADES DE ENJOY POR CANJE DE PROMOCIONES Y PRESTACIÓN DE SERVICIOS      236 default 235 138381072   \N  \N
CREACIÓN DE UN SISTEMA GENERADOR DE DIFERENTES SERIES DE INSTRUMENTOS DE EVALUACIÓN PARA LA COORDINACIÓN DE FUNDAMENTOS DE COMPUTACIÓN Y PROGRAMACIÓN DE LA UNIVERSIDAD DE SANTIAGO DE CHILE    18/08/2014  237 default 236 173865090   \N  \N
PROPUESTA DEL GLEN  30/04/2015  596 1/2015  590 167110614   f   \N
DESARROLLO DE APLICACIÓN MÓVIL PARA MONITOREO, DETECCIÓN Y ALERTA AUTOM�?TICA DE CRISIS EPILÉPTICA CONVULSIVA        238 default 237 15068143K   \N  \N
SISTEMA ADMINISTRADOR DE ACCESOS PARA USUARIOS EN SAP       239 default 238 139060806   \N  \N
PREDICCIÓN DE ESTADIA DE PACIENTES HOSPITALIZADOS EN LA UNIDAD DE CUIDADOS INTENSIVOS ADULTOS EN UNA CLINICA PRIVADA DE SANTIAGO    1/10/2014   240 default 239 151737943   \N  \N
AN�?LISIS Y DESARRLLO DE UN DSS PARA LA SELECCIÓN DE PERSONAS TI 10/5/2010   241 default 240 156039020   \N  \N
DESARROLLO DE UN SISTEMA DE SERVICIOS DE MAPAS WEB PARA VISUALIZACION Y USO DE PRODUCTOS TOPOGRAFICOS ELABORADOS POR EL SAF     242 default 241 138819280   \N  \N
EVALUACIÓN DEL EFECTO DE FACTORES EXTERNOS EN LA RESOLUCIÓN DE UN PROBLEMA NP-C UTILIZANDO JUEGOS COMPUTACIONALES.  4/7/2011    243 default 242 141976974   \N  \N
SISTEMA WEB PARA POTENCIAR RELACION DE CLIENTES Y PROVEEDORES DE DISTRIBUIDORAS DE ABARROTES, LICORES Y CARNES  7/4/2011    244 default 243 139371127   \N  \N
MODELO PARA LA ESTIMACIÓN DE LA VARIABILIDAD DE LOS COSTOS EN LA FORMULACIÓN DE PROYECTOS DE TECNOLO G�?AS DE LA INFORMACIÓN.        245 default 244 162156055   \N  \N
PROTOTIPO DE SOFTWARE Y ESTUDIO DE MERCADO DE UNA PLATAFORMA SOCIAL DE APRENDIZAJE. 6/9/2010    246 default 245 158377365   \N  \N
NO HAY INFORMACION      247 default 246 130680526   \N  \N
MODELO PREDICTIVO PARA LA VENTA-CRUZADA DE PRODUCTOS FINANCIEROS UTILIZANDO MINER�?A DE DATOS.       248 default 247 139056736   \N  \N
SISTEMA PARA EL SEGUIMIENTO Y CONTROL DE LA OPERATIVIDAD DE SERVIDORES DEL AREA TIC DE CARABINEROS DE CHILE 4/8/2010    249 default 248 134405155   \N  \N
SISTEMA DE REALIDAD AUMENTADA PARA LA DIFUSIÓN DE INFORMACIÓN DE LA UNIVERSIDAD DE SANTIAGO DE CHILE    14/01/2013  250 default 249 169087350   \N  \N
DESARROLLO E IMPLEMENTACIÓN DE APLICACIÓN MÓVIL EN ANDROID PARA EL CONTROL PERSONALIZADO DE LA ALIMENTACIÓN 22/01/2014  251 default 250 173819803   \N  \N
PROTOTIPO PARA LA DETECCIÓN DE MALWARE EN EL SISTEMA OPERATIVO      252 default 251 169039682   \N  \N
DISEÑO E IMPLEMENTACIÓN DE SISTEMA DE INFORMACIÓN DE APOYO DE GESTIÓN DE INVENTARIO DE LA EMPRESA COMERCIAL E INDUSTRIAL BERMUDAS S.A.      253 default 252 172552609   \N  \N
SISTEMA WED PARA SUBASTAR VIDEOS DE CAZANOTICIAS ENTRE CANALES DE TELEVISIÓN    23/07/2012  254 default 253 172320104   \N  \N
DATAMART PARA UN SISTEMA DE REPORTES DE TIEMPOS EN L�?NEA DE ENLACES DE TELECOMUNICACIONES   30/07/2013  255 default 254 141234153   \N  \N
UN PROTOTIPO DE SOFWARE DE APOYO PARA EL TEST DE CAFRA.     256 default 255 163867052   \N  \N
SISTEMA DE FACTURACIÓN ELECTRÓNICA, INVENTARIO Y PRESUPUESTOS WEB PARA TALLER DE TORNER�?A TRIFLEX   9/2/2012    257 default 256 16569953K   \N  \N
SISTEMAS PARA LA DETECCIÓN PREVENTIVA DE BAJOS RENDIMIENTOS ACADÉMICOS DE ALUMNOS DEL MÓDULO B�?SICO DE LA FACULTAD DE INGENIER�?A        258 default 257 156434027   \N  \N
SISTEMA WEB DE APOYO A LA GESTIÓN DE UNA ORGANIZACIÓN COMUNITARIA   31/03/2014  259 default 258 171818575   \N  \N
PROPUESTA DE MÉTODO �?GIL DE DESARROLLO DE SOFTWARE FUNCIONAL, USABLE Y SEGURO       260 default 259 170291220   \N  \N
PROTOTIPO DE SISTEMA DE DETECCIÓN DE INTRUSOS BASADO EN HOST PARA ANDROID   5/12/2012   261 default 260 172510957   \N  \N
SISTEMA DE INFORMACIÓN Y AUTOMATIZACIÓN WEB PARA GESTIÓN Y ADMINISTRACIÓN DE SERVICIOS Y RECURSOS DEL COMPLEJO TUR�?STICO ATALAYA LANALHUE.      262 default 261 159598314   \N  \N
PROTOTIPO DE APLICACIÓN MÓVIL PARA LA DETECCIÓN DE MALWARE EN DISPOSITIVOS CON SISTEMA OPERATIVO ANDROID    29/07/2014  263 default 262 172974325   \N  \N
SISTEMA DE ACTAS DE SESIONES DE CONSEJO Y AGENDA DEPARTAMENTAL.     264 default 263 151049486   \N  \N
PROPUESTA DE MÉTODO �?GIL DE DESARROLLO DE SOFTWARE FUNCIONAL, USABLE Y SEGURO.  24/07/2014  265 default 264 170291220   \N  \N
APLICACIÓN ANDROID UTILIZANDO REALIDAD AUMENTADA PARA LA UBICACIÓN ESPACIAL DE SITIOS DE INTERÉS    23/01/2014  266 default 265 170289943   \N  \N
PROTOTIPO DE SISTEMA DE DETECCIÓN DE MALWARE PARA DISPOSITIVOS ANDROID  20/01/2014  267 default 266 173028318   \N  \N
DESARROLLO DE UN PLAN DE CONTINGENCIA Y RECUPERACIÓN ANTE DESASTRES PARA EL �?REA INFORM�?TICA DE LA EMPRESA ARCADIS CHILE    26-12-2012  268 default 267 166096502   \N  \N
GENERACION DE UNA PLATAFORMA VIRTUALIZADA DE SERVICIOS INTEGRADOS PARA EL DEPARTAMENTO DE INGENIERIA EN INFORMATICA 24/09/2013  269 default 268 180762353   \N  \N
SISTEMA DE GESTIÓN ADMINISTRATIVA DE ALUMNOS PARA EL COLEGIO PUKARAY.       270 default 269 170483685   \N  \N
PROTOTIPO DE SISTEMA WEB PARA LA GESTIÓN Y CONSOLIDACIÓN DE INFORMACIÓN ADMINISTRATIVA COMO APOYO AL PROCESO DE ACREDITACIÓN DE LOS PROGRAMAS DEL DEPARTAMENTO DE INGENIER�?A INFORM�?TICA    23/01/2014  271 default 270 173900996   \N  \N
SISTEMA DE GESTIÓN DE LA SEGURIDAD DE LA INFORMACIÓN PARA EL DIINF  24/12/2014  272 default 271 164729931   \N  \N
DESARROLLO DE UN ASISTENTE PARA EL SOFTWARE GREI QUE PERMITA GUIAR A LOS DOCENTES EN LA CREACIÓN DE SECUENCIAS INTERACTIVAS DE APRENDIZAJE RESGUARDANDO CRITERIOS DID�?CTICOS-MATEM�?TICOS    7/4/2014    273 default 272 161163813   \N  \N
CURSE DE CREDITOS HIPOTECARIO EN WORKFLOW   5/12/2012   274 default 273 122596451   \N  \N
DESARROLLO DE UNA HERRAMIENTA DE SOFTWARE BASADA EN UN MARCO DE TRABAJO PARA LA GU�?A DE GESTIÓN DE PROYECTOS TI PARA PUMES      275 default 274 166570727   \N  \N
METODOLOGIA DE TRABAJO PARA LA GESTION DE PROYECTOS TI EN PYMES 30/09/2013  276 default 275 169102627   \N  \N
TESTING DE CORE BUSINESS PARA UNA EMPRESA DE TELECOMUNICACIONES 18/03/2013  277 default 276 123957016   \N  \N
DESARROLLO  E IMPLEMENTACIÓN DE UN DATAMART PARA EL APOYO A LAS VENTAS DEL GRUPO SIG    13/06/2012  278 default 277 160319135   \N  \N
HOLA    23/04/2015  598 1/2015  592 166257344   f   \N
DISEÑO E IMPLEMENTACIÓN DE UN DATAWAREHOUSE Y DE REPORTES DE APOYO PARA EL �?REA GLOBAL BPO DE UN CLIENTE DE LA EMPRESA METRIC ARTS  23/05/2013  281 default 280 168036639   \N  \N
SISTEMA DE INFORMACION WEB PARA EL CONTROL DE ORDENES DE TRABAJO EN IMPRENTA COLORAMA S.A   3/15/2011   282 default 281 160319135   \N  \N
SISTEMA WEB DE CONTROL Y SOPORTE DE INFORMACIÓN AL SERVICIO TÉCNICO DE LA EMPRESA PROYEXION SERVICIOS S.A.  4/12/2013   283 default 282 135237566   \N  \N
SISTEMA WEB DE APOYO A LA ADMINISTRACIÓN DEL CONTROL DE CAMBIOS EN SERVIDORES DELA PLATAFORMA WINTEL DE HP      284 default 283 153447586   \N  \N
SISTEMA WEB PARA PUBLICACION Y AYUDA A LA COMPRA-VENTA DE AUTOS DE EL PORTAL DEL AUTO       285 default 284 159975509   \N  \N
SISTEMA WEB DE APOYO A LA LABOR COMERCIAL DE UNA EMPRESA DISTRIBUIDORA DE GAS LICUADO   7/4/2011    286 default 285 129799927   \N  \N
APLICACION DE APOYO AL DEPARTAMENTO DE RECURSOS HUMANOS PARA "AMEC ING Y CONSTRUCCIÓN LTDA" 26/12/2012  287 default 286 119905621   \N  \N
SISTEMA DE APOYO A LA ATENCIÓN DE CLIENTES  23/01/13    288 default 287 155885173   \N  \N
MODELACIÓN LINE-PACK DE LA OPERACIÓN DEL GASODUCTO GAS ATACAMA MEDIANTE REDES NEURONALES ARTIFICIALES       289 default 288 126355971   \N  \N
SISTEMA INTEGRADO DE REMUNERACIONES Y DECLARACIÓN JURADA ANUAL DE RENTAS    10/7/2014   290 default 289 118425480   \N  \N
DESARROLLO UN SISTEMA WEB DE APOYO A LA ADMINISTRACION DE PROYECTOS DE INGENIERIA EN LA EMPRESA L&C     291 default 290 161173800   \N  \N
DESARROLLO E IMPLEMENTACIÓN DE DATAMART PARA LA GERENCIA COMERCIAL DE UNA ASOCIACIÓN GENERAL DE FONDOS  19/08/2014  292 default 291 169592306   \N  \N
SISTEMA MONITOR DE DISPOSITIVOS ELECTRÓNICOS EN UNA PLANTA TRASMISORA DE FRECUENCIA MODULADA    8/3/2013    293 default 292 172683843   \N  \N
SISTEMA DE APOYO A LA GESTIÓN DE FRANQUICIAS MÉDICAS-DENTALES PARA ALUMNOS DE LA UNIVERSIDAD DE CHILE   14/07/2014  294 default 293 102607376   \N  \N
SISTEMA WEB DE APOYO A LA GESTION DE MONITOREO Y SEGUIMIENTO DEL TRABAJO EN EL AUTO 7/4/2011    295 default 294 156663859   \N  \N
NO HAY INFORMACION      296 default 295 155446099   \N  \N
SISTEMA DE APOYO A LA GESTION DE BODEGA PARA LA EMPRESA MC2     297 default 296 164735737   \N  \N
SISTEMA WEB DE EVALUACIÓN DE DESEMPEÑO PARA EL PERSONAL DE OFICIALES DE LA FUERZA AÉREA DE CHILE    11/7/2012   298 default 297 163549239   \N  \N
SISTEMA WEB DE APOYO A LA GESTION DEL AREA DE SOPORTE COMPUTACIONAL PARA LA EMPRESA MARCARIA.COM    7/4/2011    299 default 298 141968092   \N  \N
IMPLEMENTACIÓN DE UN ERP DE APOYO A LA ADMINISTRACIÓN DEL SALÓN DE BELLEZA �?RTICO   18/08/2014  300 default 299 179512130   \N  \N
DESARROLLAR UN JUEGO COMO HERRAMIENTA DE APRENDIZAJE PARA EL CURSO DE ECONOM�?A DE LA FACULTAD TECNOLÓGICA       25/09/2014  301 default 300 16375228K   \N  \N
DESARROLLAR UN SISTEMA DE APOYO A LA GESTION DE FICHAS,HORAS Y MEDICAMENTOS PARA LA POSTA RURAL DE PENCAHUE BAJO        302 default 301 171663741   \N  \N
SISTEMA DE APOYO AL PRCOESO DE EVALUACIÓN ECONÓMICA SOCIAL DE PROYECTOS DE VIALIDAD URBANA  26/12/2012  303 default 302 98953051    \N  \N
DESARROLLO DEL SISTEMA SAP SRM PARA LA EMPRESA MULTINACIONAL ALFA   18/03/13    304 default 303 139147820   \N  \N
SISTEMA WEB DE APOYO A LA GESTIÓN DE UN CENTRO DE DISTRIBUCIÓN  17/07/2014  305 default 304 122550915   \N  \N
SISTEMA WEB DE GENERACION Y SEGUIMIENTO DE REQUERIMIENTOS DE SOPORTE PARA SISTEMAS LTDA.    7/4/2011    306 default 305 126305478   \N  \N
SISTEMA DE INFORMACION DE APOYO A LOS PROCESOS DE VENTA E INVENTARIO PARA LA EMPRESA RODAMIENTO "VILLELA"       307 default 306 157559281   \N  \N
REDISEÑO DEL PROCESO DE NEGOCIO ASOCIADO AL SERVICIO DE ARRIENDO DE GRÚAS HORQUILLA, PARA LA EMPRESA GRÚAS M&L LTDA.    7/1/2015    308 default 307 169561249   \N  \N
DESARROLLAR UN JUEGO COMO HERRAMIENTA DE APRENDIZAJE PARA EL CURSO DE ECONOM�?A DE LA FACULTAD TECNOLÓGICA       1/10/2014   309 default 308 167535682   \N  \N
AUTOMATIZACIÓN DEL PROYECTO DE FORMALIZACIÓN DE SUBSIDIOS DE CORFO  20/03/2013  310 default 309 151138853   \N  \N
IMPLEMENTACIÓN DEL PROCESO DE FORMALIZACIÓN DE SUBSIDIOS DE CORFO EN ADOBE LIVE CYCL    21/10/2014  311 default 310 151138853   \N  \N
RESOLUCIÓN DE KO THREATS UTILIZANDO HEUR�?STICAS EN MONTE CARLO GO.      312 default 311 163601311   \N  \N
USO DE GPU EN ALGORITMOS DE BUSQUEDA LOCAL PARA EL PROBLEMA DE LA ASIGNACION CUADRATICA 5/10/2011   313 default 312 171679249   \N  \N
ACERELERACION DE DESEMPEÑO DEL ALGORITMO DE BUSQUEDA LOCAL PARA FLOW SHOP USANDO PROCESADORES GRAFICOS  7/10/2011   314 default 313 170215710   \N  \N
ALGORITMO DE AGRUPAMIENTO PARA DATOS DE EXPRESIÓN GÉNICA DE RNA-SEQ CON LA INCORPORACIÓN DE ANOTACIONES BIOLÓGICAS  14/08/2014  315 default 314 175975721   \N  \N
ALGORITMO MEMÉTICO BASADO EN CONOCIMIENTO BIOLÓGICO PARA EL PROBLEMA DE PREDICCIÓN DE LA ESTRUCTURA TRIDIMENSIONAL DE LA PROTE�?NA   20/01/2014  316 default 315 171509688   \N  \N
CONSTRUCCIÓN DE UN FRAMEWORK PARA PIPELINE DE APLICACIONES DE BIOINFORM�?TICA    22/01/2014  317 default 316 165626826   \N  \N
DISEÑO Y DESARROLLO DE UN ALGORITMOS DE BÚSQUEDA DE ARN OBJETIVOS PARA UN MICROARN  22/6/2012   318 default 317 161561444   \N  \N
SISTEMA DE EVALUCIÓN FORMATIVA EN LINEA PARA LA SOCIEDAD CHILENA DE RADIOLOGIA      319 default 318 141645064   \N  \N
ALGORITMO PARA LA VISUALIZACIÓN DE DATOS EXPERIMENTOS DE MIROARRAYS BASADOS EN ANOTACIONES BIOLÓGICAS Y EXPRESIÓN GENÉTICA  25/07/2012  320 default 319 167891497   \N  \N
GRAFO DE CONSENSO DE FUENTES DE ANOTACIONES BIOLÓGICAS DE GENES HUMANOS     22/01/2014  321 default 320 167998186   \N  \N
DESARROLLO DE UNA APLICACIÓN WEB PARA EL APOYO AL AN�?LISIS DE DATOS RT-PCR.     322 default 321 173169906   \N  \N
INCORPORACIÓN DE ANOTACIONES GENÉTICAS EN EL ALGORITMO DE AGRUPAMIENTO MST -KNN 25/07/2012  323 default 322 164780430   \N  \N
REINGENIERIA PORTAL DE PAGOS DEL ESTADO PARA TESORER�?A GENERAL DELA REPÚBLICA   31/07/2013  324 default 323 130597572   \N  \N
PLATAFORMA DE MONITOREO WEB DE CUENTAS DE TWITTER PARA PROYECTO FONDEF D09I1185 "OBSERVATORIO ESCALABLES DE LA WEB EN TIEMPO REAL"      325 default \N  154841970   \N  \N
AN�?LISIS DE TÉCNICAS PARA FILTRADO DE NOTICIAS DE LA WEB    7/9/2012    326 default 324 120324314   \N  \N
CLASIFICACIÓN AUTOM�?TICA DE TEXTOS PERIOD�?STICOS ENRIQUECIDA CON FUENTES EXTERNAS   5/3/2012    327 default 325 159674290   \N  \N
SISTEMA DE SEGUIMIENTO DE JUICIOS PARA GESTIÓN DE COBRANZA  20/08/12    328 default 326 120101099   \N  \N
EVALUACIÓN DE ALGORITMOS PARA LA IDENTIFICACIÓN DE ESTRUCTURA DE SITIOS WEB CON APLICACIONES EN RECOLECTORES FOCALIZADOS DE LA WEB.     329 default 327 164324206   \N  \N
MÓDULOS DEL SISTEMA INFORM�?TICO PARA APOYAR LA GESTIÓN EN UNA EMPRESA DE RETAIL 5/8/2013    331 default 329 134428244   \N  \N
SDAFASFASD  22/04/2011  599 1/2010  \N  167110614   f   \N
DESARROLLO DE UNA API PARA LA ASOCIACIÓN DE PERSONAS Y EL CONTENIDO DE NOTICIAS EN ESPACIOS.        332 default 330 174176264   \N  \N
GENERACIÓN DE REPORTES CON EL CONTEXTO DE NOTICIAS EN TWITTER.      333 default 331 170309545   \N  \N
AN�?LISIS DE SENTIMIENTO EN EL SISTEMA DE RED SOCIAL TWITTER     334 default 332 169847029   \N  \N
DISEÑOS DE UN CLASIFICADOR DE PATENTES INDUSTRIALES 20/07/2012  335 default 333 167441823   \N  \N
API PARA LA VISUALIZACIÓN DE RELACIONES EXISTENTES ENTRE CONTACTOS PERSONALES A TRAVÉS DE REDES SOCIALES.       336 default 334 174052255   \N  \N
DESARROLLO DE UN SISTEMA DE GESTION HORARIA PARA RECURSOS DE UNA EMPRESA DE DEPILACION LASER    25/07/2012  337 default 335 173136986   \N  \N
DISEÑO DE UN ALGORITMO DE PLANIFICACIÓN PARA APLICACIONES PARALELAS SOBRE RECURSOS HETEROGÉNEOS EN CLOUD COMPUTING  15/06/2012  338 default 336 163225816   \N  \N
PLATAFORMA DE EVALUACIÓN DE ALGORITMOS DE SUBASTA PARA BUSQUEDAS PATROCINADAS   19/07/2012  339 default 337 168039891   \N  \N
AN�?LISIS DE LA SATISFACCIÓN DE CLIENTES MEDIANTE EL AN�?LISIS DE CORREOS ELECTRÓNICOS    25/03/2013  340 default 338 160081937   \N  \N
INTEGRACIÓN ERP MICROSOFT DYNAMICS AX CON SISTEMA WEB EXTERNO PARA EL INGRESO DE PEDIDOS DE VENTA   15/4/13 341 default 339 141861239   \N  \N
ACTUALIZACIÓN CONCURRENTE DE �?NDICES INVERTIDOS EN MOTORES DE BÚSQUEDA VERTICALES   22/12/2014  342 default 340 170222156   \N  \N
DETERMINACIÓN DE LA INFLUENCIA DE EST�?MULOS SONOROSY SU EMOCIÓN EN LA AUTORREGULACIÓN.  7/8/2012    343 default 341 167432530   \N  \N
DETERMINACIÓN DE LA INFLUENCIA DE EST�?MULOS MUSICALES EN LA AUTORREGULACIÓN DEL FLUJO SANGU�?NEO CEREBRAL.   3/1/2012    344 default 342 171679249   \N  \N
PRE-PROCESAMIENTO DE SEÑALES DE HEMODIN�?MICA CEREBRAL PARA ESTUDIOS DE AUTTOREGULACION DEL FLUJO SANGUINEO CEREBRAL 7/4/2011    345 default 343 11480715K   \N  \N
DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA DE CONTRASTE DE HIPÓTESIS BASADO EN BOOTSTRAP     346 default 344 165319559   \N  \N
AN�?LISIS DE LA COMPLEJIDAD DE LAS SEÑALES DEL SISTEMA DE HEMODIN�?MICA CEREBRAL Y LA RELACIÓN DE ESTA CARACTER�?STICA CON SU MODELAMIENTO     347 default 345 167485405   \N  \N
ANALISIS COMPARATIVO ENTRE METODOS PARA EL CALCULO DE LA AUTORREGULACION CEREBRAL QUE USAN CAMBIOS BRUSCOS DE PRESION Y VARIACIONES ESPONTANEAS UTILIZANDO SVM  30/09/2013  348 default 346 169969329   \N  \N
COMPARACIÓN DE LOS MÉTODOS DE C�?LCULO DE AUTOREGULACIÓN USANDO MODELOS LINEALES CON LA MANIOBRA DE VALSALVA Y VARIACIONES ESPONTANEAS DE PRESIÓN    4/9/2014    349 default 347 163219689   \N  \N
MODIFICACION DE LOS METODOS DE DETECCION DE LATIDOS CARDIACOS PARA SER UTILIZADOS EN LA ESTIMACION DE SEÑALES DE PSAM Y FSCM        350 default 348 167282032   \N  \N
SOLUCIÓN DE INTELIGENCIA DE NEGOCIOS Y MODELO PREDICTIVO COMO APOYO A LA GESTIÓN DE INDICADORES CL�?NICOS EN CL�?NICA ALEMANA DE SANTIAGO     351 default 349 130441793   \N  \N
SELECCIÓN DE CARACTER�?STICAS PARA LA ESTIMACIÓN DE NIVELES DE PRESIÓN INTRACRANEAL EN FORMA NO INVASIVA.        352 default 350 164751392   \N  \N
CREACIÓN DE MODELOS DE CLASIFICACIÓN PARA CULTIVOS NEURONALES CON CLASES DESBALANCEADAS Y BÚSQUEDA DE VARIABLES REPRESENTATIVAS 19/05/2014  353 default 351 16612106K   \N  \N
CLASIFICACION DEL GRUPO SOCIO ECOOMICO UTILIZANDO VARIABLES DE CONSUME DE PRODUCTOS DE SUPERMERCADO 3/4/2013    354 default 352 132575568   \N  \N
MEJORAMIENTO DEL �?NDICE DE AUTORREGULACIÓN DE FLUJO SANGU�?NEO CEREBRAL (ARI) MEDIANTE LA MEDICIÓN DE FASE ENTRE PRESIÓN Y FLUJO.        355 default 353 166810388   \N  \N
COMPARACIÓN DE LOS MÉTODOS DE C�?LCULO DE AUTORREGULACIÓN CON LA MANIOBRA "SIT-TO-STAND" Y VARIACIONES ESPONT�?NEAS DE PRESIÓN    20/01/2014  356 default 354 145012163   \N  \N
DISEÑO E IMPLEMENTACIÓN DE UNA HERRAMIENTA PARA LA CATEGOGORIZACIÓN DE PACIENTES EN SERVICIOS DE URGENCIA       357 default 355 164182169   \N  \N
IDENTIFICACIÓN DE EVENTOS DE TRANSFERENCIA HORIZONTAL DE GENES EN BACTERIAS MEDIANTE DISEÑO DE CLASIFICADORES DE DATOS  28/12/12    358 default 356 167472982   \N  \N
DISEÑO DE UN CLASIFICADOR PARA LA DETECCIÓN DEL MOBILOMA EN GENOMAS DE BACTERIAS    24/04/2014  359 default 357 167472982   \N  \N
EVALUACIÓN COMPARATIVA DE MÑETODOS DE MINER�?A DE DATOS PARA LA CLASIFICACIÓN DE SEÑALES S�?SMICAS DEL VOLC�?N LLAIMA  28/12/12    360 default 358 167116116   \N  \N
OPTIMIZACIÓN Y MEJORAS A PROCESOS EJECUTADOS PARA LA OBTENCIÓN DE LOS ESTADOS DE RESULTADOS COMERCIALES DE LAN CHILE    9/1/2013    361 default 359 105018274   \N  \N
USO DE TÉCNICAS DE CAJA GRIS Y FUNCIÓN DE TRANSFERENCIA PARA MODELAR LA AUTORREGULACIÓN CEREBRAL    9/2/2012    362 default 360 161240176   \N  \N
SISTEMA PARA CONTROL DE ENV�?O Y RECEPCIÓN DE MENSAJER�?A DE TEXTO EN EQUIPOS DE TELEFON�?A MÓVIL  12/12/2012  363 default 361 9998998K    \N  \N
COMPARACIÓN DE �?NDICES DE AUTORREGULACIÓN DE FLUJO SANGU�?NEO CEREBRAL BASADOS SOLO EN SEÑAL DE FLUJO    13/12/12    364 default 362 176675459   \N  \N
COMPARACION ENTRE MODELOS NARX DE SVM Y TLRNN PARA OBTENER INDICE AUTORREGULATORIO CEREBRAL EN VARIACIONES ESPONTANEAS  30/09/2013  365 default 363 167463479   \N  \N
EVALUACIÓN DE MÉTODOS QUE MEJORAN LA IDENTIFICACIÓN DE BIOMARCADORES A PARTIR DE DATOS DE EXPRESIÓN GÉNETICA EN EL SALMÓN ATL�?NTICO (SALMO SALAR)   28/12/12    366 default 364 167460003   \N  \N
EVALUACIÓN DE LOS EFECTOS DE LA POSICIÓN CORPORAL EN EL C�?LCULO DE LOS �?NDICES DE AUTORREGULACIÓN DEL FLUJO SANGU�?NEO CEREBRAL USANDO MODELOS LINEALES  21/12/2012  367 default 365 164910652   \N  \N
APLICACIÓN DEL CRÉDITO TRIBUTARIO PARA LA INSTALACIÓN DE UN SISTEMA SOLAR TÉRMICO Y SU IMPACTO EN EL SISTEMA INFORM�?TICO TRIBUTARIO CHILENO ADMINISTRADO POR EL S.I.I.  27/11/12    368 default 366 83157739    \N  \N
CONSTRUCCIÓN DE MODELOS PARA EVALUAR LA AUTORREGULACIÓN DE PACIENTES CON TEC USANDO MODELOS NARMAX Y FIR CON SVM.   24/07/12    369 default 367 170631129   \N  \N
ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS POLARES     4/8/2014    370 default 368 169448264   \N  \N
IMPLEMENTACIÓN DE ALGORITMOS DE LAYOUT DE GRAFOS Y AN�?LISIS DE SU COMPORTAMIENTO AL GENERAR SOLUCIONES IN�?CIALES PARA EL ALGORITMO QAPGRID.     371 default 369 164792560   \N  \N
ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS OCTOPUS 23/06/2014  372 default 370 174044953   \N  \N
CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFO GOOD    18/08/2014  373 default 371 174424977   \N  \N
OBJETOS DE APRENDIZAJE PARA POYAR LA COMPRENSIÓN Y APLICACIÓN DE CONCEPTOS B�?SICOS DE INTRODUCCIÓN A LAS BASES DE DATOS 3/12/2012   374 default 372 170505727   \N  \N
SISTEMA DE GESTIÓN ESCOLAR PARA LA EMPRESA DE CLASES PARTICULARES "PLAY HOUSE TEACHER"      375 default 373 156646636   \N  \N
GENERACION VIRTUAL DE NANOTUBOS DE CARBONO DE UNA PARED FUNCIONALIZADOS CON DISTINTAS MOLECULAS 10/1/2013   376 default 374 167391753   \N  \N
DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA DE PREDICCIÓN PARA LA CANTIDAD DE ALUMNOS EN LAS ASIGNATURAS DEL DEPARTAMENTO DE INGENIERIA INFORMATICA   23/07/2012  377 default 375 167391753   \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE ALGORITMOS DE PLANIFICACIÓN DE PROCESOS EN CPU EN EL CURSO DE SISTEMAS OPERATIVOS  13/12/12    378 default 376 17850620K   \N  \N
SISTEMA PARA LA CREACION,GESTION Y DIFUSION DE BANDAS MUSICALES     379 default 377 168409974   \N  \N
REINGENIER�?A DE PROCESOS DE DOCENCIA  DEL DEPARTAMENTE DE INGENIER�?A INFORM�?TICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE 20/07/2012  380 default 378 167497578   \N  \N
OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE CONTABILIDAD PARA ALUMNOS DEL INSTITUTO PROFESIONAL LA ARAUCANA       381 default 379 167464181   \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL MODELAMIENTO MATEM�?TICO DE PROBLEMAS DE OPTIMIZACIÓN  21/12/12    382 default 380 169197342   \N  \N
ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS "K-TREE"    9/9/2014    383 default 381 167476171   \N  \N
ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS "K-TREE"        384 default 382 167476171   \N  \N
APLICACIÓN DE APOYO A LA ENSEÑANZA - APRENDIZAJE PARA EL MANEJO DE LENJUAGE DE MATRICES EN OCTAVE EN EL CURSO DE FUNDAMENTOS DE PROGRAMACIÓN    5/3/2013    385 default 383 170286499   \N  \N
DETECCIÓN PREVENTIVA DE ALUMNOS CON BAJO RENDIMIENTO ACADÉMICO EN LA FACULTAD DE INGENIER�?A DE LA UNIVERSIDAD DE SANTIAGO DE CHILE      386 default 384 160687975   \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR LA APREHESIÓN DE LOS CONCEPTOS DE PROCESOS Y HEBRAS  20/12/12    387 default 385 173093403   \N  \N
DESARROLLO DE UN MÓDULO DE EXTENSIÓN PARA DETERMINAR RUTAS DE TRANSPORTES DE CARGA POR EL MEDIO VIAL, FERROVIARIO O MAR�?TIMO EN EL ENTORNO ARCMAP       388 default 386 153182051   \N  \N
APLICACIÓN WEB DE APOYO PARA LA GESTIÓN DE PROCESO DE POSTULACIONES  ACADÉMICAS EN EL DEPARTAMENTO DE INGENIER�?A INFORM�?TICA DE LA UNIIVERSIDAD DE SANTIAGO DE CHILE        389 default 387 176744499   \N  \N
ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS LOBSTER     390 default 388 132527121   \N  \N
OBJETIVOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN DE CONCURRENCIA COMPUTACIONAL   23/01/2013  391 default 389 165702867   \N  \N
ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS BISPLIT.        392 default 390 162850350   \N  \N
OBJETO DE APRENDIZAJE PARA LA EJERCITACIÓN DE LOS CONCEPTOS DEL MÉTODO SIMPLEX  12/12/2012  393 default 391 170061403   \N  \N
DIAGNOSTICO DE INGRESO DE ALUMNOS A LA CARRERA DE INGENIER�?A DE EJECUCIÓN EN COMPUTACIÓN E INFORM�?TICA MODALIDAD VESPERTINA 2/5/2013    394 default 392 120472003   \N  \N
EVALUACIÓN DE OBJETOS DE APRENDIZAJE MOODLE, MEDIANTE LA SUPERVISIÓN DE USO DE LOS ESTUDIANTES  23/12/2014  395 default 393 174866309   \N  \N
SISTEMA DE INFORMACIÓN DOCENTE PARA APOYO A LA ACREDITACIÓN DE LOS PROGRAMAS DE PREGRADO DEL DEPARTAMENTO DE INGENIER�?A INFORM�?TICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE  23/12/2014  396 default 394 174256346   \N  \N
SISTEMA DE APOYO A LA FORMULACIÓN DE PROYECTOS CONCURSABLES DEL DEPARTAMENTO DE INGENIER�?A INFORM�?TICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE   22/12/2014  397 default 395 172427545   \N  \N
ALGORITMOS PARALELOS PARA LA GENERACIÓN DE LOS CONJUNTOS INDEPENDIENTES MAXIMALES DE UN GRAFO CAMINO SIN CUERDAS Y DE UN GRAFO CATERPILLAR  22/12/2014  398 default 396 175340718   \N  \N
MODELADO DE LAS CARACTER�?STICAS DE LOS POSTULANTES A LA CARRERA DE INGENIER�?A DE EJECUCIÓN EN COMPUTACIÓN E INFORM�?TICA MODALIDAD VESPERTINA    18/12/2014  399 default 397 174888817   \N  \N
ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN FRAFOS OCTOPUS 16/10/2014  400 default 398 174044953   \N  \N
INTELIGENCIA DE NEGOCIOS APLICADA A CAJA DE COMPENSACIÓN    15/06/2012  401 default 399 16171898k   \N  \N
SISTEMA DE APOYO A LA ADMINISTRACIÓN DE INFORMACIÓN PARA LOS COMITÉS DE AGUA POTABLE RURALES    8/2/2012    402 default 400 166606322   \N  \N
DESARROLLO DE UNA APLICACIÓN DE MONITOREO SPLUNK PARA AGUILIZAR EL PROCESO ITIL DE GESTIÓN DE INCIDENTES EN BANCO ESTADO    18/11/2013  403 default 401 170508157   \N  \N
SISTEMA DE GESTIÓN Y CONTROL PARA EMPRESA "PG&I"    08/05/12    404 default 402 155661569   \N  \N
BUSINESS INTELLIGENCE PARA EL �?REA DE CONTROL DE GESTIÓN EN LA SUPERINTENDENCIA DE ELECTRICIDAD Y COMBUSTIBLES  29/11/2012  405 default 403 134897384   \N  \N
MONITOREO Y MANEJO DE REDES INAL�?MBRICAS EN MINAS A RAJO ABIERTO    30/11/2012  406 default 404 101489736   \N  \N
CUBO OLAP PARA AN�?LISIS DE VENTAS   26/09/12    407 default 405 132601305   \N  \N
ESTUDIO DE FACTIBILIDAD PARA LA IMPLEMENTACION DE APLICACIONES DISTRIBUIDAS SOBRE SET-TOP-BOXES EN CHILE    3/10/2013   408 default 406 172508782   \N  \N
BIBLIOTECA PARA EL DESPEGUE �?GIL DE APLICACIONES DE STREAM EN ESCENARIOS DE DESASTRES   13/07/2014  409 default 407 182940933   \N  \N
IMPLEMENTACION DE PROCESOS DE GESTION DE PROYECTOS FOSIS UTILIZANDO HERRAMIENTAS BPMS   4/8/2010    410 default 408 153503583   \N  \N
SISTEMA WEB DE DENUNCIA CIUDADANA PARA LA ILUSTRE MUNICIPALIDAD DE SAN JOAQUIN  20/09/2011  411 default 409 101113515   \N  \N
SISTEMA DE RECOLECCIÓN DE LECHE FRESCA PARA LAS PLANTAS NESTLÉ CHILE S.A.   13/05/2013  412 default 410 123894960   \N  \N
PROTOTIPO DE SISTEMA DE GESTIÓN DOCUMENTAL PARA LA DIRECCIÓN DE ASISTENCIA JUR�?DICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE      413 default 411 142527847   \N  \N
REDISEÑO DE PROCESOS: IMPLEMENTACION DE SISTEA RIS/PACS EN UNIDAD DE IMAGENOLOGIA, HOSPITAL SAN JUAN DE DIOS    4/8/2010    414 default 412 132136106   \N  \N
SISTEMA DE CONTROL Y MONITOREO A LAS TRANSACCIONES DE UN CONJUNTO DE BASES DE DATOS SQL SERVER  20/09/2011  415 default 413 130557333   \N  \N
DATAMART PARA EL �?REA DE APROVISIONAMIENTO DE ENDESA COLOMBIA       416 default 414 147365403   \N  \N
DISEÑO E IMPLEMENTACIÓN DE UN CUADRO DE MANDO INTEGRAL  4/8/2010    417 default 415 142432722   \N  \N
SISTEMA DE CONTROL DE PROCESOS Y GESTION PARA EL AREA DE SOPORTE INFORMATICO PARA BROWSE INGENIERIA 4/8/2010    418 default 416 130476716   \N  \N
PROCESO DE DESARROLLO DE PROYECTOS DE SEGURIDAD PARA SAP ERP EN ROLES Y PERFILES    4/8/2010    419 default 417 139368142   \N  \N
SISATEMA DE INVENTARIO WEB PARA APOYAR LA GESTIÓN DE LA EMPRESA VTV LTDA.   15/05/2012  420 default 418 171204593   \N  \N
SISTEMA DE ASIGNACIÓN DE LABORATORIOS DE DOCENCIA   4/8/2010    421 default 419 120580094   \N  \N
PLAN DE CONTINUIDAD DE NEGOCIOS PARA EL MACRO PROCESO GESTIÓN FINANCIERA Y OTROS ACTIVOS DEL TESORO PÚBLICO 3/11/2013   423 default 421 137465493   \N  \N
SISTEMA DE CONTROL DE PERMISOS Y AUSENCIAS DE FUNCIONARIOS DEL 3º JUZGADO DE FAMILIA DE SANTIAGO DE CHILE   7/4/2011    424 default 422 12236299K   \N  \N
DESARROLLO DE SISTEMA DE COTIZACIÓN Y DE CONTROL DE EXISTENCIAS PARA LA EMPRESA ALUMAR  19/07/2012  425 default 423 17325752K   \N  \N
SISTEMA WEB DE APOYO A LA ADMINISTRACION Y PLANIFICACION DE EVIDENCIA NORMATIVA DE AUDITORIAS PARA NEXUS S.A.   7/4/2011    426 default 424 111690871   \N  \N
DESARROLLO E IMPLEMENTACIÓN DE SISTEMA DE AUTOMATIZACIÓN DE PROCESOS DE AN�?LISIS CRM    19/11/2013  427 default \N  164273008   \N  \N
SISTEMA WEB PARA MONITOREAR DISPOSITIVOS GPS    20/09/2011  428 default 425 141928664   \N  \N
SISTEMA CMR DE APOYO A LA FUERZA DE VENTAS CON CLIENTE DE OPERACION ASINCRONICA 7/4/2011    429 default 426 118453816   \N  \N
SISTEMA DE INFORMACIÓN WEB, PARA LA "CL�?NICA DENTAL - ALEXANDRA ALVAREZ"    1/2/2012    430 default 427 126776691   \N  \N
DESARROLLO DE UN SISTEMA DE APOYO A LA GESTIÓN DE TORNEOS Y APUESTAS EN LA COMUNIDAD DE VIDEOJUEGOS CIBERDEPORTES.NET.  9/2/2012    431 default 428 16375228K   \N  \N
WEB SERVICES PARA APOYAR LA VENTA DE SEGUROS DE VEH�?CULOS PARTICULARES A TRAVES DE UNA MULTITIENDA  1/2/2012    432 default 429 07364058K   \N  \N
SISTEMA DE INFORMACIÓN DE APOYO PARA AUTOMATIZACIÓN Y MONITOREO DE ACTIVIDADES DE PLAN DE CORTE EN CONVERSIÓN DE TIENDAS PARA LA COMPAÑ�?A ZCMART CHILE. 19/11/2013  433 default 430 157559281   \N  \N
PLATAFORMA PARA LA DEFINICIÓN Y APOYO A LA EVALUACIÓN DE GESTOS T�?CTILES EN LA INTERACCIÓN CON OBJETOS DIGITALES DE INFORMACIÓN 4/8/2014    434 default 431 17705318K   \N  \N
IDENTIFICACIÓN AUTOMATIZADA DE ETAPAS DEL PROCESO DE BÚSQUEDA DE INFORMACIÓN DEL USUARIO    18/07/2014  435 default 432 174859329   \N  \N
DISEÑO Y DESARROLLO DE UNA APLICACIÓN MODULAR PARA APOYAR LA INVESTIGACIÓN OBSERVACIONAL CON DATOS MULTIMODALES     13/08/2014  436 default 433 176233516   \N  \N
DETECCIÓN IMPL�?CITA DE RELEVANCIA DE P�?GINAS WEB UTILIZANDO REGISTROS DE ACTIVIDAD DEL USUARIO EN LA BÚSQUEDA DE INFORMACIÓN    18/08/2014  437 default 434 176641959   \N  \N
PLATAFORMA PARA LA GENERACIÓN Y APOYO A LA EVALUACIÓN DE VISUALIZAORES DE RESULTADOS DE BÚSQUEDA    12/8/2014   438 default 435 17490314K   \N  \N
HERRAMIENTA INTERACTIVA PARA APOYAR LA EVALUACIÓN DE PACIENTES EN TRATAMIENTO DEL TRASTORNO DE DÉFICIT ATENCIONAL A PARTIR DEL RASTREO OCULAR   18/08/2014  439 default 436 180550321   \N  \N
PLATAFORMA PARA EL APOYO A LA EVALUACIÓN Y DEFINICIÓN DE GESTOS CORPORALES EN LA INTERACCIÓN CON OBJETOS DIGITALES DE INFORMACIÓN   4/8/2014    440 default 437 176013435   \N  \N
EVALUACIÓN IMPL�?CITA DE CARGA COGNITIVA DURANTE EL PROCESAMIENTO DE INFORMACIÓN A PARTIR DE PATRONES DE LECTURA 18/08/2014  441 default 438 174269211   \N  \N
F�?BRICA DE COLABORATORIOS PARA APOYAR LA INVESTIGACIÓN EN BÚSQUEDA COLABORATIVA DE INFORMACIÓN  23/12/2014  442 default 439 175333967   \N  \N
PLATAFORMA PARA LA DEFINICIÓN Y APOYO A LA EVALUACIÓN DE RETROALIMENTACIÓN T�?CTIL EN LA INTERACCIÓN CON OBJETOS DE INFORMACIÓN DIGITAL A TRAVÉS DE INTERFACES NATURALES 23/12/2014  443 default 440 176717890   \N  \N
METODOLOGIA PARA EL DISEÑO DE INFRAESTRUCTURA DE ALTA DISPONIBILIDAD TI 20/09/2011  444 default 441 116474042   \N  \N
PROTOCOLO SERVIDOR VIRTUAL EN NUBE PARA RESPALDO Y ACTUALIZACION DINAMICA DE AGENDA TELEFONICA CELULAR      445 default 442 173110189   \N  \N
RED SOCIAL TWITTER APLICADA A SEGURIDAD DOMOTICA PROTOTIPO CON ACCESO MOBILE        446 default 443 17084405K   \N  \N
TECNOLOG�?A QR MÓVIL DE APOYO A LA VENTA ONLINE Y FUNCIÓN DE CAJEROS MÓVILES EN SUPERMERCADOS.       447 default 444 174273944   \N  \N
PROTOTIPO DE NODO OBSERVATORIO TERRITORIAL INTEGRADO EN RED,PARA GEOLOCALIZACIÓN DE RECURSOS Y APOYO A LA GESTIÓN DIN�?MICA COMUNAL (P-NOT).     448 default 445 161280070   \N  \N
NODO COMUNAL INTEGRABLE A RED DE GEO-REPRESENTACIÓN DE ZONAS DE RIESGO Y CONTINGENCIA TERRITORIAL, BASADO EN SOFWARE LIBRE (NODO CIR-GR2).      449 default 446 161469912   \N  \N
SISTEMA PARA EL MANEJO DE PARTITURAS DIGITALES BASADA EN TECNOLOG�?A TOUCH-MOBILE PARA ORQUESTAS SINFÓNICAS.     450 default 447 171204593   \N  \N
OBJETOS DE APRENDIZAJE RELATIVOS AL TRATAMIENTO DE ERROR EN LA TRANSMISIÓN Y RECEPCIÓN DE DATOS 14/07/2014  451 default 448 169033188   \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE LAS REDES IP    20/01/2014  452 default 449 166484588   \N  \N
DESARROLLO DE UNA APLICACIÓN MULTIMEDIA QUE APOYE EL APRENDIZAJE DEL IDIOMA CHINO MANDARIN COMO LENGUAJE EXTRANJERA ORIENTADO A LA ESCRITURA        453 default 450 157724282   \N  \N
DISEÑO DE UN LABORATORIO VIRTUAL PARA EL CURSO CRIPTOGRAF�?A 21/07/11    454 default 451 156430579   \N  \N
SISTEMA DE MONITIREO REMOTO EXCLUSIVO PARA DISPOSITIVOS CON SOPORTE IPV6        455 default 452 17372098K   \N  \N
SISTEMA DE APOYO DE GESTIÓN EFICIENTE DE LAS ENERG�?AS DEL DIINF 31/03/2014  456 default 453 173549849   \N  \N
OBJETO DE APRENDIZAJE PARA EL ESTUDIO DE REDES DE �?REA LOCAL    18/08/2014  457 default 454 175646736   \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL APOYO A LA INTRODUCCIÓN A LA PROGRAMACIÓN  18/08/2014  458 default 455 176683007   \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDS SATELITALES 18/01/13    459 default 456 94928400    \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRESIÓN Y APLICACIÓN DE LOS FUNDAMENTOS DE DESARROLLO WEB  20/11/12    460 default 457 160895683   \N  \N
DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA DE COMPRA VENTA DE SEGUROS EN L�?NEA       461 default 458 153742642   \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS PROTOCOLOS DE TRANSPORTE UTILIZADOS EN REDES CONMUTACIÓN DE PAQUETES 22/01/2014  462 default 459 164336646   \N  \N
DESARROLLO DE UN SISTEMA DE NOTIFICACIONES A TRAVÉS DE REDES SOCIALES DE INTERNET   18/01/13    463 default 460 132455252   \N  \N
DESARROLLO DE UN FRAMEWORK PARA LA CONSTRUCCIÓN DE OBJETOS DE APRENDIZAJE   10/4/2014   464 default 461 159674290   \N  \N
DISEÑO E IMPLEMENTACIÓN DE RED COMPUTACIONAL EMPRESA VYS        465 default 462 156394165   \N  \N
SISTEMA DE COMUNICACIÓN DE EMERGENCIAS AL CUERPO DE BOMBEROS DE SANTIAGO        466 default 463 182100625   \N  \N
SOFTWARE DE APOYO AL SEGUIMIENTO DEL PLAN ESTRATÉGICO DE LA EMPRESA PÚBLICA EMERES  23/10/2013  467 default 464 153400253   \N  \N
OBJETO DE APRENDIZAJE PARA EL ESTUDIO DE DISTRIBUCIÓN DE CLAVES CRIPTOPOGR�?FIA      468 default 465 165308697   \N  \N
MODELO PARA LA AUTORIZACIÓN DE TRANSACCIONES FINANCIERAS BASADO EN EST�?NDAR EMV 4/12/2012   469 default 466 158323486   \N  \N
APLICACIÓN DE APOYO AL APRENDIZAJE DE LA FONÉTICA DEL IDIOMA CHINO MANDAR�?N.        470 default 467 166401313   \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS MÉTODOS DE DETECCIÓN Y CORRECCIÓN DE ERRORES EN LA TRANSMISIÓN DE DATOS. 23/07/2013  471 default 468 90073648    \N  \N
EVALUCION DE LA EFICIENCIA DE LOS OBJETOS DE APRENDIZAJE QUE APOYAN LA ENSEÑANZA DE LOS ALUMNOS DEL CURSO DE CRIPTOGRAFIA       472 default 469 141871331   \N  \N
METODOLOG�?A PARA EL DESARROLLO DE OBJETOS DE APRENDIZAJE    26/12/12    473 default 470 166183383   \N  \N
OBJETO DE APRENDIZAJE PARA TRANSMISIÓN DE DATOS 4/12/2014   474 default 471 161228850   \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE PROTOCOLOS CRIPTOGR�?FICOS CL�?SICOS  20/01/2014  475 default 472 173132387   \N  \N
OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DEL MARCO DE TRABAJO DE DESARROLLO DE SOFTWARE SCRUM 4/8/2014    476 default 473 172571182   \N  \N
SERVICIO DE COMUNICACIÓN POR VOZ EN UNA RED INAL�?MBRICA DE MALLA SIMULADA   18/08/2014  477 default 474 171895723   \N  \N
OBJETOS DE APRENDIZAJE EN APOYO A CONDUCTAS DE AUTOCUIDADO PARA NIÑOS Y JÓVENES CON DISCAPACIDAD INTELECTUAL    28/12/12    478 default 475 167182952   \N  \N
    16/10/2013  479 default 476 168401264   \N  \N
SOFTWARE PREDICTIVO DE APOYO A LA PLANEACIÓN DE CAPACIDAD DE INFRAESTRUCTURAS DE RED    4/7/2013    480 default 477 156491373   \N  \N
PLAN DE CAPACITACIÓN EMPRESARIAL PARA ENSEÑAR TELEFONIA CELULAR USANDO OBJETOS DE APRENDIZAJE   20/07/11    481 default 478 154680756   \N  \N
OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DEL PROTOCOLO DE AUTENTICACIÓN KERBEROS  28/12/12    482 default 479 147074220   \N  \N
UNA PLATAFORMA CROWDSOURCING PARA LA PREPARACIÓN DE LA PSU  18/08/2014  483 default 480 174025282   \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDES DE AREA LOCAL (ETHERNET)   29/07/2013  484 default 481 163589419   \N  \N
EAPECIFICACIÓNES FORMAL DE UNA RED MESH ORIENTADA AL ESTUDIO DE ALGORITMOS DE ENRUTAMIENTO Y AUTENTICACIÓN. 5/10/2011   485 default 482 167454761   \N  \N
SERVICIO DE CONFIDENCIALIDAD EN RED DE MALLA INALAMBRICA    20/01/2014  486 default 483 168553439   \N  \N
OBJETO DE APRENDIZAJE PARA APOYAR EL APRENDIZAJE DE LA HERRAMIENTA OMNET++  27/08/2014  487 default 484 168553439   \N  \N
OBJETOS DE APRENDIZAJE COMO HERRAMIENTA DE APOYO A LA ENSEÑANZA DE PROTOCOLOS DE SEGURIDAD EN LA RED.   11/9/2012   488 default 485 163725886   \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE PROTOCOLOS DE SEGURIDAD PARA CORREO ELECTRÓNICOS   9/2/2012    489 default 486 164174034   \N  \N
APLICACION DE APOYO AL APRENDIZAJE DE LA ESCRITURA EN CHINO MANDARIN    25/09/2013  490 default 487 17414852K   \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN Y APLICACIÓN DE IPV6.     491 default 488 158369346   \N  \N
OBJETOS DE APRENDIZAJES PARA COMUNICACIONES DIGITALES   12/12/2013  492 default \N  141545914   \N  \N
GU�? METODOLÓGICA PARA LA IMPLEMENTACIÓN DE UN PROTOCOLO DE AUTENTICACIÓN BASADO EN KERBEROS.    05/02/09    493 default 489 161974579   \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE APLICACIONES DE TIEMPO REAL EN INTERNET    8/8/2014    494 default 490 139154673   \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE ENFOCADOS EN TRANSMISIÓN INAL�?MBRICA   26/01/2012  495 default 491 159005577   \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DEL IDIOMA INGLÉS EN NIÑOS PREESCOLARES 1/8/2013    496 default 492 120041282   \N  \N
SERVICIO PARA COMPARTIR MATERIAL DE ESTUDIO SOBRE UNA RED INAL�?MBRICA DE MALLA SIMULADA     14/08/2014  497 default 493 180830936   \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LA SEGURIDAD EN REDES A TRAVÉS DE FUNCIONES HASH, FUNCIONES MAC Y FIRMA DIGITAL    17/08/12    498 default 494 161483419   \N  \N
OBJETO DE APRENDIZAJE PARA APOYAR EL PROCESO DE LECTURA INFANTIL    4/8/2014    499 default 495 177406538   \N  \N
SISTEMA DE GESTIÓN DE PROYECTOS CONSULTORA SAP PRIME GROUP.     500 default 496 159301567   \N  \N
APLICACIÓN DE APOYO AL APRENDIZAJE DE LA GRAM�?TICA DEL CHINO MANDARIN   14/07/2014  501 default 497 160794321   \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE INTERACTIVOS PARA APOYAR EL ESTUDIO DE LOS MÉTODOS DE DETECCIÓN Y CORRECCIÓN DE ERRORES EN LA TRANSACCIÓN DE DATOS 23/01/2014  502 default 498 169325421   \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS PROTOCOLOS USADOS EN APLICACIONES TIEMPO-REAL EN INTERNET, REAL TIME PROTOCOL (RTP) Y REAL TIME PROTOCOL (RTCP).   23/04/2014  503 default 499 161469912   \N  \N
OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE ALGORITMOS HASH.      504 default 500 164730271   \N  \N
DESARROLLO DE UN SISTEMA DE INFORMACIÓN PARA OPTIMIZAR LA GESTIÓN DE PLANIFICACIÓN DE LA RED DE TRANSMISIÓN ELÉCTRICA.      505 default 501 161989495   \N  \N
DESARROLLO DE UN PROTOTIPO DE RED INAL�?MBRICA DE MALLA PARA EL DEPARTAMENTO DE INGENIER�?A INFORM�?TICA   12/8/2014   506 default 502 18049152K   \N  \N
EVALUACION DE UNA NUEVA METODOLOGIA PARA EL DESARROLLO DE OBJETOS DE APRENDIZAJE    13/09/2013  507 default 503 162121774   \N  \N
EVALUACIÓN DE METODOLOG�?A CPIS PARA EL DESARROLLO DE OBJETOS DE APRENDIZAJE 24/03/2014  508 default 504 162121774   \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO Y COMPRENSIÓN DE LOS PROTOCOLOS DE SEGURIDAD IPSEC Y SSL PARA INTERNET    27/07/12    509 default 505 163827255   \N  \N
DESARROLLO DE UN REPOSITORIO DE OBJETOS DE APRENDIZAJE PARA EL DEPARTAMENTO DE INGENIER�?A INFORM�?TICA   10/12/2012  510 default 506 166570722   \N  \N
IMPLEMENTACIÓN DE SEGURIDAD EN ROLES Y PERFILES PARA SAP ERP EN CONSTRUMART S.A.    19/11/12    511 default 507 139368142   \N  \N
OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE PROTOCOLOS DE APLICACIÓN EN INTERNET  5/7/2014    512 default 508 128108408   \N  \N
APLICACIÓN WEB PARA LA ADMINISTRACIÓN DE EVALUACIONES DE ATENCIÓN A CLIENTES PARA CONSULTORA GETGAIN    12/11/2012  513 default 509 136874667   \N  \N
DESARROLLO DE OBJETIVOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS MECANISMOS DE CONTROL DE CONGESTION USANDO REDES DE CONMUTACION DE PAQUETES    24/09/2013  514 default 510 16385788K   \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE LOS MECANISMOS DE CONTROL DE CONGESTIÓN EN REDES DE CONMUTACIÓN DE PAQUETES 29/07/2014  515 default 511 16385788K   \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDES DE TELEFON�?A CELULAR.      516 default 512 167404855   \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN DE LOS CIFRADOS SIMÉTRICOS AES Y DES.     517 default 513 162774778   \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDES WI-FI Y WI-MAX 20/06/2013  518 default 514 160265353   \N  \N
METODO DE VALIDACION PARA OBJETOS DE APRENDIZAJE    11/10/2013  519 default 515 169102627   \N  \N
UN ALGORITMO DE AUTENTICACIÓN PARA LA SEGURIDAD EN REDES DE MALLA   27/07/12    520 default 516 160208619   \N  \N
MODELO DE GESTIÓN DE COTIZACIONES Y VENTAS DE SEGUROS DE VEH�?CULOS  25/09/2014  521 default 517 152509022   \N  \N
PROCESO DE NEGOCIO Y REQUERIMIENTOS PARA SISTEMA DE RECLUTAMIENTO Y SELESCCIÓN DE EMPRESA DE �?REA FINANCIERA    18/01/13    522 default 518 152509022   \N  \N
ESTUDIO Y DESARROLLO DE UN SISTEMA DE RESPALDO (BACKUP) Y RECUPERACIÓN PARA LA SEGURIDAD Y CONTINUIDAD OPERACIONAL DE PROVECTIS S.A.        523 default 519 158366037   \N  \N
DISEÑO E IMPLEMENTACIÓN DE UN REPOSITORIO DE OAS PARA EL DEPARTAMENTO DE INGENIÉRIA INFORM�?TICA     524 default 520 155648511   \N  \N
OBJETO DE APRENDIZAJE SOBRE LA DIRECCIÓN Y GESTIÓN DE PROYECTOR TI  18/08/2014  525 default 521 144878552   \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN DE LOS CIFRADORES SIMÉTRICOS RC4, IDEA Y BLOWFISH 9/1/2013    526 default 522 161168440   \N  \N
DISEÑO, IMPLEMENTACIÓN Y AN�?LISIS DE BLOQUES ATÓMICOS EN CONTRA DE SSCA, ATAQUES C-SAFE-FAULTS Y ATAQUES DE COLISIÓN DE CORRELACIÓN HORIZONTAL EN CRIPTOGRAF�?A DE CURVA EL�?PTICA    22/12/2014  527 default 523 171891841   \N  \N
OBJETO DE APRENDIZAJE PARA APOYAR LA ENSEÑANZA DE PROTOCOLOS DE VENTANA DESLIZANTE  23/12/2014  528 default 524 169772835   \N  \N
APLICACIÓN DE UN MÉTODO DE VALIDACIÓN SOBRE LOS OBJETOS DE APRENDIZAJE DEL REPOSITORIO DEL DIINF    19/12/2014  529 default 525 166398703   \N  \N
OBJETOS DE APRENDIZAJE SOBRE CRIPTOGRAF�?A SIMÉTRICO PARA BLOWFISH   19/12/2014  530 default 526 176782765   \N  \N
LOCALIZACIÓN Y SEGUIMIENTO DE PERSONAS DENTRO DE UN TREN EN MOVIMIENTO UTILIZANDO VISIÓN ARTIFICIAL 20/01/2014  531 default 527 169402035   \N  \N
CONTABILIZACIÓN DE PERSONAS QUE SUBEN Y BAJAN DE UN TREN METROPOLITANO USANDO VISIÓN POR COMPUTADOR 23/01/2014  532 default 528 170054989   \N  \N
DETECCIÓN DE PERSONAS EN TIEMPO REAL MEDIANTE EL USO DE UNA RASPBERRY PI    20/01/2014  533 default 529 166078482   \N  \N
DETECCIÓN DE VEH�?CULOS DETENIDOS EN SECTORES PROHIBIDOS DEL TR�?FICO URBANO UTILIZANDO TÉCNICAS DE VISIÓN POR COMPUTADOR.    22/01/2014  534 default 530 169033285   \N  \N
AN�?LISIS COMPARATIVO DE CLASIFICADORES EN CUANTO A SU SENSIBILIDAD ESPACIAL PARA LA DETECCIÓN DE PEATONES EN IM�?GENES   24/07/2014  535 default 531 174276471   \N  \N
DETECCIÓN, LOCALIZACIÓN Y CONTEO AUTOM�?TICO DE PERSONAS QUE ENTRAN A UN MICROBÚS, MEDIANTE ALGORITMOS DE VISIÓN POR COMPUTADOR. 10/3/2014   536 default 532 170865510   \N  \N
PICKUP AND DELIVERY PROBLEM: APLICACIÓN AL PROBLEMA DE ASIGNACIÓN DE TAREAS PARA LA FLOTA DE CAMIONES DE TRANSPORTES BELLO.     537 default 533 160080280   \N  \N
SISTEMA WEB DE VIDEOS CLASIFICADOS DE APOYO EN LA PREPARACIÓN DE ESTUDIANTES PARA LA PSU-MATEM�?TICAS    5/8/2013    538 default 534 128712135   \N  \N
UN MODELO DE OPTIMIZACIÓN PARA EL RUTEO DE FLOTA DE CAMIONES DE UNA EMPRESA DE TRANSPORTES      539 default 535 158384043   \N  \N
EVOLUCIÓN DE METAHEUR�?STICAS PARA PROBLEMAS DE OPTIMIZACIÓN COMBINATORIA    18/08/2014  540 default 536 176303034   \N  \N
UNA SOLUCIÓN AL PROBLEMA DE PLANIFICACIÓN DE DISTRIBUCIÓN DE CONTENEDORES LLENOS Y VAC�?OS.      541 default 537 160895683   \N  \N
GENERACION DE NUEVOS ALGORITMOS UTILIZANDO PROGRAMACION GENETICA PARA EL PROBLEMA DE OPTIMIZACION JOB SHOP FLEXIBLE 30/09/2013  542 default 538 171893798   \N  \N
SITIO WEB PARA LA INCORPORACION DE VIDEOS EN LAS SALAS DE CLASES    7/4/2011    543 default 539 130727859   \N  \N
RESOLVIENDO EL PROBLEMA CORTE DE PIEZAS GUILLOTINA MEDIANTE LA COMPUTACION EVOLUTIVA    24/09/2013  544 default 540 166070201   \N  \N
ALGOBOTS PARA EL PROBLEMA DE LA MOCHILA MULTIDIMENSIONAL    3/9/2013    545 default 541 179475634   \N  \N
GENERACION AUTOMATICA DE ALGORITMO PARA EL PROBLEMA DE FORMACION DE CELULAS DE MANUFACTURAS     546 default 542 165385454   \N  \N
DETECCIÓN DE FALLAS EN GRANJA FOTOVOLTAICA MODULAR DE 10 MW/H   18/07/2014  547 default 543 160170166   \N  \N
ESTUDIO DE APLICABILIDAD DE VIDEOS JUEGOS PARA SOLUCIONAR PROBLEMAS DE OPTIMIZACION     548 default 544 167535682   \N  \N
GENERACION DE ALGORITMOS PARA EL PROBLEMA JOB-SHOP FLEXIBLE UTILIZANDO PROGRAMACION GENETICA    24/09/2013  549 default 545 181652497   \N  \N
UN ALGORITMO GENÉTICO COOPERATIVO PARA PROBLEMAS DE CORTES Y EMPAQUE    26/06/2012  550 default 546 159172090   \N  \N
UNA SOLUCIÓN HEUR�?STICA PARA EL PROBLEMA ASIGNACIÓN DE BUSES Y TRIPULACIONES CONSIDERANDO SUS ROTACIONES.       551 default 547 159172090   \N  \N
UN AG COOPERATIVO PARA PROBLEMAS DE CORTE Y EMPAQUE     552 default 548 159172090   \N  \N
NUEVOS ALGOR�?TMOS ARTIFICIALES DE OPTIMIZACIÓN PARA EL WEIGHTED INDEPENDENCE SET PROBLEM BAJO LA TEOR�?A DE LA COMPUTACIÓN EVOLUTIVA 16/12/2013  553 default 549 158422867   \N  \N
MEJORA DE ALGORITMOS AUTOM�?TICOS PARA EL PROBLEMA DE LA MOCHILA IDENTIFICANDO EL CONJUNTO DE FUNCIONES Y TERMINALES ADECUADO    7/8/2012    554 default 550 169215219   \N  \N
AGENTES RECURSIVOS PARA EL CONTROL DE LA CENTRALIZACIÓN Y DISTRIBUCIÓN DE LAS DECISIONES EN SISTEMAS INTELIGENTES DE PRODUCCIÓN 10/7/2012   555 default 551 151138853   \N  \N
EVALUACIÓN DE LOS MÉTODOS NARX Y NARMAX CON REDES NEURONALES Y M�?QUINA DE SOPORTE VECTORIAL PARA LA ESTIMACIÓN DE LA ACCIDENTABILIDAD EN LA MINER�?A     556 default 552 153811229   \N  \N
GENERACIÓN DE UNA SOLUCIÓN HEUR�?STICA PARA EL PROBLEMA DE TSPPC A TRAVÉS DE LA PROGRAMACIÓN GENÉTICA    18/08/2014  557 default 553 183017578   \N  \N
EVOLUCION DE ALGORITMOS DETECTORES DE TRAYECTORIA PARA EL PROBLEMA DEL VENDEDOR VIAJERO 30/09/2013  558 default 554 174746761   \N  \N
EFECTOS DEL CRITERIO DE ENFRIAMIENTO SOBRE SIMULATED ANNEALING EN LA RESOLUCIÓN DEL PROBLEMA DEL �?RBOL DE COBERTURA M�?NIMA  12/9/2012   559 default 555 159598373   \N  \N
DISEÑO Y DESARROLLO DE UNA PLATAFORMA PARA EL SOPORTE DE LAS CLASAS VIRTUALES EN CURSOS DE INGENIER�?A EN EJECUCIÓN EN COMPUTACIÓN E INFORM�?TICA.        560 default 556 161561444   \N  \N
REGISTRO DE IM�?GENES ASTRONÓMICAS   21/01/2014  561 default 557 165581555   \N  \N
UN JUEGO GENERADOR DE ALGORITMOS PARA EL PROBLEMA DE LA MOCHILA.        562 default 558 167959008   \N  \N
GENERACION ATOMATICA DE ALGORITMOS PARA EL PROBLEMA DEL VENDEDOR VIAJERO    24/09/2013  563 default 559 180977104   \N  \N
UNA RESOLUCIÓN AL PROBLEMA DE LA SELECCIÓN UBICADA DE INTERRUPTORES EN UN SISTEMA DE DISTRIBUSIÓN ELÉCTRICO, CON MÉTODO DE OPTIMIZACIÓN HEUR�?STICA ALGORITMO GENÉTICO PARALELO  2/8/2010    564 default 560 163725886   \N  \N
SOLUCIÓN NUMÉRICA AL PROBLEMA DEL �?RBOL DE COBERTURA M�?NIMO GENERALIZADO MEDIANTE SIMULATED ANNEALING       565 default 561 161365475   \N  \N
REDUCCIÓN DE ARISTAS PARA INSTANCIAS DE �?RBOL DE COBERTURA M�?NIMO GENERALIZADO      566 default 562 161365475   \N  \N
UNA CONTRIBUCIÓN AL PROBLEMA DE ASIGNACIÓN DE VEH�?CULOS CON MÚLTLIPES DEPÓSITOS Y MANTENCIONES PROGRAMADAS      567 default 563 164120538   \N  \N
GENERACIÓN AUTOM�?TICA DE ALGORITMOS PARA EL PROBLEMA DE CORTE DE PIEZAS NO GUILLOTINA CON PROGRAMACIÓN GENÉTICA BINARIA PARALELA.       568 default 564 156434027   \N  \N
IDENTIFICACIÓN DE PATRONES DE USO PARA USUARIOS DEL TRANSANTIAGO.       569 default 565 163549239   \N  \N
GENERACIÓN AUTOM�?TICA DE ALGORITMOS DE CLUSTERIZACIÓN.  10/3/2014   570 default 566 161989495   \N  \N
BÚSQUEDA DE ALGORITMOS ESPECIALIZADOS PARA FAMILIAS DE INSTANCIAS DE PROBLEMAS DE OPTIMIZACIÓN  20/01/2014  571 default 567 145981859   \N  \N
NUEVOS ALGORITMOS ARTIFICIALES PARA LA ASIGNACION DE BUSES Y SERVICIOS DE CONDUCCION EN EL TRANSPORTE URBANO        572 default 568 160186801   \N  \N
GENERACIÓN DE LA CALENDARIZACIÓN DE LOS PARTIDOS DEL CAMPEONATO DE FÚTBOL DE CHILE MEDIANTE SIMULATED ANNEALING     573 default 569 166579643   \N  \N
GENERACIÓN DE ALGORITMOS PARA EL PROBLEMA DE OPTIMIZACIÓN CELL FORMATION PROBLEM UTILIZANDO COMPUTACIÓN EVOLUTIVA   20/01/2014  574 default 570 172717144   \N  \N
IMPLEMENTACION DE HERRAMIENTA DE APOYO A LA GESTION DE LA DOCENCIA EN  COLEGIOS DE EDUCACION MEDIA BASDA EN TECNOLOGIA DE CODIGO ABIERTO        575 default 571 166156971   \N  \N
DESARROLLO DE UN SISTEMA PARA MEJORAR LA BÚSQUEDA Y MANEJO DE �?TEMS DE CONFIGURACIÓN PARA APOYO AL PROCESO DE GESTIÓN DE CONFIGURACIÓN ITIL V3  25/06/2014  576 default 572 166156971   \N  \N
APLICANDO INDICADORES A ALGORITMOS GENERADOS POR PROGRAMACIÓN GENÉTICA PARA EL PROBLEMA NP-C TSP.   10/5/2012   577 default 573 153480389   \N  \N
NUEVOS ENFOQUES ALGOR�?TMICOS PARA JOB SHOP SCHEDUBLING PROBLEM Y FLOW SHOP SCHEDULING PROBLEM   13/07/2012  578 default 574 164740773   \N  \N
GENERADOR DE ALGORITMOS PARA RESOLVER EL PROBLEMA DE LA PLANIFICACIÓN DE BUSES PARA EL TRANSPORTE URBANO DE PASAJEROS   7/9/2012    579 default 575 114651214   \N  \N
CREACIÓN AUTOMATICA DE ALGORITMOS PARA RESOLVER EL PROBLEMA DE CAMINO MINIMO BASANDOSE EN COMPUTACIÓN EVOLUTIVA0    24/07/2012  580 default 576 173771955   \N  \N
DESARROLLO E IMPLEMENTACION DE CONTENIDOS DE UN SITIO WEB PARA LA SOLUCION DE LOS PROBLEMAS DEL CAMINO MINIMO, FLOW SHOP Y JOB SHOP Y ARBOL DE COBERTURA DE COSTO MINIMO    4/8/2010    581 default 577 092174379   \N  \N
ALGORITMO DE CLASIFICACIÓN DE GALAXIAS SEGÚN SU MORFOLOG�?A EN IM�?GENES CAPTURADAS POR EL RADIOTELESCOPIO DEL OBSERVATORIO ALMA. 14/03/2014  582 default 578 170291220   \N  \N
GENERACIÓN DE TURNOS LABORALES PARA LOG�?STICA AEROPORTUARIA MEDIANTE OPTIMIZACIÓN ROBUSTA   16/12/2013  583 default \N  166166454   \N  \N
NUEVAS HIPERHEUR�?STICAS COMPETITIVAS PARA EL PROBLEMA DEL CONJUNTO INDEPENDIENTE M�?XIMO DE VÉRTICES 20/01/2014  584 default 579 169428166   \N  \N
GENERACIÓN DE ALGORITMOS UTILIZANDO PROGRAMACIÓN GENÉTICA PARA EL PROBLEMA DE OPTIMIZACIÓN GENERALIZED TRAVELLING SALESMAN PROBLEM  20/01/2014  585 default 580 158207664   \N  \N
EVALUACIÓN DE ALGORITMOS GENÉTICOS CELULARES PARA EL PROBLEMA DE CORTE DE PIEZAS    28/12/12    586 default 581 15366708K   \N  \N
DISEÑO DE UN ALGORITMO PARA EL PROBLEMA DEL COLOREAMIENTO DE GRAFOS A TRAVÉS DE UN JUEGO COMPUTACIONAL.     587 default 582 163905140   \N  \N
UN SISTEMA WEB DE VIDEOS EDUCATIVOS PARA SEGUNDO Y TERCER NIVEL DE INGENIER�?A.      588 default 583 171100062   \N  \N
CO-EVOLUCIÓN COMPUTACIONAL EN PROBLEMAS DE OPTIMIZACIÓN COMBINATORIA    22/12/2014  589 default 584 173196474   \N  \N
REVISIÓN Y MEJORAS DEL SOFTWARE PARA LA ADMINISTRACIÓN DE LAS POSTULACIONES A PROGRAMAS VESPERTINOS DEL DIINF   23/12/2014  590 default 585 17919998k   \N  \N
DATOS SENSIBLES Y SU MANIPULACIÓN EN DISPOSITIVOS MÓVILES   23/12/2014  591 default 586 181724315   \N  \N
APLICACIÓN MULTIPLATAFORMA PARA DENUNCIAS, SUCESOS Y EVENTOS GEOCALIZADOS EN TIEMPO REAL CON EVIDENCIA MULTIMEDIA   1/12/2014   592 default 587 180628754   \N  \N
SISTEMA WEB DE CARACTERIZACIÓN BIOLÓGICA DE GRUPOS DE GENES     22/12/2014  593 default 588 17962091K   \N  \N
PROP    14/05/2015  602 1/2016  594 159073122   f   \N
PPP 16/05/2015  603 1/2016  595 128516948   f   \N
ASD 16/05/2015  604 1/2016  596 173832168   f   \N
123 29/05/2015  605 1/2016  597 171818575   f   \N
PROPUESTA PROP  20/05/2015  607 1/2016  598 166257344   f   \N
PROPUESTA PROP1 17/05/2015  608 1/2016  599 128516948   f   \N
PROP EJEMP  21/05/2015  609 1/2016  \N  173832168   f   \N
ASDASDAS    14/05/2015  611 1/2016  \N  153179409   f   \N
ASDASDSDSADSA   19/05/2015  612 1/2016  602 128516948   f   \N
PROPUESTA EJEMPLO 2 21/05/2015  613 1/2016  603 153179409   f   \N
PROPUESTA CON JOSE LUIS 18/05/2015  614 1/2016  604 173832168   f   \N
PROPUESTA ASD   20/05/2015  615 1/2016  605 153179409   f   \N
PROPP   20/05/2015  616 1/2016  606 128516948   f   \N
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
1   Ajedrez 1
2   Básquetbol  1
3   Fútbol  1
4   Actividades de Inducción    3
5   Ceremonia   3
6   Charla  3
7   Tenis   1
8   Concurso    3
9   Lanzamiento de Libros   3
10  Presentación artística  3
11  Presentación Cultural   3
12  Taller  3
13  Charla  2
14  Coloquio    2
15  Congreso    2
16  Curso   2
17  Encuentro   2
18  Feria   2
19  Seminario   2
20  Taller  2
\.


--
-- Data for Name: tema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tema (nombre_tema, fecha_tema, estado_tema, id_tema, id_correctora, id_semestre, id_revisora, fecha_siac, fecha_real, semestre_termino, precierre, precerrado) FROM stdin;
DISEÑO DE UN SISTEMA QUE PERMITA LA CREACIÓN DE APLICACIONES EDUCATIVAS 30/03/13    1   5   3   default 5   \N  \N  \N  \N  \N
SOLUCION TECNOLOGICA PARA LA CREACION DE SITIOS WEB Y SU GESTION DE INFORMACION, EN UNA EMPRESA DE SELECCIÓN DE PERSONAL    4/8/2010    1   8   5   default 8   \N  \N  \N  \N  \N
SOFTWARE DE APOYO AL PROCESO ADMINISTRATIVO DE LA EMPRESA OPTICA REAL   11/10/2012  3   10  \N  default 10  \N  \N  \N  \N  \N
SISTEMA DE EVALUACIÓN INTERACTIVO CON DISPOSITIVOS SMARTPHONE   1/2014  3   18  \N  default 18  \N  \N  \N  \N  \N
SISTEMA INFORM�?TICO PARA EL PROCESO DE POSTULACIÓN EN L�?NEA Y POSTERIOR SELECCIÓN DE AYUDANTES DEL DEPARTAMENTO DE INFENIER�?A INFORM�?TICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE    7/9/2012    1   11  6   default 11  \N  \N  \N  \N  \N
IMPLEMENTACIÓN DE WEB SERVICE PARA INTEGRACIÓN SAP CON PLATAFORMAS WEB      3   19  \N  default 19  \N  \N  \N  \N  \N
SISTEMA INFORM�?TICO PARA LA GESTIÓN DE RECURSOS DEL DEPARTAMENTO DE DEPORTES DE LA UNIVERSIDAD DE SANTIAGO DE CHILE 2/2013  1   12  7   default 12  \N  \N  \N  \N  \N
AUTOMATIZACIÓN DEL PROCESO PARA VISADO DE PAGO A PROVEEDORES DE LA EMPRESA ENVASES DEL PAC�?FICO (EDELPA)    11/11/2014  3   21  \N  default 21  \N  \N  \N  \N  \N
SISTEMA PARA MONITOREO Y GESTIÓN DE REQUERIMIENTOS E INCIDENTES DE CLIENTES CORPORATIVOS EMPRESA ENTEL, MEDIANTE HERRAMIENTA SPLUNK 20/03/12    1   13  8   default 13  \N  \N  \N  \N  \N
DESARROLLAR JUEGOS PARA CURSO DE ECONOM�?A DE BACHILLER DE TECNOLOG�?A        3   15  \N  default 15  \N  \N  \N  \N  \N
DESARROLLO DE SISTEMA DE PLANIFICACIÓN DE MISIÓN Y CONTROL ADAPTIVO EN VUELO PARA EL SISTEMA AEREO ROBOTICO RUAS    11/10/1012  3   27  \N  default 27  \N  \N  \N  \N  \N
PROTOTIPO FUNCIANAL DE UN SISTEMA BROKER PARA LA EMPRESA SOLINGAS S.A   11/1/2013   1   16  9   default 16  \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA WEB ADMINISTRATIVO Y RESERVAS DE ATENCIÓN EN L�?NEA PARA UNA SERVITECA 11/1/2013   3   17  \N  default 17  \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE TECNOLOG�?AS DE LA INFORMACIÓN EN LA ENSEÑANZA B�?SICA   11/1/2013   3   20  \N  default 20  \N  \N  \N  \N  \N
SOFTWARE PARA PLANIFICACIÓN DE VUELO FOTOGRAMÉTRICO DE UAV EN TERRENOS COMPLEJOS    1/2014  3   28  \N  default 28  \N  \N  \N  \N  \N
OBEJTOS DE APRENDIZAJE PARA LA ENSEÑANZA DE LA LENGUA DE SEÑAS CHILENAS PARA NIÑOS CON DISCAPACIDAD AUDITIVA    11/1/2013   1   22  10  default 22  \N  \N  \N  \N  \N
SISTEMA DE DETECCIÓN Y EVASIÓN DE OBST�?CULOS PARA UAV CUADRICOPTERO BASADO EN ARDUPILOT 1/2014  3   32  \N  default 32  \N  \N  \N  \N  \N
HERRAMIENTA DE SOFTWARE PARA ENTREGA DE INFORMACIÓN TUR�?STICA DIFERENCIADA Y FOCALIZADA EN PERFILES DE TURISTICA    30/03/12    1   23  11  default 23  \N  \N  \N  \N  \N
SISTEMA DE DETECCIÓN DE PERSONAS EXTRAVIADAS, POR MEDIO DE RECONOCIMIENTO DE PATRONES EN IMAGÉNES TRANSMITIDAS EN TIEMPO REAL DESDE AVIÓN NO TRIPULADO  11/01/13    3   33  \N  default 33  \N  \N  \N  \N  \N
PROTOCOLO PARA LA INTEROPERACIÓN DE UAVS, MEDIANTE UNA TORRE DE CONTROL VIRTUAL EN UN ESPACIO  AÉREO NO SEGREGADO "OGMIOS"  12/10/11    1   24  12  default 24  \N  \N  \N  \N  \N
UN SISTEMA PARA EL LANZAMIENTO DE SUMINISTROS MÉDICOS DESDE UN VEH�?CULO AÉREO NO TRIPULADO  2/2013  3   35  \N  default 35  \N  \N  \N  \N  \N
EVALUACIÓN DEALGORITMOS AEROFOTOGRAMÉTRICOS PARA CORRECCIÓN ORTOGONAL DE IM�?GENES, OBTENIDAS MEDIANTES UAV, USACDAS PARA GENERAR MOSAICOS Y MODELOS 3D  21/03/2013  1   26  13  default 26  \N  \N  \N  \N  \N
DESARROLLO DE SOFTWARE PARA CONTROL DE PLANES DE VUELO DE SISTEMA ROBÓTICO AÉREO MULTIAGENTE, BASADO EN LA ARQUITECTURA L-ALLIANCE  11/01/13    3   29  \N  default 29  \N  \N  \N  \N  \N
IMPLEMENTACIÓN DE ARQUITECTURA MULTIAGENTE L-ALLIANCE PARA EL CONTROL DE COMPORTAMIENTO DE VUELO DE ROBOTS AÉREOS       3   30  \N  default 30  \N  \N  \N  \N  \N
AUTOPILOTO INTEGRADO EN SMARTPHONE PARA VEH�?CULO AÉREO NO TRIPULADO (UAV)   1/2014  3   36  \N  default 36  \N  \N  \N  \N  \N
DIFERENCIACIÓN DE VIGOR VEGETATIVO EN CULTIVOS AGR�?COLAS POR MEDIO DEL TRATAMIENTO DE IM�?GENES INFRARROJAS AÉREAS, CAPTURADAS CON UN AVIÓN ROBOTIZADO   30/03/12    1   31  14  default 31  \N  \N  \N  \N  \N
SISTEMA DE SOFTWARE EMBEBIDO EN HARDWARE PARA DETECCIÓN DE FIGURAS HUMANAS DESDE ROBOT AÉREO    2/2014  3   38  \N  default 38  \N  \N  \N  \N  \N
SISTEMA DE APOYO A LA DOCUMENTACIÓN DE IM�?GENES, AUTOMATIZANDO EL RECONOCIMIENTO DE EDIFICIOS Y ESTRUCTURAS 11/10/12    1   34  15  default 34  \N  \N  \N  \N  \N
DESARROLLO DE UNA PLATAFORMA DE SOFTWARE PARA PRUEBAS DE REGRESIÓN AUTOMATIZADAS DE APLICACIONES WEB USADAS EN EL OBSERVATORIO ALMA 23/07/2013  3   40  \N  default 40  \N  \N  \N  \N  \N
SISTEMA DE ORIENTACIÓN DE SERVICIOS TUR�?STICOS PARA DISPOSITIVOS MÓVILES UTILIZANDO REALIDAD AUMENTADA. 30/03/12    1   37  16  default 37  \N  \N  \N  \N  \N
UTILIZACIÓN DE UNA METODOLOG�?A �?GIL PARA ENTEL S.A. 29/07/2013  3   41  \N  default 41  \N  \N  \N  \N  \N
APLICACIÓN WEB PARA EVALUACIÓN DEL DESEMPEÑO Y AUTOCONSULTA DE RECURSOS HUMANOS 22/01/13    1   39  17  default 39  \N  \N  \N  \N  \N
UNA APLICACIÓN COLABORATIVA PARA APOYAR EL USO DE LA METODOLOG�?A DE SISTEMAS BLANDOS DE PETER CHECKLAND 1/2014  3   44  \N  default 44  \N  \N  \N  \N  \N
DESARROLLO DE UNA APLICACIÓN DE PROTOTIPO EN LA WEB USANDO TECNOLOG�?A DE LA NUBE    22/07/2013  1   42  18  default 42  \N  \N  \N  \N  \N
PREDICCIÓN DE LA RENTABILIDAD DE LOS FONDOS DE PENSIONES UTILIZANDO AUTÓMATAS CELULARES 22/07/2013  3   45  \N  default 45  \N  \N  \N  \N  \N
SISTEMA DE APOYO A LA GESTIÓN PARA EL PROCESO DE CERTIFICACIÓN DE SOFTWARE QA   22/07/2013  1   43  19  default 43  \N  \N  \N  \N  \N
CLASIFICADOR DE PUNTOS SOBRE NUBE DE OBJETOS GENERADA POR SISTEMA LIDAR     3   46  \N  default 46  \N  \N  \N  \N  \N
UNA APLICACIÓN MÓVIL QUE APOYA LA REALIZACIÓN DE LA METODOLOG�?A DE SISTEMAS BLANDOS DE PETER CHECKLAND  2/2014  3   47  \N  default 47  \N  \N  \N  \N  \N
PROPUESTA DE MEJORAS METODOLÓGICAS PARA LA GESTIÓN DE LA INCERTIDUMBRE EN PROYECTOS DE SOFTWARE �?GILES DESDE UN ENFOQUE DE SISTEMAS BLANDOS 2/2014  3   48  \N  default 48  \N  \N  \N  \N  \N
SISTEMA DE SOPORTE A EDUCADORES EN ENTORNOS DE EVALUACIÓN Y APRENDIZAJE DE ALUMNOS CON NECESIDADES EDUCATIVAS ESPECIALES EN �?REAS COGNITIVAS    1/2014  3   49  \N  default 49  \N  \N  \N  \N  \N
SISTEMA DE ADMINISTRACIÓN PARA LA INFORMACIÓN TRANSPARENTE EN UNA COMUNIDAD DE EDIFICIOS        3   9   \N  default 9   \N  \N  \N  \N  \N
DESARROLLO DE ESTRATÉGIAS DE PLANIFICACIÓN PARA MOTORES DE BÚSQUEDA VERTICALES      3   51  \N  default 51  \N  \N  \N  \N  \N
PREDICCIÓN DE L ESTRUCTURA TRIDIMENSIONAL DE PROTE�?NAS MEDIANTE CLOUD COMPUTING     1   54  20  default 54  \N  \N  \N  \N  \N
ADAPTACIÓN DE ALGORITMOS DE ORDENAMIENTO A M�?QUINAS DE BÚSQUEDA VERTICALES  11/1/2013   3   55  \N  default 55  \N  \N  \N  \N  \N
SISTEMA DE APOYO A LA PLANIFICACIÓN DOCENTE Y MEDICIÓN DEL ESTADO DE AVANCE DE LOS ALUMNOS EN HABILIDADES COGNITIVAS ESPEC�?FICAS    30/03/2013  3   3   \N  1/2016  3   15/05/2015  15/05/2015  \N  \N  \N
DESARROLLO DE API DE VALIDACIÓN MEDIANTE HUELLA DIGITAL EN TARJETAS CON CHIP    11/10/2012  1   2   2   2/2012  2   16/05/2015  15/05/2015  \N  \N  \N
NO HAY INFORMACION      3   246 \N  default 246 \N  \N  \N  \N  \N
DESARROLLO DE PROTOTIPO DE UNA CALCULADORA DE DOSIS PARA EL APOYO DEL �?REA DE PEDRIATR�?A    15/05/2015  3   14  \N  1/2015  14  17/05/2015  16/05/2015  \N  \N  \N
SOFTWARE DE AGENDA PERSONAL Y ASISTENTE PARA ESTRATEGIAS SOCIALES PARA PERSONAS CON S�?NDROME DE ASPERGER    1/2014  3   52  \N  default 52  \N  \N  \N  \N  \N
ESTUDIO Y AN�?LISIS DE HERRAMIENTAS DE PROCESAMIENTO DE DATOS EN STREAMING   11/1/2013   1   57  21  default 57  \N  \N  \N  \N  \N
PREDICCION DE LA ESTRUCTURA TRIDIMENSIONAL DE PROTEINAS MEDIANTE CLOUD COMPUTING        3   53  \N  default 53  \N  \N  \N  \N  \N
PROTOTIPO DE SOFTWARE DE COMUNICACIÓN A TRAVÉS DE BLUETOOTH PARA USO COMERCIAL Y SOCIAL 11/01/13    1   59  22  default 59  \N  \N  \N  \N  \N
IMPLEMENTACIÓN DE ALGORITMOS DE MEJORA DE CLASIFICACIÓN EXTRA�?DOS DESDE EL ESTADO DEL ARTE  1/2014  3   56  \N  default 56  \N  \N  \N  \N  \N
INSTALACIÓN Y CONFIGURACIÓN DE HERRAMIENTA ORACLE ENTERPRICE GOVERNANCE, RISK AND COMPLIANCE, MÓDULO APPLICATION ACCESS CONTROL GOVERNOR    29/07/2013  1   67  23  default 67  \N  \N  \N  \N  \N
SISTEMA DE SEGUIMIENTO DE JUICIOS APOYAR LA GESTIÓN DE COBRANZA DE EMPRESA RECOLINE 21/12/2012  3   71  \N  default 71  \N  \N  \N  \N  \N
SISTEMA WEB DE APOYO A LAS VENTAS Y SERVICIOS TÉCNICOS DE LA EMPRESA IMPORTADORA NORTE  28/09/2012  3   72  \N  default 72  \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DE UN FIREWALL EN ALTA DISPONIBILIDAD       3   58  \N  default 58  \N  \N  \N  \N  \N
SISTEMA DE TRAZABILIDAD COMO APOYO AL PROCESO DE ELABORACIÓN DE JUGO/MOSTO  2/2012  1   74  24  default 74  \N  \N  \N  \N  \N
APLICACIÓN DE APOYO AL PROCESO DE GESTIÓN DE SERVICIOS DE TALLER    1/2014  3   60  \N  default 60  \N  \N  \N  \N  \N
SISTEMA DE CONTROL DE ASISTENCIA Y APOYO AL C�?LCULO DE REMUNERACIONES BASADOS EN PRODUCCIÓN 2/2012  1   75  25  default 75  \N  \N  \N  \N  \N
SISTEMA DE SEGUIMIENTO DE CLIENTES DE UNA EMPRESA INFORM�?TICA   1/2014  3   61  \N  default 61  \N  \N  \N  \N  \N
CENTRAL DE REPORTES PARA EL �?REA DE RIESGOS DE MERCADO DEL BANCO SANTANDER  11/09/13    1   77  26  default 77  \N  \N  \N  \N  \N
DESARROLO DE BASE DE DATOS PARA OBSERVATORIOS WEB   1/2014  3   62  \N  default 62  \N  \N  \N  \N  \N
METODOLOG�?A DE GESTIÓN DE PROCESOS ORIENTADA A LA DETERMINACIÓN Y ADMINISTRACIÓN DE RIESGOS OPERACIONAL EN UNA INSTITUCIÓN BANCARIA 27/2012 1   79  27  default 79  \N  \N  \N  \N  \N
ALGORITMO DE IDENTIFICACIÓN DE L�?DERES DE OPINIÓN EN TWITTER        3   63  \N  default 63  \N  \N  \N  \N  \N
IMPLEMENTACIÓN DE BPM PARA LA GESTIÓN DOCUMENTAL DE UN SERVICIO PÚBLICO 15/01/2013  1   80  28  default 80  \N  \N  \N  \N  \N
SISTEMA DE UBICACIÓN DEL CENTRO DE MASA EN ADULTOS MAYORES A TRAVÉS DE DISPOSITIVOS MÓVILES 1/2014  3   64  \N  default 64  \N  \N  \N  \N  \N
SISTEMA DE ADMINISTRACIÓN DE CAPACITACIONES PARA EMPRESA CAPACITACIÓN USACH LTDA.   20/01/2014  1   81  29  default 81  \N  \N  \N  \N  \N
SIMULACION DE APLICACIOINES UTILIZADAS EN ESCENARIOS DE EMERGENCIA, DESPLEGADAS SOBRE LA PLATAFORMA S4 ADAPTADA A CELULARES     3   65  \N  default 65  \N  \N  \N  \N  \N
INTEGRACIÓN DE PLATAFORMA ERP CORPORATIVA CON LICENCIA MEDICA ELECTRONICA Y REDISEÑO DE PROCESOS ASOCIADOS  25/01/2013  1   82  30  default 82  \N  \N  \N  \N  \N
MODELO DE PROCESOS DE LA OTEC USECAP, SEGÚN NORMAS NCH 2728  E ISO 9001/2008. DESARROLLO DE SISTEMA PARA LA TRAZABILIDAD    20/09/2011  3   83  \N  default 83  \N  \N  \N  \N  \N
DETECCIÓN DE LOS ACTOS DEL HABLA DE INDAGACIÓN Y PERSUACIÓN UTILIZANDO EN FRAMEWORK DE EXPERIMENTACIÓN. 11/10/12    1   84  31  default 84  \N  \N  \N  \N  \N
INTEGRACION DEL CONTROL DE UN PROCESO DE NEGOCIOS DE GENERACION DE NOTICIAS CON LA COLABORACION ENTRE PERIODISTAS UTILIZANDO UNA RED SOCIAL CORPORATIVA 1/2013  3   85  \N  default 85  \N  \N  \N  \N  \N
SOFTWARE DE EJERCICIOS DE ESTIMULACIÓN Y EVALUACIÓN COGNITIVA PARA PACIENTES CON PARKINSON  2/2014  3   68  \N  default 68  \N  \N  \N  \N  \N
SISTEMA DE INFORMACIÓN PARA EL APOYO A LA EVALUACIÓN DE LOCALES PARA EMPRESA TACK S.A   7/12/2011   1   87  32  default 87  \N  \N  \N  \N  \N
SOFTWARE DE EJERCICIOS DE ESTIMULACIÓN Y EVALUACIÓN MOTORA PARA PACIENTES CON PARKINSON 2/2014  3   69  \N  default 69  \N  \N  \N  \N  \N
INFERENCIA DE SOMNOLENCIA AL CONDUCIR UN AUTOMÓVIL MEDIANTE LOS MOVIMIENTOS DE LA CABEZA    10/11/12    1   88  33  default 88  \N  \N  \N  \N  \N
DESARROLLO DE API PARA AN�?LISIS DE TÓPICOS EN REDES SOCIALES    2/2014  3   70  \N  default 70  \N  \N  \N  \N  \N
INCORPORACION DE LA DETECCION DEL BOSTEZO EN UN PROTOTIPO RECONOCEDOR DEL ESTADO DE SOMNOLENCIA EN EL DOMINIO DE LA CONDUCCION DE VEHICULOS     1   89  34  default 89  \N  \N  \N  \N  \N
FORO WEB CON ENFOQUE DE DI�?LOGO DISTRIBUIDO PARA MANTEKA    2/2013  3   90  \N  default 90  \N  \N  \N  \N  \N
PROTOTIPO DE UN SISTEMA INFORM�?TICO DE POSTULACIÓN, EVALUAVIÓN Y SELECCIÓN DE AYUDANTE DE DOCENCIA  19/05/2014  3   73  \N  default 73  \N  \N  \N  \N  \N
EVALUACIÓN Y MEJORA DE LA INFRAESTRUCTURA DE UNA RED SOCIAL GENERADORA DE NOTICIAS MEDIANTE MONITORES DE RENDIMIENTO DE SOFTWARE    11/10/2012  1   93  35  default 93  \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DE ETL PARA SERVICIOS DE LEASING FINANCIERO Y OPERATIVO 27/10/2014  3   76  \N  default 76  \N  \N  \N  \N  \N
DESARROLLO DE UNA PLATAFORMA DE SOFTWARE PARA LA RECAUDACIÓN EN L�?NEA MODALIDAD PRESENCIAL ENTRE INSTITUCIONES RECAUDADORAS AUTORIZADAS Y LA TESORER�?A GENERAL DE LA REPUBLICA  22/07/2013  1   94  36  default 94  \N  \N  \N  \N  \N
OBSERVATORIO WEB DE PROYECTOS INNOVADORES EN INFORM�?TICA    2/2013  3   78  \N  default 78  \N  \N  \N  \N  \N
DETECCIÓN DE NIVELES DE ESTRÉS  A TRAVÉS DEL PROCESAMIENTO DE LA VOZ EN TELÉFONOS INTELIGENTES  3/12/2013   1   95  37  default 95  \N  \N  \N  \N  \N
PORTAL WEB CON RED SOCIAL CORPORATIVA PARA LA ORGANIZACIÓN REASE    28/11/2014  3   91  \N  default 91  \N  \N  \N  \N  \N
HERRAMIENTA DE EXPERIMENTACIÓN CONFIGURABLE QUE PERMITA  COMPARAR Y PROBAR ALGORITMOS DE RECOMENDACIÓN CON EL FIN DE GENERAR  DISPONIBIZAR SERVICIOS DE RECOMENDACIÓN PARA DISTINTOS TIPOS DE REDES SOCIALES        1   96  38  default 96  \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACION DE UN MODULO DE EVALUACION DE RENDIMIENTO ESCALABLE Y MANTENIBLE PARA UNA RED SOCIAL GENERADORA DE NOTICIAS 25/10/2013  3   92  \N  default 92  \N  \N  \N  \N  \N
SOFTWARE COMO LABORATORIO PARA PROBAR Y EVALUAR ALGORITMOS DE RECOMENDACIÓN COLABORATIVA    04/10/11    1   97  39  default 97  \N  \N  \N  \N  \N
MODELO PREDICTIVO PARA LA VENTA-CRUZADA DE PRODUCTOS FINANCIEROS UTILIZANDO MINER�?A DE DATOS.   22/12/10    3   247 \N  default 247 \N  \N  \N  \N  \N
DESARROLLO DE HERRAMIENTAS PARA MEDIR COMPETENECIAS EN APRENDIZAJE BASADO EN PROYECTOS  1/2014  3   98  \N  default 98  \N  \N  \N  \N  \N
SOFTWARE DE APOYO EN EL RECONOCIMEINTO DE MENTIRAS EN VICTIMAS DE ABUSO SEXUAL INFANTIL 1/2014  3   99  \N  default 99  \N  \N  \N  \N  \N
APLICACIÓN ANDROID FISCALIZACIÓN CIUDADANA  21/11/2013  3   66  \N  default 66  \N  \N  \N  \N  \N
DESARROLLO DE UN SERVICIO DE INTEGRACIÓN PARA ACTUALIZAR SERVICIOS DE RECOMENDACIÓN DE ETIQUETAS EN UNA RED SOCIAL EMPRESARIAL DE NOTICIAS  11/01/13    3   100 \N  default 100 \N  \N  \N  \N  \N
RECONOCEDOR DE SONRISAS ANSIOSAS EN SITUACIONES EXPERIMENTALES PARA PESQUISAR ENGAÑO    1/2014  3   109 \N  default 109 \N  \N  \N  \N  \N
DESARROLLO DE UN ETIQUETADOR INTERACTIVO DE DOCUMENTOS DENTRO DE UN PROCESO DE NEGOCIOS DE GENERACIÓN DE NOTICIAS.  22/07/2012  1   102 40  default 102 \N  \N  \N  \N  \N
VISUALIZANDO DI�?LOGOS EN COMUNIDADES VIRTUALES DE APRENDIZAJE   22/08/2014  3   115 \N  default 115 \N  \N  \N  \N  \N
SISTEMA DE ADMINISTRACION AGIL PARA MULTIPLES PROYECTOS     1   103 41  default 103 \N  \N  \N  \N  \N
IDENTIFICACIÓN DE PATRONES DE USO PARA USUARIOS DEL TRANSANTIAGO.   07/10/11    3   565 \N  default 565 \N  \N  \N  \N  \N
SELECCIÓN DE IMPLEMENTACIÓN DE ALGORITMO DE RECOMENDACIÓN BASADO EN TGS EN UNA RED SOCIAL GENERADORA DE NOTICIAS    11/01/13    3   104 \N  default 104 \N  \N  \N  \N  \N
DESARROLLO DE APLICACIONES WEB PARA ORGANIZACIONES SIN FINES DE LUCRO POR MEDIO DE LA ARQUITECTURA DE LA INFORMACIÓN    2/2013  3   116 \N  default 116 \N  \N  \N  \N  \N
ALGORITMO DE RECOMENDACIÓN DE TAGS BASADO EN CLUTERS PARA UNA RED SOCIAL DE NOTICIAS    29/05/2014  1   105 42  default 105 \N  \N  \N  \N  \N
PROTOTIPO DE SUITE AFECTIVA PARA EL ANALISIS DE LA SATISFACCIÓN DEL USUARIO.    25/02/10    3   106 \N  default 106 \N  \N  \N  \N  \N
ETIQUETADO EMOCIONAL IMPL�?CITO EN REDES SOCIALES DE NOTICIAS    11/10/2012  3   119 \N  default 119 \N  \N  \N  \N  \N
AUTOMATIZACION DEL PROCESO DE CONTRATACION DE PROFESORES POR HORA PARA LA FACULTAD DE INGENIERIA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE     1   107 43  default 107 \N  \N  \N  \N  \N
EL ENFOQUE DI�?LOGO-ACCIÓN: CASO DE LAS ACTAS DIALÓGICAS EN SCRUM USANDO TABLEROS KANBAN 2/2014  3   121 \N  default 121 \N  \N  \N  \N  \N
“DESCRIPCIÓN ARQUITECTURAL DE UN SISTEMA GENERADOR DE SERVICIOS DE RECOMENDACIÓN PARA OBSERVATORIOS DE LA WEB�?  11/10/2012  1   110 44  default 110 \N  \N  \N  \N  \N
MANUAL PARA SELECCIONAR SUITES BMP CON CRITERIOS DE FUNCIONALIDAD Y USABILIDAD: CASO DE PROCESO DE GENERACIÓN DE NOTICIAS       3   111 \N  default 111 \N  \N  \N  \N  \N
RECURSO DE APRENDIZAJE DE USABILIDAD WEB: UNA APROXIMACIÓN DESDE LA CUARTA HEUR�?STICA DE NIELSEN    2/2014  3   122 \N  default 122 \N  \N  \N  \N  \N
GENERACIÓN DE DATASETS CON ESQUEMA EST�?NDAR PARA ENTRENAR ALGORITMOS DE RECOMENDACIÓN PARA REDES SOCIALES   11/10/2012  1   112 45  default 112 \N  \N  \N  \N  \N
SISTEMA DE RECOMENDACION Y DIFUSION PARA MOVILES        3   127 \N  default 127 \N  \N  \N  \N  \N
SISTEMA DE CONTROL DE CONTRATO CON KANBAN       1   113 46  default 113 \N  \N  \N  \N  \N
DISEÑO Y DESARROLLO DE UN FRAMEWORK DE NOTIFICACIONES V�?A MENSAJER�?A SMS    21/12/12    3   114 \N  default 114 \N  \N  \N  \N  \N
SISTEMA DE REPUTACIÓN PARA LA RED SOCIAL WAZE   2/2014  3   129 \N  default 129 \N  \N  \N  \N  \N
CONSTRUCCION DE UNA INFRAESTRUCTURA EMPRESARIAL PARA UN SISTEMA DE GENERACIÓN DE NOTICIAS CON ETIQUETADO SOCIAL EN UNA RED SOCIAL CORPORATIVA   29/11/12    1   117 47  default 117 \N  \N  \N  \N  \N
UNA ARQUITECTURA DISTRIBUIDA MULTIPLATAFORMA APLICADA A SIMULACIONES MONTE CARLO    1/2014  3   143 \N  default 143 \N  \N  \N  \N  \N
INTERACCIÓN DE SERVICIOS POR EL MEDIO DE UNA INFRAESTRUCTURA SOA, PARA REALIZAR RECOMENDACIONES EN UNA INTERNET DE GENERACIÓN DE NOTICIAS   09/07/12    1   118 48  default 118 \N  \N  \N  \N  \N
HERRAMIENTA DE DISEÑO DE OBJETOS Y VISUALIZACIÓN DE RESULTADOS PARA SIMULACIÓN DE CAMPO MAGNÉTICO   1/2014  3   148 \N  default 148 \N  \N  \N  \N  \N
SELECCIÓN DE PERSONAS BAJO EL ENFOQUE DE LA DIRECCIÓN POR VALORES   11/10/2012  1   120 49  default 120 \N  \N  \N  \N  \N
SISTEMA DE GESTIÓN DE INFORMACIÓN TRANSPARENTE PARA EDIFICIOS DE DEPARTAMENTOS  11/10/2012  3   123 \N  default 123 \N  \N  \N  \N  \N
GENERACIÓN ASISTIDA DE DOCUMENTOS COTIDIANOS PARA PERSONAS CON DISCAPACIDAD INTELECTUAL.    11/10/2012  3   124 \N  default 124 \N  \N  \N  \N  \N
DETECCIÓN DE FALLAS EN LA RED DE SUMINISTRO DE BANDA ANCHA UTILIZANDO EL PROTOCOLO RADIUS   11/10/2012  3   125 \N  default 125 \N  \N  \N  \N  \N
SIMULACIÓN MONTE CARLO PARALELA DEL MODELO HEISENBERG PARA SISTEMAS FERROMAGNÉTICOS 2/2013  3   150 \N  default 150 \N  \N  \N  \N  \N
LOCALIZACION DISTRIBUIDA DE STREAMS PARA EL PROCESAMIENTO DE EVENTOS EN TIEMPO REAL     1   126 50  default 126 \N  \N  \N  \N  \N
MEJORAR LA TOLERANCIA A FALLAS EN UN SISTEMA DE PROCESAMIENTO DE EVENTOS SOBRE DISPOSITIVOS MOVILES     1   128 51  default 128 \N  \N  \N  \N  \N
DISEÑO MOTODOLÓGICO PARA LA ELABORACIÓN Y DESARROLLO DE SECUENCIAS DE ACTIVIDADES INTERACTIVAS PARA LA ENSEÑANZA DEL CAMPO ADICTIVO EN EL PRIMER CICLO B�?SICO   11/10/12    3   130 \N  default 130 \N  \N  \N  \N  \N
SISTEMA PARA GUIAR LA REALIZACIÓN DE ACTIVIDADES ESCOLARES EN CASA  22/02/12    1   131 52  default 131 \N  \N  \N  \N  \N
PROTOTIPO FUNCIONAL DE UNA RED SOCIAL VERTICAL PARA EL SOFTWARE GREI    11/10/12    3   132 \N  default 132 \N  \N  \N  \N  \N
ANALISIS BIOMECANICA DE ANGULOS EN LA SALIDA DE TACOS   05/10/11    3   133 \N  default 133 \N  \N  \N  \N  \N
DESARROLLO DE SISTEMA DE COTIZACIÓN Y DE CONTROL DE EXISTENCIAS PARA LA EMPRESA ALUMAR  11/10/2012  3   134 \N  default 134 \N  \N  \N  \N  \N
SISTEMA DE RECONOCIMIENTO Y DIGITALIZACIÓN DE IM�?GENES DE PARTITURAS ESCRITAS A MANO    07/08/10    3   135 \N  default 135 \N  \N  \N  \N  \N
OBJETIVOS DE APRNEDIZAJE PARA APOYART LA COMPRENSION Y APLICACION DE LA CRIPTOGRAFIA CLASICA    12/7/2010   1   136 53  default 136 \N  \N  \N  \N  \N
SISTEMA DE SEGUIMIENTO A CLIENTES Y DE APOYO A LAS REPARACIONES PARA UN TALLER MEC�?NICO 11/10/2012  3   137 \N  default 137 \N  \N  \N  \N  \N
SISTEMA DE VISUALIZACION DEL POSICIONAMIENTO GEORREFERENCIAL ON-LINE DE EQUIPOS DE EXTRACCION MINERA    20/09/2011  3   138 \N  default 138 \N  \N  \N  \N  \N
ESTRATEGIA DE PARALELIZACION DE SIMULACIONES DE EVENTOS DISCRETOS E INDEPENDIENTES EN GPU   1/2013  1   139 54  default 139 \N  \N  \N  \N  \N
RESOLUCIÓN DEL GENERALIZED MINIMUN SPANNING TREE PROBLEM MEDIANTE ALGORITMOS GENÉTICOS  1/19/2010   1   140 55  default 140 \N  \N  \N  \N  \N
CARACTERIZACIÓN Y OPTIMIZACIÓN DEL USO DE LA MEMORIA CACHE PARA EL ALGORITMO DE RECONSTRUCCIÓN ESTAD�?STICO DE IM�?GENES MÉDICAS EM-ML.   1/2010  1   141 56  default 141 \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DE ALGORITMOS PARALELOS DE RECONTRUCIÓN DE IM�?GENES BASADOS EN EL PARADIGMA "ESPACIO DE DIRECCIONES GLOBALES PARTICIONADO". 05/10/11    1   142 57  default 142 \N  \N  \N  \N  \N
DISEÑO DE UNA API PARA LA IMPLEMENTACIÓN DE ALGORITMOS ESTAD�?STICOS DE RECONSTRUCCIÓN TOMOGR�?FICA DE IM�?GENES   11/10/12    1   144 58  default 144 \N  \N  \N  \N  \N
MODELACIÓN Y SIMULACIÓN DEL ESC�?NER PET SIEMENS BIOGRAPH    11/01/13    1   145 59  default 145 \N  \N  \N  \N  \N
MODELAMIENTO E IMPLEMENTACION ORIENTADA A OBJETOS DE SIMULACIONES MONTE CARLO CONCURRENTES EN BIOLUMINISCENCIA MEDIANTE EL USO DE LA EXTENSION UC++ 11/10/12    1   146 60  default 146 \N  \N  \N  \N  \N
ESTUDIO E IMPLEMENTACIÓN DE ALGORITMOS ESTAD�?STICOS PARALELOS, PARA LA RECONSTRUCCIÓN DE IM�?GENES.  1/2010  1   147 61  default 147 \N  \N  \N  \N  \N
RECONTRUCCIÓN TOMOGR�?FICA PARALELA PARA UN ESC�?NER PET DE ANIMALES PEQUEÑOS 05/12/08    3   149 \N  default 149 \N  \N  \N  \N  \N
PREDICCIÓN DE FENÓMENOS S�?SMICOS EN UN �?REA GEOGR�?FICA DETERMINADA USANDO REDES NEURONALES  2/2012  1   152 62  default 152 \N  \N  \N  \N  \N
APLICACIÓN WEB PARA ADMINISTRACIÓN DOCUMENTAL DE VEH�?CULOS      3   328 \N  default 328 \N  \N  \N  \N  \N
AN�?LISIS COMPARATIVO DE MODELOS NARMA (X) Y NAR (X) USANDO REDES NEURONALES Y SVM SOBRE SISTEMAS CAÓTICOS   11/1/2013   3   153 \N  default 153 \N  \N  \N  \N  \N
SISTEMA DE PREDICCIÓN DEL TR�?FICO DE UN MOTOR DE BÚSQUEDA WEB   02/02/12    1   154 63  default 154 \N  \N  \N  \N  \N
PREDICCION DE SERIES DE TIEMPO USANDO RN Y SVM  20/09/11    1   155 64  default 155 \N  \N  \N  \N  \N
CONSTRUCCIÓN DE MODELOS PREDICTIVOS PARA EL �?NDICE DE DISPONIBILIDAD DE LOS EQUIPOS MINEROS PESADOS USANDO MODELOS DIN�?MICOS CON RNA Y SVM  2/2013  3   156 \N  default 156 \N  \N  \N  \N  \N
PREDICCIÓN DE FENÓMENOS S�?SMICOS EN UN �?REA GEOGR�?FICA DETERMINADA USANDO REDES NEURONALES Y M�?QUINAS DE VECTORES DE SOPORTE    30/03/2012  1   157 65  default 157 \N  \N  \N  \N  \N
SISTEMA PROTOTIPO DE APOYO A LA ALERTA TEMPRANA DE SISMOS MEDIANTE USO DE HERRAMIENTAS DE INTELIGENCIA COMPUTACIONAL    1/2014  3   158 \N  default 158 \N  \N  \N  \N  \N
SISTEMA INFORMATICO PARA LA PREDICCIÓN DE FALLAS EN ANTENAS DEL OBSERVATORIO ALMA, UTILIZANDO HERRAMIENTAS DE INTELIGENCIA COMPUTACIONAL    22/07/2013  1   159 66  default 159 \N  \N  \N  \N  \N
MODELO DIN�?MICO PARA LA GESTIÓN DE FLOTAS DE PALAS EN FAENAS MINERAS    2/2013  3   161 \N  default 161 \N  \N  \N  \N  \N
DISEÑO Y EVALUACIÓN DE UN MODELO CUANTITATIVO DE ESTIMACIÓN DE COMPONENTES MINERALÓGICOS DE ARCILLAS, A TRAVÉS DEL AN�?LISIS DEL ESPECTROGRAMA DEL INFRARROJO CERCANO (NIR), BASADO EN ALGORTIMOS COMPUTACIONALES, PARA EMPRESAS CUPR�?FERAS. 22/11/2013  1   160 67  default 160 \N  \N  \N  \N  \N
ELABORACION DE UN CLASIFICADOR DE SEÑALES SISMOGRAFICAS P Y S MEDIANTE SVM: ESTUDIO DE ALGORITMOS DE FILTRADO Y AUTOSIMILARIDAD     3   163 \N  default 163 \N  \N  \N  \N  \N
ELABORACIÓN DE CLASIFICADORES PARA DETECCIÓN DE SEÑALES DE TIPO S Y P MEDIANTE REDES NAURONALES Y SVM   11/10/2012  1   162 68  default 162 \N  \N  \N  \N  \N
CONSTRUCCIÓN DE UN MODELO PARA DETERMINAR VARIABLES DE DISPONIBILIDAD Y TIEMPO ENTRE FALLAS EN EL �?REA DE LA MINER�?A    2/2014  3   164 \N  default 164 \N  \N  \N  \N  \N
SISTEMA COLABORATIVO WEB PARA EL AN�?LISIS Y EVALUACIÓN DE PLANES ESTRATÉGICOS   17/10/2013  1   165 69  default 165 \N  \N  \N  \N  \N
SISTEMA COLABORATIVO DE APOYO AL APRENDIZAJE DE MATEM�?TICAS EN PRIMER AÑO B�?SICO    30/03/2012  3   166 \N  default 166 \N  \N  \N  \N  \N
DESARROLLO DE UN SISTEMA COLABORATIVO PARA APOYAR EL REFORZAMIENTO DEL IDIOMA INGLÉS EN NIÑOS DE 5Tº AÑO B�?SICO 30/03/2012  3   167 \N  default 167 \N  \N  \N  \N  \N
SISTEMA COLABORATIVO PARA LA PLANIFICACIÓN DE PROYECTOS MEDIANTE CARTAS GANTT.  15/12/10    3   168 \N  default 168 \N  \N  \N  \N  \N
SISTEMA COLABORATIVO PARA COMPLEMENTAR LA ENSEÑANZA DE NIÑOS ENTRE PRIMERO Y SEGUNDO B�?SICO EN LA ASIGNATURA DE INGLÉS  01/11/13    3   173 \N  default 173 \N  \N  \N  \N  \N
SISTEMA COMUNICACIÓN MEDIADA COMPUTADOR PARA APOYAR EL A�?NILIS DE TEMAS EN GRUPOS   04/10/11    1   169 70  default 169 \N  \N  \N  \N  \N
SISTEMA WEB Y MOVIL PARA FOMENTAR EL TURISMO        3   177 \N  default 177 \N  \N  \N  \N  \N
SISTEMA DE APOYO AL  AN�?LISIS DE ASUNTOS PARA LA INGENIER�?A DE REQUERIMIENTOS ORIENTADA A ASPECTOS  13/11/2012  1   170 71  default 170 \N  \N  \N  \N  \N
AUTOMATIZACIÓN DE PROCESOS DE INSPECCIONES DE VEH�?CULOS PARA RSA SEGUROS    1/8/2013    3   181 \N  default 181 \N  \N  \N  \N  \N
SOFTWARE DE APOYO AL SEGUIMIENTO DEL PLAN ESTRATÉGICO DE LA EMPRESA PÚBLICA EMERES  7/11/2013   1   171 72  default 171 \N  \N  \N  \N  \N
HERRAMIENTA DE APOYO A LA DEFINICIÓN DE REQUISITOS, EN LA INGENIER�?A DE SOFTWARE, EXPLOTANDO RECURSOS DE AUDIO  2/2012  3   187 \N  default 187 \N  \N  \N  \N  \N
SISTEMA COLABORATIVO PARA APOYAR LA PREPARACIÓN DE ENTREVISTAS Y SU POSTERIOR AN�?LISIS EN EL PROCESO DE CAPTURA DE REQUISITOS.  10/6/2011   1   172 73  default 172 \N  \N  \N  \N  \N
SISTEMA COOPERATIVO PARA EL DESARROLLO DE INTERFACES GR�?FICAS   1/2014  3   189 \N  default 189 \N  \N  \N  \N  \N
UN MODELO PARA LA ESTIMULACIÓN DEL ESFUERZO EN PROYECTOS DE DESARROLLO DE SOFTWARE. 16/01/12    1   174 74  default 174 \N  \N  \N  \N  \N
SISTEMA DE APLICACIONES PARA EL APOYO EN LA INTERACCIÓN ANFITRIÓN-AUDIENCIA Y LA GENERACIÓN DE CONTENIDO EN PRESENTACIONES CON PROYECTOR    1/2014  3   190 \N  default 190 \N  \N  \N  \N  \N
DESARROLLO DE UNA GU�?A DE ESTRATEGIAS EN APOYO A LA INGENIER�?A DE REQUISITOS    30/03/2012  1   175 75  default 175 \N  \N  \N  \N  \N
IMPLEMENTACIÓN DE ARQUITECTURA BASADA EN SWARM PARA BÚSQUEDA COLABORATIVA MEDIANTE VEH�?CULOS AÉREOS NO TRIPULADOS (UAVS)    1/2014  3   25  \N  default 25  \N  \N  \N  \N  \N
GENERACIÓN DE UN JUEGO COLABORATIVO QUE PERMITA EL DESARROLLO DE HABILIDADES METAFONOLÓGICAS EN NIÑOS DE ENTRE 4 Y 6 AÑOS   30/03/2012  1   176 76  default 176 \N  \N  \N  \N  \N
SISTEMA DE COORDINACIÓN DE ACTIVIDADES ACADÉMICAS, REGISTRO DE NOTAS Y PLANES DE ESTUDIO PARA UNA ESCUELA DE ENSEÑANZA B�?SICA   30/03/2012  1   178 77  default 178 \N  \N  \N  \N  \N
APLICACIÓN PARA MEJORAR EL SEGUIMIENTO DEL RENDIMIENTO Y LA CONDUCTA DE LOS ALUMNOS EN EL AULA DE CLASES    30/03/2012  1   179 78  default 179 \N  \N  \N  \N  \N
SISTEMA DE GESTIÓN DE AYUDAS A PROYECTOS E IDEAS (GAPI) 16/11/2011  3   180 \N  default 180 \N  \N  \N  \N  \N
EVALUACIÓN DE LA EFECTIVIDAD DE UNA PROPUESTA DE TOMA DE REQUIRIMIENTOS BASADA EN CIENCIAS SOCIALES.    7/30/2010   1   182 79  default 182 \N  \N  \N  \N  \N
EVALUACIÓN DE LA EFECTIVIDAD Y REFORMULACIÓN DE UNA PROPUESTA PARA LA ROMA DE REQUERIMIENTOS APLICADO A UN CASO PR�?CTICO    27/11/12    1   183 80  default 183 \N  \N  \N  \N  \N
METODOLOGIA DE HACKING ETICO PARA APLICACIONES WEB EN PRODUCCION    11/10/12    4   184 \N  default 184 \N  \N  \N  \N  \N
DESARROLLO DE APLICACIÓN COLABORATIVA PARA LA EVALUACIÓN DE USABILIDAD DE SOFTWARE STANDALONE BASADO EN FORMULARIO  07/05/13    1   185 81  default 185 \N  \N  \N  \N  \N
SISTEMA DE APOYO AL APRENDIZAJE DE LA LECTURA DE LOS NIÑOS  03/09/08    3   186 \N  default 186 \N  \N  \N  \N  \N
EVALUACIÓN Y RECOMENDACIONES DE MEJORAS DE LA USABILIDAD DE BROWSERS WEB PARA USUARIOS ADULTOS MAYORES CON POCA EXPERIENCIA EN EL USO DE COMPUTADORES.  12/13/2010  3   188 \N  default 188 \N  \N  \N  \N  \N
DESARROLLAR UN AMBIENTE WEB QUE PERMITA REPRESENTAR  INFORMACIÓN ASOCIADA AL CRÉDITO HIPOTECARIO UTULIZANDO ORGANIZADORES GR�?FICOS PARA VIRTUALAB - USACH   24/06/2013  3   191 \N  default 191 \N  \N  \N  \N  \N
DESARROLLO DE COMPONENTES DE SOFWARE EN HTML 5 QUE IMPLEMENTEN ORGANIZADORES GRAFICOS INTERACTIVOS  22/03/11    3   192 \N  default 192 \N  \N  \N  \N  \N
DESARROLLO DE UN AMBIENTE WEB UTILIZANDO ORGANIZADORES GR�?FICOS EN LA REPRESENTACIÓN DE CONTENODOS SOBRE EL INFARTO AGUDO AL MIOCARDIO. 02/08/10    3   193 \N  default 193 \N  \N  \N  \N  \N
DESARROLLO DE COMPONENTES DE SOFWARE QUE IMPLEMENTEN ESTRATEGIAS VISUALES PARA LA PRUDUCCIIÓN DE TEXTO ARGUMENTATIVO TIPO ENSAYO DE NIVEL B�?SICO TRES A SEIS.   12/07/10    3   194 \N  default 194 \N  \N  \N  \N  \N
DESARROLLO DE COMPONENTES DE SOFWARE PARA LA PRODUCCIÓN DE CUENTOS INFANTILES   12/07/10    3   195 \N  default 195 \N  \N  \N  \N  \N
DESARROLLO DE UN AMBIENTE WEB PROTOTIPO QUE PERMITA REPRESENTAR INFORMACIÓN DEL CRÉDITO HIPOTECARIO UTILIZANDO ORGANIZADORES GR�?FICOS.  24/08/10    3   196 \N  default 196 \N  \N  \N  \N  \N
TEMA DE ALBERTOX    24/12/2010  3   590 \N  1/2015  589 \N  \N  \N  \N  \N
DESARROLLO DE COMPONENTES DE SOFTWARE QUE IMPLEMENTEN DIAGRAMAS UTILIZADOS EN LA PLANEACIÓN ESTRATÉGICA.    03/08/10    1   197 82  default 197 \N  \N  \N  \N  \N
DESARROLLO DE COMPONENTES DE SOFWARE PARA LA IMPLEMENTACIÓN DE HERRAMIENTAS QUE FACILITEN LA UTILIZACIÓN DE DIAGRAMAS PARA LA PLANIFICACIÓN DE MARKETING.   21/12/10    3   198 \N  default 198 \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DE COMPONENTES DE SOFTWARE VISUALES QUE FACILITEN EL DESARROLLO DE LA HABILIDAD COGNITIVA DE LA CLASIFICACIÓN.  20/07/10    3   199 \N  default 199 \N  \N  \N  \N  \N
DESARROLLO DE COMPONENTES DE SOFTWARE QUE IMPLEMENTAN ESTRATEGIAS VISUALES PARA APOYAR LA CONCEPTUALIZACIÓN DE FRACCIONES EN ALUMNOS DE CUARTO B�?SICO.  20/08/10    1   200 83  default 200 \N  \N  \N  \N  \N
DESARROLLO DE COMPONENTES DE SOFTWARE PARA FACILITAR LA PRODUCCIÓN DE TEXTO DISCURSIVO DE ALUMNOS ENTRE 5º Y 8º AÑO DE ENSEÑANZA B�?SICA.    08/03/10    3   201 \N  default 201 \N  \N  \N  \N  \N
DESARROLLO DE COMPONENTES VISUALES DE APOYO A COBIT.    15/11/10    3   202 \N  default 202 \N  \N  \N  \N  \N
APLICACIÓN WEB PARA APOYAR LA GESTIÓN DE M�?QUINAS VIRTUALES EN LA EMPRESA ADESSA LTDA.  1/2012  3   227 \N  default 227 \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DEL SISTEMA CAJA VECINA EN APLICACIONES TRANSACCIONALES DEL BANCO ESTADO    12/12/12    1   203 84  default 203 \N  \N  \N  \N  \N
CREACIÓN DE UN SISTEMA GENERADOR DE DIFERENTES SERIES DE INSTRUMENTOS DE EVALUACIÓN PARA LA COORDINACIÓN DE FUNDAMENTOS DE COMPUTACIÓN Y PROGRAMACIÓN DE LA UNIVERSIDAD DE SANTIAGO DE CHILE    1/2014  3   236 \N  default 236 \N  \N  \N  \N  \N
SOLUCIÓN BASADA EN ESB PARA MIGRAR SOTWARE LEGADO CRITICO EN EL SISTEMA PÚBLICO 01/07/13    1   204 85  default 204 \N  \N  \N  \N  \N
DESARROLLO DE APLICACIÓN MÓVIL PARA MONITOREO, DETECCIÓN Y ALERTA AUTOM�?TICA DE CRISIS EPILÉPTICA CONVULSIVA    5/8/2013    3   237 \N  default 237 \N  \N  \N  \N  \N
PROYECTO INTRANET DE GENDARMER�?A DE CHILE   15/01/13    1   205 86  default 205 \N  \N  \N  \N  \N
PREDICCIÓN DE ESTADIA DE PACIENTES HOSPITALIZADOS EN LA UNIDAD DE CUIDADOS INTENSIVOS ADULTOS EN UNA CLINICA PRIVADA DE SANTIAGO    1/2014  3   239 \N  default 239 \N  \N  \N  \N  \N
IMPLEMENTACIÓN DE UN TERCER FACTOR DE AUTENTICACIÓN PARA AUTORIZACIÓN DE TRANSACCIONES EN LA BANCA INTERNET 13/12/12    1   206 87  default 206 \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DEL PORTAL WEB PARA LA MUNICIPALIDAD DE HIJUELAS    13/12/12    3   207 \N  default 207 \N  \N  \N  \N  \N
SISTEMA ONLINE DE ENSEÑANZA DE ESTRATEGIAS ORIENTADO A LOS PADRES PARA APOYAR LAS TAREAS ESCOLARES DE LOS HIJOS 30/03/2012  3   208 \N  default 208 \N  \N  \N  \N  \N
SISTEMA DE GESTIÓN PARA EL HUERTO SANTA MERCEDES    22/05/2012  1   209 88  default 209 \N  \N  \N  \N  \N
CREACIÓN Y APLICACIÓN DE OBJETOS DE APRENDIZAJES PARA EL APOYO A PROGRAMACIÓN COMPUTACIONAL 16/01/2013  1   210 89  default 210 \N  \N  \N  \N  \N
OBTENCIÓN DE LA CARGA ANUAL EQUIVALENTE (CAE) Y CARGA ANUAL EQUIVALENTE VIGENTE (CAEV) UTILIZANDO UN MÉTODO MATEM�?TICO PARA LA EMPRESA PENTAVIDA    19/12/2012  3   211 \N  default 211 \N  \N  \N  \N  \N
DESARROLLO E IMPLEMENTACIÓN DE LA ESTACIÓN DE TRABAJO EVEREST PARA EL BANCO DE CRÉDITO E INVERSIONES    20/3/13 3   212 \N  default 212 \N  \N  \N  \N  \N
CONSTRUCCIÓN Y APLICACIÓN DE OBJETOS DE APRENDIZAJE PARA LA UNIDAD DE AN�?LISIS LÉXICO DE LA ASIGNATURA COMPILADORES 20/03/13    3   213 \N  default 213 \N  \N  \N  \N  \N
LABORATORIO VIRTUAL DE MATEM�?TICAS "LABMAT3EM" PARA ESTABLECIMIENTOS MUNICIPALIZADOS    05/02/12    1   215 90  default 215 \N  \N  \N  \N  \N
LABORATORIO VIRTUAL DE MATEM�?TICAS "LABMAT3EM" PARA ESTABLECIMIENTOS MUNICIPALIZADOS    10/4/2011   1   216 91  default 216 \N  \N  \N  \N  \N
UN SISTEMA DE APOYO AL PROCESO DE TITULACIÓN PARA EL DEPARTAMENTO DE INGENIER�?A INFORM�?TICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE      3   217 \N  default 217 \N  \N  \N  \N  \N
NO HAY INFORMACION      3   218 \N  default 218 \N  \N  \N  \N  \N
SISTEMA DE REMUNERACIONES MODULO DE RELIQUIDACIONES 21/12/2012  1   219 92  default 219 \N  \N  \N  \N  \N
SOLUCION INFORMATICA PARA SOLICITUDES DE INSCRIPCIONES DE ASIGNATURAS   4/8/2010    3   220 \N  default 220 \N  \N  \N  \N  \N
SISTEMA DE APOYO AL CONTROL DE GASTOS Y VIAJES DE VEH�?CULOS DE SERVICIOS DE TRANSPORTE DE LA EMPRESA TRASANDES S.A  24/01/2014  1   221 93  default 221 \N  \N  \N  \N  \N
SISTEMA WEB DE APOYO A LA GESTON DE ADQUISICIONES DE MATERIALES DE CONSTRUCCION DE LA CONSTRUCCION KOPPMANN 7/4/2011    3   222 \N  default 222 \N  \N  \N  \N  \N
SISTEMA WEB DE APOYO A LA ADMINISTRACION DEL GIMNASIO "PUNTO VITAL" 20/09/2011  1   223 94  default 223 \N  \N  \N  \N  \N
SISTEMA DE BUSQUEDA Y VISUALIZACIÓN DE INFORMACIÓN PARA LA BIBLIOTECA CIENT�?FICA DE CONICYT 1/2011  \N  224 \N  default 224 \N  \N  \N  \N  \N
SISTEMA DE GESTIÓN DE COMPRA DE VEH�?CULOS Y EQUIPAMIENTOS PARA EMPRESA SALFA RENT   21/12/12    3   225 \N  default 225 \N  \N  \N  \N  \N
ADMINISTRACIÓN Y TRACKING DE ACTIVOSDE UNA EMPRESA DE SERVICIOS DE ARRIENDO DE CONTENEDORAS 21/03/13    3   226 \N  default 226 \N  \N  \N  \N  \N
UN SISTEMA PARA LA GESTION DE FALLAS EN CENTRALES ELECTRICAS    20/06/2012  3   228 \N  default 228 \N  \N  \N  \N  \N
UNA HERRAMIENTA DE APOYO A LA EVALUACIÓN DEL CONTROL INTERNO EN COOPERATIVAS DE AHORRO Y CREDITO    21/12/12    1   229 95  default 229 \N  \N  \N  \N  \N
AUTOMATIZACIÓN DE LA INVITACIÓN A OFERTAR EN LICITACIONES DE SAP - SRM EN CODELCO   19/04/2013  1   230 96  default 230 \N  \N  \N  \N  \N
IMPLEMENTACIÓN DE PLATAFORMA DE ALTA DISPONIBILIDAD PARA SISTEMA WEB    2/2012  1   231 97  default 231 \N  \N  \N  \N  \N
DESARROLLO UN SISTEMA DE APOYO A LA PLANIFICACION DOCENTE PARA EL DEPARTAMENTO DE INGENIERIA INFORMATICA DE LA FACULTAD DE INGENIERIA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE    01/08/11    1   232 98  default 232 \N  \N  \N  \N  \N
SISTEMA PARA LA ADMINISTRACIÓN DE PROVEEDORES Y PRODUCTOS DE LA MICROEMPRESA FCI LTDA.  30/03/2011  3   233 \N  default 233 \N  \N  \N  \N  \N
SISTEMA PARA LA CERTIFICACIÓN Y SUPERVISIÓN DE VENTA DE MÚSICA DIGITALIZADA 15/01/13    1   234 99  default 234 \N  \N  \N  \N  \N
SISTEM DE FACTURACIÓN ENTRE SOCIEDADES DE ENJOY POR CANJE DE PROMOCIONES Y PRESTACIÓN DE SERVICIOS      3   235 \N  default 235 \N  \N  \N  \N  \N
SISTEMA ADMINISTRADOR DE ACCESOS PARA USUARIOS EN SAP       3   238 \N  default 238 \N  \N  \N  \N  \N
AN�?LISIS Y DESARRLLO DE UN DSS PARA LA SELECCIÓN DE PERSONAS TI 26/05/2010  3   240 \N  default 240 \N  \N  \N  \N  \N
DESARROLLO DE UN SISTEMA DE SERVICIOS DE MAPAS WEB PARA VISUALIZACION Y USO DE PRODUCTOS TOPOGRAFICOS ELABORADOS POR EL SAF     1   241 100 default 241 \N  \N  \N  \N  \N
EVALUACIÓN DEL EFECTO DE FACTORES EXTERNOS EN LA RESOLUCIÓN DE UN PROBLEMA NP-C UTILIZANDO JUEGOS COMPUTACIONALES.  10/07/11    3   242 \N  default 242 \N  \N  \N  \N  \N
SISTEMA WEB PARA POTENCIAR RELACION DE CLIENTES Y PROVEEDORES DE DISTRIBUIDORAS DE ABARROTES, LICORES Y CARNES  7/4/2011    1   243 101 default 243 \N  \N  \N  \N  \N
MODELO PARA LA ESTIMACIÓN DE LA VARIABILIDAD DE LOS COSTOS EN LA FORMULACIÓN DE PROYECTOS DE TECNOLO G�?AS DE LA INFORMACIÓN.    26/07/10    1   244 102 default 244 \N  \N  \N  \N  \N
PROTOTIPO DE SOFTWARE Y ESTUDIO DE MERCADO DE UNA PLATAFORMA SOCIAL DE APRENDIZAJE. 27/09/2010  3   245 \N  default 245 \N  \N  \N  \N  \N
SISTEMA PARA EL SEGUIMIENTO Y CONTROL DE LA OPERATIVIDAD DE SERVIDORES DEL AREA TIC DE CARABINEROS DE CHILE 4/8/2010    1   248 103 default 248 \N  \N  \N  \N  \N
DATAMART PARA UN SISTEMA DE REPORTES DE TIEMPOS EN L�?NEA DE ENLACES DE TELECOMUNICACIONES   12/8/2013   3   254 \N  default 254 \N  \N  \N  \N  \N
SISTEMA DE REALIDAD AUMENTADA PARA LA DIFUSIÓN DE INFORMACIÓN DE LA UNIVERSIDAD DE SANTIAGO DE CHILE    21/03/2013  1   249 104 default 249 \N  \N  \N  \N  \N
PROTOTIPO PARA LA DETECCIÓN DE MALWARE EN EL SISTEMA OPERATIVO  11/01/13    1   251 105 default 251 \N  \N  \N  \N  \N
PROTOTIPO DE APLICACIÓN MÓVIL PARA LA DETECCIÓN DE MALWARE EN DISPOSITIVOS CON SISTEMA OPERATIVO ANDROID    1/2014  3   262 \N  default 262 \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DE SISTEMA DE INFORMACIÓN DE APOYO DE GESTIÓN DE INVENTARIO DE LA EMPRESA COMERCIAL E INDUSTRIAL BERMUDAS S.A.  30/03/2012  1   252 106 default 252 \N  \N  \N  \N  \N
PROPUESTA DE MÉTODO �?GIL DE DESARROLLO DE SOFTWARE FUNCIONAL, USABLE Y SEGURO.  22/01/2015  3   264 \N  default 264 \N  \N  \N  \N  \N
SISTEMA WED PARA SUBASTAR VIDEOS DE CAZANOTICIAS ENTRE CANALES DE TELEVISIÓN    11/10/12    1   253 107 default 253 \N  \N  \N  \N  \N
PROTOTIPO DE SISTEMA DE DETECCIÓN DE MALWARE PARA DISPOSITIVOS ANDROID  2/2013  3   266 \N  default 266 \N  \N  \N  \N  \N
UN PROTOTIPO DE SOFWARE DE APOYO PARA EL TEST DE CAFRA. 21/12/10    1   255 108 default 255 \N  \N  \N  \N  \N
SISTEMA DE FACTURACIÓN ELECTRÓNICA, INVENTARIO Y PRESUPUESTOS WEB PARA TALLER DE TORNER�?A TRIFLEX   30/03/2012  3   256 \N  default 256 \N  \N  \N  \N  \N
DESARROLLO DE UN PLAN DE CONTINGENCIA Y RECUPERACIÓN ANTE DESASTRES PARA EL �?REA INFORM�?TICA DE LA EMPRESA ARCADIS CHILE        3   267 \N  default 267 \N  \N  \N  \N  \N
SISTEMAS PARA LA DETECCIÓN PREVENTIVA DE BAJOS RENDIMIENTOS ACADÉMICOS DE ALUMNOS DEL MÓDULO B�?SICO DE LA FACULTAD DE INGENIER�?A    10/02/12    1   257 109 default 257 \N  \N  \N  \N  \N
SISTEMA WEB DE APOYO A LA GESTIÓN DE UNA ORGANIZACIÓN COMUNITARIA       7   258 \N  default 258 \N  \N  \N  \N  \N
PROPUESTA DE MÉTODO �?GIL DE DESARROLLO DE SOFTWARE FUNCIONAL, USABLE Y SEGURO       \N  259 \N  default 259 \N  \N  \N  \N  \N
PROTOTIPO DE SISTEMA WEB PARA LA GESTIÓN Y CONSOLIDACIÓN DE INFORMACIÓN ADMINISTRATIVA COMO APOYO AL PROCESO DE ACREDITACIÓN DE LOS PROGRAMAS DEL DEPARTAMENTO DE INGENIER�?A INFORM�?TICA    2/2013  3   270 \N  default 270 \N  \N  \N  \N  \N
PROTOTIPO DE SISTEMA DE DETECCIÓN DE INTRUSOS BASADO EN HOST PARA ANDROID   11/01/13    1   260 110 default 260 \N  \N  \N  \N  \N
SISTEMA DE GESTIÓN DE LA SEGURIDAD DE LA INFORMACIÓN PARA EL DIINF  2/2014  3   271 \N  default 271 \N  \N  \N  \N  \N
SISTEMA DE INFORMACIÓN Y AUTOMATIZACIÓN WEB PARA GESTIÓN Y ADMINISTRACIÓN DE SERVICIOS Y RECURSOS DEL COMPLEJO TUR�?STICO ATALAYA LANALHUE.  30/03/2012  1   261 111 default 261 \N  \N  \N  \N  \N
DESARROLLO DE UN ASISTENTE PARA EL SOFTWARE GREI QUE PERMITA GUIAR A LOS DOCENTES EN LA CREACIÓN DE SECUENCIAS INTERACTIVAS DE APRENDIZAJE RESGUARDANDO CRITERIOS DID�?CTICOS-MATEM�?TICOS    24/06/2014  3   272 \N  default 272 \N  \N  \N  \N  \N
SISTEMA DE ACTAS DE SESIONES DE CONSEJO Y AGENDA DEPARTAMENTAL. 19/07/2011  1   263 112 default 263 \N  \N  \N  \N  \N
APLICACIÓN ANDROID UTILIZANDO REALIDAD AUMENTADA PARA LA UBICACIÓN ESPACIAL DE SITIOS DE INTERÉS    2/2013  3   265 \N  default 265 \N  \N  \N  \N  \N
SISTEMA WEB DE APOYO A LA ADMINISTRACIÓN DEL CONTROL DE CAMBIOS EN SERVIDORES DELA PLATAFORMA WINTEL DE HP  29/07/2013  3   283 \N  default 283 \N  \N  \N  \N  \N
GENERACION DE UNA PLATAFORMA VIRTUALIZADA DE SERVICIOS INTEGRADOS PARA EL DEPARTAMENTO DE INGENIERIA EN INFORMATICA     1   268 113 default 268 \N  \N  \N  \N  \N
APLICACION DE APOYO AL DEPARTAMENTO DE RECURSOS HUMANOS PARA "AMEC ING Y CONSTRUCCIÓN LTDA" 2/2012  3   286 \N  default 286 \N  \N  \N  \N  \N
SISTEMA DE GESTIÓN ADMINISTRATIVA DE ALUMNOS PARA EL COLEGIO PUKARAY.   30/03/2012  1   269 114 default 269 \N  \N  \N  \N  \N
CURSE DE CREDITOS HIPOTECARIO EN WORKFLOW   12/12/12    3   273 \N  default 273 \N  \N  \N  \N  \N
DESARROLLO DE UNA HERRAMIENTA DE SOFTWARE BASADA EN UN MARCO DE TRABAJO PARA LA GU�?A DE GESTIÓN DE PROYECTOS TI PARA PUMES  09/04/12    3   274 \N  default 274 \N  \N  \N  \N  \N
METODOLOGIA DE TRABAJO PARA LA GESTION DE PROYECTOS TI EN PYMES     3   275 \N  default 275 \N  \N  \N  \N  \N
MODELACIÓN LINE-PACK DE LA OPERACIÓN DEL GASODUCTO GAS ATACAMA MEDIANTE REDES NEURONALES ARTIFICIALES   29/07/2013  3   288 \N  default 288 \N  \N  \N  \N  \N
TESTING DE CORE BUSINESS PARA UNA EMPRESA DE TELECOMUNICACIONES 21/03/2013  1   276 115 default 276 \N  \N  \N  \N  \N
SISTEMA INTEGRADO DE REMUNERACIONES Y DECLARACIÓN JURADA ANUAL DE RENTAS    1/2014  3   289 \N  default 289 \N  \N  \N  \N  \N
DESARROLLO  E IMPLEMENTACIÓN DE UN DATAMART PARA EL APOYO A LAS VENTAS DEL GRUPO SIG    24/07/2012  1   277 116 default 277 \N  \N  \N  \N  \N
DESARROLLO E IMPLEMENTACIÓN DE DATAMART PARA LA GERENCIA COMERCIAL DE UNA ASOCIACIÓN GENERAL DE FONDOS  6/11/2014   3   291 \N  default 291 \N  \N  \N  \N  \N
SISTEMA WEB DE APOYO AL CONTROL ACADÉMICO PARA LA ACADEMIA POLITÉCNICA AERON�?UTICA DE FUERZA AÉREA DE CHILE 21/08/2012  1   278 117 default 278 \N  \N  \N  \N  \N
SISTEMA DE APOYO A LA GESTIÓN DE FRANQUICIAS MÉDICAS-DENTALES PARA ALUMNOS DE LA UNIVERSIDAD DE CHILE   1/2014  3   293 \N  default 293 \N  \N  \N  \N  \N
SISTEMA VACACIONES PROGRESIVAS Y GENERACIÓN DE ALARMAS PARA LA EMPRESA CYSS 19/07/2012  1   279 118 default 279 \N  \N  \N  \N  \N
CLASIFICACION DEL GRUPO SOCIO ECOOMICO UTILIZANDO VARIABLES DE CONSUME DE PRODUCTOS DE SUPERMERCADO 3/4/2013    3   352 \N  default 352 \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DE UN DATAWAREHOUSE Y DE REPORTES DE APOYO PARA EL �?REA GLOBAL BPO DE UN CLIENTE DE LA EMPRESA METRIC ARTS  1/8/2013    1   280 119 default 280 \N  \N  \N  \N  \N
SISTEMA DE INFORMACION WEB PARA EL CONTROL DE ORDENES DE TRABAJO EN IMPRENTA COLORAMA S.A   11/10/2012  1   281 120 default 281 \N  \N  \N  \N  \N
SISTEMA WEB DE CONTROL Y SOPORTE DE INFORMACIÓN AL SERVICIO TÉCNICO DE LA EMPRESA PROYEXION SERVICIOS S.A.  2/2013  7   282 \N  default 282 \N  \N  \N  \N  \N
SISTEMA WEB PARA PUBLICACION Y AYUDA A LA COMPRA-VENTA DE AUTOS DE EL PORTAL DEL AUTO   4/4/2011    3   284 \N  default 284 \N  \N  \N  \N  \N
SISTEMA WEB DE APOYO A LA LABOR COMERCIAL DE UNA EMPRESA DISTRIBUIDORA DE GAS LICUADO   7/4/2011    3   285 \N  default 285 \N  \N  \N  \N  \N
SISTEMA DE APOYO A LA ATENCIÓN DE CLIENTES  20/03/13    3   287 \N  default 287 \N  \N  \N  \N  \N
DESARROLLO UN SISTEMA WEB DE APOYO A LA ADMINISTRACION DE PROYECTOS DE INGENIERIA EN LA EMPRESA L&C     3   290 \N  default 290 \N  \N  \N  \N  \N
SISTEMA MONITOR DE DISPOSITIVOS ELECTRÓNICOS EN UNA PLANTA TRASMISORA DE FRECUENCIA MODULADA    30/03/2013  1   292 121 default 292 \N  \N  \N  \N  \N
SISTEMA WEB DE APOYO A LA GESTION DE MONITOREO Y SEGUIMIENTO DEL TRABAJO EN EL AUTO 7/4/2011    3   294 \N  default 294 \N  \N  \N  \N  \N
NO HAY INFORMACION      3   295 \N  default 295 \N  \N  \N  \N  \N
SISTEMA DE APOYO A LA GESTION DE BODEGA PARA LA EMPRESA MC2 15/12/11    3   296 \N  default 296 \N  \N  \N  \N  \N
SISTEMA WEB DE EVALUACIÓN DE DESEMPEÑO PARA EL PERSONAL DE OFICIALES DE LA FUERZA AÉREA DE CHILE        1   297 122 default 297 \N  \N  \N  \N  \N
UN AG COOPERATIVO PARA PROBLEMAS DE CORTE Y EMPAQUE 25/06/12    3   548 \N  default 548 \N  \N  \N  \N  \N
SISTEMA WEB DE APOYO A LA GESTION DEL AREA DE SOPORTE COMPUTACIONAL PARA LA EMPRESA MARCARIA.COM    7/4/2011    1   298 123 default 298 \N  \N  \N  \N  \N
DESARROLLAR UN SISTEMA DE APOYO A LA GESTION DE FICHAS,HORAS Y MEDICAMENTOS PARA LA POSTA RURAL DE PENCAHUE BAJO    15/12/11    3   301 \N  default 301 \N  \N  \N  \N  \N
DESARROLLO DEL SISTEMA SAP SRM PARA LA EMPRESA MULTINACIONAL ALFA   19/3/13 4   303 \N  default 303 \N  \N  \N  \N  \N
SISTEMA WEB DE GENERACION Y SEGUIMIENTO DE REQUERIMIENTOS DE SOPORTE PARA SISTEMAS LTDA.    7/4/2011    3   305 \N  default 305 \N  \N  \N  \N  \N
SISTEMA DE INFORMACION DE APOYO A LOS PROCESOS DE VENTA E INVENTARIO PARA LA EMPRESA RODAMIENTO "VILLELA"   9/3/2010    3   306 \N  default 306 \N  \N  \N  \N  \N
AUTOMATIZACIÓN DEL PROYECTO DE FORMALIZACIÓN DE SUBSIDIOS DE CORFO  15/04/2013  3   309 \N  default 309 \N  \N  \N  \N  \N
RESOLUCIÓN DE KO THREATS UTILIZANDO HEUR�?STICAS EN MONTE CARLO GO.  12/6/2010   1   311 124 default 311 \N  \N  \N  \N  \N
USO DE GPU EN ALGORITMOS DE BUSQUEDA LOCAL PARA EL PROBLEMA DE LA ASIGNACION CUADRATICA 05/10/11    3   312 \N  default 312 \N  \N  \N  \N  \N
ACERELERACION DE DESEMPEÑO DEL ALGORITMO DE BUSQUEDA LOCAL PARA FLOW SHOP USANDO PROCESADORES GRAFICOS  10/7/2011   3   313 \N  default 313 \N  \N  \N  \N  \N
CONSTRUCCIÓN DE UN FRAMEWORK PARA PIPELINE DE APLICACIONES DE BIOINFORM�?TICA    2/2013  3   316 \N  default 316 \N  \N  \N  \N  \N
DISEÑO Y DESARROLLO DE UN ALGORITMOS DE BÚSQUEDA DE ARN OBJETIVOS PARA UN MICROARN  12/7/2012   3   317 \N  default 317 \N  \N  \N  \N  \N
SISTEMA DE EVALUCIÓN FORMATIVA EN LINEA PARA LA SOCIEDAD CHILENA DE RADIOLOGIA  04/08/10    3   318 \N  default 318 \N  \N  \N  \N  \N
SISTEMA WEB DE DENUNCIA CIUDADANA PARA LA ILUSTRE MUNICIPALIDAD DE SAN JOAQUIN  20/09/2011  1   409 173 default 409 \N  \N  \N  \N  \N
ALGORITMO PARA LA VISUALIZACIÓN DE DATOS EXPERIMENTOS DE MIROARRAYS BASADOS EN ANOTACIONES BIOLÓGICAS Y EXPRESIÓN GENÉTICA  11/10/1012  1   319 125 default 319 \N  \N  \N  \N  \N
GRAFO DE CONSENSO DE FUENTES DE ANOTACIONES BIOLÓGICAS DE GENES HUMANOS     2/2013  3   320 \N  default 320 \N  \N  \N  \N  \N
DESARROLLO DE UNA APLICACIÓN WEB PARA EL APOYO AL AN�?LISIS DE DATOS RT-PCR. 10/4/2011   1   321 126 default 321 \N  \N  \N  \N  \N
INCORPORACIÓN DE ANOTACIONES GENÉTICAS EN EL ALGORITMO DE AGRUPAMIENTO MST -KNN 11/10/1012  1   322 127 default 322 \N  \N  \N  \N  \N
REINGENIERIA PORTAL DE PAGOS DEL ESTADO PARA TESORER�?A GENERAL DELA REPÚBLICA   23/07/2013  1   323 128 default 323 \N  \N  \N  \N  \N
AN�?LISIS DE TÉCNICAS PARA FILTRADO DE NOTICIAS DE LA WEB    1/2012  1   324 129 default 324 \N  \N  \N  \N  \N
CLASIFICACIÓN AUTOM�?TICA DE TEXTOS PERIOD�?STICOS ENRIQUECIDA CON FUENTES EXTERNAS   20/03/2012  3   325 \N  default 325 \N  \N  \N  \N  \N
SISTEMA DE SEGUIMIENTO DE JUICIOS PARA GESTIÓN DE COBRANZA      3   326 \N  default 326 \N  \N  \N  \N  \N
EVALUACIÓN DE ALGORITMOS PARA LA IDENTIFICACIÓN DE ESTRUCTURA DE SITIOS WEB CON APLICACIONES EN RECOLECTORES FOCALIZADOS DE LA WEB. 03/10/11    3   327 \N  default 327 \N  \N  \N  \N  \N
MÓDULOS DEL SISTEMA INFORM�?TICO PARA APOYAR LA GESTIÓN EN UNA EMPRESA DE RETAIL     1   329 130 default 329 \N  \N  \N  \N  \N
DESARROLLO DE UNA API PARA LA ASOCIACIÓN DE PERSONAS Y EL CONTENIDO DE NOTICIAS EN ESPACIOS.        1   330 131 default 330 \N  \N  \N  \N  \N
GENERACIÓN DE REPORTES CON EL CONTEXTO DE NOTICIAS EN TWITTER.  05/10/11    1   331 132 default 331 \N  \N  \N  \N  \N
SISTEMA DE COORDINACION Y GESTION DE RESERVA HORARIA PARA EVENTOS Y ACTIVIDADES DEL COLEGIO ALEMAN DE SANTIAGO  20/09/2011  3   4   \N  default 4   \N  \N  \N  \N  \N
AN�?LISIS DE SENTIMIENTO EN EL SISTEMA DE RED SOCIAL TWITTER 03/10/11    1   332 133 default 332 \N  \N  \N  \N  \N
DESARROLLAR UN JUEGO COMO HERRAMIENTA DE APRENDIZAJE PARA EL CURSO DE ECONOM�?A DE LA FACULTAD TECNOLÓGICA       208/11/2014 3   300 \N  default 300 \N  \N  \N  \N  \N
DISEÑOS DE UN CLASIFICADOR DE PATENTES INDUSTRIALES 11/10/12    1   333 134 default 333 \N  \N  \N  \N  \N
SISTEMA DE APOYO AL PRCOESO DE EVALUACIÓN ECONÓMICA SOCIAL DE PROYECTOS DE VIALIDAD URBANA  2/2012  3   302 \N  default 302 \N  \N  \N  \N  \N
API PARA LA VISUALIZACIÓN DE RELACIONES EXISTENTES ENTRE CONTACTOS PERSONALES A TRAVÉS DE REDES SOCIALES.   07/10/11    1   334 135 default 334 \N  \N  \N  \N  \N
SISTEMA WEB DE APOYO A LA GESTIÓN DE UN CENTRO DE DISTRIBUCIÓN  1/2014  3   304 \N  default 304 \N  \N  \N  \N  \N
DESARROLLO DE UN SISTEMA DE GESTION HORARIA PARA RECURSOS DE UNA EMPRESA DE DEPILACION LASER    11/10/12    1   335 136 default 335 \N  \N  \N  \N  \N
DISEÑO DE UN ALGORITMO DE PLANIFICACIÓN PARA APLICACIONES PARALELAS SOBRE RECURSOS HETEROGÉNEOS EN CLOUD COMPUTING  3/7/2012    3   336 \N  default 336 \N  \N  \N  \N  \N
PLATAFORMA DE EVALUACIÓN DE ALGORITMOS DE SUBASTA PARA BUSQUEDAS PATROCINADAS   11/10/12    3   337 \N  default 337 \N  \N  \N  \N  \N
AN�?LISIS DE LA SATISFACCIÓN DE CLIENTES MEDIANTE EL AN�?LISIS DE CORREOS ELECTRÓNICOS    11/01/13    3   338 \N  default 338 \N  \N  \N  \N  \N
INTEGRACIÓN ERP MICROSOFT DYNAMICS AX CON SISTEMA WEB EXTERNO PARA EL INGRESO DE PEDIDOS DE VENTA       3   339 \N  default 339 \N  \N  \N  \N  \N
REDISEÑO DEL PROCESO DE NEGOCIO ASOCIADO AL SERVICIO DE ARRIENDO DE GRÚAS HORQUILLA, PARA LA EMPRESA GRÚAS M&L LTDA.    03/04/15    3   307 \N  default 307 \N  \N  \N  \N  \N
DETERMINACIÓN DE LA INFLUENCIA DE EST�?MULOS SONOROSY SU EMOCIÓN EN LA AUTORREGULACIÓN.  11/10/12    1   341 137 default 341 \N  \N  \N  \N  \N
DESARROLLAR UN JUEGO COMO HERRAMIENTA DE APRENDIZAJE PARA EL CURSO DE ECONOM�?A DE LA FACULTAD TECNOLÓGICA       5/11/2014   3   308 \N  default 308 \N  \N  \N  \N  \N
DETERMINACIÓN DE LA INFLUENCIA DE EST�?MULOS MUSICALES EN LA AUTORREGULACIÓN DEL FLUJO SANGU�?NEO CEREBRAL.   18/01/2012  1   342 138 default 342 \N  \N  \N  \N  \N
IMPLEMENTACIÓN DEL PROCESO DE FORMALIZACIÓN DE SUBSIDIOS DE CORFO EN ADOBE LIVE CYCL    25/11/2014  3   310 \N  default 310 \N  \N  \N  \N  \N
PRE-PROCESAMIENTO DE SEÑALES DE HEMODIN�?MICA CEREBRAL PARA ESTUDIOS DE AUTTOREGULACION DEL FLUJO SANGUINEO CEREBRAL 7/4/2011    1   343 139 default 343 \N  \N  \N  \N  \N
ALGORITMO DE AGRUPAMIENTO PARA DATOS DE EXPRESIÓN GÉNICA DE RNA-SEQ CON LA INCORPORACIÓN DE ANOTACIONES BIOLÓGICAS  1/2014  3   314 \N  default 314 \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA DE CONTRASTE DE HIPÓTESIS BASADO EN BOOTSTRAP 30/03/2012  1   344 140 default 344 \N  \N  \N  \N  \N
AN�?LISIS DE LA COMPLEJIDAD DE LAS SEÑALES DEL SISTEMA DE HEMODIN�?MICA CEREBRAL Y LA RELACIÓN DE ESTA CARACTER�?STICA CON SU MODELAMIENTO     3   345 \N  default 345 \N  \N  \N  \N  \N
ALGORITMO MEMÉTICO BASADO EN CONOCIMIENTO BIOLÓGICO PARA EL PROBLEMA DE PREDICCIÓN DE LA ESTRUCTURA TRIDIMENSIONAL DE LA PROTE�?NA   1/2014  3   315 \N  default 315 \N  \N  \N  \N  \N
ANALISIS COMPARATIVO ENTRE METODOS PARA EL CALCULO DE LA AUTORREGULACION CEREBRAL QUE USAN CAMBIOS BRUSCOS DE PRESION Y VARIACIONES ESPONTANEAS UTILIZANDO SVM      1   346 141 default 346 \N  \N  \N  \N  \N
ACTUALIZACIÓN CONCURRENTE DE �?NDICES INVERTIDOS EN MOTORES DE BÚSQUEDA VERTICALES   2/2014  3   340 \N  default 340 \N  \N  \N  \N  \N
COMPARACIÓN DE LOS MÉTODOS DE C�?LCULO DE AUTOREGULACIÓN USANDO MODELOS LINEALES CON LA MANIOBRA DE VALSALVA Y VARIACIONES ESPONTANEAS DE PRESIÓN    1/2014  3   347 \N  default 347 \N  \N  \N  \N  \N
MODIFICACION DE LOS METODOS DE DETECCION DE LATIDOS CARDIACOS PARA SER UTILIZADOS EN LA ESTIMACION DE SEÑALES DE PSAM Y FSCM    30/05/11    1   348 142 default 348 \N  \N  \N  \N  \N
COMPARACIÓN DE LOS MÉTODOS DE C�?LCULO DE AUTORREGULACIÓN CON LA MANIOBRA "SIT-TO-STAND" Y VARIACIONES ESPONT�?NEAS DE PRESIÓN    2/2013  3   354 \N  default 354 \N  \N  \N  \N  \N
SOLUCIÓN DE INTELIGENCIA DE NEGOCIOS Y MODELO PREDICTIVO COMO APOYO A LA GESTIÓN DE INDICADORES CL�?NICOS EN CL�?NICA ALEMANA DE SANTIAGO     1   349 143 default 349 \N  \N  \N  \N  \N
SELECCIÓN DE CARACTER�?STICAS PARA LA ESTIMACIÓN DE NIVELES DE PRESIÓN INTRACRANEAL EN FORMA NO INVASIVA.    20/09/11    3   350 \N  default 350 \N  \N  \N  \N  \N
DISEÑO DE UN CLASIFICADOR PARA LA DETECCIÓN DEL MOBILOMA EN GENOMAS DE BACTERIAS    04/06/14    3   357 \N  default 357 \N  \N  \N  \N  \N
CREACIÓN DE MODELOS DE CLASIFICACIÓN PARA CULTIVOS NEURONALES CON CLASES DESBALANCEADAS Y BÚSQUEDA DE VARIABLES REPRESENTATIVAS 3/6/2014    1   351 144 default 351 \N  \N  \N  \N  \N
ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS POLARES     1/2014  3   368 \N  default 368 \N  \N  \N  \N  \N
MEJORAMIENTO DEL �?NDICE DE AUTORREGULACIÓN DE FLUJO SANGU�?NEO CEREBRAL (ARI) MEDIANTE LA MEDICIÓN DE FASE ENTRE PRESIÓN Y FLUJO.    13/09/11    1   353 145 default 353 \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DE UNA HERRAMIENTA PARA LA CATEGOGORIZACIÓN DE PACIENTES EN SERVICIOS DE URGENCIA       3   355 \N  default 355 \N  \N  \N  \N  \N
IDENTIFICACIÓN DE EVENTOS DE TRANSFERENCIA HORIZONTAL DE GENES EN BACTERIAS MEDIANTE DISEÑO DE CLASIFICADORES DE DATOS  03/11/13    3   356 \N  default 356 \N  \N  \N  \N  \N
ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS OCTOPUS 1/2014  3   370 \N  default 370 \N  \N  \N  \N  \N
EVALUACIÓN COMPARATIVA DE MÑETODOS DE MINER�?A DE DATOS PARA LA CLASIFICACIÓN DE SEÑALES S�?SMICAS DEL VOLC�?N LLAIMA  03/11/13    1   358 146 default 358 \N  \N  \N  \N  \N
OPTIMIZACIÓN Y MEJORAS A PROCESOS EJECUTADOS PARA LA OBTENCIÓN DE LOS ESTADOS DE RESULTADOS COMERCIALES DE LAN CHILE        3   359 \N  default 359 \N  \N  \N  \N  \N
CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFO GOOD    1/2014  3   371 \N  default 371 \N  \N  \N  \N  \N
USO DE TÉCNICAS DE CAJA GRIS Y FUNCIÓN DE TRANSFERENCIA PARA MODELAR LA AUTORREGULACIÓN CEREBRAL    30/03/2012  1   360 147 default 360 \N  \N  \N  \N  \N
SISTEMA PARA CONTROL DE ENV�?O Y RECEPCIÓN DE MENSAJER�?A DE TEXTO EN EQUIPOS DE TELEFON�?A MÓVIL  13/12/12    3   361 \N  default 361 \N  \N  \N  \N  \N
ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS LOBSTER     3   388 \N  default 388 \N  \N  \N  \N  \N
COMPARACIÓN DE �?NDICES DE AUTORREGULACIÓN DE FLUJO SANGU�?NEO CEREBRAL BASADOS SOLO EN SEÑAL DE FLUJO    03/11/13    1   362 148 default 362 \N  \N  \N  \N  \N
COMPARACION ENTRE MODELOS NARX DE SVM Y TLRNN PARA OBTENER INDICE AUTORREGULATORIO CEREBRAL EN VARIACIONES ESPONTANEAS      3   363 \N  default 363 \N  \N  \N  \N  \N
EVALUACIÓN DE MÉTODOS QUE MEJORAN LA IDENTIFICACIÓN DE BIOMARCADORES A PARTIR DE DATOS DE EXPRESIÓN GÉNETICA EN EL SALMÓN ATL�?NTICO (SALMO SALAR)   03/11/13    3   364 \N  default 364 \N  \N  \N  \N  \N
EVALUACIÓN DE OBJETOS DE APRENDIZAJE MOODLE, MEDIANTE LA SUPERVISIÓN DE USO DE LOS ESTUDIANTES  2/2014  3   393 \N  default 393 \N  \N  \N  \N  \N
EVALUACIÓN DE LOS EFECTOS DE LA POSICIÓN CORPORAL EN EL C�?LCULO DE LOS �?NDICES DE AUTORREGULACIÓN DEL FLUJO SANGU�?NEO CEREBRAL USANDO MODELOS LINEALES  03/11/13    1   365 149 default 365 \N  \N  \N  \N  \N
APLICACIÓN DEL CRÉDITO TRIBUTARIO PARA LA INSTALACIÓN DE UN SISTEMA SOLAR TÉRMICO Y SU IMPACTO EN EL SISTEMA INFORM�?TICO TRIBUTARIO CHILENO ADMINISTRADO POR EL S.I.I.  18/12/12    1   366 150 default 366 \N  \N  \N  \N  \N
CONSTRUCCIÓN DE MODELOS PARA EVALUAR LA AUTORREGULACIÓN DE PACIENTES CON TEC USANDO MODELOS NARMAX Y FIR CON SVM.   11/10/12    1   367 151 default 367 \N  \N  \N  \N  \N
IMPLEMENTACIÓN DE ALGORITMOS DE LAYOUT DE GRAFOS Y AN�?LISIS DE SU COMPORTAMIENTO AL GENERAR SOLUCIONES IN�?CIALES PARA EL ALGORITMO QAPGRID. 6/12/2010   1   369 152 default 369 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA POYAR LA COMPRENSIÓN Y APLICACIÓN DE CONCEPTOS B�?SICOS DE INTRODUCCIÓN A LAS BASES DE DATOS 11/01/13    1   372 153 default 372 \N  \N  \N  \N  \N
SISTEMA DE GESTIÓN ESCOLAR PARA LA EMPRESA DE CLASES PARTICULARES "PLAY HOUSE TEACHER"  2/2011  1   373 154 default 373 \N  \N  \N  \N  \N
GENERACION VIRTUAL DE NANOTUBOS DE CARBONO DE UNA PARED FUNCIONALIZADOS CON DISTINTAS MOLECULAS 03/05/13    1   374 155 default 374 \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA DE PREDICCIÓN PARA LA CANTIDAD DE ALUMNOS EN LAS ASIGNATURAS DEL DEPARTAMENTO DE INGENIERIA INFORMATICA   11/10/12    3   375 \N  default 375 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE ALGORITMOS DE PLANIFICACIÓN DE PROCESOS EN CPU EN EL CURSO DE SISTEMAS OPERATIVOS  11/01/13    1   376 156 default 376 \N  \N  \N  \N  \N
SISTEMA PARA LA CREACION,GESTION Y DIFUSION DE BANDAS MUSICALES 02/11/11    1   377 157 default 377 \N  \N  \N  \N  \N
REINGENIER�?A DE PROCESOS DE DOCENCIA  DEL DEPARTAMENTE DE INGENIER�?A INFORM�?TICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE 11/10//2012 1   378 158 default 378 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE CONTABILIDAD PARA ALUMNOS DEL INSTITUTO PROFESIONAL LA ARAUCANA       1   379 159 default 379 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL MODELAMIENTO MATEM�?TICO DE PROBLEMAS DE OPTIMIZACIÓN  11/01/13    1   380 160 default 380 \N  \N  \N  \N  \N
ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS "K-TREE"        \N  381 \N  default 381 \N  \N  \N  \N  \N
ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS "K-TREE"    05/10/11    3   382 \N  default 382 \N  \N  \N  \N  \N
APLICACIÓN DE APOYO A LA ENSEÑANZA - APRENDIZAJE PARA EL MANEJO DE LENJUAGE DE MATRICES EN OCTAVE EN EL CURSO DE FUNDAMENTOS DE PROGRAMACIÓN    11/01/13    1   383 161 default 383 \N  \N  \N  \N  \N
DETECCIÓN PREVENTIVA DE ALUMNOS CON BAJO RENDIMIENTO ACADÉMICO EN LA FACULTAD DE INGENIER�?A DE LA UNIVERSIDAD DE SANTIAGO DE CHILE   1º 2012    1   384 162 default 384 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR LA APREHESIÓN DE LOS CONCEPTOS DE PROCESOS Y HEBRAS  11/01/13    1   385 163 default 385 \N  \N  \N  \N  \N
DESARROLLO DE UN MÓDULO DE EXTENSIÓN PARA DETERMINAR RUTAS DE TRANSPORTES DE CARGA POR EL MEDIO VIAL, FERROVIARIO O MAR�?TIMO EN EL ENTORNO ARCMAP   23/04/12    1   386 164 default 386 \N  \N  \N  \N  \N
APLICACIÓN WEB DE APOYO PARA LA GESTIÓN DE PROCESO DE POSTULACIONES  ACADÉMICAS EN EL DEPARTAMENTO DE INGENIER�?A INFORM�?TICA DE LA UNIIVERSIDAD DE SANTIAGO DE CHILE    11/10/12    1   387 165 default 387 \N  \N  \N  \N  \N
OBJETIVOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN DE CONCURRENCIA COMPUTACIONAL   11/01/13    1   389 166 default 389 \N  \N  \N  \N  \N
ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS BISPLIT.    05/10/11    1   390 167 default 390 \N  \N  \N  \N  \N
OBJETO DE APRENDIZAJE PARA LA EJERCITACIÓN DE LOS CONCEPTOS DEL MÉTODO SIMPLEX  11/01/13    3   391 \N  default 391 \N  \N  \N  \N  \N
DIAGNOSTICO DE INGRESO DE ALUMNOS A LA CARRERA DE INGENIER�?A DE EJECUCIÓN EN COMPUTACIÓN E INFORM�?TICA MODALIDAD VESPERTINA     3   392 \N  default 392 \N  \N  \N  \N  \N
INTELIGENCIA DE NEGOCIOS APLICADA A CAJA DE COMPENSACIÓN    19/07/2012  3   399 \N  default 399 \N  \N  \N  \N  \N
SISTEMA DE APOYO A LA ADMINISTRACIÓN DE INFORMACIÓN PARA LOS COMITÉS DE AGUA POTABLE RURALES    04/07/12    3   400 \N  default 400 \N  \N  \N  \N  \N
DESARROLLO DE UN SISTEMA PERSONALIZABLE PARA QUE PROFESORES TRABAJEN LA INCLUSIÓN DE ALUMNOS CON NECESIDADES ESPECIALES TRANSITORIAS    1/2014  3   50  \N  default 50  \N  \N  \N  \N  \N
DESARROLLO DE UNA APLICACIÓN DE MONITOREO SPLUNK PARA AGUILIZAR EL PROCESO ITIL DE GESTIÓN DE INCIDENTES EN BANCO ESTADO    20/01/2014  1   401 168 default 401 \N  \N  \N  \N  \N
SISTEMA DE APOYO A LA FORMULACIÓN DE PROYECTOS CONCURSABLES DEL DEPARTAMENTO DE INGENIER�?A INFORM�?TICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE   2/2014  3   395 \N  default 395 \N  \N  \N  \N  \N
SISTEMA DE GESTIÓN Y CONTROL PARA EMPRESA "PG&I"    7/5/2012    1   402 169 default 402 \N  \N  \N  \N  \N
ALGORITMOS PARALELOS PARA LA GENERACIÓN DE LOS CONJUNTOS INDEPENDIENTES MAXIMALES DE UN GRAFO CAMINO SIN CUERDAS Y DE UN GRAFO CATERPILLAR  2/2014  3   396 \N  default 396 \N  \N  \N  \N  \N
BUSINESS INTELLIGENCE PARA EL �?REA DE CONTROL DE GESTIÓN EN LA SUPERINTENDENCIA DE ELECTRICIDAD Y COMBUSTIBLES  21/12/12    1   403 170 default 403 \N  \N  \N  \N  \N
MODELADO DE LAS CARACTER�?STICAS DE LOS POSTULANTES A LA CARRERA DE INGENIER�?A DE EJECUCIÓN EN COMPUTACIÓN E INFORM�?TICA MODALIDAD VESPERTINA    2/2014  3   397 \N  default 397 \N  \N  \N  \N  \N
MONITOREO Y MANEJO DE REDES INAL�?MBRICAS EN MINAS A RAJO ABIERTO    13/12/12    1   404 171 default 404 \N  \N  \N  \N  \N
CUBO OLAP PARA AN�?LISIS DE VENTAS   REFORMULAR  3   405 \N  default 405 \N  \N  \N  \N  \N
ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN FRAFOS OCTOPUS 2/2014  3   398 \N  default 398 \N  \N  \N  \N  \N
ESTUDIO DE FACTIBILIDAD PARA LA IMPLEMENTACION DE APLICACIONES DISTRIBUIDAS SOBRE SET-TOP-BOXES EN CHILE        1   406 172 default 406 \N  \N  \N  \N  \N
IMPLEMENTACION DE PROCESOS DE GESTION DE PROYECTOS FOSIS UTILIZANDO HERRAMIENTAS BPMS   4/8/2010    3   408 \N  default 408 \N  \N  \N  \N  \N
BIBLIOTECA PARA EL DESPEGUE �?GIL DE APLICACIONES DE STREAM EN ESCENARIOS DE DESASTRES   1/2014  3   407 \N  default 407 \N  \N  \N  \N  \N
SISTEMA DE RECOLECCIÓN DE LECHE FRESCA PARA LAS PLANTAS NESTLÉ CHILE S.A.   15/05/2013  3   410 \N  default 410 \N  \N  \N  \N  \N
PLAN DE CONTINUIDAD DE NEGOCIOS PARA EL MACRO PROCESO GESTIÓN FINANCIERA Y OTROS ACTIVOS DEL TESORO PÚBLICO 8/1/2014    3   421 \N  default 421 \N  \N  \N  \N  \N
PROTOTIPO DE SISTEMA DE GESTIÓN DOCUMENTAL PARA LA DIRECCIÓN DE ASISTENCIA JUR�?DICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE  APROBADO    1   411 174 default 411 \N  \N  \N  \N  \N
REDISEÑO DE PROCESOS: IMPLEMENTACION DE SISTEA RIS/PACS EN UNIDAD DE IMAGENOLOGIA, HOSPITAL SAN JUAN DE DIOS    4/8/2010    3   412 \N  default 412 \N  \N  \N  \N  \N
SISTEMA DE INFORMACIÓN WEB, PARA LA "CL�?NICA DENTAL - ALEXANDRA ALVAREZ"    2/2011  3   427 \N  default 427 \N  \N  \N  \N  \N
SISTEMA DE CONTROL Y MONITOREO A LAS TRANSACCIONES DE UN CONJUNTO DE BASES DE DATOS SQL SERVER  20/09/2011  1   413 175 default 413 \N  \N  \N  \N  \N
DATAMART PARA EL �?REA DE APROVISIONAMIENTO DE ENDESA COLOMBIA       3   414 \N  default 414 \N  \N  \N  \N  \N
PLATAFORMA PARA LA DEFINICIÓN Y APOYO A LA EVALUACIÓN DE GESTOS T�?CTILES EN LA INTERACCIÓN CON OBJETOS DIGITALES DE INFORMACIÓN 1/2014  3   431 \N  default 431 \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DE UN CUADRO DE MANDO INTEGRAL  4/8/2010    1   415 176 default 415 \N  \N  \N  \N  \N
IDENTIFICACIÓN AUTOMATIZADA DE ETAPAS DEL PROCESO DE BÚSQUEDA DE INFORMACIÓN DEL USUARIO    1/2014  3   432 \N  default 432 \N  \N  \N  \N  \N
SISTEMA DE CONTROL DE PROCESOS Y GESTION PARA EL AREA DE SOPORTE INFORMATICO PARA BROWSE INGENIERIA 4/8/2010    1   416 177 default 416 \N  \N  \N  \N  \N
PROCESO DE DESARROLLO DE PROYECTOS DE SEGURIDAD PARA SAP ERP EN ROLES Y PERFILES    4/8/2010    3   417 \N  default 417 \N  \N  \N  \N  \N
SISATEMA DE INVENTARIO WEB PARA APOYAR LA GESTIÓN DE LA EMPRESA VTV LTDA.   26-07-2012  3   418 \N  default 418 \N  \N  \N  \N  \N
SISTEMA DE ASIGNACIÓN DE LABORATORIOS DE DOCENCIA   4/8/2010    3   419 \N  default 419 \N  \N  \N  \N  \N
DISEÑO Y DESARROLLO DE UNA APLICACIÓN MODULAR PARA APOYAR LA INVESTIGACIÓN OBSERVACIONAL CON DATOS MULTIMODALES     1/2014  3   433 \N  default 433 \N  \N  \N  \N  \N
SISTEMA DE LICENCIAS MEDICAS EN UNA CAJA DE COMPENSACION    4/8/2010    1   420 178 default 420 \N  \N  \N  \N  \N
DETECCIÓN IMPL�?CITA DE RELEVANCIA DE P�?GINAS WEB UTILIZANDO REGISTROS DE ACTIVIDAD DEL USUARIO EN LA BÚSQUEDA DE INFORMACIÓN    1/2014  3   434 \N  default 434 \N  \N  \N  \N  \N
SISTEMA DE CONTROL DE PERMISOS Y AUSENCIAS DE FUNCIONARIOS DEL 3º JUZGADO DE FAMILIA DE SANTIAGO DE CHILE   7/4/2011    1   422 179 default 422 \N  \N  \N  \N  \N
DESARROLLO DE SISTEMA DE COTIZACIÓN Y DE CONTROL DE EXISTENCIAS PARA LA EMPRESA ALUMAR  11/10/12    3   423 \N  default 423 \N  \N  \N  \N  \N
SISTEMA WEB DE APOYO A LA ADMINISTRACION Y PLANIFICACION DE EVIDENCIA NORMATIVA DE AUDITORIAS PARA NEXUS S.A.   7/4/2011    3   424 \N  default 424 \N  \N  \N  \N  \N
SISTEMA WEB PARA MONITOREAR DISPOSITIVOS GPS    20/09/2011  3   425 \N  default 425 \N  \N  \N  \N  \N
SISTEMA CMR DE APOYO A LA FUERZA DE VENTAS CON CLIENTE DE OPERACION ASINCRONICA 7/4/2011    3   426 \N  default 426 \N  \N  \N  \N  \N
DESARROLLO DE UN SISTEMA DE APOYO A LA GESTIÓN DE TORNEOS Y APUESTAS EN LA COMUNIDAD DE VIDEOJUEGOS CIBERDEPORTES.NET.  30/03/2012  3   428 \N  default 428 \N  \N  \N  \N  \N
WEB SERVICES PARA APOYAR LA VENTA DE SEGUROS DE VEH�?CULOS PARTICULARES A TRAVES DE UNA MULTITIENDA  1/2/2012    3   429 \N  default 429 \N  \N  \N  \N  \N
SISTEMA DE INFORMACIÓN DE APOYO PARA AUTOMATIZACIÓN Y MONITOREO DE ACTIVIDADES DE PLAN DE CORTE EN CONVERSIÓN DE TIENDAS PARA LA COMPAÑ�?A ZCMART CHILE.     3   430 \N  default 430 \N  \N  \N  \N  \N
PLATAFORMA PARA LA GENERACIÓN Y APOYO A LA EVALUACIÓN DE VISUALIZAORES DE RESULTADOS DE BÚSQUEDA    1/2014  3   435 \N  default 435 \N  \N  \N  \N  \N
METODOLOGIA PARA EL DISEÑO DE INFRAESTRUCTURA DE ALTA DISPONIBILIDAD TI 20/09/2011  1   441 180 default 441 \N  \N  \N  \N  \N
PROTOCOLO SERVIDOR VIRTUAL EN NUBE PARA RESPALDO Y ACTUALIZACION DINAMICA DE AGENDA TELEFONICA CELULAR      3   442 \N  default 442 \N  \N  \N  \N  \N
HERRAMIENTA INTERACTIVA PARA APOYAR LA EVALUACIÓN DE PACIENTES EN TRATAMIENTO DEL TRASTORNO DE DÉFICIT ATENCIONAL A PARTIR DEL RASTREO OCULAR   1/2014  3   436 \N  default 436 \N  \N  \N  \N  \N
PLATAFORMA PARA EL APOYO A LA EVALUACIÓN Y DEFINICIÓN DE GESTOS CORPORALES EN LA INTERACCIÓN CON OBJETOS DIGITALES DE INFORMACIÓN   1/2014  3   437 \N  default 437 \N  \N  \N  \N  \N
EVALUACIÓN IMPL�?CITA DE CARGA COGNITIVA DURANTE EL PROCESAMIENTO DE INFORMACIÓN A PARTIR DE PATRONES DE LECTURA 1/2014  3   438 \N  default 438 \N  \N  \N  \N  \N
F�?BRICA DE COLABORATORIOS PARA APOYAR LA INVESTIGACIÓN EN BÚSQUEDA COLABORATIVA DE INFORMACIÓN  2/2014  3   439 \N  default 439 \N  \N  \N  \N  \N
PLATAFORMA PARA LA DEFINICIÓN Y APOYO A LA EVALUACIÓN DE RETROALIMENTACIÓN T�?CTIL EN LA INTERACCIÓN CON OBJETOS DE INFORMACIÓN DIGITAL A TRAVÉS DE INTERFACES NATURALES 2/2014  3   440 \N  default 440 \N  \N  \N  \N  \N
RED SOCIAL TWITTER APLICADA A SEGURIDAD DOMOTICA PROTOTIPO CON ACCESO MOBILE    8/22/2011   1   443 181 default 443 \N  \N  \N  \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE LAS REDES IP    2/2013  3   449 \N  default 449 \N  \N  \N  \N  \N
TECNOLOG�?A QR MÓVIL DE APOYO A LA VENTA ONLINE Y FUNCIÓN DE CAJEROS MÓVILES EN SUPERMERCADOS.   8/22/2011   1   444 182 default 444 \N  \N  \N  \N  \N
PROTOTIPO DE NODO OBSERVATORIO TERRITORIAL INTEGRADO EN RED,PARA GEOLOCALIZACIÓN DE RECURSOS Y APOYO A LA GESTIÓN DIN�?MICA COMUNAL (P-NOT). 12/7/2010   3   445 \N  default 445 \N  \N  \N  \N  \N
NODO COMUNAL INTEGRABLE A RED DE GEO-REPRESENTACIÓN DE ZONAS DE RIESGO Y CONTINGENCIA TERRITORIAL, BASADO EN SOFWARE LIBRE (NODO CIR-GR2).  13/08/2010  3   446 \N  default 446 \N  \N  \N  \N  \N
SISTEMA PARA EL MANEJO DE PARTITURAS DIGITALES BASADA EN TECNOLOG�?A TOUCH-MOBILE PARA ORQUESTAS SINFÓNICAS.     3   447 \N  default 447 \N  \N  \N  \N  \N
DESARROLLO DE UNA APLICACIÓN MULTIMEDIA QUE APOYE EL APRENDIZAJE DEL IDIOMA CHINO MANDARIN COMO LENGUAJE EXTRANJERA ORIENTADO A LA ESCRITURA    7/10/2011   3   450 \N  default 450 \N  \N  \N  \N  \N
DISEÑO DE UN LABORATORIO VIRTUAL PARA EL CURSO CRIPTOGRAF�?A 05/08/11    3   451 \N  default 451 \N  \N  \N  \N  \N
OBJETO DE APRENDIZAJE PARA EL ESTUDIO DE REDES DE �?REA LOCAL    1/2014  3   454 \N  default 454 \N  \N  \N  \N  \N
SISTEMA DE MONITIREO REMOTO EXCLUSIVO PARA DISPOSITIVOS CON SOPORTE IPV6    10/5/2011   1   452 183 default 452 \N  \N  \N  \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL APOYO A LA INTRODUCCIÓN A LA PROGRAMACIÓN  1/2014  3   455 \N  default 455 \N  \N  \N  \N  \N
SISTEMA DE APOYO DE GESTIÓN EFICIENTE DE LAS ENERG�?AS DEL DIINF     1   453 184 default 453 \N  \N  \N  \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDS SATELITALES 2/2012  3   456 \N  default 456 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRESIÓN Y APLICACIÓN DE LOS FUNDAMENTOS DE DESARROLLO WEB  04/12/12    1   457 185 default 457 \N  \N  \N  \N  \N
DESARROLLO DE UN FRAMEWORK PARA LA CONSTRUCCIÓN DE OBJETOS DE APRENDIZAJE       3   461 \N  default 461 \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA DE COMPRA VENTA DE SEGUROS EN L�?NEA   25/04/12    1   458 186 default 458 \N  \N  \N  \N  \N
DESARROLLO DE UN SISTEMA DE NOTIFICACIONES A TRAVÉS DE REDES SOCIALES DE INTERNET   19/03/13    3   460 \N  default 460 \N  \N  \N  \N  \N
SISTEMA DE COMUNICACIÓN DE EMERGENCIAS AL CUERPO DE BOMBEROS DE SANTIAGO    1/2014  3   463 \N  default 463 \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DE RED COMPUTACIONAL EMPRESA VYS    02/04/12    1   462 187 default 462 \N  \N  \N  \N  \N
SOFTWARE DE APOYO AL SEGUIMIENTO DEL PLAN ESTRATÉGICO DE LA EMPRESA PÚBLICA EMERES  7/11/2013   3   464 \N  default 464 \N  \N  \N  \N  \N
OBJETO DE APRENDIZAJE PARA EL ESTUDIO DE DISTRIBUCIÓN DE CLAVES CRIPTOPOGR�?FIA      1   465 188 default 465 \N  \N  \N  \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS MÉTODOS DE DETECCIÓN Y CORRECCIÓN DE ERRORES EN LA TRANSMISIÓN DE DATOS. 3/10/2013   3   468 \N  default 468 \N  \N  \N  \N  \N
MODELO PARA LA AUTORIZACIÓN DE TRANSACCIONES FINANCIERAS BASADO EN EST�?NDAR EMV 12/11/12    1   466 189 default 466 \N  \N  \N  \N  \N
OBJETO DE APRENDIZAJE PARA TRANSMISIÓN DE DATOS     3   471 \N  default 471 \N  \N  \N  \N  \N
APLICACIÓN DE APOYO AL APRENDIZAJE DE LA FONÉTICA DEL IDIOMA CHINO MANDAR�?N.    15/10/11    1   467 190 default 467 \N  \N  \N  \N  \N
EVALUCION DE LA EFICIENCIA DE LOS OBJETOS DE APRENDIZAJE QUE APOYAN LA ENSEÑANZA DE LOS ALUMNOS DEL CURSO DE CRIPTOGRAFIA   20/06/11    3   469 \N  default 469 \N  \N  \N  \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE PROTOCOLOS CRIPTOGR�?FICOS CL�?SICOS  2/2013  3   472 \N  default 472 \N  \N  \N  \N  \N
METODOLOG�?A PARA EL DESARROLLO DE OBJETOS DE APRENDIZAJE    11/01/13    1   470 191 default 470 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DEL MARCO DE TRABAJO DE DESARROLLO DE SOFTWARE SCRUM 1/2014  3   473 \N  default 473 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE EN APOYO A CONDUCTAS DE AUTOCUIDADO PARA NIÑOS Y JÓVENES CON DISCAPACIDAD INTELECTUAL    11/01/13    1   475 192 default 475 \N  \N  \N  \N  \N
SERVICIO DE COMUNICACIÓN POR VOZ EN UNA RED INAL�?MBRICA DE MALLA SIMULADA   1/2014  3   474 \N  default 474 \N  \N  \N  \N  \N
    2/2013  1   476 193 default 476 \N  \N  \N  \N  \N
PLAN DE CAPACITACIÓN EMPRESARIAL PARA ENSEÑAR TELEFONIA CELULAR USANDO OBJETOS DE APRENDIZAJE   05/08/11    3   478 \N  default 478 \N  \N  \N  \N  \N
SOFTWARE PREDICTIVO DE APOYO A LA PLANEACIÓN DE CAPACIDAD DE INFRAESTRUCTURAS DE RED        3   477 \N  default 477 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DEL PROTOCOLO DE AUTENTICACIÓN KERBEROS  11/01/13    1   479 194 default 479 \N  \N  \N  \N  \N
EAPECIFICACIÓNES FORMAL DE UNA RED MESH ORIENTADA AL ESTUDIO DE ALGORITMOS DE ENRUTAMIENTO Y AUTENTICACIÓN.     3   482 \N  default 482 \N  \N  \N  \N  \N
SERVICIO DE CONFIDENCIALIDAD EN RED DE MALLA INALAMBRICA    2/2013  7   483 \N  default 483 \N  \N  \N  \N  \N
UNA PLATAFORMA CROWDSOURCING PARA LA PREPARACIÓN DE LA PSU  1/2014  3   480 \N  default 480 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE PROTOCOLOS DE SEGURIDAD PARA CORREO ELECTRÓNICOS   30/03/2012  1   486 195 default 486 \N  \N  \N  \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDES DE AREA LOCAL (ETHERNET)   13/08/2013  3   481 \N  default 481 \N  \N  \N  \N  \N
APLICACION DE APOYO AL APRENDIZAJE DE LA ESCRITURA EN CHINO MANDARIN        1   487 196 default 487 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN Y APLICACIÓN DE IPV6. 27/07/11    3   488 \N  default 488 \N  \N  \N  \N  \N
GU�? METODOLÓGICA PARA LA IMPLEMENTACIÓN DE UN PROTOCOLO DE AUTENTICACIÓN BASADO EN KERBEROS.    28/08/2009  3   489 \N  default 489 \N  \N  \N  \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE ENFOCADOS EN TRANSMISIÓN INAL�?MBRICA   01/03/12    3   491 \N  default 491 \N  \N  \N  \N  \N
OBJETO DE APRENDIZAJE PARA APOYAR EL APRENDIZAJE DE LA HERRAMIENTA OMNET++  22/09/2014  3   484 \N  default 484 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LA SEGURIDAD EN REDES A TRAVÉS DE FUNCIONES HASH, FUNCIONES MAC Y FIRMA DIGITAL    11/10/12    1   494 197 default 494 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE COMO HERRAMIENTA DE APOYO A LA ENSEÑANZA DE PROTOCOLOS DE SEGURIDAD EN LA RED.   04/10/12    3   485 \N  default 485 \N  \N  \N  \N  \N
SISTEMA DE GESTIÓN DE PROYECTOS CONSULTORA SAP PRIME GROUP. 03/05/11    1   496 198 default 496 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE APLICACIONES DE TIEMPO REAL EN INTERNET    1/2014  3   490 \N  default 490 \N  \N  \N  \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DEL IDIOMA INGLÉS EN NIÑOS PREESCOLARES 22/07/2013  3   492 \N  default 492 \N  \N  \N  \N  \N
SERVICIO PARA COMPARTIR MATERIAL DE ESTUDIO SOBRE UNA RED INAL�?MBRICA DE MALLA SIMULADA     1/2014  3   493 \N  default 493 \N  \N  \N  \N  \N
OBJETO DE APRENDIZAJE PARA APOYAR EL PROCESO DE LECTURA INFANTIL    1/2014  3   495 \N  default 495 \N  \N  \N  \N  \N
APLICACIÓN DE APOYO AL APRENDIZAJE DE LA GRAM�?TICA DEL CHINO MANDARIN   1/2014  3   497 \N  default 497 \N  \N  \N  \N  \N
EVALUACION DE UNA NUEVA METODOLOGIA PARA EL DESARROLLO DE OBJETOS DE APRENDIZAJE        3   503 \N  default 503 \N  \N  \N  \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE INTERACTIVOS PARA APOYAR EL ESTUDIO DE LOS MÉTODOS DE DETECCIÓN Y CORRECCIÓN DE ERRORES EN LA TRANSACCIÓN DE DATOS 2/2013  1   498 199 default 498 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS PROTOCOLOS USADOS EN APLICACIONES TIEMPO-REAL EN INTERNET, REAL TIME PROTOCOL (RTP) Y REAL TIME PROTOCOL (RTCP).   12/5/2014   7   499 \N  default 499 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE ALGORITMOS HASH.  20/09/11    3   500 \N  default 500 \N  \N  \N  \N  \N
DESARROLLO DE UN SISTEMA DE INFORMACIÓN PARA OPTIMIZAR LA GESTIÓN DE PLANIFICACIÓN DE LA RED DE TRANSMISIÓN ELÉCTRICA.  30/11/2011  3   501 \N  default 501 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE PROTOCOLOS DE APLICACIÓN EN INTERNET  1/2014  3   508 \N  default 508 \N  \N  \N  \N  \N
EVALUACIÓN DE METODOLOG�?A CPIS PARA EL DESARROLLO DE OBJETOS DE APRENDIZAJE     1   504 200 default 504 \N  \N  \N  \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE LOS MECANISMOS DE CONTROL DE CONGESTIÓN EN REDES DE CONMUTACIÓN DE PAQUETES 1/2014  3   511 \N  default 511 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO Y COMPRENSIÓN DE LOS PROTOCOLOS DE SEGURIDAD IPSEC Y SSL PARA INTERNET    11/10/12    1   505 201 default 505 \N  \N  \N  \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDES WI-FI Y WI-MAX 22/07/2013  3   514 \N  default 514 \N  \N  \N  \N  \N
DESARROLLO DE UN REPOSITORIO DE OBJETOS DE APRENDIZAJE PARA EL DEPARTAMENTO DE INGENIER�?A INFORM�?TICA   27/12/2012  1   506 202 default 506 \N  \N  \N  \N  \N
MODELO DE GESTIÓN DE COTIZACIONES Y VENTAS DE SEGUROS DE VEH�?CULOS  24/10/2014  3   517 \N  default 517 \N  \N  \N  \N  \N
IMPLEMENTACIÓN DE SEGURIDAD EN ROLES Y PERFILES PARA SAP ERP EN CONSTRUMART S.A.    12/11/12    1   507 203 default 507 \N  \N  \N  \N  \N
OBJETO DE APRENDIZAJE SOBRE LA DIRECCIÓN Y GESTIÓN DE PROYECTOR TI  1/2014  3   521 \N  default 521 \N  \N  \N  \N  \N
APLICACIÓN WEB PARA LA ADMINISTRACIÓN DE EVALUACIONES DE ATENCIÓN A CLIENTES PARA CONSULTORA GETGAIN    13/1/12 1   509 204 default 509 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN DE LOS CIFRADORES SIMÉTRICOS RC4, IDEA Y BLOWFISH 5/3/2013    3   522 \N  default 522 \N  \N  \N  \N  \N
DESARROLLO DE OBJETIVOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS MECANISMOS DE CONTROL DE CONGESTION USANDO REDES DE CONMUTACION DE PAQUETES        1   510 205 default 510 \N  \N  \N  \N  \N
DISEÑO, IMPLEMENTACIÓN Y AN�?LISIS DE BLOQUES ATÓMICOS EN CONTRA DE SSCA, ATAQUES C-SAFE-FAULTS Y ATAQUES DE COLISIÓN DE CORRELACIÓN HORIZONTAL EN CRIPTOGRAF�?A DE CURVA EL�?PTICA    2/2014  3   523 \N  default 523 \N  \N  \N  \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDES DE TELEFON�?A CELULAR.  30/05/11    1   512 206 default 512 \N  \N  \N  \N  \N
OBJETO DE APRENDIZAJE PARA APOYAR LA ENSEÑANZA DE PROTOCOLOS DE VENTANA DESLIZANTE  2/2014  3   524 \N  default 524 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN DE LOS CIFRADOS SIMÉTRICOS AES Y DES. 10/11/11    1   513 207 default 513 \N  \N  \N  \N  \N
APLICACIÓN DE UN MÉTODO DE VALIDACIÓN SOBRE LOS OBJETOS DE APRENDIZAJE DEL REPOSITORIO DEL DIINF    2/2014  3   525 \N  default 525 \N  \N  \N  \N  \N
METODO DE VALIDACION PARA OBJETOS DE APRENDIZAJE    25/10/2013  1   515 208 default 515 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE SOBRE CRIPTOGRAF�?A SIMÉTRICO PARA BLOWFISH   2/2014  3   526 \N  default 526 \N  \N  \N  \N  \N
UN ALGORITMO DE AUTENTICACIÓN PARA LA SEGURIDAD EN REDES DE MALLA   11/10/12    1   516 209 default 516 \N  \N  \N  \N  \N
PROCESO DE NEGOCIO Y REQUERIMIENTOS PARA SISTEMA DE RECLUTAMIENTO Y SELESCCIÓN DE EMPRESA DE �?REA FINANCIERA    19/01/13    3   518 \N  default 518 \N  \N  \N  \N  \N
LOCALIZACIÓN Y SEGUIMIENTO DE PERSONAS DENTRO DE UN TREN EN MOVIMIENTO UTILIZANDO VISIÓN ARTIFICIAL 2/2013  3   527 \N  default 527 \N  \N  \N  \N  \N
ESTUDIO Y DESARROLLO DE UN SISTEMA DE RESPALDO (BACKUP) Y RECUPERACIÓN PARA LA SEGURIDAD Y CONTINUIDAD OPERACIONAL DE PROVECTIS S.A.    06/01/11    1   519 210 default 519 \N  \N  \N  \N  \N
DISEÑO E IMPLEMENTACIÓN DE UN REPOSITORIO DE OAS PARA EL DEPARTAMENTO DE INGENIÉRIA INFORM�?TICA 01/08/12    3   520 \N  default 520 \N  \N  \N  \N  \N
CONTABILIZACIÓN DE PERSONAS QUE SUBEN Y BAJAN DE UN TREN METROPOLITANO USANDO VISIÓN POR COMPUTADOR 2/2013  3   528 \N  default 528 \N  \N  \N  \N  \N
PICKUP AND DELIVERY PROBLEM: APLICACIÓN AL PROBLEMA DE ASIGNACIÓN DE TAREAS PARA LA FLOTA DE CAMIONES DE TRANSPORTES BELLO. 10/11/11    1   533 211 default 533 \N  \N  \N  \N  \N
UN MODELO DE OPTIMIZACIÓN PARA EL RUTEO DE FLOTA DE CAMIONES DE UNA EMPRESA DE TRANSPORTES  21/12/09    3   535 \N  default 535 \N  \N  \N  \N  \N
UNA SOLUCIÓN AL PROBLEMA DE PLANIFICACIÓN DE DISTRIBUCIÓN DE CONTENEDORES LLENOS Y VAC�?OS.  05/10/11    3   537 \N  default 537 \N  \N  \N  \N  \N
DETECCIÓN DE PERSONAS EN TIEMPO REAL MEDIANTE EL USO DE UNA RASPBERRY PI    2/2013  3   529 \N  default 529 \N  \N  \N  \N  \N
GENERACION DE NUEVOS ALGORITMOS UTILIZANDO PROGRAMACION GENETICA PARA EL PROBLEMA DE OPTIMIZACION JOB SHOP FLEXIBLE     1   538 212 default 538 \N  \N  \N  \N  \N
DETECCIÓN DE VEH�?CULOS DETENIDOS EN SECTORES PROHIBIDOS DEL TR�?FICO URBANO UTILIZANDO TÉCNICAS DE VISIÓN POR COMPUTADOR.    2/2013  3   530 \N  default 530 \N  \N  \N  \N  \N
SITIO WEB PARA LA INCORPORACION DE VIDEOS EN LAS SALAS DE CLASES    7/4/2011    1   539 213 default 539 \N  \N  \N  \N  \N
AN�?LISIS COMPARATIVO DE CLASIFICADORES EN CUANTO A SU SENSIBILIDAD ESPACIAL PARA LA DETECCIÓN DE PEATONES EN IM�?GENES   1/2014  3   531 \N  default 531 \N  \N  \N  \N  \N
RESOLVIENDO EL PROBLEMA CORTE DE PIEZAS GUILLOTINA MEDIANTE LA COMPUTACION EVOLUTIVA    1/2013  1   540 214 default 540 \N  \N  \N  \N  \N
DETECCIÓN, LOCALIZACIÓN Y CONTEO AUTOM�?TICO DE PERSONAS QUE ENTRAN A UN MICROBÚS, MEDIANTE ALGORITMOS DE VISIÓN POR COMPUTADOR. 2/2013  3   532 \N  default 532 \N  \N  \N  \N  \N
ALGOBOTS PARA EL PROBLEMA DE LA MOCHILA MULTIDIMENSIONAL        1   541 215 default 541 \N  \N  \N  \N  \N
GENERACION AUTOMATICA DE ALGORITMO PARA EL PROBLEMA DE FORMACION DE CELULAS DE MANUFACTURAS 12/10/11    3   542 \N  default 542 \N  \N  \N  \N  \N
ESTUDIO DE APLICABILIDAD DE VIDEOS JUEGOS PARA SOLUCIONAR PROBLEMAS DE OPTIMIZACION 28/07/10    3   544 \N  default 544 \N  \N  \N  \N  \N
SISTEMA WEB DE VIDEOS CLASIFICADOS DE APOYO EN LA PREPARACIÓN DE ESTUDIANTES PARA LA PSU-MATEM�?TICAS        3   534 \N  default 534 \N  \N  \N  \N  \N
GENERACION DE ALGORITMOS PARA EL PROBLEMA JOB-SHOP FLEXIBLE UTILIZANDO PROGRAMACION GENETICA        1   545 216 default 545 \N  \N  \N  \N  \N
EVOLUCIÓN DE METAHEUR�?STICAS PARA PROBLEMAS DE OPTIMIZACIÓN COMBINATORIA    1/2014  3   536 \N  default 536 \N  \N  \N  \N  \N
UN ALGORITMO GENÉTICO COOPERATIVO PARA PROBLEMAS DE CORTES Y EMPAQUE    19/07/2012  1   546 217 default 546 \N  \N  \N  \N  \N
UNA SOLUCIÓN HEUR�?STICA PARA EL PROBLEMA ASIGNACIÓN DE BUSES Y TRIPULACIONES CONSIDERANDO SUS ROTACIONES.       3   547 \N  default 547 \N  \N  \N  \N  \N
DETECCIÓN DE FALLAS EN GRANJA FOTOVOLTAICA MODULAR DE 10 MW/H   1/2014  3   543 \N  default 543 \N  \N  \N  \N  \N
INFRAESTRUCTURA EMPRESARIAL PARA OBSERVATORIO DE LA WEB: CASO DE LA GENERACIÓN DE NOTICIAS EN UNA RED SOCIAL CORPORATIVA CON UN PROCESO DE NEGOCIO ASOCIADO 9/9/2014    3   86  \N  default 86  \N  \N  \N  \N  \N
MEJORA DE ALGORITMOS AUTOM�?TICOS PARA EL PROBLEMA DE LA MOCHILA IDENTIFICANDO EL CONJUNTO DE FUNCIONES Y TERMINALES ADECUADO    11/10/12    1   550 218 default 550 \N  \N  \N  \N  \N
AGENTES RECURSIVOS PARA EL CONTROL DE LA CENTRALIZACIÓN Y DISTRIBUCIÓN DE LAS DECISIONES EN SISTEMAS INTELIGENTES DE PRODUCCIÓN 30/03/2012  3   551 \N  default 551 \N  \N  \N  \N  \N
CONTINUOUSDELIVERY DE SERVICIOS DE RECOMENDACIÓN EN UNA RED SOCIAL EMPRESARIAL DE NOTICIAS  10/6/2014   3   101 \N  default 101 \N  \N  \N  \N  \N
EVOLUCION DE ALGORITMOS DETECTORES DE TRAYECTORIA PARA EL PROBLEMA DEL VENDEDOR VIAJERO     1   554 219 default 554 \N  \N  \N  \N  \N
EFECTOS DEL CRITERIO DE ENFRIAMIENTO SOBRE SIMULATED ANNEALING EN LA RESOLUCIÓN DEL PROBLEMA DEL �?RBOL DE COBERTURA M�?NIMA  04/10/12    3   555 \N  default 555 \N  \N  \N  \N  \N
DISEÑO Y DESARROLLO DE UNA PLATAFORMA PARA EL SOPORTE DE LAS CLASAS VIRTUALES EN CURSOS DE INGENIER�?A EN EJECUCIÓN EN COMPUTACIÓN E INFORM�?TICA.    20/12/10    3   556 \N  default 556 \N  \N  \N  \N  \N
REGISTRO DE IM�?GENES ASTRONÓMICAS   2/2013  \N  557 \N  default 557 \N  \N  \N  \N  \N
DESARROLLO DE SISTEMAS WORKFLOW PARA EL PLANTEAMIENTO Y VERIFICACIÓN DE COMPETENCIAS DE MANEJO DE PROYECTOS EN LOS CURSOS DE INGENIER�?A CIVIL INFORM�?TICA   1/2014  3   108 \N  default 108 \N  \N  \N  \N  \N
UN JUEGO GENERADOR DE ALGORITMOS PARA EL PROBLEMA DE LA MOCHILA.    20/09/11    1   558 220 default 558 \N  \N  \N  \N  \N
DESARROLLO Y APLICACIÓN DE MODELO DIN�?MICO EN AMBIENTE REAL DE CONMINUCIÓN PARA ESTIMAR EN LINEA VARIABLES CR�?TICAS DE MOLIENDA SEMIAUTÓGENA    1/2012  3   151 \N  default 151 \N  \N  \N  \N  \N
GENERACION ATOMATICA DE ALGORITMOS PARA EL PROBLEMA DEL VENDEDOR VIAJERO        1   559 221 default 559 \N  \N  \N  \N  \N
UNA RESOLUCIÓN AL PROBLEMA DE LA SELECCIÓN UBICADA DE INTERRUPTORES EN UN SISTEMA DE DISTRIBUSIÓN ELÉCTRICO, CON MÉTODO DE OPTIMIZACIÓN HEUR�?STICA ALGORITMO GENÉTICO PARALELO      3   560 \N  default 560 \N  \N  \N  \N  \N
UN SISTEMA WEB PARA MEJORAR EL RENDIMIENTO DE IMPRESORAS AL ENVIAR TRABAJOS DE IMPRESIÓN MASIVA 22/07/2013  3   214 \N  default 214 \N  \N  \N  \N  \N
SOLUCIÓN NUMÉRICA AL PROBLEMA DEL �?RBOL DE COBERTURA M�?NIMO GENERALIZADO MEDIANTE SIMULATED ANNEALING   26/09/2012  1   561 222 default 561 \N  \N  \N  \N  \N
DESARROLLO E IMPLEMENTACIÓN DE APLICACIÓN MÓVIL EN ANDROID PARA EL CONTROL PERSONALIZADO DE LA ALIMENTACIÓN 2/2013  3   250 \N  default 250 \N  \N  \N  \N  \N
REDUCCIÓN DE ARISTAS PARA INSTANCIAS DE �?RBOL DE COBERTURA M�?NIMO GENERALIZADO  03/09/12    1   562 223 default 562 \N  \N  \N  \N  \N
IMPLEMENTACIÓN DE UN ERP DE APOYO A LA ADMINISTRACIÓN DEL SALÓN DE BELLEZA �?RTICO   1/2014  3   299 \N  default 299 \N  \N  \N  \N  \N
UNA CONTRIBUCIÓN AL PROBLEMA DE ASIGNACIÓN DE VEH�?CULOS CON MÚLTLIPES DEPÓSITOS Y MANTENCIONES PROGRAMADAS  26/04/12    1   563 224 default 563 \N  \N  \N  \N  \N
GENERACIÓN AUTOM�?TICA DE ALGORITMOS PARA EL PROBLEMA DE CORTE DE PIEZAS NO GUILLOTINA CON PROGRAMACIÓN GENÉTICA BINARIA PARALELA.   02/12/10    3   564 \N  default 564 \N  \N  \N  \N  \N
EVALUACIÓN DE LOS MÉTODOS NARX Y NARMAX CON REDES NEURONALES Y M�?QUINA DE SOPORTE VECTORIAL PARA LA ESTIMACIÓN DE LA ACCIDENTABILIDAD EN LA MINER�?A 2/2012  3   552 \N  default 552 \N  \N  \N  \N  \N
GENERACIÓN AUTOM�?TICA DE ALGORITMOS DE CLUSTERIZACIÓN.      1   566 225 default 566 \N  \N  \N  \N  \N
GENERACIÓN DE UNA SOLUCIÓN HEUR�?STICA PARA EL PROBLEMA DE TSPPC A TRAVÉS DE LA PROGRAMACIÓN GENÉTICA    1/2014  3   553 \N  default 553 \N  \N  \N  \N  \N
BÚSQUEDA DE ALGORITMOS ESPECIALIZADOS PARA FAMILIAS DE INSTANCIAS DE PROBLEMAS DE OPTIMIZACIÓN  2/2013  1   567 226 default 567 \N  \N  \N  \N  \N
GENERACIÓN DE LA CALENDARIZACIÓN DE LOS PARTIDOS DEL CAMPEONATO DE FÚTBOL DE CHILE MEDIANTE SIMULATED ANNEALING 1/2014  3   569 \N  default 569 \N  \N  \N  \N  \N
NUEVOS ALGORITMOS ARTIFICIALES PARA LA ASIGNACION DE BUSES Y SERVICIOS DE CONDUCCION EN EL TRANSPORTE URBANO    13/11/10    1   568 227 default 568 \N  \N  \N  \N  \N
IMPLEMENTACION DE HERRAMIENTA DE APOYO A LA GESTION DE LA DOCENCIA EN  COLEGIOS DE EDUCACION MEDIA BASDA EN TECNOLOGIA DE CODIGO ABIERTO        3   571 \N  default 571 \N  \N  \N  \N  \N
GENERACIÓN DE ALGORITMOS PARA EL PROBLEMA DE OPTIMIZACIÓN CELL FORMATION PROBLEM UTILIZANDO COMPUTACIÓN EVOLUTIVA   2/2013  3   570 \N  default 570 \N  \N  \N  \N  \N
DESARROLLO DE UN SISTEMA PARA MEJORAR LA BÚSQUEDA Y MANEJO DE �?TEMS DE CONFIGURACIÓN PARA APOYO AL PROCESO DE GESTIÓN DE CONFIGURACIÓN ITIL V3  14/07/2014  1   572 228 default 572 \N  \N  \N  \N  \N
APLICANDO INDICADORES A ALGORITMOS GENERADOS POR PROGRAMACIÓN GENÉTICA PARA EL PROBLEMA NP-C TSP.   28/05/2012  3   573 \N  default 573 \N  \N  \N  \N  \N
GENERADOR DE ALGORITMOS PARA RESOLVER EL PROBLEMA DE LA PLANIFICACIÓN DE BUSES PARA EL TRANSPORTE URBANO DE PASAJEROS   1/2012  3   575 \N  default 575 \N  \N  \N  \N  \N
NUEVOS ENFOQUES ALGOR�?TMICOS PARA JOB SHOP SCHEDUBLING PROBLEM Y FLOW SHOP SCHEDULING PROBLEM   11/10/12    1   574 229 default 574 \N  \N  \N  \N  \N
ALGORITMO DE CLASIFICACIÓN DE GALAXIAS SEGÚN SU MORFOLOG�?A EN IM�?GENES CAPTURADAS POR EL RADIOTELESCOPIO DEL OBSERVATORIO ALMA. 31/03/2014  3   578 \N  default 578 \N  \N  \N  \N  \N
CREACIÓN AUTOMATICA DE ALGORITMOS PARA RESOLVER EL PROBLEMA DE CAMINO MINIMO BASANDOSE EN COMPUTACIÓN EVOLUTIVA0    11/10/12    1   576 230 default 576 \N  \N  \N  \N  \N
DESARROLLO E IMPLEMENTACION DE CONTENIDOS DE UN SITIO WEB PARA LA SOLUCION DE LOS PROBLEMAS DEL CAMINO MINIMO, FLOW SHOP Y JOB SHOP Y ARBOL DE COBERTURA DE COSTO MINIMO    4/8/2010    3   577 \N  default 577 \N  \N  \N  \N  \N
NUEVAS HIPERHEUR�?STICAS COMPETITIVAS PARA EL PROBLEMA DEL CONJUNTO INDEPENDIENTE M�?XIMO DE VÉRTICES 2/2013  3   579 \N  default 579 \N  \N  \N  \N  \N
EVALUACIÓN DE ALGORITMOS GENÉTICOS CELULARES PARA EL PROBLEMA DE CORTE DE PIEZAS    11/01/13    1   581 231 default 581 \N  \N  \N  \N  \N
DISEÑO DE UN ALGORITMO PARA EL PROBLEMA DEL COLOREAMIENTO DE GRAFOS A TRAVÉS DE UN JUEGO COMPUTACIONAL.     3   582 \N  default 582 \N  \N  \N  \N  \N
GENERACIÓN DE ALGORITMOS UTILIZANDO PROGRAMACIÓN GENÉTICA PARA EL PROBLEMA DE OPTIMIZACIÓN GENERALIZED TRAVELLING SALESMAN PROBLEM  2/2013  3   580 \N  default 580 \N  \N  \N  \N  \N
UN SISTEMA WEB DE VIDEOS EDUCATIVOS PARA SEGUNDO Y TERCER NIVEL DE INGENIER�?A.  07/10/11    1   583 232 default 583 \N  \N  \N  \N  \N
CO-EVOLUCIÓN COMPUTACIONAL EN PROBLEMAS DE OPTIMIZACIÓN COMBINATORIA    2/2014  3   584 \N  default 584 \N  \N  \N  \N  \N
REVISIÓN Y MEJORAS DEL SOFTWARE PARA LA ADMINISTRACIÓN DE LAS POSTULACIONES A PROGRAMAS VESPERTINOS DEL DIINF   2/2014  3   585 \N  default 585 \N  \N  \N  \N  \N
DATOS SENSIBLES Y SU MANIPULACIÓN EN DISPOSITIVOS MÓVILES   2/2014  3   586 \N  default 586 \N  \N  \N  \N  \N
APLICACIÓN MULTIPLATAFORMA PARA DENUNCIAS, SUCESOS Y EVENTOS GEOCALIZADOS EN TIEMPO REAL CON EVIDENCIA MULTIMEDIA   2/2014  3   587 \N  default 587 \N  \N  \N  \N  \N
SISTEMA WEB DE CARACTERIZACIÓN BIOLÓGICA DE GRUPOS DE GENES     2/2014  3   588 \N  default 588 \N  \N  \N  \N  \N
SISTEMA DE INFORMACIÓN DOCENTE PARA APOYO A LA ACREDITACIÓN DE LOS PROGRAMAS DE PREGRADO DEL DEPARTAMENTO DE INGENIER�?A INFORM�?TICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE  2/2014  3   394 \N  default 394 \N  \N  \N  \N  \N
OBJETOS DE APRENDIZAJE RELATIVOS AL TRATAMIENTO DE ERROR EN LA TRANSMISIÓN Y RECEPCIÓN DE DATOS 1/2014  3   448 \N  default 448 \N  \N  \N  \N  \N
DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS PROTOCOLOS DE TRANSPORTE UTILIZADOS EN REDES CONMUTACIÓN DE PAQUETES 2/2013  3   459 \N  default 459 \N  \N  \N  \N  \N
DESARROLLO DE UN PROTOTIPO DE RED INAL�?MBRICA DE MALLA PARA EL DEPARTAMENTO DE INGENIER�?A INFORM�?TICA   1/2014  3   502 \N  default 502 \N  \N  \N  \N  \N
NUEVOS ALGOR�?TMOS ARTIFICIALES DE OPTIMIZACIÓN PARA EL WEIGHTED INDEPENDENCE SET PROBLEM BAJO LA TEOR�?A DE LA COMPUTACIÓN EVOLUTIVA     3   549 \N  default 549 \N  \N  \N  \N  \N
TEMA111 01/06/2015  1   595 239 1/2016  597 23/05/2015  16/05/2015  1/2016  \N  \N
ASDTEMA 19/05/2015  0   597 \N  1/2016  602 \N  \N  \N  \N  \N
SISTEMA WEW PARA AYUDAR A PADRES Y APODERADOS EN LA BUSQUEDA DE COLEGIOS USANDO UN OPEN DATE    11/10/2012  1   1   1   1/2015  1   17/05/2015  16/05/2015  \N  \N  \N
TEMABAS 28/05/2015  1   593 236 1/2016  595 19/05/2015  16/05/2015  \N  \N  \N
TEMA EJEMPLO 2  19/05/2015  1   598 240 1/2016  603 21/05/2015  20/05/2015  1/2016  \N  \N
TEMA TM 28/05/2015  1   596 238 1/2016  598 21/05/2015  16/05/2015  \N  \N  \N
TEMA PROP   15/05/2015  1   592 235 1/2016  594 23/05/2015  22/05/2015  \N  \N  \N
TEMA    15/05/2015  1   594 237 1/2016  596 16/05/2015  15/05/2015  1/2016  \N  \N
QWEQWE  30/03/2013  1   7   233 2/2011  7   21/05/2015  20/05/2015  1/2016  \N  \N
SISTEMA WEB DE APOYO A LA GESTIÓN DE UNA ORGANIZACIÓN COMUNITARIA   20/12/2013  1   6   4   1/2016  6   21/05/2015  20/05/2015  1/2016  \N  \N
\.


--
-- Name: tema_id_tema_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tema_id_tema_seq', 599, true);


--
-- Data for Name: tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo (nombre_tipo) FROM stdin;
ADMINISTRADOR
SECRETARIA
\.


--
-- Data for Name: tipoevento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipoevento (idtipoevento, nombretipo) FROM stdin;
1   F2: Actividades Deportivas
2   F4: Actividades de Difusión científica y tecnológica
3   F3: Actividades Artísticas
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

COPY usuario (username, nombre_usuario, apellido_usuario, password, activo) FROM stdin;
118403096   Pamela  Aguirre 9012cfb5fd87f82382c6d51c6b1e803cd72de18fa5f403db910ab48fc256f6c0    t
admin   admin   admin   8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918    \N
167500323   MARLEEN MARLEEN bec29f1e782001071ae91718ccb328406382ee9d982e23e34c98462c594d90f8    t
SECRE   SECRE   SECRE   5798c5e02a99432bf8d2111fb98be1cb36031d3e46a72045a72cf6fbfd1be949    t
coordinador coordinador coordinador 8e5f39d697ec216a897dde05b7835756df238e4d6d3bccd1b43fa1bc3478a50a    t
profesor    profesor    profesor    48a8d9ca65d4ffed5d24d09cde13ef76320e7d4ebf468bcfcb5c4a17f87785a9    t
secretaria  secretaria  secretaria  3e7100903faebe330d30fd23a5563830568bca178d5210986163528da8fac196    t
\.


--
-- Data for Name: usuario_tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuario_tipo (id_usuario_tipo, nombre_tipo, username) FROM stdin;
1   ADMINISTRADOR   118403096
4   ADMINISTRADOR   admin
5   SECRETARIA  167500323
7   SECRETARIA  SECRE
\.


--
-- Name: usuario_tipo_id_usuario_tipo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuario_tipo_id_usuario_tipo_seq', 7, true);


--
-- Data for Name: usuario_tipousuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuario_tipousuario (usuario_username, tipos_nombre_tipo) FROM stdin;
coordinador COORDINADOR DOCENTE
profesor    PROFESOR
secretaria  SECRETARIA
\.


--
-- Data for Name: usuarioevento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuarioevento (id, clave, nombre, rol) FROM stdin;
\.


--
-- Data for Name: versionplan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY versionplan (id, version, anio, planestudio_id) FROM stdin;
1   3   2012    1
2   1   2003    2
3   2   2001    3
4   2   1990    4
5   3   2012    5
6   1   2002    6
7   2   1990    7
8   1   1990    8
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
    ADD CONSTRAINT pk_tipo PRIMARY KEY (nombre_tipo);


--
-- Name: pk_usuario; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT pk_usuario PRIMARY KEY (username);


--
-- Name: pk_usuario_tipo; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY usuario_tipo
    ADD CONSTRAINT pk_usuario_tipo PRIMARY KEY (id_usuario_tipo);


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
    ADD CONSTRAINT usuario_tipousuario_pkey PRIMARY KEY (usuario_username, tipos_nombre_tipo);


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

CREATE INDEX relationship_28_fk ON usuario_tipo USING btree (username);


--
-- Name: relationship_29_fk; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE INDEX relationship_29_fk ON usuario_tipo USING btree (nombre_tipo);


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

CREATE UNIQUE INDEX tipo_pk ON tipo USING btree (nombre_tipo);


--
-- Name: usuario_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE UNIQUE INDEX usuario_pk ON usuario USING btree (username);


--
-- Name: usuario_tipo_pk; Type: INDEX; Schema: public; Owner: postgres; Tablespace:
--

CREATE UNIQUE INDEX usuario_tipo_pk ON usuario_tipo USING btree (id_usuario_tipo);


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
-- Name: fk_usuario__relations_tipo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario_tipo
    ADD CONSTRAINT fk_usuario__relations_tipo FOREIGN KEY (nombre_tipo) REFERENCES tipo(nombre_tipo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_usuario__relations_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario_tipo
    ADD CONSTRAINT fk_usuario__relations_usuario FOREIGN KEY (username) REFERENCES usuario(username) ON UPDATE RESTRICT ON DELETE RESTRICT;


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
