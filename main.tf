resource "proxmox_vm_qemu" "service" {
  name = format("%s", var.service_name)
  desc = templatefile("${path.module}/templates/desc.tpl", {
    service_name     = var.service_name
    service_desc     = var.service_desc
    default_username = local.default_username
  })

  target_node = var.target_node
  clone       = var.template_name
  agent       = 1

  os_type = var.os_type
  cores   = var.cores
  sockets = var.sockets
  vcpus   = var.vcpus
  cpu     = var.cpu
  memory  = var.memory
  scsihw  = "virtio-scsi-pci"

  dynamic "disk" {
    for_each = var.disks
    content {
      size    = lookup(disk.value, "disk_size", "10G")
      storage = lookup(disk.value, "disk_storage", "local")
      type    = lookup(disk.value, "disk_type", "scsi")
    }
  }

  dynamic "network" {
    for_each = var.networks
    content {
      model  = "virtio"
      bridge = lookup(network.value, "network_bridge", "vmbr0")
      tag    = lookup(network.value, "network_tag", null)
    }
  }

  # cloud init stuff
  ciuser       = local.default_username
  cipassword   = var.default_password
  searchdomain = var.searchdomain
  nameserver   = var.nameserver

  ipconfig0 = join(",", compact(local.ipconfig0))
  sshkeys   = file(var.devops_keys)

  connection {
    type     = "ssh"
    host     = local.host_ip
    user     = local.default_username
    password = var.default_password
    # host     = split("/", var.ipv4_cidr)[0]
  }

  lifecycle {
    ignore_changes = [
      bootdisk,
      cipassword
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl start qemu-guest-agent",
      "sudo systemctl enable qemu-guest-agent"
    ]
  }

}
