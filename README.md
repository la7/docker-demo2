# 🚀 Spring Boot Hockey API - AWS Cloud-Native 
## Implementation
Esta es una evolución del proyecto docker-demo2, transformada en una arquitectura de microservicios productiva. La aplicación permite gestionar los jugadores y equipos de los Montreal Canadiens, utilizando una infraestructura automatizada en Amazon Web Services (AWS).

## 🏗️ Arquitectura del Sistema 

El proyecto implementa los siguientes conceptos avanzados de nube:

Infraestructura como Código (IaC): 

* Desplegada con Terraform.
* Orquestación de Contenedores: 
* Ejecutado en AWS ECS (Elastic Container Service) con tecnología Fargate (Serverless).
* Persistencia: Base de datos gestionada Amazon RDS (MySQL 8.0).
* Seguridad y Redes: Aislamiento mediante VPC, Subredes privadas, IAM Roles y Security Groups.Pipeline CI/CD: Automatización total mediante GitHub Actions.

🛠️ Stack Tecnológico Backend: 

Java 17, Spring Boot 3, Spring Data JPA.Base de Datos: MySQL 8.0.DevOps: Docker (Multi-stage), Terraform, GitHub Actions.Cloud: AWS (ECR, ECS, RDS, VPC, IAM).

## 🚀 Guía de Ejecución en CloudShell 
Sigue este orden exacto en la terminal de AWS para desplegar el proyecto:

#### 1. Preparar el Entorno y Terraform
Bash

##### 1.1. Configurar identidad
```

   git config --global user.email "tu@email.com" 
   git config --global user.name "Tu Nombre"

```
##### 1.2. Clonar y desplegar infraestructura
```
git clone https://github.com/TU_USUARIO/docker-demo2.git
cd docker-demo2/terraform
terraform init
terraform apply -auto-approve
cd ..
```
##### 1.3. Inyección Dinámica de Datos

Este paso adapta el archivo de configuración de AWS a los recursos recién creados:
Bash

Captura de datos reales del lab
```   
export ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
export RDS_ENDPOINT=$(aws rds describe-db-instances --query "DBInstances[0].Endpoint.Address" --output text)
export ROLE_ARN=$(aws iam get-role --role-name ecsTaskExecutionRole --query "Role.Arn" --output text)
```
##### 1.4 Actualización del plano de despliegue (Task Definition)
```
sed -i "s|<TU_ID_CUENTA>|$ACCOUNT_ID|g" .aws/task-definition.json
sed -i "s/reemplazar-con-endpoint-de-rds/$RDS_ENDPOINT/g" .aws/task-definition.json
sed -i "s|\"executionRoleArn\": \".*\"|\"executionRoleArn\": \"$ROLE_ARN\"|g" .aws/task-definition.json
```
##### 1.5. Disparar CI/CD
Bash
###### Subir cambios para activar GitHub Actions
```
git add .
git commit -m "🚀 Deploying to AWS Cloud Quest"
git push origin main
```   
## 📖 Documentación de la API

Endpoints Principales

Método Endpoint

Descripción
```
GET/health                      # Verificación de salud (App + DB Connection)
GET/api/team/{year}             # Obtener equipo por año
POST/api/team/{year}            # Agregar un nuevo jugador al equipo
PUT/api/player/captain/{id}     # Asignar capitanía a un jugador🧪 
```
#### Troubleshooting y Pruebas

Si la aplicación no responde, verifica los logs en CloudWatch o realiza un Smoke Test:

Bash

Obtener DNS del Load Balancer
```
export LB_URL=$(aws elbv2 describe-load-balancers --query "LoadBalancers[0].DNSName" --output text)
```
# Verificar conexión
```
curl -v http://$LB_URL/health
```
📁 Estructura del Repositorio
Plaintext
```
├── .github/workflows/  # Automatización de despliegue (YAML)
├── .aws/               # Definición de tareas para AWS ECS (JSON)
├── terraform/          # Código de Infraestructura (HCL)
├── src/                # Código fuente Java/Spring
├── Dockerfile          # Imagen optimizada Multi-stage
└── pom.xml             # Dependencias de Maven (MySQL v8.3.0)
```

# docker-demo2


## Project description

This is a REST API project to add players and view Montreal Canadians' Hokey Team.


PS : The project can be upgraded for demonstration purpose.


## Models


Team


```

{

    "id": long,

    "coach": string

    "teamYear" : long

    "players": [

        {

            "number": long,

            "name": string,

            "lastname": string,

            "position":"defenseman",

            "isCaptain" : boolean

        }

    ]

}


```

## Endpoints

### GET /api/team/{year}

-   Request: Year in the URI
-   Response: Team Object
-   Status: 200 OK


    http://localhost:8080/api/team/2022
    {
       "id":2,
       "coach":"Dominique Ducharme",
       "teamYear":"2022",
       "players":[
          {
             "number":31,
             "name":"Carey",
             "lastname":"Price",
             "position":"goaltender"
          },
          {
             "number":14,
             "name":"Nick",
             "lastname":"Suzuki",
             "position":"forward"
          },
          {
             "number":15,
             "name":"Jesperi",
             "lastname":"Kotkaniemi",
             "position":"forward"
          },
          {
             "number":71,
             "name":"Jake",
             "lastname":"Evans",
             "position":"forward"
          },
          {
             "number":27,
             "name":"Alexander",
             "lastname":"Romanov",
             "position":"defenseman"
          },
          {
             "number":6,
             "name":"Shea",
             "lastname":"Weber",
             "position":"defenseman",
             "isCaptain" : true
          }
       ]
    }

    http://localhost:8080/api/team/2022
    {
       "id":1,
       "coach":"Dominique Ducharme",
       "teamYear":"2022",
       "players":[
          {
             "number":31,
             "name":"Carey",
             "lastname":"Price",
             "position":"goaltender"
          },
          {
             "number":14,
             "name":"Nick",
             "lastname":"Suzuki",
             "position":"forward"
          },
          {
             "number":15,
             "name":"Jesperi",
             "lastname":"Kotkaniemi",
             "position":"forward"
          },
          {
             "number":71,
             "name":"Jake",
             "lastname":"Evans",
             "position":"forward"
          },
          {
             "number":27,
             "name":"Alexander",
             "lastname":"Romanov",
             "position":"defenseman"
          },
          {
             "number":6,
             "name":"Shea",
             "lastname":"Weber",
             "position":"defenseman",
             "isCaptain" : true
          }
       ]
    }

### POST /api/team/{Year}

-   Request: Player Object in the body
-   Response: Created Player Object
-   Status: 201 CREATED


```
http://localhost:8080/api/player  --header "Content-Type:application/json"

{
  "number":99,
  "name":"Marion",
  "lastname":"Félix",
  "position":"forward",
  "isCaptain" : false
}

```

### PUT /api/player/captain/{ID}

-   Request: ID of Player in the URI
-   Response: Object Player
-   Status: 200 OK
