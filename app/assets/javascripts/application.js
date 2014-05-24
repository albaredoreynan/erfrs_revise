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

    $('.grant').each(function(){
     total_grant += parseFloat($(this).children().first().val());
    });

    $('.lcc').each(function(){
     total_lcc += parseFloat($(this).children().first().val());
    });

    $('.plgu').each(function(){
     total_plgu += parseFloat($(this).children().first().val());
    });

    $('.mlgu').each(function(){
     total_mlgu += parseFloat($(this).children().first().val());
    });

    $('.community').each(function(){
     total_community += parseFloat($(this).children().first().val());
    });
    $('.total_lcc_cash').each(function(){
      total_lcc_cash_val += parseFloat($(this).children().first().val());
    });

    $('.sdc > input').each(function(){
      subtotal_direct += parseFloat($(this).val())
    });
    $('.sic > input').each(function(){
      subtotal_indirect += parseFloat($(this).val())
    });

    $('.scc > input').each(function(){
      subtotal_contingency += parseFloat($(this).val())
    });

    $('.total_lcc_cash').each(function(){
     total_lcc_cash += parseFloat($(this).children().first().val());
    });
    
    $('.total_lcc_in_kind').each(function(){
     total_lcc_in_kind += parseFloat($(this).children().first().val());
    });

    subtotal_total = subtotal_direct + subtotal_indirect + subtotal_contingency;

    total_direct = subtotal_direct + parseFloat($('#subproject_total_lcc_cash_direct_cost').val()) +  parseFloat($('#subproject_total_lcc_in_kind_direct_cost').val());
    total_indirect = subtotal_indirect + parseFloat($('#subproject_total_lcc_cash_indirect_cost').val()) +  parseFloat($('#subproject_total_lcc_in_kind_indirect_cost').val());
    total_contingency = subtotal_contingency + parseFloat($('#subproject_total_lcc_cash_contingency_cost').val()) +  parseFloat($('#subproject_total_lcc_in_kind_contingency_cost').val());
    total_total =  total_direct + total_indirect + total_contingency 

    $('#total_grant').html(total_grant);
    $('#total_plgu').html(total_plgu);
    $('#total_mlgu').html(total_mlgu);
    $('#total_community').html(total_community);
    $('#total_lcc').html(total_lcc);
    
    $('#subtotal_direct').html(subtotal_direct);
    $('#subtotal_indirect').html(subtotal_indirect);
    $('#subtotal_contingency').html(subtotal_contingency);
    $('#subtotal_total').html(subtotal_total);

    $('#total_lcc_cash').html(total_lcc_cash_val)
    $('#total_lcc_in_kind').html(total_lcc_in_kind);
    

    $('#total_direct').html(total_direct);
    $('#total_indirect').html(total_indirect);
    $('#total_contingency').html(total_contingency);
    $('#total_total').html(total_total)

  }


