/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Util;

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
}
