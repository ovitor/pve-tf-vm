variable "instances" {
  description = "Map object for instances definition"
  type = map(object({
    name          = string
    description   = string
    target_node   = string
    template_name = string
    username      = string
    password      = string
    cores         = string
    sockets       = string
    memory        = string
    disks         = list(any)
    networks      = list(any)
    searchdomain  = string
    nameserver    = string
  }))
}

variable "authorized_keys" {
  description = "authorized user's keys"
  type        = string
}
