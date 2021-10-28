variable "awsregion" {
    type = string
    default = "us-east-1"  
}
variable "vpccidr" {
    type = string
    default = "172.16.0.0/16"
}
variable "subcidr" {
    type = string
    default = "172.16.1.0/24"  
}
variable "subaz" {
    type = string
    default = "us-east-1a"  
}
variable "rtcidr" {
    type = string
    default = "0.0.0.0/0"  
}
