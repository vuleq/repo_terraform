output "vnet_name" {
  value = azurerm_virtual_network.vule_vnet.name
}

output "subnet_id" {
  value = azurerm_subnet.vule_subnet.id
}
