$ = jQuery;
$(document).ready(function() {

    if ( $( '#formulario\\:tipoContrato' ).val() === '1'){ // j completa
        $( '#formulario\\:optionsPPH' ).hide();
    } else if ( $( '#formulario\\:tipoContrato' ).val() === '0') { // profe externo (por hora)
        $( '#formulario\\:optionsPJC' ).hide();
    }
});

function showPanel(){
    var $element = $("select[name='formulario:tipo1_input'] option:selected").val();
    if ( $element === '1') { //seminario
        //console.log("1");
        $( '#formulario\\:panelSeminario' ).show();
        $( '#formulario\\:panelSecretaria' ).hide();
    } else if ( $element === '0' ) { //secretaria
        //console.log("0");
        $( '#formulario\\:panelSeminario' ).hide();
        $( '#formulario\\:panelSecretaria' ).show();
    } else {
        //console.log("nada");
        
    }
    
    var $element2 = $("select[name='formulario:tipo2_input'] option:selected").val();
    if($element2 === '3'){
        $( '#formulario\\:panelConsejo' ).hide();
        $( '#formulario\\:panelSeminario' ).hide();
        $( '#formulario\\:panelSecretaria' ).hide();
        $( '#formulario\\:panelMagister' ).show();       
    } else if ( $element2 === '2' ){ // consejo
        //console.log("2");
        $( '#formulario\\:panelConsejo' ).show();
        $( '#formulario\\:panelSeminario' ).hide();
        $( '#formulario\\:panelSecretaria' ).hide();
        $( '#formulario\\:panelMagister' ).hide(); 
    } else if ( $element2 === '1') { //seminario
        //console.log("1");
        $( '#formulario\\:panelConsejo' ).hide();
        $( '#formulario\\:panelSeminario' ).show();
        $( '#formulario\\:panelSecretaria' ).hide();
        $( '#formulario\\:panelMagister' ).hide(); 
    } else if ( $element2 === '0' ) { //secretaria
        //console.log("0");
        $( '#formulario\\:panelConsejo' ).hide();
        $( '#formulario\\:panelSeminario' ).hide();
        $( '#formulario\\:panelSecretaria' ).show();
        $( '#formulario\\:panelMagister' ).hide(); 
    } else {
        //console.log("nada");

    }
}