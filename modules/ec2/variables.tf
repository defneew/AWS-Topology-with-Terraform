variable "project_name" {
  type = string
}

variable "private_subnet_a" {
  type = string
}

variable "private_subnet_b" {
  type = string
}

variable "ec2_sg_id" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "user_data" {
  type = string
}
variable "key_name" {
  description = "The key pair name to use for SSH access"
  type        = string
}