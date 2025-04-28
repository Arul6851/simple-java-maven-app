FROM maven:latest AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM tomcat:latest
WORKDIR /usr/local/tomcat/webapps
COPY --from=build /app/target/*.war ./app.war
EXPOSE 8080
CMD ["./catalina.bat"]