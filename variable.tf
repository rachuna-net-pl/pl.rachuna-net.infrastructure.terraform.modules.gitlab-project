variable "name" {
  type        = string
  description = "Repository Name"
}

variable "description" {
  type        = string
  description = "Repository Description"
}

variable "parent_group" {
  type        = string
  description = "Parent Group"
}

variable "default_branch" {
  type        = string
  description = "Default branch"
  default     = ""
}

variable "tags" {
  type        = list(string)
  description = "Tags"
  default     = []
}

variable "visibility" {
  type        = string
  default     = "private"
  description = "The project's visibility"

  validation {
    condition = contains([
      "private",
      "internal",
      "public"
    ], var.visibility)
    error_message = "Unsupported project visibility"
  }
}

variable "build_git_strategy" {
  type        = string
  default     = "clone"
  description = "The Git strategy. Defaults to fetch."
}

variable "autoclose_referenced_issues" {
  type        = bool
  default     = true
  description = "Autoclose referenced issues"
}

variable "allowed_avatar_types_json" {
  type        = string
  default     = ""
  description = "Path to allowed avatar types json"
}

variable "avatar" {
  type        = string
  description = "Type of the avatar for the group (default: from type)"
  default     = ""

  validation {
    condition     = contains(local.allowed_avatar_types, var.avatar)
    error_message = "Unsupported group type"
  }
}

variable "allowed_project_types_json" {
  type        = string
  default     = ""
  description = "Path to allowed project types json"
}


variable "project_type" {
  type        = string
  description = "Project type"
  default     = ""

  validation {
    condition     = contains(keys(local.allowed_project_types), var.project_type)
    error_message = "Unsupported project project_type"
  }
}

variable "gitlab_ci_path" {
  type        = string
  description = "Path to the GitLab CI file"
  default     = null
}

variable "protected_branches" {
  type = map(object({
    push_access_level  = string
    merge_access_level = string
  }))
  default = {
    "develop" = {
      push_access_level  = "no one"
      merge_access_level = "maintainer"
    }
    "main" = {
      push_access_level  = "no one"
      merge_access_level = "maintainer"
    }
  }
}

variable "labels" {
  type = map(object({
    description = string
    color       = string
  }))
  default = {}
}

variable "protected_tags" {
  type = map(object({
    create_access_level = string
  }))
  description = "Protected tags"
  default = {
    "v*" = {
      create_access_level = "maintainer"
    }
  }
}

## SonarQube
variable "sonarqube_cloud_project_id" {
  type        = string
  default     = ""
  description = "SonarQube Cloud Project ID"
}

variable "is_enabled_sonarqube" {
  type        = bool
  default     = true
  description = "Is SonarQube enabled"
}

variable "sonarqube_badges" {
  type    = map(bool)
  default = {}

  validation {
    condition = alltrue([
      for k in keys(var.sonarqube_badges) : contains([
        "sonarqube_quality_gate_status",
        "sonarqube_bugs",
        "sonarqube_code_smells",
        "sonarqube_coverage",
        "sonarqube_duplicated_lines_density",
        "sonarqube_lines_of_code",
        "sonarqube_reliability_rating",
        "sonarqube_security_rating",
        "sonarqube_technical_debt",
        "sonarqube_maintainability_rating",
        "sonarqube_vulnerabilities"
      ], k)
    ])
    error_message = "Invalid key found in sonarqube_badges. Allowed keys: sonarqube_quality_gate_status, sonarqube_bugs, sonarqube_code_smells, sonarqube_coverage, sonarqube_duplicated_lines_density, sonarqube_lines_of_code, sonarqube_reliability_rating, sonarqube_security_rating, sonarqube_technical_debt, sonarqube_maintainability_rating, sonarqube_vulnerabilities."
  }
}

variable "variables" {
  type = map(object({
    value             = string
    description       = optional(string)
    protected         = optional(bool)
    masked            = optional(bool)
    environment_scope = optional(string)
  }))
  default = {}
}

variable "mirror_url" {
  type        = string
  description = "URL for the project mirror"
  default     = ""
}

variable "is_gitlab_free" {
  type        = bool
  default     = true
  description = "Is the project a free tier project"
}

variable "is_enable_conventional_commits_push_rule" {
  type        = bool
  default     = false
  description = "Enable conventional commits push rule"

}

variable "archived" {
  type        = bool
  default     = false
  description = "Whether the GitLab project should be archived"
}

variable "avatars_dir" {
  description = "Avatars directory png files"
  type        = string
  default     = ""
}

variable "only_allow_merge_if_pipeline_succeeds" {
  description = "Set to true if you want allow merges only if a pipeline succeeds."
  type        = bool
  default     = true
}

variable "allow_merge_on_skipped_pipeline" {
  description = "Set to true if you want to treat skipped pipelines as if they finished with success."
  type        = bool
  default     = false
}