/*

    COMISION REVISORA

    public ComisionRevisora() {
        propuestaList = new ArrayList();
        profeRevisionList = new ArrayList();
        temaList = new ArrayList();
    }

    public ComisionRevisora(Integer idRevisora) {
        propuestaList = new ArrayList();
        profeRevisionList = new ArrayList();
        temaList = new ArrayList();
        this.idRevisora = idRevisora;
    }
    
    public void add(Propuesta object){
        propuestaList.add(object);
    }
    
    public void add(ProfeRevision object){
        profeRevisionList.add(object);
    }
    
    public void add(Tema object){
        temaList.add(object);
    }

    ALUMNO

    public Alumno() {
        propuestaList = new ArrayList();
    }

    public Alumno(String rutAlumno) {
        propuestaList = new ArrayList();
        this.rutAlumno = rutAlumno;
    }
    
    public void add(Propuesta object){
        propuestaList.add(object);
    }

    COMISION CORRECTORA

    public ComisionCorrectora() {
        temaList = new ArrayList();
        profeCorreccionList = new ArrayList();
    }

    public ComisionCorrectora(Integer idCorrectora) {
        temaList = new ArrayList();
        profeCorreccionList = new ArrayList();
        this.idCorrectora = idCorrectora;
    }
    
    public void add(Tema object){
        temaList.add(object);
    }
    
    public void add(ProfeCorreccion object){
        profeCorreccionList.add(object);
    }

    PROFESOR
    
    public Profesor() {
        profePropuestaList = new ArrayList();
        profeRevisionList = new ArrayList();
        profeCorreccionList = new ArrayList();
    }

    public Profesor(String rutProfesor) {
        profePropuestaList = new ArrayList();
        profeRevisionList = new ArrayList();
        profeCorreccionList = new ArrayList();
        this.rutProfesor = rutProfesor;
    }
    
    public void add(ProfePropuesta object){
        profePropuestaList.add(object);
    }
    
    public void add(ProfeRevision object){
        profeRevisionList.add(object);
    }
    
    public void add(ProfeCorreccion object){
        profeCorreccionList.add(object);
    }

    PROPUESTA
    
    public Propuesta() {
        profePropuestaList = new ArrayList();
        comisionRevisoraList = new ArrayList();
    }

    public Propuesta(Integer idPropuesta) {
        profePropuestaList = new ArrayList();
        comisionRevisoraList = new ArrayList();
        this.idPropuesta = idPropuesta;
    }
    
    public void add(ProfePropuesta object){
        profePropuestaList.add(object);
    }
    
    public void add(ComisionRevisora object){
        comisionRevisoraList.add(object);
    }

    SEMESTRE

    public Semestre() {
        comisionCorrectoraList = new ArrayList();
        propuestaList = new ArrayList();
        temaList = new ArrayList();
        comisionRevisoraList = new ArrayList();
    }

    public Semestre(String idSemestre) {
        comisionCorrectoraList = new ArrayList();
        propuestaList = new ArrayList();
        temaList = new ArrayList();
        comisionRevisoraList = new ArrayList();
        this.idSemestre = idSemestre;
    }
    
    public void add(ComisionCorrectora object){
        comisionCorrectoraList.add(object);
    }
    
    public void add(Propuesta object){
        propuestaList.add(object);
    }
    
    public void add(Tema object){
        temaList.add(object);
    }
    
    public void add(ComisionRevisora object){
        comisionRevisoraList.add(object);
    }

    TEMA

    public Tema() {
        comisionCorrectoraList = new ArrayList();
        comisionRevisoraList = new ArrayList();
    }

    public Tema(Integer idTema) {
        comisionCorrectoraList = new ArrayList();
        comisionRevisoraList = new ArrayList();
        this.idTema = idTema;
    }
    
    public void add(ComisionCorrectora object){
        comisionCorrectoraList.add(object);
    }
    
    public void add(ComisionRevisora object){
        comisionRevisoraList.add(object);
    }

    USUARIO

    public Usuario() {
        usuarioTipoList = new ArrayList();
    }

    public Usuario(String username) {
        usuarioTipoList = new ArrayList();
        this.username = username;
    }
    
    public void add(UsuarioTipo object) {
        usuarioTipoList.add(object);
    }


*/

