variable "project_name" {
  type        = string
  description = "Project name prefix"
  default     = "aws-architecture"
}
variable "ami_id" {
  type    = string
  default = "ami-06dd92ecc74fdfb36" # Frankfurt Amazon Linux 2
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}
# PostgreSQL Veritabanı Değişkenleri
variable "db_username" {
  description = "Master database username"
  type        = string
  default     = "postgresadmin"
}

variable "db_password" {
  description = "Master database password"
  type        = string
  default     = "12345678" 
}
# Amazon MQ Değişkenleri
variable "mq_username" {
  description = "Amazon MQ master username"
  type        = string
  default     = "mqadmin"
}

variable "mq_password" {
  description = "Amazon MQ master password (En az 12 karakter, büyük/küçük harf, rakam ve özel karakter içermelidir)"
  type        = string
  default     = "MqSecurePassword123!" # Lütfen bu şifreyi daha güvenli ve karmaşık bir değerle değiştirin
}
# root/variables.tf

variable "opensearch_password" {
  description = "OpenSearch Master User Password (at least 8 chars)"
  type        = string
  default     = "OsSecurePassword2025!" # Güçlü bir şifre kullanın
}