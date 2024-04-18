variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "private_ip_address" {
  type    = string
  default = null
}

variable "vm_sku" {
  type    = string
  default = "B2_v5"
}

variable "vm_username" {
  type    = string
  default = "azadmin"
}

variable "vm_password" {
  type      = string
  sensitive = true
}

