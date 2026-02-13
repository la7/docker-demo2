#!/bin/bash

# ==============================================================================
# Script: deploy-local.sh
# Objetivo: Automatizar el despliegue del microservicio en LocalStack (Mac)
# ==============================================================================

echo "🚀 Iniciando despliegue en LocalStack..."

# 0. Configurar credenciales temporales para la sesión
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1

# 1. Asegurar que Docker está corriendo
if ! docker info > /dev/null 2>&1; then
    echo "❌ Error: Docker no está corriendo. Abre Docker Desktop e intenta de nuevo."
    exit 1
fi

# 2. Iniciar LocalStack si no está corriendo
if ! localstack status services > /dev/null 2>&1; then
    echo "📦 Iniciando LocalStack..."
    localstack start -d
    sleep 5 # Esperar a que los servicios despierten
fi

# 3. Aplicar Infraestructura con Terraform
echo "🏗️ Aplicando infraestructura con Terraform..."
tflocal init
tflocal apply -auto-approve

# 3. Build de la imagen
echo "🐳 Construyendo imagen Docker (AMD64)..."
docker build -t springboot-app:latest .

## 4. Obtener URI del ECR de LocalStack de forma segura
#echo "📤 Obteniendo URI del ECR..."
## Usamos el comando directo de AWS apuntando al endpoint de LocalStack
##ECR_URI=$(aws --endpoint-url=http://localhost:4566 ecr describe-repositories \
##  --repository-names springboot-app \
##  --region us-east-1 \
##  --query "repositories[0].repositoryUri" \
##  --output text)
## Cambiar localhost por 127.0.0.1
#ECR_URI=$(aws --endpoint-url=http://127.0.0.1:4566 ecr describe-repositories \
#  --repository-names springboot-app \
#  --region us-east-1 \
#  --query "repositories[0].repositoryUri" \
#  --output text)

# 3. Aplicar Infraestructura con Terraform indicando la carpeta
echo "🏗️ Aplicando infraestructura desde la carpeta /terraform..."
tflocal -chdir=terraform init
tflocal -chdir=terraform apply -auto-approve

# 4. Obtener URI del ECR
echo "📤 Obteniendo URI del ECR..."
# IMPORTANTE: Usamos tflocal output para obtener
# la URL directamente de Terraform
ECR_URI=$(tflocal -chdir=terraform output -raw ecr_repository_url)

if [ -z "$ECR_URI" ] || [ "$ECR_URI" == "None" ]; then
    echo "❌ Error: Terraform no devolvió una URL. Verifica tus archivos en /terraform."
    exit 1
fi
echo "URI: $ECR_URI"

if [ -z "$ECR_URI" ]; then
    echo "❌ Error: No se encontró el repositorio 'springboot-app' en LocalStack."
    exit 1
fi
echo "URI: $ECR_URI"

echo "✅ URI encontrada: $ECR_URI"

# 5. Tag y Push
docker tag springboot-app:latest ${ECR_URI}:latest
docker push ${ECR_URI}:latest

echo "✨ ¡Despliegue completado con éxito!"
echo "🔍 Puedes probar la app en: http://localhost:8080/actuator/health"