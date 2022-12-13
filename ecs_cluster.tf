resource "aws_ecs_cluster" "ecs_cluster" {
  name = "tutorial-cluster-name"
  depends_on = [
    aws_lb_listener.listener
  ]
}
