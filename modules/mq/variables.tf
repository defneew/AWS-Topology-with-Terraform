variable "project_name" { 
    type = string 
}
variable "vpc_id" { 
    type = string 
}
variable "private_subnets" { 
    type = list(string) 
}
variable "app_security_group_id" { 
    type = string 
} # EC2 SG ID'si
variable "mq_username" { 
    type = string 
}
variable "mq_password" { 
    type = string 
}