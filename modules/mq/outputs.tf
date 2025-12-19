output "mq_endpoint_wire" {
  description = "The Secure Wire Protocol Endpoint for the MQ Broker (e.g. activemq+ssl://...)"
  # Active/Standby olduğu için ilk endpoint'i döndürür
  value       = aws_mq_broker.mq_broker.instances[0].endpoints[0]
}

output "mq_console_url" {
  description = "The URL for the ActiveMQ Web Console (internal)"
  # Active/Standby olduğu için ilk konsol endpoint'ini döndürür
  value       = aws_mq_broker.mq_broker.instances[0].endpoints[1]
}