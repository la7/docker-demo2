provider "aws" {
  region = "us-east-1"
}

# Repositorio ECR - Nombre crítico para el script y deploy.yml
resource "aws_ecr_repository" "springboot_app" {
  name                 = "springboot-app" 
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}

# Definición de Tarea ECS
resource "aws_ecs_task_definition" "app" {
  family                   = "spring-app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  resource "aws_ecs_task_definition" "app" {
    family                   = "spring-app-task"
    container_definitions = jsonencode([
      {
        name  = "spring-app" # <-- Coincide con container-name en deploy.yml
        image = "000000000000.dkr.ecr.us-east-1.amazonaws.com/springboot-app:latest"
        # ... resto de la config
      }
    ])
  }
  container_definitions = jsonencode([
    {
      name      = "spring-app" # Coincide con container-name en deploy.yml
      image     = "000000000000.dkr.ecr.us-east-1.amazonaws.com/springboot-app:latest"
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