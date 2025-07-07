## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | ~> 18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | ~> 18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [gitlab_branch_protection.protected_branches](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/branch_protection) | resource |
| [gitlab_project.project](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project) | resource |
| [gitlab_project_badge.sonarqube_badge](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_badge) | resource |
| [gitlab_project_label.label](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_label) | resource |
| [gitlab_project_mirror.mirror](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_mirror) | resource |
| [gitlab_project_push_rules.push_rule](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_push_rules) | resource |
| [gitlab_project_variable.variable](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_variable) | resource |
| [gitlab_tag_protection.protected_tags](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/tag_protection) | resource |
| [gitlab_group.parent](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/data-sources/group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_archived"></a> [archived](#input\_archived) | Whether the GitLab project should be archived | `bool` | `false` | no |
| <a name="input_autoclose_referenced_issues"></a> [autoclose\_referenced\_issues](#input\_autoclose\_referenced\_issues) | Autoclose referenced issues | `bool` | `true` | no |
| <a name="input_build_git_strategy"></a> [build\_git\_strategy](#input\_build\_git\_strategy) | The Git strategy. Defaults to fetch. | `string` | `"clone"` | no |
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | Default branch | `string` | `""` | no |
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | n/a | yes |
| <a name="input_gitlab_ci_path"></a> [gitlab\_ci\_path](#input\_gitlab\_ci\_path) | Path to the GitLab CI file | `string` | `null` | no |
| <a name="input_avatar_type"></a> [avatar\_type](#input\_avatar\_type) | Type of the avatar for the group (default: from type) | `string` | `""` | no |
| <a name="input_is_enable_conventional_commits_push_rule"></a> [is\_enable\_conventional\_commits\_push\_rule](#input\_is\_enable\_conventional\_commits\_push\_rule) | Enable conventional commits push rule | `bool` | `false` | no |
| <a name="input_is_enabled_sonarqube"></a> [is\_enabled\_sonarqube](#input\_is\_enabled\_sonarqube) | Is SonarQube enabled | `bool` | `true` | no |
| <a name="input_is_gitlab_free"></a> [is\_gitlab\_free](#input\_is\_gitlab\_free) | Is the project a free tier project | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | <pre>map(object({<br/>    description = string<br/>    color       = string<br/>  }))</pre> | `{}` | no |
| <a name="input_mirror_url"></a> [mirror\_url](#input\_mirror\_url) | URL for the project mirror | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_parent_group"></a> [parent\_group](#input\_parent\_group) | n/a | `string` | n/a | yes |
| <a name="input_project_type"></a> [project\_type](#input\_project\_type) | Project type | `string` | `""` | no |
| <a name="input_protected_branches"></a> [protected\_branches](#input\_protected\_branches) | n/a | <pre>map(object({<br/>    push_access_level  = string<br/>    merge_access_level = string<br/>  }))</pre> | <pre>{<br/>  "develop": {<br/>    "merge_access_level": "maintainer",<br/>    "push_access_level": "no one"<br/>  },<br/>  "main": {<br/>    "merge_access_level": "maintainer",<br/>    "push_access_level": "no one"<br/>  }<br/>}</pre> | no |
| <a name="input_protected_tags"></a> [protected\_tags](#input\_protected\_tags) | Protected tags | <pre>map(object({<br/>    create_access_level = string<br/>  }))</pre> | <pre>{<br/>  "v*": {<br/>    "create_access_level": "maintainer"<br/>  }<br/>}</pre> | no |
| <a name="input_sonarqube_badges"></a> [sonarqube\_badges](#input\_sonarqube\_badges) | n/a | `map(bool)` | `{}` | no |
| <a name="input_sonarqube_cloud_project_id"></a> [sonarqube\_cloud\_project\_id](#input\_sonarqube\_cloud\_project\_id) | SonarQube Cloud Project ID | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `list(string)` | `[]` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | n/a | <pre>map(object({<br/>    value             = string<br/>    description       = optional(string)<br/>    protected         = optional(bool)<br/>    masked            = optional(bool)<br/>    environment_scope = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | The project's visibility | `string` | `"private"` | no |

## Outputs

No outputs.
