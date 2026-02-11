#FROM openjdk:11
#COPY ./target/docker-demo-0.0.1-SNAPSHOT.jar docker-demo-0.0.1-SNAPSHOT.jar
#CMD ["java","-jar","docker-demo-0.0.1-SNAPSHOT.jar"]
#EXPOSE 8080

# Etapa 1: Compilación (Build)
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
# Copiamos el pom y el código fuente
COPY pom.xml .
COPY src ./src
# Compilamos y generamos el JAR ignorando los tests para ganar velocidad
RUN mvn clean package -DskipTests

# Etapa 2: Ejecución (Runtime)
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Copiamos el JAR generado en la etapa anterior con un nombre genérico
COPY --from=build /app/target/*.jar app.jar
# Exponemos el puerto
EXPOSE 8080
# Ejecutamos la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]