terraform {
  required_version = ">= 1.12.0"
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 18.0"
    }
  }
}