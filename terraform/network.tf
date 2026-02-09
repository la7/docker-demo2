# Seguridad: Permitir que la App llegue a la DB
resource "aws_security_group" "db_sg" {
  name        = "db-security-group"
  description = "Permitir trafico MySQL"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # En producción usarías solo la IP de la VPC
  }
}

# Rol de ejecución para ECS (IAM)
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole-Custom"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}