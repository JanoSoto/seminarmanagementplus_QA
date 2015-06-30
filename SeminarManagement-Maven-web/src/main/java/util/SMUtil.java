package util;

import entities.PlanEstudio;
import entities.Versionplan;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import sessionbeans.PlanestudioFacadeLocal;
import sessionbeans.VersionplanFacadeLocal;

/**
 *
 * @author giovanni
 */
public class SMUtil {

    @EJB
    PlanestudioFacadeLocal planesFacade;

    @EJB
    VersionplanFacadeLocal versionFacade;

    public static String formatearRut(String rut) {
//        rut = rut.replaceAll("[^0-9]+", " ");
        int cont = 0;
        String format;
        rut = rut.replace(".", "");
        rut = rut.replace("-", "");
        format = "-" + rut.substring(rut.length() - 1);
        for (int i = rut.length() - 2; i >= 0; i--) {
            format = rut.substring(i, i + 1) + format;
            cont++;
            if (cont == 3 && i != 0) {
                format = "." + format;
                cont = 0;
            }
        }
        return format;
    }

    public static String reducirNombre(String nombre, String apellido, Integer maxChars) {
        while (nombre.length() + apellido.length() > maxChars) {
            String nombres[] = nombre.split(" ");
            String apellidos[] = apellido.split(" ");
            if (nombres.length >= apellidos.length && !nombres[0].contentEquals("")) {
                if (nombres.length > 1) {
                    nombre = nombre.substring(0, nombre.lastIndexOf(" "));
                } else {
                    break;
                }
            } else {
                if (apellidos.length > 1) {
                    apellido = apellido.substring(0, apellido.lastIndexOf(" "));
                } else {
                    break;
                }
            }
        }
        return nombre + " " + apellido;
    }

    public static String jornadaToString(Integer jornada) {
        return jornada == 0 ? "Diurno" : "Vespertino";
    }

    public static String semestreAnterior(String semestreActual) {
        String a = semestreActual.substring(0, 1);
        String b = semestreActual.substring(2, 6);
        String aux, aux2, semAnt;
        Integer cont;
        if ("2".equals(a)) {
            aux = "1";
            aux2 = b;
            semAnt = aux + "/" + aux2;
        } else {
            aux = "2";
            cont = Integer.parseInt(b);
            cont--;
            aux2 = String.valueOf(cont);
            semAnt = aux + "/" + aux2;
        }
        return semAnt;
    }

    //Manejos de fechas
    public static String dateToString(Date dateChoosen) {
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(dateChoosen);
    }

    public static Date stringToDate(String dateChoosen) {
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        try {
            Date date = formatter.parse(dateChoosen);
            return date;
        } catch (ParseException e) {
            return null;
        }
    }

    public static XSSFWorkbook csvTextToExcel(String csvContent) throws IOException {
        XSSFWorkbook workBook = new XSSFWorkbook();
        XSSFSheet sheet = workBook.createSheet("Hoja 1");
        String currentLine;
        int RowNum = 0;

        BufferedReader br = new BufferedReader(new StringReader(csvContent));
        while ((currentLine = br.readLine()) != null) {
            String str[] = currentLine.split("\t");
            XSSFRow currentRow = sheet.createRow(RowNum);
            for (int i = 0; i < str.length; i++) {
                currentRow.createCell(i).setCellValue(str[i]);
                sheet.autoSizeColumn(i);
            }
            RowNum++;
        }
        return workBook;
    }

    public String getAnioPlan(Integer id_plan, Integer version_plan) {
        
        if (id_plan == null || version_plan == null) {
            return "malo";
        }

        PlanEstudio plan = planesFacade.findById(id_plan);

        for (Versionplan version : plan.getVersionplanList()) {
            
            if (version.getVersion() == Long.parseLong(version_plan + "")) {
                return version.getAnio().toString();
            }
        }

        return "";
    }

    public String getAnioPlanFormateado(Integer id_plan, Integer version_plan) {
        
        if (id_plan == null || version_plan == null) {
            return null;
        }

        PlanEstudio plan = planesFacade.findById(id_plan);
        
        for (Versionplan version : plan.getVersionplanList()) {
            if (version.getVersion() == Long.parseLong(version_plan + "")) {
                
                return plan.getCodigo() + " " + version.getAnio().toString() + "." + version_plan + " " + plan.getCarreraId().getNombre();
            }
        }

        return null;
    }
}
