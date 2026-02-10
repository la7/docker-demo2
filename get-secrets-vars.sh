#!/bin/bash

echo "-----------------------------------------------------"
echo "🛠️  EXTRACTOR DE SECRETOS Y VARIABLES (GitHub Ready)"
echo "-----------------------------------------------------"

# 1. Obtener Credenciales Temporales (Secrets)
# Estas vienen del entorno de CloudShell o de lo que configuraste localmente
echo "🔐 [SECRETS] - Copia estos a Settings > Secrets > Actions"
echo "AWS_ACCESS_KEY_ID: $(aws configure get aws_access_key_id)"
echo "AWS_SECRET_ACCESS_KEY: $(aws configure get aws_secret_access_key)"
echo "AWS_SESSION_TOKEN: $(aws configure get aws_session_token)"

echo ""

# 2. Obtener Variables de Infraestructura (Variables)
# Consultamos directamente a AWS y a los outputs de Terraform
echo "🌍 [VARIABLES] - Copia estas a Settings > Variables > Actions"

# ID de Cuenta
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
echo "ACCOUNT_ID: $ACCOUNT_ID"

# Región actual
REGION=$(aws configure get region)
echo "AWS_REGION: $REGION"

# Endpoint de RDS (Buscamos la instancia que creamos)
RDS_ENDPOINT=$(aws rds describe-db-instances --query "DBInstances[0].Endpoint.Address" --output text)
echo "DB_HOST: $RDS_ENDPOINT"

# URI de ECR (Buscamos el repo de Spring Boot)
ECR_URI=$(aws ecr describe-repositories --repository-names springboot-app --query "repositories[0].repositoryUri" --output text 2>/dev/null || echo "Repo no encontrado")
echo "ECR_REPOSITORY_URI: $ECR_URI"

# Nombres de ECS (Basados en el estándar de Terraform)
echo "ECS_CLUSTER_NAME: spring-hockey-cluster"
echo "ECS_SERVICE_NAME: spring-hockey-service"

echo "-----------------------------------------------------"
echo "✅ Script finalizado. ¡No olvides actualizar los Secrets!"