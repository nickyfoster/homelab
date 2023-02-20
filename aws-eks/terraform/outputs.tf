output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = var.cluster_name
}

output "update_kubeconfig_command" {
  value = format("%s %s %s %s %s", "aws eks update-kubeconfig --name", var.cluster_name, "--region", var.region, "--alias eks-dev")
}
