resource "random_integer" "priority" {
  min = 1
  max = 3
}

variable "prefix" {
    default = ["Mr", "Mrs", "Sir"]
}


resource "random_pet" "my-pet" {
    prefix = var.prefix[random_integer.priority.id]
}
