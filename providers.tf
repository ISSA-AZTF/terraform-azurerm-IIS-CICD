
# Specify the version of the azureRM provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.1"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
  backend "azurerm" {
    resource_group_name   = "rg"
    storage_account_name  = "sa_tfstatefile"
    container_name        = "mycontainer"
    key                   = "terraform.tfstate"
}
}

# Configure the azureRm provider
provider "azurerm" {
  features {}
}