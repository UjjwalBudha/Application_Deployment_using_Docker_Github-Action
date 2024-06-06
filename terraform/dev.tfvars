# Defines the terraform initalization variables
#################################################################################

region                      = "us-east-1"
project                     = "ansible-server"
terraform                   = true
silo                        = "intern"
owner                       = "ujwal.budha"
instance_type               = "t2.micro"
sg_id                       = ["sg-0b58f156501701642"]
subnet_id                   = "subnet-0f97b0bb45cdeb3b7"
monitoring                  = true
associate_public_ip_address = true
# ssm_policy                    = "arn:aws:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy"
key_name = "intern-ujwal"



name = {
  name1 = "docker-server-intern-ujwal"
  # name2= "ansible-module-server2"
}


# ami_id    = "ami-0f9c44e98edf38a2b"   # windows
ami_id = "ami-04b70fa74e45c3917" # ubuntu
# ami_id    = "ami-0fe630eb857a6ec83"     # redhat
#ami_id    = "ami-0f403e3180720dd7e"   # amazon linux 2023
# ami_id = "ami-033a1ebf088e56e81" # amazon linux2