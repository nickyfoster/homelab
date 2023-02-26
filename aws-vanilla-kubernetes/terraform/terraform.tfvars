region                 = "us-east-2"
default_vpc_cidr_block = "172.31.0.0/16"
peering_conn_id        = "pcx-0b806b92a99fe37e4"


availability_zones           = ["us-east-2a", "us-east-2b"]
k8s_vpc_cidr_block           = "10.10.0.0/16"
k8s_controller_instance_type = "t3.medium"

versions = {
  ubuntu = "jammy"

  # https://github.com/cri-o/cri-o/tags
  cri-o = "1.19.0"

  # https://github.com/kubernetes/kubernetes/tags
  kubernetes = "1.26.1"

  # https://github.com/kubernetes/kubernetes/blob/release-1.26/cmd/kubeadm/app/constants/constants.go#L483
  etcd = "3.5.6-0"
}
