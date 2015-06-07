package entities;

import java.io.Serializable;

public class AsociacionPlanEstudioAlumnoId implements Serializable {
 
  private Integer planId;
 
  private Integer alumnoId;
 
  public int hashCode() {
    return (int)(planId + alumnoId);
  }
 
  public boolean equals(Object object) {
    if (object instanceof AsociacionPlanEstudioAlumnoId) {
      AsociacionPlanEstudioAlumnoId otherId = (AsociacionPlanEstudioAlumnoId) object;
      return (otherId.planId == this.planId) && (otherId.alumnoId == this.alumnoId);
    }
    return false;
  }
 
}