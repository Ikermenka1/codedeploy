resource "aws_ecs_service" "ecs_service" {
  cluster         = aws_ecs_cluster.ecs_cluster.name
  name            = "service-bluegreen"
  task_definition = aws_ecs_task_definition.ecs_task_definition.family
  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = "sample-app"
    container_port   = 80

  }
  launch_type         = "FARGATE"
  scheduling_strategy = "REPLICA"
  deployment_controller {
    type = "CODE_DEPLOY"
  }
  platform_version = "LATEST"
  network_configuration {

    assign_public_ip = true
    security_groups  = ["${aws_security_group.web-server-sg.id}"]
    subnets          = "${module.vpc.public_subnets}"


  }
  desired_count = 1
  depends_on = [
    aws_ecs_cluster.ecs_cluster,
    
    aws_ecs_task_definition.ecs_task_definition
  ]
}