## 构建阶段
#FROM openjdk:17-slim AS build
#ENV HOME=/usr/app
#RUN mkdir -p $HOME
#WORKDIR $HOME
#ADD . $HOME
## 为 mvnw 脚本添加执行权限
#RUN chmod +x mvnw
#RUN --mount=type=cache,target=/root/.m2 ./mvnw -f $HOME/pom.xml clean package
#
## 打包阶段
#FROM openjdk:17-slim
#ARG JAR_FILE=/usr/app/target/*.jar
#COPY --from=build $JAR_FILE /app/runner.jar
#EXPOSE 8021
#ENTRYPOINT java -jar /app/runner.jar

# 第一阶段：构建JAR
FROM maven:3.8.6-eclipse-temurin-17-alpine AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B  # 提前下载依赖利用缓存
COPY src ./src
RUN mvn package -DskipTests      # 构建可执行JAR,跳过测试

# 第二阶段：最小化运行时镜像
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]