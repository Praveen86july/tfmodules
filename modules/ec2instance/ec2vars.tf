variable "ec2_instance_type" {
    default = "t2.micro"  
}
variable "ec2_instance_az" {
    default = "ua-east-1a"  
}
# variable "ec2_instance_ami" {
#     default = "ami-02e136e904f3da870"  
# }
variable "ec2_instance_keypair" {
    default = "keypair"  
}
variable "ec2_instance_subnet" {}
variable "ec2_instance_sg" {}


# variable "ebsaz" {
#     default = "us-east-1a"  
# }
# variable "ebssize" {
#     default = 1  
# }