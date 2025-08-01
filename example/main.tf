
module "docs" {
  source = "git@gitlab.com:pl.rachuna-net/infrastructure/terraform/modules/gitlab-project.git?ref=v2.1.0"

  name               = "docs"
  archived           = false
  description        = "Dokumentacja projektu pl.rachuna-net"
  visibility         = "public"
  tags               = ["documentation", "mkdocs"]
  avatar             = "docs"
  parent_group       = local.parent_name
  project_type       = "docs"
  default_branch     = "main"
  build_git_strategy = "clone"
  gitlab_ci_path     = "mkdocs/pages.yml@pl.rachuna-net/cicd/gitlab-ci"

  # sonarqube
  is_enabled_sonarqube = false

  # mirror to github
  mirror_url = format(
    "https://%s:%s@github.com/%s/%s.git",
    data.vault_kv_secret_v2.github.data["owner"],
    data.vault_kv_secret_v2.github.data["token"],
    data.vault_kv_secret_v2.github.data["owner"],
    "pl.rachuna-net.docs"
  )


  variables = {
  }

  protected_branches = {
    main = {
      push_access_level  = "no one"
      merge_access_level = "maintainer"
    }
  }

  protected_tags = {
    "v*" = {
      create_access_level = "maintainer"
    }
  }
}