output "admin_username" {
  value = azurerm_windows_virtual_machine.vm.admin_username
}
output "admin_password" {
  value = azurerm_windows_virtual_machine.vm.admin_password
}
output "vm_name" {
  value = azurerm_windows_virtual_machine.vm.name
}