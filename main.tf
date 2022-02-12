provider "azurerm" {
    version = "=2.0.0"
  features {}
}
terraform {
  backend "azurerm" {
    resourceresource_group_name = "brd-github-tf-rg"  
    storage_account_name        = "bradygithub"
    container_name              = "terraformstatefile"
    key                         = "terraform.tfstate"  
    
  }
}

resource "azurerm_resource_group" "dev" {
  name     = "rg-github-tf-brd"
  location = "UK South"
}

resource "azurerm_app_service_plan" "dev" {
  name                =  "bradyappsrvplan"
  location            =   azurerm_resource_group.dev.location
  resource_group_name =   azurerm_resource_group.dev.name

  sku {
    tier = "Free"
    size = "F1"
  }
}
resource "azurerm_app_service" "dev" {
  name                =  "bradytfwebapp"
  location            =   azurerm_resource_group.dev.location
  resource_group_name =   azurerm_resource_group.dev.name
  app_service_plan_id =   azurerm_app_service_plan.dev.id
}
