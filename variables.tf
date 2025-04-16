variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "resource_group_name" {
  default     = "vuleRG"
  description = "Resource Group name"
}

variable "location" {
  default     = "East US"
  description = "Location for Azure resources"
}

variable "vnet_name" {
  default     = "vuleNetwork"
}

variable "vnet_address_space" {
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  default     = "vuleSubnet"
}

variable "subnet_prefix" {
  default     = "10.0.1.0/24"
}

variable "nsg_name" {
  default     = "vuleNSG"
}

variable "public_ip_name" {
  default     = "vuleVMLinuxIP"
}

variable "nic_name" {
  default     = "vuleVMLinuxNIC"
}

variable "vm_name" {
  default     = "vule-vm-linux"
}

variable "vm_size" {
  default     = "Standard_B1ms"
}

variable "admin_username" {
  default     = "azureuser"
}

variable "ssh_key_path" {
  description = "Path to your local public SSH key"
  type        = string
}
