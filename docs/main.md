## Opis modułu

Moduł umożliwia tworzenie projektu GitLab wraz z konfiguracją:
- ustawienia podstawowych właściwości projektu (nazwa, opis, widoczność, tagi, domyślna gałąź)
- ochrony gałęzi (protected branches)
- ochrony tagów (protected tags)
- zmiennych CI/CD
- mirrorowania projektu
- reguł push (push rules) w tym wymuszanie konwencji Conventional Commits w commit message

---
## Wymagania

- Provider: [gitlabhq/gitlab](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs)
- Uprawnienia do tworzenia projektów w wybranej grupie GitLab

---
## Zmienne wejściowe

| Nazwa                 | Typ                                                                 | Opis                                                                                     | Domyślna wartość                                                                                  |
|-----------------------|---------------------------------------------------------------------|------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| `name`                | string                                                              | Nazwa projektu                                                                           | -                                                                                                |
| `description`         | string                                                              | Opis projektu                                                                            | -                                                                                                |
| `parent_group`        | string                                                              | ID grupy nadrzędnej                                                                      | -                                                                                                |
| `default_branch`      | string                                                              | Domyślna gałąź                                                                           | "" (brak)                                                                                        |
| `tags`                | list(string)                                                        | Lista tagów                                                                             | []                                                                                               |
| `visibility`          | string                                                              | Widoczność projektu (`private`, `internal`, `public`)                                   | `private`                                                                                        |
| `build_git_strategy`  | string                                                              | Strategia pobierania Gita (`clone`, `fetch`)                                            | `clone`                                                                                         |
| `autoclose_referenced_issues` | bool                                                        | Automatyczne zamykanie powiązanych issue                                               | true                                                                                            |
| `icon_type`           | string                                                              | Typ ikony projektu                                                                       | "" (brak)                                                                                        |
| `project_type`        | string                                                              | Typ projektu (określa domyślne tagi i konfiguracje)                                     | "" (brak)                                                                                        |
| `gitlab_ci_path`      | string                                                              | Ścieżka do pliku GitLab CI                                                              | null                                                                                            |
| `protected_branches`  | map(object({push_access_level=string, merge_access_level=string}))  | Konfiguracja chronionych gałęzi                                                         | { "main" = { push_access_level = "no one", merge_access_level = "maintainer" } }                  |
| `protected_tags`      | map(object({create_access_level=string}))                           | Konfiguracja chronionych tagów                                                          | { "v*" = { create_access_level = "maintainer" } }                                               |
| `sonarqube_cloud_project_id` | string                                                        | ID projektu SonarQube Cloud                                                              | ""                                                                                              |
| `is_enabled_sonarqube`| bool                                                                | Włączenie SonarQube                                                                      | true                                                                                           |
| `sonarqube_badges`    | map(bool)                                                           | Konfiguracja odznak SonarQube                                                            | {}                                                                                              |
| `variables`           | map(object({value=string, description=optional(string), protected=optional(bool), masked=optional(bool), environment_scope=optional(string)})) | Zmienne CI/CD                                                                            | {}                                                                                              |
| `mirror_url`          | string                                                              | URL do mirrorowania projektu                                                             | ""                                                                                              |
| `push_rules`          | object                                                             | Reguły push, w tym regex do walidacji commit message (Conventional Commits)              | commit_message_regex: "^(build|chore|ci|docs|feat|fix|perf|refactor|style|test|revert|merge|release|hotfix|fixup|squash|wip|BREAKING CHANGE)(\\(.+\\))?: .+" |

---
## Przykład użycia

```hcl
module "gitlab_project" {
  source = "path_to_module"

  name        = "my-project"
  description = "Przykładowy projekt"
  parent_group = "123456"
  default_branch = "main"
  tags        = ["terraform", "gitlab"]
  visibility  = "private"
  build_git_strategy = "clone"
  autoclose_referenced_issues = true
  icon_type   = "gitlab"
  project_type = "default"
  gitlab_ci_path = null

  protected_branches = {
    "main" = {
      push_access_level  = "no one"
      merge_access_level = "maintainer"
    }
  }

  protected_tags = {
    "v*" = {
      create_access_level = "maintainer"
    }
  }

  variables = {
    "EXAMPLE_VAR" = {
      value       = "example"
      description = "Przykładowa zmienna"
      protected   = false
      masked      = false
      environment_scope = "*"
    }
  }

  mirror_url = ""

  push_rules = {
    commit_message_regex = "^(feat|fix|docs|style|refactor|test|chore)(\\(.+\\))?: .+"
    deny_delete_tag      = true
    member_check         = true
    prevent_secrets      = true
  }
}
```

---
## Uwagi

- Moduł wymaga odpowiednich uprawnień do tworzenia i modyfikacji projektów GitLab.
- Regex w `commit_message_regex` powinien być dostosowany do wymagań projektu.
- Push rules mogą być rozszerzane o dodatkowe opcje zgodnie z dokumentacją GitLab.

---
## Wyjścia

Brak zdefiniowanych wyjść.

---
## Dodatkowe informacje

- Obsługiwane typy projektów i ikon znajdziesz w pliku [`locals.tf`](locals.tf) oraz [`data/allowed_icon_types.json`](data/allowed_icon_types.json).
- Domyślne ustawienia ochrony branchy i tagów możesz nadpisać przez zmienne `protected_branches` i `protected_tags`.
