terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.94.0"
    }
  }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "djgazure"

    workspaces {
      name = "DJG-AZURE-Project"
    }
  }
}
