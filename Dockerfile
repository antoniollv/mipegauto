FROM openjdk:8-jre-slim-bullseye

RUN mkdir -p /pegauto/directorios
#RUN mkdir  /pegauto/directorios/atributos
#RUN mkdir /pegauto/directorios/bat
#RUN mkdir /pegauto/directorios/descargas
#RUN mkdir /pegauto/directorios/enviados
#RUN mkdir /pegauto/directorios/error
#RUN mkdir /pegauto/directorios/logs
#RUN mkdir /pegauto/directorios/subidas
WORKDIR /pegauto
COPY log4j.properties ./
COPY pegauto.properties ./
COPY pegauto.jar ./
VOLUME ["/pegauto/directorios"]

ENTRYPOINT [ "java", "-jar", "pegauto.jar"]

