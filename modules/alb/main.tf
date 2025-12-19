#alb oluştur
resource "aws_lb" "this" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnets

  tags = {
    Name = "${var.project_name}-alb"
  }
}
#alb için target group oluştur.
resource "aws_lb_target_group" "this" {
  name     = "${var.project_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/" # Kök dizini kontrol et
    port                = "traffic-port" 
    protocol            = "HTTP"
    interval            = 30 # 30 saniyede bir kontrol et
    timeout             = 5  # 5 saniye içinde yanıt bekle
    healthy_threshold   = 3  # 3 ardışık başarılı kontrolde Healthy say
    unhealthy_threshold = 3  # 3 ardışık başarısız kontrolde Unhealthy say
    matcher             = "200" # Sadece 200 HTTP kodu bekle
  }
}
#alb için listener oluştur(80 portu)
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
