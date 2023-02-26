variable "region" {
  type = string
}

variable "k8s_controller_instance_type" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "k8s_vpc_cidr_block" {
  type = string
}

variable "default_vpc_cidr_block" {
  type = string
}

variable "peering_conn_id" {
  type = string
}

variable "versions" {
  type = object({
    ubuntu     = string
    cri-o      = string
    kubernetes = string
    etcd       = string
  })
}
