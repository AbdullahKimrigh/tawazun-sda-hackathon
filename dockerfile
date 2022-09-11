FROM maven:3.6.0-jdk-11-slim AS build

WORKDIR /app

COPY pom.xml /app/pom.xml
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "clean"]

ENV DB_URL=mysql
ENV DB_PORT=3306
ENV DB_NAME=DB_tawazun
ENV DB_USERNAME=root
ENV DB_PASSWORD=root

COPY ["/src", "/app/src"]
RUN ["mvn", "package"]

FROM openjdk:11-jre-slim

COPY --from=build /app/target/tawazun.war /

CMD ["java", "-jar", "/tawazun.war"]
