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
@Table(name="planes_alumno")
@IdClass(AsociacionPlanEstudioAlumnoId.class)
public class AsociacionPlanEstudioAlumno {
  @Id
  private Integer alumnoId;
  @Id
  private Integer planId;
  @Column(name="activo")
  private boolean activo;
  
  @ManyToOne
  @PrimaryKeyJoinColumn(name="plan_id", referencedColumnName="id")
  private PlanEstudio planEstudio;
  
  @ManyToOne
  @PrimaryKeyJoinColumn(name="alumno_id", referencedColumnName="id")
  private Alumno alumno;
}