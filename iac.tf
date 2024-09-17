terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}

provider "azurerm" {  
  resource_provider_registrations = "none"
  subscription_id = "481c1d25-e4df-4209-9f20-6d3c0c28a214"
  features {}
}

resource "azurerm_resource_group" "pedro_robo" {
  name = "pedro_robo_group"
  location = "eastus2"
}

resource "azurerm_service_plan" "pedro_robo_sp" {
  name = "pedro_robo_sp"
  resource_group_name = azurerm_resource_group.pedro_robo.name
  location = azurerm_resource_group.pedro_robo.location
  sku_name = "S1"
  os_type = "Windows"
}

resource "azurerm_windows_web_app" "pedro_robo_app" {
  name = "pedro-robo-app"
  resource_group_name = azurerm_resource_group.pedro_robo.name
  location = azurerm_resource_group.pedro_robo.location
  service_plan_id = azurerm_service_plan.pedro_robo_sp.id
  site_config {
    always_on = false
  }
}

resource "azurerm_windows_web_app_slot" "pedro_robo_slot_qa" {
  name = "pedro-robo-slot-qa"
  app_service_id = azurerm_windows_web_app.pedro_robo_app.id
  site_config {

  }  
}
