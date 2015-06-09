package entities;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "planes_alumno")
@IdClass(AsociacionPlanEstudioAlumnoId.class)
public class AsociacionPlanEstudioAlumno implements Serializable {

    @Id
    private String alumno_id;

    @Id
    private Long plan_id;
    
    @Column(name = "activo")
    private Boolean activo;

    @ManyToOne
    @PrimaryKeyJoinColumn(name = "plan_id", referencedColumnName = "id")
    private PlanEstudio planEstudio;

    @ManyToOne
    @PrimaryKeyJoinColumn(name = "alumno_id", referencedColumnName = "rut_alumno")
    private Alumno alumno;

    public String getAlumnoId() {
        return alumno_id;
    }

    public void setAlumnoId(String alumnoId) {
        this.alumno_id = alumnoId;
    }

    public Long getPlanId() {
        return plan_id;
    }

    public void setPlanId(Long planId) {
        this.plan_id = planId;
    }

    public Boolean isActivo() {
        return activo;
    }

    public void setActivo(Boolean activo) {
        this.activo = activo;
    }

    public PlanEstudio getPlanEstudio() {
        return planEstudio;
    }

    public void setPlanEstudio(PlanEstudio planEstudio) {
        this.planEstudio = planEstudio;
    }

    public Alumno getAlumno() {
        return alumno;
    }

    public void setAlumno(Alumno alumno) {
        this.alumno = alumno;
    }

}
