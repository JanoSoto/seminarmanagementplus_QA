package util;

/**
 *
 * @author giovanni
 */
public class Util {
    public static String formatearRut(String rut) {
//        rut = rut.replaceAll("[^0-9]+", " ");
        int cont=0;
        String format;
        rut = rut.replace(".", "");
        rut = rut.replace("-", "");
        format = "-"+rut.substring(rut.length()-1);
        for(int i = rut.length()-2;i>=0;i--){
            format = rut.substring(i, i+1)+format;
            cont++;
            if(cont == 3 && i != 0){
                format = "."+format;
                cont = 0;
            }
        }
        return format;
    }
    
    public static String reducirNombre(String nombre, String apellido, Integer maxChars){
        while ( nombre.length() + apellido.length() > maxChars){
            String nombres[] = nombre.split(" ");
            String apellidos[] = apellido.split(" ");
            if ( nombres.length >= apellidos.length && !nombres[0].contentEquals("") ){
                if ( nombres.length > 1){
                    nombre = nombre.substring(0, nombre.lastIndexOf(" "));
                }else{
                    break;
                }
            } else {
                if ( apellidos.length > 1 ){
                    apellido = apellido.substring(0, apellido.lastIndexOf(" "));
                } else {
                    break;
                }
            }
        }
        return nombre+" "+apellido;
    }
    
    public static String jornadaToString(Integer jornada) {
        return jornada == 0 ? "Diurno" : "Vespertino";
    }
    
    public static String semestreAnterior(String semestreActual) {
        String a = semestreActual.substring(0, 1);
        String b = semestreActual.substring(2, 6);
        String aux,aux2,semAnt;
        Integer cont;
        if ( "2".equals(a)){
            aux = "1";
            aux2 = b;
            semAnt = aux+"/"+aux2;
        }
        else{
            aux = "2";
            cont = Integer.parseInt(b);
            cont--;
            aux2 = String.valueOf(cont);
            semAnt = aux+"/"+aux2;
        }
        return semAnt;
    }
}
