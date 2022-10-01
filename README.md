# ScheduledHTTPRequest

A simple container that does HTTP GET requests on a given interval.

Set the URL via POLL_URL environment variable or via application.properties file.

Set the interval via POLL_DELAY environment variable or via application.properties file. Example value is 30s for 30 seconds.

## Running the application in dev mode

You can run your application in dev mode that enables live coding using:
```shell script
./mvnw compile quarkus:dev
```

## Packaging and running the application with Dockerfile

Build with Docker:
```shell script
docker build -t scheduledhttprequest .
```

Run with Docker:
```shell script
docker run --name scheduledhttprequest scheduledhttprequest
```

## Packaging and running the application

The application can be packaged using:
```shell script
./mvnw package
```
It produces the `quarkus-run.jar` file in the `target/quarkus-app/` directory.
Be aware that it’s not an _über-jar_ as the dependencies are copied into the `target/quarkus-app/lib/` directory.

The application is now runnable using `java -jar target/quarkus-app/quarkus-run.jar`.

If you want to build an _über-jar_, execute the following command:
```shell script
./mvnw package -Dquarkus.package.type=uber-jar
```

The application, packaged as an _über-jar_, is now runnable using `java -jar target/*-runner.jar`.
