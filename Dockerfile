# 构建阶段
FROM openjdk:17-slim AS build
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD . $HOME
# 为 mvnw 脚本添加执行权限
RUN chmod +x mvnw
RUN --mount=type=cache,target=/root/.m2 ./mvnw -f $HOME/pom.xml clean package

# 打包阶段
FROM openjdk:17-slim
ARG JAR_FILE=/usr/app/target/*.jar
COPY --from=build $JAR_FILE /app/runner.jar
EXPOSE 8021
ENTRYPOINT java -jar /app/runner.jar