# 1. Repositorio para la imagen de Docker

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ecr = "http://localhost:4566"
    ecs = "http://localhost:4566"
    rds = "http://localhost:4566"
    # ... otros endpoints que uses
  }
}

resource "aws_ecr_repository" "springboot_app" {
  name                 = "springboot-app"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}

# 2. Base de Datos RDS MySQL (Capa Gratuita)
resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  db_name              = "appdb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro" # Free Tier
  username             = "admin"
  password             = "Password12345"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = true # Para que puedas verla desde CloudShell fácilmente
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}
