output "subnet_id" {
  value = azurerm_subnet.vule_subnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vule_vnet.name
}
