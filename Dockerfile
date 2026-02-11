#FROM openjdk:11
#COPY ./target/docker-demo-0.0.1-SNAPSHOT.jar docker-demo-0.0.1-SNAPSHOT.jar
#CMD ["java","-jar","docker-demo-0.0.1-SNAPSHOT.jar"]
#EXPOSE 8080

# Etapa 1: Compilación (Build)
# Usamos Amazon Corretto 17, que es ultra estable para AWS
FROM maven:3.8.5-amazoncorretto-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
# Compilamos el proyecto
RUN mvn clean package -DskipTests

# Etapa 2: Ejecución (Runtime)
# Usamos una imagen ligera de Alpine para el JRE
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Copiamos el JAR desde la etapa de compilación
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]