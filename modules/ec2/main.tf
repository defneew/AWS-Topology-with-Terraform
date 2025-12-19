#private subnet için instance oluştur.
resource "aws_instance" "ec2_a" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_a
  vpc_security_group_ids      = [var.ec2_sg_id]
  associate_public_ip_address = false
  key_name              = var.key_name 

  user_data = base64encode(var.user_data)

  tags = {
    Name = "${var.project_name}-ec2-a"
  }
}

resource "aws_instance" "ec2_b" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_b
  vpc_security_group_ids      = [var.ec2_sg_id]
  associate_public_ip_address = false
  key_name              = var.key_name 

  user_data = base64encode(var.user_data)

  tags = {
    Name = "${var.project_name}-ec2-b"
  }
}
