$ ->
  regions        = $('#subproject_region_id')
  provinces      = $('#subproject_province_id')
  municipalities = $('#subproject_municipality_id')
  barangays      = $('#subproject_barangay_id')

  provinces.attr('readonly', 'readonly')
  municipalities.attr('readonly', 'readonly')
  barangays.attr('readonly', 'readonly')

  fetch_province = (region_id)->
    url = "/provinces.json?region_id=" + region_id
    $.get url, (data)->
      provinces.empty().attr('disabled', false)
      municipalities.empty().attr('disabled','disabled')
      barangays.empty().attr('disabled', 'disabled')
      provinces.append('<option value></option>')
      $.each data, ->
        provinces.append($('<option></option>').attr('value', this.id).text(this.name))

  fetch_municipalities = (province_id)->
    url = "/municipalities.json?province_id=" + province_id
    $.get url, (data)->
      municipalities.empty().attr('disabled', false)
      barangays.empty().attr('disabled', 'disabled')
      municipalities.append('<option value></option>')
      $.each data, ->
        municipalities.append($('<option></option>').attr('value', this.id).text(this.name))

  fetch_barangays = (municipality_id)->
    url = "/barangays.json?municipality_id=" + municipality_id
    $.get url, (data)->
      barangays.empty().attr('disabled', false)
      barangays.append('<option value></option>')
      $.each data, ->
        barangays.append($('<option></option>').attr('value', this.id).text(this.name))

  regions.change ->
    rid = $(this).val()
    fetch_province(rid)

  provinces.change ->
    pid = $(this).val()
    fetch_municipalities(pid)

  municipalities.change ->
    mid = $(this).val()
    fetch_barangays(mid)

  retrieve_province = (region_id)->
    url = "/provinces.json?region_id=" + region_id
    $.get url, (data)->
      provinces.append('<option value></option>')
      $.each data, ->
        provinces.append($('<option></option>').attr('value', this.id).text(this.name))

  retrieve_municipalities = (province_id)->
    url = "/municipalities.json?province_id=" + province_id
    $.get url, (data)->
      municipalities.append('<option value></option>')
      $.each data, ->
        municipalities.append($('<option></option>').attr('value', this.id).text(this.name))

  retrieve_barangays = (municipality_id)->
    url = "/barangays.json?municipality_id=" + municipality_id
    $.get url, (data)->
      barangays.append('<option value></option>')
      $.each data, ->
        barangays.append($('<option></option>').attr('value', this.id).text(this.name))

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

