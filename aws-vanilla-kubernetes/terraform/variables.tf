variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "tags" {
  description = "AWS tags"
  type        = map(any)
  default     = {}
}

variable "k8s_instance_type" {
  description = "Type of EC2 instance for k8s nodes"
  type        = string
  default     = "t2.small"
}

variable "k8s_instance_ami" {
  description = "AMI id of k8s node"
  type        = string
  default     = "ami-00eeedc4036573771"
}