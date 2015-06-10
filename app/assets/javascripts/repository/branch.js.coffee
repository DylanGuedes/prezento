class Repository.Branch
  @toggle: ->
    scm_type_field = document.getElementById("repository_scm_type")
    index = scm_type_field.selectedIndex
    option = scm_type_field.options[index]

    if option.value != "SVN"
      $("#branches").show()
      fetch_branches (document.getElementById("repository_address"))
    else
      $("#branches").hide()