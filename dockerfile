FROM maven:3.6.3-openjdk-11 AS build
FROM openjdk:11-jre

COPY . .

RUN ["mvn", "clean"]
RUN ["mvn", "package"]

EXPOSE 8080

CMD ["java", "-jar", "/*.war"]