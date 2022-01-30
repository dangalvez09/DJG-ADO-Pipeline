terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "0.1.8"
    }
  }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "djgazure"

    workspaces {
      name = "DJG-ADO-Project"
    }
  }
}
