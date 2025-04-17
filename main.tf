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

  security_rule {
    name                       = "AllowRDP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "vule_vm_linux_ip" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.vule_rg.location
  resource_group_name = azurerm_resource_group.vule_rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "vule_vm_linux_nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.vule_rg.location
  resource_group_name = azurerm_resource_group.vule_rg.name

  ip_configuration {
    name                          = "vuleLinuxVMIPConfig"
    subnet_id                     = azurerm_subnet.vule_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vule_vm_linux_ip.id
  }
}

resource "azurerm_virtual_machine" "vule_vm_linux" {
  name                  = var.vm_name
  location              = azurerm_resource_group.vule_rg.location
  resource_group_name   = azurerm_resource_group.vule_rg.name
  network_interface_ids = [azurerm_network_interface.vule_vm_linux_nic.id]
  vm_size               = var.vm_size

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = var.ssh_public_key
    }
  }

  storage_os_disk {
    name              = "${var.vm_name}-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  tags = {
    environment = "dev"
    owner = "vule"
  }
}
