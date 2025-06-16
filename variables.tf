# Module Network 
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

# Module Win_VM
variable "admin_username" {
  type        = string
  description = "Admin username"
}
variable "location" {
  type        = string
  description = "Resource location"
}
variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}
variable "extension_prefix" {
  type        = string
  description = "Custom script extension prefix name"
}
variable "vm_prefix" {
  type        = string
  description = "Windows virtual machine prefix name"
}
variable "vm_size" {
  type        = string
  description = "Windows virtual machine size"
}
variable "caching" {
  type        = string
  description = "caching mode for the managed disk"
}
variable "storage_account_type" {
  type        = string
  description = "Storage account type"
}
variable "publisher" {
  type        = string
  description = "OS Microsoft publisher "
}
variable "offer" {
  type        = string
  description = "OS family"
}
variable "sku" {
  type        = string
  description = "OS SKU"
}
variable "version" {
  type        = string
  description = "OS version"
}
variable "IIS_publisher" {
  type        = string
  description = "Azure compute Provider"
}
variable "type" {
  type        = string
  description = "Custom script extension resource type"
}