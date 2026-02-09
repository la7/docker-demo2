# 1. Repositorio para la imagen de Docker
resource "aws_ecr_repository" "app_repo" {
  name                 = "springboot-app"
  image_tag_mutability = "MUTABLE"
  force_delete         = true # Útil para laboratorios
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