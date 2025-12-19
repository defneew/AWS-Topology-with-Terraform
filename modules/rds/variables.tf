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
variable "db_name" { 
    type = string 
    default = "applicationdb" 
}
variable "db_username" { 
    type = string 
}
variable "db_password" { 
    type = string 
}