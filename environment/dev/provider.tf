terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "todo-rg"
    storage_account_name = "todostg"
    container_name       = "todo-container"
    key                  = "todo.key"

  }

}

provider "azurerm" {
  features {}
  subscription_id = "075d036c-4cbd-46d6-a39c-519dc57956b3"
} 
