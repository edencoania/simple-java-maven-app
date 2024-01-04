FROM maven:3.8.6 as compiler

COPY . .

RUN mvn verify

RUN mvn -B -DskipTests clean package



FROM openjdk:23-slim

COPY --from=compiler target/my-app-1.0-SNAPSHOT.jar .

CMD java -jar my-app-1.0-SNAPSHOT.jar
