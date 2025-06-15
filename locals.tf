locals {
  allowed_icon_types    = jsondecode(file("${path.module}/data/allowed_icon_types.json"))
  allowed_project_types = jsondecode(file("${path.module}/data/allowed_project_types.json"))
  sonarqube_badges      = jsondecode(file("${path.module}/data/sonarqube_badges.json"))


  final_enabled_badges = merge(local.allowed_project_types[var.project_type].sonarqube, var.sonarqube_badges)
  selected_badges = var.sonarqube_cloud_project_id != "" ? ({
    for k, v in local.sonarqube_badges : k => v
    if try(local.final_enabled_badges[k], false) == true }
  ) : {}
}