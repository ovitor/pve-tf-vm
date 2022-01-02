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

variable "os_type" {
  description = "os type, ubuntu/centos/cloud-init"
  type        = string
  default     = "cloud-init"
}

variable "vcpus" {
  description = "virtual cpus"
  type        = string
  default     = "0"
}

variable "cpu" {
  description = "cpu to emulate in the guest"
  type        = string
  default     = "host"
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

variable "networks" {
  description = "list of vm network interfaces"
  type        = list(any)
}

variable "agent" {
  description = "set qemu_guest_agent"
  type        = number
  default     = 1

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
  default     = ""
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
  description = "content of ssh public keys (one per line)"
  type        = string
}
