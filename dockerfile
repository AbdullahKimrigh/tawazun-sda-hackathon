FROM maven:3.6.3-openjdk-11 AS build

WORKDIR /app

COPY pom.xml /app/pom.xml
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "clean"]

# Adding source, compile and package into a fat jar
COPY ["/src", "/app/src"]
RUN ["mvn", "package"]

FROM openjdk:11-jre

COPY --from=build /app/target/tawazun.war .

EXPOSE 8080
CMD ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-jar", "/tawazun.war"]