variable "ado_org_service_url" {
  type        = string
  description = "Org service url for Azure DevOps"
}

variable "ado_pat" {
  type        = string
  description = "Personal access token for azure devops"
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
  az_storage_account_name = "${lower(var.prefix)}${random_integer.suffix.result}"

}