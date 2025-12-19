# modules/opensearch/variables.tf

variable "project_name" { type = string }
variable "vpc_id" { type = string }
variable "private_subnets" { type = list(string) }
variable "app_security_group_id" { type = string } # Uygulama (EC2) SG ID'si
variable "bastion_security_group_id" { type = string } # Yönetim (Bastion) SG ID'si
