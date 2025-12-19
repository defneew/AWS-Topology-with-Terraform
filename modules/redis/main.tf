# 1. Redis Security Group (6379 Portu)
resource "aws_security_group" "redis_sg" {
  name        = "${var.project_name}-redis-sg"
  description = "Allow inbound traffic from application security group to Redis (6379)"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [var.app_security_group_id] # Sadece EC2'den gelenlere izin ver
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-redis-sg"
  }
}

# 2. ElastiCache Subnet Group
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "${var.project_name}-redis-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "${var.project_name}-redis-subnet-group"
  }
}

# 3. Redis Cluster
resource "aws_elasticache_cluster" "redis_cache" {
  cluster_id           = "${var.project_name}-redis-cache"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1 # Tek bir node (geliştirme/test için yeterli)
  port                 = 6379
  parameter_group_name = "default.redis7" # Veya AWS'in önerdiği güncel sürümü kullanın
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids   = [aws_security_group.redis_sg.id]

  tags = {
    Name = "${var.project_name}-redis-cache"
  }
}