output "id" {
  value = [for instance_id in module.ec2 : instance_id.id]
}