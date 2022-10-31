FROM maven:alpine as build
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD . $HOME
RUN mvn clean package

FROM openjdk:8-alpine
ARG JAR_FILE=/usr/app/target/*.jar
COPY --from=build ${JAR_FILE} /app/spring-boot-docker.jar
ENTRYPOINT ["java","-jar","/app/spring-boot-docker.jar"]
EXPOSE 8080