variable "region" {
  type    = string
  default = "us-east-2"
}

variable "suffix" {
  type    = string
  default = "epam-test"
}

variable "cluster_name" {
  type    = string
  default = "eks-dev"
}

variable "cluster_version" {
  type    = string
  default = ""
}

variable "node_group_name" {
  type    = string
  default = "node-group-1"
}

variable "ami_id" {
  type    = string
  default = ""
}

variable "ami_type" {
  type    = string
  default = null
}

variable "ami_release_version" {
  type    = string
  default = ""
}

variable "capacity_type" {
  type    = string
  default = "ON_DEMAND"
}

variable "instance_types" {
  type    = list(string)
  default = null
}

variable "min_size" {
  type    = number
  default = 0
}

variable "max_size" {
  type    = number
  default = 3
}

variable "desired_size" {
  type    = number
  default = 2
}

variable "update_config_max_unavailable_percentage" {
  type    = number
  default = 33
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "cluster_enabled_log_types" {
  type    = list(string)
  default = ["audit", "api", "authenticator"]
}

variable "metadata_options" {
  type = map(string)
  default = {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }
}

variable "enable_monitoring" {
  type    = bool
  default = true
}

variable "tag_specifications" {
  type    = list(string)
  default = ["instance", "volume", "network-interface"]
}

variable "alb_namespace" {
  type    = string
  default = "kube-system"
}

variable "alb_service_account_name" {
  type    = string
  default = "aws-alb-ingress-controller"
}

variable "alb_helm_chart_name" {
  type    = string
  default = "aws-load-balancer-controller"
}

variable "alb_helm_chart_release_name" {
  type    = string
  default = "aws-load-balancer-controller"
}

variable "alb_helm_chart_repo" {
  type    = string
  default = "https://aws.github.io/eks-charts"
}

variable "alb_helm_chart_version" {
  type    = string
  default = "1.4.4"
}