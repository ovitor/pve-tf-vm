resource "proxmox_vm_qemu" "service" {
  for_each = var.instances
  name     = each.key

  desc = templatefile("${path.module}/templates/desc.tpl", {
    service_name     = each.key
    service_desc     = each.value.description
    environment      = each.value.environment
    default_username = each.value.username
  })

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
  ciuser       = each.value.username
  cipassword   = each.value.password
  searchdomain = each.value.searchdomain
  nameserver   = each.value.nameserver

  ipconfig0 = lookup(local.ips[0], "ipconfig0", null)
  ipconfig1 = lookup(local.ips[0], "ipconfig1", null)
  ipconfig2 = lookup(local.ips[0], "ipconfig2", null)
  ipconfig3 = lookup(local.ips[0], "ipconfig3", null)
  ipconfig4 = lookup(local.ips[0], "ipconfig4", null)
  ipconfig5 = lookup(local.ips[0], "ipconfig5", null)

  connection {
    type     = "ssh"
    host     = local.host_ip
    user     = each.value.username
    password = each.value.password
  }

  sshkeys = var.authorized_keys

  lifecycle {
    ignore_changes = [
      bootdisk,
      cipassword
    ]
  }
}
