variable "location" {
  type        = string
  description = "Resource location"
}
variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}
variable "prefix" {
  type        = string
  description = "Prefix for this module's resources"
}
variable "ip_allocation" {
  type        = string
  description = "Allocation IP method"
}
variable "sec_rules" {
  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))

  description = "Nsg security rules"
}