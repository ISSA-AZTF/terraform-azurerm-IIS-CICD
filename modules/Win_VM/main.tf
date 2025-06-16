#locals

locals {
  tags      = merge({ environment = "Production" }, { Department = "IT" })
  ps_script = "powershell -ExecutionPolicy Unrestricted -Command \"Install-WindowsFeature -Name Web-Server -IncludeManagementTools; Start-Service W3SVC; New-NetFirewallRule -DisplayName 'Allow HTTP' -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow\""
}

# Random password
resource "random_password" "admin_password" {
  length           = 14
  special          = true
  override_special = "!*$@-/()&"
  lower            = true
  upper            = true
  numeric          = true
  min_lower        = 1
  min_numeric      = 1
  min_upper        = 1
  min_special      = 1
}

# Windows Virtual machine
resource "azurerm_windows_virtual_machine" "vm" {
  name                = "${var.vm_prefix}-IIS"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = random_password.admin_password.result
  network_interface_ids = [
  module.Network.nic_id]

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.version
  }
}

# Custom script extension Install " IIS web server inside Our Vm machine "
resource "azurerm_virtual_machine_extension" "Windows_custom_script" {
  name                 = "${var.extension_prefix}-IIS"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
  publisher            = var.IIS_publisher
  type                 = var.type
  type_handler_version = "1.10"

  settings = jsonencode({
    commandToExecute = local.ps_script
  })


  tags = local.tags
}