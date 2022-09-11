FROM maven:3.5-jdk-8-alpine AS build

WORKDIR /app

COPY pom.xml /app/pom.xml
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "verify"]

# Adding source, compile and package into a fat jar
COPY ["src/main", "/app/src/main"]
RUN ["mvn", "package"]

FROM openjdk:8-jre-alpine

COPY --from=build /app/target/worker-jar-with-dependencies.jar /

CMD ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-jar", "/worker-jar-with-dependencies.jar"]