variable "resource_group_location" {
  type    = string
  default = "eastus"
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix to combinate with a randomly name created"
}