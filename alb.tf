resource "aws_lb" "alb" {
  name            = "bluegreen-alb"
  subnets         = "${module.vpc.public_subnets}"
  security_groups = ["${aws_security_group.web-server-sg.id}"]
  depends_on = [
    aws_security_group.web-server-sg
  ]
}
resource "aws_lb_target_group" "target_group" {
  name        = "bluegreen-target-1"
  protocol    = "HTTP"
  port        = 80
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
}
resource "aws_lb_target_group" "target_group2" {
  name        = "bluegreen-target-2"
  protocol    = "HTTP"
  port        = 80
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
}
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  protocol          = "HTTP"
  port              = 80
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
resource "aws_security_group" "web-server-sg" {
  name        = "web-server-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [module.vpc.vpc_cidr_block]
    # ipv6_cidr_blocks = [module.vpc.vpc_ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web-server-sg"
  }
  
}