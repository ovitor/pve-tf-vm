resource "proxmox_vm_qemu" "service" {
  name = format("%s", var.service_name)
  desc = templatefile("${path.module}/templates/desc.tpl", {
    service_name = var.service_name
    service_desc = var.service_desc
    default_user = var.default_user
  })

  target_node = var.target_node
  clone       = var.template_name
  agent       = 1

  os_type = "cloud-init"
  cores   = var.cores
  sockets = var.sockets
  vcpus   = "0"
  cpu     = "host"
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

  # TODO add more network device with loop
  network {
    model  = "virtio"
    bridge = var.network_bridge_interface
    tag    = var.network_vlan_tag
  }

  # cloud init stuff
  ciuser       = var.default_user
  cipassword   = var.default_password
  searchdomain = var.searchdomain
  nameserver   = var.nameserver
  ipconfig0    = join(",", compact(local.ipconfig0))
  sshkeys      = file(var.devops_keys)

  connection {
    type     = "ssh"
    host     = local.host_ip
    user     = var.default_user
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
