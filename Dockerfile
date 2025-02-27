FROM openjdk:17

WORKDIR /usrapp/bin

ENV PORT 30000

COPY target/classes /usrapp/bin/classes
COPY target/dependency /usrapp/bin/dependency

COPY src/main/resources/web/web /usrapp/bin/www

CMD ["java", "-cp", "./classes:./dependency/*", "co.edu.eci.arep.HttpServer", "co.edu.eci.arep.GreetingController"]

