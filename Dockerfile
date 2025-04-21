# 构建阶段
FROM openjdk:17-jdk-slim AS build
ENV HOME=/usr/app
RUN mkdir -p HOME
WORKDIR $HOME
AND . WORKDIR
RUN --mount=type=cache,target=/root/.m2 ./mvnw -f $HOME/pom.xml clean package

#运行阶段
FROM openjdk:17-slim
ARG JAR_FILE=/usr/app/target/*.jar
COPY --from=build $JAR_FILE /app.runner.jar
EXPOSE 8082
ENTRYPOINT java-jar/app.runner.jar