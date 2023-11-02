FROM maven:3.9.2-amazoncorretto-17 as build

RUN mkdir microservices

WORKDIR /microservices

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src src

RUN mvn package

FROM amazoncorretto:17

##FROM openjdk:17-jre-alpine

VOLUME /hello-service

COPY --from=build /microservices/target/*.jar hello-service.jar

ENTRYPOINT ["java","-jar","hello-service.jar"]