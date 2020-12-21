FROM maven:latest
COPY ./ /src/
RUN ls /src
WORKDIR /src
RUN mvn clean install

FROM adoptopenjdk/openjdk11
WORKDIR /bin
RUN mkdir agents
COPY ../agents/* ./agents/
COPY --from=0 /src/target/poc-newrelic-oc-thorntail.jar .

EXPOSE 8080
EXPOSE 8778
ENTRYPOINT ["java", "-jar", "-javaagent:/bin/agents/newrelic.jar", "-javaagent:/bin/agents/jolokia-jvm-1.6.2-agent.jar=port=8778,host=0.0.0.0", "-Djava.net.preferIPv4Stack=true", "/bin/poc-newrelic-oc-thorntail.jar"]
