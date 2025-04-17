variable "vnet_name" {
  default     = "vuleVNet"
  description = "Name of the Virtual Network"
}

variable "vnet_address_space" {
  default     = "10.0.0.0/16"
  description = "Address space for the VNet"
}

variable "subnet_name" {
  default     = "vuleSubnet"
  description = "Name of the Subnet"
}

variable "subnet_address_prefix" {
  default     = "10.0.1.0/24"
  description = "Address prefix for the Subnet"
}
