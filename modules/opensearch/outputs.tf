# modules/opensearch/outputs.tf

output "opensearch_endpoint" {
  value = aws_opensearch_domain.log_domain.endpoint
  description = "The endpoint for data ingestion and API access (e.g. logstash)"
}

output "opensearch_dashboard_url" {
  value = aws_opensearch_domain.log_domain.dashboard_endpoint
  description = "The URL for the OpenSearch Dashboards (Kibana) UI"
}