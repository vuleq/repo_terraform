output "public_ip_address" {
  value = azurerm_public_ip.vule_vm_linux_ip.ip_address
}

output "vm_name" {
  value = azurerm_virtual_machine.vule_vm_linux.name
}
