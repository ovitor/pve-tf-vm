locals {
  ipconfig0 = [
    var.ipv4_cidr != null ? "ip=${var.ipv4_cidr}" : "ip=dhcp",
    var.ipv4_gw != null ? "gw=${var.ipv4_gw}" : ""
  ]
  is_dhcp = var.ipv4_cidr != null ? false : true

  host_ip = var.ipv4_cidr != null ? split("/", var.ipv4_cidr)[0] : "self.ssh_host"

  default_username = split("-", var.template_name)[0]
}
