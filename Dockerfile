# ---------- Stage 1: Build the WAR file using Maven ----------
FROM maven:3.8.4-eclipse-temurin-17 AS build

WORKDIR /app
COPY . .
RUN mvn package

# ---------- Stage 2: Deploy WAR into Tomcat ----------
FROM tomcat:latest

COPY --from=build /app/webapp/target/webapp.war /usr/local/tomcat/webapps/webapp.war

# Optional: Restore default Tomcat apps (manager, docs, etc.)
RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
