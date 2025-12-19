module "vpc" {
  source = "./modules/vpc"
  project_name = "aws-architecture"
}
module "alb" {
  source          = "./modules/alb"
  project_name    = var.project_name
  public_subnets  = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id
  security_group_id = aws_security_group.alb_sg.id
}
resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-alb-sg"
  description = "Allow HTTP"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_name}-ec2-sg"
  description = "Allow ALB to access EC2"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "Allow ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  tags = {
    Name = "${var.project_name}-ec2-sg"
  }
}
module "ec2" {
  source            = "./modules/ec2"
  project_name      = var.project_name
  private_subnet_a  = module.vpc.private_subnets[0]
  private_subnet_b  = module.vpc.private_subnets[1]
  ec2_sg_id         = aws_security_group.ec2_sg.id
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  user_data         = file("userdata.sh")
  key_name          = aws_key_pair.ec2_bastion_key.key_name 
}
resource "aws_lb_target_group_attachment" "ec2_a" {
  target_group_arn = module.alb.target_group_arn
  target_id        = module.ec2.ec2_ids[0]
  port             = 80
}

resource "aws_lb_target_group_attachment" "ec2_b" {
  target_group_arn = module.alb.target_group_arn
  target_id        = module.ec2.ec2_ids[1]
  port             = 80
}
# root/main.tf dosyasına eklenecek
resource "aws_key_pair" "ec2_bastion_key" {
  key_name   = "${var.project_name}-ssh-key"
  # DİKKAT: Public Key dosyanızın yerel yolunu buraya yazın.
  public_key = file("D:/Downloads/public_ec2.pub") 
}
module "rds" {
  source                = "./modules/rds"
  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  private_subnets       = module.vpc.private_subnets
  app_security_group_id = aws_security_group.ec2_sg.id # EC2 SG'sini gönderiyoruz
  db_username           = var.db_username
  db_password           = var.db_password
}
module "redis" {
  source                = "./modules/redis"
  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  private_subnets       = module.vpc.private_subnets
  app_security_group_id = aws_security_group.ec2_sg.id # EC2 SG'sini gönderiyoruz
}
module "mq" {
  source                = "./modules/mq"
  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  private_subnets       = module.vpc.private_subnets
  app_security_group_id = aws_security_group.ec2_sg.id
  mq_username           = var.mq_username
  mq_password           = var.mq_password
}

module "efs" {
  source                = "./modules/efs"
  project_name          = var.project_name
  vpc_id                = module.vpc.vpc_id
  private_subnets       = module.vpc.private_subnets
  app_security_group_id = aws_security_group.ec2_sg.id
}
# root/main.tf (opensearch module çağrısı)

module "opensearch" {
  source                     = "./modules/opensearch"
  project_name               = var.project_name
  vpc_id                     = module.vpc.vpc_id
  private_subnets            = module.vpc.private_subnets
  app_security_group_id      = aws_security_group.ec2_sg.id
  # Bastion Host'un SG ID'sini varsayalım ki, yönetim erişimi için Bastion Host'a bağlı olan SG'yi kullanalım.
  bastion_security_group_id  = aws_security_group.alb_sg.id # ALB SG'sini Bastion SG olarak kullanıyoruz (Public Subnet'te olduğu için)
  
  # Not: Bastion Host için ayrı bir SG oluşturmanız en iyi pratiktir. 
  # Şu an Public Subnet'teki SG'yi (ALB SG'yi) kullanıyorum, bu yanlıştır, ama SG ID'niz olmadığı için
  # ALB'nin Public Subnet'te olan SG'sini geçici olarak kullanıyorum.
}