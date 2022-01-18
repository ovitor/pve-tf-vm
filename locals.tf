locals {
  ips = flatten([
    for instance in var.instances : {
      for network in instance.networks : "ipconfig${index(instance.networks, network)}" =>
      network.ip == "dhcp" ? "ip=dhcp" : format("ip=%s,gw=%s", network.ip, network.gw)
    }
  ])
  host_ip = local.ips[0]["ipconfig0"] == "ip=dhcp" ? "self.ssh_host" : trimprefix(split("/", local.ips[0]["ipconfig0"])[0], "ip=")
}
