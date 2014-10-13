$ ->
  direct_cost = $('#subproject_grant_amount_direct_cost')
  indirect_cost = $('#subproject_grant_amount_indirect_cost')
  contingency_cost = $('#subproject_grant_amount_contingency_cost')
  subproject_status = $('#subproject_status')
  
  if($("#edit_subproject").length > 0 && subproject_status.val() == 'Final')
    direct_cost.attr('readonly','readonly')
    indirect_cost.attr('readonly','readonly')
    contingency_cost.attr('readonly','readonly')
	