provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "vule_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vule_vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.vule_rg.location
  resource_group_name = azurerm_resource_group.vule_rg.name
}

resource "azurerm_subnet" "vule_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.vule_rg.name
  virtual_network_name = azurerm_virtual_network.vule_vnet.name
  address_prefixes     = [var.subnet_prefix]
}

resource "azurerm_network_security_group" "vule_nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.vule_rg.location
  resource_group_name = azurerm_resource_group.vule_rg.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
}
