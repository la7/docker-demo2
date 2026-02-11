#!/bin/bash

# ==============================================================================
# Script: deploy-local.sh
# Objetivo: Automatizar el despliegue del microservicio en LocalStack (Mac)
# ==============================================================================

echo "🚀 Iniciando despliegue local..."

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

# 4. Build de la imagen Docker
echo "🐳 Construyendo imagen Docker..."
docker build -t springboot-app:latest .

# 5. Obtener URI del ECR y subir imagen
echo "📤 Subiendo imagen al ECR de LocalStack..."
ECR_URI=$(tflocal ecr describe-repositories --repository-names springboot-app --query "repositories[0].repositoryUri" --output text)

if [ -z "$ECR_URI" ] || [[ "$ECR_URI" == *"terraform"* ]]; then
    echo "❌ Error: No se pudo obtener la URI del ECR. Verifica tu main.tf"
    exit 1
fi

echo "✅ URI obtenida: $ECR_URI"
docker tag springboot-app:latest ${ECR_URI}:latest
docker push ${ECR_URI}:latest

echo "✨ ¡Despliegue completado con éxito!"
echo "🔍 Puedes probar la app en: http://localhost:8080/actuator/health"