## Wymagania

- Provider: [gitlabhq/gitlab](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs)
- Uprawnienia do tworzenia projektów w wybranej grupie GitLab

## Przykład użycia

```hcl
module "gitlab_project" {
  source       = "git@gitlab.com:pl.rachuna-net/infrastructure/terraform/modules/gitlab-project.git?ref=v1.1.1"

  name         = "my-repo"
  description  = "Opis projektu"
  parent_group = "my-group"
  project_type = "terraform-module"
  visibility   = "private"
  tags         = ["terraform", "iac"]

  # Opcjonalnie:
  icon_type    = "terraform"
  default_branch = "main"

  # SonarQube
  sonarqube_cloud_project_id = "123456"
  is_enabled_sonarqube       = true
  sonarqube_badges = {
    sonarqube_quality_gate_status = true
    sonarqube_coverage           = true
  }
}
```

## Zmienne wejściowe

| Nazwa                       | Typ                | Domyślna wartość | Opis |
|-----------------------------|--------------------|------------------|------|
| name                        | string             | brak             | Nazwa projektu |
| description                 | string             | brak             | Opis projektu |
| parent_group                | string             | brak             | Ścieżka grupy nadrzędnej w GitLab |
| default_branch              | string             | ""               | Domyślna gałąź |
| tags                        | list(string)       | []               | Lista tagów projektu |
| visibility                  | string             | "private"        | Widoczność: private, internal, public |
| build_git_strategy          | string             | "clone"          | Strategia pobierania kodu przez GitLab CI |
| autoclose_referenced_issues | bool               | true             | Automatyczne zamykanie powiązanych issue |
| icon_type                   | string             | ""               | Typ ikony projektu (np. terraform, ansible) |
| project_type                | string             | ""               | Typ projektu (np. terraform-module, ansible-role) |
| gitlab_ci_path              | string             | null             | Ścieżka do pliku GitLab CI |
| protected_branches          | map(object)        | patrz kod        | Ochrona branchy |
| protected_tags              | map(object)        | patrz kod        | Ochrona tagów |
| sonarqube_cloud_project_id  | string             | ""               | ID projektu w SonarQube Cloud |
| is_enabled_sonarqube        | bool               | true             | Czy SonarQube jest włączony |
| sonarqube_badges            | map(bool)          | {}               | Wybór odznak SonarQube |

## Wyjścia

Brak zdefiniowanych wyjść.

## Dodatkowe informacje

- Obsługiwane typy projektów i ikon znajdziesz w pliku [`locals.tf`](locals.tf) oraz [`data/allowed_icon_types.json`](data/allowed_icon_types.json).
- Domyślne ustawienia ochrony branchy i tagów możesz nadpisać przez zmienne `protected_branches` i `protected_tags`.
