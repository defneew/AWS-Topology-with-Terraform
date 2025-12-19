output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "db_port" {
  value = module.rds.db_port
}

output "mq_endpoint" {
  description = "The primary endpoint for the message broker (Secure Wire Protocol)"
  value       = module.mq.mq_endpoint_wire
}

output "mq_console_url" {
  description = "The URL for the ActiveMQ Web Console (internal)"
  value       = module.mq.mq_console_url
}

output "efs_id" {
  description = "The ID of the Elastic File System"
  value       = module.efs.efs_id
}

output "efs_dns_name" {
  description = "The DNS name for the EFS"
  value       = module.efs.efs_dns_name
}
# root/outputs.tf (modülden çıktı alma)

output "opensearch_endpoint" {
  description = "The endpoint for data ingestion and API access"
  value       = module.opensearch.opensearch_endpoint
}

output "opensearch_dashboard_url" {
  description = "The URL for the OpenSearch Dashboards (Kibana) UI (Access via Bastion Host)"
  value       = module.opensearch.opensearch_dashboard_url
}