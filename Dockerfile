FROM adoptopenjdk/openjdk17:alpine-slim
RUN apk add -U tzdata
ENV TZ America/Lima
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime
RUN echo "${TZ}" > /etc/timezone
VOLUME /tmp
EXPOSE 8761
ADD ./target/sprigboot-servicio-eureka-server.jar eureka.jar
ENTRYPOINT ["java", "-jar", "/eureka.jar"]
