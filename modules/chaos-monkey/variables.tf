variable "region" {
  default = "eu-central-1"
}

variable "name_prefix" {
  default = ""
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "subnet_id" {
  type = "string"
}

variable "ami_id" {
  type = "string"
}

variable "instance_type" {
  type = "string"
  default = "t2.nano"
}

variable "sshkeyname" {
  type = "string"
}
