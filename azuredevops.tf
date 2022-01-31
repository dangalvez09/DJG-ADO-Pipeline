#Create Azure Devops Resources for pipeline
provider "azuredevops" {
  org_service_url       = var.ado_org_service_url
  personal_access_token = var.ado_pat
  # Authentication through PAT defined with AZDO_PERSONAL_ACCESS_TOKEN 
}

# Manages a project within Azure DevOps
resource "azuredevops_project" "project" {
  name               = local.ado_project_name
  description        = local.ado_project_description
  visibility         = local.ado_project_visibility
  version_control    = "Git"   # This will always be Git for me
  work_item_template = "Agile" # Not sure if this matters, check back later

  features = {
    "testplans"    = "enabled"
    "artifacts"    = "enabled"
    "boards"       = "enabled"
    "repositories" = "enabled"
    "pipelines"    = "enabled"
  }
}

# Manages a GitHub service endpoint within Azure DevOps
resource "azuredevops_serviceendpoint_github" "serviceendpoint_github" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "DJG-Terraform-Project"

  auth_personal {
    personal_access_token = var.ado_github_pat
  }
}

# Manages authorization of resources, e.g. for access in build pipelines
resource "azuredevops_resource_authorization" "auth" {
  project_id  = azuredevops_project.project.id
  resource_id = azuredevops_serviceendpoint_github.serviceendpoint_github.id
  authorized  = true
}

resource "azuredevops_variable_group" "variablegroup" {
  project_id   = azuredevops_project.project.id
  name         = "terraform-djg"
  description  = "Variable group for pipelines"
  allow_access = true

  variable {
    name         = "az_client_id"
    secret_value = var.az_client_id
    is_secret    = true
  }

  variable {
    name         = "az_client_secret"
    secret_value = var.az_client_secret
    is_secret    = true
  }

  variable {
    name         = "az_subscription"
    secret_value = var.az_subscription
    is_secret    = true
  }

  variable {
    name         = "az_tenant"
    secret_value = var.az_tenant
    is_secret    = true
  }
}