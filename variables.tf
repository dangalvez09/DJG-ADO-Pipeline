variable "ado_org_service_url" {
  type        = string
  description = "Org service url for Azure DevOps"
}

variable "ado_pat" {
  type        = string
  description = "Personal access token for azure devops"
  sensitive   = true
}

variable "prefix" {
  type        = string
  description = "Naming prefix for resources"
  default     = "DJG"
}

variable "ado_github_pat" {
  type        = string
  description = "Personal access token for github"
  sensitive   = true
}

variable "github_repo_name" {
  type        = string
  description = "GitHub Repository name"
  default     = "DJG-ADO-Pipeline"
}

variable "ado_repo_name" {
  type        = string
  description = "azure devops git repo name"
  default     = "DevOps Pipeline Lab"
}

/*
variable "ado_pipeline_yaml_path_1" {
  type = string
  description = "Pipeline name"
}
*/
/*
variable "az_location" {
  type    = string
  default = "eastus"
}

variable "az_client_id" {
  type        = string
  description = "Client ID with permissions to create resources in Azure, use env variables"
}

variable "az_client_secret" {
  type        = string
  description = "Client secret with permissions to create resources in Azure, use env variables"
}

variable "az_subscription" {
  type        = string
  description = "Client ID subscription, use env variables"
}
variable "az_tenant" {
  type        = string
  description = "Client ID Azure AD tenant, use env variables"
}
*/
resource "random_integer" "suffix" {
  min = 1
  max = 100
}

locals {
  ado_project_name        = "${var.prefix}-project-${random_integer.suffix.result}"
  ado_project_description = "Project for ${var.prefix}"
  ado_project_visibility  = "private"
  ado_pipeline_name_1     = "${var.prefix}-pipeline-1"
  az_resource_group_name  = "${var.prefix}${random_integer.suffix.result}"
}