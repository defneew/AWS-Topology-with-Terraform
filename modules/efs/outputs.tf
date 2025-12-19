output "efs_id" {
  value       = aws_efs_file_system.efs_file_system.id
  description = "The ID of the Elastic File System"
}

output "efs_dns_name" {
  value       = aws_efs_file_system.efs_file_system.dns_name
  description = "The DNS name for the EFS"
}