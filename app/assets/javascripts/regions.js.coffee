$ ->
  regions           = $('#subproject_region_id')
  provinces         = $('#subproject_province_id')
  municipalities    = $('#subproject_municipality_id')
  barangays         = $('#subproject_barangay_id')
  regional_officers = $("#regional_officers")

  provinces.attr('readonly', 'readonly')
  municipalities.attr('readonly', 'readonly')
  barangays.attr('readonly', 'readonly')
  
  fetch_province = (region_id)->
    url = "/provinces.json?region_id=" + region_id
    $.get url, (data)->
      provinces.empty().attr('disabled', false).removeAttr('readonly')
      municipalities.empty().attr('disabled','disabled')
      barangays.empty().attr('disabled', 'disabled')
      provinces.append('<option value></option>')
      $.each data, ->
        provinces.append($('<option></option>').attr('value', this.id).text(this.name))

  fetch_municipalities = (province_id)->
    url = "/municipalities.json?province_id=" + province_id
    $.get url, (data)->
      municipalities.empty().attr('disabled', false).removeAttr('readonly')
      barangays.empty().attr('disabled', 'disabled')
      municipalities.append('<option value></option>')
      $.each data, ->
        municipalities.append($('<option></option>').attr('value', this.id).text(this.name))

  fetch_barangays = (municipality_id)->
    url = "/barangays.json?municipality_id=" + municipality_id
    $.get url, (data)->
      barangays.empty().attr('disabled', false).removeAttr('readonly')
      barangays.append('<option value></option>')
      $.each data, ->
        barangays.append($('<option></option>').attr('value', this.id).text(this.name))

  regions.change ->
    rid = $(this).val()
    if rid isnt ''
      fetch_province(rid)
    else
      $("#subproject_province_id").empty()   

  provinces.change ->
    pid = $(this).val()
    if pid isnt ''
      fetch_municipalities(pid)
    else
      $("#subproject_municipality_id").empty()   

  municipalities.change ->
    mid = $(this).val()
    if mid isnt ''
      fetch_barangays(mid)
    else
      $("#subproject_barangay_id").empty() 
  
  retrieve_region = (region_id) ->
    $('#subproject_province_id').val(region_id) 
 
  retrieve_province = (region_id)->
    url = "/provinces.json?region_id=" + region_id
    $.get url, (data)->
      provinces.append('<option value></option>')
      $.each data, ->
        provinces.append($('<option></option>').attr('value', this.id).text(this.name))
      spi = $.urlParam('subproject_province_id') || $.urlParam('province_id')
      if spi isnt `undefined` and spi isnt '' and $("#edit_subproject").length == 0
        $('#subproject_province_id').val(spi) 
        retrieve_municipalities(spi)

  retrieve_municipalities = (province_id)->
    url = "/municipalities.json?province_id=" + province_id
    $.get url, (data)->
      municipalities.append('<option value></option>')
      $.each data, ->
        municipalities.append($('<option></option>').attr('value', this.id).text(this.name))
      smi = $.urlParam('subproject_municipality_id') || $.urlParam('municipality_id')
      if smi isnt `undefined` and smi isnt '' and $("#edit_subproject").length == 0 
        $('#subproject_municipality_id').val(smi)
        retrieve_barangays(smi)

  retrieve_barangays = (municipality_id)->
    url = "/barangays.json?municipality_id=" + municipality_id
    $.get url, (data)->
      barangays.append('<option value></option>')
      $.each data, ->
        barangays.append($('<option></option>').attr('value', this.id).text(this.name))
      sbi = $.urlParam('subproject_barangay_id') || $.urlParam('barangay_id')   
      if sbi isnt `undefined` and sbi isnt '' and $("#edit_subproject").length == 0 
        $('#subproject_barangay_id').val(sbi)

  regional_officers.on 'change', ->
    region_id = regional_officers.val()
    url = '/regional_officers/?region_id='+region_id
    window.location.href = url

  $(document).ready ->
    if (regions.val() != '')
      rid = $(regions).val()
      retrieve_province(rid)

    if (provinces.val() != '')
      pid = $(provinces).val()
      retrieve_municipalities(pid)

    if (municipalities.val() != '')
      mid = $(municipalities).val()
      retrieve_barangays(mid)
  

