variable "nombres_de_servidores" {
  default = ["backend-server-1", "backend-server-2", "backend-server-3"]
}

variable "num" {
  default = [ 250, 10, 11, 5]
  description = "numeros"
}

variable "ami" {
  type = string
  default = "ami-xyz,AMI-ABC,ami-efg"
  description = "a string containing ami ids"
}
