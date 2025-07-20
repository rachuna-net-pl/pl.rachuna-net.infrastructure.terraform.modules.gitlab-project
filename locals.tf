locals {
  avatars_dir = var.avatars_dir == "" ? "${path.root}/images/project" : var.avatars_dir

  allowed_avatar_types_json = var.allowed_avatar_types_json == "" ? "${path.root}/data/allowed_avatar_project_types.json" : var.allowed_avatar_types_json
  allowed_avatar_types      = jsondecode(file(local.allowed_avatar_types_json))


  allowed_project_types_json = var.allowed_avatar_types_json == "" ? "${path.root}/data/allowed_project_types.json" : var.allowed_project_types_json
  allowed_project_types      = jsondecode(try(file(local.allowed_project_types_json), null) == null ? file("${path.module}/data/allowed_project_types.json") : file(local.allowed_project_types_json))

  # Define the allowed project types as a map
  avatar_project = local.allowed_project_types[var.project_type].avatar == "" ? null : "${local.avatars_dir}/${local.allowed_project_types[var.project_type].avatar}.png"
  avatar_path    = var.avatar == "" ? local.avatar_project : "${local.avatars_dir}/${var.avatar}.png"
  avatar         = try(file(local.avatar_path), null) == null ? local.avatar_path : null

  sonarqube_badges = {
    "sonarqube_quality_gate_status" : {
      "link_url" : "https://sonarcloud.io/summary/new_code?id=${var.sonarqube_cloud_project_id}",
      "image_url" : "https://sonarcloud.io/api/project_badges/measure?project=${var.sonarqube_cloud_project_id}&metric=alert_status"
    },
    "sonarqube_bugs" : {
      "link_url" : "https://sonarcloud.io/summary/new_code?id=${var.sonarqube_cloud_project_id}",
      "image_url" : "https://sonarcloud.io/api/project_badges/measure?project=${var.sonarqube_cloud_project_id}&metric=bugs"
    },
    "sonarqube_code_smells" : {
      "link_url" : "https://sonarcloud.io/summary/new_code?id=${var.sonarqube_cloud_project_id}",
      "image_url" : "https://sonarcloud.io/api/project_badges/measure?project=${var.sonarqube_cloud_project_id}&metric=code_smells"
    },
    "sonarqube_coverage" : {
      "link_url" : "https://sonarcloud.io/summary/new_code?id=${var.sonarqube_cloud_project_id}",
      "image_url" : "https://sonarcloud.io/api/project_badges/measure?project=${var.sonarqube_cloud_project_id}&metric=coverage"
    },
    "sonarqube_duplicated_lines_density" : {
      "link_url" : "https://sonarcloud.io/summary/new_code?id=${var.sonarqube_cloud_project_id}",
      "image_url" : "https://sonarcloud.io/api/project_badges/measure?project=${var.sonarqube_cloud_project_id}&metric=duplicated_lines_density"
    },
    "sonarqube_lines_of_code" : {
      "link_url" : "https://sonarcloud.io/summary/new_code?id=${var.sonarqube_cloud_project_id}",
      "image_url" : "https://sonarcloud.io/api/project_badges/measure?project=${var.sonarqube_cloud_project_id}&metric=ncloc"
    },
    "sonarqube_reliability_rating" : {
      "link_url" : "https://sonarcloud.io/summary/new_code?id=${var.sonarqube_cloud_project_id}",
      "image_url" : "https://sonarcloud.io/api/project_badges/measure?project=${var.sonarqube_cloud_project_id}&metric=reliability_rating"
    },
    "sonarqube_security_rating" : {
      "link_url" : "https://sonarcloud.io/summary/new_code?id=${var.sonarqube_cloud_project_id}",
      "image_url" : "https://sonarcloud.io/api/project_badges/measure?project=${var.sonarqube_cloud_project_id}&metric=security_rating"
    },
    "sonarqube_technical_debt" : {
      "link_url" : "https://sonarcloud.io/summary/new_code?id=${var.sonarqube_cloud_project_id}",
      "image_url" : "https://sonarcloud.io/api/project_badges/measure?project=${var.sonarqube_cloud_project_id}&metric=sqale_index"
    },
    "sonarqube_maintainability_rating" : {
      "link_url" : "https://sonarcloud.io/summary/new_code?id=${var.sonarqube_cloud_project_id}",
      "image_url" : "https://sonarcloud.io/api/project_badges/measure?project=${var.sonarqube_cloud_project_id}&metric=sqale_rating"
    },
    "sonarqube_vulnerabilities" : {
      "link_url" : "https://sonarcloud.io/summary/new_code?id=${var.sonarqube_cloud_project_id}",
      "image_url" : "https://sonarcloud.io/api/project_badges/measure?project=${var.sonarqube_cloud_project_id}&metric=vulnerabilities"
    }
  }


  final_enabled_badges = merge(local.allowed_project_types[var.project_type].sonarqube, var.sonarqube_badges)
  selected_badges = var.sonarqube_cloud_project_id != "" ? ({
    for k, v in local.sonarqube_badges : k => v
    if try(local.final_enabled_badges[k], false) == true }
  ) : {}

  merged_project_variables = merge(
    local.allowed_project_types[var.project_type].ci_variables,
    var.variables,
    {
      PROJECT_TYPE = {
        value             = var.project_type
        description       = "Project Type"
        protected         = false
        masked            = false
        environment_scope = "*"
      },
      IS_ENABLED_SONARQUBE = {
        value             = var.is_enabled_sonarqube
        description       = "SonarQube enabled flag"
        protected         = false
        masked            = false
        environment_scope = "*"
      }
    },
    var.sonarqube_cloud_project_id != "" ? {
      SONARQUBE_CLOUD_PROJECT_ID = {
        value             = var.sonarqube_cloud_project_id
        description       = "SonarQube Cloud Project ID"
        protected         = false
        masked            = false
        environment_scope = "*"
      }
    } : {}
  )
}