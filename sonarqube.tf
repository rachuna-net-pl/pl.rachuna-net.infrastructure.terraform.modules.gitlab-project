resource "gitlab_project_variable" "ci_variable_sonarqube_cloud_project_id" {
  count = var.sonarqube_cloud_project_id != "" ? 1 : 0

  project     = gitlab_project.project.id
  key         = "SONARQUBE_CLOUD_PROJECT_ID"
  value       = var.sonarqube_cloud_project_id
  protected   = false
  masked      = false
  description = "SonarQube Cloud Project ID"
}

resource "gitlab_project_variable" "ci_variable_is_enabled_sonarqube" {
  project     = gitlab_project.project.id
  key         = "IS_ENABLED_SONARQUBE"
  value       = var.sonarqube_cloud_project_id == "" ? "false" : var.is_enabled_sonarqube
  protected   = false
  masked      = false
  description = "SonarQube Cloud Project ID"
}

resource "gitlab_project_badge" "sonarqube_badge" {
  for_each = local.selected_badges

  project   = gitlab_project.project.id
  link_url  = each.value.link_url
  image_url = each.value.image_url
  name      = each.key
}