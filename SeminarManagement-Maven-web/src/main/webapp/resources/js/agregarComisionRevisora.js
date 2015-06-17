$ = jQuery;
$(document).ready(function() {

    if ( $( '#formulario\\:tipoContrato' ).val() === '1'){ // j completa
        // oculta opcion trabajo de titulo (secretaria)
        //console.log('ocultando secre');
        $( '#formulario\\:optionsPPH' ).hide();
        //jQuery( '#formulario\\:tipo_input' ).children( 'option[value="0"]').hide();
    } else if ( $( '#formulario\\:tipoContrato' ).val() === '0') { // profe externo (por hora)
        // oculta opcion tipo
        //console.log('ocultando consejo');
        //jQuery( '#formulario\\:tipo_input' ).children( 'option[value="2"]').css('display','none');
        $( '#formulario\\:optionsPJC' ).hide();
    }
});

function showPanel(){
    var $element = $("select[name='formulario:tipo1_input'] option:selected").val();
    //console.log('tipo: ' + $( '#formulario\\:tipoContrato' ).val() );
    //alert($element);
    if ( $element === '2' ){
        $( '#formulario\\:panelConsejo' ).show();
        $( '#formulario\\:panelProfes' ).hide();
        //console.log('2');
    } else {
        $( '#formulario\\:panelConsejo' ).hide();
        $( '#formulario\\:panelProfes' ).show();
        //console.log('1');
    } 
    
    var $element2 = $("select[name='formulario:tipo2_input'] option:selected").val();
    //console.log('tipo: ' + $( '#formulario\\:tipoContrato' ).val() );
    //alert($element);
    if ( $element2 === '2' ){
        $( '#formulario\\:panelConsejo' ).show();
        $( '#formulario\\:panelProfes' ).hide();
        //console.log('2');
    } else {
        $( '#formulario\\:panelConsejo' ).hide();
        $( '#formulario\\:panelProfes' ).show();
        //console.log('1');
    } 
}