output "k8s_controller_public_ip" {
  description = "k8s-controller-public-ip"
  value       = aws_eip.k8s_controller.public_ip
}
