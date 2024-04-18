variable "resource_group_name" {
  type        = string
  description = "RG to put the VM and attached resources"
}

variable "location" {
  type        = string
  description = "Location of the VM"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "vm_name" {
  type        = string
  description = "Name of the VM and it's attached resources. All names are prefixed"
}

variable "vm_sku" {
  type        = string
  default     = "Standard_B2als_v5"
  description = "VM SKU"
}

variable "vm_username" {
  type    = string
  default = "azadmin"
}

variable "vm_password" {
  type      = string
  sensitive = true
}

variable "private_ip_address" {
  type        = string
  default     = null
  description = "(OPTIONAL) Set static IP address"
}

variable "use_public_ip" {
  type        = bool
  default     = false
  description = "Attach public IP"
}


