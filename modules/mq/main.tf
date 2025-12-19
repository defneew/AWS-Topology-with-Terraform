# 1. MQ Security Group: Uygulama erişimine izin verir (61617 ve 8161)
resource "aws_security_group" "mq_sg" {
  name        = "${var.project_name}-mq-sg"
  description = "Allow inbound traffic from application security group to ActiveMQ"
  vpc_id      = var.vpc_id

  # ActiveMQ Protokol Portu (OpenWire, STOMP vb. için)
  ingress {
    from_port       = 61617 
    to_port         = 61617
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }

  # ActiveMQ Web Konsol Portu (Yönetim arayüzü)
  ingress {
    from_port       = 8161
    to_port         = 8161
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-mq-sg"
  }
}

# 2. Amazon MQ Broker Instance (ActiveMQ)
resource "aws_mq_broker" "mq_broker" {
  broker_name             = "${var.project_name}-mq-broker"
  engine_type             = "ACTIVEMQ"
  engine_version          = "5.18" 
  host_instance_type      = "mq.t3.micro"
  security_groups         = [aws_security_group.mq_sg.id]
  subnet_ids              = var.private_subnets
  deployment_mode         = "ACTIVE_STANDBY_MULTI_AZ" # Multi-AZ ile Yüksek Erişilebilirlik
  auto_minor_version_upgrade = true
  publicly_accessible     = false

  user {
    username = var.mq_username
    password = var.mq_password
  }

  tags = {
    Name = "${var.project_name}-mq-broker"
  }
}