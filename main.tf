provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "vule_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vule_vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = azurerm_resource_group.vule_rg.location
  resource_group_name = azurerm_resource_group.vule_rg.name
}

resource "azurerm_subnet" "vule_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.vule_rg.name
  virtual_network_name = azurerm_virtual_network.vule_vnet.name
  address_prefixes     = [var.subnet_prefix]
}
