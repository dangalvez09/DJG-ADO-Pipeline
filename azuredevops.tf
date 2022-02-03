#Create Azure Devops Resources
provider "azuredevops" {
  org_service_url = var.ado_org_service_url
}

# Manages a project within Azure DevOps
resource "azuredevops_project" "project" {
  name               = "${local.ado_project_name}-project-{local.ado_test}"
  description        = local.ado_project_description
  visibility         = local.ado_project_visibility
  version_control    = "Git"
  work_item_template = "Agile"

  features = {
    "testplans"    = "enabled"
    "artifacts"    = "enabled"
    "boards"       = "enabled"
    "repositories" = "enabled"
    "pipelines"    = "enabled"
  }
}

# Creates git repository in Azure DevOps
resource "azuredevops_git_repository" "repo" {
  project_id = azuredevops_project.project.id
  name       = var.ado_repo_name
  initialization {
    init_type = "Clean"
  }
}

# Manages authorization of resources, e.g. for access in build pipelines
resource "azuredevops_resource_authorization" "auth" {
  project_id  = azuredevops_project.project.id
  resource_id = azuredevops_serviceendpoint_github.serviceendpoint_github.id
  authorized  = true
}

# Creates variable group in azure devops library
resource "azuredevops_variable_group" "variablegroup" {
  project_id   = azuredevops_project.project.id
  name         = "terraform-djg"
  description  = "Variable group for pipelines"
  allow_access = true

  variable {
    name = "az_client_id"
  }

  variable {
    name = "az_client_secret"
  }

  variable {
    name = "az_subscription"
  }

  variable {
    name = "az_tenant"
  }
}

# Manages a GitHub service endpoint within Azure DevOps
resource "azuredevops_serviceendpoint_github" "serviceendpoint_github" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "DJG-ADO-Pipeline"

  auth_personal {
    personal_access_token = var.ado_github_pat
  }
}


resource "azuredevops_build_definition" "pipeline_1" {

  depends_on = [azuredevops_resource_authorization.auth]
  project_id = azuredevops_project.project.id
  name       = local.ado_pipeline_name_1

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type             = "GitHub"
    repo_id               = var.github_repo_name
    branch_name           = "master"
    yml_path              = var.ado_pipeline_yaml_path_1
    service_connection_id = azuredevops_serviceendpoint_github.serviceendpoint_github.id
  }
}