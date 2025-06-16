# Module Network
prefix        = "win-vm"
ip_allocation = "Static"
sec_rules = {
  "allow_rdp" = {
    name                       = "sr-123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  "allow_http" = {
    name                       = "sr-456"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Module Win_VM
admin_username       = "testadmin"
version              = "latest"
publisher            = "MicrosoftWindowsServer"
caching              = "ReadWrite"
IIS_publisher        = "Microsoft.Compute"
extension_prefix     = "custom-extension"
vm_size              = "Standard_B2ms"
vm_prefix            = "win-vm"
storage_account_type = "Standard_LRS"
offer                = "WindowsServer"
sku                  = "2016-Datacenter"
type                 = "CustomScriptExtension"


