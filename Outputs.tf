
output "public_ip" {
  value       = module.Win_VM.public_ip
  description = "Public ip of the virtual machine"
}

output "rdp_username" {
  value       = module.Win_VM.admin_username
  description = "Admin username of the virtual machine"
}

output "rdp_password" {
  value       = module.Win_VM.admin_password
  description = "Admin password of the virtual machine"
}