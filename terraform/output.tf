output "instnace_ip" {
  value = [for ip in module.ec2 : ip.public_ip]
}

output "id" {
  value = [for instance_id in module.ec2 : instance_id.id]
}