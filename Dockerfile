FROM maven:3.6.3-jdk-8 AS build-env
WORKDIR /PetClinic_DockerHub

COPY pom.xml ./
RUN mvn dependency:go-offline
RUN mvn spring-javaformat:help

COPY . ./
RUN mvn spring-javaformat:apply
RUN mvn package -DfinalName=petclinic

FROM openjdk:8-jre-alpine
EXPOSE 8080
WORKDIR /PetClinic_DockerHub

COPY --from=build-env PetClinic_DockerHub/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar ./petclinic.jar
CMD ["/usr/bin/java", "-jar", "/PetClinic_DockerHub/petclinic.jar"]