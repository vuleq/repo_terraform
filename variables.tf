variable "location" {
  description = "Azure region"
  default     = "East US"
}

variable "resource_group_name" {
  default = "vuleRG"
}

variable "vnet_name" {
  default = "vuleNetwork"
}

variable "subnet_name" {
  default = "vuleSubnet"
}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet_prefix" {
  default = "10.0.1.0/24"
}
