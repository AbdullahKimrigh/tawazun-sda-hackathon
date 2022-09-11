FROM maven:3.6.0-jdk-11-slim AS build

WORKDIR /app

COPY pom.xml /app/pom.xml
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "compile"]

# Adding source, compile and package into a fat jar
COPY ["src/main", "/app/src/main"]
RUN ["mvn", "package"]

FROM openjdk:11-jre-slim

COPY --from=build /app/target/*.war /

EXPOSE 8080
CMD ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-jar", "/tawazun-sda-hackathon.war"]