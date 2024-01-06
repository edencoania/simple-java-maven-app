FROM maven:3.8.6 as compiler

COPY . .

#RUN mvn verify

#RUN mvn -B -DskipTests clean package
#RUN mvn release
RUN mvn jar:jar install:install help:evaluate -Dexpression=project.name
NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`


FROM openjdk:23-slim

COPY --from=compiler target/*.jar .

CMD java -jar target/*.jar

#CMD java -jar my-app-1.0-SNAPSHOT.jar
