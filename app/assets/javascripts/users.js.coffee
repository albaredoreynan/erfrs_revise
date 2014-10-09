$ ->
	role = $("#user_role_id")
	role.change ->
	  role_text = $("option:selected", this).text()
	  if role_text is "Admin"
	    $(".show_off").show()
	  else
	    $(".show_off").hide()
	    $(".regional").show()  if role_text is "National" or role_text is "Regional"
	    if role_text is "Sub Regional"
	      $(".regional").show()
	      $(".provinces").show()
	    if role_text is "Municipal"
	      $(".regional").show()
	      $(".provinces").show()
	      $(".municipalities").show()
	    if role_text is "Barangay" or role_text is "Public"
	      $(".regional").show()
	      $(".provinces").show()
	      $(".municipalities").show()
	      $(".barangays").show()
	  return
	
