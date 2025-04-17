provider "azurerm" {
  features {}
  subscription_id = "740f7a70-5b4e-4fe9-baa9-3ed0b6c2972c"
}

resource "azurerm_resource_group" "vule_rg" {
  name     = var.resource_group_name
  location = var.location
}

# ✅ Thêm Virtual Network
resource "azurerm_virtual_network" "vule_vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.vule_rg.location
  resource_group_name = azurerm_resource_group.vule_rg.name
}

# ✅ Thêm Subnet
resource "azurerm_subnet" "vule_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.vule_rg.name
  virtual_network_name = azurerm_virtual_network.vule_vnet.name
  address_prefixes     = [var.subnet_address_prefix]
}

