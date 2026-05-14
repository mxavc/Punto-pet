# Compilar usando Maven
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Imagen ligera de Java
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
# .war generado (utiliza configuracion pom.xml genere .war)
COPY --from=build /app/target/*.war app.war

# Puerto interno de Spring Boot
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.war"]