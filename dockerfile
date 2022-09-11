FROM maven:3.6-jdk-11-alpine AS build

WORKDIR /app

COPY pom.xml /app/pom.xml
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "clean"]

# Adding source, compile and package into a fat jar
COPY ["/src", "/app/src"]
RUN ["mvn", "package"]

FROM openjdk:11-jre-alpine

COPY --from=build /app/target/tawazun.war /

EXPOSE 8080
CMD ["java", "-jar", "/tawazun.war"]
