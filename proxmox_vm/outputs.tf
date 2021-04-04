output "vm_name" {
  description = "vm name"
  value       = proxmox_vm_qemu.proxmox_vm.name
}

output "ipv4_address" {
  description = "ipv4 address"
  value       = proxmox_vm_qemu.proxmox_vm.ssh_host
}
