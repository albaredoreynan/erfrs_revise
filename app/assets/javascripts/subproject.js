$(function() {
	$('#subproject_first_tranch_date_required').blur(function(){
		if( Date.parse($('#subproject_date_of_mibf').val()) > Date.parse($('#subproject_first_tranch_date_required').val())){
	  	alert("The date of First tranche is not later than the date of MIBF specified above");
		}	
	});
	$(".monetary_field").focus(function(){ if ( $(this).val() == 0 ) {  $(this).val(''); }  });
});
