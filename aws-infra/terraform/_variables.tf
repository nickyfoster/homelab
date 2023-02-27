variable "region" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "default_vpc_id" {
  type = string
}

variable "versions" {
  type = object({
    ubuntu = string
  })
}

variable "peer_networks" {
  type = list(object({
    name     = string
    vpc_id   = string
    vpc_cidr = string
  }))
}

variable "ec2_iam_default_profile_statements" {
  description = "Default statements for priv-net EC2 instance profile"
  type = list(object({
    name      = string
    resources = list(string)
    actions   = list(string)
    effect    = string

  }))
}

variable "private_hosts" {
  type = list(object({
    name                   = string
    instance_type          = optional(string)
    ami                    = optional(string)
    availability_zone      = optional(string)
    subnet_id              = optional(string)
    key_name               = optional(string)
    vpc_security_group_ids = optional(list(string))
    volume_size            = optional(number)
    iam = optional(list(object({
      name      = string
      resources = list(string)
      actions   = list(string)
      effect    = string
    })))
  }))
}
