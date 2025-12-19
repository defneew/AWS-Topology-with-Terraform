output "db_endpoint" {
  value       = aws_db_instance.postgres_db.address
  description = "The DNS address of the PostgreSQL database"
}

output "db_port" {
  value       = aws_db_instance.postgres_db.port
  description = "The database port"
}

output "db_security_group_id" {
  value = aws_security_group.db_sg.id
  description = "The Security Group ID of the RDS instance"
}