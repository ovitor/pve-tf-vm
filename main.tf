resource "proxmox_vm_qemu" "service" {
  for_each = var.instances
  name     = each.value.name
  desc     = each.value.description

  target_node = each.value.target_node
  clone       = each.value.template_name
  agent       = 1

  os_type = "cloud-init"
  cores   = each.value.cores
  sockets = each.value.sockets
  memory  = each.value.memory
  scsihw  = "virtio-scsi-pci"

  dynamic "disk" {
    for_each = each.value.disks
    content {
      size    = lookup(disk.value, "size", "10G")
      storage = lookup(disk.value, "storage", "local")
      type    = lookup(disk.value, "type", "scsi")
    }
  }

  dynamic "network" {
    for_each = each.value.networks
    content {
      model  = "virtio"
      bridge = lookup(network.value, "bridge", "vmbr0")
      tag    = lookup(network.value, "tag", null)
    }
  }

  # cloud init stuff
  cicustom     = "user=local:snippets/user_data_${each.key}.yaml"
  ciuser       = each.value.username
  cipassword   = each.value.password
  searchdomain = each.value.searchdomain
  nameserver   = each.value.nameserver

  ipconfig0 = lookup(local.ips[index(keys(var.instances), each.key)], "ipconfig0", null)
  ipconfig1 = lookup(local.ips[index(keys(var.instances), each.key)], "ipconfig1", null)
  ipconfig2 = lookup(local.ips[index(keys(var.instances), each.key)], "ipconfig2", null)
  ipconfig3 = lookup(local.ips[index(keys(var.instances), each.key)], "ipconfig3", null)
  ipconfig4 = lookup(local.ips[index(keys(var.instances), each.key)], "ipconfig4", null)
  ipconfig5 = lookup(local.ips[index(keys(var.instances), each.key)], "ipconfig5", null)

  connection {
    type     = "ssh"
    host     = local.host_ip
    user     = each.value.username
    password = each.value.password
  }

  lifecycle {
    ignore_changes = [
      bootdisk,
      cipassword
    ]
  }
}
