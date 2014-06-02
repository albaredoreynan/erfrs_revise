// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require cocoon
//= require chosen.jquery
//= require_tree .
  function parseNaN(num) {
    a = $(num).children().first().val();
    if (isNaN(a)) a = 0;
    return a;
  }

  function compute(){
    var total_grant = 0.0;
    var total_lcc = 0.0;
    var total_plgu = 0.0;
    var total_community = 0.0;
    var total_mlgu = 0.0;
    var subtotal_direct = 0.0
    var subtotal_indirect = 0.0;
    var subtotal_contingency = 0.0;
    var subtotal_total = 0.0;
    var total_lcc_in_kind = 0.0;
    var total_direct = 0.0;
    var total_indirect = 0.0;
    var total_contingency = 0.0;
    var total_total = 0.0;
    var total_lcc_cash_val = 0.0; 
    var percent_total_grant = 0.0;
    var percent_total_lcc = 0.0;
    var percent_total_plgu = 0.0;
    var percent_total_mlgu = 0.0;
    var percent_total_community = 0.0;
    var percent_total_lcc_cash_val = 0.0;
    var percent_total_lcc_in_kind = 0.0;

    $('.grant').each(function(){
      total_grant += parseFloat(parseNaN(this));
    });

    $('.lcc').each(function(){
      total_lcc += parseFloat(parseNaN(this));
    });

    $('.plgu').each(function(){
      total_plgu += parseFloat(parseNaN(this));
    });

    $('.mlgu').each(function(){

      total_mlgu += parseFloat(parseNaN(this));
    });

    $('.community').each(function(){
     total_community += parseFloat(parseNaN(this));
    });
    $('.total_lcc_cash').each(function(){
      total_lcc_cash_val += parseFloat(parseNaN(this));
    });

    $('.sdc > input').each(function(){
      a = $(this).val();
      if (isNaN(a)) a = 0;
      subtotal_direct += parseFloat(a);
    });
    $('.sic > input').each(function(){
      a = $(this).val();
      if (isNaN(a)) a = 0;
      subtotal_indirect += parseFloat(a)
    });

    $('.scc > input').each(function(){
      a = $(this).val();
      if (isNaN(a)) a = 0;
      subtotal_contingency += parseFloat(a);
    });

    $('.total_lcc_cash').each(function(){
     total_lcc_cash += parseFloat(parseNaN(this));
    });
    
    $('.total_lcc_in_kind').each(function(){
     total_lcc_in_kind += parseFloat(parseNaN(this));
    });

    subtotal_total = subtotal_direct + subtotal_indirect + subtotal_contingency;

    total_direct = subtotal_direct + parseFloat($('#subproject_total_lcc_cash_direct_cost').val()) +  parseFloat($('#subproject_total_lcc_in_kind_direct_cost').val());
    total_indirect = subtotal_indirect + parseFloat($('#subproject_total_lcc_cash_indirect_cost').val()) +  parseFloat($('#subproject_total_lcc_in_kind_indirect_cost').val());
    total_contingency = subtotal_contingency + parseFloat($('#subproject_total_lcc_cash_contingency_cost').val()) +  parseFloat($('#subproject_total_lcc_in_kind_contingency_cost').val());
    total_total =  total_direct + total_indirect + total_contingency 


    // Percent Formula
    percent_total_grant = (total_grant / total_total) * 100
    percent_total_lcc = (total_lcc / total_total) * 100
    percent_total_plgu =(total_plgu / total_total) * 100
    percent_total_mlgu = (total_mlgu / total_total) * 100
    percent_total_community = (total_community / total_total) * 100
    percent_total_lcc_cash_val = (total_lcc_cash_val / total_total) * 100
    percent_total_lcc_in_kind = (total_lcc_in_kind / total_total) * 100

    $('#total_grant').html(total_grant.toFixed(2));
    $('#total_plgu').html(total_plgu.toFixed(2));
    $('#total_mlgu').html(total_mlgu.toFixed(2));
    $('#total_community').html(total_community.toFixed(2));
    $('#total_lcc').html(total_lcc.toFixed(2));
    
    $('#subtotal_direct').html(subtotal_direct.toFixed(2));
    $('#subtotal_indirect').html(subtotal_indirect.toFixed(2));
    $('#subtotal_contingency').html(subtotal_contingency.toFixed(2));
    $('#subtotal_total').html(subtotal_total.toFixed(2));

    $('#total_lcc_cash').html(total_lcc_cash_val.toFixed(2))
    $('#total_lcc_in_kind').html(total_lcc_in_kind.toFixed(2));

    $('#total_direct').html(total_direct.toFixed(2));
    $('#total_indirect').html(total_indirect.toFixed(2));
    $('#total_contingency').html(total_contingency.toFixed(2));
    $('#total_total').html(total_total.toFixed(2))

    if (total_total != ""){
        $('#percent_grant').html(percent_total_grant.toFixed(2) + "%");
        $('#percent_lcc').html(percent_total_lcc.toFixed(2) + "%" );
        $('#percent_plgu').html(percent_total_plgu.toFixed(2) + "%" );
        $('#percent_community').html(percent_total_community.toFixed(2) + "%");
        $('#percent_mlgu').html(percent_total_mlgu.toFixed(2) + "%");
        $('#percent_lcc_percent').html(percent_total_lcc_cash_val.toFixed(2) + "%");
        $('#percent_lcc_in_kind').html(percent_total_lcc_in_kind.toFixed(2) + "%");
        $('#total_percent').html("100%");
    }
  }


