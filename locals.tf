locals {
  allowed_icon_types    = jsondecode(file("${path.module}/data/allowed_icon_types.json"))
  allowed_project_types = jsondecode(file("${path.module}/data/allowed_project_types.json"))
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
}