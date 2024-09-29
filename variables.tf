variable "ami"{
    type = string
    default = "ami-0e86e20dae9224db8"
}

variable "instance_type"{ 
  type = string
  default = "t2.2xlarge"
}

variable "key_name" {
  type = string
  default = "tech365key"
}

variable "port" {
  type = number
  default = 8080
}