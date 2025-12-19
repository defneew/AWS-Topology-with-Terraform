# modules/opensearch/main.tf

# 1. OpenSearch Security Group: Uygulama ve Yönetim (443 portu) erişimine izin verir
resource "aws_security_group" "opensearch_sg" {
  name        = "${var.project_name}-opensearch-sg"
  description = "Allow inbound HTTPS from application and management SG"
  vpc_id      = var.vpc_id

  # Gelen Kural 1: Uygulama Katmanından Gelen HTTPS (443) trafiğine izin ver
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }

  # Gelen Kural 2: Yönetim/Bastion Host'tan Gelen HTTPS (443) trafiğine izin ver
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [var.bastion_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-opensearch-sg"
  }
}

# 2. OpenSearch Domain
resource "aws_opensearch_domain" "log_domain" {
  domain_name           = "${var.project_name}-log-domain"
  engine_version        = "OpenSearch_2.11" 
  
  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }
  
  vpc_options {
    subnet_ids         = var.private_subnets
    security_group_ids = [aws_security_group.opensearch_sg.id]
  }
  
  # KÜME YAPILANDIRMASI: Instance tipi ve sayısı burada olmalıdır
  cluster_config {
    instance_type  = "t3.small.search"
    instance_count = 1 # Eklendi: Instance sayısını da burada tanımlamamız gerekiyor
  }
  
  domain_endpoint_options {
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }
  
  # MASTER KULLANICI AYARLARI: IAM/Policy'ye geçiş yaptığımız için Master User ayarlarını 
  # kaldırıyoruz ve Master yetkisini IAM kimliğimize (ARN) veriyoruz.
  
  # Dizin Tabanlı Erişim Politikası (IAM ARN Tabanlı Yönetim Erişimi)
  access_policies = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          AWS = data.aws_caller_identity.current.arn # Kendi oturum açtığınız IAM ARN'niz
        },
        Action = "es:*",
        Resource = "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.project_name}-log-domain/*"
      }
      # Uygulama erişim kuralları daha sonra eklenebilir.
    ]
  })

  tags = {
    Name = "${var.project_name}-opensearch-domain"
  }
}

# Modülde kullanmak için mevcut AWS bilgilerini alırız (Datasources)
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}