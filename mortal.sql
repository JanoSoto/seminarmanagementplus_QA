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


ALTER TABLE alumno OWNER TO postgres;

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


ALTER TABLE asignatura OWNER TO postgres;

--
-- Name: asignatura_asignatura; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE asignatura_asignatura (
    asignatura_id bigint NOT NULL,
    prerequisitos_id bigint NOT NULL
);


ALTER TABLE asignatura_asignatura OWNER TO postgres;

--
-- Name: asignatura_profesor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE asignatura_profesor (
    asignaturas_id bigint NOT NULL,
    profesores_rut_profesor character varying(255) NOT NULL
);


ALTER TABLE asignatura_profesor OWNER TO postgres;

--
-- Name: asociado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE asociado (
    idasociado bigint NOT NULL,
    nombreasociado character varying(255) NOT NULL,
    idcategoria_idcategoria bigint
);


ALTER TABLE asociado OWNER TO postgres;

--
-- Name: carrera; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE carrera (
    id bigint NOT NULL,
    nombre character varying(255)
);


ALTER TABLE carrera OWNER TO postgres;

--
-- Name: categoriaaevento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE categoriaaevento (
    idcategoria bigint NOT NULL,
    nombrecategoria character varying(255)
);


ALTER TABLE categoriaaevento OWNER TO postgres;

--
-- Name: checklist; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE checklist (
    id bigint NOT NULL,
    aceptado boolean,
    encuesta_id bigint,
    asignatura_id bigint
);


ALTER TABLE checklist OWNER TO postgres;

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


ALTER TABLE checklisteventos OWNER TO postgres;

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


ALTER TABLE comision_correctora OWNER TO postgres;

--
-- Name: comision_correctora_id_correctora_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comision_correctora_id_correctora_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comision_correctora_id_correctora_seq OWNER TO postgres;

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


ALTER TABLE comision_revisora OWNER TO postgres;

--
-- Name: comision_revisora_id_revisora_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comision_revisora_id_revisora_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comision_revisora_id_revisora_seq OWNER TO postgres;

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


ALTER TABLE coordinacion OWNER TO postgres;

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


ALTER TABLE encuesta OWNER TO postgres;

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


ALTER TABLE evento OWNER TO postgres;

--
-- Name: evento_asociado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE evento_asociado (
    id bigint NOT NULL,
    idasociado_idasociado bigint,
    idevento_idevento bigint
);


ALTER TABLE evento_asociado OWNER TO postgres;

--
-- Name: evento_expositor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE evento_expositor (
    id bigint NOT NULL,
    idevento_idevento bigint,
    idexpositor_idexpositor bigint
);


ALTER TABLE evento_expositor OWNER TO postgres;

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


ALTER TABLE expositor OWNER TO postgres;

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


ALTER TABLE historial OWNER TO postgres;

--
-- Name: historial_id_historial_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE historial_id_historial_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE historial_id_historial_seq OWNER TO postgres;

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


ALTER TABLE horario OWNER TO postgres;

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


ALTER TABLE inscripcion OWNER TO postgres;

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


ALTER TABLE inscripcionspam OWNER TO postgres;

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


ALTER TABLE logs OWNER TO postgres;

--
-- Name: logs_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE logs_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE logs_logs_id_seq OWNER TO postgres;

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


ALTER TABLE paramsemestreano OWNER TO postgres;

--
-- Name: planes_alumno; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE planes_alumno (
    alumno_id character varying(20),
    plan_id bigint,
    activo boolean
);


ALTER TABLE planes_alumno OWNER TO postgres;

--
-- Name: planestudio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE planestudio (
    id bigint NOT NULL,
    codigo integer,
    jornada integer,
    carrera_id bigint
);


ALTER TABLE planestudio OWNER TO postgres;

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


ALTER TABLE profe_correccion OWNER TO postgres;

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


ALTER TABLE profe_propuesta OWNER TO postgres;

--
-- Name: profe_revision; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE profe_revision (
    id_revisora integer NOT NULL,
    rut_profesor character varying(20) NOT NULL,
    rol_revision integer,
    fecha_revision character varying(15)
);


ALTER TABLE profe_revision OWNER TO postgres;

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
    jerarquia_categoria character varying(30),
    esta_seminar boolean,
    puede_guiar boolean,
    puede_corregir boolean,
    alias character varying(30)
);


ALTER TABLE profesor OWNER TO postgres;

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


ALTER TABLE propuesta OWNER TO postgres;

--
-- Name: propuesta_id_propuesta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE propuesta_id_propuesta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE propuesta_id_propuesta_seq OWNER TO postgres;

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


ALTER TABLE seccion OWNER TO postgres;

--
-- Name: semestre; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE semestre (
    id_semestre character varying(15) NOT NULL
);


ALTER TABLE semestre OWNER TO postgres;

--
-- Name: semestre_actual; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE semestre_actual (
    semestre_actual character varying(15) NOT NULL
);


ALTER TABLE semestre_actual OWNER TO postgres;

--
-- Name: subtipo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE subtipo (
    idsubtipo bigint NOT NULL,
    nombresubtipo character varying(255),
    idtipoevento_idtipoevento bigint
);


ALTER TABLE subtipo OWNER TO postgres;

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


ALTER TABLE tema OWNER TO postgres;

--
-- Name: tema_id_tema_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tema_id_tema_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tema_id_tema_seq OWNER TO postgres;

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


ALTER TABLE tipo OWNER TO postgres;

--
-- Name: tipoevento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipoevento (
    idtipoevento bigint NOT NULL,
    nombretipo character varying(255)
);


ALTER TABLE tipoevento OWNER TO postgres;

--
-- Name: tipousuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipousuario (
    id_tipo bigint NOT NULL,
    nombre_tipo character varying(255),
    pass character varying(256) NOT NULL
);


ALTER TABLE tipousuario OWNER TO postgres;

--
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario (
    uid character varying(20) NOT NULL,
    rut_usuario character varying(20) NOT NULL,
    nombre_usuario character varying(50),
    apellido_usuario character varying(50),
    activo boolean
);


ALTER TABLE usuario OWNER TO postgres;

--
-- Name: usuario_tipo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario_tipo (
    id_tipo bigint NOT NULL,
    rut_usuario character varying(20) NOT NULL,
    pass character varying(300) NOT NULL
);


ALTER TABLE usuario_tipo OWNER TO postgres;

--
-- Name: usuario_tipousuario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuario_tipousuario (
    usuario_rut_usuario character varying(255) NOT NULL,
    tipos_id_tipo bigint NOT NULL
);


ALTER TABLE usuario_tipousuario OWNER TO postgres;

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


ALTER TABLE usuariobytipo OWNER TO postgres;

--
-- Name: usuarioevento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuarioevento (
    id bigint NOT NULL,
    clave character varying(255),
    nombre character varying(255),
    rol character varying(255)
);


ALTER TABLE usuarioevento OWNER TO postgres;

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


ALTER TABLE versionplan OWNER TO postgres;

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
-- Data for Name: alumno; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO alumno VALUES ('NAYADA', 'HERNANDEZ OYANEDEL', '', '', '128516948', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('HERNANDO ANDRES', 'MANRIQUEZ NAVARRO', '', '', '173832168', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOAQUÍN', 'OLIVARES DONOSO', 'JOLIVARESD@GMAIL.COM', NULL, '171818575', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIAN', 'ROSENDE PINO', 'SEBASTIAN666@GMAIL.COM', '', '153179409', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MANUEL ALEJANDRO', 'ALARCON BELMAR', 'MANUEL.ALARCON@USACH.CL', NULL, '159073122', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GONZALO SEBASTIAN', 'ALVARADO REYES', 'MAILTO:GONSACOPATA@HOTMAIL.COM', NULL, '166257344', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARÍA SOLEDAD', 'ALVAREZ OPAZO', 'MAILTO:MARIA.ALVAREZO@USACH.CL', NULL, '169367353', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FABIÁN IGNACIO', 'ARÉVALO VELÁSQEZ', 'FABIAN.AREVALO@USACH.CL', NULL, '17841447K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FABIÁN ESTEBAN', 'CABELLO DEVIA', 'MAILTO:FABIAN.CABELLOD@USACH.CL', '', '163235315', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SERGIO DANIEL', 'CORTÉS PÉREZ', '', '', '171176654', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LUIS EDUARDO', 'DÍAZ PEREIRA', 'LEDZAID@GMAIL.COM', NULL, '167535682', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('HOSSMAN ANDRÉS', 'ESCOBAR MARTÍNEZ', 'GUTURAL.VOICE@GMAIL.COM', NULL, '179365995', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CLAUDIO ANDRÉS', 'MORALES ARAYA', 'CLAUDIO.MORALESAR@USACH.CL', NULL, '171676568', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALEX', 'POBLETE GONZALEZ', 'ALEX.POBLETE@GMAIL.COM', NULL, '150947952', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN ANDRÉS', 'REYES RAMÍREZ', 'JANDRES.RR@GMAIL.COM', NULL, '136750089', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DIEGO IGNACIO', 'ROJAS BUSTOS', 'DIEGO.ROJASBU@USACH.CL', NULL, '174641625', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOHN ISRAEL', 'SALVO REYES', 'JOHN.SALVOR@USACH.CL', NULL, '16548262K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARÍA JOSÉ', 'TAMAYO LEIVA', 'MARIA.TAMAYOL@USACH.CL', NULL, '174115273', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FRANCISCO JAVIER', 'ACUÑA CASTILLO', 'MAILTO:FRANCISCO.ACUNA@USACH.CL', NULL, '170217535', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ANDRES ESTEBAN', 'ALVAREZ ROMERO', 'ANDRESWF16@HOTMAIL.COM', NULL, '161952133', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ADOLFO ESTEBAN', 'DIAZ MORALES', 'ADOLFO.DIAZ@USACH.CL', NULL, '169009112', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE ANDRES', 'FUENTES BRAVO', 'MAILTO:FELIPE.FUENTESB@USACH.CL', NULL, '167406386', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN FRANCISCO', 'GONZALEZ REYES', 'MAILTO:JUAN.GONZALEZ@USACH.CL', NULL, '160707186', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('YHANN CARLOS', 'JARA GODOY', 'YHANN.JARA@USACH.CL', NULL, '172952739', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GUSTAVO JAVIER', 'MEJÍAS KALVIS', '', '', '166097401', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CARLOS ABRAHAM', 'MOLINA MUÑOZ', 'MAILTO:CARLOS.MOLINAM@USACH.CL', NULL, '167239404', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARIO', 'MUÑOZ VILLEGAS', 'MARIO.MUNOZ@USACH.CL', NULL, '173127677', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('HÉCTOR', 'OPAZO ROBLES', 'HECTOR.OPAZO.R@GMAIL.COM', NULL, '169091749', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('HÉCTOR NICOLÁS', 'POBLETE ROJAS', 'MAILTO:HECTOR.POBLETE@USACH.CL', NULL, '166250536', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE ARTURO', 'REYES ENCINA', 'FELIPE.REYESE@USACH.CL', NULL, '171686202', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ARMANDO', 'ROJAS MUÑOZ', 'ARMANDO.ROJAS@USACH.CL', NULL, '173808200', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LUZ ESTRELLA', 'VALENZUELA CABALLERO', 'MAILTO:LUZ.VALENZUELA@USACH.CL', NULL, '167858244', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RICARDO ADRIÁN', 'CISTERNA ESPINA', 'RICARDO.CISTERNA@USACH.CL', NULL, '174846863', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LEONARDO', 'ALLENDES CARVAJAL', 'LEONARDO.ALLENDES@GMAIL.COM', NULL, '10225225K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIAN', 'CORNEJO BAEZA', 'SEBASTIAN.CORNEJO@GMAIL.COM', NULL, '100438413', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('VICTOR', 'ERICES NEIRA', 'VERICESN@GMAIL.COM', NULL, '141359193', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('AQUILES ESTEBAN', 'GONZALEZ FUENTES', 'AEGONZALEZ@GMAIL.COM', NULL, '132978883', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JULIO MAURICIO', 'MUÑOZ ALVAREZ', 'JULIO.MUNOZ.ALVAREZ@GMAIL.COM', NULL, '154115919', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALDO CÉSAR', 'NAVARRETE MUÑOZ', 'ALDO.NAVARRETE@USACH.CL', NULL, '167503004', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JAIME HERNÁN', 'PAVEZ PAVEZ', 'JAIMEPAVEZPAVEZ@GMAIL.COM', NULL, '151166822', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIÁN ANDRÉS', 'SALAZAR SITIC', 'SEBASTIAN.SALAZARS@USACH.CL', NULL, '153318115', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARIO LUIS', 'LÓPEZ LANDEZ', 'MARIOLOPEZLANDES@GMAIL.COM', NULL, '171885701', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GUSTAVO ALBERTO', 'SALVO LARA', 'GUSTAVO.SALVO@USACH.CL', NULL, '177402168', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARCO ANTONIO', 'ACEVEDO BAEZA', 'MARCO.ACEVEDO@USACH.CL', NULL, '171233496', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARCO ALEJANDRO', 'BAEZA SALAZAR', 'MARCO.BAEZA@USACH.CL', NULL, '176719443', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FABIÁN ESTEBAN', 'CABELLO DEVIA', 'DANILO.BUSTOS@USACH.CL', NULL, '175147160', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DIEGO NICOLÁS', 'ESCOBAR LAGOS', 'DIEGO.ESCOBARLA@USACH.CL', NULL, '175863419', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALFREDO', 'ESCOBAR REX', 'IVAN.ESCOBAR@USACH.CL', NULL, '180611843', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('HUGO  MIGUEL', 'GARCIA GARCIA', 'LETHIUS@HOTMAIL.COM', NULL, '161228850', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DIEGO SEBASTIÁN', 'GARCÍA MELO', 'DIEGO.GARCIA@USACH.CL', NULL, '160954361', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PABLO IGNACIO', 'GONZÁLEZ CANTERGIANI', 'PABLO.GONZALEZCA@USACH.CL', NULL, '17080631K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('BRYAN', 'HENRÍQUEZ DÍAZ', 'B.HENRIQUEZD@GMAIL.COM', NULL, '164706699', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JAVIER', 'LARA SOTO', 'DIEGO.FRIEDMAN@GMAIL.COM', '', '172863027', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('VICTOR', 'LEBIL LEGUE', 'VICTOR.LEBIL@GMAIL.COM', NULL, '125011268', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN LUIS', 'MARCHANT AGUILAR', 'JUANLUISMARCHANT@GMAIL.COM', NULL, '167441882', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('WILDER HEBERT', 'PRADO PACCI', 'WILDERHP@GMAIL.COM', NULL, '158324954', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GONZALO', 'QUEZADA MORAGA', 'GONZALOQUEZADAM@YAHOO.COM', NULL, '141459368', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('BENJAMIN', 'QUINTANA OVIEDO', 'BENJA.QUINTANA777@GMAIL.COM', NULL, '180486011', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MANUEL ALEJANDRO', 'RUBIO HERRERA', 'MANUEL.RUBIOH@USACH.CL', NULL, '174841691', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RAFAEL', 'SOTO GALLARDO', 'RAFAEL.SOTO@USACH.CL', NULL, '174135142', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOSHUA', 'TRONCOSO ESPEJO', 'JOSHUA.TRONCOSO@USACH.CL', NULL, '170061403', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SERGIO FELIPE', 'VELASCO MOYA', 'SFVELASCO@GMAIL.COM', NULL, '160158840', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARCELA PAZ', 'SANTANA JARA', 'MARCELA.SANTANA@USACH.CL', NULL, '176731303', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIÁN ALEJANDRO', 'ARAYA MORALES', 'SEBASTIAN.ARAYAM@USACH.CL', NULL, '174875642', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FABIÁN ANDRÉS', 'ARISMENDI FERRADA', 'FABIAN.ARISMENDI@USACH.CL', NULL, '169410313', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODOLFO', 'CONCHA  HERNÁNDEZ', 'RGCONCHA@VTR.NET', NULL, '120101099', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LEONARDO', 'ORTIZ CARTES', 'LEO9.ORTIZ@GMAIL.COM', NULL, '11266789K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DELGADO', 'JUAN PADILLA', 'JUAN.PADILLA@USACH.CL', NULL, '164182169', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SOLANGE', 'ALEGRIA PARADA', 'SOLANGE.ALEGRIA@GMAIL.COM', NULL, '143418700', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SERGIO', 'GONZALEZ CELIS', 'SERGIOP.GONZALEZ@GMAIL.COM', NULL, '126644930', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE ANDRÉS', 'NANJARI FUENTES', 'FNANJARI@SANTANDER.CL', NULL, '155667885', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('YERKO ESTEBAN', 'PALMA SERRANO', 'YERKO.PALMA@USACH.CL', NULL, '175433406', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOSÉ EDUARDO', 'PÉREZ MOYA', '', '', '158433761', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PABLO', 'RIQUELME JOFRE', 'ROCKELME@GMAIL.COM', NULL, '121018071', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTIAN FELIPE', 'VALDÉS ROMERO', 'CRISTIAN.VALDESR@USACH.CL', NULL, '166606322', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ANDREA', 'YAÑEZ GALLEGOS', 'ANDREAYG@GMAIL.COM', NULL, '13471476K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALFONSO', 'HENRÍQUEZ HANDY', '', '12312312', '172288987', '', NULL, NULL);
INSERT INTO alumno VALUES ('JOSE', 'ZUARES NARBONA', '', '', '123961846', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('VICTOR', 'CRESPO ASTUDILLO', 'SIVCRESPO@GMAIL.COM', '', '11480715K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO DE JESÚS', ' VÁSQUEZ FERNÁNDEZ', 'MAILTO:RODRIGO.VASQUEZFF@USACH.CL', NULL, '164115267', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('IVAN ANDRES', 'ABARCA BAVESTRELLO', 'IVAN.ABARCA@USACH.CL', NULL, '173102771', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MAURICIO', 'ACEVEDO CÁCERES', 'MAILTO:MAURICIO.ACEVEDOC@USACH.CL', NULL, '160193379', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JORGE LUIS', 'ACUÑA ROJAS', 'MAILTO:JORGE.ACUNA@USACH.CL', NULL, '16633277K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GERARDO ROBERTO', 'ALONSO MELLADO', 'HIALEK@GMAIL.COM', NULL, '168401795', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PAZ CAROLINA', 'BUSTOS MENA', 'PAZ.BUSTOS.M@GMAIL.COM', NULL, '174865744', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE IGNACIO', 'BUSTOS PONCE', 'FEIPE.BUSTOSP@GMAIL.COM', NULL, '166489229', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CARLA SOPHIA', 'CÁCERES MAURICIO', 'CARLA.CACERES.M@GMAIL.COM', NULL, '14059203K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ESTEBAN', 'CAMPOS VALENZUELA', 'ESTEBAN.CAMPOS@USACH.CL', NULL, '167834566', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SALVADOR', 'CORTÉS CATALÁN', 'MAILTO:SALVADOR.CORTESC@USACH.CL', NULL, '161509299', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ANDY CRISTOPHER', 'CULLACHE GARRIDO', 'MAILTO:ANDY.CULLACHE@USACH.CL', NULL, '172562752', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('HÉCTOR ANDRÉS', 'ECHEVERRÍA QUINTANILLA', 'HECTOR.ECHEVERRIA@USACH.CL', NULL, '158896222', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ERWIN', 'FUENTEALBA GUARDIOLA', 'FUENTEALBA.ERWIN@GMAIL.COM', NULL, '151765637', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE', 'GARRIDO FREDES', 'FELIPE.GARRIDO.F@GMAIL.COM', NULL, '169428182', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALONSO ALBERTO', 'GONZALEZ OTAROLA', 'MAILTO:ALONSO.GONZALEZOT@USACH.CL', NULL, '154010335', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FREDDY ANDRES', 'GUZMAN TABILO', 'FREDDY.GUZMAN@USACH.CL', NULL, '171219698', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FRANCISCO ALEXIS', 'HERNÁNDEZ VILLAGRA', 'FRANCISCO.HERNANDEZV@USACH.CL', NULL, '169849900', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ENRIQUE CESAR', 'JOPIA QUILODRÁN', 'MAILTO:ENRIQUEJOPIAQ@GMAIL.COM', NULL, '157002880', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTOPHER ESTEBAN', 'LEIVA ARAVENA', 'CRISTOPHER.LEIVAA@GMAIL.COM', NULL, '173796773', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GABRIELA VICTORIA', 'LEÓN FLORES', 'GABRIELA.LEON@USACH.CL', NULL, '174043221', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALVARO', 'MALDONADO PINTO', 'ALVARO.MALDONADO1988@GMAIL.COM', NULL, '169074526', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALVARO IGNACIO', 'MENDEZ BRINCK', 'ALVARO.MEDEZB@USACH.CL', NULL, '16556717K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('BRUCE ELDA', 'MOGOLLONES', 'ELDAMB@GMAIL.COM', NULL, '72002393', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FABIÁN WILLIAM', 'MOLINS JARA', 'MAILTO:FWMOLINS@GMAIL.COM', NULL, '166912644', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CHRISTIAN', 'MONTIEL SIERRALTA', 'CMONSIER@VTR.NET', NULL, '107046844', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN', 'NECULQUEO LLANCO', 'JNECULQUEO@GMAIL.COM', NULL, '11473909K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CAROLINA FABIOLA', 'ORREGO VERGARA', 'CAROLINA.ORREGO.VERGARA@GMAIL.COM', NULL, '167395333', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE', 'QUIROZ BECERRA', 'MAILTO:FELIPE.QUIROZ@GMAIL.COM', NULL, '139056736', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CARLOS ALBERTO', 'RIVERA VALENZUELA', 'MAILTO:CARLOS.RIVERA.VALENZUELA@GMAIL.COM', NULL, '156976261', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CÉSAR ANTONIO', 'SILVA CORNEJO', 'MAILTO:CESAR.SILVA@USACH.CL', NULL, '166054109', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FAVIO ENRIQUE', 'ZUÑIGA SOTO', 'MAILTO:FAVIO.ZUNIGA@GMAIL.COM', NULL, '168849516', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('EDUARDO ALFREDO', 'LAGOS ROSALES', 'EDUARDO.LAGOS@USACH.CL', NULL, '173387903', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JAVIER ALFONSO', 'CÁCERES MIÑO', 'JAVIER.CACERESM@USACH.CL', NULL, '174112924', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('VIVIANA ALEJANDRA', 'CARO CARDENAS', 'MAILTO:VIVIANA.CARO@USACH.CL', NULL, '166099838', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('HÉCTOR OSCIEL', 'HERRERA VILLAVICENCIO', 'MAILTO:HETOR.HERRERAVIL@USACH.CL', NULL, '165707036', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('BASTIAN ANDRES', 'CABRERA ESPINOZA', 'BASTIAN.CABRERA@USACH.CL', NULL, '174890412', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SARAI', 'MARAMBIO MORALES', 'SARAI.MARAMBIO@GMAIL.COM', NULL, '180963820', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JEFFERSON ESTEBAN', 'MORALES DE LA PARRA', 'JEFF_MDE@HOTMAIL.COM', NULL, '161670960', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LUIS FELIPE', 'SÁNCHEZ GUDENSCHWAGER', 'LUIS.SANCHEZGU@USACH.CL', NULL, '97829736', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ESTEBAN OMAR', 'MANOSALVA RODRIGUEZ', 'MAILTO:ESTEBAN.MANOSALVA@USACH.CL', NULL, '161163813', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SUSANA', 'PALACIOS PIZARRO', 'SUSANA.PALACIOS@USACH.CL', NULL, '16955594K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CHRISTOPHER BAYRON', 'URRUTIA MESSINA', 'CHRISTOPHER.URRUTIA@USACH.CL', NULL, '171754755', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PATRICIO HERIBERTO', 'ALVAREZ URZUA', 'MAILTO:PATRICIO@HOTMAIL.COM', NULL, '163215454', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALEJANDRO ANDRÉS', 'CONTRERAS ZUÑIGA', 'MAILTO:ALEJANDRO.CONTRERASZ@USACH.CL', NULL, '17325752K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARCIA ANDREA', 'DURÁN RIVEROS', 'MAILTO:MDURANRIV@GMAIL.COM', NULL, '156612529', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GUILLERMO ANTONIO', 'GAMBOA RAMÍREZ', 'GUILO32@HOTMAIL.COM', '', '162648640', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('VICTOR MANUEL', 'NARANJO PEREZ', 'MAILTO:VICTOR.NARANJO@USACH.CL', NULL, '137750406', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('IVÁN', 'RIQUELME GAMONAL', '', '', '92174379', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DANILO', 'ABURTO VIVIANS', 'DANILO@REQUIES.CL', NULL, '179043939', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOSÉ LUIS', 'ALLENDE REIHER', 'MAILTO:JOSELUISAR20@GMAIL.COM', NULL, '158407337', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FABRIZIO', 'BARISIONE BISO', '', '', '150881609', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOSÉ ', 'DE LA FUENTE LORCA', 'MAILTO:FDELAFUENTE.LC@GMAIL.COM', NULL, '166612799', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('VÍCTOR MANUEL', 'FLORES SÁNCHEZ', 'VICTOR.FLORESS@USACH.CL', NULL, '175657436', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTIAN', 'GIHA SEPULVEDA', 'MAILTO:CRISTIAN.GIHA@USACH.CL', NULL, '171464765', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODDY BENJAMÍN', 'GONZÁLEZ GARCÉS', 'RODDY.GONZALEZ@USACH.CL', NULL, '171002761', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('HECTOR ALEXANDER', 'LAGOS PÉREZ', 'MAILTO:HECTOR.LAGOS@USACH.CL', NULL, '168396449', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE', 'TORRES ROJAS', '', '', '143831639', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN PABLO', 'VERDEJO JORQUERA', 'JUAN.VERDEJO@USACH.CL', NULL, '171907233', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LUIS ANTONIO', 'VILLAGRÁN PAREDES', 'MAILTO:LUIS.VILLAGRAN@GMAIL.COM', NULL, '155648511', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIÁN SANTIAGO', 'VIZCAY DERZA', 'SEBASTIAN.VIZCAY@USACH.CL', NULL, '171052386', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('VICTOR MANUEL', 'BAEZA RAMÍREZ', 'VBAEZ001@CODELCO.CL', NULL, '142035928', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOSÉ LUIS', 'CANDIA FIGUEROA', 'JOSELUISCANDIA.F@GMAIL.COM', NULL, '166171644', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIÁN GABRIEL', 'GONZÁLEZ SALAZAR', 'METALHYOGA@GMAIL.COM', NULL, '168401264', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO ANDRES', 'HENRIQUEZ RAMOS', 'MAILTO:RODRIGO.HENRIQUEZR@USACH.CL', NULL, '139047788', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MIGUEL ÀNGEL', 'HERNÀNDEZ PONCE', 'MAILTO:MIGUEL.HERNANDEZP@USACH.CL', NULL, '173249616', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO PATRICIO', 'MIRANDA CÁRDENAS', 'RODRIGO.MIRANDACA@USACH.CL', NULL, '170842804', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE ALONSO', 'MONROY SÁEZ', 'MAILTO:FELIPE.MONROY@USACH.CL', NULL, '166928370', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('YANINA ELIZABETH', 'OVANDO GUERRERO', 'YANINA.OVANDO@USACH.CL', NULL, '176314141', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALFREDO EDUARDO', 'PLATA ARANCIBIA', 'ALFREDOPLATAA@GMAIL.COM', NULL, '136865250', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JAIME', 'SAEZ POBLETE', 'JAIME.SAEZ.POBLETE@GMAIL.COM', NULL, '16171898K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIAN IGNACIO', 'STUARDO VILCHES', 'SEBASTIAN.STUARDO@USACH.CL', NULL, '166632749', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ARNOLDO FABIÁN', 'VALENZUELA', '', '', '16939816K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CARLOS MATIAS', 'VILCHES MANDIOLA', 'CARLOS.VILCHES@USACH.CL', NULL, '170721993', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CARLOS ANDRÉS', 'PÉREZ ROJAS', 'CARLOS.PEREZRO@USACH.CL', NULL, '181181486', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FRANCISCA', 'ALVAREZ MADRID', 'F.ALVAREZ.MADRID@GMAIL.COM', NULL, '158384043', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARÍA DEL ROSARIO', 'BERRUETA GONZÁLEZ', 'MAILTO:MARI.BERRUETA@HOTMAIL.COM', NULL, '170508157', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MAURICIO LEONEL', 'CARÚS FLORES', 'MAILTO:MCARUSF@GMAIL.COM', NULL, '161915602', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('OSCAR FELIPE', 'CASTILLO BORQUEZ', 'MAILTO:STEALTH_ASSASSINS@HOTMAIL.COM', NULL, '166602181', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MAURO', 'CONTRERAS BEHRENS', 'MAILTO:MAURO.BEHRENS@GMAIL.COM', NULL, '170630025', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FRANCISCO', 'DÍAZ GONZÁLEZ', 'PANCHOLOLIN@GMAIL.COM', NULL, '153400253', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('NIKOL DANIELA', 'LIBERONA ARAYA', 'MAILTO:H2ZIRAX@YAHOO.COM', NULL, '163578476', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FERNANDO', 'MEZA ZAMORA', '', '', '170256158', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('EDUARDO ANDRÉS', 'MIRANDA PEREIRA', 'MAILTO:EDUARDO.MIRANDAPE@USACH.CL', NULL, '162156055', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARIA CRISTINA', 'NARANJO ROJAS', 'MAILTO:MARIA.NARANJO@USACH.CL', NULL, '165570820', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('WALDO IGNACIO', 'ORTEGA OLAVE', 'MAILTO:WALDOHADES@GMAIL.COM', NULL, '170052781', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO ARMANDO', 'QUINTEROS MAULEN', 'RODRIGO.QUINTEROSM@USACH.CL', NULL, '159166422', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MANUEL ERNESTO', 'RAMÍREZ CALDERÓN', 'MAILTO:MANUEL.ERC@GMAIL.COM', NULL, '172135528', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('HUMBERTO DARÍO', 'RIVERA GUTIERREZ', 'MAILTO:HUMBERTO.RIVERA@USACH.CL', NULL, '167995314', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('IVAN', 'ROJAS MARCHANT', 'IVAN.ROJAS@USACH.CL', NULL, '141610120', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOSÉ ALEJANDRO', 'ROJAS RAMOS', 'MAILTO:JOSE.ROJAS.RAMOS@GMAIL.COM', NULL, '158385686', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('IGNACIO IVAN', 'SANCHEZ FABRE', 'MAILTO:ISANCHEZFABRE@HOTMAIL.COM', NULL, '171212243', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('IVÁN ANDRÉS', 'SILVA CORNEJO', 'IVANSILVAC@GMAIL.COM', NULL, '160076747', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALEJANDRO ALFREDO', 'TRUAN GRANDÓN', 'MAILTO:ALEJANDRO.TRUAN@GMAIL.COM', NULL, '152509022', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GERARDO JORGE', 'VILLARROEL GONZALEZ', 'VILLARROEL.GJ@GMAIL.COM', NULL, '153877009', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('EDUARDO', 'ZÚÑIGA JOFRÉ', 'MAILTO:EDUARDO.ZUNIGA.J@GMAIL.COM', NULL, '161168440', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOSÉ ', 'CABRERA BRAVO', '78349616', NULL, '184407604', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MAURICIO', 'ASTORGA ORELLANA', 'ASTORGALORD@GMAIL.COM', '', '169113823', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JORGE FRANCISCO', 'CABEZAS MORALES', 'JORGE.CABEZAS@USACH.CL', NULL, '169561249', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE ALBERTO', 'OLIVARES GUARDA', 'MAILTO:FELIPE.OLIVARES.GUARDA@GMAIL.COM', NULL, '162430947', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FERNANDO EUSEBIO', 'ORMEÑO CEBALLO', 'MAILTO:FERNANDO.ORMENO.C@GMAIL.COM', NULL, '162433903', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MANUEL FELIPE', 'ROJAS MARTINEZ', 'MAILTO:MANUEL.ROJAS.M@GMAIL.COM', NULL, '162774778', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MIGUEL ANGEL', 'SALOM SALAS', 'MAILTO:MIGUEL.SALOM.S@GMAIL.COM', NULL, '153182051', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FERNANDO', 'CARVAJAL ARAYA', 'FDOCARVAJAL@GMAIL.COM', NULL, '10797136K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GERARDO', 'CONTRERAS MARDONES', 'GERARDO.CM@GMAIL.COM', NULL, '130555292', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JORGE ANDRÉS', 'MEYNARD PONTANILLA', 'JORGE.MEYNARD@GMAIL.COM', NULL, '130594220', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN CARLOS', 'MONSALVE SAEZ', 'JCMONSALVE@NEOINGEN.CL', NULL, '126560028', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('BRAIHAM', 'TAPIA GONZALEZ', 'BRAIHAM.TAPIAG@USACH.CL', NULL, '165393678', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN OSVALDO', 'TORRES TOLEDO', 'MAILTO:JUANO.TORRES@GMAIL.COM', NULL, '162696513', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MATIAS FELIPE', 'BOBADILLA DÍAZ', 'MAILTO:MAT.BOBADILLA@GMAIL.COM', NULL, '173110189', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ÁLVARO', 'CÁCERES ULLOA', 'A.CACERES.U@GMAIL.COM', NULL, '165385454', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FABIAN', 'CONTRERAS PICHUANTE', 'CONTRERAS.PICHUANTE.FABIAN@GMAIL.COM', NULL, '163107155', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CLAUDIA', 'SILVA MARTINEZ', 'CLAUDITS@GMAIL.COM', NULL, '151265588', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('KARYL ALFREDO', 'VÁSQUEZ SOLÍS', 'KARYLVASQUEZ@GMAIL.COM', NULL, '141749579', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('IGNACIO JAVIER', 'VILLARROEL SÁNCHEZ', 'MAILTO:GATREVOLUTION@GMAIL.COM', NULL, '167883273', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('BELGICA', ' SANHUEZA MONTECINO', 'MAILTO:BELGICA.SAHUEZA@GMAIL.COM', NULL, '16121874K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FERNANDO', 'BRICEÑO GÓMEZ', '', '', '101426750', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LUIS ALBERTO', 'CONTRERAS SALINAS', 'LUISC.USACH@GMAIL.COM', NULL, '143771512', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RENE', 'DIAZ PADILLA', 'RENE.DIAZ@USACH.CL', NULL, '66163636', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DAVID', 'ESPINOZA ROJAS', '', '', '166944589', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ESTEBAN', 'GONZALEZ RIVEROS', 'EGON27@GMAIL.COM', '', '143404773', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JAVIER', 'HENRIQUEZ AHUMADA', '', '', '153150958', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JORGE', 'HERRERA  PINTO', 'JHERRERAPINTO@GMAIL.COM', '', '132541159', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARCELO', 'MAULÉN MUÑOZ', 'MARCELO.MAULEN@GMAIL.COM', NULL, '15890828k', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTIÁN', 'POBLETE VOGT', 'CRISTIAN.VOGT@GMAIL.COM', NULL, '135486108', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN PABLO', 'REYES SEPÚLVEDA', 'JUAN.P.REYES.S@GMAIL.COM', '', '128773843', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JORGE', 'RIVERA BURGOS', 'JRIVERA110@GMAIL.COM', NULL, '139141628', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LINO ALFREDO', 'ROBLEDO CERDA', 'LINO_ROBLEDO@HOTMAIL.COM', NULL, '143180646', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RICARDO', 'RUBIO RIVEROS', 'RRUBIO@CODELCO.CL', NULL, '106677514', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTIAN', 'SILVA PONCE', 'CRISTIAN.SILVAPO@USACH.CL', '', '16178883K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ESTEFANIA PAZ', 'TEJOS ARAYA', 'MAILTO:ESTEFANIA.TEJOS@USACH.CL', NULL, '167485081', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('VÍCTOR EZEQUIEL', 'VÁSQUEZ SAAVEDRA', 'EZEQUIEL77@TUTOPIA.COM', NULL, '132803188', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE', 'ALTAMIRANO ABURTO', 'FELIPE.ALTAMIRANO.PET2012@GMAIL.COM', NULL, '138381072', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARCIAL NATALIO', 'HERNÁNDEZ SÁNCHEZ', 'MARCIALHS@GMAIL.COM', NULL, '173865090', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIÁN EDUARDO', 'MALDONADO DURÁN', 'SEBMALDO@GMAIL.COM', NULL, '15068143K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARIA ESTER', 'SOTO BURGOS', 'MARIASOTO@DELOITTE.COM', NULL, '139060806', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CARLOS', 'TORRES PEREZ', 'CARLOS.TORRES@USACH.CL', NULL, '151737943', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ANDREA DEL PILAR ', 'ANTOINE ROJO', '', '', '156039020', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JAINZ DIETRICH JOSE', 'DE LA ROSA DONOSO', '', '', '138819280', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('KIRA LESLIE', 'ESPINA SUÁREZ', 'MAILTO:KIRA.ESPINA@GMAIL.COM', NULL, '141976974', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ESTEBAN', 'GOMEZ LILLO', '', '', '139371127', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOSÉ LUIS', 'NÚÑEZ DÍAZ', 'MAILTO:JOSENUNEZDIAZ@GMAIL.COM', NULL, '158377365', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('OSCAR', 'PINTO SALAZAR', '', '', '130680526', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('XIMENA', 'VASQUEZ TOBAR', 'XIMENA.VASQUEZ@CARABINEROS.CL', '', '134405155', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('NICOLÁS ENRIQUE', 'AROS FUENTES', 'NICOLAS.AROS@USACH.CL', NULL, '169087350', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JAVIER DAVID', 'BRAVO VALDIVIA', 'JAVIER.BRAVOV@USACH.CL', NULL, '173819803', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALVARO', 'BUSTAMANTE FUENTES', 'ALVARO.BUSTAMANTE@USACH.CL', NULL, '169039682', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PAZ LETICIA', 'CABEZAS GUERRERO', 'MAILTO:PAZ.CABEZAS@USACH.CL', NULL, '172552609', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTOPHER NELSON', 'DEL POZO CATALAN', 'MAILTO:CRISTOPHER.DELPOZO@USACH.CL', NULL, '172320104', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JEAN PIERRE', 'DÍAZ BRAVO', 'JEAN.DIAZ@USACH.CL', NULL, '141234153', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('NICOLÁS ALFONSO', 'GARCÍA OLATE', 'MAILTO:NICOLAS.GARCIA.O@GMAIL.COM', NULL, '163867052', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JONATHAN ANDRÉS', 'GARRIDO PINTO', 'MAILTO:BLACK.KAPO@GMAIL.COM', NULL, '16569953K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO', 'MUÑOZ LIZAMA', 'MAILTO:RODRIGO.MUNOZLIZ@USACH.CL', NULL, '156434027', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CLAUDIO NICOLÁS', ' ROJAS FUENTEALBA', 'CLAUDIO.ROJASF@YSACH.CL', NULL, '170291220', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JAVIER ALEJANDRO', 'PARRA GARRIDO', 'JAVIER.PARRA@USACH.CL', NULL, '172510957', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GERARDO DAVID', 'PEREIRA DE LA HOZ', 'MAILTO:GERARDO.PEREIRA@USACH.CL', NULL, '159598314', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE JAVIER', 'PIÑEIRO POBLETE', 'FELIPE.PINEIRO@USACH.CL', NULL, '172974325', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTHIAN ANDRES', 'PLAZA IBARRA', 'MAILTO:CPLAZA@HOTMAIL.COM', '', '151049486', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JORGE BERMECIDES', 'SALAZAR CASTRO', 'JORGE.SALAZAR@USACH.CL', NULL, '170289943', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GABRIEL ANTONIO', 'SALAZAR MORENO', 'GABRIEL.SALAZAR@USACH.CL', NULL, '173028318', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GUILLERMO', 'SANTANDER LEÓN', 'GUILLERMO.SANTANDER@GMAIL.COM', NULL, '166096502', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('IGNACIO EXEQUIEL ', 'SARAVIA REYES', 'IGNACIO.SARAVIA@USACH.CL', NULL, '180762353', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PAZ MILLARAY', 'TOBAR MIRA', 'MAILTO:PAZ.TOBARM@USACH.CL', NULL, '170483685', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIÁN ANTONIO', 'VALDES DONOSO', 'SEBASTIAN.VALDESD@USACH.CL', NULL, '173900996', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PABLO IGNACIO', 'DONOSO CASTRO', 'PABLO.DONOSOCA@USACH.CL', NULL, '164729931', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RENE', 'CHANDIA NAVARRO', 'RCHN1925@GMAIL.COM', NULL, '122596451', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DANIELA CONSTANZA', 'QUIROZ CARRASCO', 'MAILTO:DANI.QUIROZ@GMAIL.COM', NULL, '166570727', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALVARO ALEJANDRO', 'SALAS AVILA', 'ALVARO.SALAS@USACH.CL', NULL, '169102627', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ROBERTO', 'VALDERRAMA CORTES', 'RVALDCORT@GMAIL.COM', NULL, '123957016', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOSÉ CRISTÓBAL', ' ACEVEDO CAVIERES', '', '', '160319135', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JEANS ANDREE', ' LÓPEZ DUCHENS', 'MAILTO:JEANS.LOPEZ.D@GMAIL.COM', NULL, '158932121', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FABIAN', ' TELLO DÍAZ', 'FTELLODIAZ@GMAIL.COM', NULL, '168036639', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ROBERTO', 'AROS ANGULO', 'ROBERTOAROSA@USACH.CL', NULL, '135237566', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DANIEL', 'BRAVO DIAZ', 'DANIEL.BRAVO.DIAZ@GMAIL.COM', '', '153447586', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CLAUDIO', 'BUSTAMANTE ARRIAGADA', 'MAILTO:CLAUDIO.BUSTAMANTE.A@GMAIL.COM', '', '159975509', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MAURICIO', 'CAMPOS RIVERA', 'MACAMPOSR@GMAIL.COM', '', '129799927', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GUILLERMO', 'CANCINO GARATE', 'GUILLERMO.CANCINO@GMAIL.COM', '', '119905621', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RICHARD ALEJANDRO', 'CASAS FARIAS', 'RICHARD.CASAS@GMAIL.COM', NULL, '155885173', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FRANCISCO JOSE', 'DIAZ NEIRA', 'FRANCISCO.DIAZN@USACH.CL', NULL, '126355971', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('BLADIMIR ALEXIS', 'FLORES GATICA', 'BLADIMIR.FLORES@USACH.CL', NULL, '118425480', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CARLOS MANUEL', 'GARCIA CARRASCO', 'MAILTO:CARLOS.GARCIACA@USACH.CL', NULL, '161173800', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ESTEBAN', 'HOLTHEUER ROJAS', 'ESTEBAN.HOLTHEUER@GMAIL.COM', NULL, '169592306', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('NICOLÁS', 'HUERTA FUENTES', 'NICOLAS.HUERTA@USACH.CL', NULL, '172683843', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE', 'LAGOS BECERRA', 'FLAGOSB@GMAIL.COM', '', '102607376', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SERGIO', 'MIRANDA VALDES', 'SERGIO.MIRANDA@EQUIFAX.CL', '', '156663859', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE', 'MOLINA GONZALEZ', '', '', '155446099', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIAN', 'OPAZO PALOMINO', 'MAILTO:SEBASTIANOPAZO@GMAIL.COM', NULL, '164735737', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIÁN EMILIO', 'ORELLANA CASANOVA', 'SEBASTIAN.ORELLANAC@GMAIL.COM', NULL, '163549239', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('BRUCES', 'PIÑA JARA', '', '', '141968092', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JORGE EDUARDO', 'REBOLLEDO GONZÁLEZ', 'JORGE.REBOLLEDO@USACH.CL', NULL, '179512130', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CARLOS ROBERTO', 'RIVAS CONEJERO', '', '', '16375228K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LORETO ISABEL', 'RODRIGUEZ CORREA', 'MAILTO:LORETO.RODRIGUEZ@USACH.CL', NULL, '171663741', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LEONARDO', 'ROJO AHUMADA', 'LEOROJOAHU@YAHOO.COM', NULL, '98953051', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('NELSON ALEJANDRO', 'ULLOA QUINTANA', 'NELSON.ULLOA@ENDESA.ES', NULL, '139147820', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RAUL', 'VARGAS PEREZ', 'RAUL.VARGAS@VTR.NET', '', '122550915', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JAIME', 'VIDAL OLIVA', '', '', '126305478', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALVARO', 'ZUÑIGA CABEZAS', 'MAILTO:ALVARO.ZUNIGACA@USACH.CL', NULL, '157559281', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FERNANDO', ' GONZÁLEZ CASTRO', 'FERNANDO.CONZALEZCAS@USACH.CL,  FERNANDO.GONZALEZCAS@USACH.CL', NULL, '151138853', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTÓBAL ALEJANDRO', 'ACOSTA JURADO', 'MAILTO:CRISTOBAL.ACOSTA@USACH.CL', NULL, '163601311', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JORGE ANDRES', 'BOURGUET BARRIGA', 'MAILTO:JORGECROSS3@HOTMAIL.COM', NULL, '171679249', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTIAN ANDRES', 'BRAVO PETRICIC', 'MAILTO:CPETRICIC@GMAIL.COM', NULL, '170215710', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTIAN', 'CORNEJO LUENGO', 'CRISTIAN.CORNEJO@USACH.CL', NULL, '175975721', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CAMILO', 'FARFÁN PÉREZ', 'CAMILO.FARFAN@USACH.CL', NULL, '171509688', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RUBÉN LEANDRO', 'FIGUEROA NAHUELPI', 'RUBEN.FIGUEROA@USACH.CL', NULL, '165626826', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE ANTONIO', 'IRIBARREN VIERTEL', 'MAILTO:FELIPE.IRIBARREN@GMAIL.COM', NULL, '161561444', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALDO ALEX', 'JIMENEZ ALEGRE', 'MAILTO:ALDO.JIMENEZ.A@GMAIL.COM', NULL, '141645064', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CAMILO FABIÁN', 'MUÑOZ SILVA', 'MAILTO:CAMILO.MUÑOZS@USACH.CL', NULL, '167891497', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARÍA JOSÉ', 'OSORIO SOTO', 'MARIA.OSORIOS@USACH.CL', NULL, '167998186', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FABIÁN ESTEBAN', 'PARRA MESSINA', 'MAILTO:FABIAN.PARRAM@USACH.CL', NULL, '173169906', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DANIEL IGNACIO', 'PAVEZ SANDOVAL', 'MAILTO:DANIEL.PAVEZ@USACH.CL', NULL, '164780430', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DANIEL ANDRES', 'SOTO CASTRO', 'DANIEL.SOTO.CASTRO@GMAIL.COM', NULL, '130597572', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('IBER SEBASTIÁN', 'ÁLVARES DÍAZ', 'IBERALVAREZ@YAHOO.ES', NULL, '154841970', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('EDISON JOHN', 'ARAYA GONZÁLEZ', 'MECI2009@YAHOO.COM', NULL, '120324314', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LEONARDO', 'CABRERA LOBOS', 'LCABRERA@AMERICAECONOMIA.COM', NULL, '159674290', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ADRIÁN ERNESTO', 'CONTRERAS ROMO', 'MAILTO:ADRIAN.CONTRERAS@USACH.CL', NULL, '164324206', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('NICOLÁS ELÍAS', 'FIGUEROA MATEO', 'NICOLAS.FIGUEROAMA@USACH.CL', NULL, '163652838', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOSE', 'GOMEZ JOFRE', 'FELIX_GJ2003@HOTMAIL.COM', NULL, '134428244', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DIEGO ANTONIO', 'GUTIERREZ MOLINA', 'MAILTO:DIEGO.GUTIERREZM@USACH.CL', NULL, '174176264', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE ANTONIO', 'MACHUCA SAN JUAN', 'MAILTO:FELIPE.MACHUCA@USACH.CL', NULL, '170309545', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LUIS FRANCISCO', 'MALDONADO SALAZAR', 'MAILTO:LUISEVERNET@GMAIL.COM', NULL, '169847029', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CAROLINA ANDREA', 'MARTÍNEZ PÉREZ DE ARCE', 'CMARTINEZP.00@GMAIL.COM,"CAROLINA.MARTINEZP@USACH.CL")', NULL, '167441823', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALBERTO DANIEL', 'OCHOA JOHN JUAN', 'MAILTO:DOCHOAJ@GMAIL.COM', NULL, '174052255', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ANDRES', 'ROJAS PARDO RODRIGO', 'MAILTO:RODRIGO.ROJASP@USACH.CL', NULL, '173136986', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FRANCISCO JAVIER', 'SAENZ TOBAR', 'MAILTO:SAENZJ@GMAIL.COM', NULL, '163225816', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('EMILIO', 'TAPIA SANHUEZA', 'MAILTO:EMILIO.TAPIA@USACH.CL', NULL, '168039891', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ORLANDO ANDRÉS', 'VELÁSQUEZ CÓRDOBA', 'OVCORDOBA@GMAIL.COM', '', '160081937', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PEDRO', 'VENEGAS SANTIBAÑEZ', 'PEDRO.VENEGAS@GMAIL.COM', NULL, '141861239', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOSÉ DANIEL', 'ORELLANA NÚÑEZ', 'JOSE.ORELLANAN@USACH.CL', NULL, '170222156', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PAOLA IGNACIA', 'ARMIJO TORRES', 'MAILTO:PAOLA.ARMIJO@USACH.CL', NULL, '167432530', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GONZALO CAMILO', 'DÍAZ CRUZ', 'MAILTO:GONZALO.DIAZCRU@USACH.CL', NULL, '165319559', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('HÉCTOR GERARDO', 'FUENTES GAETE', '', '', '167485405', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('NICOLAS', 'GAJARDO AEDO', 'NICOLAS.GAJARDOA@USACH.CL', NULL, '169969329', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARCELA PAZ', 'GIL SANHUEZA', 'MARCELA.GIL@USACH.CL', NULL, '163219689', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARIANO PATRICIO', 'GONZALEZ NUÑEZ', 'MAILTO:MARIANO.G.N@HOTMAIL.COM', NULL, '167282032', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DANIEL', 'HIDALGO PINTO', 'DANIEL.HIDALGO@GMAIL.COM', '', '130441793', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN ANDRÉS', 'LEVICHE HUILIPÁN', 'MAILTO:JLEVICHE@GMAIL.COM', NULL, '164751392', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTIAN ANDRÉS', 'LÓPEZ NÚÑEZ', 'CRISTIAN_ALN@HOTMAIL.COM', NULL, '16612106K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RICARDO', 'LOPEZ SOT', 'RJLOPEZS@GMAIL.COM', NULL, '132575568', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MIGUEL ÁNGEL', 'MORAGA ALCAINO', 'MAILTO:MIGMORAGA@GMAIL.COM', NULL, '166810388', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SUN-HO', 'NOH', 'SUNNOH@GMAIL.COM', NULL, '145012163', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PAULO IGNACIO', 'PAILLACAR OYARZO', 'PAULO.PAILLACAR@USACH.CL', NULL, '167472982', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RAFAEL', 'PALOMINO ROJAS', 'R.PALOMINO.ROJAS@GMAIL.COM', NULL, '167116116', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SANDRA', 'SAAVEDA VERGARA', 'S.SAAVEDRA.V@GMAIL.COM', NULL, '105018274', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CLAUDIA ANDREA', 'SEPÚLVEDA SALFATE', 'MAILTO:CLAUDIA.SEPULVEDA.S@GMAIL.COM', NULL, '161240176', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DORIS', 'SOTO AGUIRRE', 'DORISSOTOA@GMAIL.COM', NULL, '9998998K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GABRIEL ÁNGEL', 'TAMAYO LEIVA', 'GABRIEL.TAMAYO@LIVE.CL', NULL, '176675459', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE', 'TAPIA ARACENA', 'FELIPE.TAPIAA@USACH.CL', NULL, '167463479', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JORGE GUILLERMO', 'TOBAR VALLADARES', 'JORGE.TOBAR@USACH.CL', NULL, '167460003', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JONATHAN', 'UMAÑA RAMÍREZ', 'JONATHAN.UMANAR@USACH.CL', NULL, '164910652', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GERARDO', 'URETA QUEVEDO', 'GURETAQ@GMAIL.COM', NULL, '83157739', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('NATALIA', 'VARAS RIVERA', 'VARASSR@GMAIL.COM', NULL, '170631129', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DAVID IGNACIO', 'AGUILAR BORNE', 'DAVID.AGUILAR@USACH.CL', NULL, '169448264', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('VICTOR MANUEL', 'BARRA BUSTAMANTE', 'MAILTO:BALROG687@GMAIL.COM', NULL, '164792560', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DIEGO ESTEBAN', 'BERRÍOS AGUIRRE', 'DIEGO.BERRIOS@USACH.CL', NULL, '174044953', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('VICENTE', 'BRAVO PRIDA', 'VICENTE.BRAVO@USACH.CL', NULL, '174424977', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JORGE ALBERTO', 'CÁRCAMO BUSTAMANTE', '', '', '170505727', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALEX IGNACIO', 'CARRASCO BARRAS', 'MAILTO:ALEX.CARRASCO@GMAIL.COM', NULL, '156646636', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALEJANDRO JOSÉ', 'CISTERNA VILLALOBOS', 'MAILTO:ALEJANDRO.CISTERNA@USACH.CL', NULL, '167391753', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PAULINA BÁRBARA', 'GALLARDO GRANDÓN', 'PAULINA.GGRANDON@GMAIL.COM', NULL, '17850620K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CLAUDIO IGNACIO', 'GALLARDO MILLAR', 'MAILTO:CLAUDIO.GALLARDO@USACH.CL', NULL, '168409974', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LUCIANO', 'HIDALGO SEPÚLVEDA', 'MAILTO:LUCIANO.HIDALGO@USACH.CL', NULL, '167497578', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MAURICIO ANDRÉS', 'MATURANA SANDOVAL', 'MAURICIO.MATURANA@HOTMAIL.COM', NULL, '167464181', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ROBERTO JULIO', 'MOYA SUAREZ', 'ROBERTO.MOYA.SUAREZ@GMAIL.COM', NULL, '169197342', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTOPHER', 'MUÑOZ SANDOVAL', 'TOPHER182@GMAIL.COM', NULL, '167476171', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE', 'PÁEZ RODRÍGUEZ', 'FELIPE.PAEZR@HOTMAIL.COM', NULL, '170286499', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JULIO ALEJANDRO', 'PARRAO BUSCHMANN', 'MAILTO:JPARRAOB@GMAIL.COM', NULL, '160687975', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SIMÓN IGNACIO', 'RODRÍGUEZ ARANDA', 'SIMON.RODRIGUEZ@USACH.CL', NULL, '173093403', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('NICOLE', 'SANHUEZA HINOJOSA', 'NICOLE.SANHUEZA@USACH.CL', NULL, '176744499', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTIAN', 'SEPÚLVEDA SANCHEZ', 'CRANSEPULVEDA@GMAIL.COM', NULL, '132527121', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('NICOLÁS PATRICIO', 'SOTO CALDERÓN', 'NICOLAS.SOTOS@USACH.CL', '', '165702867', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CÉSAR ANDRÉS', 'STUARDO MORAGA', 'MAILTO:CESAR.STUARDO@USACH.CL', NULL, '162850350', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARCELO', 'VASQUEZ VASQUEZ', 'NYCOMVV@HOTMAIL.COM', NULL, '120472003', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CAMILA ALEJANDRA', 'CASTILLO GUTIÉRREZ', 'CAMILA.CASTILLO@USACH.CL', NULL, '174866309', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JORGE ANDRÉS ALBERTO', 'FIGUEROA GONZÁLEZ', 'JORGE.FIGUEROAGO@USACH.CL', NULL, '174256346', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALEX PATRICIO', 'AHUMADA AHUMADA', 'ALEX.AHUMADA@USACH.CL', NULL, '172427545', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CAMILA FERNANDA', 'TORRES VILLANUEVA', 'CAMILA.TORRESV@USACH.CL', NULL, '175340718', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CAMILO ANDRÉS', 'CORREA RUZ', 'CAMILO.CORREA.RUZ@GMAIL.COM', NULL, '174888817', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JAIME', ' SÁEZ POBLETE', '', '', '16171898k', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO ANDRÉS', 'CASTRO SANTANA', 'MAILTO:RCASTR83@GMAIL.COM', NULL, '155661569', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ROBINSON ALEJANDRO', 'GARRIDO FIGUEROA', 'ROBINSON.GARRIDO@GMAIL.COM', '', '134897384', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CAROLINA ANDREA', 'MALEBRAN QUIROGA', 'CAROLINA.MALEBRAN.Q@GMAIL.COM', NULL, '101489736', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO HERNÁN', 'PALMA CONTRERAS', 'RHPALMAC@GMAIL.COM,', NULL, '132601305', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('NICOLAS CAMILO', 'ACEITUNO LEIVA', 'NICOLAS.ACEITUNO@GMAIL.COM', NULL, '172508782', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DANIEL', 'WLADDIMIRO COTTET', 'DANIEL.WLADDIMIRO@USACH.CL', NULL, '182940933', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GONZALO', 'ARAYA REYES', 'GARAYA.REYES@GMAIL.COM', '', '153503583', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOSE', 'CAPDEVILLE PEREZ', '', '', '101113515', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PAOLO ENRIQUE', 'CEPEDA ROJAS', 'PCEPEDA@MMM.COM', NULL, '123894960', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JULIO', 'DELGADO PUEBLA', 'JULIODELGA@GMAIL.COM', NULL, '142527847', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ERICK', 'HECHT LOPEZ', 'ERICK.HECHT@GMAIL.COM', '', '132136106', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FERNANDO', 'LAZZARICH MEZA', '', '', '130557333', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARÍA GABRIELA', 'LÓPEZ BARRAZUETA', 'GABRIELA.LOPEZ.B@GMAIL.COM', NULL, '147365403', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN', 'MOLINA VERA', 'JAMOLINAV@GMAIL.COM', '', '142432722', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('BERNABE', 'PEREZ PAILLAMIL', 'BERNA@BROWSE.CL', '', '130476716', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PABLO ', 'QUIROZ CARREÑO', 'PBQUIROZ@GMAIL.COM', '', '139368142', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ARIEL', 'SAAVEDRA GARÍN', 'MAILTO:ARIEL.SAAVEDRA@USACH.CL', NULL, '171204593', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN', 'VALENZUELA VENEGAS', 'JUAN.VALENZUELA@USACH.CL', NULL, '120580094', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PABLO', 'VILCHES RODRIGUEZ', 'PABLO.VILCHES@GMAIL.COM', '', '130273513', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALEXIS', 'YÁÑEZ HORMAZÁBAL', '', '', '137465493', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MIRTA', 'CHANDIA MARECHAL', 'MIRTACHANDIA@GMAIL.COM', '', '12236299K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARCELO', 'CORDERO JULIO', 'MARCELOCORDEROJULIO@GMAIL.COM', '', '111690871', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DANIEL ANDRÉS', 'NAVARRO BRITO', 'DANIEL.NAVARRO.BRITO@GMAIL.COM', NULL, '164273008', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('HERNAN', 'OLAVARRIA VENEGAS', '', '', '141928664', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('IVAN', 'PEREZ PANTOJA', '', '', '118453816', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MIGUEL ANGEL', 'POBLETE ESCALONA', 'MAPOBLETE2005@GMAIL.COM', '', '126776691', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALEJANDRO', 'ROMERO POBLETE', '', '', '07364058K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CARLOS ALFREDO', 'BARRERA PULGAR', 'CARLOS.BARRERAP@USACH.CL', NULL, '17705318K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO HERNÁN', 'CIFUENTES RUIZ', 'RODRIGO.CIFUENTES@USACH.CL', NULL, '174859329', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ESTEBAN ANDRÉS', 'CONTARDO PÉREZ', 'ESTEBAN.CONTARDO@USACH.CL', NULL, '176233516', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('AILEEN', 'ESPARZA VILLAMÁN', 'AILEEN.ESPARZA@USACH.CL', NULL, '176641959', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GARY IGNACIO', 'FUENZALIDA NAVARRETE', 'GARY.FUENZALIDA@USACH.CL', NULL, '17490314K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('NICOLÁS EMILIO', 'MONTENEGRO VARELA', 'NICOLAS.MONTENEGRO@USACH.CL', '', '180550321', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOSÉ LUIS', 'VARELA OTÁROLA', 'JOSE.VARELA@USACH.CL', NULL, '176013435', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN CARLOS', 'VARGAS GODOY', 'JUAN.VARGAS@USACH.CL', NULL, '174269211', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MATÍAS NICOLÁS', 'GARCÍA VERDUGO', 'MANIGAVE@GMAIL.COM', NULL, '175333967', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO ANDRÉS', 'MONSALVE LAGOS', 'RODRIGO.MONSALVEL@USACH.CL', NULL, '176717890', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO', 'BARRIENTOS BELTRAN', '', '', '116474042', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('IGNACIO JAVIER', 'ECHEGOYEN BATHICH', 'MAILTO:IGNACIO.ECHEGOYEN@USACH.CL', NULL, '17084405K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RUBÉN ANDRÉ', 'ITURRIETA SEPÚLVEDA', 'MAILTO:RUBEN.ITURRIETA@USACH.CL', NULL, '174273944', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALEX CRISTIAN', 'OBREGÓN GALAZ', 'MAILTO:ALEXR.67@GMAIL.COM', NULL, '161280070', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JERSON ANTONIO', 'ORTIZ SILVA', 'MAILTO:JERSON.ORTIZ@GMAIL.COM', NULL, '161469912', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTIAN', 'ACEVEDO FUENZALIDA', 'CRISTIAN.ACEVEDO@USACH.CL', NULL, '169033188', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FABIÁN IGNACIO', 'ACUÑA FLORES', 'FABIAN.ACUNAF@USACH.CL', NULL, '166484588', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ANDREA CECILIA', 'ALARCON SOTO', 'MAILTO:ACAS_MG2004@HOTMAIL.COM', NULL, '157724282', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALLISON CRISTINA', 'ALBORNOZ BARRA', 'MAILTO:ALLISON.ALBORNOZ@GMAIL.COM', NULL, '156430579', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE ALEXIS', 'ALFARO MUÑOZ', 'MAILTO:FELIPE.ALFAROM@USACH.CL', NULL, '17372098K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LUCIANO', 'ARANCIBIA VALENZUELA', 'PIERROT.72@GMAIL.COM', NULL, '173549849', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RENÉ PATRICIO', 'ARNÉS ARNÉS', 'RENE.ARNES@USACH.CL', NULL, '175646736', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('HANS KEVIN', 'AUZIAN CASTRO', 'HANS.AUZIAN@USACH.CL', '', '176683007', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('HECTOR GUILLERMO', 'AYET CERNA', 'HECTOR.AYET@GMAIL.COM', NULL, '94928400', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LUIS', 'BARASSI MALDONADO', 'MAILTO:LUIS.BARASSI@USACH.CL', NULL, '160895683', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DANIEL GUSTAVO', 'BARRIA CONCHA', 'MAILTO:DANIELBC@GMAIL.COM', NULL, '153742642', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIÁN ALEJANDRO', 'BEAS HIDALGO', 'SEBASTIAN.BEAS@GMAIL.COM', NULL, '164336646', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO', 'BRIONES SEPULVEDA', 'RBRIONES@GMAIL.COM', NULL, '132455252', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN PABLO', 'CÓRDOBA VARGAS', 'MAILTO:JUAN.CORDOVA.VARGAS@GMAIL.COM', NULL, '156394165', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTOBAL', 'DEL FIERRO BERRIOS', 'CRISTOBAL.DELFIERROB@GMAIL.COM', NULL, '182100625', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DIEGO ESTEVAN', 'DURÁN LÓPEZ', 'DIEGO.DURAN@USACH.CL', NULL, '165308697', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MIGUEL ANGEL', 'ELEMATORE CARRASCO', 'MIGUEL_ELEMATORE@YAHOO.ES', NULL, '158323486', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN PABLO', 'FLORES VARGAS', 'MAILTO:JP.FLORESV@GMAIL.COM', NULL, '166401313', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PEDRO ALFONSO', 'FUENTEALBA MARTÍNEZ', 'PAFM2006@GMAIL.COM', NULL, '90073648', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN JOSE', 'FUENTES GONZALEZ', 'MAILTO:JUANJOTOPER@HOTMAIL.COM', NULL, '141871331', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ELOY', 'GALLEGOS OLIVARES', 'ELOY.GALLEGOS@USACH.CL', NULL, '166183383', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PATRICIO EDUARDO', 'GARRIDO BARRA', 'PATRICIOGARRIDOBARRA@GMAIL.COM', NULL, '173132387', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LUIS IGNACIO', 'GARRIDO PARDO', 'LUIS.GARRIDOP@USACH.CL', NULL, '172571182', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('EDGAR OLADIO', 'GATICA MARTINEZ', 'EDGAR.GATICA@USACH.CL', NULL, '171895723', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('VIVIANA CAROLINA', 'GONZÁLEZ HERRERA', 'VIVIANA.GONZALEZH@USACH.CL', NULL, '167182952', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CAMILO ANDRÉS', 'HENRIQUEZ MENA', 'CAMILO.HENRIQUEZ.MENA@GMAIL.COM', NULL, '156491373', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('LUIS FERNANDO', 'HERNÁNDEZ HERNÁNDEZ', 'MAILTO:IFHERNANDEZH@GMAIL.COM', NULL, '154680756', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ANTONIO ALESSANDRO', 'IBÁÑEZ BENDEZÚ', 'ANTONIO.IBANEZ@USACH.CL', NULL, '147074220', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DIEGO JOSÉ', 'JAUME GUAZZINI', 'DIEGO.JAUME@USACH.CL', NULL, '174025282', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTIAN ANDRÉS', 'LARCO LIZAMA', 'CRISTIAN.LARCO@GMAIL.COM', NULL, '163589419', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIÁN', 'LEIVA GULPPI', 'MAILTO:SHEBA_LEIVA@HOTMAIL.COM', NULL, '167454761', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JUAN PABLO', 'LEÓN ARCE', 'IKERUX@GMAIL.COM', NULL, '168553439', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MIGUEL', 'MALDONADO ALGUERNA', 'MAILTO:MIGUEL.MALDONADO@USACH.CL', NULL, '163725886', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MIGUEL ÁNGEL', 'MEJÍAS SÁEZ', 'MAILTO:MIGUELMEJIAS10@GMAIL.COM', NULL, '164174034', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARTA ISABEL', 'MENESES SEPULVEDA', 'MARTA.MENESES@USACH.CL', NULL, '17414852K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('OSCAR ALEJANDRO', 'MOLINA LEIVA', 'MAILTO:OSCAR.MOLINAL@GMAIL.COM', NULL, '158369346', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CARLOS MANFRED', 'MORALES GÓMEZ', 'CMANFREDM@GMAIL.COM', NULL, '141545914', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO ANDRÉS', 'MORALES MEDINA', '', '', '161974579', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARCO', 'MORALES PINCHEIRA', 'MARCOMORALESP@GMAIL.COM', NULL, '139154673', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTIAN ALEJANDRO', 'MUÑOZ GUAJARDO', 'MAILTO:CRISTIAN.MUNOZ.G@HOTMAIL.COM', NULL, '159005577', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CARLOS JAVIER', 'MUÑOZ NAVARRETE', 'CMUNOZN@LIVE.CL', NULL, '120041282', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PABLO ANDRÉS', 'MURGA SALVATIERRA', 'PABLO.MURGA@USACH.CL', '', '180830936', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FABIÁN ANDRÉS', 'NARANJO BUSTAMANTE', 'MAILTO:NARANJO.FABIAN@GMAIL.COM', NULL, '161483419', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('NICOLÁS NAZRÉ', 'NASER ABARZÚA', 'NICOLAS.NASER@USACH.CL', NULL, '177406538', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MIGUEL ANGEL', 'NAVARRO CERECEDA', 'MAILTO:MIGUEL.NAVARROC@USACH.CL', NULL, '159301567', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALMA', 'NEGRETE SHEN', 'ALMANEGRETESHEN@GMAIL.COM', NULL, '160794321', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODEN', 'OLIVEROS VIDAL', 'RODEN.OLIVEROS@USACH.CL', NULL, '169325421', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CAROLINA PAZ', 'OSORIO FAURÉ', 'MAILTO:CAROLINA_OSORIO_FAURE@HOTMAIL.COM', NULL, '164730271', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JONNATAN WASHINGTON', 'OYARZÚN RODRIGUEZ', 'MAILTO:JONSXAERO@GMAIL.COM', NULL, '161989495', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTOPHER HERNÁN', 'PEREIRA SANDOVAL', 'CRISTOPHER.PEREIRAS@GMAIL. COM', NULL, '18049152K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTOBAL', 'PEREZ VASQUEZ', 'CRISTOBAL.PEREZ@USACH.CL', NULL, '162121774', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PABLO IGNACIO', 'PULGAR LÓPEZ', 'PULGAO10@GMAIL.COM', NULL, '163827255', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DANIELA CONSTANZA', 'QUIROZ CARRASCO', 'DANI.QUIROZ@GMAIL.COM', NULL, '166570722', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO', 'RAMIREZ GARZO', 'RODRIGORAMI@GMAIL.COM', NULL, '128108408', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PRISCILLA', 'READI ANANIAS', 'PRISCYREADI@GMAIL.COM', NULL, '136874667', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOSE MIGUEL', 'REMOLCOY VELASQUEZ', 'JOSE.REMOLCOYV@USACH.CL', NULL, '16385788K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GONZALO ALEJANDRO', 'ROCO DÍAZ', 'MAILTO:GONZALO.ROCO@USACH.CL', NULL, '167404855', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GONZALO', 'ROJAS MONTIEL', 'GONZALO.ROJASMO@USACH.CL', NULL, '160265353', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO', 'SANDOVAL TEJERINA', 'MAILTO:SANDOVAL622@HOTMAIL.COM', NULL, '160208619', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JOSÉ MANUEL', 'VALDIVIESO OYARCE', 'MAILTO:JOSE.VALDIVIESOO@GMAIL.COM', NULL, '158366037', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO ANDRÉS', 'YÁÑEZ GUTIÉRREZ', 'RODRIGO.YANEZGUSACH.CL', NULL, '144878552', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PEDRO CAMILO', 'ROJAS BERIESTAIN', 'PEDRO.ROJASB@USACH.CL', NULL, '171891841', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FELIPE ANDRÉS', 'VALENZUELA HERNÁNDEZ', 'FELIPE.VALENZUELAH@USACH.CL', NULL, '169772835', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JAVIER ALONSO', 'CAMPOS OLGUÍN', 'JAVIER.CAMPOSO@USACH.CL', NULL, '166398703', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('VÍCTOR', 'REYES TAPIA', '', '', '176782765', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DIEGO', 'GÓMEZ LIRA', 'DIEGOG.ASD@GMAIL.COM', NULL, '169402035', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MIGUEL ANGEL', 'JARA RODRÍGUEZ', 'MIGUEL.JARA.RODRIGUEZ@GMAIL.COM', NULL, '170054989', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('BYRON', 'LANAS LAFERTTE', 'BYRON.LANAS@USACH.CL', NULL, '166078482', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARCELO', 'MADARIAGA MORENO', 'MARCELO.MADARIAGAM@USACH.CL', NULL, '169033285', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DANIEL IGNACIO', 'QUINTEROS CÉSPEDES', 'DANIEL.QUINTEROSC@USACH.CL', NULL, '174276471', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PATRICIO ENRIQUE', 'TOLEDO CHAMORRO', 'PATRICIO.TOLEDO@USACH.CL', NULL, '170865510', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FRANCISCO JAVIER', 'ABARZA RIFFO', 'MAILTO:FABARZAR@GMAIL.COM', NULL, '160080280', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MAURICIO ADOLFO', 'ACEVEDO RUBIO', 'MAURICIO.ACEVEDO@USACH.CL', NULL, '128712135', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('VALERIA ANDREA', 'ASENCIO CUELLAR', 'VALERIA.ASENCIO@USACH.CL', NULL, '176303034', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GONZALO', 'BARRA RIVAS', 'GONZALO.BARRA@USACH.CL', NULL, '171893798', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTIAN', 'BASTIAS INOSTROZA', 'CRISTIAN.BASTIAS@GMAIL.COM', '', '130727859', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('VITTORIO ', 'BERTOLINI ONOFRI', 'VBERTOLINI@GMAIL.COM', NULL, '166070201', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CAIO FERNANDO', 'BEZARES MACHADO', 'CAIO.BEZARES@USACH.CL', NULL, '179475634', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DIEGO', 'CADIZ PAU', 'DIEGO.CADIZ@USACH.CL', NULL, '160170166', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ANTONIO', 'FIGUEROA SEPULVEDA', 'ANTONIO.FIGUES@GMAIL.COM', NULL, '181652497', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ALVARO FELIPE', 'FLORES JIMÉNEZ', 'MAILTO:AFFLORES@GMAIL.COM', NULL, '159172090', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DIEGO ANTONIO', 'FLORES SALDAÑO', 'DIEGOX.LIGHT@GMAIL.COM', NULL, '158422867', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARIO ANTONIO', 'GACITÚA LÓPEZ', 'MAILTO:MARIO.GACITUA.L@GMAIL.COM', NULL, '169215219', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RICARDO', 'GUASCH ZUÑIGA', 'RGUASCH@GMAIL.COM', NULL, '153811229', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MAXIMILIANO', 'HERNÁNDEZ SAN MARTÍN', 'MAXIMILIANO.HERNANDEZ@USACH.CL', NULL, '183017578', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JULIO ENRIQUE', 'HINOJOSA GALINDO', 'KJULIO.HINOJOSA@USACH.CL', NULL, '174746761', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('FRANCISCO JAVIER', 'IBACACHE MUÑOZ', 'MAILTO:FRANCISCO.IBACACHE.MUNOZ@GMAIL.COM', NULL, '159598373', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('RODRIGO ANÍBAL', 'JARA CARTAGENA', 'RODRIGO.JARA@USACH.CL', NULL, '165581555', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('JORGE ALFREDO', 'LIZAMA GALARCE', 'MAILTO:JORGE.LIZAMAG@GMAIL.COM', NULL, '167959008', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CRISTIAN IGNACIO', 'LOYOLA VALDIVIA', 'CRISTIAN.LOYOLA@USACH.CL', NULL, '180977104', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MARCELO ALEJANDRO', 'MEIXNER BEJAR', 'MAILTO:MARCELO.MEIXNER@USACH.CL', NULL, '161365475', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIÁN LEONARDO', 'MIRANDA OSORIO', 'MAILTO:SEBASTIAN.MIRANDAO@USACH.CL', NULL, '164120538', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MAXIMILIANO PABLO', 'PALERMO', 'MAXIMILIANO.PALERMO@USACH.CL', NULL, '145981859', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIÁN ALEJANDRO', 'PARADA RAMOS', 'MAILTO:SEBASTIAN.PARADA@GMAIL.COM', NULL, '160186801', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('IGNACIO', 'PEÑA SEPULVEDA', 'IGNACIO.PENA87GMAIL.COM', NULL, '166579643', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MACARENA', 'PÉREZ SEPÚLVEDA', 'MACARENA.PEREZ@USACH.CL', NULL, '172717144', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIÁN', 'QUEZADA  GONZÁLEZ', 'MAILTO:SEBASTIAN.QUEZADAG@USACH.CL', NULL, '166156971', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('PEDRO PAULO', 'QUIROZ ARAYA', '', '', '153480389', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('VICTOR ROLANDO', 'RAMOS BENITO', 'MAILTO:VICTORRAMOSB@GMAIL.COM', NULL, '164740773', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SERGIO', 'RAMOS COSSIO', 'SRAMOS.USACH@YAHOO.COM', '', '114651214', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CARLOS ROGRIGO', 'REY BARRA', 'MAILTO:CARLOS.REYB@USACH.CL', NULL, '173771955', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('IVÁN', 'RIQUELME GAMONAL', 'IGAMONAL@HOTMAIL.COM', '', '092174379', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MIGUEL ANGEL', 'SALAZAR LÓPEZ', 'MIGUEL.SALAZAR.LOPEZ@GMAIL.COM', NULL, '166166454', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('CAMILO IGNACIO', 'SOTO CÁCERES', 'CAMILO.SOTO@USACH.CL', NULL, '169428166', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('GUSTAVO ARTURO', 'SOTO CERNA', 'GUSTAVO.SOTO@USACH.CL', NULL, '158207664', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('DIEGO', 'SOTO JARA', 'DIEGO.FRIEDMAN@GMAIL.COM', NULL, '15366708K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SERGIO ANDRÉS', 'VALENZUELA PÉREZ', 'MAILTO:SERGIO.VALENZUELAP@GMAIL.COM', NULL, '163905140', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('MACARENA SOLEDAD', 'VERGARA CONCHA', 'MAILTO:MACARENA.VERGARA@USACH.CL', NULL, '171100062', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('NICOLÁS ALFREDO', 'ACEVEDO URZÚA', 'NICOLAS.ACEVEDOU@USACH.CL', NULL, '173196474', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ÁLVARO ', 'FELMER PIZARRO', '', '', '17919998k', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('ADRIÁN ', 'GARRIDO GOICOVIC', '27892430', NULL, '181724315', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('SEBASTIÁN ', 'ESCOBAR TRONCOSO', '86517264', NULL, '180628754', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('EDUARDO', ' PEÑA ANDRADES', '63366169', NULL, '17962091K', NULL, NULL, NULL);
INSERT INTO alumno VALUES ('WALESKA ANDREA', 'CARREÑO ARANDA', 'ASD@ASD.CL', '', '176744650', '', NULL, NULL);
INSERT INTO alumno VALUES ('GLEN ENRIQUE', 'CIFUENTES TOR', 'GLEN.CIFUENTES@GMAIL.COM', '', '167110614', '', NULL, NULL);


--
-- Data for Name: asignatura; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: asignatura_asignatura; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: asignatura_profesor; Type: TABLE DATA; Schema: public; Owner: postgres
--



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



--
-- Data for Name: checklisteventos; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: comision_correctora; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO comision_correctora VALUES (1, 'default', 1, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (2, 'default', 2, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (4, 'default', 6, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (5, 'default', 8, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (6, 'default', 11, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (7, 'default', 12, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (8, 'default', 13, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (9, 'default', 16, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (10, 'default', 22, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (11, 'default', 23, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (12, 'default', 24, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (13, 'default', 26, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (14, 'default', 31, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (15, 'default', 34, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (16, 'default', 37, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (17, 'default', 39, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (18, 'default', 42, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (19, 'default', 43, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (20, 'default', 54, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (21, 'default', 57, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (22, 'default', 59, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (23, 'default', 67, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (24, 'default', 74, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (25, 'default', 75, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (26, 'default', 77, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (27, 'default', 79, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (28, 'default', 80, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (29, 'default', 81, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (30, 'default', 82, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (31, 'default', 84, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (32, 'default', 87, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (33, 'default', 88, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (34, 'default', 89, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (35, 'default', 93, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (36, 'default', 94, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (37, 'default', 95, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (38, 'default', 96, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (39, 'default', 97, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (40, 'default', 102, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (41, 'default', 103, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (42, 'default', 105, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (43, 'default', 107, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (44, 'default', 110, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (45, 'default', 112, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (46, 'default', 113, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (47, 'default', 117, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (48, 'default', 118, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (49, 'default', 120, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (50, 'default', 126, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (51, 'default', 128, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (52, 'default', 131, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (53, 'default', 136, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (54, 'default', 139, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (55, 'default', 140, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (56, 'default', 141, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (57, 'default', 142, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (58, 'default', 144, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (59, 'default', 145, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (60, 'default', 146, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (61, 'default', 147, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (62, 'default', 152, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (63, 'default', 154, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (64, 'default', 155, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (65, 'default', 157, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (66, 'default', 159, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (67, 'default', 160, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (68, 'default', 162, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (69, 'default', 165, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (70, 'default', 169, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (71, 'default', 170, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (72, 'default', 171, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (73, 'default', 172, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (74, 'default', 174, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (75, 'default', 175, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (76, 'default', 176, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (77, 'default', 178, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (78, 'default', 179, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (79, 'default', 182, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (80, 'default', 183, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (81, 'default', 185, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (82, 'default', 197, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (83, 'default', 200, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (84, 'default', 203, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (85, 'default', 204, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (86, 'default', 205, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (87, 'default', 206, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (88, 'default', 209, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (89, 'default', 210, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (90, 'default', 215, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (91, 'default', 216, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (92, 'default', 219, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (93, 'default', 221, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (94, 'default', 223, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (95, 'default', 229, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (96, 'default', 230, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (97, 'default', 231, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (98, 'default', 232, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (99, 'default', 234, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (100, 'default', 241, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (101, 'default', 243, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (102, 'default', 244, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (103, 'default', 248, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (104, 'default', 249, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (105, 'default', 251, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (106, 'default', 252, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (107, 'default', 253, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (108, 'default', 255, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (109, 'default', 257, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (110, 'default', 260, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (111, 'default', 261, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (112, 'default', 263, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (113, 'default', 268, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (114, 'default', 269, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (115, 'default', 276, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (116, 'default', 277, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (117, 'default', 278, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (118, 'default', 279, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (119, 'default', 280, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (120, 'default', 281, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (121, 'default', 292, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (122, 'default', 297, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (123, 'default', 298, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (124, 'default', 311, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (125, 'default', 319, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (126, 'default', 321, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (127, 'default', 322, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (128, 'default', 323, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (129, 'default', 324, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (130, 'default', 329, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (131, 'default', 330, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (132, 'default', 331, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (133, 'default', 332, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (134, 'default', 333, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (135, 'default', 334, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (136, 'default', 335, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (137, 'default', 341, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (138, 'default', 342, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (139, 'default', 343, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (140, 'default', 344, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (141, 'default', 346, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (142, 'default', 348, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (143, 'default', 349, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (144, 'default', 351, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (145, 'default', 353, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (146, 'default', 358, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (147, 'default', 360, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (148, 'default', 362, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (149, 'default', 365, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (150, 'default', 366, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (151, 'default', 367, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (152, 'default', 369, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (153, 'default', 372, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (154, 'default', 373, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (155, 'default', 374, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (156, 'default', 376, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (157, 'default', 377, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (158, 'default', 378, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (159, 'default', 379, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (160, 'default', 380, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (161, 'default', 383, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (162, 'default', 384, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (163, 'default', 385, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (164, 'default', 386, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (165, 'default', 387, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (166, 'default', 389, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (167, 'default', 390, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (168, 'default', 401, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (169, 'default', 402, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (170, 'default', 403, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (171, 'default', 404, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (172, 'default', 406, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (173, 'default', 409, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (174, 'default', 411, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (175, 'default', 413, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (176, 'default', 415, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (177, 'default', 416, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (178, 'default', 420, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (179, 'default', 422, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (180, 'default', 441, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (181, 'default', 443, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (182, 'default', 444, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (183, 'default', 452, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (184, 'default', 453, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (185, 'default', 457, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (186, 'default', 458, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (187, 'default', 462, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (188, 'default', 465, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (189, 'default', 466, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (190, 'default', 467, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (191, 'default', 470, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (192, 'default', 475, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (193, 'default', 476, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (194, 'default', 479, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (195, 'default', 486, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (196, 'default', 487, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (197, 'default', 494, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (198, 'default', 496, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (199, 'default', 498, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (200, 'default', 504, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (201, 'default', 505, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (202, 'default', 506, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (203, 'default', 507, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (204, 'default', 509, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (205, 'default', 510, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (206, 'default', 512, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (207, 'default', 513, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (208, 'default', 515, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (209, 'default', 516, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (210, 'default', 519, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (211, 'default', 533, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (212, 'default', 538, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (213, 'default', 539, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (214, 'default', 540, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (215, 'default', 541, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (216, 'default', 545, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (217, 'default', 546, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (218, 'default', 550, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (219, 'default', 554, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (220, 'default', 558, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (221, 'default', 559, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (222, 'default', 561, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (223, 'default', 562, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (224, 'default', 563, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (225, 'default', 566, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (226, 'default', 567, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (227, 'default', 568, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (228, 'default', 572, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (229, 'default', 574, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (230, 'default', 576, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (231, 'default', 581, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (232, 'default', 583, NULL, NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (235, '1/2016', 592, '26/05/2015', NULL, NULL, NULL);
INSERT INTO comision_correctora VALUES (236, '1/2016', 593, '27/05/2015', '28/05/2015', NULL, NULL);
INSERT INTO comision_correctora VALUES (237, '1/2016', 594, '15/05/2015', '16/05/2015', NULL, NULL);
INSERT INTO comision_correctora VALUES (238, '1/2016', 596, '28/05/2015', '29/05/2015', NULL, NULL);
INSERT INTO comision_correctora VALUES (239, '1/2016', 595, '15/05/2015', '16/05/2015', NULL, NULL);
INSERT INTO comision_correctora VALUES (240, '1/2016', 598, '20/05/2015', '20/05/2015', '28/05/2015', '28/05/2015');
INSERT INTO comision_correctora VALUES (3, 'default', 5, '20/05/2015', '21/05/2015', '21/05/2015', '20/05/2015');
INSERT INTO comision_correctora VALUES (233, '1/2016', 7, '12/05/2015', '20/05/2015', '28/05/2015', '27/05/2015');
INSERT INTO comision_correctora VALUES (242, '1/2016', 597, '08/06/2015', '17/06/2015', '10/06/2015', '08/06/2015');


--
-- Name: comision_correctora_id_correctora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comision_correctora_id_correctora_seq', 242, true);


--
-- Data for Name: comision_revisora; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO comision_revisora VALUES ('', NULL, 1, 1, 'default', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 122, 123, 'default', 122, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 2, 2, 'default', 2, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 3, 3, 'default', 3, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 123, 124, 'default', 123, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 4, 4, 'default', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 5, 5, 'default', 5, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 124, 125, 'default', 124, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 6, 6, 'default', 6, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 7, 7, 'default', 7, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 125, 126, 'default', 125, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 8, 8, 'default', 8, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 9, 9, 'default', 9, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 126, 127, 'default', 126, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 10, 10, 'default', 10, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 11, 11, 'default', 11, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 127, 128, 'default', 127, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 12, 12, 'default', 12, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 13, 13, 'default', 13, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 128, 129, 'default', 128, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 14, 14, 'default', 14, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 15, 15, 'default', 15, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 129, 130, 'default', 129, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 16, 16, 'default', 16, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 17, 17, 'default', 17, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 18, 18, 'default', 18, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 19, 19, 'default', 19, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 20, 20, 'default', 20, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 21, 21, 'default', 21, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 22, 22, 'default', 22, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 23, 23, 'default', 23, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 24, 24, 'default', 24, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 25, 25, 'default', 25, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 26, 26, 'default', 26, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 27, 27, 'default', 27, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 28, 28, 'default', 28, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 29, 29, 'default', 29, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 30, 30, 'default', 30, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 31, 31, 'default', 31, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 32, 32, 'default', 32, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 33, 33, 'default', 33, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 34, 34, 'default', 34, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 35, 35, 'default', 35, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 36, 36, 'default', 36, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 37, 37, 'default', 37, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 38, 38, 'default', 38, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 39, 39, 'default', 39, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 40, 40, 'default', 40, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 41, 41, 'default', 41, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 42, 42, 'default', 42, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 43, 43, 'default', 43, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 44, 44, 'default', 44, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 45, 45, 'default', 45, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 46, 46, 'default', 46, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 47, 47, 'default', 47, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 48, 48, 'default', 48, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 49, 49, 'default', 49, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 50, 50, 'default', 50, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 51, 51, 'default', 51, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 52, 52, 'default', 52, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 53, 53, 'default', 53, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 54, 54, 'default', 54, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 55, 55, 'default', 55, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 56, 56, 'default', 56, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 57, 57, 'default', 57, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 58, 58, 'default', 58, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 59, 59, 'default', 59, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 60, 60, 'default', 60, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 61, 61, 'default', 61, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 62, 63, 'default', 62, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 63, 64, 'default', 63, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 64, 65, 'default', 64, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 65, 66, 'default', 65, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 66, 67, 'default', 66, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 67, 68, 'default', 67, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 68, 69, 'default', 68, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 69, 70, 'default', 69, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 70, 71, 'default', 70, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 71, 72, 'default', 71, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 72, 73, 'default', 72, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 73, 74, 'default', 73, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 74, 75, 'default', 74, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 75, 76, 'default', 75, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 76, 77, 'default', 76, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 77, 78, 'default', 77, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 78, 79, 'default', 78, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 79, 80, 'default', 79, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 80, 81, 'default', 80, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 81, 82, 'default', 81, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 82, 83, 'default', 82, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 83, 84, 'default', 83, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 84, 85, 'default', 84, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 85, 86, 'default', 85, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 86, 87, 'default', 86, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 87, 88, 'default', 87, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 88, 89, 'default', 88, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 89, 90, 'default', 89, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 90, 91, 'default', 90, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 91, 92, 'default', 91, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 92, 93, 'default', 92, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 93, 94, 'default', 93, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 94, 95, 'default', 94, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 95, 96, 'default', 95, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 96, 97, 'default', 96, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 97, 98, 'default', 97, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 98, 99, 'default', 98, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 99, 100, 'default', 99, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 100, 101, 'default', 100, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 101, 102, 'default', 101, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 102, 103, 'default', 102, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 103, 104, 'default', 103, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 104, 105, 'default', 104, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 105, 106, 'default', 105, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 106, 107, 'default', 106, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 107, 108, 'default', 107, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 108, 109, 'default', 108, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 109, 110, 'default', 109, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 110, 111, 'default', 110, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 111, 112, 'default', 111, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 112, 113, 'default', 112, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 113, 114, 'default', 113, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 114, 115, 'default', 114, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 115, 116, 'default', 115, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 116, 117, 'default', 116, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 117, 118, 'default', 117, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 118, 119, 'default', 118, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 119, 120, 'default', 119, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 120, 121, 'default', 120, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 121, 122, 'default', 121, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 130, 131, 'default', 130, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 131, 132, 'default', 131, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 132, 133, 'default', 132, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 133, 134, 'default', 133, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 134, 135, 'default', 134, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 135, 136, 'default', 135, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 136, 137, 'default', 136, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 137, 138, 'default', 137, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 138, 139, 'default', 138, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 139, 140, 'default', 139, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 140, 141, 'default', 140, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 141, 142, 'default', 141, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 142, 143, 'default', 142, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 143, 144, 'default', 143, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 144, 145, 'default', 144, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 145, 146, 'default', 145, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 146, 147, 'default', 146, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 147, 148, 'default', 147, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 148, 149, 'default', 148, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 149, 150, 'default', 149, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 150, 151, 'default', 150, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 151, 152, 'default', 151, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 152, 153, 'default', 152, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 153, 154, 'default', 153, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 154, 155, 'default', 154, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 155, 156, 'default', 155, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 156, 157, 'default', 156, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 157, 158, 'default', 157, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 158, 159, 'default', 158, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 159, 160, 'default', 159, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 160, 161, 'default', 160, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 161, 162, 'default', 161, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 162, 163, 'default', 162, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 163, 164, 'default', 163, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 164, 165, 'default', 164, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 165, 166, 'default', 165, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 166, 167, 'default', 166, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 167, 168, 'default', 167, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 168, 169, 'default', 168, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 169, 170, 'default', 169, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 170, 171, 'default', 170, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 171, 172, 'default', 171, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 172, 173, 'default', 172, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 173, 174, 'default', 173, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 174, 175, 'default', 174, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 175, 176, 'default', 175, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 176, 177, 'default', 176, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 177, 178, 'default', 177, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 178, 179, 'default', 178, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 179, 180, 'default', 179, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 180, 181, 'default', 180, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 181, 182, 'default', 181, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 182, 183, 'default', 182, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 183, 184, 'default', 183, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 184, 185, 'default', 184, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 185, 186, 'default', 185, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 186, 187, 'default', 186, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 187, 188, 'default', 187, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 188, 189, 'default', 188, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 189, 190, 'default', 189, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 190, 191, 'default', 190, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 191, 192, 'default', 191, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 192, 193, 'default', 192, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 193, 194, 'default', 193, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 194, 195, 'default', 194, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 195, 196, 'default', 195, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 196, 197, 'default', 196, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 197, 198, 'default', 197, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 198, 199, 'default', 198, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 199, 200, 'default', 199, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 200, 201, 'default', 200, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 201, 202, 'default', 201, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 202, 203, 'default', 202, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 203, 204, 'default', 203, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 204, 205, 'default', 204, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 205, 206, 'default', 205, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 206, 207, 'default', 206, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 207, 208, 'default', 207, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 208, 209, 'default', 208, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 209, 210, 'default', 209, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 210, 211, 'default', 210, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 211, 212, 'default', 211, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 212, 213, 'default', 212, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 213, 214, 'default', 213, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 214, 215, 'default', 214, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 215, 216, 'default', 215, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 216, 217, 'default', 216, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 217, 218, 'default', 217, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 218, 219, 'default', 218, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 219, 220, 'default', 219, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 220, 221, 'default', 220, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 221, 222, 'default', 221, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 222, 223, 'default', 222, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 223, 224, 'default', 223, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 224, 225, 'default', 224, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 225, 226, 'default', 225, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 226, 227, 'default', 226, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 227, 228, 'default', 227, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 228, 229, 'default', 228, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 229, 230, 'default', 229, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 230, 231, 'default', 230, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 231, 232, 'default', 231, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 232, 233, 'default', 232, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 233, 234, 'default', 233, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 234, 235, 'default', 234, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 235, 236, 'default', 235, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 236, 237, 'default', 236, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 237, 238, 'default', 237, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 238, 239, 'default', 238, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 239, 240, 'default', 239, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 240, 241, 'default', 240, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 241, 242, 'default', 241, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 242, 243, 'default', 242, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 243, 244, 'default', 243, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 244, 245, 'default', 244, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 245, 246, 'default', 245, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 246, 247, 'default', 246, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 247, 248, 'default', 247, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 248, 249, 'default', 248, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 249, 250, 'default', 249, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 250, 251, 'default', 250, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 251, 252, 'default', 251, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 252, 253, 'default', 252, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 253, 254, 'default', 253, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 254, 255, 'default', 254, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 255, 256, 'default', 255, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 256, 257, 'default', 256, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 257, 258, 'default', 257, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 258, 259, 'default', 258, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 259, 260, 'default', 259, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 260, 261, 'default', 260, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 261, 262, 'default', 261, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 262, 263, 'default', 262, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 263, 264, 'default', 263, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 264, 265, 'default', 264, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 265, 266, 'default', 265, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 266, 267, 'default', 266, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 267, 268, 'default', 267, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 268, 269, 'default', 268, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 269, 270, 'default', 269, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 270, 271, 'default', 270, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 271, 272, 'default', 271, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 272, 273, 'default', 272, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 273, 274, 'default', 273, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 274, 275, 'default', 274, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 275, 276, 'default', 275, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 276, 277, 'default', 276, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 277, 278, 'default', 277, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 278, 279, 'default', 278, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 279, 280, 'default', 279, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 280, 281, 'default', 280, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 281, 282, 'default', 281, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 282, 283, 'default', 282, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 283, 284, 'default', 283, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 284, 285, 'default', 284, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 285, 286, 'default', 285, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 286, 287, 'default', 286, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 287, 288, 'default', 287, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 288, 289, 'default', 288, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 289, 290, 'default', 289, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 290, 291, 'default', 290, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 291, 292, 'default', 291, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 292, 293, 'default', 292, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 293, 294, 'default', 293, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 294, 295, 'default', 294, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 295, 296, 'default', 295, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 296, 297, 'default', 296, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 297, 298, 'default', 297, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 298, 299, 'default', 298, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 299, 300, 'default', 299, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 300, 301, 'default', 300, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 301, 302, 'default', 301, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 302, 303, 'default', 302, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 303, 304, 'default', 303, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 304, 305, 'default', 304, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 305, 306, 'default', 305, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 306, 307, 'default', 306, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 307, 308, 'default', 307, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 308, 309, 'default', 308, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 309, 310, 'default', 309, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 310, 311, 'default', 310, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 311, 312, 'default', 311, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 312, 313, 'default', 312, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 313, 314, 'default', 313, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 314, 315, 'default', 314, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 315, 316, 'default', 315, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 316, 317, 'default', 316, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 317, 318, 'default', 317, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 318, 319, 'default', 318, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 319, 320, 'default', 319, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 320, 321, 'default', 320, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 321, 322, 'default', 321, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 322, 323, 'default', 322, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 323, 324, 'default', 323, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 324, 326, 'default', 324, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 325, 327, 'default', 325, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 326, 328, 'default', 326, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 327, 329, 'default', 327, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 328, 330, 'default', 328, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 329, 331, 'default', 329, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 330, 332, 'default', 330, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 331, 333, 'default', 331, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 332, 334, 'default', 332, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 333, 335, 'default', 333, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 334, 336, 'default', 334, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 335, 337, 'default', 335, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 336, 338, 'default', 336, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 337, 339, 'default', 337, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 338, 340, 'default', 338, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 339, 341, 'default', 339, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 340, 342, 'default', 340, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 341, 343, 'default', 341, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 342, 344, 'default', 342, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 343, 345, 'default', 343, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 344, 346, 'default', 344, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 345, 347, 'default', 345, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 346, 348, 'default', 346, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 347, 349, 'default', 347, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 348, 350, 'default', 348, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 349, 351, 'default', 349, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 350, 352, 'default', 350, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 351, 353, 'default', 351, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 352, 354, 'default', 352, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 353, 355, 'default', 353, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 354, 356, 'default', 354, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 355, 357, 'default', 355, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 356, 358, 'default', 356, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 357, 359, 'default', 357, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 358, 360, 'default', 358, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 359, 361, 'default', 359, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 360, 362, 'default', 360, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 361, 363, 'default', 361, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 362, 364, 'default', 362, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 363, 365, 'default', 363, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 364, 366, 'default', 364, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 365, 367, 'default', 365, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 366, 368, 'default', 366, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 367, 369, 'default', 367, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 368, 370, 'default', 368, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 369, 371, 'default', 369, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 370, 372, 'default', 370, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 371, 373, 'default', 371, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 372, 374, 'default', 372, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 373, 375, 'default', 373, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 374, 376, 'default', 374, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 375, 377, 'default', 375, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 376, 378, 'default', 376, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 377, 379, 'default', 377, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 378, 380, 'default', 378, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 379, 381, 'default', 379, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 380, 382, 'default', 380, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 381, 383, 'default', 381, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 382, 384, 'default', 382, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 383, 385, 'default', 383, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 384, 386, 'default', 384, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 385, 387, 'default', 385, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 386, 388, 'default', 386, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 387, 389, 'default', 387, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 388, 390, 'default', 388, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 389, 391, 'default', 389, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 390, 392, 'default', 390, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 391, 393, 'default', 391, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 392, 394, 'default', 392, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 393, 395, 'default', 393, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 394, 396, 'default', 394, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 395, 397, 'default', 395, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 396, 398, 'default', 396, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 397, 399, 'default', 397, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 398, 400, 'default', 398, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 399, 401, 'default', 399, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 400, 402, 'default', 400, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 401, 403, 'default', 401, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 402, 404, 'default', 402, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 403, 405, 'default', 403, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 404, 406, 'default', 404, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 405, 407, 'default', 405, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 406, 408, 'default', 406, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 407, 409, 'default', 407, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 408, 410, 'default', 408, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 409, 411, 'default', 409, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 410, 412, 'default', 410, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 411, 413, 'default', 411, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 412, 414, 'default', 412, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 413, 415, 'default', 413, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 414, 416, 'default', 414, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 415, 417, 'default', 415, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 416, 418, 'default', 416, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 417, 419, 'default', 417, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 418, 420, 'default', 418, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 419, 421, 'default', 419, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 420, 422, 'default', 420, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 421, 423, 'default', 421, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 422, 424, 'default', 422, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 423, 425, 'default', 423, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 424, 426, 'default', 424, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 425, 428, 'default', 425, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 426, 429, 'default', 426, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 427, 430, 'default', 427, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 428, 431, 'default', 428, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 429, 432, 'default', 429, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 430, 433, 'default', 430, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 431, 434, 'default', 431, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 432, 435, 'default', 432, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 433, 436, 'default', 433, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 434, 437, 'default', 434, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 435, 438, 'default', 435, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 436, 439, 'default', 436, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 437, 440, 'default', 437, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 438, 441, 'default', 438, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 439, 442, 'default', 439, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 440, 443, 'default', 440, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 441, 444, 'default', 441, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 442, 445, 'default', 442, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 443, 446, 'default', 443, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 444, 447, 'default', 444, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 445, 448, 'default', 445, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 446, 449, 'default', 446, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 447, 450, 'default', 447, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 448, 451, 'default', 448, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 449, 452, 'default', 449, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 450, 453, 'default', 450, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 451, 454, 'default', 451, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 452, 455, 'default', 452, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 453, 456, 'default', 453, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 454, 457, 'default', 454, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 455, 458, 'default', 455, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 456, 459, 'default', 456, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 457, 460, 'default', 457, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 458, 461, 'default', 458, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 459, 462, 'default', 459, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 460, 463, 'default', 460, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 461, 464, 'default', 461, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 462, 465, 'default', 462, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 463, 466, 'default', 463, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 464, 467, 'default', 464, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 465, 468, 'default', 465, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 466, 469, 'default', 466, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 467, 470, 'default', 467, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 468, 471, 'default', 468, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 469, 472, 'default', 469, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 470, 473, 'default', 470, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 471, 474, 'default', 471, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 472, 475, 'default', 472, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 473, 476, 'default', 473, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 474, 477, 'default', 474, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 475, 478, 'default', 475, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 476, 479, 'default', 476, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 477, 480, 'default', 477, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 478, 481, 'default', 478, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 479, 482, 'default', 479, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 480, 483, 'default', 480, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 481, 484, 'default', 481, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 482, 485, 'default', 482, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 483, 486, 'default', 483, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 484, 487, 'default', 484, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 485, 488, 'default', 485, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 486, 489, 'default', 486, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 487, 490, 'default', 487, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 488, 491, 'default', 488, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 489, 493, 'default', 489, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 490, 494, 'default', 490, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 491, 495, 'default', 491, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 492, 496, 'default', 492, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 493, 497, 'default', 493, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 494, 498, 'default', 494, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 495, 499, 'default', 495, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 496, 500, 'default', 496, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 497, 501, 'default', 497, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 498, 502, 'default', 498, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 499, 503, 'default', 499, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 500, 504, 'default', 500, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 501, 505, 'default', 501, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 502, 506, 'default', 502, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 503, 507, 'default', 503, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 504, 508, 'default', 504, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 505, 509, 'default', 505, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 506, 510, 'default', 506, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 507, 511, 'default', 507, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 508, 512, 'default', 508, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 509, 513, 'default', 509, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 510, 514, 'default', 510, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 511, 515, 'default', 511, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 512, 516, 'default', 512, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 513, 517, 'default', 513, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES (NULL, 1, 591, 597, '1/2015', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 514, 518, 'default', 514, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES (NULL, 1, 590, 596, '1/2015', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 515, 519, 'default', 515, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES (NULL, 0, 592, 598, '1/2015', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 516, 520, 'default', 516, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES (NULL, 0, 589, 595, '1/2015', 590, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 517, 521, 'default', 517, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 518, 522, 'default', 518, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 519, 523, 'default', 519, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 520, 524, 'default', 520, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 521, 525, 'default', 521, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 522, 526, 'default', 522, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 523, 527, 'default', 523, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 524, 528, 'default', 524, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 525, 529, 'default', 525, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 526, 530, 'default', 526, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 527, 531, 'default', 527, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 528, 532, 'default', 528, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 529, 533, 'default', 529, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 530, 534, 'default', 530, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 531, 535, 'default', 531, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 532, 536, 'default', 532, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 533, 537, 'default', 533, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 534, 538, 'default', 534, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 535, 539, 'default', 535, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 536, 540, 'default', 536, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 537, 541, 'default', 537, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 538, 542, 'default', 538, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 539, 543, 'default', 539, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 540, 544, 'default', 540, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 541, 545, 'default', 541, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 542, 546, 'default', 542, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 543, 547, 'default', 543, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 544, 548, 'default', 544, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 545, 549, 'default', 545, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 546, 550, 'default', 546, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 547, 551, 'default', 547, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 548, 552, 'default', 548, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 549, 553, 'default', 549, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 550, 554, 'default', 550, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 551, 555, 'default', 551, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 552, 556, 'default', 552, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 553, 557, 'default', 553, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 554, 558, 'default', 554, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 555, 559, 'default', 555, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 556, 560, 'default', 556, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 557, 561, 'default', 557, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 558, 562, 'default', 558, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 559, 563, 'default', 559, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 560, 564, 'default', 560, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 561, 565, 'default', 561, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 562, 566, 'default', 562, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 563, 567, 'default', 563, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 564, 568, 'default', 564, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 565, 569, 'default', 565, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 566, 570, 'default', 566, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 567, 571, 'default', 567, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 568, 572, 'default', 568, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 569, 573, 'default', 569, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 570, 574, 'default', 570, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 571, 575, 'default', 571, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 572, 576, 'default', 572, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 573, 577, 'default', 573, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 574, 578, 'default', 574, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 575, 579, 'default', 575, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 576, 580, 'default', 576, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 577, 581, 'default', 577, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 578, 582, 'default', 578, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 579, 584, 'default', 579, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 580, 585, 'default', 580, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 581, 586, 'default', 581, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', NULL, 582, 587, 'default', 582, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 0, 583, 588, 'default', 583, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 584, 589, 'default', 584, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 585, 590, 'default', 585, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 586, 591, 'default', 586, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 587, 592, 'default', 587, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('', 1, 588, 593, 'default', 588, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES (NULL, 0, 594, 602, '1/2016', 592, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES (NULL, 0, 595, 603, '1/2016', 593, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('21/05/2015', 0, 596, 604, '1/2016', 594, '22/05/2015', NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('30/05/2015', 0, 597, 605, '1/2016', 595, '31/05/2015', NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('18/05/2015', 0, 599, 608, '1/2016', NULL, '19/05/2015', '27/05/2015', '28/05/2015', NULL, NULL);
INSERT INTO comision_revisora VALUES ('19/05/2015', 0, 606, 616, '1/2016', NULL, '20/05/2015', '20/05/2015', '21/05/2015', NULL, NULL);
INSERT INTO comision_revisora VALUES ('18/05/2015', 0, 598, 607, '1/2016', 596, '21/05/2015', '27/05/2015', '28/05/2015', NULL, NULL);
INSERT INTO comision_revisora VALUES (NULL, 0, 602, 612, '1/2016', 597, NULL, NULL, NULL, NULL, NULL);
INSERT INTO comision_revisora VALUES ('13/05/2015', 0, 603, 613, '1/2016', 598, '13/05/2015', '21/05/2015', '21/05/2015', NULL, NULL);
INSERT INTO comision_revisora VALUES ('19/05/2015', 0, 604, 614, '1/2016', NULL, '19/06/2015', '20/05/2015', '21/05/2015', NULL, NULL);
INSERT INTO comision_revisora VALUES ('20/05/2015', 2, 605, 615, '1/2016', NULL, '21/05/2015', '20/05/2015', '21/05/2015', NULL, NULL);


--
-- Name: comision_revisora_id_revisora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comision_revisora_id_revisora_seq', 606, true);


--
-- Data for Name: coordinacion; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: encuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: evento_asociado; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: evento_expositor; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: expositor; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: historial; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO historial VALUES ('Se le asignó Tema. Lo ingresó el usuario admin admin', '04/04/2015', '167110614', 2, 1);
INSERT INTO historial VALUES ('Ingresó Tema al alumno GLEN ENRIQUE CIFUENTES TORO', '04/04/2015', 'admin', 3, 2);
INSERT INTO historial VALUES ('Se creó el tema, con estado ''Vigente''', '14/05/2015', '589', 1, 3);
INSERT INTO historial VALUES ('Informe de Avance: El estado del tema cambió de ''Vigente'' a ''Prorrogado''', '24/04/2015', '25', 1, 4);
INSERT INTO historial VALUES ('Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin', '12/05/2015', '171818575', 2, 5);
INSERT INTO historial VALUES ('Ingresó Comisión Correctora al alumno JOAQUÍN OLIVARES DONOSO', '12/05/2015', 'admin', 3, 6);
INSERT INTO historial VALUES ('Comision Correctora: El estado del tema cambió de ''Vigente con borrador final'' a En proceso de examen', '12/05/2015', '7', 1, 7);
INSERT INTO historial VALUES ('Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin', '12/05/2015', '172288987', 2, 8);
INSERT INTO historial VALUES ('Ingresó Comisión Correctora al alumno ALFONSO HENRÍQUEZ HANDY', '12/05/2015', 'admin', 3, 9);
INSERT INTO historial VALUES ('Comision Correctora: El estado del tema cambió de ''Vigente con borrador final'' a En proceso de examen', '12/05/2015', '591', 1, 10);
INSERT INTO historial VALUES ('Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin', '15/05/2015', '159073122', 2, 11);
INSERT INTO historial VALUES ('Ingresó Comisión Correctora al alumno MANUEL ALEJANDRO ALARCON BELMAR', '15/05/2015', 'admin', 3, 12);
INSERT INTO historial VALUES ('Comision Correctora: El estado del tema cambió de ''Vigente con borrador final'' a En proceso de examen', '26/05/2015', '592', 1, 13);
INSERT INTO historial VALUES ('Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin', '15/05/2015', '128516948', 2, 14);
INSERT INTO historial VALUES ('Ingresó Comisión Correctora al alumno NAYADA HERNANDEZ OYANEDEL', '15/05/2015', 'admin', 3, 15);
INSERT INTO historial VALUES ('Comision Correctora: El estado del tema cambió de ''Vigente con borrador final'' a En proceso de examen', '27/05/2015', '593', 1, 16);
INSERT INTO historial VALUES ('Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin', '15/05/2015', '173832168', 2, 17);
INSERT INTO historial VALUES ('Ingresó Comisión Correctora al alumno HERNANDO ANDRES MANRIQUEZ NAVARRO', '15/05/2015', 'admin', 3, 18);
INSERT INTO historial VALUES ('Comision Correctora: El estado del tema cambió de ''Vigente con borrador final'' a En proceso de examen', '15/05/2015', '594', 1, 19);
INSERT INTO historial VALUES ('Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin', '15/05/2015', '166257344', 2, 20);
INSERT INTO historial VALUES ('Ingresó Comisión Correctora al alumno GONZALO SEBASTIAN ALVARADO REYES', '15/05/2015', 'admin', 3, 21);
INSERT INTO historial VALUES ('Comision Correctora: El estado del tema cambió de ''Vigente con borrador final'' a En proceso de examen', '28/05/2015', '596', 1, 22);
INSERT INTO historial VALUES ('Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin', '15/05/2015', '171818575', 2, 23);
INSERT INTO historial VALUES ('Ingresó Comisión Correctora al alumno JOAQUÍN OLIVARES DONOSO', '15/05/2015', 'admin', 3, 24);
INSERT INTO historial VALUES ('Comision Correctora: El estado del tema cambió de ''Vigente con borrador final'' a En proceso de examen', '15/05/2015', '595', 1, 25);
INSERT INTO historial VALUES ('Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin', '18/05/2015', '153179409', 2, 26);
INSERT INTO historial VALUES ('Ingresó Comisión Correctora al alumno SEBASTIAN ROSENDE PINO', '18/05/2015', 'admin', 3, 27);
INSERT INTO historial VALUES ('Comision Correctora: El estado del tema cambió de ''Vigente con borrador final'' a En proceso de examen', '20/05/2015', '598', 1, 28);
INSERT INTO historial VALUES ('Se le asignó Comisión Correctora. Lo ingresó el usuario admin admin', '18/05/2015', '173832168', 2, 29);
INSERT INTO historial VALUES ('Ingresó Comisión Correctora al alumno HERNANDO ANDRES MANRIQUEZ NAVARRO', '18/05/2015', 'admin', 3, 30);
INSERT INTO historial VALUES ('Comision Correctora: El estado del tema cambió de ''Vigente con borrador final'' a En proceso de examen', NULL, '599', 1, 31);


--
-- Name: historial_id_historial_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('historial_id_historial_seq', 31, true);


--
-- Data for Name: horario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: inscripcion; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: inscripcionspam; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: logs_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('logs_logs_id_seq', 176, true);


--
-- Data for Name: paramsemestreano; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO paramsemestreano VALUES (1, 2015, 1);


--
-- Data for Name: planes_alumno; Type: TABLE DATA; Schema: public; Owner: postgres
--



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

INSERT INTO profe_correccion VALUES (236, '145010330', 0, 5.5, 5.5);
INSERT INTO profe_correccion VALUES (236, '163601311', 1, 5.5, 5.5);
INSERT INTO profe_correccion VALUES (238, '162690302', 0, 6.5999999, 6.5999999);
INSERT INTO profe_correccion VALUES (238, '155560002', 1, 6.5999999, 6.5999999);
INSERT INTO profe_correccion VALUES (235, '68635926', 0, 6.5999999, 6.5999999);
INSERT INTO profe_correccion VALUES (235, '162690302', 1, 6.5999999, 6.5999999);
INSERT INTO profe_correccion VALUES (237, '78132884', 0, 5.5, 5.5);
INSERT INTO profe_correccion VALUES (237, '155560002', 1, 5.5, 5.5);
INSERT INTO profe_correccion VALUES (239, '78132884', 0, 5.5, 5.5);
INSERT INTO profe_correccion VALUES (239, '70658828', 1, 5.5, 5.5);
INSERT INTO profe_correccion VALUES (240, '120188615', 0, 5.5, 5.5);
INSERT INTO profe_correccion VALUES (240, '78132884', 1, 5.5, 5.5);
INSERT INTO profe_correccion VALUES (233, '70658828', 0, 5.5, 5.5);
INSERT INTO profe_correccion VALUES (233, '120188615', 1, 5.5, 5.5);


--
-- Data for Name: profe_propuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO profe_propuesta VALUES (1, '136711261', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (2, '136711261', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (3, '136711261', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (4, '136711261', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (5, '136711261', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (6, '136711261', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (8, '136711261', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (9, '70549123', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (10, '70549123', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (11, '70549123', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (12, '70549123', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (13, '70549123', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (14, '70549123', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (15, '70549123', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (16, '70549123', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (17, '70549123', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (18, '70549123', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (19, '70549123', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (20, '70549123', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (21, '70549123', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (22, '70549123', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (23, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (24, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (25, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (26, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (27, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (28, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (29, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (30, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (31, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (32, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (33, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (34, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (35, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (36, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (37, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (38, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (39, '70658828', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (40, '70658828', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (41, '70658828', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (42, '70658828', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (43, '70658828', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (44, '70658828', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (45, '70658828', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (46, '70658828', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (47, '70658828', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (48, '70658828', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (49, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (50, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (51, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (52, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (53, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (54, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (55, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (56, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (57, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (58, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (59, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (60, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (61, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (62, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (63, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (64, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (65, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (66, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (67, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (68, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (69, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (70, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (71, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (72, '145010330', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (73, '145010330', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (74, '163601311', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (75, '68635926', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (76, '68635926', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (77, '68635926', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (78, '68635926', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (79, '68635926', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (80, '68635926', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (81, '68635926', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (82, '68635926', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (83, '68635926', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (84, '68635926', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (85, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (86, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (87, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (88, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (89, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (90, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (91, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (92, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (93, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (94, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (95, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (96, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (97, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (98, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (99, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (100, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (101, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (102, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (103, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (104, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (105, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (106, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (107, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (108, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (109, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (110, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (111, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (112, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (113, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (114, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (115, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (116, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (117, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (118, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (119, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (120, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (121, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (122, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (123, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (124, '162690302', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (125, '162690302', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (126, '162690302', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (127, '155560002', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (128, '155560002', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (129, '155560002', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (130, '155560002', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (131, '109857017', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (132, '109857017', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (133, '109857017', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (134, '56369325', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (135, '56369325', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (136, '56369325', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (137, '56369325', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (138, '56369325', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (139, '56369325', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (140, '95794912', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (141, '95794912', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (142, '95794912', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (143, '95794912', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (144, '95794912', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (145, '95794912', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (146, '95794912', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (147, '95794912', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (148, '95794912', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (149, '95794912', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (150, '95794912', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (151, '95794912', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (152, '69476376', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (153, '69476376', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (154, '69476376', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (155, '69476376', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (156, '69476376', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (157, '69476376', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (158, '69476376', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (159, '69476376', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (160, '69476376', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (161, '69476376', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (162, '69476376', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (163, '69476376', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (164, '69476376', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (165, '69476376', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (166, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (167, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (168, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (169, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (170, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (171, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (172, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (173, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (174, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (175, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (176, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (177, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (178, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (179, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (180, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (181, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (182, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (183, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (184, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (185, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (186, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (187, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (188, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (189, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (190, '65776545', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (191, '00', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (192, '00', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (193, '00', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (194, '00', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (195, '00', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (196, '00', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (197, '00', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (198, '00', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (199, '00', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (200, '00', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (201, '00', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (202, '00', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (203, '00', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (204, '130461786', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (205, '130461786', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (206, '130461786', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (207, '130461786', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (208, '130461786', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (209, '130461786', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (210, '136725092', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (211, '136725092', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (212, '136725092', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (213, '136725092', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (214, '136725092', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (215, '136725092', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (216, '136725092', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (217, '136725092', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (218, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (219, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (220, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (221, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (222, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (223, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (224, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (225, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (226, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (227, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (228, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (229, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (230, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (231, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (232, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (233, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (234, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (235, '63567833', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (236, '96742975', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (237, '96742975', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (238, '96742975', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (239, '96742975', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (240, '96742975', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (241, '73172713', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (242, '73172713', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (243, '73172713', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (244, '73172713', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (245, '73172713', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (246, '73172713', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (247, '73172713', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (248, '73172713', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (249, '73172713', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (250, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (251, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (252, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (253, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (254, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (255, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (256, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (257, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (258, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (259, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (260, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (261, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (262, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (263, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (264, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (265, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (266, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (267, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (268, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (269, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (270, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (271, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (272, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (273, '157762311', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (274, '141622404', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (275, '141622404', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (276, '141622404', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (277, '141622404', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (278, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (279, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (280, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (281, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (282, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (283, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (284, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (285, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (286, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (287, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (288, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (289, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (290, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (291, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (292, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (293, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (294, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (295, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (296, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (297, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (298, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (299, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (300, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (301, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (302, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (303, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (304, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (305, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (306, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (307, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (308, '59653024', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (309, '138328449', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (310, '138328449', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (311, '138328449', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (312, '130438164', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (313, '130438164', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (314, '130438164', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (315, '130438164', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (316, '130438164', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (317, '130438164', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (318, '130438164', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (319, '130438164', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (320, '130438164', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (321, '130438164', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (322, '130438164', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (323, '130438164', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (324, '130438164', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (325, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (326, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (327, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (328, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (329, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (330, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (331, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (332, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (333, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (334, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (335, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (336, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (337, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (338, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (339, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (340, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (341, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (342, '71531589', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (343, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (344, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (345, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (346, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (347, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (348, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (349, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (350, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (351, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (352, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (353, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (354, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (355, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (356, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (357, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (358, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (359, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (360, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (361, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (362, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (363, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (364, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (365, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (366, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (367, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (368, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (369, '80796609', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (370, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (371, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (372, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (373, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (374, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (375, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (376, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (377, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (378, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (379, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (380, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (381, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (382, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (383, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (384, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (385, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (386, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (387, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (388, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (389, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (390, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (391, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (392, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (393, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (394, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (395, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (396, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (397, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (398, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (399, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (400, '51668316', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (401, '58872830', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (402, '58872830', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (403, '58872830', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (404, '58872830', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (405, '58872830', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (406, '58872830', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (407, '58872830', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (408, '155898712', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (409, '155898712', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (410, '128416374', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (411, '128416374', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (412, '128416374', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (413, '128416374', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (414, '128416374', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (415, '128416374', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (416, '128416374', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (417, '128416374', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (418, '128416374', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (419, '128416374', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (420, '128416374', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (421, '128416374', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (422, '128416374', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (423, '128416374', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (424, '90070819', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (425, '90070819', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (426, '90070819', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (427, '90070819', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (428, '90070819', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (429, '90070819', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (430, '90070819', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (431, '90070819', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (432, '90070819', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (433, '90070819', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (434, '141475789', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (435, '141475789', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (436, '141475789', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (437, '141475789', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (438, '141475789', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (439, '141475789', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (440, '141475789', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (441, '141475789', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (442, '141475789', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (443, '141475789', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (444, '66348903', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (445, '66348903', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (446, '66348903', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (447, '66348903', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (448, '66348903', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (449, '66348903', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (450, '66348903', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (451, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (452, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (453, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (454, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (455, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (456, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (457, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (458, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (459, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (460, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (461, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (462, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (463, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (464, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (465, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (466, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (467, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (468, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (469, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (470, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (471, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (472, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (473, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (474, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (475, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (476, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (477, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (478, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (479, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (480, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (481, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (482, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (483, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (484, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (485, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (486, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (487, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (488, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (489, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (490, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (491, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (492, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (493, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (494, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (495, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (496, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (497, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (498, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (499, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (500, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (501, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (502, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (503, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (504, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (505, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (506, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (507, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (508, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (509, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (510, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (511, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (512, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (513, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (514, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (515, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (516, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (517, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (518, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (519, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (520, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (521, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (522, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (523, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (524, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (525, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (526, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (527, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (528, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (529, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (530, '77657495', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (531, '70629054', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (532, '70629054', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (533, '70629054', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (534, '70629054', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (535, '70629054', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (536, '70629054', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (537, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (538, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (539, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (540, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (541, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (542, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (543, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (544, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (545, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (546, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (547, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (548, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (549, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (550, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (551, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (552, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (553, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (554, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (555, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (556, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (557, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (558, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (559, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (560, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (561, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (562, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (563, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (564, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (565, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (566, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (567, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (568, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (569, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (570, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (571, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (572, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (573, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (574, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (575, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (576, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (577, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (578, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (579, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (580, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (581, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (582, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (583, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (584, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (585, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (586, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (587, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (588, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (589, '82230971', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (590, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (591, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (592, '156232890', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (593, '130438164', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (595, '136711261', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (596, '70658828', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (597, '136934384', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (598, '163601311', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (598, '136934384', 1, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (599, '136711261', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (607, '120188615', 0, 6.5999999, 6.5999999, NULL);
INSERT INTO profe_propuesta VALUES (602, '120188615', 1, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (603, '120188615', 1, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (603, '70658828', 0, 5.5, 5.5, NULL);
INSERT INTO profe_propuesta VALUES (605, '68635926', 1, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (602, '70658828', 0, 6.5999999, 6.5999999, NULL);
INSERT INTO profe_propuesta VALUES (604, '120188615', 0, 5.5, 5.5, NULL);
INSERT INTO profe_propuesta VALUES (605, '145010330', 0, 5.5, 5.5, NULL);
INSERT INTO profe_propuesta VALUES (608, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (608, '68635926', 1, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (609, '145010330', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (609, '78132884', 1, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (611, '145010330', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (612, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (613, '78132884', 1, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (613, '68635926', 0, 5.5, 5.5, NULL);
INSERT INTO profe_propuesta VALUES (614, '78132884', 1, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (7, '136711261', 0, 5.5, 5.5, NULL);
INSERT INTO profe_propuesta VALUES (615, '120188615', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (614, '163601311', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (616, '78132884', 0, NULL, NULL, NULL);
INSERT INTO profe_propuesta VALUES (616, '162690302', 1, NULL, NULL, NULL);


--
-- Data for Name: profe_revision; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO profe_revision VALUES (589, '70549123', 0, NULL);
INSERT INTO profe_revision VALUES (589, '136934384', 1, NULL);
INSERT INTO profe_revision VALUES (590, '68635926', 0, NULL);
INSERT INTO profe_revision VALUES (590, '120188615', 1, NULL);
INSERT INTO profe_revision VALUES (591, '120188615', 0, NULL);
INSERT INTO profe_revision VALUES (591, '136711261', 1, NULL);
INSERT INTO profe_revision VALUES (592, '70658828', 0, NULL);
INSERT INTO profe_revision VALUES (592, '109857017', 1, NULL);
INSERT INTO profe_revision VALUES (594, '163601311', 0, NULL);
INSERT INTO profe_revision VALUES (594, '68635926', 1, NULL);
INSERT INTO profe_revision VALUES (595, '68635926', 0, NULL);
INSERT INTO profe_revision VALUES (595, '78132884', 1, NULL);
INSERT INTO profe_revision VALUES (596, '78132884', 0, NULL);
INSERT INTO profe_revision VALUES (596, '155560002', 1, NULL);
INSERT INTO profe_revision VALUES (597, '70658828', 0, NULL);
INSERT INTO profe_revision VALUES (597, '120188615', 1, NULL);
INSERT INTO profe_revision VALUES (598, '70658828', 0, NULL);
INSERT INTO profe_revision VALUES (598, '145010330', 1, NULL);
INSERT INTO profe_revision VALUES (599, '162690302', 0, NULL);
INSERT INTO profe_revision VALUES (599, '155560002', 1, NULL);
INSERT INTO profe_revision VALUES (602, '163601311', 0, NULL);
INSERT INTO profe_revision VALUES (602, '162690302', 1, NULL);
INSERT INTO profe_revision VALUES (603, '70658828', 0, NULL);
INSERT INTO profe_revision VALUES (603, '162690302', 1, NULL);
INSERT INTO profe_revision VALUES (604, '70658828', 0, NULL);
INSERT INTO profe_revision VALUES (604, '120188615', 1, NULL);
INSERT INTO profe_revision VALUES (606, '145010330', 0, NULL);
INSERT INTO profe_revision VALUES (606, '155560002', 1, NULL);


--
-- Data for Name: profesor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO profesor VALUES (1, 'CAROLINA', 'BONACIC', NULL, NULL, 0, NULL, '120188615', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'CRISTIÁN', 'BADILLA', NULL, NULL, 0, NULL, '145010330', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'CRISTÓBAL', 'ACOSTA', NULL, NULL, 0, NULL, '163601311', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'EDGARDO', 'SEPÚLVEDA', NULL, NULL, 0, NULL, '68635926', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'EDMUNDO', 'LEIVA', NULL, NULL, 0, NULL, '78132884', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'EMIR', 'MUÑOZ', NULL, NULL, 0, NULL, '162690302', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'ERIKA', 'ROSAS', NULL, NULL, 0, NULL, '155560002', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'FERNANDA', 'KRI', NULL, NULL, 0, NULL, '109857017', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'FERNANDO', 'CONTRERAS', NULL, NULL, 0, NULL, '56369325', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'FERNANDO', 'RANNOU', NULL, NULL, 0, NULL, '95794912', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'GONZALO', 'ACUÑA', NULL, NULL, 0, NULL, '69476376', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'HÉCTOR', 'ANTILLANCA', NULL, NULL, 0, NULL, '65776545', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'HÉCTOR', 'PONCE', NULL, NULL, 0, NULL, '00', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'IRENE', 'ZUCCAR', NULL, NULL, 0, NULL, '130461786', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'JACQUELINE', 'KOHLER', NULL, NULL, 0, NULL, '136725092', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'JOSÉ', 'ÁLVAREZ', NULL, NULL, 0, NULL, '63567833', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'JOSÉ LUIS', 'JARA', NULL, NULL, 0, NULL, '96742975', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'JUAN', 'COCKBAINE', NULL, NULL, 0, NULL, '73172713', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'JUAN', 'ITURBE', NULL, NULL, 0, NULL, '156232890', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'JUAN PABLO', 'RUZ', NULL, NULL, 0, NULL, '157762311', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'LUIS', 'BERRÍOS', NULL, NULL, 0, NULL, '141622404', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'LUIS', 'RÍOS', NULL, NULL, 0, NULL, '59653024', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'MARIA CAROLINA', 'CHAMORRO', NULL, NULL, 0, NULL, '138328449', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'MARIO', 'INOSTROZA', NULL, NULL, 0, NULL, '130438164', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'MAURICIO', 'MARÍN', NULL, NULL, 0, NULL, '71531589', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'MAX', 'CHACON', NULL, NULL, 0, NULL, '80796609', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'MÓNICA', 'VILLANUEVA', NULL, NULL, 0, NULL, '51668316', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'NÉSTOR', 'GONZÁLEZ', NULL, NULL, 0, NULL, '58872830', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'NICOLÁS', 'HIDALGO', NULL, NULL, 0, NULL, '155898712', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'PAULO', 'QUINSACARA', NULL, NULL, 0, NULL, '128416374', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'RICARDO', 'CONTRERAS', NULL, NULL, 0, NULL, '90070819', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'ROBERTO', 'GONZÁLEZ', NULL, NULL, 0, NULL, '141475789', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'ROGERS', 'ATERO', NULL, NULL, 0, NULL, '66348903', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'ROSA', 'MUÑOZ', NULL, NULL, 0, NULL, '77657495', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'SERGIO', 'VELASTIN', NULL, NULL, 0, NULL, '70629054', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (1, 'VÍCTOR', 'PARADA', NULL, NULL, 0, NULL, '82230971', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (0, 'ANDRÉS', 'RICE', '', '', 0, NULL, '70549123', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (0, 'ALBERTO', 'CEBALLO', 'ASD@ASD.CL', '83340796', 0, NULL, '136711261', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (0, 'ARTURO', 'ALVAREZSDFA', NULL, '12312321', 0, 7, '136934384', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (0, 'PROFE', 'SOR', 'profe@profe.cl', '89307940', 0, 7, '176767901', NULL, NULL, NULL, NULL, NULL);
INSERT INTO profesor VALUES (0, 'BRUNO', 'JERARDINO', 'mail@mail.cl', '89307940', 0, 7, '70658828', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: propuesta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO propuesta VALUES ('SISTEMA WEW PARA AYUDAR A PADRES Y APODERADOS EN LA BUSQUEDA DE COLEGIOS USANDO UN OPEN DATE', '20/07/2012', 1, 'default', 1, '176744650', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA VACACIONES PROGRESIVAS Y GENERACIÓN DE ALARMAS PARA LA EMPRESA CYSS', '22/06/2012', 280, 'default', 279, '158932121', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE API DE VALIDACIÓN MEDIANTE HUELLA DIGITAL EN TARJETAS CON CHIP', '23/07/2012', 2, 'default', 2, '167110614', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE APOYO A LA PLANIFICACIÓN DOCENTE Y MEDICIÓN DEL ESTADO DE AVANCE DE LOS ALUMNOS EN HABILIDADES COGNITIVAS ESPECÍFICAS', '', 3, 'default', 3, '172288987', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE COORDINACION Y GESTION DE RESERVA HORARIA PARA EVENTOS Y ACTIVIDADES DEL COLEGIO ALEMAN DE SANTIAGO', '20/09/2011', 4, 'default', 4, '128516948', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO DE UN SISTEMA QUE PERMITA LA CREACIÓN DE APLICACIONES EDUCATIVAS', '', 5, 'default', 5, '173832168', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE APOYO A LA GESTIÓN DE UNA ORGANIZACIÓN COMUNITARIA', '20/11/2013', 6, 'default', 6, '171818575', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACIÓN AUTOMÁTICA DE RUTAS CON ENTREGAS PRIORITARIAS', '', 7, 'default', 7, '171818575', NULL, NULL);
INSERT INTO propuesta VALUES ('SOLUCION TECNOLOGICA PARA LA CREACION DE SITIOS WEB Y SU GESTION DE INFORMACION, EN UNA EMPRESA DE SELECCIÓN DE PERSONAL', '4/8/2010', 8, 'default', 8, '153179409', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE ADMINISTRACIÓN PARA LA INFORMACIÓN TRANSPARENTE EN UNA COMUNIDAD DE EDIFICIOS', '11/11/2014', 9, 'default', 9, '159073122', NULL, NULL);
INSERT INTO propuesta VALUES ('SOFTWARE DE APOYO AL PROCESO ADMINISTRATIVO DE LA EMPRESA OPTICA REAL', '20/07/2012', 10, 'default', 10, '166257344', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA INFORMÁTICO PARA EL PROCESO DE POSTULACIÓN EN LÍNEA Y POSTERIOR SELECCIÓN DE AYUDANTES DEL DEPARTAMENTO DE INFENIERÍA INFORMÁTICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '8/8/2012', 11, 'default', 11, '169367353', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA INFORMÁTICO PARA LA GESTIÓN DE RECURSOS DEL DEPARTAMENTO DE DEPORTES DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '23/01/2014', 12, 'default', 12, '17841447K', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA PARA MONITOREO Y GESTIÓN DE REQUERIMIENTOS E INCIDENTES DE CLIENTES CORPORATIVOS EMPRESA ENTEL, MEDIANTE HERRAMIENTA SPLUNK', '', 13, 'default', 13, '163235315', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE PROTOTIPO DE UNA CALCULADORA DE DOSIS PARA EL APOYO DEL ÁREA DE PEDRIATRÍA', '18/12/12', 14, 'default', 14, '171176654', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLAR JUEGOS PARA CURSO DE ECONOMÍA DE BACHILLER DE TECNOLOGÍA', '18/07/2013', 15, 'default', 15, '167535682', NULL, NULL);
INSERT INTO propuesta VALUES ('PROTOTIPO FUNCIANAL DE UN SISTEMA BROKER PARA LA EMPRESA SOLINGAS S.A', '5/12/2012', 16, 'default', 16, '179365995', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA WEB ADMINISTRATIVO Y RESERVAS DE ATENCIÓN EN LÍNEA PARA UNA SERVITECA', '14/12/12', 17, 'default', 17, '171676568', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE EVALUACIÓN INTERACTIVO CON DISPOSITIVOS SMARTPHONE', '28/07/2014', 18, 'default', 18, '150947952', NULL, NULL);
INSERT INTO propuesta VALUES ('IMPLEMENTACIÓN DE WEB SERVICE PARA INTEGRACIÓN SAP CON PLATAFORMAS WEB', '29/07/2013', 19, 'default', 19, '136750089', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE TECNOLOGÍAS DE LA INFORMACIÓN EN LA ENSEÑANZA BÁSICA', '17/12/12', 20, 'default', 20, '174641625', NULL, NULL);
INSERT INTO propuesta VALUES ('AUTOMATIZACIÓN DEL PROCESO PARA VISADO DE PAGO A PROVEEDORES DE LA EMPRESA ENVASES DEL PACÍFICO (EDELPA)', '3/3/2014', 21, 'default', 21, '16548262K', NULL, NULL);
INSERT INTO propuesta VALUES ('OBEJTOS DE APRENDIZAJE PARA LA ENSEÑANZA DE LA LENGUA DE SEÑAS CHILENAS PARA NIÑOS CON DISCAPACIDAD AUDITIVA', '7/1/2013', 22, 'default', 22, '174115273', NULL, NULL);
INSERT INTO propuesta VALUES ('HERRAMIENTA DE SOFTWARE PARA ENTREGA DE INFORMACIÓN TURÍSTICA DIFERENCIADA Y FOCALIZADA EN PERFILES DE TURISTICA', '', 23, 'default', 23, '170217535', NULL, NULL);
INSERT INTO propuesta VALUES ('PROTOCOLO PARA LA INTEROPERACIÓN DE UAVS, MEDIANTE UNA TORRE DE CONTROL VIRTUAL EN UN ESPACIO  AÉREO NO SEGREGADO "OGMIOS"', '', 24, 'default', 24, '161952133', NULL, NULL);
INSERT INTO propuesta VALUES ('IMPLEMENTACIÓN DE ARQUITECTURA BASADA EN SWARM PARA BÚSQUEDA COLABORATIVA MEDIANTE VEHÍCULOS AÉREOS NO TRIPULADOS (UAVS)', '14/08/2014', 25, 'default', 25, '169009112', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACIÓN DEALGORITMOS AEROFOTOGRAMÉTRICOS PARA CORRECCIÓN ORTOGONAL DE IMÁGENES, OBTENIDAS MEDIANTES UAV, USACDAS PARA GENERAR MOSAICOS Y MODELOS 3D', '28//12/2012', 26, 'default', 26, '167406386', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE SISTEMA DE PLANIFICACIÓN DE MISIÓN Y CONTROL ADAPTIVO EN VUELO PARA EL SISTEMA AEREO ROBOTICO RUAS', '23/07/2012', 27, 'default', 27, '160707186', NULL, NULL);
INSERT INTO propuesta VALUES ('SOFTWARE PARA PLANIFICACIÓN DE VUELO FOTOGRAMÉTRICO DE UAV EN TERRENOS COMPLEJOS', '14/08/2014', 28, 'default', 28, '172952739', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE SOFTWARE PARA CONTROL DE PLANES DE VUELO DE SISTEMA ROBÓTICO AÉREO MULTIAGENTE, BASADO EN LA ARQUITECTURA L-ALLIANCE', '01/03/13', 29, 'default', 29, '166097401', NULL, NULL);
INSERT INTO propuesta VALUES ('IMPLEMENTACIÓN DE ARQUITECTURA MULTIAGENTE L-ALLIANCE PARA EL CONTROL DE COMPORTAMIENTO DE VUELO DE ROBOTS AÉREOS', '22/04/2014', 30, 'default', 30, '166097401', NULL, NULL);
INSERT INTO propuesta VALUES ('DIFERENCIACIÓN DE VIGOR VEGETATIVO EN CULTIVOS AGRÍCOLAS POR MEDIO DEL TRATAMIENTO DE IMÁGENES INFRARROJAS AÉREAS, CAPTURADAS CON UN AVIÓN ROBOTIZADO', '', 31, 'default', 31, '167239404', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE DETECCIÓN Y EVASIÓN DE OBSTÁCULOS PARA UAV CUADRICOPTERO BASADO EN ARDUPILOT', '6/8/2014', 32, 'default', 32, '173127677', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE DETECCIÓN DE PERSONAS EXTRAVIADAS, POR MEDIO DE RECONOCIMIENTO DE PATRONES EN IMAGÉNES TRANSMITIDAS EN TIEMPO REAL DESDE AVIÓN NO TRIPULADO', '01/03/13', 33, 'default', 33, '169091749', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE APOYO A LA DOCUMENTACIÓN DE IMÁGENES, AUTOMATIZANDO EL RECONOCIMIENTO DE EDIFICIOS Y ESTRUCTURAS', '27/07/2012', 34, 'default', 34, '166250536', NULL, NULL);
INSERT INTO propuesta VALUES ('UN SISTEMA PARA EL LANZAMIENTO DE SUMINISTROS MÉDICOS DESDE UN VEHÍCULO AÉREO NO TRIPULADO', '20/01/2014', 35, 'default', 35, '171686202', NULL, NULL);
INSERT INTO propuesta VALUES ('AUTOPILOTO INTEGRADO EN SMARTPHONE PARA VEHÍCULO AÉREO NO TRIPULADO (UAV)', '4/8/2014', 36, 'default', 36, '173808200', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE ORIENTACIÓN DE SERVICIOS TURÍSTICOS PARA DISPOSITIVOS MÓVILES UTILIZANDO REALIDAD AUMENTADA.', '', 37, 'default', 37, '167858244', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE SOFTWARE EMBEBIDO EN HARDWARE PARA DETECCIÓN DE FIGURAS HUMANAS DESDE ROBOT AÉREO', '23/12/2014', 38, 'default', 38, '174846863', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACIÓN WEB PARA EVALUACIÓN DEL DESEMPEÑO Y AUTOCONSULTA DE RECURSOS HUMANOS', '15/01/13', 39, 'default', 39, '10225225K', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UNA PLATAFORMA DE SOFTWARE PARA PRUEBAS DE REGRESIÓN AUTOMATIZADAS DE APLICACIONES WEB USADAS EN EL OBSERVATORIO ALMA', '10/7/2013', 40, 'default', 40, '100438413', NULL, NULL);
INSERT INTO propuesta VALUES ('UTILIZACIÓN DE UNA METODOLOGÍA ÁGIL PARA ENTEL S.A.', '19/07/2013', 41, 'default', 41, '141359193', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UNA APLICACIÓN DE PROTOTIPO EN LA WEB USANDO TECNOLOGÍA DE LA NUBE', '5/8/2013', 42, 'default', 42, '132978883', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE APOYO A LA GESTIÓN PARA EL PROCESO DE CERTIFICACIÓN DE SOFTWARE QA', '17/07/2013', 43, 'default', 43, '154115919', NULL, NULL);
INSERT INTO propuesta VALUES ('UNA APLICACIÓN COLABORATIVA PARA APOYAR EL USO DE LA METODOLOGÍA DE SISTEMAS BLANDOS DE PETER CHECKLAND', '18/07/2014', 44, 'default', 44, '167503004', NULL, NULL);
INSERT INTO propuesta VALUES ('PREDICCIÓN DE LA RENTABILIDAD DE LOS FONDOS DE PENSIONES UTILIZANDO AUTÓMATAS CELULARES', '10/7/2013', 45, 'default', 45, '151166822', NULL, NULL);
INSERT INTO propuesta VALUES ('CLASIFICADOR DE PUNTOS SOBRE NUBE DE OBJETOS GENERADA POR SISTEMA LIDAR', '16/12/2013', 46, 'default', 46, '153318115', NULL, NULL);
INSERT INTO propuesta VALUES ('UNA APLICACIÓN MÓVIL QUE APOYA LA REALIZACIÓN DE LA METODOLOGÍA DE SISTEMAS BLANDOS DE PETER CHECKLAND', '19/12/2014', 47, 'default', 47, '171885701', NULL, NULL);
INSERT INTO propuesta VALUES ('RECURSO DE APRENDIZAJE DE USABILIDAD WEB: UNA APROXIMACIÓN DESDE LA CUARTA HEURÍSTICA DE NIELSEN', '23/12/2014', 123, 'default', 122, '174112924', NULL, NULL);
INSERT INTO propuesta VALUES ('PROPUESTA DE MEJORAS METODOLÓGICAS PARA LA GESTIÓN DE LA INCERTIDUMBRE EN PROYECTOS DE SOFTWARE ÁGILES DESDE UN ENFOQUE DE SISTEMAS BLANDOS', '19/12/2014', 48, 'default', 48, '177402168', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE SOPORTE A EDUCADORES EN ENTORNOS DE EVALUACIÓN Y APRENDIZAJE DE ALUMNOS CON NECESIDADES EDUCATIVAS ESPECIALES EN ÁREAS COGNITIVAS', '30/07/2014', 49, 'default', 49, '171233496', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN SISTEMA PERSONALIZABLE PARA QUE PROFESORES TRABAJEN LA INCLUSIÓN DE ALUMNOS CON NECESIDADES ESPECIALES TRANSITORIAS', '4/8/2014', 50, 'default', 50, '176719443', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE ESTRATÉGIAS DE PLANIFICACIÓN PARA MOTORES DE BÚSQUEDA VERTICALES', '', 51, 'default', 51, '175147160', NULL, NULL);
INSERT INTO propuesta VALUES ('SOFTWARE DE AGENDA PERSONAL Y ASISTENTE PARA ESTRATEGIAS SOCIALES PARA PERSONAS CON SÍNDROME DE ASPERGER', '29/07/2014', 52, 'default', 52, '175863419', NULL, NULL);
INSERT INTO propuesta VALUES ('PREDICCION DE LA ESTRUCTURA TRIDIMENSIONAL DE PROTEINAS MEDIANTE CLOUD COMPUTING', '23/09/2013', 53, 'default', 53, '180611843', NULL, NULL);
INSERT INTO propuesta VALUES ('PREDICCIÓN DE L ESTRUCTURA TRIDIMENSIONAL DE PROTEÍNAS MEDIANTE CLOUD COMPUTING', '11/3/2014', 54, 'default', 54, '180611843', NULL, NULL);
INSERT INTO propuesta VALUES ('ADAPTACIÓN DE ALGORITMOS DE ORDENAMIENTO A MÁQUINAS DE BÚSQUEDA VERTICALES', '19/12/12', 55, 'default', 55, '161228850', NULL, NULL);
INSERT INTO propuesta VALUES ('IMPLEMENTACIÓN DE ALGORITMOS DE MEJORA DE CLASIFICACIÓN EXTRAÍDOS DESDE EL ESTADO DEL ARTE', '21/08/2014', 56, 'default', 56, '160954361', NULL, NULL);
INSERT INTO propuesta VALUES ('ESTUDIO Y ANÁLISIS DE HERRAMIENTAS DE PROCESAMIENTO DE DATOS EN STREAMING', '19/12/12', 57, 'default', 57, '17080631K', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN FIREWALL EN ALTA DISPONIBILIDAD', '18/07/2013', 58, 'default', 58, '164706699', NULL, NULL);
INSERT INTO propuesta VALUES ('PROTOTIPO DE SOFTWARE DE COMUNICACIÓN A TRAVÉS DE BLUETOOTH PARA USO COMERCIAL Y SOCIAL', '20-12-2012', 59, 'default', 59, '172863027', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACIÓN DE APOYO AL PROCESO DE GESTIÓN DE SERVICIOS DE TALLER', '14/08/2014', 60, 'default', 60, '125011268', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE SEGUIMIENTO DE CLIENTES DE UNA EMPRESA INFORMÁTICA', '', 61, 'default', 61, '167441882', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE MONITOREO DE VALORES CRÍTICOS QUE APOYE LA GESTIÓN DE LABORATORIOS CLÍNICOS', '12/12/2013', 62, 'default', NULL, '158324954', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLO DE BASE DE DATOS PARA OBSERVATORIOS WEB', '', 63, 'default', 62, '141459368', NULL, NULL);
INSERT INTO propuesta VALUES ('ALGORITMO DE IDENTIFICACIÓN DE LÍDERES DE OPINIÓN EN TWITTER', '5/12/2014', 64, 'default', 63, '180486011', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE UBICACIÓN DEL CENTRO DE MASA EN ADULTOS MAYORES A TRAVÉS DE DISPOSITIVOS MÓVILES', '4/8/2014', 65, 'default', 64, '174841691', NULL, NULL);
INSERT INTO propuesta VALUES ('SIMULACION DE APLICACIOINES UTILIZADAS EN ESCENARIOS DE EMERGENCIA, DESPLEGADAS SOBRE LA PLATAFORMA S4 ADAPTADA A CELULARES', '27/09/2013', 66, 'default', 65, '174135142', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACIÓN ANDROID FISCALIZACIÓN CIUDADANA', '7/11/2013', 67, 'default', 66, '170061403', NULL, NULL);
INSERT INTO propuesta VALUES ('INSTALACIÓN Y CONFIGURACIÓN DE HERRAMIENTA ORACLE ENTERPRICE GOVERNANCE, RISK AND COMPLIANCE, MÓDULO APPLICATION ACCESS CONTROL GOVERNOR', '22/07/2013', 68, 'default', 67, '160158840', NULL, NULL);
INSERT INTO propuesta VALUES ('SOFTWARE DE EJERCICIOS DE ESTIMULACIÓN Y EVALUACIÓN COGNITIVA PARA PACIENTES CON PARKINSON', '19/12/2014', 69, 'default', 68, '176731303', NULL, NULL);
INSERT INTO propuesta VALUES ('SOFTWARE DE EJERCICIOS DE ESTIMULACIÓN Y EVALUACIÓN MOTORA PARA PACIENTES CON PARKINSON', '19/12/2014', 70, 'default', 69, '174875642', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE API PARA ANÁLISIS DE TÓPICOS EN REDES SOCIALES', '22/12/2014', 71, 'default', 70, '169410313', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE SEGUIMIENTO DE JUICIOS APOYAR LA GESTIÓN DE COBRANZA DE EMPRESA RECOLINE', '28/11/2012', 72, 'default', 71, '120101099', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE APOYO A LAS VENTAS Y SERVICIOS TÉCNICOS DE LA EMPRESA IMPORTADORA NORTE', '25/09/2012', 73, 'default', 72, '11266789K', NULL, NULL);
INSERT INTO propuesta VALUES ('PROTOTIPO DE UN SISTEMA INFORMÁTICO DE POSTULACIÓN, EVALUAVIÓN Y SELECCIÓN DE AYUDANTE DE DOCENCIA', '', 74, 'default', 73, '164182169', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE TRAZABILIDAD COMO APOYO AL PROCESO DE ELABORACIÓN DE JUGO/MOSTO', '25/01/13', 75, 'default', 74, '143418700', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE CONTROL DE ASISTENCIA Y APOYO AL CÁLCULO DE REMUNERACIONES BASADOS EN PRODUCCIÓN', '26/12/2012', 76, 'default', 75, '126644930', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DE ETL PARA SERVICIOS DE LEASING FINANCIERO Y OPERATIVO', '9/9/2014', 77, 'default', 76, '171676568', NULL, NULL);
INSERT INTO propuesta VALUES ('CENTRAL DE REPORTES PARA EL ÁREA DE RIESGOS DE MERCADO DEL BANCO SANTANDER', '3/10/2012', 78, 'default', 77, '155667885', NULL, NULL);
INSERT INTO propuesta VALUES ('OBSERVATORIO WEB DE PROYECTOS INNOVADORES EN INFORMÁTICA', '21/01/2014', 79, 'default', 78, '175433406', NULL, NULL);
INSERT INTO propuesta VALUES ('METODOLOGÍA DE GESTIÓN DE PROCESOS ORIENTADA A LA DETERMINACIÓN Y ADMINISTRACIÓN DE RIESGOS OPERACIONAL EN UNA INSTITUCIÓN BANCARIA', '29/06/2012', 80, 'default', 79, '158433761', NULL, NULL);
INSERT INTO propuesta VALUES ('IMPLEMENTACIÓN DE BPM PARA LA GESTIÓN DOCUMENTAL DE UN SERVICIO PÚBLICO', '11/1/2013', 81, 'default', 80, '121018071', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE ADMINISTRACIÓN DE CAPACITACIONES PARA EMPRESA CAPACITACIÓN USACH LTDA.', '21/11/2013', 82, 'default', 81, '166606322', NULL, NULL);
INSERT INTO propuesta VALUES ('INTEGRACIÓN DE PLATAFORMA ERP CORPORATIVA CON LICENCIA MEDICA ELECTRONICA Y REDISEÑO DE PROCESOS ASOCIADOS', '18/01/13', 83, 'default', 82, '13471476K', NULL, NULL);
INSERT INTO propuesta VALUES ('MODELO DE PROCESOS DE LA OTEC USECAP, SEGÚN NORMAS NCH 2728  E ISO 9001/2008. DESARROLLO DE SISTEMA PARA LA TRAZABILIDAD', '20/09/2011', 84, 'default', 83, '123961846', NULL, NULL);
INSERT INTO propuesta VALUES ('DETECCIÓN DE LOS ACTOS DEL HABLA DE INDAGACIÓN Y PERSUACIÓN UTILIZANDO EN FRAMEWORK DE EXPERIMENTACIÓN.', '24/08/2012', 85, 'default', 84, '164115267', NULL, NULL);
INSERT INTO propuesta VALUES ('INTEGRACION DEL CONTROL DE UN PROCESO DE NEGOCIOS DE GENERACION DE NOTICIAS CON LA COLABORACION ENTRE PERIODISTAS UTILIZANDO UNA RED SOCIAL CORPORATIVA', '1/10/2013', 86, 'default', 85, '173102771', NULL, NULL);
INSERT INTO propuesta VALUES ('INFRAESTRUCTURA EMPRESARIAL PARA OBSERVATORIO DE LA WEB: CASO DE LA GENERACIÓN DE NOTICIAS EN UNA RED SOCIAL CORPORATIVA CON UN PROCESO DE NEGOCIO ASOCIADO', '22/08/2014', 87, 'default', 86, '173102771', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE INFORMACIÓN PARA EL APOYO A LA EVALUACIÓN DE LOCALES PARA EMPRESA TACK S.A', '', 88, 'default', 87, '160193379', NULL, NULL);
INSERT INTO propuesta VALUES ('INFERENCIA DE SOMNOLENCIA AL CONDUCIR UN AUTOMÓVIL MEDIANTE LOS MOVIMIENTOS DE LA CABEZA', '24/07/12', 89, 'default', 88, '16633277K', NULL, NULL);
INSERT INTO propuesta VALUES ('INCORPORACION DE LA DETECCION DEL BOSTEZO EN UN PROTOTIPO RECONOCEDOR DEL ESTADO DE SOMNOLENCIA EN EL DOMINIO DE LA CONDUCCION DE VEHICULOS', '30/09/2013', 90, 'default', 89, '168401795', NULL, NULL);
INSERT INTO propuesta VALUES ('FORO WEB CON ENFOQUE DE DIÁLOGO DISTRIBUIDO PARA MANTEKA', '23/01/2014', 91, 'default', 90, '174865744', NULL, NULL);
INSERT INTO propuesta VALUES ('PORTAL WEB CON RED SOCIAL CORPORATIVA PARA LA ORGANIZACIÓN REASE', '14/11/2014', 92, 'default', 91, '174865744', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACION DE UN MODULO DE EVALUACION DE RENDIMIENTO ESCALABLE Y MANTENIBLE PARA UNA RED SOCIAL GENERADORA DE NOTICIAS', '14/10/2013', 93, 'default', 92, '166489229', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACIÓN Y MEJORA DE LA INFRAESTRUCTURA DE UNA RED SOCIAL GENERADORA DE NOTICIAS MEDIANTE MONITORES DE RENDIMIENTO DE SOFTWARE', '26/07/2012', 94, 'default', 93, '166489229', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DE ALGORITMOS PARALELOS DE RECONTRUCIÓN DE IMÁGENES BASADOS EN EL PARADIGMA "ESPACIO DE DIRECCIONES GLOBALES PARTICIONADO".', '', 143, 'default', 142, '166612799', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UNA PLATAFORMA DE SOFTWARE PARA LA RECAUDACIÓN EN LÍNEA MODALIDAD PRESENCIAL ENTRE INSTITUCIONES RECAUDADORAS AUTORIZADAS Y LA TESORERÍA GENERAL DE LA REPUBLICA', '17/07/2013', 95, 'default', 94, '14059203K', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE GESTIÓN DE INFORMACIÓN TRANSPARENTE PARA EDIFICIOS DE DEPARTAMENTOS', '27/07/2012', 124, 'default', 123, '159073122', NULL, NULL);
INSERT INTO propuesta VALUES ('DETECCIÓN DE NIVELES DE ESTRÉS  A TRAVÉS DEL PROCESAMIENTO DE LA VOZ EN TELÉFONOS INTELIGENTES', '20/12/2013', 96, 'default', 95, '167834566', NULL, NULL);
INSERT INTO propuesta VALUES ('HERRAMIENTA DE EXPERIMENTACIÓN CONFIGURABLE QUE PERMITA  COMPARAR Y PROBAR ALGORITMOS DE RECOMENDACIÓN CON EL FIN DE GENERAR  DISPONIBIZAR SERVICIOS DE RECOMENDACIÓN PARA DISTINTOS TIPOS DE REDES SOCIALES', '6/7/0212', 97, 'default', 96, '161509299', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACIÓN ASISTIDA DE DOCUMENTOS COTIDIANOS PARA PERSONAS CON DISCAPACIDAD INTELECTUAL.', '20/07/2012', 125, 'default', 124, '166099838', NULL, NULL);
INSERT INTO propuesta VALUES ('SOFTWARE COMO LABORATORIO PARA PROBAR Y EVALUAR ALGORITMOS DE RECOMENDACIÓN COLABORATIVA', '', 98, 'default', 97, '172562752', NULL, NULL);
INSERT INTO propuesta VALUES ('PROPUESTA PRUEBA', '24/04/2015', 595, '1/2015', 589, '176744650', false, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE HERRAMIENTAS PARA MEDIR COMPETENECIAS EN APRENDIZAJE BASADO EN PROYECTOS', '13/08/2014', 99, 'default', 98, '158896222', NULL, NULL);
INSERT INTO propuesta VALUES ('DETECCIÓN DE FALLAS EN LA RED DE SUMINISTRO DE BANDA ANCHA UTILIZANDO EL PROTOCOLO RADIUS', '24/07/2012', 126, 'default', 125, '165707036', NULL, NULL);
INSERT INTO propuesta VALUES ('SOFTWARE DE APOYO EN EL RECONOCIMEINTO DE MENTIRAS EN VICTIMAS DE ABUSO SEXUAL INFANTIL', '7/7/2014', 100, 'default', 99, '151765637', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN SERVICIO DE INTEGRACIÓN PARA ACTUALIZAR SERVICIOS DE RECOMENDACIÓN DE ETIQUETAS EN UNA RED SOCIAL EMPRESARIAL DE NOTICIAS', '02/01/03', 101, 'default', 100, '169428182', NULL, NULL);
INSERT INTO propuesta VALUES ('LOCALIZACION DISTRIBUIDA DE STREAMS PARA EL PROCESAMIENTO DE EVENTOS EN TIEMPO REAL', '23/09/2013', 127, 'default', 126, '174890412', NULL, NULL);
INSERT INTO propuesta VALUES ('CONTINUOUSDELIVERY DE SERVICIOS DE RECOMENDACIÓN EN UNA RED SOCIAL EMPRESARIAL DE NOTICIAS', '22/05/2014', 102, 'default', 101, '169428182', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN ETIQUETADOR INTERACTIVO DE DOCUMENTOS DENTRO DE UN PROCESO DE NEGOCIOS DE GENERACIÓN DE NOTICIAS.', '7/7/2012', 103, 'default', 102, '154010335', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE RECOMENDACION Y DIFUSION PARA MOVILES', '24/09/2013', 128, 'default', 127, '180963820', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE ADMINISTRACION AGIL PARA MULTIPLES PROYECTOS', '30/09/2013', 104, 'default', 103, '171219698', NULL, NULL);
INSERT INTO propuesta VALUES ('SELECCIÓN DE IMPLEMENTACIÓN DE ALGORITMO DE RECOMENDACIÓN BASADO EN TGS EN UNA RED SOCIAL GENERADORA DE NOTICIAS', '', 105, 'default', 104, '169849900', NULL, NULL);
INSERT INTO propuesta VALUES ('MEJORAR LA TOLERANCIA A FALLAS EN UN SISTEMA DE PROCESAMIENTO DE EVENTOS SOBRE DISPOSITIVOS MOVILES', '23/09/2013', 129, 'default', 128, '161670960', NULL, NULL);
INSERT INTO propuesta VALUES ('ALGORITMO DE RECOMENDACIÓN DE TAGS BASADO EN CLUTERS PARA UNA RED SOCIAL DE NOTICIAS', '12/5/2014', 106, 'default', 105, '169849900', NULL, NULL);
INSERT INTO propuesta VALUES ('PROTOTIPO DE SUITE AFECTIVA PARA EL ANALISIS DE LA SATISFACCIÓN DEL USUARIO.', 's/f', 107, 'default', 106, '157002880', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE REPUTACIÓN PARA LA RED SOCIAL WAZE', '22/12/2014', 130, 'default', 129, '97829736', NULL, NULL);
INSERT INTO propuesta VALUES ('AUTOMATIZACION DEL PROCESO DE CONTRATACION DE PROFESORES POR HORA PARA LA FACULTAD DE INGENIERIA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '30/09/2013', 108, 'default', 107, '173796773', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE SISTEMAS WORKFLOW PARA EL PLANTEAMIENTO Y VERIFICACIÓN DE COMPETENCIAS DE MANEJO DE PROYECTOS EN LOS CURSOS DE INGENIERÍA CIVIL INFORMÁTICA', '18/08/2014', 109, 'default', 108, '174043221', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO MOTODOLÓGICO PARA LA ELABORACIÓN Y DESARROLLO DE SECUENCIAS DE ACTIVIDADES INTERACTIVAS PARA LA ENSEÑANZA DEL CAMPO ADICTIVO EN EL PRIMER CICLO BÁSICO', 'NO', 131, 'default', 130, '161163813', NULL, NULL);
INSERT INTO propuesta VALUES ('RECONOCEDOR DE SONRISAS ANSIOSAS EN SITUACIONES EXPERIMENTALES PARA PESQUISAR ENGAÑO', '18/08/2014', 110, 'default', 109, '169074526', NULL, NULL);
INSERT INTO propuesta VALUES ('“DESCRIPCIÓN ARQUITECTURAL DE UN SISTEMA GENERADOR DE SERVICIOS DE RECOMENDACIÓN PARA OBSERVATORIOS DE LA WEB”', '23/07/2012', 111, 'default', 110, '16556717K', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA PARA GUIAR LA REALIZACIÓN DE ACTIVIDADES ESCOLARES EN CASA', '7/1/2012', 132, 'default', 131, '16955594K', NULL, NULL);
INSERT INTO propuesta VALUES ('MANUAL PARA SELECCIONAR SUITES BMP CON CRITERIOS DE FUNCIONALIDAD Y USABILIDAD: CASO DE PROCESO DE GENERACIÓN DE NOTICIAS', '5/3/2013', 112, 'default', 111, '72002393', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACIÓN DE DATASETS CON ESQUEMA ESTÁNDAR PARA ENTRENAR ALGORITMOS DE RECOMENDACIÓN PARA REDES SOCIALES', '23/07/2012', 113, 'default', 112, '166912644', NULL, NULL);
INSERT INTO propuesta VALUES ('PROTOTIPO FUNCIONAL DE UNA RED SOCIAL VERTICAL PARA EL SOFTWARE GREI', '24/07/2012', 133, 'default', 132, '171754755', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE CONTROL DE CONTRATO CON KANBAN', '21/12/12', 114, 'default', 113, '107046844', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO Y DESARROLLO DE UN FRAMEWORK DE NOTIFICACIONES VÍA MENSAJERÍA SMS', '17/12/12', 115, 'default', 114, '11473909K', NULL, NULL);
INSERT INTO propuesta VALUES ('ANALISIS BIOMECANICA DE ANGULOS EN LA SALIDA DE TACOS', '', 134, 'default', 133, '163215454', NULL, NULL);
INSERT INTO propuesta VALUES ('VISUALIZANDO DIÁLOGOS EN COMUNIDADES VIRTUALES DE APRENDIZAJE', '6/8/2014', 116, 'default', 115, '169091749', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE APLICACIONES WEB PARA ORGANIZACIONES SIN FINES DE LUCRO POR MEDIO DE LA ARQUITECTURA DE LA INFORMACIÓN', '21/03/2014', 117, 'default', 116, '167395333', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE SISTEMA DE COTIZACIÓN Y DE CONTROL DE EXISTENCIAS PARA LA EMPRESA ALUMAR', '19/07/2012', 135, 'default', 134, '17325752K', NULL, NULL);
INSERT INTO propuesta VALUES ('CONSTRUCCION DE UNA INFRAESTRUCTURA EMPRESARIAL PARA UN SISTEMA DE GENERACIÓN DE NOTICIAS CON ETIQUETADO SOCIAL EN UNA RED SOCIAL CORPORATIVA', '15/11/2012', 118, 'default', 117, '139056736', NULL, NULL);
INSERT INTO propuesta VALUES ('INTERACCIÓN DE SERVICIOS POR EL MEDIO DE UNA INFRAESTRUCTURA SOA, PARA REALIZAR RECOMENDACIONES EN UNA INTERNET DE GENERACIÓN DE NOTICIAS', '', 119, 'default', 118, '156976261', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE RECONOCIMIENTO Y DIGITALIZACIÓN DE IMÁGENES DE PARTITURAS ESCRITAS A MANO', '', 136, 'default', 135, '156612529', NULL, NULL);
INSERT INTO propuesta VALUES ('ETIQUETADO EMOCIONAL IMPLÍCITO EN REDES SOCIALES DE NOTICIAS', '24/07/12', 120, 'default', 119, '166054109', NULL, NULL);
INSERT INTO propuesta VALUES ('SELECCIÓN DE PERSONAS BAJO EL ENFOQUE DE LA DIRECCIÓN POR VALORES', '24/07/2012', 121, 'default', 120, '168849516', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETIVOS DE APRNEDIZAJE PARA APOYART LA COMPRENSION Y APLICACION DE LA CRIPTOGRAFIA CLASICA ', '', 137, 'default', 136, '162648640', NULL, NULL);
INSERT INTO propuesta VALUES ('EL ENFOQUE DIÁLOGO-ACCIÓN: CASO DE LAS ACTAS DIALÓGICAS EN SCRUM USANDO TABLEROS KANBAN', '23/12/2014', 122, 'default', 121, '173387903', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE SEGUIMIENTO A CLIENTES Y DE APOYO A LAS REPARACIONES PARA UN TALLER MECÁNICO', '23/07/12', 138, 'default', 137, '137750406', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE VISUALIZACION DEL POSICIONAMIENTO GEORREFERENCIAL ON-LINE DE EQUIPOS DE EXTRACCION MINERA', '20/09/2011', 139, 'default', 138, '92174379', NULL, NULL);
INSERT INTO propuesta VALUES ('ESTRATEGIA DE PARALELIZACION DE SIMULACIONES DE EVENTOS DISCRETOS E INDEPENDIENTES EN GPU', '30/09/2013', 140, 'default', 139, '179043939', NULL, NULL);
INSERT INTO propuesta VALUES ('RESOLUCIÓN DEL GENERALIZED MINIMUN SPANNING TREE PROBLEM MEDIANTE ALGORITMOS GENÉTICOS', '', 141, 'default', 140, '158407337', NULL, NULL);
INSERT INTO propuesta VALUES ('CARACTERIZACIÓN Y OPTIMIZACIÓN DEL USO DE LA MEMORIA CACHE PARA EL ALGORITMO DE RECONSTRUCCIÓN ESTADÍSTICO DE IMÁGENES MÉDICAS EM-ML.', '23/08/10', 142, 'default', 141, '150881609', NULL, NULL);
INSERT INTO propuesta VALUES ('UNA ARQUITECTURA DISTRIBUIDA MULTIPLATAFORMA APLICADA A SIMULACIONES MONTE CARLO', '1/7/2014', 144, 'default', 143, '175657436', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO DE UNA API PARA LA IMPLEMENTACIÓN DE ALGORITMOS ESTADÍSTICOS DE RECONSTRUCCIÓN TOMOGRÁFICA DE IMÁGENES', '', 145, 'default', 144, '171464765', NULL, NULL);
INSERT INTO propuesta VALUES ('MODELACIÓN Y SIMULACIÓN DEL ESCÁNER PET SIEMENS BIOGRAPH', '26/12/12', 146, 'default', 145, '171002761', NULL, NULL);
INSERT INTO propuesta VALUES ('MODELAMIENTO E IMPLEMENTACION ORIENTADA A OBJETOS DE SIMULACIONES MONTE CARLO CONCURRENTES EN BIOLUMINISCENCIA MEDIANTE EL USO DE LA EXTENSION UC++', '', 147, 'default', 146, '168396449', NULL, NULL);
INSERT INTO propuesta VALUES ('ESTUDIO E IMPLEMENTACIÓN DE ALGORITMOS ESTADÍSTICOS PARALELOS, PARA LA RECONSTRUCCIÓN DE IMÁGENES.', '23/08/10', 148, 'default', 147, '143831639', NULL, NULL);
INSERT INTO propuesta VALUES ('HERRAMIENTA DE DISEÑO DE OBJETOS Y VISUALIZACIÓN DE RESULTADOS PARA SIMULACIÓN DE CAMPO MAGNÉTICO', '7/7/2014', 149, 'default', 148, '171907233', NULL, NULL);
INSERT INTO propuesta VALUES ('RECONTRUCCIÓN TOMOGRÁFICA PARALELA PARA UN ESCÁNER PET DE ANIMALES PEQUEÑOS', '', 150, 'default', 149, '155648511', NULL, NULL);
INSERT INTO propuesta VALUES ('SIMULACIÓN MONTE CARLO PARALELA DEL MODELO HEISENBERG PARA SISTEMAS FERROMAGNÉTICOS', '20/01/2014', 151, 'default', 150, '171052386', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO Y APLICACIÓN DE MODELO DINÁMICO EN AMBIENTE REAL DE CONMINUCIÓN PARA ESTIMAR EN LINEA VARIABLES CRÍTICAS DE MOLIENDA SEMIAUTÓGENA', '7/9/2012', 152, 'default', 151, '142035928', NULL, NULL);
INSERT INTO propuesta VALUES ('PREDICCIÓN DE FENÓMENOS SÍSMICOS EN UN ÁREA GEOGRÁFICA DETERMINADA USANDO REDES NEURONALES', '26/12/12', 153, 'default', 152, '166171644', NULL, NULL);
INSERT INTO propuesta VALUES ('ANÁLISIS COMPARATIVO DE MODELOS NARMA (X) Y NAR (X) USANDO REDES NEURONALES Y SVM SOBRE SISTEMAS CAÓTICOS', '28/12/12', 154, 'default', 153, '168401264', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE PREDICCIÓN DEL TRÁFICO DE UN MOTOR DE BÚSQUEDA WEB', '', 155, 'default', 154, '139047788', NULL, NULL);
INSERT INTO propuesta VALUES ('PREDICCION DE SERIES DE TIEMPO USANDO RN Y SVM', '', 156, 'default', 155, '173249616', NULL, NULL);
INSERT INTO propuesta VALUES ('CONSTRUCCIÓN DE MODELOS PREDICTIVOS PARA EL ÍNDICE DE DISPONIBILIDAD DE LOS EQUIPOS MINEROS PESADOS USANDO MODELOS DINÁMICOS CON RNA Y SVM', '22/01/2014', 157, 'default', 156, '170842804', NULL, NULL);
INSERT INTO propuesta VALUES ('PREDICCIÓN DE FENÓMENOS SÍSMICOS EN UN ÁREA GEOGRÁFICA DETERMINADA USANDO REDES NEURONALES Y MÁQUINAS DE VECTORES DE SOPORTE', '', 158, 'default', 157, '166928370', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA PROTOTIPO DE APOYO A LA ALERTA TEMPRANA DE SISMOS MEDIANTE USO DE HERRAMIENTAS DE INTELIGENCIA COMPUTACIONAL', '4/8/2014', 159, 'default', 158, '176314141', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA INFORMATICO PARA LA PREDICCIÓN DE FALLAS EN ANTENAS DEL OBSERVATORIO ALMA, UTILIZANDO HERRAMIENTAS DE INTELIGENCIA COMPUTACIONAL', '31/07/2013', 160, 'default', 159, '136865250', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO Y EVALUACIÓN DE UN MODELO CUANTITATIVO DE ESTIMACIÓN DE COMPONENTES MINERALÓGICOS DE ARCILLAS, A TRAVÉS DEL ANÁLISIS DEL ESPECTROGRAMA DEL INFRARROJO CERCANO (NIR), BASADO EN ALGORTIMOS COMPUTACIONALES, PARA EMPRESAS CUPRÍFERAS.', '7/11/2013', 161, 'default', 160, '16171898K', NULL, NULL);
INSERT INTO propuesta VALUES ('MODELO DINÁMICO PARA LA GESTIÓN DE FLOTAS DE PALAS EN FAENAS MINERAS', '23/01/2014', 162, 'default', 161, '166632749', NULL, NULL);
INSERT INTO propuesta VALUES ('ELABORACIÓN DE CLASIFICADORES PARA DETECCIÓN DE SEÑALES DE TIPO S Y P MEDIANTE REDES NAURONALES Y SVM', '7/8/2012', 163, 'default', 162, '16939816K', NULL, NULL);
INSERT INTO propuesta VALUES ('ELABORACION DE UN CLASIFICADOR DE SEÑALES SISMOGRAFICAS P Y S MEDIANTE SVM: ESTUDIO DE ALGORITMOS DE FILTRADO Y AUTOSIMILARIDAD', '30/09/2013', 164, 'default', 163, '170721993', NULL, NULL);
INSERT INTO propuesta VALUES ('CONSTRUCCIÓN DE UN MODELO PARA DETERMINAR VARIABLES DE DISPONIBILIDAD Y TIEMPO ENTRE FALLAS EN EL ÁREA DE LA MINERÍA', '24/12/2014', 165, 'default', 164, '181181486', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA COLABORATIVO WEB PARA EL ANÁLISIS Y EVALUACIÓN DE PLANES ESTRATÉGICOS', '', 166, 'default', 165, '158384043', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA COLABORATIVO DE APOYO AL APRENDIZAJE DE MATEMÁTICAS EN PRIMER AÑO BÁSICO', '', 167, 'default', 166, '169367353', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN SISTEMA COLABORATIVO PARA APOYAR EL REFORZAMIENTO DEL IDIOMA INGLÉS EN NIÑOS DE 5Tº AÑO BÁSICO', '9/2/2012', 168, 'default', 167, '170508157', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA COLABORATIVO PARA LA PLANIFICACIÓN DE PROYECTOS MEDIANTE CARTAS GANTT.', '', 169, 'default', 168, '161915602', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA COMUNICACIÓN MEDIADA COMPUTADOR PARA APOYAR EL AÁNILIS DE TEMAS EN GRUPOS', '', 170, 'default', 169, '166602181', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE APOYO AL  ANÁLISIS DE ASUNTOS PARA LA INGENIERÍA DE REQUERIMIENTOS ORIENTADA A ASPECTOS', '26/10/2012', 171, 'default', 170, '170630025', NULL, NULL);
INSERT INTO propuesta VALUES ('SOFTWARE DE APOYO AL SEGUIMIENTO DEL PLAN ESTRATÉGICO DE LA EMPRESA PÚBLICA EMERES', '23/10/2013', 172, 'default', 171, '153400253', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA COLABORATIVO PARA APOYAR LA PREPARACIÓN DE ENTREVISTAS Y SU POSTERIOR ANÁLISIS EN EL PROCESO DE CAPTURA DE REQUISITOS.', '', 173, 'default', 172, '163578476', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA COLABORATIVO PARA COMPLEMENTAR LA ENSEÑANZA DE NIÑOS ENTRE PRIMERO Y SEGUNDO BÁSICO EN LA ASIGNATURA DE INGLÉS', '', 174, 'default', 173, '170256158', NULL, NULL);
INSERT INTO propuesta VALUES ('UN MODELO PARA LA ESTIMULACIÓN DEL ESFUERZO EN PROYECTOS DE DESARROLLO DE SOFTWARE.', '', 175, 'default', 174, '162156055', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UNA GUÍA DE ESTRATEGIAS EN APOYO A LA INGENIERÍA DE REQUISITOS', '', 176, 'default', 175, '165570820', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACIÓN DE UN JUEGO COLABORATIVO QUE PERMITA EL DESARROLLO DE HABILIDADES METAFONOLÓGICAS EN NIÑOS DE ENTRE 4 Y 6 AÑOS', '', 177, 'default', 176, '170052781', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB Y MOVIL PARA FOMENTAR EL TURISMO', '23/09/2013', 178, 'default', 177, '180486011', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE COORDINACIÓN DE ACTIVIDADES ACADÉMICAS, REGISTRO DE NOTAS Y PLANES DE ESTUDIO PARA UNA ESCUELA DE ENSEÑANZA BÁSICA', '', 179, 'default', 178, '159166422', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACIÓN PARA MEJORAR EL SEGUIMIENTO DEL RENDIMIENTO Y LA CONDUCTA DE LOS ALUMNOS EN EL AULA DE CLASES', '', 180, 'default', 179, '172135528', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE GESTIÓN DE AYUDAS A PROYECTOS E IDEAS (GAPI)', '', 181, 'default', 180, '167995314', NULL, NULL);
INSERT INTO propuesta VALUES ('AUTOMATIZACIÓN DE PROCESOS DE INSPECCIONES DE VEHÍCULOS PARA RSA SEGUROS', '', 182, 'default', 181, '141610120', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACIÓN DE LA EFECTIVIDAD DE UNA PROPUESTA DE TOMA DE REQUIRIMIENTOS BASADA EN CIENCIAS SOCIALES.', '', 183, 'default', 182, '158385686', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACIÓN DE LA EFECTIVIDAD Y REFORMULACIÓN DE UNA PROPUESTA PARA LA ROMA DE REQUERIMIENTOS APLICADO A UN CASO PRÁCTICO', '', 184, 'default', 183, '158385686', NULL, NULL);
INSERT INTO propuesta VALUES ('METODOLOGIA DE HACKING ETICO PARA APLICACIONES WEB EN PRODUCCION', '20/07/2012', 185, 'default', 184, '171212243', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE APLICACIÓN COLABORATIVA PARA LA EVALUACIÓN DE USABILIDAD DE SOFTWARE STANDALONE BASADO EN FORMULARIO', '22/04/2013', 186, 'default', 185, '160076747', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE APOYO AL APRENDIZAJE DE LA LECTURA DE LOS NIÑOS', '', 187, 'default', 186, '152509022', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACIÓN WEB PARA ADMINISTRACIÓN DOCUMENTAL DE VEHÍCULOS', '16/12/2013', 330, 'default', 328, '163652838', NULL, NULL);
INSERT INTO propuesta VALUES ('HERRAMIENTA DE APOYO A LA DEFINICIÓN DE REQUISITOS, EN LA INGENIERÍA DE SOFTWARE, EXPLOTANDO RECURSOS DE AUDIO', '11/1/2013', 188, 'default', 187, '153877009', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACIÓN Y RECOMENDACIONES DE MEJORAS DE LA USABILIDAD DE BROWSERS WEB PARA USUARIOS ADULTOS MAYORES CON POCA EXPERIENCIA EN EL USO DE COMPUTADORES.', '', 189, 'default', 188, '161168440', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA COOPERATIVO PARA EL DESARROLLO DE INTERFACES GRÁFICAS', '', 190, 'default', 189, '184407604', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE APLICACIONES PARA EL APOYO EN LA INTERACCIÓN ANFITRIÓN-AUDIENCIA Y LA GENERACIÓN DE CONTENIDO EN PRESENTACIONES CON PROYECTOR', '14/08/2014', 191, 'default', 190, '169113823', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLAR UN AMBIENTE WEB QUE PERMITA REPRESENTAR  INFORMACIÓN ASOCIADA AL CRÉDITO HIPOTECARIO UTULIZANDO ORGANIZADORES GRÁFICOS PARA VIRTUALAB - USACH', '4/4/2013', 192, 'default', 191, '169561249', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE COMPONENTES DE SOFWARE EN HTML 5 QUE IMPLEMENTEN ORGANIZADORES GRAFICOS INTERACTIVOS', '', 193, 'default', 192, '169561249', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN AMBIENTE WEB UTILIZANDO ORGANIZADORES GRÁFICOS EN LA REPRESENTACIÓN DE CONTENODOS SOBRE EL INFARTO AGUDO AL MIOCARDIO.', '', 194, 'default', 193, '161509299', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE COMPONENTES DE SOFWARE QUE IMPLEMENTEN ESTRATEGIAS VISUALES PARA LA PRUDUCCIIÓN DE TEXTO ARGUMENTATIVO TIPO ENSAYO DE NIVEL BÁSICO TRES A SEIS.', '', 195, 'default', 194, '162648640', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE COMPONENTES DE SOFWARE PARA LA PRODUCCIÓN DE CUENTOS INFANTILES', '', 196, 'default', 195, '154010335', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN AMBIENTE WEB PROTOTIPO QUE PERMITA REPRESENTAR INFORMACIÓN DEL CRÉDITO HIPOTECARIO UTILIZANDO ORGANIZADORES GRÁFICOS.', '', 197, 'default', 196, '139047788', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE COMPONENTES DE SOFTWARE QUE IMPLEMENTEN DIAGRAMAS UTILIZADOS EN LA PLANEACIÓN ESTRATÉGICA.', '', 198, 'default', 197, '162430947', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE COMPONENTES DE SOFWARE PARA LA IMPLEMENTACIÓN DE HERRAMIENTAS QUE FACILITEN LA UTILIZACIÓN DE DIAGRAMAS PARA LA PLANIFICACIÓN DE MARKETING.', '', 199, 'default', 198, '162433903', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DE COMPONENTES DE SOFTWARE VISUALES QUE FACILITEN EL DESARROLLO DE LA HABILIDAD COGNITIVA DE LA CLASIFICACIÓN.', '', 200, 'default', 199, '158433761', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE COMPONENTES DE SOFTWARE QUE IMPLEMENTAN ESTRATEGIAS VISUALES PARA APOYAR LA CONCEPTUALIZACIÓN DE FRACCIONES EN ALUMNOS DE CUARTO BÁSICO.', '', 201, 'default', 200, '162774778', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE COMPONENTES DE SOFTWARE PARA FACILITAR LA PRODUCCIÓN DE TEXTO DISCURSIVO DE ALUMNOS ENTRE 5º Y 8º AÑO DE ENSEÑANZA BÁSICA.', '', 202, 'default', 201, '153182051', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE COMPONENTES VISUALES DE APOYO A COBIT.', '', 203, 'default', 202, '160076747', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DEL SISTEMA CAJA VECINA EN APLICACIONES TRANSACCIONALES DEL BANCO ESTADO', '28/11/12', 204, 'default', 203, '10797136K', NULL, NULL);
INSERT INTO propuesta VALUES ('SOLUCIÓN BASADA EN ESB PARA MIGRAR SOTWARE LEGADO CRITICO EN EL SISTEMA PÚBLICO', '4/1/2013', 205, 'default', 204, '130555292', NULL, NULL);
INSERT INTO propuesta VALUES ('PROYECTO INTRANET DE GENDARMERÍA DE CHILE', '10/1/2013', 206, 'default', 205, '130594220', NULL, NULL);
INSERT INTO propuesta VALUES ('IMPLEMENTACIÓN DE UN TERCER FACTOR DE AUTENTICACIÓN PARA AUTORIZACIÓN DE TRANSACCIONES EN LA BANCA INTERNET', '21/11/2012', 207, 'default', 206, '126560028', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DEL PORTAL WEB PARA LA MUNICIPALIDAD DE HIJUELAS', '5/12/2012', 208, 'default', 207, '165393678', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA ONLINE DE ENSEÑANZA DE ESTRATEGIAS ORIENTADO A LOS PADRES PARA APOYAR LAS TAREAS ESCOLARES DE LOS HIJOS', '9/2/2012', 209, 'default', 208, '162696513', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE GESTIÓN PARA EL HUERTO SANTA MERCEDES', '', 210, 'default', 209, '173110189', NULL, NULL);
INSERT INTO propuesta VALUES ('CREACIÓN Y APLICACIÓN DE OBJETOS DE APRENDIZAJES PARA EL APOYO A PROGRAMACIÓN COMPUTACIONAL', '14/12/12', 211, 'default', 210, '165385454', NULL, NULL);
INSERT INTO propuesta VALUES ('OBTENCIÓN DE LA CARGA ANUAL EQUIVALENTE (CAE) Y CARGA ANUAL EQUIVALENTE VIGENTE (CAEV) UTILIZANDO UN MÉTODO MATEMÁTICO PARA LA EMPRESA PENTAVIDA', '30/10/12', 212, 'default', 211, '161915602', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO E IMPLEMENTACIÓN DE LA ESTACIÓN DE TRABAJO EVEREST PARA EL BANCO DE CRÉDITO E INVERSIONES', '20/3/13', 213, 'default', 212, '163107155', NULL, NULL);
INSERT INTO propuesta VALUES ('CONSTRUCCIÓN Y APLICACIÓN DE OBJETOS DE APRENDIZAJE PARA LA UNIDAD DE ANÁLISIS LÉXICO DE LA ASIGNATURA COMPILADORES', '20/01/13', 214, 'default', 213, '151265588', NULL, NULL);
INSERT INTO propuesta VALUES ('UN SISTEMA WEB PARA MEJORAR EL RENDIMIENTO DE IMPRESORAS AL ENVIAR TRABAJOS DE IMPRESIÓN MASIVA', '', 215, 'default', 214, '141749579', NULL, NULL);
INSERT INTO propuesta VALUES ('LABORATORIO VIRTUAL DE MATEMÁTICAS "LABMAT3EM" PARA ESTABLECIMIENTOS MUNICIPALIZADOS', '', 216, 'default', 215, '167883273', NULL, NULL);
INSERT INTO propuesta VALUES ('LABORATORIO VIRTUAL DE MATEMÁTICAS "LABMAT3EM" PARA ESTABLECIMIENTOS MUNICIPALIZADOS', '', 217, 'default', 216, '167883273', NULL, NULL);
INSERT INTO propuesta VALUES ('UN SISTEMA DE APOYO AL PROCESO DE TITULACIÓN PARA EL DEPARTAMENTO DE INGENIERÍA INFORMÁTICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '', 218, 'default', 217, '16121874K', NULL, NULL);
INSERT INTO propuesta VALUES ('NO HAY INFORMACION', '', 219, 'default', 218, '101426750', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE REMUNERACIONES MODULO DE RELIQUIDACIONES', '30/11/2012', 220, 'default', 219, '143771512', NULL, NULL);
INSERT INTO propuesta VALUES ('SOLUCION INFORMATICA PARA SOLICITUDES DE INSCRIPCIONES DE ASIGNATURAS', '4/8/2010', 221, 'default', 220, '66163636', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE APOYO AL CONTROL DE GASTOS Y VIAJES DE VEHÍCULOS DE SERVICIOS DE TRANSPORTE DE LA EMPRESA TRASANDES S.A', '24/09/2013', 222, 'default', 221, '166944589', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE APOYO A LA GESTON DE ADQUISICIONES DE MATERIALES DE CONSTRUCCION DE LA CONSTRUCCION KOPPMANN', '7/4/2011', 223, 'default', 222, '143404773', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE APOYO A LA ADMINISTRACION DEL GIMNASIO "PUNTO VITAL"', '20/09/2011', 224, 'default', 223, '153150958', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE BUSQUEDA Y VISUALIZACIÓN DE INFORMACIÓN PARA LA BIBLIOTECA CIENTÍFICA DE CONICYT', '20/09/11', 225, 'default', 224, '132541159', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE GESTIÓN DE COMPRA DE VEHÍCULOS Y EQUIPAMIENTOS PARA EMPRESA SALFA RENT', '30/11/12', 226, 'default', 225, '15890828k', NULL, NULL);
INSERT INTO propuesta VALUES ('ADMINISTRACIÓN Y TRACKING DE ACTIVOSDE UNA EMPRESA DE SERVICIOS DE ARRIENDO DE CONTENEDORAS', '23/01/2013', 227, 'default', 226, '135486108', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACIÓN WEB PARA APOYAR LA GESTIÓN DE MÁQUINAS VIRTUALES EN LA EMPRESA ADESSA LTDA.', '07/0912', 228, 'default', 227, '128773843', NULL, NULL);
INSERT INTO propuesta VALUES ('UN SISTEMA PARA LA GESTION DE FALLAS EN CENTRALES ELECTRICAS', '22/05/2012', 229, 'default', 228, '139141628', NULL, NULL);
INSERT INTO propuesta VALUES ('UNA HERRAMIENTA DE APOYO A LA EVALUACIÓN DEL CONTROL INTERNO EN COOPERATIVAS DE AHORRO Y CREDITO', '30/11/12', 230, 'default', 229, '143180646', NULL, NULL);
INSERT INTO propuesta VALUES ('AUTOMATIZACIÓN DE LA INVITACIÓN A OFERTAR EN LICITACIONES DE SAP - SRM EN CODELCO', '8/4/2013', 231, 'default', 230, '106677514', NULL, NULL);
INSERT INTO propuesta VALUES ('IMPLEMENTACIÓN DE PLATAFORMA DE ALTA DISPONIBILIDAD PARA SISTEMA WEB', '26/12/12', 232, 'default', 231, '16178883K', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE APOYO AL CONTROL ACADÉMICO PARA LA ACADEMIA POLITÉCNICA AERONÁUTICA DE FUERZA AÉREA DE CHILE', '11/7/2012', 279, 'default', 278, '163215454', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE LICENCIAS MEDICAS EN UNA CAJA DE COMPENSACION', '4/8/2010', 422, 'default', 420, '130273513', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO UN SISTEMA DE APOYO A LA PLANIFICACION DOCENTE PARA EL DEPARTAMENTO DE INGENIERIA INFORMATICA DE LA FACULTAD DE INGENIERIA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '', 233, 'default', 232, '167485081', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA PARA LA ADMINISTRACIÓN DE PROVEEDORES Y PRODUCTOS DE LA MICROEMPRESA FCI LTDA.', '', 234, 'default', 233, '166606322', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA PARA LA CERTIFICACIÓN Y SUPERVISIÓN DE VENTA DE MÚSICA DIGITALIZADA', '11/1/2013', 235, 'default', 234, '132803188', NULL, NULL);
INSERT INTO propuesta VALUES ('PROPUESTA PRUEBA 2', '29/04/2015', 597, '1/2015', 591, '172288987', false, NULL);
INSERT INTO propuesta VALUES ('SISTEM DE FACTURACIÓN ENTRE SOCIEDADES DE ENJOY POR CANJE DE PROMOCIONES Y PRESTACIÓN DE SERVICIOS', '', 236, 'default', 235, '138381072', NULL, NULL);
INSERT INTO propuesta VALUES ('CREACIÓN DE UN SISTEMA GENERADOR DE DIFERENTES SERIES DE INSTRUMENTOS DE EVALUACIÓN PARA LA COORDINACIÓN DE FUNDAMENTOS DE COMPUTACIÓN Y PROGRAMACIÓN DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '18/08/2014', 237, 'default', 236, '173865090', NULL, NULL);
INSERT INTO propuesta VALUES ('PROPUESTA DEL GLEN', '30/04/2015', 596, '1/2015', 590, '167110614', false, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE APLICACIÓN MÓVIL PARA MONITOREO, DETECCIÓN Y ALERTA AUTOMÁTICA DE CRISIS EPILÉPTICA CONVULSIVA', '', 238, 'default', 237, '15068143K', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA ADMINISTRADOR DE ACCESOS PARA USUARIOS EN SAP', '', 239, 'default', 238, '139060806', NULL, NULL);
INSERT INTO propuesta VALUES ('PREDICCIÓN DE ESTADIA DE PACIENTES HOSPITALIZADOS EN LA UNIDAD DE CUIDADOS INTENSIVOS ADULTOS EN UNA CLINICA PRIVADA DE SANTIAGO', '1/10/2014', 240, 'default', 239, '151737943', NULL, NULL);
INSERT INTO propuesta VALUES ('ANÁLISIS Y DESARRLLO DE UN DSS PARA LA SELECCIÓN DE PERSONAS TI', '10/5/2010', 241, 'default', 240, '156039020', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN SISTEMA DE SERVICIOS DE MAPAS WEB PARA VISUALIZACION Y USO DE PRODUCTOS TOPOGRAFICOS ELABORADOS POR EL SAF', '', 242, 'default', 241, '138819280', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACIÓN DEL EFECTO DE FACTORES EXTERNOS EN LA RESOLUCIÓN DE UN PROBLEMA NP-C UTILIZANDO JUEGOS COMPUTACIONALES.', '4/7/2011', 243, 'default', 242, '141976974', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB PARA POTENCIAR RELACION DE CLIENTES Y PROVEEDORES DE DISTRIBUIDORAS DE ABARROTES, LICORES Y CARNES', '7/4/2011', 244, 'default', 243, '139371127', NULL, NULL);
INSERT INTO propuesta VALUES ('MODELO PARA LA ESTIMACIÓN DE LA VARIABILIDAD DE LOS COSTOS EN LA FORMULACIÓN DE PROYECTOS DE TECNOLO GÍAS DE LA INFORMACIÓN.', '', 245, 'default', 244, '162156055', NULL, NULL);
INSERT INTO propuesta VALUES ('PROTOTIPO DE SOFTWARE Y ESTUDIO DE MERCADO DE UNA PLATAFORMA SOCIAL DE APRENDIZAJE.', '6/9/2010', 246, 'default', 245, '158377365', NULL, NULL);
INSERT INTO propuesta VALUES ('NO HAY INFORMACION', '', 247, 'default', 246, '130680526', NULL, NULL);
INSERT INTO propuesta VALUES ('MODELO PREDICTIVO PARA LA VENTA-CRUZADA DE PRODUCTOS FINANCIEROS UTILIZANDO MINERÍA DE DATOS.', '', 248, 'default', 247, '139056736', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA PARA EL SEGUIMIENTO Y CONTROL DE LA OPERATIVIDAD DE SERVIDORES DEL AREA TIC DE CARABINEROS DE CHILE', '4/8/2010', 249, 'default', 248, '134405155', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE REALIDAD AUMENTADA PARA LA DIFUSIÓN DE INFORMACIÓN DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '14/01/2013', 250, 'default', 249, '169087350', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO E IMPLEMENTACIÓN DE APLICACIÓN MÓVIL EN ANDROID PARA EL CONTROL PERSONALIZADO DE LA ALIMENTACIÓN', '22/01/2014', 251, 'default', 250, '173819803', NULL, NULL);
INSERT INTO propuesta VALUES ('PROTOTIPO PARA LA DETECCIÓN DE MALWARE EN EL SISTEMA OPERATIVO', '', 252, 'default', 251, '169039682', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DE SISTEMA DE INFORMACIÓN DE APOYO DE GESTIÓN DE INVENTARIO DE LA EMPRESA COMERCIAL E INDUSTRIAL BERMUDAS S.A.', '', 253, 'default', 252, '172552609', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WED PARA SUBASTAR VIDEOS DE CAZANOTICIAS ENTRE CANALES DE TELEVISIÓN', '23/07/2012', 254, 'default', 253, '172320104', NULL, NULL);
INSERT INTO propuesta VALUES ('DATAMART PARA UN SISTEMA DE REPORTES DE TIEMPOS EN LÍNEA DE ENLACES DE TELECOMUNICACIONES', '30/07/2013', 255, 'default', 254, '141234153', NULL, NULL);
INSERT INTO propuesta VALUES ('UN PROTOTIPO DE SOFWARE DE APOYO PARA EL TEST DE CAFRA.', '', 256, 'default', 255, '163867052', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE FACTURACIÓN ELECTRÓNICA, INVENTARIO Y PRESUPUESTOS WEB PARA TALLER DE TORNERÍA TRIFLEX', '9/2/2012', 257, 'default', 256, '16569953K', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMAS PARA LA DETECCIÓN PREVENTIVA DE BAJOS RENDIMIENTOS ACADÉMICOS DE ALUMNOS DEL MÓDULO BÁSICO DE LA FACULTAD DE INGENIERÍA', '', 258, 'default', 257, '156434027', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE APOYO A LA GESTIÓN DE UNA ORGANIZACIÓN COMUNITARIA', '31/03/2014', 259, 'default', 258, '171818575', NULL, NULL);
INSERT INTO propuesta VALUES ('PROPUESTA DE MÉTODO ÁGIL DE DESARROLLO DE SOFTWARE FUNCIONAL, USABLE Y SEGURO', '', 260, 'default', 259, '170291220', NULL, NULL);
INSERT INTO propuesta VALUES ('PROTOTIPO DE SISTEMA DE DETECCIÓN DE INTRUSOS BASADO EN HOST PARA ANDROID', '5/12/2012', 261, 'default', 260, '172510957', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE INFORMACIÓN Y AUTOMATIZACIÓN WEB PARA GESTIÓN Y ADMINISTRACIÓN DE SERVICIOS Y RECURSOS DEL COMPLEJO TURÍSTICO ATALAYA LANALHUE.', '', 262, 'default', 261, '159598314', NULL, NULL);
INSERT INTO propuesta VALUES ('PROTOTIPO DE APLICACIÓN MÓVIL PARA LA DETECCIÓN DE MALWARE EN DISPOSITIVOS CON SISTEMA OPERATIVO ANDROID', '29/07/2014', 263, 'default', 262, '172974325', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE ACTAS DE SESIONES DE CONSEJO Y AGENDA DEPARTAMENTAL.', '', 264, 'default', 263, '151049486', NULL, NULL);
INSERT INTO propuesta VALUES ('PROPUESTA DE MÉTODO ÁGIL DE DESARROLLO DE SOFTWARE FUNCIONAL, USABLE Y SEGURO.', '24/07/2014', 265, 'default', 264, '170291220', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACIÓN ANDROID UTILIZANDO REALIDAD AUMENTADA PARA LA UBICACIÓN ESPACIAL DE SITIOS DE INTERÉS', '23/01/2014', 266, 'default', 265, '170289943', NULL, NULL);
INSERT INTO propuesta VALUES ('PROTOTIPO DE SISTEMA DE DETECCIÓN DE MALWARE PARA DISPOSITIVOS ANDROID', '20/01/2014', 267, 'default', 266, '173028318', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN PLAN DE CONTINGENCIA Y RECUPERACIÓN ANTE DESASTRES PARA EL ÁREA INFORMÁTICA DE LA EMPRESA ARCADIS CHILE', '26-12-2012', 268, 'default', 267, '166096502', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACION DE UNA PLATAFORMA VIRTUALIZADA DE SERVICIOS INTEGRADOS PARA EL DEPARTAMENTO DE INGENIERIA EN INFORMATICA', '24/09/2013', 269, 'default', 268, '180762353', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE GESTIÓN ADMINISTRATIVA DE ALUMNOS PARA EL COLEGIO PUKARAY.', '', 270, 'default', 269, '170483685', NULL, NULL);
INSERT INTO propuesta VALUES ('PROTOTIPO DE SISTEMA WEB PARA LA GESTIÓN Y CONSOLIDACIÓN DE INFORMACIÓN ADMINISTRATIVA COMO APOYO AL PROCESO DE ACREDITACIÓN DE LOS PROGRAMAS DEL DEPARTAMENTO DE INGENIERÍA INFORMÁTICA', '23/01/2014', 271, 'default', 270, '173900996', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE GESTIÓN DE LA SEGURIDAD DE LA INFORMACIÓN PARA EL DIINF', '24/12/2014', 272, 'default', 271, '164729931', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN ASISTENTE PARA EL SOFTWARE GREI QUE PERMITA GUIAR A LOS DOCENTES EN LA CREACIÓN DE SECUENCIAS INTERACTIVAS DE APRENDIZAJE RESGUARDANDO CRITERIOS DIDÁCTICOS-MATEMÁTICOS', '7/4/2014', 273, 'default', 272, '161163813', NULL, NULL);
INSERT INTO propuesta VALUES ('CURSE DE CREDITOS HIPOTECARIO EN WORKFLOW', '5/12/2012', 274, 'default', 273, '122596451', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UNA HERRAMIENTA DE SOFTWARE BASADA EN UN MARCO DE TRABAJO PARA LA GUÍA DE GESTIÓN DE PROYECTOS TI PARA PUMES', '', 275, 'default', 274, '166570727', NULL, NULL);
INSERT INTO propuesta VALUES ('METODOLOGIA DE TRABAJO PARA LA GESTION DE PROYECTOS TI EN PYMES', '30/09/2013', 276, 'default', 275, '169102627', NULL, NULL);
INSERT INTO propuesta VALUES ('TESTING DE CORE BUSINESS PARA UNA EMPRESA DE TELECOMUNICACIONES', '18/03/2013', 277, 'default', 276, '123957016', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO  E IMPLEMENTACIÓN DE UN DATAMART PARA EL APOYO A LAS VENTAS DEL GRUPO SIG', '13/06/2012', 278, 'default', 277, '160319135', NULL, NULL);
INSERT INTO propuesta VALUES ('HOLA', '23/04/2015', 598, '1/2015', 592, '166257344', false, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN DATAWAREHOUSE Y DE REPORTES DE APOYO PARA EL ÁREA GLOBAL BPO DE UN CLIENTE DE LA EMPRESA METRIC ARTS', '23/05/2013', 281, 'default', 280, '168036639', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE INFORMACION WEB PARA EL CONTROL DE ORDENES DE TRABAJO EN IMPRENTA COLORAMA S.A', '3/15/2011', 282, 'default', 281, '160319135', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE CONTROL Y SOPORTE DE INFORMACIÓN AL SERVICIO TÉCNICO DE LA EMPRESA PROYEXION SERVICIOS S.A.', '4/12/2013', 283, 'default', 282, '135237566', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE APOYO A LA ADMINISTRACIÓN DEL CONTROL DE CAMBIOS EN SERVIDORES DELA PLATAFORMA WINTEL DE HP', '', 284, 'default', 283, '153447586', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB PARA PUBLICACION Y AYUDA A LA COMPRA-VENTA DE AUTOS DE EL PORTAL DEL AUTO', '', 285, 'default', 284, '159975509', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE APOYO A LA LABOR COMERCIAL DE UNA EMPRESA DISTRIBUIDORA DE GAS LICUADO', '7/4/2011', 286, 'default', 285, '129799927', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACION DE APOYO AL DEPARTAMENTO DE RECURSOS HUMANOS PARA "AMEC ING Y CONSTRUCCIÓN LTDA"', '26/12/2012', 287, 'default', 286, '119905621', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE APOYO A LA ATENCIÓN DE CLIENTES', '23/01/13', 288, 'default', 287, '155885173', NULL, NULL);
INSERT INTO propuesta VALUES ('MODELACIÓN LINE-PACK DE LA OPERACIÓN DEL GASODUCTO GAS ATACAMA MEDIANTE REDES NEURONALES ARTIFICIALES ', '', 289, 'default', 288, '126355971', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA INTEGRADO DE REMUNERACIONES Y DECLARACIÓN JURADA ANUAL DE RENTAS', '10/7/2014', 290, 'default', 289, '118425480', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO UN SISTEMA WEB DE APOYO A LA ADMINISTRACION DE PROYECTOS DE INGENIERIA EN LA EMPRESA L&C', '', 291, 'default', 290, '161173800', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO E IMPLEMENTACIÓN DE DATAMART PARA LA GERENCIA COMERCIAL DE UNA ASOCIACIÓN GENERAL DE FONDOS', '19/08/2014', 292, 'default', 291, '169592306', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA MONITOR DE DISPOSITIVOS ELECTRÓNICOS EN UNA PLANTA TRASMISORA DE FRECUENCIA MODULADA', '8/3/2013', 293, 'default', 292, '172683843', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE APOYO A LA GESTIÓN DE FRANQUICIAS MÉDICAS-DENTALES PARA ALUMNOS DE LA UNIVERSIDAD DE CHILE', '14/07/2014', 294, 'default', 293, '102607376', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE APOYO A LA GESTION DE MONITOREO Y SEGUIMIENTO DEL TRABAJO EN EL AUTO', '7/4/2011', 295, 'default', 294, '156663859', NULL, NULL);
INSERT INTO propuesta VALUES ('NO HAY INFORMACION', '', 296, 'default', 295, '155446099', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE APOYO A LA GESTION DE BODEGA PARA LA EMPRESA MC2', '', 297, 'default', 296, '164735737', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE EVALUACIÓN DE DESEMPEÑO PARA EL PERSONAL DE OFICIALES DE LA FUERZA AÉREA DE CHILE', '11/7/2012', 298, 'default', 297, '163549239', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE APOYO A LA GESTION DEL AREA DE SOPORTE COMPUTACIONAL PARA LA EMPRESA MARCARIA.COM', '7/4/2011', 299, 'default', 298, '141968092', NULL, NULL);
INSERT INTO propuesta VALUES ('IMPLEMENTACIÓN DE UN ERP DE APOYO A LA ADMINISTRACIÓN DEL SALÓN DE BELLEZA ÁRTICO', '18/08/2014', 300, 'default', 299, '179512130', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLAR UN JUEGO COMO HERRAMIENTA DE APRENDIZAJE PARA EL CURSO DE ECONOMÍA DE LA FACULTAD TECNOLÓGICA    ', '25/09/2014', 301, 'default', 300, '16375228K', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLAR UN SISTEMA DE APOYO A LA GESTION DE FICHAS,HORAS Y MEDICAMENTOS PARA LA POSTA RURAL DE PENCAHUE BAJO', '', 302, 'default', 301, '171663741', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE APOYO AL PRCOESO DE EVALUACIÓN ECONÓMICA SOCIAL DE PROYECTOS DE VIALIDAD URBANA', '26/12/2012', 303, 'default', 302, '98953051', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DEL SISTEMA SAP SRM PARA LA EMPRESA MULTINACIONAL ALFA', '18/03/13', 304, 'default', 303, '139147820', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE APOYO A LA GESTIÓN DE UN CENTRO DE DISTRIBUCIÓN', '17/07/2014', 305, 'default', 304, '122550915', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE GENERACION Y SEGUIMIENTO DE REQUERIMIENTOS DE SOPORTE PARA SISTEMAS LTDA.', '7/4/2011', 306, 'default', 305, '126305478', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE INFORMACION DE APOYO A LOS PROCESOS DE VENTA E INVENTARIO PARA LA EMPRESA RODAMIENTO "VILLELA"', '', 307, 'default', 306, '157559281', NULL, NULL);
INSERT INTO propuesta VALUES ('REDISEÑO DEL PROCESO DE NEGOCIO ASOCIADO AL SERVICIO DE ARRIENDO DE GRÚAS HORQUILLA, PARA LA EMPRESA GRÚAS M&L LTDA.', '7/1/2015', 308, 'default', 307, '169561249', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLAR UN JUEGO COMO HERRAMIENTA DE APRENDIZAJE PARA EL CURSO DE ECONOMÍA DE LA FACULTAD TECNOLÓGICA    ', '1/10/2014', 309, 'default', 308, '167535682', NULL, NULL);
INSERT INTO propuesta VALUES ('AUTOMATIZACIÓN DEL PROYECTO DE FORMALIZACIÓN DE SUBSIDIOS DE CORFO', '20/03/2013', 310, 'default', 309, '151138853', NULL, NULL);
INSERT INTO propuesta VALUES ('IMPLEMENTACIÓN DEL PROCESO DE FORMALIZACIÓN DE SUBSIDIOS DE CORFO EN ADOBE LIVE CYCL', '21/10/2014', 311, 'default', 310, '151138853', NULL, NULL);
INSERT INTO propuesta VALUES ('RESOLUCIÓN DE KO THREATS UTILIZANDO HEURÍSTICAS EN MONTE CARLO GO.', '', 312, 'default', 311, '163601311', NULL, NULL);
INSERT INTO propuesta VALUES ('USO DE GPU EN ALGORITMOS DE BUSQUEDA LOCAL PARA EL PROBLEMA DE LA ASIGNACION CUADRATICA', '5/10/2011', 313, 'default', 312, '171679249', NULL, NULL);
INSERT INTO propuesta VALUES ('ACERELERACION DE DESEMPEÑO DEL ALGORITMO DE BUSQUEDA LOCAL PARA FLOW SHOP USANDO PROCESADORES GRAFICOS', '7/10/2011', 314, 'default', 313, '170215710', NULL, NULL);
INSERT INTO propuesta VALUES ('ALGORITMO DE AGRUPAMIENTO PARA DATOS DE EXPRESIÓN GÉNICA DE RNA-SEQ CON LA INCORPORACIÓN DE ANOTACIONES BIOLÓGICAS', '14/08/2014', 315, 'default', 314, '175975721', NULL, NULL);
INSERT INTO propuesta VALUES ('ALGORITMO MEMÉTICO BASADO EN CONOCIMIENTO BIOLÓGICO PARA EL PROBLEMA DE PREDICCIÓN DE LA ESTRUCTURA TRIDIMENSIONAL DE LA PROTEÍNA', '20/01/2014', 316, 'default', 315, '171509688', NULL, NULL);
INSERT INTO propuesta VALUES ('CONSTRUCCIÓN DE UN FRAMEWORK PARA PIPELINE DE APLICACIONES DE BIOINFORMÁTICA', '22/01/2014', 317, 'default', 316, '165626826', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO Y DESARROLLO DE UN ALGORITMOS DE BÚSQUEDA DE ARN OBJETIVOS PARA UN MICROARN', '22/6/2012', 318, 'default', 317, '161561444', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE EVALUCIÓN FORMATIVA EN LINEA PARA LA SOCIEDAD CHILENA DE RADIOLOGIA', '', 319, 'default', 318, '141645064', NULL, NULL);
INSERT INTO propuesta VALUES ('ALGORITMO PARA LA VISUALIZACIÓN DE DATOS EXPERIMENTOS DE MIROARRAYS BASADOS EN ANOTACIONES BIOLÓGICAS Y EXPRESIÓN GENÉTICA', '25/07/2012', 320, 'default', 319, '167891497', NULL, NULL);
INSERT INTO propuesta VALUES ('GRAFO DE CONSENSO DE FUENTES DE ANOTACIONES BIOLÓGICAS DE GENES HUMANOS ', '22/01/2014', 321, 'default', 320, '167998186', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UNA APLICACIÓN WEB PARA EL APOYO AL ANÁLISIS DE DATOS RT-PCR.', '', 322, 'default', 321, '173169906', NULL, NULL);
INSERT INTO propuesta VALUES ('INCORPORACIÓN DE ANOTACIONES GENÉTICAS EN EL ALGORITMO DE AGRUPAMIENTO MST -KNN', '25/07/2012', 323, 'default', 322, '164780430', NULL, NULL);
INSERT INTO propuesta VALUES ('REINGENIERIA PORTAL DE PAGOS DEL ESTADO PARA TESORERÍA GENERAL DELA REPÚBLICA', '31/07/2013', 324, 'default', 323, '130597572', NULL, NULL);
INSERT INTO propuesta VALUES ('PLATAFORMA DE MONITOREO WEB DE CUENTAS DE TWITTER PARA PROYECTO FONDEF D09I1185 "OBSERVATORIO ESCALABLES DE LA WEB EN TIEMPO REAL"', '', 325, 'default', NULL, '154841970', NULL, NULL);
INSERT INTO propuesta VALUES ('ANÁLISIS DE TÉCNICAS PARA FILTRADO DE NOTICIAS DE LA WEB', '7/9/2012', 326, 'default', 324, '120324314', NULL, NULL);
INSERT INTO propuesta VALUES ('CLASIFICACIÓN AUTOMÁTICA DE TEXTOS PERIODÍSTICOS ENRIQUECIDA CON FUENTES EXTERNAS', '5/3/2012', 327, 'default', 325, '159674290', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE SEGUIMIENTO DE JUICIOS PARA GESTIÓN DE COBRANZA', '20/08/12', 328, 'default', 326, '120101099', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACIÓN DE ALGORITMOS PARA LA IDENTIFICACIÓN DE ESTRUCTURA DE SITIOS WEB CON APLICACIONES EN RECOLECTORES FOCALIZADOS DE LA WEB.', '', 329, 'default', 327, '164324206', NULL, NULL);
INSERT INTO propuesta VALUES ('MÓDULOS DEL SISTEMA INFORMÁTICO PARA APOYAR LA GESTIÓN EN UNA EMPRESA DE RETAIL', '5/8/2013', 331, 'default', 329, '134428244', NULL, NULL);
INSERT INTO propuesta VALUES ('SDAFASFASD', '22/04/2011', 599, '1/2010', NULL, '167110614', false, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UNA API PARA LA ASOCIACIÓN DE PERSONAS Y EL CONTENIDO DE NOTICIAS EN ESPACIOS.', '', 332, 'default', 330, '174176264', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACIÓN DE REPORTES CON EL CONTEXTO DE NOTICIAS EN TWITTER.', '', 333, 'default', 331, '170309545', NULL, NULL);
INSERT INTO propuesta VALUES ('ANÁLISIS DE SENTIMIENTO EN EL SISTEMA DE RED SOCIAL TWITTER', '', 334, 'default', 332, '169847029', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑOS DE UN CLASIFICADOR DE PATENTES INDUSTRIALES', '20/07/2012', 335, 'default', 333, '167441823', NULL, NULL);
INSERT INTO propuesta VALUES ('API PARA LA VISUALIZACIÓN DE RELACIONES EXISTENTES ENTRE CONTACTOS PERSONALES A TRAVÉS DE REDES SOCIALES.', '', 336, 'default', 334, '174052255', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN SISTEMA DE GESTION HORARIA PARA RECURSOS DE UNA EMPRESA DE DEPILACION LASER', '25/07/2012', 337, 'default', 335, '173136986', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO DE UN ALGORITMO DE PLANIFICACIÓN PARA APLICACIONES PARALELAS SOBRE RECURSOS HETEROGÉNEOS EN CLOUD COMPUTING', '15/06/2012', 338, 'default', 336, '163225816', NULL, NULL);
INSERT INTO propuesta VALUES ('PLATAFORMA DE EVALUACIÓN DE ALGORITMOS DE SUBASTA PARA BUSQUEDAS PATROCINADAS', '19/07/2012', 339, 'default', 337, '168039891', NULL, NULL);
INSERT INTO propuesta VALUES ('ANÁLISIS DE LA SATISFACCIÓN DE CLIENTES MEDIANTE EL ANÁLISIS DE CORREOS ELECTRÓNICOS', '25/03/2013', 340, 'default', 338, '160081937', NULL, NULL);
INSERT INTO propuesta VALUES ('INTEGRACIÓN ERP MICROSOFT DYNAMICS AX CON SISTEMA WEB EXTERNO PARA EL INGRESO DE PEDIDOS DE VENTA', '15/4/13', 341, 'default', 339, '141861239', NULL, NULL);
INSERT INTO propuesta VALUES ('ACTUALIZACIÓN CONCURRENTE DE ÍNDICES INVERTIDOS EN MOTORES DE BÚSQUEDA VERTICALES', '22/12/2014', 342, 'default', 340, '170222156', NULL, NULL);
INSERT INTO propuesta VALUES ('DETERMINACIÓN DE LA INFLUENCIA DE ESTÍMULOS SONOROSY SU EMOCIÓN EN LA AUTORREGULACIÓN.', '7/8/2012', 343, 'default', 341, '167432530', NULL, NULL);
INSERT INTO propuesta VALUES ('DETERMINACIÓN DE LA INFLUENCIA DE ESTÍMULOS MUSICALES EN LA AUTORREGULACIÓN DEL FLUJO SANGUÍNEO CEREBRAL.', '3/1/2012', 344, 'default', 342, '171679249', NULL, NULL);
INSERT INTO propuesta VALUES ('PRE-PROCESAMIENTO DE SEÑALES DE HEMODINÁMICA CEREBRAL PARA ESTUDIOS DE AUTTOREGULACION DEL FLUJO SANGUINEO CEREBRAL', '7/4/2011', 345, 'default', 343, '11480715K', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA DE CONTRASTE DE HIPÓTESIS BASADO EN BOOTSTRAP', '', 346, 'default', 344, '165319559', NULL, NULL);
INSERT INTO propuesta VALUES ('ANÁLISIS DE LA COMPLEJIDAD DE LAS SEÑALES DEL SISTEMA DE HEMODINÁMICA CEREBRAL Y LA RELACIÓN DE ESTA CARACTERÍSTICA CON SU MODELAMIENTO', '', 347, 'default', 345, '167485405', NULL, NULL);
INSERT INTO propuesta VALUES ('ANALISIS COMPARATIVO ENTRE METODOS PARA EL CALCULO DE LA AUTORREGULACION CEREBRAL QUE USAN CAMBIOS BRUSCOS DE PRESION Y VARIACIONES ESPONTANEAS UTILIZANDO SVM', '30/09/2013', 348, 'default', 346, '169969329', NULL, NULL);
INSERT INTO propuesta VALUES ('COMPARACIÓN DE LOS MÉTODOS DE CÁLCULO DE AUTOREGULACIÓN USANDO MODELOS LINEALES CON LA MANIOBRA DE VALSALVA Y VARIACIONES ESPONTANEAS DE PRESIÓN', '4/9/2014', 349, 'default', 347, '163219689', NULL, NULL);
INSERT INTO propuesta VALUES ('MODIFICACION DE LOS METODOS DE DETECCION DE LATIDOS CARDIACOS PARA SER UTILIZADOS EN LA ESTIMACION DE SEÑALES DE PSAM Y FSCM', '', 350, 'default', 348, '167282032', NULL, NULL);
INSERT INTO propuesta VALUES ('SOLUCIÓN DE INTELIGENCIA DE NEGOCIOS Y MODELO PREDICTIVO COMO APOYO A LA GESTIÓN DE INDICADORES CLÍNICOS EN CLÍNICA ALEMANA DE SANTIAGO', '', 351, 'default', 349, '130441793', NULL, NULL);
INSERT INTO propuesta VALUES ('SELECCIÓN DE CARACTERÍSTICAS PARA LA ESTIMACIÓN DE NIVELES DE PRESIÓN INTRACRANEAL EN FORMA NO INVASIVA.', '', 352, 'default', 350, '164751392', NULL, NULL);
INSERT INTO propuesta VALUES ('CREACIÓN DE MODELOS DE CLASIFICACIÓN PARA CULTIVOS NEURONALES CON CLASES DESBALANCEADAS Y BÚSQUEDA DE VARIABLES REPRESENTATIVAS', '19/05/2014', 353, 'default', 351, '16612106K', NULL, NULL);
INSERT INTO propuesta VALUES ('CLASIFICACION DEL GRUPO SOCIO ECOOMICO UTILIZANDO VARIABLES DE CONSUME DE PRODUCTOS DE SUPERMERCADO', '3/4/2013', 354, 'default', 352, '132575568', NULL, NULL);
INSERT INTO propuesta VALUES ('MEJORAMIENTO DEL ÍNDICE DE AUTORREGULACIÓN DE FLUJO SANGUÍNEO CEREBRAL (ARI) MEDIANTE LA MEDICIÓN DE FASE ENTRE PRESIÓN Y FLUJO.', '', 355, 'default', 353, '166810388', NULL, NULL);
INSERT INTO propuesta VALUES ('COMPARACIÓN DE LOS MÉTODOS DE CÁLCULO DE AUTORREGULACIÓN CON LA MANIOBRA "SIT-TO-STAND" Y VARIACIONES ESPONTÁNEAS DE PRESIÓN', '20/01/2014', 356, 'default', 354, '145012163', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DE UNA HERRAMIENTA PARA LA CATEGOGORIZACIÓN DE PACIENTES EN SERVICIOS DE URGENCIA ', '', 357, 'default', 355, '164182169', NULL, NULL);
INSERT INTO propuesta VALUES ('IDENTIFICACIÓN DE EVENTOS DE TRANSFERENCIA HORIZONTAL DE GENES EN BACTERIAS MEDIANTE DISEÑO DE CLASIFICADORES DE DATOS', '28/12/12', 358, 'default', 356, '167472982', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO DE UN CLASIFICADOR PARA LA DETECCIÓN DEL MOBILOMA EN GENOMAS DE BACTERIAS', '24/04/2014', 359, 'default', 357, '167472982', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACIÓN COMPARATIVA DE MÑETODOS DE MINERÍA DE DATOS PARA LA CLASIFICACIÓN DE SEÑALES SÍSMICAS DEL VOLCÁN LLAIMA', '28/12/12', 360, 'default', 358, '167116116', NULL, NULL);
INSERT INTO propuesta VALUES ('OPTIMIZACIÓN Y MEJORAS A PROCESOS EJECUTADOS PARA LA OBTENCIÓN DE LOS ESTADOS DE RESULTADOS COMERCIALES DE LAN CHILE', '9/1/2013', 361, 'default', 359, '105018274', NULL, NULL);
INSERT INTO propuesta VALUES ('USO DE TÉCNICAS DE CAJA GRIS Y FUNCIÓN DE TRANSFERENCIA PARA MODELAR LA AUTORREGULACIÓN CEREBRAL', '9/2/2012', 362, 'default', 360, '161240176', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA PARA CONTROL DE ENVÍO Y RECEPCIÓN DE MENSAJERÍA DE TEXTO EN EQUIPOS DE TELEFONÍA MÓVIL', '12/12/2012', 363, 'default', 361, '9998998K', NULL, NULL);
INSERT INTO propuesta VALUES ('COMPARACIÓN DE ÍNDICES DE AUTORREGULACIÓN DE FLUJO SANGUÍNEO CEREBRAL BASADOS SOLO EN SEÑAL DE FLUJO', '13/12/12', 364, 'default', 362, '176675459', NULL, NULL);
INSERT INTO propuesta VALUES ('COMPARACION ENTRE MODELOS NARX DE SVM Y TLRNN PARA OBTENER INDICE AUTORREGULATORIO CEREBRAL EN VARIACIONES ESPONTANEAS', '30/09/2013', 365, 'default', 363, '167463479', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACIÓN DE MÉTODOS QUE MEJORAN LA IDENTIFICACIÓN DE BIOMARCADORES A PARTIR DE DATOS DE EXPRESIÓN GÉNETICA EN EL SALMÓN ATLÁNTICO (SALMO SALAR)', '28/12/12', 366, 'default', 364, '167460003', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACIÓN DE LOS EFECTOS DE LA POSICIÓN CORPORAL EN EL CÁLCULO DE LOS ÍNDICES DE AUTORREGULACIÓN DEL FLUJO SANGUÍNEO CEREBRAL USANDO MODELOS LINEALES', '21/12/2012', 367, 'default', 365, '164910652', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACIÓN DEL CRÉDITO TRIBUTARIO PARA LA INSTALACIÓN DE UN SISTEMA SOLAR TÉRMICO Y SU IMPACTO EN EL SISTEMA INFORMÁTICO TRIBUTARIO CHILENO ADMINISTRADO POR EL S.I.I.', '27/11/12', 368, 'default', 366, '83157739', NULL, NULL);
INSERT INTO propuesta VALUES ('CONSTRUCCIÓN DE MODELOS PARA EVALUAR LA AUTORREGULACIÓN DE PACIENTES CON TEC USANDO MODELOS NARMAX Y FIR CON SVM.', '24/07/12', 369, 'default', 367, '170631129', NULL, NULL);
INSERT INTO propuesta VALUES ('ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS POLARES ', '4/8/2014', 370, 'default', 368, '169448264', NULL, NULL);
INSERT INTO propuesta VALUES ('IMPLEMENTACIÓN DE ALGORITMOS DE LAYOUT DE GRAFOS Y ANÁLISIS DE SU COMPORTAMIENTO AL GENERAR SOLUCIONES INÍCIALES PARA EL ALGORITMO QAPGRID.', '', 371, 'default', 369, '164792560', NULL, NULL);
INSERT INTO propuesta VALUES ('ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS OCTOPUS', '23/06/2014', 372, 'default', 370, '174044953', NULL, NULL);
INSERT INTO propuesta VALUES ('CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFO GOOD', '18/08/2014', 373, 'default', 371, '174424977', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA POYAR LA COMPRENSIÓN Y APLICACIÓN DE CONCEPTOS BÁSICOS DE INTRODUCCIÓN A LAS BASES DE DATOS', '3/12/2012', 374, 'default', 372, '170505727', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE GESTIÓN ESCOLAR PARA LA EMPRESA DE CLASES PARTICULARES "PLAY HOUSE TEACHER"', '', 375, 'default', 373, '156646636', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACION VIRTUAL DE NANOTUBOS DE CARBONO DE UNA PARED FUNCIONALIZADOS CON DISTINTAS MOLECULAS', '10/1/2013', 376, 'default', 374, '167391753', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA DE PREDICCIÓN PARA LA CANTIDAD DE ALUMNOS EN LAS ASIGNATURAS DEL DEPARTAMENTO DE INGENIERIA INFORMATICA', '23/07/2012', 377, 'default', 375, '167391753', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE ALGORITMOS DE PLANIFICACIÓN DE PROCESOS EN CPU EN EL CURSO DE SISTEMAS OPERATIVOS', '13/12/12', 378, 'default', 376, '17850620K', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA PARA LA CREACION,GESTION Y DIFUSION DE BANDAS MUSICALES', '', 379, 'default', 377, '168409974', NULL, NULL);
INSERT INTO propuesta VALUES ('REINGENIERÍA DE PROCESOS DE DOCENCIA  DEL DEPARTAMENTE DE INGENIERÍA INFORMÁTICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '20/07/2012', 380, 'default', 378, '167497578', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE CONTABILIDAD PARA ALUMNOS DEL INSTITUTO PROFESIONAL LA ARAUCANA', '', 381, 'default', 379, '167464181', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL MODELAMIENTO MATEMÁTICO DE PROBLEMAS DE OPTIMIZACIÓN', '21/12/12', 382, 'default', 380, '169197342', NULL, NULL);
INSERT INTO propuesta VALUES ('ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS "K-TREE"', '9/9/2014', 383, 'default', 381, '167476171', NULL, NULL);
INSERT INTO propuesta VALUES ('ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS "K-TREE"', '', 384, 'default', 382, '167476171', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACIÓN DE APOYO A LA ENSEÑANZA - APRENDIZAJE PARA EL MANEJO DE LENJUAGE DE MATRICES EN OCTAVE EN EL CURSO DE FUNDAMENTOS DE PROGRAMACIÓN', '5/3/2013', 385, 'default', 383, '170286499', NULL, NULL);
INSERT INTO propuesta VALUES ('DETECCIÓN PREVENTIVA DE ALUMNOS CON BAJO RENDIMIENTO ACADÉMICO EN LA FACULTAD DE INGENIERÍA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '', 386, 'default', 384, '160687975', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR LA APREHESIÓN DE LOS CONCEPTOS DE PROCESOS Y HEBRAS', '20/12/12', 387, 'default', 385, '173093403', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN MÓDULO DE EXTENSIÓN PARA DETERMINAR RUTAS DE TRANSPORTES DE CARGA POR EL MEDIO VIAL, FERROVIARIO O MARÍTIMO EN EL ENTORNO ARCMAP', '', 388, 'default', 386, '153182051', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACIÓN WEB DE APOYO PARA LA GESTIÓN DE PROCESO DE POSTULACIONES  ACADÉMICAS EN EL DEPARTAMENTO DE INGENIERÍA INFORMÁTICA DE LA UNIIVERSIDAD DE SANTIAGO DE CHILE', '', 389, 'default', 387, '176744499', NULL, NULL);
INSERT INTO propuesta VALUES ('ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS LOBSTER', '', 390, 'default', 388, '132527121', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETIVOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN DE CONCURRENCIA COMPUTACIONAL', '23/01/2013', 391, 'default', 389, '165702867', NULL, NULL);
INSERT INTO propuesta VALUES ('ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS BISPLIT.', '', 392, 'default', 390, '162850350', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETO DE APRENDIZAJE PARA LA EJERCITACIÓN DE LOS CONCEPTOS DEL MÉTODO SIMPLEX', '12/12/2012', 393, 'default', 391, '170061403', NULL, NULL);
INSERT INTO propuesta VALUES ('DIAGNOSTICO DE INGRESO DE ALUMNOS A LA CARRERA DE INGENIERÍA DE EJECUCIÓN EN COMPUTACIÓN E INFORMÁTICA MODALIDAD VESPERTINA', '2/5/2013', 394, 'default', 392, '120472003', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACIÓN DE OBJETOS DE APRENDIZAJE MOODLE, MEDIANTE LA SUPERVISIÓN DE USO DE LOS ESTUDIANTES', '23/12/2014', 395, 'default', 393, '174866309', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE INFORMACIÓN DOCENTE PARA APOYO A LA ACREDITACIÓN DE LOS PROGRAMAS DE PREGRADO DEL DEPARTAMENTO DE INGENIERÍA INFORMÁTICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '23/12/2014', 396, 'default', 394, '174256346', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE APOYO A LA FORMULACIÓN DE PROYECTOS CONCURSABLES DEL DEPARTAMENTO DE INGENIERÍA INFORMÁTICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '22/12/2014', 397, 'default', 395, '172427545', NULL, NULL);
INSERT INTO propuesta VALUES ('ALGORITMOS PARALELOS PARA LA GENERACIÓN DE LOS CONJUNTOS INDEPENDIENTES MAXIMALES DE UN GRAFO CAMINO SIN CUERDAS Y DE UN GRAFO CATERPILLAR', '22/12/2014', 398, 'default', 396, '175340718', NULL, NULL);
INSERT INTO propuesta VALUES ('MODELADO DE LAS CARACTERÍSTICAS DE LOS POSTULANTES A LA CARRERA DE INGENIERÍA DE EJECUCIÓN EN COMPUTACIÓN E INFORMÁTICA MODALIDAD VESPERTINA', '18/12/2014', 399, 'default', 397, '174888817', NULL, NULL);
INSERT INTO propuesta VALUES ('ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN FRAFOS OCTOPUS', '16/10/2014', 400, 'default', 398, '174044953', NULL, NULL);
INSERT INTO propuesta VALUES ('INTELIGENCIA DE NEGOCIOS APLICADA A CAJA DE COMPENSACIÓN', '15/06/2012', 401, 'default', 399, '16171898k', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE APOYO A LA ADMINISTRACIÓN DE INFORMACIÓN PARA LOS COMITÉS DE AGUA POTABLE RURALES', '8/2/2012', 402, 'default', 400, '166606322', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UNA APLICACIÓN DE MONITOREO SPLUNK PARA AGUILIZAR EL PROCESO ITIL DE GESTIÓN DE INCIDENTES EN BANCO ESTADO', '18/11/2013', 403, 'default', 401, '170508157', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE GESTIÓN Y CONTROL PARA EMPRESA "PG&I"', '08/05/12', 404, 'default', 402, '155661569', NULL, NULL);
INSERT INTO propuesta VALUES ('BUSINESS INTELLIGENCE PARA EL ÁREA DE CONTROL DE GESTIÓN EN LA SUPERINTENDENCIA DE ELECTRICIDAD Y COMBUSTIBLES', '29/11/2012', 405, 'default', 403, '134897384', NULL, NULL);
INSERT INTO propuesta VALUES ('MONITOREO Y MANEJO DE REDES INALÁMBRICAS EN MINAS A RAJO ABIERTO', '30/11/2012', 406, 'default', 404, '101489736', NULL, NULL);
INSERT INTO propuesta VALUES ('CUBO OLAP PARA ANÁLISIS DE VENTAS', '26/09/12', 407, 'default', 405, '132601305', NULL, NULL);
INSERT INTO propuesta VALUES ('ESTUDIO DE FACTIBILIDAD PARA LA IMPLEMENTACION DE APLICACIONES DISTRIBUIDAS SOBRE SET-TOP-BOXES EN CHILE', '3/10/2013', 408, 'default', 406, '172508782', NULL, NULL);
INSERT INTO propuesta VALUES ('BIBLIOTECA PARA EL DESPEGUE ÁGIL DE APLICACIONES DE STREAM EN ESCENARIOS DE DESASTRES', '13/07/2014', 409, 'default', 407, '182940933', NULL, NULL);
INSERT INTO propuesta VALUES ('IMPLEMENTACION DE PROCESOS DE GESTION DE PROYECTOS FOSIS UTILIZANDO HERRAMIENTAS BPMS', '4/8/2010', 410, 'default', 408, '153503583', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE DENUNCIA CIUDADANA PARA LA ILUSTRE MUNICIPALIDAD DE SAN JOAQUIN', '20/09/2011', 411, 'default', 409, '101113515', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE RECOLECCIÓN DE LECHE FRESCA PARA LAS PLANTAS NESTLÉ CHILE S.A.', '13/05/2013', 412, 'default', 410, '123894960', NULL, NULL);
INSERT INTO propuesta VALUES ('PROTOTIPO DE SISTEMA DE GESTIÓN DOCUMENTAL PARA LA DIRECCIÓN DE ASISTENCIA JURÍDICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '', 413, 'default', 411, '142527847', NULL, NULL);
INSERT INTO propuesta VALUES ('REDISEÑO DE PROCESOS: IMPLEMENTACION DE SISTEA RIS/PACS EN UNIDAD DE IMAGENOLOGIA, HOSPITAL SAN JUAN DE DIOS', '4/8/2010', 414, 'default', 412, '132136106', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE CONTROL Y MONITOREO A LAS TRANSACCIONES DE UN CONJUNTO DE BASES DE DATOS SQL SERVER', '20/09/2011', 415, 'default', 413, '130557333', NULL, NULL);
INSERT INTO propuesta VALUES ('DATAMART PARA EL ÁREA DE APROVISIONAMIENTO DE ENDESA COLOMBIA', '', 416, 'default', 414, '147365403', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN CUADRO DE MANDO INTEGRAL', '4/8/2010', 417, 'default', 415, '142432722', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE CONTROL DE PROCESOS Y GESTION PARA EL AREA DE SOPORTE INFORMATICO PARA BROWSE INGENIERIA', '4/8/2010', 418, 'default', 416, '130476716', NULL, NULL);
INSERT INTO propuesta VALUES ('PROCESO DE DESARROLLO DE PROYECTOS DE SEGURIDAD PARA SAP ERP EN ROLES Y PERFILES', '4/8/2010', 419, 'default', 417, '139368142', NULL, NULL);
INSERT INTO propuesta VALUES ('SISATEMA DE INVENTARIO WEB PARA APOYAR LA GESTIÓN DE LA EMPRESA VTV LTDA.', '15/05/2012', 420, 'default', 418, '171204593', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE ASIGNACIÓN DE LABORATORIOS DE DOCENCIA', '4/8/2010', 421, 'default', 419, '120580094', NULL, NULL);
INSERT INTO propuesta VALUES ('PLAN DE CONTINUIDAD DE NEGOCIOS PARA EL MACRO PROCESO GESTIÓN FINANCIERA Y OTROS ACTIVOS DEL TESORO PÚBLICO', '3/11/2013', 423, 'default', 421, '137465493', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE CONTROL DE PERMISOS Y AUSENCIAS DE FUNCIONARIOS DEL 3º JUZGADO DE FAMILIA DE SANTIAGO DE CHILE', '7/4/2011', 424, 'default', 422, '12236299K', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE SISTEMA DE COTIZACIÓN Y DE CONTROL DE EXISTENCIAS PARA LA EMPRESA ALUMAR', '19/07/2012', 425, 'default', 423, '17325752K', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE APOYO A LA ADMINISTRACION Y PLANIFICACION DE EVIDENCIA NORMATIVA DE AUDITORIAS PARA NEXUS S.A.', '7/4/2011', 426, 'default', 424, '111690871', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO E IMPLEMENTACIÓN DE SISTEMA DE AUTOMATIZACIÓN DE PROCESOS DE ANÁLISIS CRM', '19/11/2013', 427, 'default', NULL, '164273008', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB PARA MONITOREAR DISPOSITIVOS GPS', '20/09/2011', 428, 'default', 425, '141928664', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA CMR DE APOYO A LA FUERZA DE VENTAS CON CLIENTE DE OPERACION ASINCRONICA', '7/4/2011', 429, 'default', 426, '118453816', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE INFORMACIÓN WEB, PARA LA "CLÍNICA DENTAL - ALEXANDRA ALVAREZ"', '1/2/2012', 430, 'default', 427, '126776691', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN SISTEMA DE APOYO A LA GESTIÓN DE TORNEOS Y APUESTAS EN LA COMUNIDAD DE VIDEOJUEGOS CIBERDEPORTES.NET.', '9/2/2012', 431, 'default', 428, '16375228K', NULL, NULL);
INSERT INTO propuesta VALUES ('WEB SERVICES PARA APOYAR LA VENTA DE SEGUROS DE VEHÍCULOS PARTICULARES A TRAVES DE UNA MULTITIENDA', '1/2/2012', 432, 'default', 429, '07364058K', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE INFORMACIÓN DE APOYO PARA AUTOMATIZACIÓN Y MONITOREO DE ACTIVIDADES DE PLAN DE CORTE EN CONVERSIÓN DE TIENDAS PARA LA COMPAÑÍA ZCMART CHILE.', '19/11/2013', 433, 'default', 430, '157559281', NULL, NULL);
INSERT INTO propuesta VALUES ('PLATAFORMA PARA LA DEFINICIÓN Y APOYO A LA EVALUACIÓN DE GESTOS TÁCTILES EN LA INTERACCIÓN CON OBJETOS DIGITALES DE INFORMACIÓN', '4/8/2014', 434, 'default', 431, '17705318K', NULL, NULL);
INSERT INTO propuesta VALUES ('IDENTIFICACIÓN AUTOMATIZADA DE ETAPAS DEL PROCESO DE BÚSQUEDA DE INFORMACIÓN DEL USUARIO ', '18/07/2014', 435, 'default', 432, '174859329', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO Y DESARROLLO DE UNA APLICACIÓN MODULAR PARA APOYAR LA INVESTIGACIÓN OBSERVACIONAL CON DATOS MULTIMODALES ', '13/08/2014', 436, 'default', 433, '176233516', NULL, NULL);
INSERT INTO propuesta VALUES ('DETECCIÓN IMPLÍCITA DE RELEVANCIA DE PÁGINAS WEB UTILIZANDO REGISTROS DE ACTIVIDAD DEL USUARIO EN LA BÚSQUEDA DE INFORMACIÓN', '18/08/2014', 437, 'default', 434, '176641959', NULL, NULL);
INSERT INTO propuesta VALUES ('PLATAFORMA PARA LA GENERACIÓN Y APOYO A LA EVALUACIÓN DE VISUALIZAORES DE RESULTADOS DE BÚSQUEDA', '12/8/2014', 438, 'default', 435, '17490314K', NULL, NULL);
INSERT INTO propuesta VALUES ('HERRAMIENTA INTERACTIVA PARA APOYAR LA EVALUACIÓN DE PACIENTES EN TRATAMIENTO DEL TRASTORNO DE DÉFICIT ATENCIONAL A PARTIR DEL RASTREO OCULAR', '18/08/2014', 439, 'default', 436, '180550321', NULL, NULL);
INSERT INTO propuesta VALUES ('PLATAFORMA PARA EL APOYO A LA EVALUACIÓN Y DEFINICIÓN DE GESTOS CORPORALES EN LA INTERACCIÓN CON OBJETOS DIGITALES DE INFORMACIÓN', '4/8/2014', 440, 'default', 437, '176013435', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACIÓN IMPLÍCITA DE CARGA COGNITIVA DURANTE EL PROCESAMIENTO DE INFORMACIÓN A PARTIR DE PATRONES DE LECTURA', '18/08/2014', 441, 'default', 438, '174269211', NULL, NULL);
INSERT INTO propuesta VALUES ('FÁBRICA DE COLABORATORIOS PARA APOYAR LA INVESTIGACIÓN EN BÚSQUEDA COLABORATIVA DE INFORMACIÓN', '23/12/2014', 442, 'default', 439, '175333967', NULL, NULL);
INSERT INTO propuesta VALUES ('PLATAFORMA PARA LA DEFINICIÓN Y APOYO A LA EVALUACIÓN DE RETROALIMENTACIÓN TÁCTIL EN LA INTERACCIÓN CON OBJETOS DE INFORMACIÓN DIGITAL A TRAVÉS DE INTERFACES NATURALES', '23/12/2014', 443, 'default', 440, '176717890', NULL, NULL);
INSERT INTO propuesta VALUES ('METODOLOGIA PARA EL DISEÑO DE INFRAESTRUCTURA DE ALTA DISPONIBILIDAD TI', '20/09/2011', 444, 'default', 441, '116474042', NULL, NULL);
INSERT INTO propuesta VALUES ('PROTOCOLO SERVIDOR VIRTUAL EN NUBE PARA RESPALDO Y ACTUALIZACION DINAMICA DE AGENDA TELEFONICA CELULAR', '', 445, 'default', 442, '173110189', NULL, NULL);
INSERT INTO propuesta VALUES ('RED SOCIAL TWITTER APLICADA A SEGURIDAD DOMOTICA PROTOTIPO CON ACCESO MOBILE', '', 446, 'default', 443, '17084405K', NULL, NULL);
INSERT INTO propuesta VALUES ('TECNOLOGÍA QR MÓVIL DE APOYO A LA VENTA ONLINE Y FUNCIÓN DE CAJEROS MÓVILES EN SUPERMERCADOS.', '', 447, 'default', 444, '174273944', NULL, NULL);
INSERT INTO propuesta VALUES ('PROTOTIPO DE NODO OBSERVATORIO TERRITORIAL INTEGRADO EN RED,PARA GEOLOCALIZACIÓN DE RECURSOS Y APOYO A LA GESTIÓN DINÁMICA COMUNAL (P-NOT).', '', 448, 'default', 445, '161280070', NULL, NULL);
INSERT INTO propuesta VALUES ('NODO COMUNAL INTEGRABLE A RED DE GEO-REPRESENTACIÓN DE ZONAS DE RIESGO Y CONTINGENCIA TERRITORIAL, BASADO EN SOFWARE LIBRE (NODO CIR-GR2).', '', 449, 'default', 446, '161469912', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA PARA EL MANEJO DE PARTITURAS DIGITALES BASADA EN TECNOLOGÍA TOUCH-MOBILE PARA ORQUESTAS SINFÓNICAS.', '', 450, 'default', 447, '171204593', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE RELATIVOS AL TRATAMIENTO DE ERROR EN LA TRANSMISIÓN Y RECEPCIÓN DE DATOS', '14/07/2014', 451, 'default', 448, '169033188', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE LAS REDES IP', '20/01/2014', 452, 'default', 449, '166484588', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UNA APLICACIÓN MULTIMEDIA QUE APOYE EL APRENDIZAJE DEL IDIOMA CHINO MANDARIN COMO LENGUAJE EXTRANJERA ORIENTADO A LA ESCRITURA', '', 453, 'default', 450, '157724282', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO DE UN LABORATORIO VIRTUAL PARA EL CURSO CRIPTOGRAFÍA', '21/07/11', 454, 'default', 451, '156430579', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE MONITIREO REMOTO EXCLUSIVO PARA DISPOSITIVOS CON SOPORTE IPV6', '', 455, 'default', 452, '17372098K', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE APOYO DE GESTIÓN EFICIENTE DE LAS ENERGÍAS DEL DIINF', '31/03/2014', 456, 'default', 453, '173549849', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETO DE APRENDIZAJE PARA EL ESTUDIO DE REDES DE ÁREA LOCAL', '18/08/2014', 457, 'default', 454, '175646736', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL APOYO A LA INTRODUCCIÓN A LA PROGRAMACIÓN', '18/08/2014', 458, 'default', 455, '176683007', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDS SATELITALES', '18/01/13', 459, 'default', 456, '94928400', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRESIÓN Y APLICACIÓN DE LOS FUNDAMENTOS DE DESARROLLO WEB', '20/11/12', 460, 'default', 457, '160895683', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA DE COMPRA VENTA DE SEGUROS EN LÍNEA', '', 461, 'default', 458, '153742642', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS PROTOCOLOS DE TRANSPORTE UTILIZADOS EN REDES CONMUTACIÓN DE PAQUETES', '22/01/2014', 462, 'default', 459, '164336646', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN SISTEMA DE NOTIFICACIONES A TRAVÉS DE REDES SOCIALES DE INTERNET', '18/01/13', 463, 'default', 460, '132455252', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN FRAMEWORK PARA LA CONSTRUCCIÓN DE OBJETOS DE APRENDIZAJE', '10/4/2014', 464, 'default', 461, '159674290', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DE RED COMPUTACIONAL EMPRESA VYS', '', 465, 'default', 462, '156394165', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE COMUNICACIÓN DE EMERGENCIAS AL CUERPO DE BOMBEROS DE SANTIAGO', '', 466, 'default', 463, '182100625', NULL, NULL);
INSERT INTO propuesta VALUES ('SOFTWARE DE APOYO AL SEGUIMIENTO DEL PLAN ESTRATÉGICO DE LA EMPRESA PÚBLICA EMERES', '23/10/2013', 467, 'default', 464, '153400253', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETO DE APRENDIZAJE PARA EL ESTUDIO DE DISTRIBUCIÓN DE CLAVES CRIPTOPOGRÁFIA', '', 468, 'default', 465, '165308697', NULL, NULL);
INSERT INTO propuesta VALUES ('MODELO PARA LA AUTORIZACIÓN DE TRANSACCIONES FINANCIERAS BASADO EN ESTÁNDAR EMV', '4/12/2012', 469, 'default', 466, '158323486', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACIÓN DE APOYO AL APRENDIZAJE DE LA FONÉTICA DEL IDIOMA CHINO MANDARÍN.', '', 470, 'default', 467, '166401313', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS MÉTODOS DE DETECCIÓN Y CORRECCIÓN DE ERRORES EN LA TRANSMISIÓN DE DATOS.', '23/07/2013', 471, 'default', 468, '90073648', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUCION DE LA EFICIENCIA DE LOS OBJETOS DE APRENDIZAJE QUE APOYAN LA ENSEÑANZA DE LOS ALUMNOS DEL CURSO DE CRIPTOGRAFIA', '', 472, 'default', 469, '141871331', NULL, NULL);
INSERT INTO propuesta VALUES ('METODOLOGÍA PARA EL DESARROLLO DE OBJETOS DE APRENDIZAJE', '26/12/12', 473, 'default', 470, '166183383', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETO DE APRENDIZAJE PARA TRANSMISIÓN DE DATOS', '4/12/2014', 474, 'default', 471, '161228850', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE PROTOCOLOS CRIPTOGRÁFICOS CLÁSICOS', '20/01/2014', 475, 'default', 472, '173132387', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DEL MARCO DE TRABAJO DE DESARROLLO DE SOFTWARE SCRUM', '4/8/2014', 476, 'default', 473, '172571182', NULL, NULL);
INSERT INTO propuesta VALUES ('SERVICIO DE COMUNICACIÓN POR VOZ EN UNA RED INALÁMBRICA DE MALLA SIMULADA', '18/08/2014', 477, 'default', 474, '171895723', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE EN APOYO A CONDUCTAS DE AUTOCUIDADO PARA NIÑOS Y JÓVENES CON DISCAPACIDAD INTELECTUAL', '28/12/12', 478, 'default', 475, '167182952', NULL, NULL);
INSERT INTO propuesta VALUES ('', '16/10/2013', 479, 'default', 476, '168401264', NULL, NULL);
INSERT INTO propuesta VALUES ('SOFTWARE PREDICTIVO DE APOYO A LA PLANEACIÓN DE CAPACIDAD DE INFRAESTRUCTURAS DE RED', '4/7/2013', 480, 'default', 477, '156491373', NULL, NULL);
INSERT INTO propuesta VALUES ('PLAN DE CAPACITACIÓN EMPRESARIAL PARA ENSEÑAR TELEFONIA CELULAR USANDO OBJETOS DE APRENDIZAJE', '20/07/11', 481, 'default', 478, '154680756', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DEL PROTOCOLO DE AUTENTICACIÓN KERBEROS', '28/12/12', 482, 'default', 479, '147074220', NULL, NULL);
INSERT INTO propuesta VALUES ('UNA PLATAFORMA CROWDSOURCING PARA LA PREPARACIÓN DE LA PSU', '18/08/2014', 483, 'default', 480, '174025282', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDES DE AREA LOCAL (ETHERNET)', '29/07/2013', 484, 'default', 481, '163589419', NULL, NULL);
INSERT INTO propuesta VALUES ('EAPECIFICACIÓNES FORMAL DE UNA RED MESH ORIENTADA AL ESTUDIO DE ALGORITMOS DE ENRUTAMIENTO Y AUTENTICACIÓN.', '5/10/2011', 485, 'default', 482, '167454761', NULL, NULL);
INSERT INTO propuesta VALUES ('SERVICIO DE CONFIDENCIALIDAD EN RED DE MALLA INALAMBRICA', '20/01/2014', 486, 'default', 483, '168553439', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETO DE APRENDIZAJE PARA APOYAR EL APRENDIZAJE DE LA HERRAMIENTA OMNET++', '27/08/2014', 487, 'default', 484, '168553439', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE COMO HERRAMIENTA DE APOYO A LA ENSEÑANZA DE PROTOCOLOS DE SEGURIDAD EN LA RED.', '11/9/2012', 488, 'default', 485, '163725886', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE PROTOCOLOS DE SEGURIDAD PARA CORREO ELECTRÓNICOS', '9/2/2012', 489, 'default', 486, '164174034', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACION DE APOYO AL APRENDIZAJE DE LA ESCRITURA EN CHINO MANDARIN', '25/09/2013', 490, 'default', 487, '17414852K', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN Y APLICACIÓN DE IPV6.', '', 491, 'default', 488, '158369346', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJES PARA COMUNICACIONES DIGITALES', '12/12/2013', 492, 'default', NULL, '141545914', NULL, NULL);
INSERT INTO propuesta VALUES ('GUÍ METODOLÓGICA PARA LA IMPLEMENTACIÓN DE UN PROTOCOLO DE AUTENTICACIÓN BASADO EN KERBEROS.', '05/02/09', 493, 'default', 489, '161974579', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE APLICACIONES DE TIEMPO REAL EN INTERNET', '8/8/2014', 494, 'default', 490, '139154673', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE ENFOCADOS EN TRANSMISIÓN INALÁMBRICA', '26/01/2012', 495, 'default', 491, '159005577', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DEL IDIOMA INGLÉS EN NIÑOS PREESCOLARES', '1/8/2013', 496, 'default', 492, '120041282', NULL, NULL);
INSERT INTO propuesta VALUES ('SERVICIO PARA COMPARTIR MATERIAL DE ESTUDIO SOBRE UNA RED INALÁMBRICA DE MALLA SIMULADA ', '14/08/2014', 497, 'default', 493, '180830936', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LA SEGURIDAD EN REDES A TRAVÉS DE FUNCIONES HASH, FUNCIONES MAC Y FIRMA DIGITAL', '17/08/12', 498, 'default', 494, '161483419', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETO DE APRENDIZAJE PARA APOYAR EL PROCESO DE LECTURA INFANTIL', '4/8/2014', 499, 'default', 495, '177406538', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA DE GESTIÓN DE PROYECTOS CONSULTORA SAP PRIME GROUP.', '', 500, 'default', 496, '159301567', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACIÓN DE APOYO AL APRENDIZAJE DE LA GRAMÁTICA DEL CHINO MANDARIN', '14/07/2014', 501, 'default', 497, '160794321', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE INTERACTIVOS PARA APOYAR EL ESTUDIO DE LOS MÉTODOS DE DETECCIÓN Y CORRECCIÓN DE ERRORES EN LA TRANSACCIÓN DE DATOS', '23/01/2014', 502, 'default', 498, '169325421', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS PROTOCOLOS USADOS EN APLICACIONES TIEMPO-REAL EN INTERNET, REAL TIME PROTOCOL (RTP) Y REAL TIME PROTOCOL (RTCP).', '23/04/2014', 503, 'default', 499, '161469912', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE ALGORITMOS HASH.', '', 504, 'default', 500, '164730271', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN SISTEMA DE INFORMACIÓN PARA OPTIMIZAR LA GESTIÓN DE PLANIFICACIÓN DE LA RED DE TRANSMISIÓN ELÉCTRICA.', '', 505, 'default', 501, '161989495', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN PROTOTIPO DE RED INALÁMBRICA DE MALLA PARA EL DEPARTAMENTO DE INGENIERÍA INFORMÁTICA', '12/8/2014', 506, 'default', 502, '18049152K', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACION DE UNA NUEVA METODOLOGIA PARA EL DESARROLLO DE OBJETOS DE APRENDIZAJE', '13/09/2013', 507, 'default', 503, '162121774', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACIÓN DE METODOLOGÍA CPIS PARA EL DESARROLLO DE OBJETOS DE APRENDIZAJE', '24/03/2014', 508, 'default', 504, '162121774', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO Y COMPRENSIÓN DE LOS PROTOCOLOS DE SEGURIDAD IPSEC Y SSL PARA INTERNET', '27/07/12', 509, 'default', 505, '163827255', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN REPOSITORIO DE OBJETOS DE APRENDIZAJE PARA EL DEPARTAMENTO DE INGENIERÍA INFORMÁTICA', '10/12/2012', 510, 'default', 506, '166570722', NULL, NULL);
INSERT INTO propuesta VALUES ('IMPLEMENTACIÓN DE SEGURIDAD EN ROLES Y PERFILES PARA SAP ERP EN CONSTRUMART S.A.', '19/11/12', 511, 'default', 507, '139368142', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE PROTOCOLOS DE APLICACIÓN EN INTERNET', '5/7/2014', 512, 'default', 508, '128108408', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACIÓN WEB PARA LA ADMINISTRACIÓN DE EVALUACIONES DE ATENCIÓN A CLIENTES PARA CONSULTORA GETGAIN', '12/11/2012', 513, 'default', 509, '136874667', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE OBJETIVOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS MECANISMOS DE CONTROL DE CONGESTION USANDO REDES DE CONMUTACION DE PAQUETES', '24/09/2013', 514, 'default', 510, '16385788K', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE LOS MECANISMOS DE CONTROL DE CONGESTIÓN EN REDES DE CONMUTACIÓN DE PAQUETES', '29/07/2014', 515, 'default', 511, '16385788K', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDES DE TELEFONÍA CELULAR.', '', 516, 'default', 512, '167404855', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN DE LOS CIFRADOS SIMÉTRICOS AES Y DES.', '', 517, 'default', 513, '162774778', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDES WI-FI Y WI-MAX', '20/06/2013', 518, 'default', 514, '160265353', NULL, NULL);
INSERT INTO propuesta VALUES ('METODO DE VALIDACION PARA OBJETOS DE APRENDIZAJE', '11/10/2013', 519, 'default', 515, '169102627', NULL, NULL);
INSERT INTO propuesta VALUES ('UN ALGORITMO DE AUTENTICACIÓN PARA LA SEGURIDAD EN REDES DE MALLA', '27/07/12', 520, 'default', 516, '160208619', NULL, NULL);
INSERT INTO propuesta VALUES ('MODELO DE GESTIÓN DE COTIZACIONES Y VENTAS DE SEGUROS DE VEHÍCULOS', '25/09/2014', 521, 'default', 517, '152509022', NULL, NULL);
INSERT INTO propuesta VALUES ('PROCESO DE NEGOCIO Y REQUERIMIENTOS PARA SISTEMA DE RECLUTAMIENTO Y SELESCCIÓN DE EMPRESA DE ÁREA FINANCIERA', '18/01/13', 522, 'default', 518, '152509022', NULL, NULL);
INSERT INTO propuesta VALUES ('ESTUDIO Y DESARROLLO DE UN SISTEMA DE RESPALDO (BACKUP) Y RECUPERACIÓN PARA LA SEGURIDAD Y CONTINUIDAD OPERACIONAL DE PROVECTIS S.A.', '', 523, 'default', 519, '158366037', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN REPOSITORIO DE OAS PARA EL DEPARTAMENTO DE INGENIÉRIA INFORMÁTICA', '', 524, 'default', 520, '155648511', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETO DE APRENDIZAJE SOBRE LA DIRECCIÓN Y GESTIÓN DE PROYECTOR TI', '18/08/2014', 525, 'default', 521, '144878552', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN DE LOS CIFRADORES SIMÉTRICOS RC4, IDEA Y BLOWFISH', '9/1/2013', 526, 'default', 522, '161168440', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO, IMPLEMENTACIÓN Y ANÁLISIS DE BLOQUES ATÓMICOS EN CONTRA DE SSCA, ATAQUES C-SAFE-FAULTS Y ATAQUES DE COLISIÓN DE CORRELACIÓN HORIZONTAL EN CRIPTOGRAFÍA DE CURVA ELÍPTICA', '22/12/2014', 527, 'default', 523, '171891841', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETO DE APRENDIZAJE PARA APOYAR LA ENSEÑANZA DE PROTOCOLOS DE VENTANA DESLIZANTE', '23/12/2014', 528, 'default', 524, '169772835', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACIÓN DE UN MÉTODO DE VALIDACIÓN SOBRE LOS OBJETOS DE APRENDIZAJE DEL REPOSITORIO DEL DIINF', '19/12/2014', 529, 'default', 525, '166398703', NULL, NULL);
INSERT INTO propuesta VALUES ('OBJETOS DE APRENDIZAJE SOBRE CRIPTOGRAFÍA SIMÉTRICO PARA BLOWFISH', '19/12/2014', 530, 'default', 526, '176782765', NULL, NULL);
INSERT INTO propuesta VALUES ('LOCALIZACIÓN Y SEGUIMIENTO DE PERSONAS DENTRO DE UN TREN EN MOVIMIENTO UTILIZANDO VISIÓN ARTIFICIAL', '20/01/2014', 531, 'default', 527, '169402035', NULL, NULL);
INSERT INTO propuesta VALUES ('CONTABILIZACIÓN DE PERSONAS QUE SUBEN Y BAJAN DE UN TREN METROPOLITANO USANDO VISIÓN POR COMPUTADOR', '23/01/2014', 532, 'default', 528, '170054989', NULL, NULL);
INSERT INTO propuesta VALUES ('DETECCIÓN DE PERSONAS EN TIEMPO REAL MEDIANTE EL USO DE UNA RASPBERRY PI', '20/01/2014', 533, 'default', 529, '166078482', NULL, NULL);
INSERT INTO propuesta VALUES ('DETECCIÓN DE VEHÍCULOS DETENIDOS EN SECTORES PROHIBIDOS DEL TRÁFICO URBANO UTILIZANDO TÉCNICAS DE VISIÓN POR COMPUTADOR.', '22/01/2014', 534, 'default', 530, '169033285', NULL, NULL);
INSERT INTO propuesta VALUES ('ANÁLISIS COMPARATIVO DE CLASIFICADORES EN CUANTO A SU SENSIBILIDAD ESPACIAL PARA LA DETECCIÓN DE PEATONES EN IMÁGENES', '24/07/2014', 535, 'default', 531, '174276471', NULL, NULL);
INSERT INTO propuesta VALUES ('DETECCIÓN, LOCALIZACIÓN Y CONTEO AUTOMÁTICO DE PERSONAS QUE ENTRAN A UN MICROBÚS, MEDIANTE ALGORITMOS DE VISIÓN POR COMPUTADOR.', '10/3/2014', 536, 'default', 532, '170865510', NULL, NULL);
INSERT INTO propuesta VALUES ('PICKUP AND DELIVERY PROBLEM: APLICACIÓN AL PROBLEMA DE ASIGNACIÓN DE TAREAS PARA LA FLOTA DE CAMIONES DE TRANSPORTES BELLO.', '', 537, 'default', 533, '160080280', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE VIDEOS CLASIFICADOS DE APOYO EN LA PREPARACIÓN DE ESTUDIANTES PARA LA PSU-MATEMÁTICAS', '5/8/2013', 538, 'default', 534, '128712135', NULL, NULL);
INSERT INTO propuesta VALUES ('UN MODELO DE OPTIMIZACIÓN PARA EL RUTEO DE FLOTA DE CAMIONES DE UNA EMPRESA DE TRANSPORTES', '', 539, 'default', 535, '158384043', NULL, NULL);
INSERT INTO propuesta VALUES ('EVOLUCIÓN DE METAHEURÍSTICAS PARA PROBLEMAS DE OPTIMIZACIÓN COMBINATORIA', '18/08/2014', 540, 'default', 536, '176303034', NULL, NULL);
INSERT INTO propuesta VALUES ('UNA SOLUCIÓN AL PROBLEMA DE PLANIFICACIÓN DE DISTRIBUCIÓN DE CONTENEDORES LLENOS Y VACÍOS.', '', 541, 'default', 537, '160895683', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACION DE NUEVOS ALGORITMOS UTILIZANDO PROGRAMACION GENETICA PARA EL PROBLEMA DE OPTIMIZACION JOB SHOP FLEXIBLE', '30/09/2013', 542, 'default', 538, '171893798', NULL, NULL);
INSERT INTO propuesta VALUES ('SITIO WEB PARA LA INCORPORACION DE VIDEOS EN LAS SALAS DE CLASES', '7/4/2011', 543, 'default', 539, '130727859', NULL, NULL);
INSERT INTO propuesta VALUES ('RESOLVIENDO EL PROBLEMA CORTE DE PIEZAS GUILLOTINA MEDIANTE LA COMPUTACION EVOLUTIVA', '24/09/2013', 544, 'default', 540, '166070201', NULL, NULL);
INSERT INTO propuesta VALUES ('ALGOBOTS PARA EL PROBLEMA DE LA MOCHILA MULTIDIMENSIONAL', '3/9/2013', 545, 'default', 541, '179475634', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACION AUTOMATICA DE ALGORITMO PARA EL PROBLEMA DE FORMACION DE CELULAS DE MANUFACTURAS', '', 546, 'default', 542, '165385454', NULL, NULL);
INSERT INTO propuesta VALUES ('DETECCIÓN DE FALLAS EN GRANJA FOTOVOLTAICA MODULAR DE 10 MW/H', '18/07/2014', 547, 'default', 543, '160170166', NULL, NULL);
INSERT INTO propuesta VALUES ('ESTUDIO DE APLICABILIDAD DE VIDEOS JUEGOS PARA SOLUCIONAR PROBLEMAS DE OPTIMIZACION', '', 548, 'default', 544, '167535682', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACION DE ALGORITMOS PARA EL PROBLEMA JOB-SHOP FLEXIBLE UTILIZANDO PROGRAMACION GENETICA', '24/09/2013', 549, 'default', 545, '181652497', NULL, NULL);
INSERT INTO propuesta VALUES ('UN ALGORITMO GENÉTICO COOPERATIVO PARA PROBLEMAS DE CORTES Y EMPAQUE', '26/06/2012', 550, 'default', 546, '159172090', NULL, NULL);
INSERT INTO propuesta VALUES ('UNA SOLUCIÓN HEURÍSTICA PARA EL PROBLEMA ASIGNACIÓN DE BUSES Y TRIPULACIONES CONSIDERANDO SUS ROTACIONES.', '', 551, 'default', 547, '159172090', NULL, NULL);
INSERT INTO propuesta VALUES ('UN AG COOPERATIVO PARA PROBLEMAS DE CORTE Y EMPAQUE', '', 552, 'default', 548, '159172090', NULL, NULL);
INSERT INTO propuesta VALUES ('NUEVOS ALGORÍTMOS ARTIFICIALES DE OPTIMIZACIÓN PARA EL WEIGHTED INDEPENDENCE SET PROBLEM BAJO LA TEORÍA DE LA COMPUTACIÓN EVOLUTIVA', '16/12/2013', 553, 'default', 549, '158422867', NULL, NULL);
INSERT INTO propuesta VALUES ('MEJORA DE ALGORITMOS AUTOMÁTICOS PARA EL PROBLEMA DE LA MOCHILA IDENTIFICANDO EL CONJUNTO DE FUNCIONES Y TERMINALES ADECUADO', '7/8/2012', 554, 'default', 550, '169215219', NULL, NULL);
INSERT INTO propuesta VALUES ('AGENTES RECURSIVOS PARA EL CONTROL DE LA CENTRALIZACIÓN Y DISTRIBUCIÓN DE LAS DECISIONES EN SISTEMAS INTELIGENTES DE PRODUCCIÓN', '10/7/2012', 555, 'default', 551, '151138853', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACIÓN DE LOS MÉTODOS NARX Y NARMAX CON REDES NEURONALES Y MÁQUINA DE SOPORTE VECTORIAL PARA LA ESTIMACIÓN DE LA ACCIDENTABILIDAD EN LA MINERÍA', '', 556, 'default', 552, '153811229', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACIÓN DE UNA SOLUCIÓN HEURÍSTICA PARA EL PROBLEMA DE TSPPC A TRAVÉS DE LA PROGRAMACIÓN GENÉTICA', '18/08/2014', 557, 'default', 553, '183017578', NULL, NULL);
INSERT INTO propuesta VALUES ('EVOLUCION DE ALGORITMOS DETECTORES DE TRAYECTORIA PARA EL PROBLEMA DEL VENDEDOR VIAJERO', '30/09/2013', 558, 'default', 554, '174746761', NULL, NULL);
INSERT INTO propuesta VALUES ('EFECTOS DEL CRITERIO DE ENFRIAMIENTO SOBRE SIMULATED ANNEALING EN LA RESOLUCIÓN DEL PROBLEMA DEL ÁRBOL DE COBERTURA MÍNIMA', '12/9/2012', 559, 'default', 555, '159598373', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO Y DESARROLLO DE UNA PLATAFORMA PARA EL SOPORTE DE LAS CLASAS VIRTUALES EN CURSOS DE INGENIERÍA EN EJECUCIÓN EN COMPUTACIÓN E INFORMÁTICA.', '', 560, 'default', 556, '161561444', NULL, NULL);
INSERT INTO propuesta VALUES ('REGISTRO DE IMÁGENES ASTRONÓMICAS', '21/01/2014', 561, 'default', 557, '165581555', NULL, NULL);
INSERT INTO propuesta VALUES ('UN JUEGO GENERADOR DE ALGORITMOS PARA EL PROBLEMA DE LA MOCHILA.', '', 562, 'default', 558, '167959008', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACION ATOMATICA DE ALGORITMOS PARA EL PROBLEMA DEL VENDEDOR VIAJERO', '24/09/2013', 563, 'default', 559, '180977104', NULL, NULL);
INSERT INTO propuesta VALUES ('UNA RESOLUCIÓN AL PROBLEMA DE LA SELECCIÓN UBICADA DE INTERRUPTORES EN UN SISTEMA DE DISTRIBUSIÓN ELÉCTRICO, CON MÉTODO DE OPTIMIZACIÓN HEURÍSTICA ALGORITMO GENÉTICO PARALELO', '2/8/2010', 564, 'default', 560, '163725886', NULL, NULL);
INSERT INTO propuesta VALUES ('SOLUCIÓN NUMÉRICA AL PROBLEMA DEL ÁRBOL DE COBERTURA MÍNIMO GENERALIZADO MEDIANTE SIMULATED ANNEALING', '', 565, 'default', 561, '161365475', NULL, NULL);
INSERT INTO propuesta VALUES ('REDUCCIÓN DE ARISTAS PARA INSTANCIAS DE ÁRBOL DE COBERTURA MÍNIMO GENERALIZADO', '', 566, 'default', 562, '161365475', NULL, NULL);
INSERT INTO propuesta VALUES ('UNA CONTRIBUCIÓN AL PROBLEMA DE ASIGNACIÓN DE VEHÍCULOS CON MÚLTLIPES DEPÓSITOS Y MANTENCIONES PROGRAMADAS', '', 567, 'default', 563, '164120538', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACIÓN AUTOMÁTICA DE ALGORITMOS PARA EL PROBLEMA DE CORTE DE PIEZAS NO GUILLOTINA CON PROGRAMACIÓN GENÉTICA BINARIA PARALELA.', '', 568, 'default', 564, '156434027', NULL, NULL);
INSERT INTO propuesta VALUES ('IDENTIFICACIÓN DE PATRONES DE USO PARA USUARIOS DEL TRANSANTIAGO.', '', 569, 'default', 565, '163549239', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACIÓN AUTOMÁTICA DE ALGORITMOS DE CLUSTERIZACIÓN.', '10/3/2014', 570, 'default', 566, '161989495', NULL, NULL);
INSERT INTO propuesta VALUES ('BÚSQUEDA DE ALGORITMOS ESPECIALIZADOS PARA FAMILIAS DE INSTANCIAS DE PROBLEMAS DE OPTIMIZACIÓN', '20/01/2014', 571, 'default', 567, '145981859', NULL, NULL);
INSERT INTO propuesta VALUES ('NUEVOS ALGORITMOS ARTIFICIALES PARA LA ASIGNACION DE BUSES Y SERVICIOS DE CONDUCCION EN EL TRANSPORTE URBANO', '', 572, 'default', 568, '160186801', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACIÓN DE LA CALENDARIZACIÓN DE LOS PARTIDOS DEL CAMPEONATO DE FÚTBOL DE CHILE MEDIANTE SIMULATED ANNEALING', '', 573, 'default', 569, '166579643', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACIÓN DE ALGORITMOS PARA EL PROBLEMA DE OPTIMIZACIÓN CELL FORMATION PROBLEM UTILIZANDO COMPUTACIÓN EVOLUTIVA', '20/01/2014', 574, 'default', 570, '172717144', NULL, NULL);
INSERT INTO propuesta VALUES ('IMPLEMENTACION DE HERRAMIENTA DE APOYO A LA GESTION DE LA DOCENCIA EN  COLEGIOS DE EDUCACION MEDIA BASDA EN TECNOLOGIA DE CODIGO ABIERTO', '', 575, 'default', 571, '166156971', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO DE UN SISTEMA PARA MEJORAR LA BÚSQUEDA Y MANEJO DE ÍTEMS DE CONFIGURACIÓN PARA APOYO AL PROCESO DE GESTIÓN DE CONFIGURACIÓN ITIL V3', '25/06/2014', 576, 'default', 572, '166156971', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICANDO INDICADORES A ALGORITMOS GENERADOS POR PROGRAMACIÓN GENÉTICA PARA EL PROBLEMA NP-C TSP.', '10/5/2012', 577, 'default', 573, '153480389', NULL, NULL);
INSERT INTO propuesta VALUES ('NUEVOS ENFOQUES ALGORÍTMICOS PARA JOB SHOP SCHEDUBLING PROBLEM Y FLOW SHOP SCHEDULING PROBLEM', '13/07/2012', 578, 'default', 574, '164740773', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERADOR DE ALGORITMOS PARA RESOLVER EL PROBLEMA DE LA PLANIFICACIÓN DE BUSES PARA EL TRANSPORTE URBANO DE PASAJEROS', '7/9/2012', 579, 'default', 575, '114651214', NULL, NULL);
INSERT INTO propuesta VALUES ('CREACIÓN AUTOMATICA DE ALGORITMOS PARA RESOLVER EL PROBLEMA DE CAMINO MINIMO BASANDOSE EN COMPUTACIÓN EVOLUTIVA0', '24/07/2012', 580, 'default', 576, '173771955', NULL, NULL);
INSERT INTO propuesta VALUES ('DESARROLLO E IMPLEMENTACION DE CONTENIDOS DE UN SITIO WEB PARA LA SOLUCION DE LOS PROBLEMAS DEL CAMINO MINIMO, FLOW SHOP Y JOB SHOP Y ARBOL DE COBERTURA DE COSTO MINIMO', '4/8/2010', 581, 'default', 577, '092174379', NULL, NULL);
INSERT INTO propuesta VALUES ('ALGORITMO DE CLASIFICACIÓN DE GALAXIAS SEGÚN SU MORFOLOGÍA EN IMÁGENES CAPTURADAS POR EL RADIOTELESCOPIO DEL OBSERVATORIO ALMA.', '14/03/2014', 582, 'default', 578, '170291220', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACIÓN DE TURNOS LABORALES PARA LOGÍSTICA AEROPORTUARIA MEDIANTE OPTIMIZACIÓN ROBUSTA', '16/12/2013', 583, 'default', NULL, '166166454', NULL, NULL);
INSERT INTO propuesta VALUES ('NUEVAS HIPERHEURÍSTICAS COMPETITIVAS PARA EL PROBLEMA DEL CONJUNTO INDEPENDIENTE MÁXIMO DE VÉRTICES', '20/01/2014', 584, 'default', 579, '169428166', NULL, NULL);
INSERT INTO propuesta VALUES ('GENERACIÓN DE ALGORITMOS UTILIZANDO PROGRAMACIÓN GENÉTICA PARA EL PROBLEMA DE OPTIMIZACIÓN GENERALIZED TRAVELLING SALESMAN PROBLEM', '20/01/2014', 585, 'default', 580, '158207664', NULL, NULL);
INSERT INTO propuesta VALUES ('EVALUACIÓN DE ALGORITMOS GENÉTICOS CELULARES PARA EL PROBLEMA DE CORTE DE PIEZAS', '28/12/12', 586, 'default', 581, '15366708K', NULL, NULL);
INSERT INTO propuesta VALUES ('DISEÑO DE UN ALGORITMO PARA EL PROBLEMA DEL COLOREAMIENTO DE GRAFOS A TRAVÉS DE UN JUEGO COMPUTACIONAL.', '', 587, 'default', 582, '163905140', NULL, NULL);
INSERT INTO propuesta VALUES ('UN SISTEMA WEB DE VIDEOS EDUCATIVOS PARA SEGUNDO Y TERCER NIVEL DE INGENIERÍA.', '', 588, 'default', 583, '171100062', NULL, NULL);
INSERT INTO propuesta VALUES ('CO-EVOLUCIÓN COMPUTACIONAL EN PROBLEMAS DE OPTIMIZACIÓN COMBINATORIA', '22/12/2014', 589, 'default', 584, '173196474', NULL, NULL);
INSERT INTO propuesta VALUES ('REVISIÓN Y MEJORAS DEL SOFTWARE PARA LA ADMINISTRACIÓN DE LAS POSTULACIONES A PROGRAMAS VESPERTINOS DEL DIINF', '23/12/2014', 590, 'default', 585, '17919998k', NULL, NULL);
INSERT INTO propuesta VALUES ('DATOS SENSIBLES Y SU MANIPULACIÓN EN DISPOSITIVOS MÓVILES', '23/12/2014', 591, 'default', 586, '181724315', NULL, NULL);
INSERT INTO propuesta VALUES ('APLICACIÓN MULTIPLATAFORMA PARA DENUNCIAS, SUCESOS Y EVENTOS GEOCALIZADOS EN TIEMPO REAL CON EVIDENCIA MULTIMEDIA', '1/12/2014', 592, 'default', 587, '180628754', NULL, NULL);
INSERT INTO propuesta VALUES ('SISTEMA WEB DE CARACTERIZACIÓN BIOLÓGICA DE GRUPOS DE GENES ', '22/12/2014', 593, 'default', 588, '17962091K', NULL, NULL);
INSERT INTO propuesta VALUES ('PROP', '14/05/2015', 602, '1/2016', 594, '159073122', false, NULL);
INSERT INTO propuesta VALUES ('PPP', '16/05/2015', 603, '1/2016', 595, '128516948', false, NULL);
INSERT INTO propuesta VALUES ('ASD', '16/05/2015', 604, '1/2016', 596, '173832168', false, NULL);
INSERT INTO propuesta VALUES ('123', '29/05/2015', 605, '1/2016', 597, '171818575', false, NULL);
INSERT INTO propuesta VALUES ('PROPUESTA PROP', '20/05/2015', 607, '1/2016', 598, '166257344', false, NULL);
INSERT INTO propuesta VALUES ('PROPUESTA PROP1', '17/05/2015', 608, '1/2016', 599, '128516948', false, NULL);
INSERT INTO propuesta VALUES ('PROP EJEMP', '21/05/2015', 609, '1/2016', NULL, '173832168', false, NULL);
INSERT INTO propuesta VALUES ('ASDASDAS', '14/05/2015', 611, '1/2016', NULL, '153179409', false, NULL);
INSERT INTO propuesta VALUES ('ASDASDSDSADSA', '19/05/2015', 612, '1/2016', 602, '128516948', false, NULL);
INSERT INTO propuesta VALUES ('PROPUESTA EJEMPLO 2', '21/05/2015', 613, '1/2016', 603, '153179409', false, NULL);
INSERT INTO propuesta VALUES ('PROPUESTA CON JOSE LUIS', '18/05/2015', 614, '1/2016', 604, '173832168', false, NULL);
INSERT INTO propuesta VALUES ('PROPUESTA ASD', '20/05/2015', 615, '1/2016', 605, '153179409', false, NULL);
INSERT INTO propuesta VALUES ('PROPP', '20/05/2015', 616, '1/2016', 606, '128516948', false, NULL);


--
-- Name: propuesta_id_propuesta_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('propuesta_id_propuesta_seq', 616, true);


--
-- Data for Name: seccion; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: semestre; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO semestre VALUES ('default');
INSERT INTO semestre VALUES ('1/2015');
INSERT INTO semestre VALUES ('1/1990');
INSERT INTO semestre VALUES ('2/2015');
INSERT INTO semestre VALUES ('2/2014');
INSERT INTO semestre VALUES ('1/2011');
INSERT INTO semestre VALUES ('2/2012');
INSERT INTO semestre VALUES ('2/2013');
INSERT INTO semestre VALUES ('1/2012');
INSERT INTO semestre VALUES ('1/2010');
INSERT INTO semestre VALUES ('1/2016');
INSERT INTO semestre VALUES ('2/2011');


--
-- Data for Name: semestre_actual; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO semestre_actual VALUES ('1/2016');


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

INSERT INTO tema VALUES ('DISEÑO DE UN SISTEMA QUE PERMITA LA CREACIÓN DE APLICACIONES EDUCATIVAS', '30/03/13', 1, 5, 3, 'default', 5, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SOLUCION TECNOLOGICA PARA LA CREACION DE SITIOS WEB Y SU GESTION DE INFORMACION, EN UNA EMPRESA DE SELECCIÓN DE PERSONAL', '4/8/2010', 1, 8, 5, 'default', 8, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SOFTWARE DE APOYO AL PROCESO ADMINISTRATIVO DE LA EMPRESA OPTICA REAL', '11/10/2012', 3, 10, NULL, 'default', 10, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE EVALUACIÓN INTERACTIVO CON DISPOSITIVOS SMARTPHONE', '1/2014', 3, 18, NULL, 'default', 18, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA INFORMÁTICO PARA EL PROCESO DE POSTULACIÓN EN LÍNEA Y POSTERIOR SELECCIÓN DE AYUDANTES DEL DEPARTAMENTO DE INFENIERÍA INFORMÁTICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '7/9/2012', 1, 11, 6, 'default', 11, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IMPLEMENTACIÓN DE WEB SERVICE PARA INTEGRACIÓN SAP CON PLATAFORMAS WEB', '', 3, 19, NULL, 'default', 19, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA INFORMÁTICO PARA LA GESTIÓN DE RECURSOS DEL DEPARTAMENTO DE DEPORTES DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '2/2013', 1, 12, 7, 'default', 12, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('AUTOMATIZACIÓN DEL PROCESO PARA VISADO DE PAGO A PROVEEDORES DE LA EMPRESA ENVASES DEL PACÍFICO (EDELPA)', '11/11/2014', 3, 21, NULL, 'default', 21, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA PARA MONITOREO Y GESTIÓN DE REQUERIMIENTOS E INCIDENTES DE CLIENTES CORPORATIVOS EMPRESA ENTEL, MEDIANTE HERRAMIENTA SPLUNK', '20/03/12', 1, 13, 8, 'default', 13, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLAR JUEGOS PARA CURSO DE ECONOMÍA DE BACHILLER DE TECNOLOGÍA', '', 3, 15, NULL, 'default', 15, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE SISTEMA DE PLANIFICACIÓN DE MISIÓN Y CONTROL ADAPTIVO EN VUELO PARA EL SISTEMA AEREO ROBOTICO RUAS', '11/10/1012', 3, 27, NULL, 'default', 27, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROTOTIPO FUNCIANAL DE UN SISTEMA BROKER PARA LA EMPRESA SOLINGAS S.A', '11/1/2013', 1, 16, 9, 'default', 16, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA WEB ADMINISTRATIVO Y RESERVAS DE ATENCIÓN EN LÍNEA PARA UNA SERVITECA', '11/1/2013', 3, 17, NULL, 'default', 17, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE TECNOLOGÍAS DE LA INFORMACIÓN EN LA ENSEÑANZA BÁSICA', '11/1/2013', 3, 20, NULL, 'default', 20, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SOFTWARE PARA PLANIFICACIÓN DE VUELO FOTOGRAMÉTRICO DE UAV EN TERRENOS COMPLEJOS', '1/2014', 3, 28, NULL, 'default', 28, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBEJTOS DE APRENDIZAJE PARA LA ENSEÑANZA DE LA LENGUA DE SEÑAS CHILENAS PARA NIÑOS CON DISCAPACIDAD AUDITIVA', '11/1/2013', 1, 22, 10, 'default', 22, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE DETECCIÓN Y EVASIÓN DE OBSTÁCULOS PARA UAV CUADRICOPTERO BASADO EN ARDUPILOT', '1/2014', 3, 32, NULL, 'default', 32, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('HERRAMIENTA DE SOFTWARE PARA ENTREGA DE INFORMACIÓN TURÍSTICA DIFERENCIADA Y FOCALIZADA EN PERFILES DE TURISTICA', '30/03/12', 1, 23, 11, 'default', 23, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE DETECCIÓN DE PERSONAS EXTRAVIADAS, POR MEDIO DE RECONOCIMIENTO DE PATRONES EN IMAGÉNES TRANSMITIDAS EN TIEMPO REAL DESDE AVIÓN NO TRIPULADO', '11/01/13', 3, 33, NULL, 'default', 33, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROTOCOLO PARA LA INTEROPERACIÓN DE UAVS, MEDIANTE UNA TORRE DE CONTROL VIRTUAL EN UN ESPACIO  AÉREO NO SEGREGADO "OGMIOS"', '12/10/11', 1, 24, 12, 'default', 24, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UN SISTEMA PARA EL LANZAMIENTO DE SUMINISTROS MÉDICOS DESDE UN VEHÍCULO AÉREO NO TRIPULADO', '2/2013', 3, 35, NULL, 'default', 35, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACIÓN DEALGORITMOS AEROFOTOGRAMÉTRICOS PARA CORRECCIÓN ORTOGONAL DE IMÁGENES, OBTENIDAS MEDIANTES UAV, USACDAS PARA GENERAR MOSAICOS Y MODELOS 3D', '21/03/2013', 1, 26, 13, 'default', 26, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE SOFTWARE PARA CONTROL DE PLANES DE VUELO DE SISTEMA ROBÓTICO AÉREO MULTIAGENTE, BASADO EN LA ARQUITECTURA L-ALLIANCE', '11/01/13', 3, 29, NULL, 'default', 29, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IMPLEMENTACIÓN DE ARQUITECTURA MULTIAGENTE L-ALLIANCE PARA EL CONTROL DE COMPORTAMIENTO DE VUELO DE ROBOTS AÉREOS', '', 3, 30, NULL, 'default', 30, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('AUTOPILOTO INTEGRADO EN SMARTPHONE PARA VEHÍCULO AÉREO NO TRIPULADO (UAV)', '1/2014', 3, 36, NULL, 'default', 36, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DIFERENCIACIÓN DE VIGOR VEGETATIVO EN CULTIVOS AGRÍCOLAS POR MEDIO DEL TRATAMIENTO DE IMÁGENES INFRARROJAS AÉREAS, CAPTURADAS CON UN AVIÓN ROBOTIZADO', '30/03/12', 1, 31, 14, 'default', 31, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE SOFTWARE EMBEBIDO EN HARDWARE PARA DETECCIÓN DE FIGURAS HUMANAS DESDE ROBOT AÉREO', '2/2014', 3, 38, NULL, 'default', 38, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE APOYO A LA DOCUMENTACIÓN DE IMÁGENES, AUTOMATIZANDO EL RECONOCIMIENTO DE EDIFICIOS Y ESTRUCTURAS', '11/10/12', 1, 34, 15, 'default', 34, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UNA PLATAFORMA DE SOFTWARE PARA PRUEBAS DE REGRESIÓN AUTOMATIZADAS DE APLICACIONES WEB USADAS EN EL OBSERVATORIO ALMA', '23/07/2013', 3, 40, NULL, 'default', 40, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE ORIENTACIÓN DE SERVICIOS TURÍSTICOS PARA DISPOSITIVOS MÓVILES UTILIZANDO REALIDAD AUMENTADA.', '30/03/12', 1, 37, 16, 'default', 37, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UTILIZACIÓN DE UNA METODOLOGÍA ÁGIL PARA ENTEL S.A.', '29/07/2013', 3, 41, NULL, 'default', 41, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACIÓN WEB PARA EVALUACIÓN DEL DESEMPEÑO Y AUTOCONSULTA DE RECURSOS HUMANOS', '22/01/13', 1, 39, 17, 'default', 39, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UNA APLICACIÓN COLABORATIVA PARA APOYAR EL USO DE LA METODOLOGÍA DE SISTEMAS BLANDOS DE PETER CHECKLAND', '1/2014', 3, 44, NULL, 'default', 44, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UNA APLICACIÓN DE PROTOTIPO EN LA WEB USANDO TECNOLOGÍA DE LA NUBE', '22/07/2013', 1, 42, 18, 'default', 42, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PREDICCIÓN DE LA RENTABILIDAD DE LOS FONDOS DE PENSIONES UTILIZANDO AUTÓMATAS CELULARES', '22/07/2013', 3, 45, NULL, 'default', 45, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE APOYO A LA GESTIÓN PARA EL PROCESO DE CERTIFICACIÓN DE SOFTWARE QA', '22/07/2013', 1, 43, 19, 'default', 43, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CLASIFICADOR DE PUNTOS SOBRE NUBE DE OBJETOS GENERADA POR SISTEMA LIDAR', '', 3, 46, NULL, 'default', 46, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UNA APLICACIÓN MÓVIL QUE APOYA LA REALIZACIÓN DE LA METODOLOGÍA DE SISTEMAS BLANDOS DE PETER CHECKLAND', '2/2014', 3, 47, NULL, 'default', 47, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROPUESTA DE MEJORAS METODOLÓGICAS PARA LA GESTIÓN DE LA INCERTIDUMBRE EN PROYECTOS DE SOFTWARE ÁGILES DESDE UN ENFOQUE DE SISTEMAS BLANDOS', '2/2014', 3, 48, NULL, 'default', 48, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE SOPORTE A EDUCADORES EN ENTORNOS DE EVALUACIÓN Y APRENDIZAJE DE ALUMNOS CON NECESIDADES EDUCATIVAS ESPECIALES EN ÁREAS COGNITIVAS', '1/2014', 3, 49, NULL, 'default', 49, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE ADMINISTRACIÓN PARA LA INFORMACIÓN TRANSPARENTE EN UNA COMUNIDAD DE EDIFICIOS', '', 3, 9, NULL, 'default', 9, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE ESTRATÉGIAS DE PLANIFICACIÓN PARA MOTORES DE BÚSQUEDA VERTICALES', '', 3, 51, NULL, 'default', 51, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PREDICCIÓN DE L ESTRUCTURA TRIDIMENSIONAL DE PROTEÍNAS MEDIANTE CLOUD COMPUTING', '', 1, 54, 20, 'default', 54, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ADAPTACIÓN DE ALGORITMOS DE ORDENAMIENTO A MÁQUINAS DE BÚSQUEDA VERTICALES', '11/1/2013', 3, 55, NULL, 'default', 55, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE APOYO A LA PLANIFICACIÓN DOCENTE Y MEDICIÓN DEL ESTADO DE AVANCE DE LOS ALUMNOS EN HABILIDADES COGNITIVAS ESPECÍFICAS', '30/03/2013', 3, 3, NULL, '1/2016', 3, '15/05/2015', '15/05/2015', NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE API DE VALIDACIÓN MEDIANTE HUELLA DIGITAL EN TARJETAS CON CHIP', '11/10/2012', 1, 2, 2, '2/2012', 2, '16/05/2015', '15/05/2015', NULL, NULL, NULL);
INSERT INTO tema VALUES ('NO HAY INFORMACION', '', 3, 246, NULL, 'default', 246, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE PROTOTIPO DE UNA CALCULADORA DE DOSIS PARA EL APOYO DEL ÁREA DE PEDRIATRÍA', '15/05/2015', 3, 14, NULL, '1/2015', 14, '17/05/2015', '16/05/2015', NULL, NULL, NULL);
INSERT INTO tema VALUES ('SOFTWARE DE AGENDA PERSONAL Y ASISTENTE PARA ESTRATEGIAS SOCIALES PARA PERSONAS CON SÍNDROME DE ASPERGER', '1/2014', 3, 52, NULL, 'default', 52, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ESTUDIO Y ANÁLISIS DE HERRAMIENTAS DE PROCESAMIENTO DE DATOS EN STREAMING', '11/1/2013', 1, 57, 21, 'default', 57, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PREDICCION DE LA ESTRUCTURA TRIDIMENSIONAL DE PROTEINAS MEDIANTE CLOUD COMPUTING', '', 3, 53, NULL, 'default', 53, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROTOTIPO DE SOFTWARE DE COMUNICACIÓN A TRAVÉS DE BLUETOOTH PARA USO COMERCIAL Y SOCIAL', '11/01/13', 1, 59, 22, 'default', 59, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IMPLEMENTACIÓN DE ALGORITMOS DE MEJORA DE CLASIFICACIÓN EXTRAÍDOS DESDE EL ESTADO DEL ARTE', '1/2014', 3, 56, NULL, 'default', 56, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('INSTALACIÓN Y CONFIGURACIÓN DE HERRAMIENTA ORACLE ENTERPRICE GOVERNANCE, RISK AND COMPLIANCE, MÓDULO APPLICATION ACCESS CONTROL GOVERNOR', '29/07/2013', 1, 67, 23, 'default', 67, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE SEGUIMIENTO DE JUICIOS APOYAR LA GESTIÓN DE COBRANZA DE EMPRESA RECOLINE', '21/12/2012', 3, 71, NULL, 'default', 71, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE APOYO A LAS VENTAS Y SERVICIOS TÉCNICOS DE LA EMPRESA IMPORTADORA NORTE', '28/09/2012', 3, 72, NULL, 'default', 72, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN FIREWALL EN ALTA DISPONIBILIDAD', '', 3, 58, NULL, 'default', 58, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE TRAZABILIDAD COMO APOYO AL PROCESO DE ELABORACIÓN DE JUGO/MOSTO', '2/2012', 1, 74, 24, 'default', 74, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACIÓN DE APOYO AL PROCESO DE GESTIÓN DE SERVICIOS DE TALLER', '1/2014', 3, 60, NULL, 'default', 60, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE CONTROL DE ASISTENCIA Y APOYO AL CÁLCULO DE REMUNERACIONES BASADOS EN PRODUCCIÓN', '2/2012', 1, 75, 25, 'default', 75, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE SEGUIMIENTO DE CLIENTES DE UNA EMPRESA INFORMÁTICA', '1/2014', 3, 61, NULL, 'default', 61, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CENTRAL DE REPORTES PARA EL ÁREA DE RIESGOS DE MERCADO DEL BANCO SANTANDER', '11/09/13', 1, 77, 26, 'default', 77, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLO DE BASE DE DATOS PARA OBSERVATORIOS WEB', '1/2014', 3, 62, NULL, 'default', 62, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('METODOLOGÍA DE GESTIÓN DE PROCESOS ORIENTADA A LA DETERMINACIÓN Y ADMINISTRACIÓN DE RIESGOS OPERACIONAL EN UNA INSTITUCIÓN BANCARIA', '27/2012', 1, 79, 27, 'default', 79, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ALGORITMO DE IDENTIFICACIÓN DE LÍDERES DE OPINIÓN EN TWITTER', '', 3, 63, NULL, 'default', 63, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IMPLEMENTACIÓN DE BPM PARA LA GESTIÓN DOCUMENTAL DE UN SERVICIO PÚBLICO', '15/01/2013', 1, 80, 28, 'default', 80, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE UBICACIÓN DEL CENTRO DE MASA EN ADULTOS MAYORES A TRAVÉS DE DISPOSITIVOS MÓVILES', '1/2014', 3, 64, NULL, 'default', 64, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE ADMINISTRACIÓN DE CAPACITACIONES PARA EMPRESA CAPACITACIÓN USACH LTDA.', '20/01/2014', 1, 81, 29, 'default', 81, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SIMULACION DE APLICACIOINES UTILIZADAS EN ESCENARIOS DE EMERGENCIA, DESPLEGADAS SOBRE LA PLATAFORMA S4 ADAPTADA A CELULARES', '', 3, 65, NULL, 'default', 65, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('INTEGRACIÓN DE PLATAFORMA ERP CORPORATIVA CON LICENCIA MEDICA ELECTRONICA Y REDISEÑO DE PROCESOS ASOCIADOS', '25/01/2013', 1, 82, 30, 'default', 82, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MODELO DE PROCESOS DE LA OTEC USECAP, SEGÚN NORMAS NCH 2728  E ISO 9001/2008. DESARROLLO DE SISTEMA PARA LA TRAZABILIDAD', '20/09/2011', 3, 83, NULL, 'default', 83, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DETECCIÓN DE LOS ACTOS DEL HABLA DE INDAGACIÓN Y PERSUACIÓN UTILIZANDO EN FRAMEWORK DE EXPERIMENTACIÓN.', '11/10/12', 1, 84, 31, 'default', 84, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('INTEGRACION DEL CONTROL DE UN PROCESO DE NEGOCIOS DE GENERACION DE NOTICIAS CON LA COLABORACION ENTRE PERIODISTAS UTILIZANDO UNA RED SOCIAL CORPORATIVA', '1/2013', 3, 85, NULL, 'default', 85, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SOFTWARE DE EJERCICIOS DE ESTIMULACIÓN Y EVALUACIÓN COGNITIVA PARA PACIENTES CON PARKINSON', '2/2014', 3, 68, NULL, 'default', 68, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE INFORMACIÓN PARA EL APOYO A LA EVALUACIÓN DE LOCALES PARA EMPRESA TACK S.A', '7/12/2011', 1, 87, 32, 'default', 87, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SOFTWARE DE EJERCICIOS DE ESTIMULACIÓN Y EVALUACIÓN MOTORA PARA PACIENTES CON PARKINSON', '2/2014', 3, 69, NULL, 'default', 69, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('INFERENCIA DE SOMNOLENCIA AL CONDUCIR UN AUTOMÓVIL MEDIANTE LOS MOVIMIENTOS DE LA CABEZA', '10/11/12', 1, 88, 33, 'default', 88, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE API PARA ANÁLISIS DE TÓPICOS EN REDES SOCIALES', '2/2014', 3, 70, NULL, 'default', 70, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('INCORPORACION DE LA DETECCION DEL BOSTEZO EN UN PROTOTIPO RECONOCEDOR DEL ESTADO DE SOMNOLENCIA EN EL DOMINIO DE LA CONDUCCION DE VEHICULOS', '', 1, 89, 34, 'default', 89, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('FORO WEB CON ENFOQUE DE DIÁLOGO DISTRIBUIDO PARA MANTEKA', '2/2013', 3, 90, NULL, 'default', 90, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROTOTIPO DE UN SISTEMA INFORMÁTICO DE POSTULACIÓN, EVALUAVIÓN Y SELECCIÓN DE AYUDANTE DE DOCENCIA', '19/05/2014', 3, 73, NULL, 'default', 73, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACIÓN Y MEJORA DE LA INFRAESTRUCTURA DE UNA RED SOCIAL GENERADORA DE NOTICIAS MEDIANTE MONITORES DE RENDIMIENTO DE SOFTWARE', '11/10/2012', 1, 93, 35, 'default', 93, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DE ETL PARA SERVICIOS DE LEASING FINANCIERO Y OPERATIVO', '27/10/2014', 3, 76, NULL, 'default', 76, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UNA PLATAFORMA DE SOFTWARE PARA LA RECAUDACIÓN EN LÍNEA MODALIDAD PRESENCIAL ENTRE INSTITUCIONES RECAUDADORAS AUTORIZADAS Y LA TESORERÍA GENERAL DE LA REPUBLICA', '22/07/2013', 1, 94, 36, 'default', 94, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBSERVATORIO WEB DE PROYECTOS INNOVADORES EN INFORMÁTICA', '2/2013', 3, 78, NULL, 'default', 78, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DETECCIÓN DE NIVELES DE ESTRÉS  A TRAVÉS DEL PROCESAMIENTO DE LA VOZ EN TELÉFONOS INTELIGENTES', '3/12/2013', 1, 95, 37, 'default', 95, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PORTAL WEB CON RED SOCIAL CORPORATIVA PARA LA ORGANIZACIÓN REASE', '28/11/2014', 3, 91, NULL, 'default', 91, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('HERRAMIENTA DE EXPERIMENTACIÓN CONFIGURABLE QUE PERMITA  COMPARAR Y PROBAR ALGORITMOS DE RECOMENDACIÓN CON EL FIN DE GENERAR  DISPONIBIZAR SERVICIOS DE RECOMENDACIÓN PARA DISTINTOS TIPOS DE REDES SOCIALES', '', 1, 96, 38, 'default', 96, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACION DE UN MODULO DE EVALUACION DE RENDIMIENTO ESCALABLE Y MANTENIBLE PARA UNA RED SOCIAL GENERADORA DE NOTICIAS', '25/10/2013', 3, 92, NULL, 'default', 92, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SOFTWARE COMO LABORATORIO PARA PROBAR Y EVALUAR ALGORITMOS DE RECOMENDACIÓN COLABORATIVA', '04/10/11', 1, 97, 39, 'default', 97, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MODELO PREDICTIVO PARA LA VENTA-CRUZADA DE PRODUCTOS FINANCIEROS UTILIZANDO MINERÍA DE DATOS.', '22/12/10', 3, 247, NULL, 'default', 247, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE HERRAMIENTAS PARA MEDIR COMPETENECIAS EN APRENDIZAJE BASADO EN PROYECTOS', '1/2014', 3, 98, NULL, 'default', 98, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SOFTWARE DE APOYO EN EL RECONOCIMEINTO DE MENTIRAS EN VICTIMAS DE ABUSO SEXUAL INFANTIL', '1/2014', 3, 99, NULL, 'default', 99, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACIÓN ANDROID FISCALIZACIÓN CIUDADANA', '21/11/2013', 3, 66, NULL, 'default', 66, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN SERVICIO DE INTEGRACIÓN PARA ACTUALIZAR SERVICIOS DE RECOMENDACIÓN DE ETIQUETAS EN UNA RED SOCIAL EMPRESARIAL DE NOTICIAS', '11/01/13', 3, 100, NULL, 'default', 100, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('RECONOCEDOR DE SONRISAS ANSIOSAS EN SITUACIONES EXPERIMENTALES PARA PESQUISAR ENGAÑO', '1/2014', 3, 109, NULL, 'default', 109, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN ETIQUETADOR INTERACTIVO DE DOCUMENTOS DENTRO DE UN PROCESO DE NEGOCIOS DE GENERACIÓN DE NOTICIAS.', '22/07/2012', 1, 102, 40, 'default', 102, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('VISUALIZANDO DIÁLOGOS EN COMUNIDADES VIRTUALES DE APRENDIZAJE', '22/08/2014', 3, 115, NULL, 'default', 115, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE ADMINISTRACION AGIL PARA MULTIPLES PROYECTOS', '', 1, 103, 41, 'default', 103, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IDENTIFICACIÓN DE PATRONES DE USO PARA USUARIOS DEL TRANSANTIAGO.', '07/10/11', 3, 565, NULL, 'default', 565, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SELECCIÓN DE IMPLEMENTACIÓN DE ALGORITMO DE RECOMENDACIÓN BASADO EN TGS EN UNA RED SOCIAL GENERADORA DE NOTICIAS', '11/01/13', 3, 104, NULL, 'default', 104, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE APLICACIONES WEB PARA ORGANIZACIONES SIN FINES DE LUCRO POR MEDIO DE LA ARQUITECTURA DE LA INFORMACIÓN', '2/2013', 3, 116, NULL, 'default', 116, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ALGORITMO DE RECOMENDACIÓN DE TAGS BASADO EN CLUTERS PARA UNA RED SOCIAL DE NOTICIAS', '29/05/2014', 1, 105, 42, 'default', 105, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROTOTIPO DE SUITE AFECTIVA PARA EL ANALISIS DE LA SATISFACCIÓN DEL USUARIO.', '25/02/10', 3, 106, NULL, 'default', 106, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ETIQUETADO EMOCIONAL IMPLÍCITO EN REDES SOCIALES DE NOTICIAS', '11/10/2012', 3, 119, NULL, 'default', 119, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('AUTOMATIZACION DEL PROCESO DE CONTRATACION DE PROFESORES POR HORA PARA LA FACULTAD DE INGENIERIA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '', 1, 107, 43, 'default', 107, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EL ENFOQUE DIÁLOGO-ACCIÓN: CASO DE LAS ACTAS DIALÓGICAS EN SCRUM USANDO TABLEROS KANBAN', '2/2014', 3, 121, NULL, 'default', 121, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('“DESCRIPCIÓN ARQUITECTURAL DE UN SISTEMA GENERADOR DE SERVICIOS DE RECOMENDACIÓN PARA OBSERVATORIOS DE LA WEB”', '11/10/2012', 1, 110, 44, 'default', 110, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MANUAL PARA SELECCIONAR SUITES BMP CON CRITERIOS DE FUNCIONALIDAD Y USABILIDAD: CASO DE PROCESO DE GENERACIÓN DE NOTICIAS', '', 3, 111, NULL, 'default', 111, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('RECURSO DE APRENDIZAJE DE USABILIDAD WEB: UNA APROXIMACIÓN DESDE LA CUARTA HEURÍSTICA DE NIELSEN', '2/2014', 3, 122, NULL, 'default', 122, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACIÓN DE DATASETS CON ESQUEMA ESTÁNDAR PARA ENTRENAR ALGORITMOS DE RECOMENDACIÓN PARA REDES SOCIALES', '11/10/2012', 1, 112, 45, 'default', 112, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE RECOMENDACION Y DIFUSION PARA MOVILES', '', 3, 127, NULL, 'default', 127, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE CONTROL DE CONTRATO CON KANBAN', '', 1, 113, 46, 'default', 113, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO Y DESARROLLO DE UN FRAMEWORK DE NOTIFICACIONES VÍA MENSAJERÍA SMS', '21/12/12', 3, 114, NULL, 'default', 114, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE REPUTACIÓN PARA LA RED SOCIAL WAZE', '2/2014', 3, 129, NULL, 'default', 129, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CONSTRUCCION DE UNA INFRAESTRUCTURA EMPRESARIAL PARA UN SISTEMA DE GENERACIÓN DE NOTICIAS CON ETIQUETADO SOCIAL EN UNA RED SOCIAL CORPORATIVA', '29/11/12', 1, 117, 47, 'default', 117, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UNA ARQUITECTURA DISTRIBUIDA MULTIPLATAFORMA APLICADA A SIMULACIONES MONTE CARLO', '1/2014', 3, 143, NULL, 'default', 143, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('INTERACCIÓN DE SERVICIOS POR EL MEDIO DE UNA INFRAESTRUCTURA SOA, PARA REALIZAR RECOMENDACIONES EN UNA INTERNET DE GENERACIÓN DE NOTICIAS', '09/07/12', 1, 118, 48, 'default', 118, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('HERRAMIENTA DE DISEÑO DE OBJETOS Y VISUALIZACIÓN DE RESULTADOS PARA SIMULACIÓN DE CAMPO MAGNÉTICO', '1/2014', 3, 148, NULL, 'default', 148, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SELECCIÓN DE PERSONAS BAJO EL ENFOQUE DE LA DIRECCIÓN POR VALORES', '11/10/2012', 1, 120, 49, 'default', 120, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE GESTIÓN DE INFORMACIÓN TRANSPARENTE PARA EDIFICIOS DE DEPARTAMENTOS', '11/10/2012', 3, 123, NULL, 'default', 123, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACIÓN ASISTIDA DE DOCUMENTOS COTIDIANOS PARA PERSONAS CON DISCAPACIDAD INTELECTUAL.', '11/10/2012', 3, 124, NULL, 'default', 124, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DETECCIÓN DE FALLAS EN LA RED DE SUMINISTRO DE BANDA ANCHA UTILIZANDO EL PROTOCOLO RADIUS', '11/10/2012', 3, 125, NULL, 'default', 125, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SIMULACIÓN MONTE CARLO PARALELA DEL MODELO HEISENBERG PARA SISTEMAS FERROMAGNÉTICOS', '2/2013', 3, 150, NULL, 'default', 150, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('LOCALIZACION DISTRIBUIDA DE STREAMS PARA EL PROCESAMIENTO DE EVENTOS EN TIEMPO REAL', '', 1, 126, 50, 'default', 126, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MEJORAR LA TOLERANCIA A FALLAS EN UN SISTEMA DE PROCESAMIENTO DE EVENTOS SOBRE DISPOSITIVOS MOVILES', '', 1, 128, 51, 'default', 128, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO MOTODOLÓGICO PARA LA ELABORACIÓN Y DESARROLLO DE SECUENCIAS DE ACTIVIDADES INTERACTIVAS PARA LA ENSEÑANZA DEL CAMPO ADICTIVO EN EL PRIMER CICLO BÁSICO', '11/10/12', 3, 130, NULL, 'default', 130, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA PARA GUIAR LA REALIZACIÓN DE ACTIVIDADES ESCOLARES EN CASA', '22/02/12', 1, 131, 52, 'default', 131, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROTOTIPO FUNCIONAL DE UNA RED SOCIAL VERTICAL PARA EL SOFTWARE GREI', '11/10/12', 3, 132, NULL, 'default', 132, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ANALISIS BIOMECANICA DE ANGULOS EN LA SALIDA DE TACOS', '05/10/11', 3, 133, NULL, 'default', 133, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE SISTEMA DE COTIZACIÓN Y DE CONTROL DE EXISTENCIAS PARA LA EMPRESA ALUMAR', '11/10/2012', 3, 134, NULL, 'default', 134, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE RECONOCIMIENTO Y DIGITALIZACIÓN DE IMÁGENES DE PARTITURAS ESCRITAS A MANO', '07/08/10', 3, 135, NULL, 'default', 135, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETIVOS DE APRNEDIZAJE PARA APOYART LA COMPRENSION Y APLICACION DE LA CRIPTOGRAFIA CLASICA ', '12/7/2010', 1, 136, 53, 'default', 136, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE SEGUIMIENTO A CLIENTES Y DE APOYO A LAS REPARACIONES PARA UN TALLER MECÁNICO', '11/10/2012', 3, 137, NULL, 'default', 137, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE VISUALIZACION DEL POSICIONAMIENTO GEORREFERENCIAL ON-LINE DE EQUIPOS DE EXTRACCION MINERA', '20/09/2011', 3, 138, NULL, 'default', 138, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ESTRATEGIA DE PARALELIZACION DE SIMULACIONES DE EVENTOS DISCRETOS E INDEPENDIENTES EN GPU', '1/2013', 1, 139, 54, 'default', 139, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('RESOLUCIÓN DEL GENERALIZED MINIMUN SPANNING TREE PROBLEM MEDIANTE ALGORITMOS GENÉTICOS', '1/19/2010', 1, 140, 55, 'default', 140, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CARACTERIZACIÓN Y OPTIMIZACIÓN DEL USO DE LA MEMORIA CACHE PARA EL ALGORITMO DE RECONSTRUCCIÓN ESTADÍSTICO DE IMÁGENES MÉDICAS EM-ML.', '1/2010', 1, 141, 56, 'default', 141, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DE ALGORITMOS PARALELOS DE RECONTRUCIÓN DE IMÁGENES BASADOS EN EL PARADIGMA "ESPACIO DE DIRECCIONES GLOBALES PARTICIONADO".', '05/10/11', 1, 142, 57, 'default', 142, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO DE UNA API PARA LA IMPLEMENTACIÓN DE ALGORITMOS ESTADÍSTICOS DE RECONSTRUCCIÓN TOMOGRÁFICA DE IMÁGENES', '11/10/12', 1, 144, 58, 'default', 144, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MODELACIÓN Y SIMULACIÓN DEL ESCÁNER PET SIEMENS BIOGRAPH', '11/01/13', 1, 145, 59, 'default', 145, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MODELAMIENTO E IMPLEMENTACION ORIENTADA A OBJETOS DE SIMULACIONES MONTE CARLO CONCURRENTES EN BIOLUMINISCENCIA MEDIANTE EL USO DE LA EXTENSION UC++', '11/10/12', 1, 146, 60, 'default', 146, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ESTUDIO E IMPLEMENTACIÓN DE ALGORITMOS ESTADÍSTICOS PARALELOS, PARA LA RECONSTRUCCIÓN DE IMÁGENES.', '1/2010', 1, 147, 61, 'default', 147, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('RECONTRUCCIÓN TOMOGRÁFICA PARALELA PARA UN ESCÁNER PET DE ANIMALES PEQUEÑOS', '05/12/08', 3, 149, NULL, 'default', 149, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PREDICCIÓN DE FENÓMENOS SÍSMICOS EN UN ÁREA GEOGRÁFICA DETERMINADA USANDO REDES NEURONALES', '2/2012', 1, 152, 62, 'default', 152, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACIÓN WEB PARA ADMINISTRACIÓN DOCUMENTAL DE VEHÍCULOS', '', 3, 328, NULL, 'default', 328, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ANÁLISIS COMPARATIVO DE MODELOS NARMA (X) Y NAR (X) USANDO REDES NEURONALES Y SVM SOBRE SISTEMAS CAÓTICOS', '11/1/2013', 3, 153, NULL, 'default', 153, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE PREDICCIÓN DEL TRÁFICO DE UN MOTOR DE BÚSQUEDA WEB', '02/02/12', 1, 154, 63, 'default', 154, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PREDICCION DE SERIES DE TIEMPO USANDO RN Y SVM', '20/09/11', 1, 155, 64, 'default', 155, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CONSTRUCCIÓN DE MODELOS PREDICTIVOS PARA EL ÍNDICE DE DISPONIBILIDAD DE LOS EQUIPOS MINEROS PESADOS USANDO MODELOS DINÁMICOS CON RNA Y SVM', '2/2013', 3, 156, NULL, 'default', 156, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PREDICCIÓN DE FENÓMENOS SÍSMICOS EN UN ÁREA GEOGRÁFICA DETERMINADA USANDO REDES NEURONALES Y MÁQUINAS DE VECTORES DE SOPORTE', '30/03/2012', 1, 157, 65, 'default', 157, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA PROTOTIPO DE APOYO A LA ALERTA TEMPRANA DE SISMOS MEDIANTE USO DE HERRAMIENTAS DE INTELIGENCIA COMPUTACIONAL', '1/2014', 3, 158, NULL, 'default', 158, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA INFORMATICO PARA LA PREDICCIÓN DE FALLAS EN ANTENAS DEL OBSERVATORIO ALMA, UTILIZANDO HERRAMIENTAS DE INTELIGENCIA COMPUTACIONAL', '22/07/2013', 1, 159, 66, 'default', 159, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MODELO DINÁMICO PARA LA GESTIÓN DE FLOTAS DE PALAS EN FAENAS MINERAS', '2/2013', 3, 161, NULL, 'default', 161, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO Y EVALUACIÓN DE UN MODELO CUANTITATIVO DE ESTIMACIÓN DE COMPONENTES MINERALÓGICOS DE ARCILLAS, A TRAVÉS DEL ANÁLISIS DEL ESPECTROGRAMA DEL INFRARROJO CERCANO (NIR), BASADO EN ALGORTIMOS COMPUTACIONALES, PARA EMPRESAS CUPRÍFERAS.', '22/11/2013', 1, 160, 67, 'default', 160, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ELABORACION DE UN CLASIFICADOR DE SEÑALES SISMOGRAFICAS P Y S MEDIANTE SVM: ESTUDIO DE ALGORITMOS DE FILTRADO Y AUTOSIMILARIDAD', '', 3, 163, NULL, 'default', 163, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ELABORACIÓN DE CLASIFICADORES PARA DETECCIÓN DE SEÑALES DE TIPO S Y P MEDIANTE REDES NAURONALES Y SVM', '11/10/2012', 1, 162, 68, 'default', 162, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CONSTRUCCIÓN DE UN MODELO PARA DETERMINAR VARIABLES DE DISPONIBILIDAD Y TIEMPO ENTRE FALLAS EN EL ÁREA DE LA MINERÍA', '2/2014', 3, 164, NULL, 'default', 164, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA COLABORATIVO WEB PARA EL ANÁLISIS Y EVALUACIÓN DE PLANES ESTRATÉGICOS', '17/10/2013', 1, 165, 69, 'default', 165, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA COLABORATIVO DE APOYO AL APRENDIZAJE DE MATEMÁTICAS EN PRIMER AÑO BÁSICO', '30/03/2012', 3, 166, NULL, 'default', 166, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN SISTEMA COLABORATIVO PARA APOYAR EL REFORZAMIENTO DEL IDIOMA INGLÉS EN NIÑOS DE 5Tº AÑO BÁSICO', '30/03/2012', 3, 167, NULL, 'default', 167, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA COLABORATIVO PARA LA PLANIFICACIÓN DE PROYECTOS MEDIANTE CARTAS GANTT.', '15/12/10', 3, 168, NULL, 'default', 168, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA COLABORATIVO PARA COMPLEMENTAR LA ENSEÑANZA DE NIÑOS ENTRE PRIMERO Y SEGUNDO BÁSICO EN LA ASIGNATURA DE INGLÉS', '01/11/13', 3, 173, NULL, 'default', 173, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA COMUNICACIÓN MEDIADA COMPUTADOR PARA APOYAR EL AÁNILIS DE TEMAS EN GRUPOS', '04/10/11', 1, 169, 70, 'default', 169, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB Y MOVIL PARA FOMENTAR EL TURISMO', '', 3, 177, NULL, 'default', 177, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE APOYO AL  ANÁLISIS DE ASUNTOS PARA LA INGENIERÍA DE REQUERIMIENTOS ORIENTADA A ASPECTOS', '13/11/2012', 1, 170, 71, 'default', 170, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('AUTOMATIZACIÓN DE PROCESOS DE INSPECCIONES DE VEHÍCULOS PARA RSA SEGUROS', '1/8/2013', 3, 181, NULL, 'default', 181, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SOFTWARE DE APOYO AL SEGUIMIENTO DEL PLAN ESTRATÉGICO DE LA EMPRESA PÚBLICA EMERES', '7/11/2013', 1, 171, 72, 'default', 171, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('HERRAMIENTA DE APOYO A LA DEFINICIÓN DE REQUISITOS, EN LA INGENIERÍA DE SOFTWARE, EXPLOTANDO RECURSOS DE AUDIO', '2/2012', 3, 187, NULL, 'default', 187, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA COLABORATIVO PARA APOYAR LA PREPARACIÓN DE ENTREVISTAS Y SU POSTERIOR ANÁLISIS EN EL PROCESO DE CAPTURA DE REQUISITOS.', '10/6/2011', 1, 172, 73, 'default', 172, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA COOPERATIVO PARA EL DESARROLLO DE INTERFACES GRÁFICAS', '1/2014', 3, 189, NULL, 'default', 189, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UN MODELO PARA LA ESTIMULACIÓN DEL ESFUERZO EN PROYECTOS DE DESARROLLO DE SOFTWARE.', '16/01/12', 1, 174, 74, 'default', 174, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE APLICACIONES PARA EL APOYO EN LA INTERACCIÓN ANFITRIÓN-AUDIENCIA Y LA GENERACIÓN DE CONTENIDO EN PRESENTACIONES CON PROYECTOR', '1/2014', 3, 190, NULL, 'default', 190, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UNA GUÍA DE ESTRATEGIAS EN APOYO A LA INGENIERÍA DE REQUISITOS', '30/03/2012', 1, 175, 75, 'default', 175, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IMPLEMENTACIÓN DE ARQUITECTURA BASADA EN SWARM PARA BÚSQUEDA COLABORATIVA MEDIANTE VEHÍCULOS AÉREOS NO TRIPULADOS (UAVS)', '1/2014', 3, 25, NULL, 'default', 25, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACIÓN DE UN JUEGO COLABORATIVO QUE PERMITA EL DESARROLLO DE HABILIDADES METAFONOLÓGICAS EN NIÑOS DE ENTRE 4 Y 6 AÑOS', '30/03/2012', 1, 176, 76, 'default', 176, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE COORDINACIÓN DE ACTIVIDADES ACADÉMICAS, REGISTRO DE NOTAS Y PLANES DE ESTUDIO PARA UNA ESCUELA DE ENSEÑANZA BÁSICA', '30/03/2012', 1, 178, 77, 'default', 178, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACIÓN PARA MEJORAR EL SEGUIMIENTO DEL RENDIMIENTO Y LA CONDUCTA DE LOS ALUMNOS EN EL AULA DE CLASES', '30/03/2012', 1, 179, 78, 'default', 179, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE GESTIÓN DE AYUDAS A PROYECTOS E IDEAS (GAPI)', '16/11/2011', 3, 180, NULL, 'default', 180, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACIÓN DE LA EFECTIVIDAD DE UNA PROPUESTA DE TOMA DE REQUIRIMIENTOS BASADA EN CIENCIAS SOCIALES.', '7/30/2010', 1, 182, 79, 'default', 182, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACIÓN DE LA EFECTIVIDAD Y REFORMULACIÓN DE UNA PROPUESTA PARA LA ROMA DE REQUERIMIENTOS APLICADO A UN CASO PRÁCTICO', '27/11/12', 1, 183, 80, 'default', 183, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('METODOLOGIA DE HACKING ETICO PARA APLICACIONES WEB EN PRODUCCION', '11/10/12', 4, 184, NULL, 'default', 184, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE APLICACIÓN COLABORATIVA PARA LA EVALUACIÓN DE USABILIDAD DE SOFTWARE STANDALONE BASADO EN FORMULARIO', '07/05/13', 1, 185, 81, 'default', 185, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE APOYO AL APRENDIZAJE DE LA LECTURA DE LOS NIÑOS', '03/09/08', 3, 186, NULL, 'default', 186, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACIÓN Y RECOMENDACIONES DE MEJORAS DE LA USABILIDAD DE BROWSERS WEB PARA USUARIOS ADULTOS MAYORES CON POCA EXPERIENCIA EN EL USO DE COMPUTADORES.', '12/13/2010', 3, 188, NULL, 'default', 188, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLAR UN AMBIENTE WEB QUE PERMITA REPRESENTAR  INFORMACIÓN ASOCIADA AL CRÉDITO HIPOTECARIO UTULIZANDO ORGANIZADORES GRÁFICOS PARA VIRTUALAB - USACH', '24/06/2013', 3, 191, NULL, 'default', 191, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE COMPONENTES DE SOFWARE EN HTML 5 QUE IMPLEMENTEN ORGANIZADORES GRAFICOS INTERACTIVOS', '22/03/11', 3, 192, NULL, 'default', 192, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN AMBIENTE WEB UTILIZANDO ORGANIZADORES GRÁFICOS EN LA REPRESENTACIÓN DE CONTENODOS SOBRE EL INFARTO AGUDO AL MIOCARDIO.', '02/08/10', 3, 193, NULL, 'default', 193, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE COMPONENTES DE SOFWARE QUE IMPLEMENTEN ESTRATEGIAS VISUALES PARA LA PRUDUCCIIÓN DE TEXTO ARGUMENTATIVO TIPO ENSAYO DE NIVEL BÁSICO TRES A SEIS.', '12/07/10', 3, 194, NULL, 'default', 194, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE COMPONENTES DE SOFWARE PARA LA PRODUCCIÓN DE CUENTOS INFANTILES', '12/07/10', 3, 195, NULL, 'default', 195, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN AMBIENTE WEB PROTOTIPO QUE PERMITA REPRESENTAR INFORMACIÓN DEL CRÉDITO HIPOTECARIO UTILIZANDO ORGANIZADORES GRÁFICOS.', '24/08/10', 3, 196, NULL, 'default', 196, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('TEMA DE ALBERTOX', '24/12/2010', 3, 590, NULL, '1/2015', 589, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE COMPONENTES DE SOFTWARE QUE IMPLEMENTEN DIAGRAMAS UTILIZADOS EN LA PLANEACIÓN ESTRATÉGICA.', '03/08/10', 1, 197, 82, 'default', 197, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE COMPONENTES DE SOFWARE PARA LA IMPLEMENTACIÓN DE HERRAMIENTAS QUE FACILITEN LA UTILIZACIÓN DE DIAGRAMAS PARA LA PLANIFICACIÓN DE MARKETING.', '21/12/10', 3, 198, NULL, 'default', 198, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DE COMPONENTES DE SOFTWARE VISUALES QUE FACILITEN EL DESARROLLO DE LA HABILIDAD COGNITIVA DE LA CLASIFICACIÓN.', '20/07/10', 3, 199, NULL, 'default', 199, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE COMPONENTES DE SOFTWARE QUE IMPLEMENTAN ESTRATEGIAS VISUALES PARA APOYAR LA CONCEPTUALIZACIÓN DE FRACCIONES EN ALUMNOS DE CUARTO BÁSICO.', '20/08/10', 1, 200, 83, 'default', 200, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE COMPONENTES DE SOFTWARE PARA FACILITAR LA PRODUCCIÓN DE TEXTO DISCURSIVO DE ALUMNOS ENTRE 5º Y 8º AÑO DE ENSEÑANZA BÁSICA.', '08/03/10', 3, 201, NULL, 'default', 201, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE COMPONENTES VISUALES DE APOYO A COBIT.', '15/11/10', 3, 202, NULL, 'default', 202, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACIÓN WEB PARA APOYAR LA GESTIÓN DE MÁQUINAS VIRTUALES EN LA EMPRESA ADESSA LTDA.', '1/2012', 3, 227, NULL, 'default', 227, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DEL SISTEMA CAJA VECINA EN APLICACIONES TRANSACCIONALES DEL BANCO ESTADO', '12/12/12', 1, 203, 84, 'default', 203, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CREACIÓN DE UN SISTEMA GENERADOR DE DIFERENTES SERIES DE INSTRUMENTOS DE EVALUACIÓN PARA LA COORDINACIÓN DE FUNDAMENTOS DE COMPUTACIÓN Y PROGRAMACIÓN DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '1/2014', 3, 236, NULL, 'default', 236, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SOLUCIÓN BASADA EN ESB PARA MIGRAR SOTWARE LEGADO CRITICO EN EL SISTEMA PÚBLICO', '01/07/13', 1, 204, 85, 'default', 204, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE APLICACIÓN MÓVIL PARA MONITOREO, DETECCIÓN Y ALERTA AUTOMÁTICA DE CRISIS EPILÉPTICA CONVULSIVA', '5/8/2013', 3, 237, NULL, 'default', 237, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROYECTO INTRANET DE GENDARMERÍA DE CHILE', '15/01/13', 1, 205, 86, 'default', 205, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PREDICCIÓN DE ESTADIA DE PACIENTES HOSPITALIZADOS EN LA UNIDAD DE CUIDADOS INTENSIVOS ADULTOS EN UNA CLINICA PRIVADA DE SANTIAGO', '1/2014', 3, 239, NULL, 'default', 239, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IMPLEMENTACIÓN DE UN TERCER FACTOR DE AUTENTICACIÓN PARA AUTORIZACIÓN DE TRANSACCIONES EN LA BANCA INTERNET', '13/12/12', 1, 206, 87, 'default', 206, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DEL PORTAL WEB PARA LA MUNICIPALIDAD DE HIJUELAS', '13/12/12', 3, 207, NULL, 'default', 207, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA ONLINE DE ENSEÑANZA DE ESTRATEGIAS ORIENTADO A LOS PADRES PARA APOYAR LAS TAREAS ESCOLARES DE LOS HIJOS', '30/03/2012', 3, 208, NULL, 'default', 208, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE GESTIÓN PARA EL HUERTO SANTA MERCEDES', '22/05/2012', 1, 209, 88, 'default', 209, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CREACIÓN Y APLICACIÓN DE OBJETOS DE APRENDIZAJES PARA EL APOYO A PROGRAMACIÓN COMPUTACIONAL', '16/01/2013', 1, 210, 89, 'default', 210, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBTENCIÓN DE LA CARGA ANUAL EQUIVALENTE (CAE) Y CARGA ANUAL EQUIVALENTE VIGENTE (CAEV) UTILIZANDO UN MÉTODO MATEMÁTICO PARA LA EMPRESA PENTAVIDA', '19/12/2012', 3, 211, NULL, 'default', 211, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO E IMPLEMENTACIÓN DE LA ESTACIÓN DE TRABAJO EVEREST PARA EL BANCO DE CRÉDITO E INVERSIONES', '20/3/13', 3, 212, NULL, 'default', 212, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CONSTRUCCIÓN Y APLICACIÓN DE OBJETOS DE APRENDIZAJE PARA LA UNIDAD DE ANÁLISIS LÉXICO DE LA ASIGNATURA COMPILADORES', '20/03/13', 3, 213, NULL, 'default', 213, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('LABORATORIO VIRTUAL DE MATEMÁTICAS "LABMAT3EM" PARA ESTABLECIMIENTOS MUNICIPALIZADOS', '05/02/12', 1, 215, 90, 'default', 215, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('LABORATORIO VIRTUAL DE MATEMÁTICAS "LABMAT3EM" PARA ESTABLECIMIENTOS MUNICIPALIZADOS', '10/4/2011', 1, 216, 91, 'default', 216, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UN SISTEMA DE APOYO AL PROCESO DE TITULACIÓN PARA EL DEPARTAMENTO DE INGENIERÍA INFORMÁTICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '', 3, 217, NULL, 'default', 217, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('NO HAY INFORMACION', '', 3, 218, NULL, 'default', 218, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE REMUNERACIONES MODULO DE RELIQUIDACIONES', '21/12/2012', 1, 219, 92, 'default', 219, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SOLUCION INFORMATICA PARA SOLICITUDES DE INSCRIPCIONES DE ASIGNATURAS', '4/8/2010', 3, 220, NULL, 'default', 220, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE APOYO AL CONTROL DE GASTOS Y VIAJES DE VEHÍCULOS DE SERVICIOS DE TRANSPORTE DE LA EMPRESA TRASANDES S.A', '24/01/2014', 1, 221, 93, 'default', 221, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE APOYO A LA GESTON DE ADQUISICIONES DE MATERIALES DE CONSTRUCCION DE LA CONSTRUCCION KOPPMANN', '7/4/2011', 3, 222, NULL, 'default', 222, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE APOYO A LA ADMINISTRACION DEL GIMNASIO "PUNTO VITAL"', '20/09/2011', 1, 223, 94, 'default', 223, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE BUSQUEDA Y VISUALIZACIÓN DE INFORMACIÓN PARA LA BIBLIOTECA CIENTÍFICA DE CONICYT', '1/2011', NULL, 224, NULL, 'default', 224, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE GESTIÓN DE COMPRA DE VEHÍCULOS Y EQUIPAMIENTOS PARA EMPRESA SALFA RENT', '21/12/12', 3, 225, NULL, 'default', 225, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ADMINISTRACIÓN Y TRACKING DE ACTIVOSDE UNA EMPRESA DE SERVICIOS DE ARRIENDO DE CONTENEDORAS', '21/03/13', 3, 226, NULL, 'default', 226, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UN SISTEMA PARA LA GESTION DE FALLAS EN CENTRALES ELECTRICAS', '20/06/2012', 3, 228, NULL, 'default', 228, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UNA HERRAMIENTA DE APOYO A LA EVALUACIÓN DEL CONTROL INTERNO EN COOPERATIVAS DE AHORRO Y CREDITO', '21/12/12', 1, 229, 95, 'default', 229, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('AUTOMATIZACIÓN DE LA INVITACIÓN A OFERTAR EN LICITACIONES DE SAP - SRM EN CODELCO', '19/04/2013', 1, 230, 96, 'default', 230, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IMPLEMENTACIÓN DE PLATAFORMA DE ALTA DISPONIBILIDAD PARA SISTEMA WEB', '2/2012', 1, 231, 97, 'default', 231, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO UN SISTEMA DE APOYO A LA PLANIFICACION DOCENTE PARA EL DEPARTAMENTO DE INGENIERIA INFORMATICA DE LA FACULTAD DE INGENIERIA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '01/08/11', 1, 232, 98, 'default', 232, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA PARA LA ADMINISTRACIÓN DE PROVEEDORES Y PRODUCTOS DE LA MICROEMPRESA FCI LTDA.', '30/03/2011', 3, 233, NULL, 'default', 233, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA PARA LA CERTIFICACIÓN Y SUPERVISIÓN DE VENTA DE MÚSICA DIGITALIZADA', '15/01/13', 1, 234, 99, 'default', 234, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEM DE FACTURACIÓN ENTRE SOCIEDADES DE ENJOY POR CANJE DE PROMOCIONES Y PRESTACIÓN DE SERVICIOS', '', 3, 235, NULL, 'default', 235, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA ADMINISTRADOR DE ACCESOS PARA USUARIOS EN SAP', '', 3, 238, NULL, 'default', 238, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ANÁLISIS Y DESARRLLO DE UN DSS PARA LA SELECCIÓN DE PERSONAS TI', '26/05/2010', 3, 240, NULL, 'default', 240, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN SISTEMA DE SERVICIOS DE MAPAS WEB PARA VISUALIZACION Y USO DE PRODUCTOS TOPOGRAFICOS ELABORADOS POR EL SAF', '', 1, 241, 100, 'default', 241, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACIÓN DEL EFECTO DE FACTORES EXTERNOS EN LA RESOLUCIÓN DE UN PROBLEMA NP-C UTILIZANDO JUEGOS COMPUTACIONALES.', '10/07/11', 3, 242, NULL, 'default', 242, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB PARA POTENCIAR RELACION DE CLIENTES Y PROVEEDORES DE DISTRIBUIDORAS DE ABARROTES, LICORES Y CARNES', '7/4/2011', 1, 243, 101, 'default', 243, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MODELO PARA LA ESTIMACIÓN DE LA VARIABILIDAD DE LOS COSTOS EN LA FORMULACIÓN DE PROYECTOS DE TECNOLO GÍAS DE LA INFORMACIÓN.', '26/07/10', 1, 244, 102, 'default', 244, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROTOTIPO DE SOFTWARE Y ESTUDIO DE MERCADO DE UNA PLATAFORMA SOCIAL DE APRENDIZAJE.', '27/09/2010', 3, 245, NULL, 'default', 245, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA PARA EL SEGUIMIENTO Y CONTROL DE LA OPERATIVIDAD DE SERVIDORES DEL AREA TIC DE CARABINEROS DE CHILE', '4/8/2010', 1, 248, 103, 'default', 248, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DATAMART PARA UN SISTEMA DE REPORTES DE TIEMPOS EN LÍNEA DE ENLACES DE TELECOMUNICACIONES', '12/8/2013', 3, 254, NULL, 'default', 254, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE REALIDAD AUMENTADA PARA LA DIFUSIÓN DE INFORMACIÓN DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '21/03/2013', 1, 249, 104, 'default', 249, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROTOTIPO PARA LA DETECCIÓN DE MALWARE EN EL SISTEMA OPERATIVO', '11/01/13', 1, 251, 105, 'default', 251, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROTOTIPO DE APLICACIÓN MÓVIL PARA LA DETECCIÓN DE MALWARE EN DISPOSITIVOS CON SISTEMA OPERATIVO ANDROID', '1/2014', 3, 262, NULL, 'default', 262, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DE SISTEMA DE INFORMACIÓN DE APOYO DE GESTIÓN DE INVENTARIO DE LA EMPRESA COMERCIAL E INDUSTRIAL BERMUDAS S.A.', '30/03/2012', 1, 252, 106, 'default', 252, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROPUESTA DE MÉTODO ÁGIL DE DESARROLLO DE SOFTWARE FUNCIONAL, USABLE Y SEGURO.', '22/01/2015', 3, 264, NULL, 'default', 264, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WED PARA SUBASTAR VIDEOS DE CAZANOTICIAS ENTRE CANALES DE TELEVISIÓN', '11/10/12', 1, 253, 107, 'default', 253, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROTOTIPO DE SISTEMA DE DETECCIÓN DE MALWARE PARA DISPOSITIVOS ANDROID', '2/2013', 3, 266, NULL, 'default', 266, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UN PROTOTIPO DE SOFWARE DE APOYO PARA EL TEST DE CAFRA.', '21/12/10', 1, 255, 108, 'default', 255, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE FACTURACIÓN ELECTRÓNICA, INVENTARIO Y PRESUPUESTOS WEB PARA TALLER DE TORNERÍA TRIFLEX', '30/03/2012', 3, 256, NULL, 'default', 256, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN PLAN DE CONTINGENCIA Y RECUPERACIÓN ANTE DESASTRES PARA EL ÁREA INFORMÁTICA DE LA EMPRESA ARCADIS CHILE', '', 3, 267, NULL, 'default', 267, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMAS PARA LA DETECCIÓN PREVENTIVA DE BAJOS RENDIMIENTOS ACADÉMICOS DE ALUMNOS DEL MÓDULO BÁSICO DE LA FACULTAD DE INGENIERÍA', '10/02/12', 1, 257, 109, 'default', 257, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE APOYO A LA GESTIÓN DE UNA ORGANIZACIÓN COMUNITARIA', '', 7, 258, NULL, 'default', 258, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROPUESTA DE MÉTODO ÁGIL DE DESARROLLO DE SOFTWARE FUNCIONAL, USABLE Y SEGURO', '', NULL, 259, NULL, 'default', 259, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROTOTIPO DE SISTEMA WEB PARA LA GESTIÓN Y CONSOLIDACIÓN DE INFORMACIÓN ADMINISTRATIVA COMO APOYO AL PROCESO DE ACREDITACIÓN DE LOS PROGRAMAS DEL DEPARTAMENTO DE INGENIERÍA INFORMÁTICA', '2/2013', 3, 270, NULL, 'default', 270, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROTOTIPO DE SISTEMA DE DETECCIÓN DE INTRUSOS BASADO EN HOST PARA ANDROID', '11/01/13', 1, 260, 110, 'default', 260, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE GESTIÓN DE LA SEGURIDAD DE LA INFORMACIÓN PARA EL DIINF', '2/2014', 3, 271, NULL, 'default', 271, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE INFORMACIÓN Y AUTOMATIZACIÓN WEB PARA GESTIÓN Y ADMINISTRACIÓN DE SERVICIOS Y RECURSOS DEL COMPLEJO TURÍSTICO ATALAYA LANALHUE.', '30/03/2012', 1, 261, 111, 'default', 261, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN ASISTENTE PARA EL SOFTWARE GREI QUE PERMITA GUIAR A LOS DOCENTES EN LA CREACIÓN DE SECUENCIAS INTERACTIVAS DE APRENDIZAJE RESGUARDANDO CRITERIOS DIDÁCTICOS-MATEMÁTICOS', '24/06/2014', 3, 272, NULL, 'default', 272, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE ACTAS DE SESIONES DE CONSEJO Y AGENDA DEPARTAMENTAL.', '19/07/2011', 1, 263, 112, 'default', 263, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACIÓN ANDROID UTILIZANDO REALIDAD AUMENTADA PARA LA UBICACIÓN ESPACIAL DE SITIOS DE INTERÉS', '2/2013', 3, 265, NULL, 'default', 265, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE APOYO A LA ADMINISTRACIÓN DEL CONTROL DE CAMBIOS EN SERVIDORES DELA PLATAFORMA WINTEL DE HP', '29/07/2013', 3, 283, NULL, 'default', 283, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACION DE UNA PLATAFORMA VIRTUALIZADA DE SERVICIOS INTEGRADOS PARA EL DEPARTAMENTO DE INGENIERIA EN INFORMATICA', '', 1, 268, 113, 'default', 268, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACION DE APOYO AL DEPARTAMENTO DE RECURSOS HUMANOS PARA "AMEC ING Y CONSTRUCCIÓN LTDA"', '2/2012', 3, 286, NULL, 'default', 286, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE GESTIÓN ADMINISTRATIVA DE ALUMNOS PARA EL COLEGIO PUKARAY.', '30/03/2012', 1, 269, 114, 'default', 269, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CURSE DE CREDITOS HIPOTECARIO EN WORKFLOW', '12/12/12', 3, 273, NULL, 'default', 273, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UNA HERRAMIENTA DE SOFTWARE BASADA EN UN MARCO DE TRABAJO PARA LA GUÍA DE GESTIÓN DE PROYECTOS TI PARA PUMES', '09/04/12', 3, 274, NULL, 'default', 274, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('METODOLOGIA DE TRABAJO PARA LA GESTION DE PROYECTOS TI EN PYMES', '', 3, 275, NULL, 'default', 275, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MODELACIÓN LINE-PACK DE LA OPERACIÓN DEL GASODUCTO GAS ATACAMA MEDIANTE REDES NEURONALES ARTIFICIALES ', '29/07/2013', 3, 288, NULL, 'default', 288, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('TESTING DE CORE BUSINESS PARA UNA EMPRESA DE TELECOMUNICACIONES', '21/03/2013', 1, 276, 115, 'default', 276, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA INTEGRADO DE REMUNERACIONES Y DECLARACIÓN JURADA ANUAL DE RENTAS', '1/2014', 3, 289, NULL, 'default', 289, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO  E IMPLEMENTACIÓN DE UN DATAMART PARA EL APOYO A LAS VENTAS DEL GRUPO SIG', '24/07/2012', 1, 277, 116, 'default', 277, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO E IMPLEMENTACIÓN DE DATAMART PARA LA GERENCIA COMERCIAL DE UNA ASOCIACIÓN GENERAL DE FONDOS', '6/11/2014', 3, 291, NULL, 'default', 291, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE APOYO AL CONTROL ACADÉMICO PARA LA ACADEMIA POLITÉCNICA AERONÁUTICA DE FUERZA AÉREA DE CHILE', '21/08/2012', 1, 278, 117, 'default', 278, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE APOYO A LA GESTIÓN DE FRANQUICIAS MÉDICAS-DENTALES PARA ALUMNOS DE LA UNIVERSIDAD DE CHILE', '1/2014', 3, 293, NULL, 'default', 293, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA VACACIONES PROGRESIVAS Y GENERACIÓN DE ALARMAS PARA LA EMPRESA CYSS', '19/07/2012', 1, 279, 118, 'default', 279, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CLASIFICACION DEL GRUPO SOCIO ECOOMICO UTILIZANDO VARIABLES DE CONSUME DE PRODUCTOS DE SUPERMERCADO', '3/4/2013', 3, 352, NULL, 'default', 352, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN DATAWAREHOUSE Y DE REPORTES DE APOYO PARA EL ÁREA GLOBAL BPO DE UN CLIENTE DE LA EMPRESA METRIC ARTS', '1/8/2013', 1, 280, 119, 'default', 280, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE INFORMACION WEB PARA EL CONTROL DE ORDENES DE TRABAJO EN IMPRENTA COLORAMA S.A', '11/10/2012', 1, 281, 120, 'default', 281, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE CONTROL Y SOPORTE DE INFORMACIÓN AL SERVICIO TÉCNICO DE LA EMPRESA PROYEXION SERVICIOS S.A.', '2/2013', 7, 282, NULL, 'default', 282, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB PARA PUBLICACION Y AYUDA A LA COMPRA-VENTA DE AUTOS DE EL PORTAL DEL AUTO', '4/4/2011', 3, 284, NULL, 'default', 284, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE APOYO A LA LABOR COMERCIAL DE UNA EMPRESA DISTRIBUIDORA DE GAS LICUADO', '7/4/2011', 3, 285, NULL, 'default', 285, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE APOYO A LA ATENCIÓN DE CLIENTES', '20/03/13', 3, 287, NULL, 'default', 287, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO UN SISTEMA WEB DE APOYO A LA ADMINISTRACION DE PROYECTOS DE INGENIERIA EN LA EMPRESA L&C', '', 3, 290, NULL, 'default', 290, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA MONITOR DE DISPOSITIVOS ELECTRÓNICOS EN UNA PLANTA TRASMISORA DE FRECUENCIA MODULADA', '30/03/2013', 1, 292, 121, 'default', 292, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE APOYO A LA GESTION DE MONITOREO Y SEGUIMIENTO DEL TRABAJO EN EL AUTO', '7/4/2011', 3, 294, NULL, 'default', 294, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('NO HAY INFORMACION', '', 3, 295, NULL, 'default', 295, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE APOYO A LA GESTION DE BODEGA PARA LA EMPRESA MC2', '15/12/11', 3, 296, NULL, 'default', 296, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE EVALUACIÓN DE DESEMPEÑO PARA EL PERSONAL DE OFICIALES DE LA FUERZA AÉREA DE CHILE', '', 1, 297, 122, 'default', 297, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UN AG COOPERATIVO PARA PROBLEMAS DE CORTE Y EMPAQUE', '25/06/12', 3, 548, NULL, 'default', 548, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE APOYO A LA GESTION DEL AREA DE SOPORTE COMPUTACIONAL PARA LA EMPRESA MARCARIA.COM', '7/4/2011', 1, 298, 123, 'default', 298, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLAR UN SISTEMA DE APOYO A LA GESTION DE FICHAS,HORAS Y MEDICAMENTOS PARA LA POSTA RURAL DE PENCAHUE BAJO', '15/12/11', 3, 301, NULL, 'default', 301, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DEL SISTEMA SAP SRM PARA LA EMPRESA MULTINACIONAL ALFA', '19/3/13', 4, 303, NULL, 'default', 303, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE GENERACION Y SEGUIMIENTO DE REQUERIMIENTOS DE SOPORTE PARA SISTEMAS LTDA.', '7/4/2011', 3, 305, NULL, 'default', 305, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE INFORMACION DE APOYO A LOS PROCESOS DE VENTA E INVENTARIO PARA LA EMPRESA RODAMIENTO "VILLELA"', '9/3/2010', 3, 306, NULL, 'default', 306, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('AUTOMATIZACIÓN DEL PROYECTO DE FORMALIZACIÓN DE SUBSIDIOS DE CORFO', '15/04/2013', 3, 309, NULL, 'default', 309, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('RESOLUCIÓN DE KO THREATS UTILIZANDO HEURÍSTICAS EN MONTE CARLO GO.', '12/6/2010', 1, 311, 124, 'default', 311, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('USO DE GPU EN ALGORITMOS DE BUSQUEDA LOCAL PARA EL PROBLEMA DE LA ASIGNACION CUADRATICA', '05/10/11', 3, 312, NULL, 'default', 312, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ACERELERACION DE DESEMPEÑO DEL ALGORITMO DE BUSQUEDA LOCAL PARA FLOW SHOP USANDO PROCESADORES GRAFICOS', '10/7/2011', 3, 313, NULL, 'default', 313, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CONSTRUCCIÓN DE UN FRAMEWORK PARA PIPELINE DE APLICACIONES DE BIOINFORMÁTICA', '2/2013', 3, 316, NULL, 'default', 316, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO Y DESARROLLO DE UN ALGORITMOS DE BÚSQUEDA DE ARN OBJETIVOS PARA UN MICROARN', '12/7/2012', 3, 317, NULL, 'default', 317, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE EVALUCIÓN FORMATIVA EN LINEA PARA LA SOCIEDAD CHILENA DE RADIOLOGIA', '04/08/10', 3, 318, NULL, 'default', 318, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE DENUNCIA CIUDADANA PARA LA ILUSTRE MUNICIPALIDAD DE SAN JOAQUIN', '20/09/2011', 1, 409, 173, 'default', 409, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ALGORITMO PARA LA VISUALIZACIÓN DE DATOS EXPERIMENTOS DE MIROARRAYS BASADOS EN ANOTACIONES BIOLÓGICAS Y EXPRESIÓN GENÉTICA', '11/10/1012', 1, 319, 125, 'default', 319, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GRAFO DE CONSENSO DE FUENTES DE ANOTACIONES BIOLÓGICAS DE GENES HUMANOS ', '2/2013', 3, 320, NULL, 'default', 320, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UNA APLICACIÓN WEB PARA EL APOYO AL ANÁLISIS DE DATOS RT-PCR.', '10/4/2011', 1, 321, 126, 'default', 321, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('INCORPORACIÓN DE ANOTACIONES GENÉTICAS EN EL ALGORITMO DE AGRUPAMIENTO MST -KNN', '11/10/1012', 1, 322, 127, 'default', 322, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('REINGENIERIA PORTAL DE PAGOS DEL ESTADO PARA TESORERÍA GENERAL DELA REPÚBLICA', '23/07/2013', 1, 323, 128, 'default', 323, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ANÁLISIS DE TÉCNICAS PARA FILTRADO DE NOTICIAS DE LA WEB', '1/2012', 1, 324, 129, 'default', 324, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CLASIFICACIÓN AUTOMÁTICA DE TEXTOS PERIODÍSTICOS ENRIQUECIDA CON FUENTES EXTERNAS', '20/03/2012', 3, 325, NULL, 'default', 325, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE SEGUIMIENTO DE JUICIOS PARA GESTIÓN DE COBRANZA', '', 3, 326, NULL, 'default', 326, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACIÓN DE ALGORITMOS PARA LA IDENTIFICACIÓN DE ESTRUCTURA DE SITIOS WEB CON APLICACIONES EN RECOLECTORES FOCALIZADOS DE LA WEB.', '03/10/11', 3, 327, NULL, 'default', 327, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MÓDULOS DEL SISTEMA INFORMÁTICO PARA APOYAR LA GESTIÓN EN UNA EMPRESA DE RETAIL', '', 1, 329, 130, 'default', 329, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UNA API PARA LA ASOCIACIÓN DE PERSONAS Y EL CONTENIDO DE NOTICIAS EN ESPACIOS.', '', 1, 330, 131, 'default', 330, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACIÓN DE REPORTES CON EL CONTEXTO DE NOTICIAS EN TWITTER.', '05/10/11', 1, 331, 132, 'default', 331, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE COORDINACION Y GESTION DE RESERVA HORARIA PARA EVENTOS Y ACTIVIDADES DEL COLEGIO ALEMAN DE SANTIAGO', '20/09/2011', 3, 4, NULL, 'default', 4, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ANÁLISIS DE SENTIMIENTO EN EL SISTEMA DE RED SOCIAL TWITTER', '03/10/11', 1, 332, 133, 'default', 332, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLAR UN JUEGO COMO HERRAMIENTA DE APRENDIZAJE PARA EL CURSO DE ECONOMÍA DE LA FACULTAD TECNOLÓGICA    ', '208/11/2014', 3, 300, NULL, 'default', 300, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑOS DE UN CLASIFICADOR DE PATENTES INDUSTRIALES', '11/10/12', 1, 333, 134, 'default', 333, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE APOYO AL PRCOESO DE EVALUACIÓN ECONÓMICA SOCIAL DE PROYECTOS DE VIALIDAD URBANA', '2/2012', 3, 302, NULL, 'default', 302, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('API PARA LA VISUALIZACIÓN DE RELACIONES EXISTENTES ENTRE CONTACTOS PERSONALES A TRAVÉS DE REDES SOCIALES.', '07/10/11', 1, 334, 135, 'default', 334, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE APOYO A LA GESTIÓN DE UN CENTRO DE DISTRIBUCIÓN', '1/2014', 3, 304, NULL, 'default', 304, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN SISTEMA DE GESTION HORARIA PARA RECURSOS DE UNA EMPRESA DE DEPILACION LASER', '11/10/12', 1, 335, 136, 'default', 335, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO DE UN ALGORITMO DE PLANIFICACIÓN PARA APLICACIONES PARALELAS SOBRE RECURSOS HETEROGÉNEOS EN CLOUD COMPUTING', '3/7/2012', 3, 336, NULL, 'default', 336, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PLATAFORMA DE EVALUACIÓN DE ALGORITMOS DE SUBASTA PARA BUSQUEDAS PATROCINADAS', '11/10/12', 3, 337, NULL, 'default', 337, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ANÁLISIS DE LA SATISFACCIÓN DE CLIENTES MEDIANTE EL ANÁLISIS DE CORREOS ELECTRÓNICOS', '11/01/13', 3, 338, NULL, 'default', 338, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('INTEGRACIÓN ERP MICROSOFT DYNAMICS AX CON SISTEMA WEB EXTERNO PARA EL INGRESO DE PEDIDOS DE VENTA', '', 3, 339, NULL, 'default', 339, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('REDISEÑO DEL PROCESO DE NEGOCIO ASOCIADO AL SERVICIO DE ARRIENDO DE GRÚAS HORQUILLA, PARA LA EMPRESA GRÚAS M&L LTDA.', '03/04/15', 3, 307, NULL, 'default', 307, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DETERMINACIÓN DE LA INFLUENCIA DE ESTÍMULOS SONOROSY SU EMOCIÓN EN LA AUTORREGULACIÓN.', '11/10/12', 1, 341, 137, 'default', 341, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLAR UN JUEGO COMO HERRAMIENTA DE APRENDIZAJE PARA EL CURSO DE ECONOMÍA DE LA FACULTAD TECNOLÓGICA    ', '5/11/2014', 3, 308, NULL, 'default', 308, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DETERMINACIÓN DE LA INFLUENCIA DE ESTÍMULOS MUSICALES EN LA AUTORREGULACIÓN DEL FLUJO SANGUÍNEO CEREBRAL.', '18/01/2012', 1, 342, 138, 'default', 342, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IMPLEMENTACIÓN DEL PROCESO DE FORMALIZACIÓN DE SUBSIDIOS DE CORFO EN ADOBE LIVE CYCL', '25/11/2014', 3, 310, NULL, 'default', 310, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PRE-PROCESAMIENTO DE SEÑALES DE HEMODINÁMICA CEREBRAL PARA ESTUDIOS DE AUTTOREGULACION DEL FLUJO SANGUINEO CEREBRAL', '7/4/2011', 1, 343, 139, 'default', 343, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ALGORITMO DE AGRUPAMIENTO PARA DATOS DE EXPRESIÓN GÉNICA DE RNA-SEQ CON LA INCORPORACIÓN DE ANOTACIONES BIOLÓGICAS', '1/2014', 3, 314, NULL, 'default', 314, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA DE CONTRASTE DE HIPÓTESIS BASADO EN BOOTSTRAP', '30/03/2012', 1, 344, 140, 'default', 344, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ANÁLISIS DE LA COMPLEJIDAD DE LAS SEÑALES DEL SISTEMA DE HEMODINÁMICA CEREBRAL Y LA RELACIÓN DE ESTA CARACTERÍSTICA CON SU MODELAMIENTO', '', 3, 345, NULL, 'default', 345, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ALGORITMO MEMÉTICO BASADO EN CONOCIMIENTO BIOLÓGICO PARA EL PROBLEMA DE PREDICCIÓN DE LA ESTRUCTURA TRIDIMENSIONAL DE LA PROTEÍNA', '1/2014', 3, 315, NULL, 'default', 315, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ANALISIS COMPARATIVO ENTRE METODOS PARA EL CALCULO DE LA AUTORREGULACION CEREBRAL QUE USAN CAMBIOS BRUSCOS DE PRESION Y VARIACIONES ESPONTANEAS UTILIZANDO SVM', '', 1, 346, 141, 'default', 346, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ACTUALIZACIÓN CONCURRENTE DE ÍNDICES INVERTIDOS EN MOTORES DE BÚSQUEDA VERTICALES', '2/2014', 3, 340, NULL, 'default', 340, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('COMPARACIÓN DE LOS MÉTODOS DE CÁLCULO DE AUTOREGULACIÓN USANDO MODELOS LINEALES CON LA MANIOBRA DE VALSALVA Y VARIACIONES ESPONTANEAS DE PRESIÓN', '1/2014', 3, 347, NULL, 'default', 347, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MODIFICACION DE LOS METODOS DE DETECCION DE LATIDOS CARDIACOS PARA SER UTILIZADOS EN LA ESTIMACION DE SEÑALES DE PSAM Y FSCM', '30/05/11', 1, 348, 142, 'default', 348, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('COMPARACIÓN DE LOS MÉTODOS DE CÁLCULO DE AUTORREGULACIÓN CON LA MANIOBRA "SIT-TO-STAND" Y VARIACIONES ESPONTÁNEAS DE PRESIÓN', '2/2013', 3, 354, NULL, 'default', 354, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SOLUCIÓN DE INTELIGENCIA DE NEGOCIOS Y MODELO PREDICTIVO COMO APOYO A LA GESTIÓN DE INDICADORES CLÍNICOS EN CLÍNICA ALEMANA DE SANTIAGO', '', 1, 349, 143, 'default', 349, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SELECCIÓN DE CARACTERÍSTICAS PARA LA ESTIMACIÓN DE NIVELES DE PRESIÓN INTRACRANEAL EN FORMA NO INVASIVA.', '20/09/11', 3, 350, NULL, 'default', 350, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO DE UN CLASIFICADOR PARA LA DETECCIÓN DEL MOBILOMA EN GENOMAS DE BACTERIAS', '04/06/14', 3, 357, NULL, 'default', 357, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CREACIÓN DE MODELOS DE CLASIFICACIÓN PARA CULTIVOS NEURONALES CON CLASES DESBALANCEADAS Y BÚSQUEDA DE VARIABLES REPRESENTATIVAS', '3/6/2014', 1, 351, 144, 'default', 351, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS POLARES ', '1/2014', 3, 368, NULL, 'default', 368, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MEJORAMIENTO DEL ÍNDICE DE AUTORREGULACIÓN DE FLUJO SANGUÍNEO CEREBRAL (ARI) MEDIANTE LA MEDICIÓN DE FASE ENTRE PRESIÓN Y FLUJO.', '13/09/11', 1, 353, 145, 'default', 353, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DE UNA HERRAMIENTA PARA LA CATEGOGORIZACIÓN DE PACIENTES EN SERVICIOS DE URGENCIA ', '', 3, 355, NULL, 'default', 355, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IDENTIFICACIÓN DE EVENTOS DE TRANSFERENCIA HORIZONTAL DE GENES EN BACTERIAS MEDIANTE DISEÑO DE CLASIFICADORES DE DATOS', '03/11/13', 3, 356, NULL, 'default', 356, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS OCTOPUS', '1/2014', 3, 370, NULL, 'default', 370, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACIÓN COMPARATIVA DE MÑETODOS DE MINERÍA DE DATOS PARA LA CLASIFICACIÓN DE SEÑALES SÍSMICAS DEL VOLCÁN LLAIMA', '03/11/13', 1, 358, 146, 'default', 358, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OPTIMIZACIÓN Y MEJORAS A PROCESOS EJECUTADOS PARA LA OBTENCIÓN DE LOS ESTADOS DE RESULTADOS COMERCIALES DE LAN CHILE', '', 3, 359, NULL, 'default', 359, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFO GOOD', '1/2014', 3, 371, NULL, 'default', 371, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('USO DE TÉCNICAS DE CAJA GRIS Y FUNCIÓN DE TRANSFERENCIA PARA MODELAR LA AUTORREGULACIÓN CEREBRAL', '30/03/2012', 1, 360, 147, 'default', 360, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA PARA CONTROL DE ENVÍO Y RECEPCIÓN DE MENSAJERÍA DE TEXTO EN EQUIPOS DE TELEFONÍA MÓVIL', '13/12/12', 3, 361, NULL, 'default', 361, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS LOBSTER', '', 3, 388, NULL, 'default', 388, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('COMPARACIÓN DE ÍNDICES DE AUTORREGULACIÓN DE FLUJO SANGUÍNEO CEREBRAL BASADOS SOLO EN SEÑAL DE FLUJO', '03/11/13', 1, 362, 148, 'default', 362, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('COMPARACION ENTRE MODELOS NARX DE SVM Y TLRNN PARA OBTENER INDICE AUTORREGULATORIO CEREBRAL EN VARIACIONES ESPONTANEAS', '', 3, 363, NULL, 'default', 363, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACIÓN DE MÉTODOS QUE MEJORAN LA IDENTIFICACIÓN DE BIOMARCADORES A PARTIR DE DATOS DE EXPRESIÓN GÉNETICA EN EL SALMÓN ATLÁNTICO (SALMO SALAR)', '03/11/13', 3, 364, NULL, 'default', 364, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACIÓN DE OBJETOS DE APRENDIZAJE MOODLE, MEDIANTE LA SUPERVISIÓN DE USO DE LOS ESTUDIANTES', '2/2014', 3, 393, NULL, 'default', 393, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACIÓN DE LOS EFECTOS DE LA POSICIÓN CORPORAL EN EL CÁLCULO DE LOS ÍNDICES DE AUTORREGULACIÓN DEL FLUJO SANGUÍNEO CEREBRAL USANDO MODELOS LINEALES', '03/11/13', 1, 365, 149, 'default', 365, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACIÓN DEL CRÉDITO TRIBUTARIO PARA LA INSTALACIÓN DE UN SISTEMA SOLAR TÉRMICO Y SU IMPACTO EN EL SISTEMA INFORMÁTICO TRIBUTARIO CHILENO ADMINISTRADO POR EL S.I.I.', '18/12/12', 1, 366, 150, 'default', 366, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CONSTRUCCIÓN DE MODELOS PARA EVALUAR LA AUTORREGULACIÓN DE PACIENTES CON TEC USANDO MODELOS NARMAX Y FIR CON SVM.', '11/10/12', 1, 367, 151, 'default', 367, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IMPLEMENTACIÓN DE ALGORITMOS DE LAYOUT DE GRAFOS Y ANÁLISIS DE SU COMPORTAMIENTO AL GENERAR SOLUCIONES INÍCIALES PARA EL ALGORITMO QAPGRID.', '6/12/2010', 1, 369, 152, 'default', 369, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA POYAR LA COMPRENSIÓN Y APLICACIÓN DE CONCEPTOS BÁSICOS DE INTRODUCCIÓN A LAS BASES DE DATOS', '11/01/13', 1, 372, 153, 'default', 372, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE GESTIÓN ESCOLAR PARA LA EMPRESA DE CLASES PARTICULARES "PLAY HOUSE TEACHER"', '2/2011', 1, 373, 154, 'default', 373, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACION VIRTUAL DE NANOTUBOS DE CARBONO DE UNA PARED FUNCIONALIZADOS CON DISTINTAS MOLECULAS', '03/05/13', 1, 374, 155, 'default', 374, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA DE PREDICCIÓN PARA LA CANTIDAD DE ALUMNOS EN LAS ASIGNATURAS DEL DEPARTAMENTO DE INGENIERIA INFORMATICA', '11/10/12', 3, 375, NULL, 'default', 375, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE ALGORITMOS DE PLANIFICACIÓN DE PROCESOS EN CPU EN EL CURSO DE SISTEMAS OPERATIVOS', '11/01/13', 1, 376, 156, 'default', 376, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA PARA LA CREACION,GESTION Y DIFUSION DE BANDAS MUSICALES', '02/11/11', 1, 377, 157, 'default', 377, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('REINGENIERÍA DE PROCESOS DE DOCENCIA  DEL DEPARTAMENTE DE INGENIERÍA INFORMÁTICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '11/10//2012', 1, 378, 158, 'default', 378, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE CONTABILIDAD PARA ALUMNOS DEL INSTITUTO PROFESIONAL LA ARAUCANA', '', 1, 379, 159, 'default', 379, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL MODELAMIENTO MATEMÁTICO DE PROBLEMAS DE OPTIMIZACIÓN', '11/01/13', 1, 380, 160, 'default', 380, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS "K-TREE"', '', NULL, 381, NULL, 'default', 381, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS "K-TREE"', '05/10/11', 3, 382, NULL, 'default', 382, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACIÓN DE APOYO A LA ENSEÑANZA - APRENDIZAJE PARA EL MANEJO DE LENJUAGE DE MATRICES EN OCTAVE EN EL CURSO DE FUNDAMENTOS DE PROGRAMACIÓN', '11/01/13', 1, 383, 161, 'default', 383, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DETECCIÓN PREVENTIVA DE ALUMNOS CON BAJO RENDIMIENTO ACADÉMICO EN LA FACULTAD DE INGENIERÍA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', ' 1º 2012', 1, 384, 162, 'default', 384, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR LA APREHESIÓN DE LOS CONCEPTOS DE PROCESOS Y HEBRAS', '11/01/13', 1, 385, 163, 'default', 385, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN MÓDULO DE EXTENSIÓN PARA DETERMINAR RUTAS DE TRANSPORTES DE CARGA POR EL MEDIO VIAL, FERROVIARIO O MARÍTIMO EN EL ENTORNO ARCMAP', '23/04/12', 1, 386, 164, 'default', 386, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACIÓN WEB DE APOYO PARA LA GESTIÓN DE PROCESO DE POSTULACIONES  ACADÉMICAS EN EL DEPARTAMENTO DE INGENIERÍA INFORMÁTICA DE LA UNIIVERSIDAD DE SANTIAGO DE CHILE', '11/10/12', 1, 387, 165, 'default', 387, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETIVOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN DE CONCURRENCIA COMPUTACIONAL', '11/01/13', 1, 389, 166, 'default', 389, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN GRAFOS BISPLIT.', '05/10/11', 1, 390, 167, 'default', 390, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETO DE APRENDIZAJE PARA LA EJERCITACIÓN DE LOS CONCEPTOS DEL MÉTODO SIMPLEX', '11/01/13', 3, 391, NULL, 'default', 391, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DIAGNOSTICO DE INGRESO DE ALUMNOS A LA CARRERA DE INGENIERÍA DE EJECUCIÓN EN COMPUTACIÓN E INFORMÁTICA MODALIDAD VESPERTINA', '', 3, 392, NULL, 'default', 392, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('INTELIGENCIA DE NEGOCIOS APLICADA A CAJA DE COMPENSACIÓN', '19/07/2012', 3, 399, NULL, 'default', 399, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE APOYO A LA ADMINISTRACIÓN DE INFORMACIÓN PARA LOS COMITÉS DE AGUA POTABLE RURALES', '04/07/12', 3, 400, NULL, 'default', 400, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN SISTEMA PERSONALIZABLE PARA QUE PROFESORES TRABAJEN LA INCLUSIÓN DE ALUMNOS CON NECESIDADES ESPECIALES TRANSITORIAS', '1/2014', 3, 50, NULL, 'default', 50, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UNA APLICACIÓN DE MONITOREO SPLUNK PARA AGUILIZAR EL PROCESO ITIL DE GESTIÓN DE INCIDENTES EN BANCO ESTADO', '20/01/2014', 1, 401, 168, 'default', 401, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE APOYO A LA FORMULACIÓN DE PROYECTOS CONCURSABLES DEL DEPARTAMENTO DE INGENIERÍA INFORMÁTICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '2/2014', 3, 395, NULL, 'default', 395, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE GESTIÓN Y CONTROL PARA EMPRESA "PG&I"', '7/5/2012', 1, 402, 169, 'default', 402, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ALGORITMOS PARALELOS PARA LA GENERACIÓN DE LOS CONJUNTOS INDEPENDIENTES MAXIMALES DE UN GRAFO CAMINO SIN CUERDAS Y DE UN GRAFO CATERPILLAR', '2/2014', 3, 396, NULL, 'default', 396, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('BUSINESS INTELLIGENCE PARA EL ÁREA DE CONTROL DE GESTIÓN EN LA SUPERINTENDENCIA DE ELECTRICIDAD Y COMBUSTIBLES', '21/12/12', 1, 403, 170, 'default', 403, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MODELADO DE LAS CARACTERÍSTICAS DE LOS POSTULANTES A LA CARRERA DE INGENIERÍA DE EJECUCIÓN EN COMPUTACIÓN E INFORMÁTICA MODALIDAD VESPERTINA', '2/2014', 3, 397, NULL, 'default', 397, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MONITOREO Y MANEJO DE REDES INALÁMBRICAS EN MINAS A RAJO ABIERTO', '13/12/12', 1, 404, 171, 'default', 404, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CUBO OLAP PARA ANÁLISIS DE VENTAS', 'REFORMULAR', 3, 405, NULL, 'default', 405, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ENUMERACIÓN DE CONJUNTOS INDEPENDIENTES MAXIMALES EN FRAFOS OCTOPUS', '2/2014', 3, 398, NULL, 'default', 398, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ESTUDIO DE FACTIBILIDAD PARA LA IMPLEMENTACION DE APLICACIONES DISTRIBUIDAS SOBRE SET-TOP-BOXES EN CHILE', '', 1, 406, 172, 'default', 406, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IMPLEMENTACION DE PROCESOS DE GESTION DE PROYECTOS FOSIS UTILIZANDO HERRAMIENTAS BPMS', '4/8/2010', 3, 408, NULL, 'default', 408, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('BIBLIOTECA PARA EL DESPEGUE ÁGIL DE APLICACIONES DE STREAM EN ESCENARIOS DE DESASTRES', '1/2014', 3, 407, NULL, 'default', 407, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE RECOLECCIÓN DE LECHE FRESCA PARA LAS PLANTAS NESTLÉ CHILE S.A.', '15/05/2013', 3, 410, NULL, 'default', 410, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PLAN DE CONTINUIDAD DE NEGOCIOS PARA EL MACRO PROCESO GESTIÓN FINANCIERA Y OTROS ACTIVOS DEL TESORO PÚBLICO', '8/1/2014', 3, 421, NULL, 'default', 421, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROTOTIPO DE SISTEMA DE GESTIÓN DOCUMENTAL PARA LA DIRECCIÓN DE ASISTENCIA JURÍDICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', 'APROBADO', 1, 411, 174, 'default', 411, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('REDISEÑO DE PROCESOS: IMPLEMENTACION DE SISTEA RIS/PACS EN UNIDAD DE IMAGENOLOGIA, HOSPITAL SAN JUAN DE DIOS', '4/8/2010', 3, 412, NULL, 'default', 412, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE INFORMACIÓN WEB, PARA LA "CLÍNICA DENTAL - ALEXANDRA ALVAREZ"', '2/2011', 3, 427, NULL, 'default', 427, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE CONTROL Y MONITOREO A LAS TRANSACCIONES DE UN CONJUNTO DE BASES DE DATOS SQL SERVER', '20/09/2011', 1, 413, 175, 'default', 413, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DATAMART PARA EL ÁREA DE APROVISIONAMIENTO DE ENDESA COLOMBIA', '', 3, 414, NULL, 'default', 414, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PLATAFORMA PARA LA DEFINICIÓN Y APOYO A LA EVALUACIÓN DE GESTOS TÁCTILES EN LA INTERACCIÓN CON OBJETOS DIGITALES DE INFORMACIÓN', '1/2014', 3, 431, NULL, 'default', 431, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN CUADRO DE MANDO INTEGRAL', '4/8/2010', 1, 415, 176, 'default', 415, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IDENTIFICACIÓN AUTOMATIZADA DE ETAPAS DEL PROCESO DE BÚSQUEDA DE INFORMACIÓN DEL USUARIO ', '1/2014', 3, 432, NULL, 'default', 432, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE CONTROL DE PROCESOS Y GESTION PARA EL AREA DE SOPORTE INFORMATICO PARA BROWSE INGENIERIA', '4/8/2010', 1, 416, 177, 'default', 416, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROCESO DE DESARROLLO DE PROYECTOS DE SEGURIDAD PARA SAP ERP EN ROLES Y PERFILES', '4/8/2010', 3, 417, NULL, 'default', 417, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISATEMA DE INVENTARIO WEB PARA APOYAR LA GESTIÓN DE LA EMPRESA VTV LTDA.', '26-07-2012', 3, 418, NULL, 'default', 418, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE ASIGNACIÓN DE LABORATORIOS DE DOCENCIA', '4/8/2010', 3, 419, NULL, 'default', 419, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO Y DESARROLLO DE UNA APLICACIÓN MODULAR PARA APOYAR LA INVESTIGACIÓN OBSERVACIONAL CON DATOS MULTIMODALES ', '1/2014', 3, 433, NULL, 'default', 433, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE LICENCIAS MEDICAS EN UNA CAJA DE COMPENSACION', '4/8/2010', 1, 420, 178, 'default', 420, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DETECCIÓN IMPLÍCITA DE RELEVANCIA DE PÁGINAS WEB UTILIZANDO REGISTROS DE ACTIVIDAD DEL USUARIO EN LA BÚSQUEDA DE INFORMACIÓN', '1/2014', 3, 434, NULL, 'default', 434, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE CONTROL DE PERMISOS Y AUSENCIAS DE FUNCIONARIOS DEL 3º JUZGADO DE FAMILIA DE SANTIAGO DE CHILE', '7/4/2011', 1, 422, 179, 'default', 422, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE SISTEMA DE COTIZACIÓN Y DE CONTROL DE EXISTENCIAS PARA LA EMPRESA ALUMAR', '11/10/12', 3, 423, NULL, 'default', 423, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE APOYO A LA ADMINISTRACION Y PLANIFICACION DE EVIDENCIA NORMATIVA DE AUDITORIAS PARA NEXUS S.A.', '7/4/2011', 3, 424, NULL, 'default', 424, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB PARA MONITOREAR DISPOSITIVOS GPS', '20/09/2011', 3, 425, NULL, 'default', 425, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA CMR DE APOYO A LA FUERZA DE VENTAS CON CLIENTE DE OPERACION ASINCRONICA', '7/4/2011', 3, 426, NULL, 'default', 426, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN SISTEMA DE APOYO A LA GESTIÓN DE TORNEOS Y APUESTAS EN LA COMUNIDAD DE VIDEOJUEGOS CIBERDEPORTES.NET.', '30/03/2012', 3, 428, NULL, 'default', 428, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('WEB SERVICES PARA APOYAR LA VENTA DE SEGUROS DE VEHÍCULOS PARTICULARES A TRAVES DE UNA MULTITIENDA', '1/2/2012', 3, 429, NULL, 'default', 429, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE INFORMACIÓN DE APOYO PARA AUTOMATIZACIÓN Y MONITOREO DE ACTIVIDADES DE PLAN DE CORTE EN CONVERSIÓN DE TIENDAS PARA LA COMPAÑÍA ZCMART CHILE.', '', 3, 430, NULL, 'default', 430, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PLATAFORMA PARA LA GENERACIÓN Y APOYO A LA EVALUACIÓN DE VISUALIZAORES DE RESULTADOS DE BÚSQUEDA', '1/2014', 3, 435, NULL, 'default', 435, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('METODOLOGIA PARA EL DISEÑO DE INFRAESTRUCTURA DE ALTA DISPONIBILIDAD TI', '20/09/2011', 1, 441, 180, 'default', 441, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROTOCOLO SERVIDOR VIRTUAL EN NUBE PARA RESPALDO Y ACTUALIZACION DINAMICA DE AGENDA TELEFONICA CELULAR', '', 3, 442, NULL, 'default', 442, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('HERRAMIENTA INTERACTIVA PARA APOYAR LA EVALUACIÓN DE PACIENTES EN TRATAMIENTO DEL TRASTORNO DE DÉFICIT ATENCIONAL A PARTIR DEL RASTREO OCULAR', '1/2014', 3, 436, NULL, 'default', 436, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PLATAFORMA PARA EL APOYO A LA EVALUACIÓN Y DEFINICIÓN DE GESTOS CORPORALES EN LA INTERACCIÓN CON OBJETOS DIGITALES DE INFORMACIÓN', '1/2014', 3, 437, NULL, 'default', 437, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACIÓN IMPLÍCITA DE CARGA COGNITIVA DURANTE EL PROCESAMIENTO DE INFORMACIÓN A PARTIR DE PATRONES DE LECTURA', '1/2014', 3, 438, NULL, 'default', 438, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('FÁBRICA DE COLABORATORIOS PARA APOYAR LA INVESTIGACIÓN EN BÚSQUEDA COLABORATIVA DE INFORMACIÓN', '2/2014', 3, 439, NULL, 'default', 439, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PLATAFORMA PARA LA DEFINICIÓN Y APOYO A LA EVALUACIÓN DE RETROALIMENTACIÓN TÁCTIL EN LA INTERACCIÓN CON OBJETOS DE INFORMACIÓN DIGITAL A TRAVÉS DE INTERFACES NATURALES', '2/2014', 3, 440, NULL, 'default', 440, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('RED SOCIAL TWITTER APLICADA A SEGURIDAD DOMOTICA PROTOTIPO CON ACCESO MOBILE', '8/22/2011', 1, 443, 181, 'default', 443, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE LAS REDES IP', '2/2013', 3, 449, NULL, 'default', 449, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('TECNOLOGÍA QR MÓVIL DE APOYO A LA VENTA ONLINE Y FUNCIÓN DE CAJEROS MÓVILES EN SUPERMERCADOS.', '8/22/2011', 1, 444, 182, 'default', 444, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROTOTIPO DE NODO OBSERVATORIO TERRITORIAL INTEGRADO EN RED,PARA GEOLOCALIZACIÓN DE RECURSOS Y APOYO A LA GESTIÓN DINÁMICA COMUNAL (P-NOT).', '12/7/2010', 3, 445, NULL, 'default', 445, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('NODO COMUNAL INTEGRABLE A RED DE GEO-REPRESENTACIÓN DE ZONAS DE RIESGO Y CONTINGENCIA TERRITORIAL, BASADO EN SOFWARE LIBRE (NODO CIR-GR2).', '13/08/2010', 3, 446, NULL, 'default', 446, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA PARA EL MANEJO DE PARTITURAS DIGITALES BASADA EN TECNOLOGÍA TOUCH-MOBILE PARA ORQUESTAS SINFÓNICAS.', '', 3, 447, NULL, 'default', 447, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UNA APLICACIÓN MULTIMEDIA QUE APOYE EL APRENDIZAJE DEL IDIOMA CHINO MANDARIN COMO LENGUAJE EXTRANJERA ORIENTADO A LA ESCRITURA', '7/10/2011', 3, 450, NULL, 'default', 450, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO DE UN LABORATORIO VIRTUAL PARA EL CURSO CRIPTOGRAFÍA', '05/08/11', 3, 451, NULL, 'default', 451, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETO DE APRENDIZAJE PARA EL ESTUDIO DE REDES DE ÁREA LOCAL', '1/2014', 3, 454, NULL, 'default', 454, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE MONITIREO REMOTO EXCLUSIVO PARA DISPOSITIVOS CON SOPORTE IPV6', '10/5/2011', 1, 452, 183, 'default', 452, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL APOYO A LA INTRODUCCIÓN A LA PROGRAMACIÓN', '1/2014', 3, 455, NULL, 'default', 455, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE APOYO DE GESTIÓN EFICIENTE DE LAS ENERGÍAS DEL DIINF', '', 1, 453, 184, 'default', 453, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDS SATELITALES', '2/2012', 3, 456, NULL, 'default', 456, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRESIÓN Y APLICACIÓN DE LOS FUNDAMENTOS DE DESARROLLO WEB', '04/12/12', 1, 457, 185, 'default', 457, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN FRAMEWORK PARA LA CONSTRUCCIÓN DE OBJETOS DE APRENDIZAJE', '', 3, 461, NULL, 'default', 461, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN SISTEMA DE COMPRA VENTA DE SEGUROS EN LÍNEA', '25/04/12', 1, 458, 186, 'default', 458, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN SISTEMA DE NOTIFICACIONES A TRAVÉS DE REDES SOCIALES DE INTERNET', '19/03/13', 3, 460, NULL, 'default', 460, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE COMUNICACIÓN DE EMERGENCIAS AL CUERPO DE BOMBEROS DE SANTIAGO', '1/2014', 3, 463, NULL, 'default', 463, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DE RED COMPUTACIONAL EMPRESA VYS', '02/04/12', 1, 462, 187, 'default', 462, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SOFTWARE DE APOYO AL SEGUIMIENTO DEL PLAN ESTRATÉGICO DE LA EMPRESA PÚBLICA EMERES', '7/11/2013', 3, 464, NULL, 'default', 464, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETO DE APRENDIZAJE PARA EL ESTUDIO DE DISTRIBUCIÓN DE CLAVES CRIPTOPOGRÁFIA', '', 1, 465, 188, 'default', 465, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS MÉTODOS DE DETECCIÓN Y CORRECCIÓN DE ERRORES EN LA TRANSMISIÓN DE DATOS.', '3/10/2013', 3, 468, NULL, 'default', 468, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MODELO PARA LA AUTORIZACIÓN DE TRANSACCIONES FINANCIERAS BASADO EN ESTÁNDAR EMV', '12/11/12', 1, 466, 189, 'default', 466, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETO DE APRENDIZAJE PARA TRANSMISIÓN DE DATOS', '', 3, 471, NULL, 'default', 471, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACIÓN DE APOYO AL APRENDIZAJE DE LA FONÉTICA DEL IDIOMA CHINO MANDARÍN.', '15/10/11', 1, 467, 190, 'default', 467, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUCION DE LA EFICIENCIA DE LOS OBJETOS DE APRENDIZAJE QUE APOYAN LA ENSEÑANZA DE LOS ALUMNOS DEL CURSO DE CRIPTOGRAFIA', '20/06/11', 3, 469, NULL, 'default', 469, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE PROTOCOLOS CRIPTOGRÁFICOS CLÁSICOS', '2/2013', 3, 472, NULL, 'default', 472, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('METODOLOGÍA PARA EL DESARROLLO DE OBJETOS DE APRENDIZAJE', '11/01/13', 1, 470, 191, 'default', 470, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DEL MARCO DE TRABAJO DE DESARROLLO DE SOFTWARE SCRUM', '1/2014', 3, 473, NULL, 'default', 473, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE EN APOYO A CONDUCTAS DE AUTOCUIDADO PARA NIÑOS Y JÓVENES CON DISCAPACIDAD INTELECTUAL', '11/01/13', 1, 475, 192, 'default', 475, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SERVICIO DE COMUNICACIÓN POR VOZ EN UNA RED INALÁMBRICA DE MALLA SIMULADA', '1/2014', 3, 474, NULL, 'default', 474, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('', '2/2013', 1, 476, 193, 'default', 476, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PLAN DE CAPACITACIÓN EMPRESARIAL PARA ENSEÑAR TELEFONIA CELULAR USANDO OBJETOS DE APRENDIZAJE', '05/08/11', 3, 478, NULL, 'default', 478, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SOFTWARE PREDICTIVO DE APOYO A LA PLANEACIÓN DE CAPACIDAD DE INFRAESTRUCTURAS DE RED', '', 3, 477, NULL, 'default', 477, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DEL PROTOCOLO DE AUTENTICACIÓN KERBEROS', '11/01/13', 1, 479, 194, 'default', 479, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EAPECIFICACIÓNES FORMAL DE UNA RED MESH ORIENTADA AL ESTUDIO DE ALGORITMOS DE ENRUTAMIENTO Y AUTENTICACIÓN.', '', 3, 482, NULL, 'default', 482, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SERVICIO DE CONFIDENCIALIDAD EN RED DE MALLA INALAMBRICA', '2/2013', 7, 483, NULL, 'default', 483, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UNA PLATAFORMA CROWDSOURCING PARA LA PREPARACIÓN DE LA PSU', '1/2014', 3, 480, NULL, 'default', 480, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE PROTOCOLOS DE SEGURIDAD PARA CORREO ELECTRÓNICOS', '30/03/2012', 1, 486, 195, 'default', 486, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDES DE AREA LOCAL (ETHERNET)', '13/08/2013', 3, 481, NULL, 'default', 481, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACION DE APOYO AL APRENDIZAJE DE LA ESCRITURA EN CHINO MANDARIN', '', 1, 487, 196, 'default', 487, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN Y APLICACIÓN DE IPV6.', '27/07/11', 3, 488, NULL, 'default', 488, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GUÍ METODOLÓGICA PARA LA IMPLEMENTACIÓN DE UN PROTOCOLO DE AUTENTICACIÓN BASADO EN KERBEROS.', '28/08/2009', 3, 489, NULL, 'default', 489, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE ENFOCADOS EN TRANSMISIÓN INALÁMBRICA', '01/03/12', 3, 491, NULL, 'default', 491, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETO DE APRENDIZAJE PARA APOYAR EL APRENDIZAJE DE LA HERRAMIENTA OMNET++', '22/09/2014', 3, 484, NULL, 'default', 484, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LA SEGURIDAD EN REDES A TRAVÉS DE FUNCIONES HASH, FUNCIONES MAC Y FIRMA DIGITAL', '11/10/12', 1, 494, 197, 'default', 494, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE COMO HERRAMIENTA DE APOYO A LA ENSEÑANZA DE PROTOCOLOS DE SEGURIDAD EN LA RED.', '04/10/12', 3, 485, NULL, 'default', 485, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE GESTIÓN DE PROYECTOS CONSULTORA SAP PRIME GROUP.', '03/05/11', 1, 496, 198, 'default', 496, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE APLICACIONES DE TIEMPO REAL EN INTERNET', '1/2014', 3, 490, NULL, 'default', 490, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DEL IDIOMA INGLÉS EN NIÑOS PREESCOLARES', '22/07/2013', 3, 492, NULL, 'default', 492, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SERVICIO PARA COMPARTIR MATERIAL DE ESTUDIO SOBRE UNA RED INALÁMBRICA DE MALLA SIMULADA ', '1/2014', 3, 493, NULL, 'default', 493, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETO DE APRENDIZAJE PARA APOYAR EL PROCESO DE LECTURA INFANTIL', '1/2014', 3, 495, NULL, 'default', 495, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACIÓN DE APOYO AL APRENDIZAJE DE LA GRAMÁTICA DEL CHINO MANDARIN', '1/2014', 3, 497, NULL, 'default', 497, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACION DE UNA NUEVA METODOLOGIA PARA EL DESARROLLO DE OBJETOS DE APRENDIZAJE', '', 3, 503, NULL, 'default', 503, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE INTERACTIVOS PARA APOYAR EL ESTUDIO DE LOS MÉTODOS DE DETECCIÓN Y CORRECCIÓN DE ERRORES EN LA TRANSACCIÓN DE DATOS', '2/2013', 1, 498, 199, 'default', 498, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS PROTOCOLOS USADOS EN APLICACIONES TIEMPO-REAL EN INTERNET, REAL TIME PROTOCOL (RTP) Y REAL TIME PROTOCOL (RTCP).', '12/5/2014', 7, 499, NULL, 'default', 499, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE ALGORITMOS HASH.', '20/09/11', 3, 500, NULL, 'default', 500, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN SISTEMA DE INFORMACIÓN PARA OPTIMIZAR LA GESTIÓN DE PLANIFICACIÓN DE LA RED DE TRANSMISIÓN ELÉCTRICA.', '30/11/2011', 3, 501, NULL, 'default', 501, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE PROTOCOLOS DE APLICACIÓN EN INTERNET', '1/2014', 3, 508, NULL, 'default', 508, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACIÓN DE METODOLOGÍA CPIS PARA EL DESARROLLO DE OBJETOS DE APRENDIZAJE', '', 1, 504, 200, 'default', 504, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA EL ESTUDIO DE LOS MECANISMOS DE CONTROL DE CONGESTIÓN EN REDES DE CONMUTACIÓN DE PAQUETES', '1/2014', 3, 511, NULL, 'default', 511, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO Y COMPRENSIÓN DE LOS PROTOCOLOS DE SEGURIDAD IPSEC Y SSL PARA INTERNET', '11/10/12', 1, 505, 201, 'default', 505, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDES WI-FI Y WI-MAX', '22/07/2013', 3, 514, NULL, 'default', 514, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN REPOSITORIO DE OBJETOS DE APRENDIZAJE PARA EL DEPARTAMENTO DE INGENIERÍA INFORMÁTICA', '27/12/2012', 1, 506, 202, 'default', 506, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MODELO DE GESTIÓN DE COTIZACIONES Y VENTAS DE SEGUROS DE VEHÍCULOS', '24/10/2014', 3, 517, NULL, 'default', 517, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IMPLEMENTACIÓN DE SEGURIDAD EN ROLES Y PERFILES PARA SAP ERP EN CONSTRUMART S.A.', '12/11/12', 1, 507, 203, 'default', 507, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETO DE APRENDIZAJE SOBRE LA DIRECCIÓN Y GESTIÓN DE PROYECTOR TI', '1/2014', 3, 521, NULL, 'default', 521, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACIÓN WEB PARA LA ADMINISTRACIÓN DE EVALUACIONES DE ATENCIÓN A CLIENTES PARA CONSULTORA GETGAIN', '13/1/12', 1, 509, 204, 'default', 509, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN DE LOS CIFRADORES SIMÉTRICOS RC4, IDEA Y BLOWFISH', '5/3/2013', 3, 522, NULL, 'default', 522, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE OBJETIVOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS MECANISMOS DE CONTROL DE CONGESTION USANDO REDES DE CONMUTACION DE PAQUETES', '', 1, 510, 205, 'default', 510, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO, IMPLEMENTACIÓN Y ANÁLISIS DE BLOQUES ATÓMICOS EN CONTRA DE SSCA, ATAQUES C-SAFE-FAULTS Y ATAQUES DE COLISIÓN DE CORRELACIÓN HORIZONTAL EN CRIPTOGRAFÍA DE CURVA ELÍPTICA', '2/2014', 3, 523, NULL, 'default', 523, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LAS REDES DE TELEFONÍA CELULAR.', '30/05/11', 1, 512, 206, 'default', 512, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETO DE APRENDIZAJE PARA APOYAR LA ENSEÑANZA DE PROTOCOLOS DE VENTANA DESLIZANTE', '2/2014', 3, 524, NULL, 'default', 524, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE PARA APOYAR LA COMPRENSIÓN DE LOS CIFRADOS SIMÉTRICOS AES Y DES.', '10/11/11', 1, 513, 207, 'default', 513, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACIÓN DE UN MÉTODO DE VALIDACIÓN SOBRE LOS OBJETOS DE APRENDIZAJE DEL REPOSITORIO DEL DIINF', '2/2014', 3, 525, NULL, 'default', 525, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('METODO DE VALIDACION PARA OBJETOS DE APRENDIZAJE', '25/10/2013', 1, 515, 208, 'default', 515, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE SOBRE CRIPTOGRAFÍA SIMÉTRICO PARA BLOWFISH', '2/2014', 3, 526, NULL, 'default', 526, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UN ALGORITMO DE AUTENTICACIÓN PARA LA SEGURIDAD EN REDES DE MALLA', '11/10/12', 1, 516, 209, 'default', 516, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PROCESO DE NEGOCIO Y REQUERIMIENTOS PARA SISTEMA DE RECLUTAMIENTO Y SELESCCIÓN DE EMPRESA DE ÁREA FINANCIERA', '19/01/13', 3, 518, NULL, 'default', 518, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('LOCALIZACIÓN Y SEGUIMIENTO DE PERSONAS DENTRO DE UN TREN EN MOVIMIENTO UTILIZANDO VISIÓN ARTIFICIAL', '2/2013', 3, 527, NULL, 'default', 527, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ESTUDIO Y DESARROLLO DE UN SISTEMA DE RESPALDO (BACKUP) Y RECUPERACIÓN PARA LA SEGURIDAD Y CONTINUIDAD OPERACIONAL DE PROVECTIS S.A.', '06/01/11', 1, 519, 210, 'default', 519, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO E IMPLEMENTACIÓN DE UN REPOSITORIO DE OAS PARA EL DEPARTAMENTO DE INGENIÉRIA INFORMÁTICA', '01/08/12', 3, 520, NULL, 'default', 520, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CONTABILIZACIÓN DE PERSONAS QUE SUBEN Y BAJAN DE UN TREN METROPOLITANO USANDO VISIÓN POR COMPUTADOR', '2/2013', 3, 528, NULL, 'default', 528, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('PICKUP AND DELIVERY PROBLEM: APLICACIÓN AL PROBLEMA DE ASIGNACIÓN DE TAREAS PARA LA FLOTA DE CAMIONES DE TRANSPORTES BELLO.', '10/11/11', 1, 533, 211, 'default', 533, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UN MODELO DE OPTIMIZACIÓN PARA EL RUTEO DE FLOTA DE CAMIONES DE UNA EMPRESA DE TRANSPORTES', '21/12/09', 3, 535, NULL, 'default', 535, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UNA SOLUCIÓN AL PROBLEMA DE PLANIFICACIÓN DE DISTRIBUCIÓN DE CONTENEDORES LLENOS Y VACÍOS.', '05/10/11', 3, 537, NULL, 'default', 537, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DETECCIÓN DE PERSONAS EN TIEMPO REAL MEDIANTE EL USO DE UNA RASPBERRY PI', '2/2013', 3, 529, NULL, 'default', 529, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACION DE NUEVOS ALGORITMOS UTILIZANDO PROGRAMACION GENETICA PARA EL PROBLEMA DE OPTIMIZACION JOB SHOP FLEXIBLE', '', 1, 538, 212, 'default', 538, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DETECCIÓN DE VEHÍCULOS DETENIDOS EN SECTORES PROHIBIDOS DEL TRÁFICO URBANO UTILIZANDO TÉCNICAS DE VISIÓN POR COMPUTADOR.', '2/2013', 3, 530, NULL, 'default', 530, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SITIO WEB PARA LA INCORPORACION DE VIDEOS EN LAS SALAS DE CLASES', '7/4/2011', 1, 539, 213, 'default', 539, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ANÁLISIS COMPARATIVO DE CLASIFICADORES EN CUANTO A SU SENSIBILIDAD ESPACIAL PARA LA DETECCIÓN DE PEATONES EN IMÁGENES', '1/2014', 3, 531, NULL, 'default', 531, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('RESOLVIENDO EL PROBLEMA CORTE DE PIEZAS GUILLOTINA MEDIANTE LA COMPUTACION EVOLUTIVA', '1/2013', 1, 540, 214, 'default', 540, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DETECCIÓN, LOCALIZACIÓN Y CONTEO AUTOMÁTICO DE PERSONAS QUE ENTRAN A UN MICROBÚS, MEDIANTE ALGORITMOS DE VISIÓN POR COMPUTADOR.', '2/2013', 3, 532, NULL, 'default', 532, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ALGOBOTS PARA EL PROBLEMA DE LA MOCHILA MULTIDIMENSIONAL', '', 1, 541, 215, 'default', 541, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACION AUTOMATICA DE ALGORITMO PARA EL PROBLEMA DE FORMACION DE CELULAS DE MANUFACTURAS', '12/10/11', 3, 542, NULL, 'default', 542, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ESTUDIO DE APLICABILIDAD DE VIDEOS JUEGOS PARA SOLUCIONAR PROBLEMAS DE OPTIMIZACION', '28/07/10', 3, 544, NULL, 'default', 544, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE VIDEOS CLASIFICADOS DE APOYO EN LA PREPARACIÓN DE ESTUDIANTES PARA LA PSU-MATEMÁTICAS', '', 3, 534, NULL, 'default', 534, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACION DE ALGORITMOS PARA EL PROBLEMA JOB-SHOP FLEXIBLE UTILIZANDO PROGRAMACION GENETICA', '', 1, 545, 216, 'default', 545, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVOLUCIÓN DE METAHEURÍSTICAS PARA PROBLEMAS DE OPTIMIZACIÓN COMBINATORIA', '1/2014', 3, 536, NULL, 'default', 536, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UN ALGORITMO GENÉTICO COOPERATIVO PARA PROBLEMAS DE CORTES Y EMPAQUE', '19/07/2012', 1, 546, 217, 'default', 546, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UNA SOLUCIÓN HEURÍSTICA PARA EL PROBLEMA ASIGNACIÓN DE BUSES Y TRIPULACIONES CONSIDERANDO SUS ROTACIONES.', '', 3, 547, NULL, 'default', 547, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DETECCIÓN DE FALLAS EN GRANJA FOTOVOLTAICA MODULAR DE 10 MW/H', '1/2014', 3, 543, NULL, 'default', 543, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('INFRAESTRUCTURA EMPRESARIAL PARA OBSERVATORIO DE LA WEB: CASO DE LA GENERACIÓN DE NOTICIAS EN UNA RED SOCIAL CORPORATIVA CON UN PROCESO DE NEGOCIO ASOCIADO', '9/9/2014', 3, 86, NULL, 'default', 86, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('MEJORA DE ALGORITMOS AUTOMÁTICOS PARA EL PROBLEMA DE LA MOCHILA IDENTIFICANDO EL CONJUNTO DE FUNCIONES Y TERMINALES ADECUADO', '11/10/12', 1, 550, 218, 'default', 550, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('AGENTES RECURSIVOS PARA EL CONTROL DE LA CENTRALIZACIÓN Y DISTRIBUCIÓN DE LAS DECISIONES EN SISTEMAS INTELIGENTES DE PRODUCCIÓN', '30/03/2012', 3, 551, NULL, 'default', 551, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CONTINUOUSDELIVERY DE SERVICIOS DE RECOMENDACIÓN EN UNA RED SOCIAL EMPRESARIAL DE NOTICIAS', '10/6/2014', 3, 101, NULL, 'default', 101, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVOLUCION DE ALGORITMOS DETECTORES DE TRAYECTORIA PARA EL PROBLEMA DEL VENDEDOR VIAJERO', '', 1, 554, 219, 'default', 554, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EFECTOS DEL CRITERIO DE ENFRIAMIENTO SOBRE SIMULATED ANNEALING EN LA RESOLUCIÓN DEL PROBLEMA DEL ÁRBOL DE COBERTURA MÍNIMA', '04/10/12', 3, 555, NULL, 'default', 555, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO Y DESARROLLO DE UNA PLATAFORMA PARA EL SOPORTE DE LAS CLASAS VIRTUALES EN CURSOS DE INGENIERÍA EN EJECUCIÓN EN COMPUTACIÓN E INFORMÁTICA.', '20/12/10', 3, 556, NULL, 'default', 556, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('REGISTRO DE IMÁGENES ASTRONÓMICAS', '2/2013', NULL, 557, NULL, 'default', 557, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE SISTEMAS WORKFLOW PARA EL PLANTEAMIENTO Y VERIFICACIÓN DE COMPETENCIAS DE MANEJO DE PROYECTOS EN LOS CURSOS DE INGENIERÍA CIVIL INFORMÁTICA', '1/2014', 3, 108, NULL, 'default', 108, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UN JUEGO GENERADOR DE ALGORITMOS PARA EL PROBLEMA DE LA MOCHILA.', '20/09/11', 1, 558, 220, 'default', 558, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO Y APLICACIÓN DE MODELO DINÁMICO EN AMBIENTE REAL DE CONMINUCIÓN PARA ESTIMAR EN LINEA VARIABLES CRÍTICAS DE MOLIENDA SEMIAUTÓGENA', '1/2012', 3, 151, NULL, 'default', 151, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACION ATOMATICA DE ALGORITMOS PARA EL PROBLEMA DEL VENDEDOR VIAJERO', '', 1, 559, 221, 'default', 559, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UNA RESOLUCIÓN AL PROBLEMA DE LA SELECCIÓN UBICADA DE INTERRUPTORES EN UN SISTEMA DE DISTRIBUSIÓN ELÉCTRICO, CON MÉTODO DE OPTIMIZACIÓN HEURÍSTICA ALGORITMO GENÉTICO PARALELO', '', 3, 560, NULL, 'default', 560, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UN SISTEMA WEB PARA MEJORAR EL RENDIMIENTO DE IMPRESORAS AL ENVIAR TRABAJOS DE IMPRESIÓN MASIVA', '22/07/2013', 3, 214, NULL, 'default', 214, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SOLUCIÓN NUMÉRICA AL PROBLEMA DEL ÁRBOL DE COBERTURA MÍNIMO GENERALIZADO MEDIANTE SIMULATED ANNEALING', '26/09/2012', 1, 561, 222, 'default', 561, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO E IMPLEMENTACIÓN DE APLICACIÓN MÓVIL EN ANDROID PARA EL CONTROL PERSONALIZADO DE LA ALIMENTACIÓN', '2/2013', 3, 250, NULL, 'default', 250, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('REDUCCIÓN DE ARISTAS PARA INSTANCIAS DE ÁRBOL DE COBERTURA MÍNIMO GENERALIZADO', '03/09/12', 1, 562, 223, 'default', 562, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IMPLEMENTACIÓN DE UN ERP DE APOYO A LA ADMINISTRACIÓN DEL SALÓN DE BELLEZA ÁRTICO', '1/2014', 3, 299, NULL, 'default', 299, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UNA CONTRIBUCIÓN AL PROBLEMA DE ASIGNACIÓN DE VEHÍCULOS CON MÚLTLIPES DEPÓSITOS Y MANTENCIONES PROGRAMADAS', '26/04/12', 1, 563, 224, 'default', 563, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACIÓN AUTOMÁTICA DE ALGORITMOS PARA EL PROBLEMA DE CORTE DE PIEZAS NO GUILLOTINA CON PROGRAMACIÓN GENÉTICA BINARIA PARALELA.', '02/12/10', 3, 564, NULL, 'default', 564, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACIÓN DE LOS MÉTODOS NARX Y NARMAX CON REDES NEURONALES Y MÁQUINA DE SOPORTE VECTORIAL PARA LA ESTIMACIÓN DE LA ACCIDENTABILIDAD EN LA MINERÍA', '2/2012', 3, 552, NULL, 'default', 552, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACIÓN AUTOMÁTICA DE ALGORITMOS DE CLUSTERIZACIÓN.', '', 1, 566, 225, 'default', 566, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACIÓN DE UNA SOLUCIÓN HEURÍSTICA PARA EL PROBLEMA DE TSPPC A TRAVÉS DE LA PROGRAMACIÓN GENÉTICA', '1/2014', 3, 553, NULL, 'default', 553, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('BÚSQUEDA DE ALGORITMOS ESPECIALIZADOS PARA FAMILIAS DE INSTANCIAS DE PROBLEMAS DE OPTIMIZACIÓN', '2/2013', 1, 567, 226, 'default', 567, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACIÓN DE LA CALENDARIZACIÓN DE LOS PARTIDOS DEL CAMPEONATO DE FÚTBOL DE CHILE MEDIANTE SIMULATED ANNEALING', '1/2014', 3, 569, NULL, 'default', 569, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('NUEVOS ALGORITMOS ARTIFICIALES PARA LA ASIGNACION DE BUSES Y SERVICIOS DE CONDUCCION EN EL TRANSPORTE URBANO', '13/11/10', 1, 568, 227, 'default', 568, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('IMPLEMENTACION DE HERRAMIENTA DE APOYO A LA GESTION DE LA DOCENCIA EN  COLEGIOS DE EDUCACION MEDIA BASDA EN TECNOLOGIA DE CODIGO ABIERTO', '', 3, 571, NULL, 'default', 571, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACIÓN DE ALGORITMOS PARA EL PROBLEMA DE OPTIMIZACIÓN CELL FORMATION PROBLEM UTILIZANDO COMPUTACIÓN EVOLUTIVA', '2/2013', 3, 570, NULL, 'default', 570, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN SISTEMA PARA MEJORAR LA BÚSQUEDA Y MANEJO DE ÍTEMS DE CONFIGURACIÓN PARA APOYO AL PROCESO DE GESTIÓN DE CONFIGURACIÓN ITIL V3', '14/07/2014', 1, 572, 228, 'default', 572, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICANDO INDICADORES A ALGORITMOS GENERADOS POR PROGRAMACIÓN GENÉTICA PARA EL PROBLEMA NP-C TSP.', '28/05/2012', 3, 573, NULL, 'default', 573, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERADOR DE ALGORITMOS PARA RESOLVER EL PROBLEMA DE LA PLANIFICACIÓN DE BUSES PARA EL TRANSPORTE URBANO DE PASAJEROS', '1/2012', 3, 575, NULL, 'default', 575, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('NUEVOS ENFOQUES ALGORÍTMICOS PARA JOB SHOP SCHEDUBLING PROBLEM Y FLOW SHOP SCHEDULING PROBLEM', '11/10/12', 1, 574, 229, 'default', 574, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('ALGORITMO DE CLASIFICACIÓN DE GALAXIAS SEGÚN SU MORFOLOGÍA EN IMÁGENES CAPTURADAS POR EL RADIOTELESCOPIO DEL OBSERVATORIO ALMA.', '31/03/2014', 3, 578, NULL, 'default', 578, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CREACIÓN AUTOMATICA DE ALGORITMOS PARA RESOLVER EL PROBLEMA DE CAMINO MINIMO BASANDOSE EN COMPUTACIÓN EVOLUTIVA0', '11/10/12', 1, 576, 230, 'default', 576, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO E IMPLEMENTACION DE CONTENIDOS DE UN SITIO WEB PARA LA SOLUCION DE LOS PROBLEMAS DEL CAMINO MINIMO, FLOW SHOP Y JOB SHOP Y ARBOL DE COBERTURA DE COSTO MINIMO', '4/8/2010', 3, 577, NULL, 'default', 577, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('NUEVAS HIPERHEURÍSTICAS COMPETITIVAS PARA EL PROBLEMA DEL CONJUNTO INDEPENDIENTE MÁXIMO DE VÉRTICES', '2/2013', 3, 579, NULL, 'default', 579, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('EVALUACIÓN DE ALGORITMOS GENÉTICOS CELULARES PARA EL PROBLEMA DE CORTE DE PIEZAS', '11/01/13', 1, 581, 231, 'default', 581, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DISEÑO DE UN ALGORITMO PARA EL PROBLEMA DEL COLOREAMIENTO DE GRAFOS A TRAVÉS DE UN JUEGO COMPUTACIONAL.', '', 3, 582, NULL, 'default', 582, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('GENERACIÓN DE ALGORITMOS UTILIZANDO PROGRAMACIÓN GENÉTICA PARA EL PROBLEMA DE OPTIMIZACIÓN GENERALIZED TRAVELLING SALESMAN PROBLEM', '2/2013', 3, 580, NULL, 'default', 580, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('UN SISTEMA WEB DE VIDEOS EDUCATIVOS PARA SEGUNDO Y TERCER NIVEL DE INGENIERÍA.', '07/10/11', 1, 583, 232, 'default', 583, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('CO-EVOLUCIÓN COMPUTACIONAL EN PROBLEMAS DE OPTIMIZACIÓN COMBINATORIA', '2/2014', 3, 584, NULL, 'default', 584, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('REVISIÓN Y MEJORAS DEL SOFTWARE PARA LA ADMINISTRACIÓN DE LAS POSTULACIONES A PROGRAMAS VESPERTINOS DEL DIINF', '2/2014', 3, 585, NULL, 'default', 585, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DATOS SENSIBLES Y SU MANIPULACIÓN EN DISPOSITIVOS MÓVILES', '2/2014', 3, 586, NULL, 'default', 586, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('APLICACIÓN MULTIPLATAFORMA PARA DENUNCIAS, SUCESOS Y EVENTOS GEOCALIZADOS EN TIEMPO REAL CON EVIDENCIA MULTIMEDIA', '2/2014', 3, 587, NULL, 'default', 587, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE CARACTERIZACIÓN BIOLÓGICA DE GRUPOS DE GENES ', '2/2014', 3, 588, NULL, 'default', 588, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA DE INFORMACIÓN DOCENTE PARA APOYO A LA ACREDITACIÓN DE LOS PROGRAMAS DE PREGRADO DEL DEPARTAMENTO DE INGENIERÍA INFORMÁTICA DE LA UNIVERSIDAD DE SANTIAGO DE CHILE', '2/2014', 3, 394, NULL, 'default', 394, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('OBJETOS DE APRENDIZAJE RELATIVOS AL TRATAMIENTO DE ERROR EN LA TRANSMISIÓN Y RECEPCIÓN DE DATOS', '1/2014', 3, 448, NULL, 'default', 448, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE OBJETOS DE APRENDIZAJE PARA APOYAR EL ESTUDIO DE LOS PROTOCOLOS DE TRANSPORTE UTILIZADOS EN REDES CONMUTACIÓN DE PAQUETES', '2/2013', 3, 459, NULL, 'default', 459, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('DESARROLLO DE UN PROTOTIPO DE RED INALÁMBRICA DE MALLA PARA EL DEPARTAMENTO DE INGENIERÍA INFORMÁTICA', '1/2014', 3, 502, NULL, 'default', 502, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('NUEVOS ALGORÍTMOS ARTIFICIALES DE OPTIMIZACIÓN PARA EL WEIGHTED INDEPENDENCE SET PROBLEM BAJO LA TEORÍA DE LA COMPUTACIÓN EVOLUTIVA', '', 3, 549, NULL, 'default', 549, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('TEMA111', '01/06/2015', 1, 595, 239, '1/2016', 597, '23/05/2015', '16/05/2015', '1/2016', NULL, NULL);
INSERT INTO tema VALUES ('ASDTEMA', '19/05/2015', 0, 597, NULL, '1/2016', 602, NULL, NULL, NULL, NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEW PARA AYUDAR A PADRES Y APODERADOS EN LA BUSQUEDA DE COLEGIOS USANDO UN OPEN DATE', '11/10/2012', 1, 1, 1, '1/2015', 1, '17/05/2015', '16/05/2015', NULL, NULL, NULL);
INSERT INTO tema VALUES ('TEMABAS', '28/05/2015', 1, 593, 236, '1/2016', 595, '19/05/2015', '16/05/2015', NULL, NULL, NULL);
INSERT INTO tema VALUES ('TEMA EJEMPLO 2', '19/05/2015', 1, 598, 240, '1/2016', 603, '21/05/2015', '20/05/2015', '1/2016', NULL, NULL);
INSERT INTO tema VALUES ('TEMA TM', '28/05/2015', 1, 596, 238, '1/2016', 598, '21/05/2015', '16/05/2015', NULL, NULL, NULL);
INSERT INTO tema VALUES ('TEMA PROP', '15/05/2015', 1, 592, 235, '1/2016', 594, '23/05/2015', '22/05/2015', NULL, NULL, NULL);
INSERT INTO tema VALUES ('TEMA', '15/05/2015', 1, 594, 237, '1/2016', 596, '16/05/2015', '15/05/2015', '1/2016', NULL, NULL);
INSERT INTO tema VALUES ('QWEQWE', '30/03/2013', 1, 7, 233, '2/2011', 7, '21/05/2015', '20/05/2015', '1/2016', NULL, NULL);
INSERT INTO tema VALUES ('SISTEMA WEB DE APOYO A LA GESTIÓN DE UNA ORGANIZACIÓN COMUNITARIA', '20/12/2013', 1, 6, 4, '1/2016', 6, '21/05/2015', '20/05/2015', '1/2016', NULL, NULL);


--
-- Name: tema_id_tema_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tema_id_tema_seq', 599, true);


--
-- Data for Name: tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tipoevento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tipoevento VALUES (1, 'F2: Actividades Deportivas');
INSERT INTO tipoevento VALUES (2, 'F4: Actividades de Difusión científica y tecnológica');
INSERT INTO tipoevento VALUES (3, 'F3: Actividades Artísticas');


--
-- Data for Name: tipousuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: usuario_tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: usuario_tipousuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: usuarioevento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: versionplan; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO versionplan VALUES (1, 3, 2012, 1632, 2014, true, 1);
INSERT INTO versionplan VALUES (2, 1, 2003, 2476, 2003, true, 2);
INSERT INTO versionplan VALUES (3, 2, 2001, 2389, 2001, true, 3);
INSERT INTO versionplan VALUES (4, 2, 1990, 998, 1990, true, 4);
INSERT INTO versionplan VALUES (5, 3, 2012, 1638, 2014, true, 5);
INSERT INTO versionplan VALUES (6, 1, 2002, 2989, 2001, true, 6);
INSERT INTO versionplan VALUES (7, 2, 1990, 6129, 2000, true, 7);
INSERT INTO versionplan VALUES (8, 1, 1990, 192, 1992, true, 8);
INSERT INTO versionplan VALUES (11, 1, 1990, 1662, 1993, false, 2);
INSERT INTO versionplan VALUES (12, 1, 2001, 2389, 2001, false, 3);
INSERT INTO versionplan VALUES (13, 1, 1990, 6129, 2000, false, 4);
INSERT INTO versionplan VALUES (14, 1, 2012, 8558, 2011, false, 5);
INSERT INTO versionplan VALUES (9, 1, 2012, 8552, 2011, false, 1);
INSERT INTO versionplan VALUES (10, 2, 2012, 8552, 2011, false, 1);
INSERT INTO versionplan VALUES (15, 2, 2012, 8558, 2011, false, 5);
INSERT INTO versionplan VALUES (16, 1, 1990, 998, 1990, false, 7);
INSERT INTO versionplan VALUES (17, 1, 1980, 2324, 1983, false, 9);
INSERT INTO versionplan VALUES (18, 1, 1980, 2324, 1983, false, 10);


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
    ADD CONSTRAINT pk_usuario_tipo PRIMARY KEY (rut_usuario, id_tipo);


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
    ADD CONSTRAINT tipousuario_pkey PRIMARY KEY (id_tipo);


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
