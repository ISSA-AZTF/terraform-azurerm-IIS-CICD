
# Resource group data source
data "azurerm_resource_group" "rg" {
  name = "rg"
}

# Network Module
module "Network" {
  source              = "./modules/Network"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  prefix              = var.prefix
  ip_allocation       = var.ip_allocation
  sec_rules           = var.sec_rules
}

# Windows Virtual Machine Module
module "Win_VM" {
  source               = "./modules/Win_VM"
  resource_group_name  = data.azurerm_resource_group.rg.name
  location             = data.azurerm_resource_group.rg.location
  admin_username       = var.admin_username
  version              = var.version
  publisher            = var.publisher
  caching              = var.caching
  IIS_publisher        = var.IIS_publisher
  extension_prefix     = var.extension_prefix
  vm_size              = var.vm_size
  vm_prefix            = var.vm_prefix
  storage_account_type = var.storage_account_type
  offer                = var.offer
  sku                  = var.sku
  type                 = var.type
}