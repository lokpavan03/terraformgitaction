terraform {
  backend "remote" {
    organization = "loktf"

    workspaces {
      name = "terraform"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

#Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "TerraformCloud"
  location = "West Europe"
}
