variable "service_name" {
  description = "service name"
  type        = string
}

variable "service_desc" {
  description = "service description"
  type        = string
  default     = "not informed"
}

variable "target_node" {
  description = "proxmox target node"
  type        = string
}

variable "template_name" {
  description = "template name"
  type        = string
}

variable "cores" {
  description = "number of cores"
  type        = string
}

variable "sockets" {
  description = "number of sockets"
  type        = string
}

variable "memory" {
  description = "memory in mb"
  type        = string
}

variable "disks" {
  description = "list of vm disks"
  type        = list(any)
}

variable "network_bridge_interface" {
  description = "network bridge interface"
  type        = string
}

variable "network_vlan_tag" {
  description = "network vlan tag"
  type        = string
  default     = null
}

variable "ipv4_cidr" {
  description = "service's ipv4 in cidr format"
  type        = string
  default     = null
}

variable "ipv4_gw" {
  description = "service's ipv4 gateway"
  type        = string
  default     = null
}

variable "default_user" {
  description = "default user name"
  type        = string
  default     = "ubuntu"
}

variable "default_password" {
  description = "default user name password"
  type        = string
}

variable "searchdomain" {
  description = "searchdomain value"
  type        = string
}

variable "nameserver" {
  description = "searchdomain value"
  type        = string
  default     = null
}

variable "devops_keys" {
  description = "file with a list of ssh public keys (one per line)"
  type        = string
}
