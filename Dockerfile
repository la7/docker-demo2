#FROM openjdk:11
#COPY ./target/docker-demo-0.0.1-SNAPSHOT.jar docker-demo-0.0.1-SNAPSHOT.jar
#CMD ["java","-jar","docker-demo-0.0.1-SNAPSHOT.jar"]
#EXPOSE 8080

# Etapa 1: Compilación
FROM --platform=$BUILDPLATFORM maven:3.8.5-amazoncorretto-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa 2: Ejecución (Forzamos amd64 para AWS ECS)
FROM --platform=$BUILDPLATFORM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]