package entities;

import java.io.Serializable;

public class AsociacionPlanEstudioAlumnoId implements Serializable {
 
  private Long plan_id;
 
  private String alumno_id;
 
  public int hashCode() {
    return (int)(plan_id + Integer.parseInt(alumno_id.substring(0, alumno_id.length() - 2)));
  }
 
  public boolean equals(Object object) {
    if (object instanceof AsociacionPlanEstudioAlumnoId) {
      AsociacionPlanEstudioAlumnoId otherId = (AsociacionPlanEstudioAlumnoId) object;
      return (otherId.plan_id == this.plan_id) && (otherId.alumno_id.equals(this.alumno_id));
    }
    return false;
  }
 
}