output "ecr_repository_url" {
  # Cambiar app_repo por springboot_app para que coincida con main.tf [cite: 3, 6]
  value = aws_ecr_repository.springboot_app.repository_url
}

output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
}
