# output "default_vpc" {
#   value = data.aws_vpc.default_vpc.id
# }
output "subnets" {
  value = [data.aws_subnets.def_subnets.ids[0], data.aws_subnets.def_subnets.ids[1]]
}
output "sg" {
  value = data.aws_security_groups.def_sg.ids[0]
}
output "aws-alb-arn" {
  value = aws_lb.alb.arn
}
output "aws-alb-target1-arn" {
  value = aws_lb_target_group.target_group.arn
}
output "aws_listener" {
  value = aws_lb_listener.listener.arn
}
output "ecs-cluster" {
  value = aws_ecs_cluster.ecs_cluster.arn
}
output "ecs-service" {
  value = aws_ecs_service.ecs_service.id
}
output "codedeploy-app-id" {
  value = aws_codedeploy_app.codedeploy_app.application_id
}
