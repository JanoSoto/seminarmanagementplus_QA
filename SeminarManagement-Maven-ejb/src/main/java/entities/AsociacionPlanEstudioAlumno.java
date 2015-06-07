package entities;

import entities.Alumno;
import entities.AsociacionPlanEstudioAlumnoId;
import entities.PlanEstudio;
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
public class AsociacionPlanEstudioAlumno {

    @Id
    private String alumno_id;
    @Id
    private Integer plan_id;
    @Column(name = "activo")
    private boolean activo;

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

    public Integer getPlanId() {
        return plan_id;
    }

    public void setPlanId(Integer planId) {
        this.plan_id = planId;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
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
