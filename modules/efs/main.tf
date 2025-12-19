# 1. EFS Security Group: Uygulama erişimine izin verir (NFS Portu 2049)
resource "aws_security_group" "efs_sg" {
  name        = "${var.project_name}-efs-sg"
  description = "Allow inbound traffic from application security group to EFS (NFS 2049)"
  vpc_id      = var.vpc_id

  # Gelen Kural: Sadece EC2 SG'sinden NFS (2049) portuna izin ver
  ingress {
    from_port       = 2049
    to_port         = 2049
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
    Name = "${var.project_name}-efs-sg"
  }
}

# 2. EFS Dosya Sistemi
resource "aws_efs_file_system" "efs_file_system" {
  creation_token = "${var.project_name}-file-system"
  performance_mode = "generalPurpose" # Genel amaçlı performans modu
  encrypted        = true

  tags = {
    Name = "${var.project_name}-efs-file-system"
  }
}

# 3. Mount Target'lar (Private Subnet'ler için)
# Her bir Private Subnet'e bir bağlantı hedefi oluşturur.
resource "aws_efs_mount_target" "mount_target" {
  count           = length(var.private_subnets)
  file_system_id  = aws_efs_file_system.efs_file_system.id
  subnet_id       = var.private_subnets[count.index]
  security_groups = [aws_security_group.efs_sg.id]
}