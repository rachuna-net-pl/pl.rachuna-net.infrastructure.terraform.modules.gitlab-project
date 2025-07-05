resource "gitlab_project" "project" {
  name                        = var.name
  description                 = var.description
  namespace_id                = data.gitlab_group.parent.id
  initialize_with_readme      = true
  default_branch              = var.default_branch == "" ? null : var.default_branch
  tags                        = toset(concat(local.allowed_project_types[var.project_type].tags, var.tags))
  ci_config_path              = var.gitlab_ci_path == null ? local.allowed_project_types[var.project_type].gitlab_ci_path : var.gitlab_ci_path
  visibility_level            = var.visibility
  build_git_strategy          = var.build_git_strategy
  autoclose_referenced_issues = var.autoclose_referenced_issues
  avatar                      = var.icon_type != "" ? "${path.module}/images/${var.icon_type}.png" : (local.allowed_project_types[var.project_type].icon_type != "" ? "${path.module}/images/${local.allowed_project_types[var.project_type].icon_type}.png" : null)
  avatar_hash                 = var.icon_type != "" ? filesha256("${path.module}/images/${var.icon_type}.png") : (local.allowed_project_types[var.project_type].icon_type != "" ? filesha256("${path.module}/images/${local.allowed_project_types[var.project_type].icon_type}.png") : null)

  archived = var.archived

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [archived]
  }
}

resource "gitlab_project_push_rules" "push_rule" {
  count   = var.is_enable_conventional_commits_push_rule == true ? 1 : 0
  project = gitlab_project.project.id

  commit_message_regex = "^(build|chore|ci|docs|params|feat|fix|perf|refactor|style|test|revert|merge|release|hotfix|fixup|squash|wip|BREAKING CHANGE)(\\(.+\\))?: .+"
}

## Protected Branches
resource "gitlab_branch_protection" "protected_branches" {
  for_each = var.protected_branches

  project            = gitlab_project.project.id
  branch             = each.key
  push_access_level  = each.value.push_access_level
  merge_access_level = each.value.merge_access_level
}

## Protected Tags
resource "gitlab_tag_protection" "protected_tags" {
  for_each = var.protected_tags

  project             = gitlab_project.project.id
  tag                 = each.key
  create_access_level = each.value.create_access_level
}


resource "gitlab_project_variable" "variable" {
  for_each = local.merged_project_variables

  project           = gitlab_project.project.id
  key               = each.key
  value             = each.value.value
  description       = lookup(each.value, "description", null)
  protected         = lookup(each.value, "protected", false)
  masked            = lookup(each.value, "masked", false)
  environment_scope = lookup(each.value, "environment_scope", "*")
}

resource "gitlab_project_mirror" "mirror" {
  count   = var.mirror_url != "" ? 1 : 0
  project = gitlab_project.project.id
  url     = var.mirror_url
}

resource "gitlab_project_badge" "sonarqube_badge" {
  for_each = local.selected_badges

  project   = gitlab_project.project.id
  link_url  = each.value.link_url
  image_url = each.value.image_url
  name      = each.key
}