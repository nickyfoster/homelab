output "peering_connection_ids" {
  value = {
    for k, v in aws_vpc_peering_connection.vpc_peerings : v.tags.Name => v.id
  }
}