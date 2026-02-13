
# Repositorio ECR - Nombre crítico para el script y deploy.yml
resource "aws_ecr_repository" "springboot_app" {
  name                 = "springboot-app" 
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  db_name              = "appdb"
  identifier           = "springboot-db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "Password12345"
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}

# Definición de Tarea ECS
resource "aws_ecs_task_definition" "app" {
  family                   = "spring-app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "spring-app" # Coincide con container-name en deploy.yml
      image     = "${aws_ecr_repository.springboot_app.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}