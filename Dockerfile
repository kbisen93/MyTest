FROM alpine/git
WORKDIR /app
RUN git clone https://github.com/kbisen93/MyTest.git

FROM maven:3.5-jdk-8-alpine
WORKDIR /app
COPY --from=0 /app/MyTest /app
RUN mvn clean package install

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=1 /app/target/test-maven-0.0.1.jar /app
ENTRYPOINT ["java","-cp","test-maven-0.0.1.jar","com.optum.rxclaim.App"]
