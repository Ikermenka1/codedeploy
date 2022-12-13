resource "aws_iam_role" "role" {
  name               = "codedeploy-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_codedeploy.json
  path = "/service-role/"
}

resource "aws_iam_role_policy_attachment" "default" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.default.arn
}


resource "aws_iam_policy" "default" {
  name        = "codedeploy-policy"
  policy      = data.aws_iam_policy_document.policy.json
}

# task execution
resource "aws_iam_role" "task_execution" {
  name               = "task-execution"
  assume_role_policy = data.aws_iam_policy_document.assume_role_ecs.json
}

resource "aws_iam_policy" "task_execution" {
  name        = "task-execution"
  policy      = data.aws_iam_policy.ecs_task_execution.policy
}

resource "aws_iam_role_policy_attachment" "task_execution" {
  role       = aws_iam_role.task_execution.name
  policy_arn = aws_iam_policy.task_execution.arn
}

