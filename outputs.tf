output "vm_name" {
  description = "vm name"
  value       = proxmox_vm_qemu.service.name
}

output "ipv4_address" {
  description = "ipv4 address"
  value       = proxmox_vm_qemu.service.ssh_host
}
