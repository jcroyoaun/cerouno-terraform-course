variable "region" {
    type = map
    default = {
        "ProjectA" = "us-west-2"
        "ProjectB" = "us-east-1"
    } 
}

variable "instance_type" {
  default = "t2.micro"

}

variable "ami" {
  type = map
  default = {
    "ProjectA" = "ami-830c94e3",
    "ProjectB" = "ami-04bf6dcdc9ab498ca"
  }
}