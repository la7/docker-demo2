#!/bin/bash
set -e

echo "🚀 Iniciando despliegue en LocalStack..."

# 1. Configurar credenciales temporales para la sesión
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1

# 2. Reiniciar Infraestructura
echo "🏗️  Aplicando infraestructura..."
tflocal init
tflocal apply -auto-approve

# 3. Build de la imagen
echo "🐳 Construyendo imagen Docker (AMD64)..."
docker build -t springboot-app:latest .

# 4. Obtener URI del ECR de LocalStack de forma segura
echo "📤 Obteniendo URI del ECR..."
# Usamos el comando directo de AWS apuntando al endpoint de LocalStack
ECR_URI=$(aws --endpoint-url=http://localhost:4566 ecr describe-repositories \
  --repository-names springboot-app \
  --region us-east-1 \
  --query "repositories[0].repositoryUri" \
  --output text)

if [ -z "$ECR_URI" ]; then
    echo "❌ Error: No se encontró el repositorio 'springboot-app' en LocalStack."
    exit 1
fi

echo "✅ URI encontrada: $ECR_URI"

# 5. Tag y Push
docker tag springboot-app:latest ${ECR_URI}:latest
docker push ${ECR_URI}:latest

echo "✨ ¡Listo! Imagen subida a LocalStack."