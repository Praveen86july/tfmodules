terraform {
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "3.63.0"
      }
  }
}
terraform {
  backend "s3" {
      bucket = "7786bucket"
      key = "tfstatefile"
      region = "us-east-1"
  }
}
provider "aws" {
    region = var.awsregion
    shared_credentials_file = "~/.aws/credentials"
}
resource "aws_vpc" "vpc" {
    cidr_block = var.vpccidr
    enable_dns_support = true  
    instance_tenancy = "default"
    tags = {
      Name = "dev_vpc"
    }
}
resource "aws_subnet" "sub" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.subcidr
    availability_zone = var.subaz
    map_public_ip_on_launch = true
    tags = {
      Name = "dev_sub"
    } 
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id  
    tags = {
      Name = "dev_igw"
    }
}
resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = var.rtcidr
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "value"
    }
}
resource "aws_route_table_association" "rta" {
    subnet_id = aws_subnet.sub.id
    route_table_id = aws_route_table.rt.id  
}
resource "aws_security_group" "sg" {
    name = "allow_all"
    description = "allow all ports"
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port = "0"
        to_port = "0"
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "-1"
    }
    egress {
        from_port = "0"
        to_port = "0"
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "-1"
    }
    tags = {
      Name = "dev_sg"
    }  
}

module "ec2instance" {

    source = "../modules/ec2instance"

    ec2_instance_ami = "ami-09e67e426f25ce0d7" #ubuntu-20.04
    ec2_instance_type = "t2.micro"
    ec2_instance_az = "us-east-1a"

    ec2_instance_keypair = "keypair"
    ec2_instance_sg = "${aws_security_group.sg.id}"
    ec2_instance_subnet = "${aws_subnet.sub.id}"
  
}

# module "s3" {
#     source = "../modules/s3bucket"
# #    allowed_bucket_actions = ["s3:GetObject", "s3:ListBucekt", "s3:GetBucketLocation"]  
# }

output "vpc_id" {
    value = aws_vpc.vpc.id  
}
output "sub_id" {
    value = aws_subnet.sub.id  
}
output "sg_id" {
    value = aws_security_group.sg.id  
}
