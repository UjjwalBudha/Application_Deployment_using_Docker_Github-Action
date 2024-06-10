module "ec2" {
  for_each                    = var.name
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "5.5.0"
  instance_type               = var.instance_type
  ami                         = var.ami_id
  monitoring                  = var.monitoring
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = var.sg_id
  subnet_id                   = var.subnet_id # public subnet
  iam_instance_profile        = "intern-ujwal"
  key_name                    = try(var.key_name, null)
  user_data                   = filebase64("script/automate.sh")
  tags = {
    Name = each.value
  }
}