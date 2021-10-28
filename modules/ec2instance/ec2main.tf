data "aws_ami" "dev" {
  most_recent = true
  owners = [ "143458194849" ]
}
resource "aws_instance" "dev" {
    ami = data.aws_ami.dev.id
#    ami = var.ec2_instance_ami
    instance_type = var.ec2_instance_type
    availability_zone = var.ec2_instance_az
    key_name = var.ec2_instance_keypair
    subnet_id = var.ec2_instance_subnet
    vpc_security_group_ids = ["${var.ec2_instance_sg}"]

    tags = {
      Name = "dev_instance"
    } 
}

# resource "aws_ebs_volume" "ebs" {
#     availability_zone = var.ebsaz
#     size = var.ebssize
#     tags = {
#       Name = "dev_ebs"
#     }  
# }
# resource "aws_volume_attachment" "ebsa" {
#     device_name = "/dev/sdh"
#     volume_id = aws_ebs_volume.ebs.id
#     instance_id =   
# }
