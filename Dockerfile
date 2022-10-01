#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app

#running the tests require the securityToken
RUN mvn -f /home/app/pom.xml clean package -DskipTests

#
# Package stage
#
FROM registry.access.redhat.com/ubi8/openjdk-11:1.11

ENV LANGUAGE='en_US:en'

# We make four distinct layers so if there are application changes the library layers can be re-used
COPY --from=build --chown=185 /home/app/target/quarkus-app/lib/ /deployments/lib/
COPY --from=build --chown=185 /home/app/target/quarkus-app/*.jar /deployments/
COPY --from=build --chown=185 /home/app/target/quarkus-app/app/ /deployments/app/
COPY --from=build --chown=185 /home/app/target/quarkus-app/quarkus/ /deployments/quarkus/

EXPOSE 8080
USER 185
ENV AB_JOLOKIA_OFF=""
ENV JAVA_OPTS="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"
ENV JAVA_APP_JAR="/deployments/quarkus-run.jar"