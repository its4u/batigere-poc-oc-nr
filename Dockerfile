FROM maven:3.8.1-openjdk-11
COPY ./ /src/
RUN ls /src
WORKDIR /src
RUN mvn clean install

FROM image-registry.openshift-image-registry.svc:5000/demo-ocp-nr/java-new-relic-image
WORKDIR /bin
COPY --from=0 /src/target/poc-newrelic-oc-thorntail.jar .

EXPOSE 8080
EXPOSE 8778
ENTRYPOINT ["java", "-jar", "-javaagent:/bin/agents/newrelic.jar", "-javaagent:/bin/agents/jolokia-jvm-1.6.2-agent.jar=port=8778,host=0.0.0.0", "-Djava.net.preferIPv4Stack=true", "/bin/poc-newrelic-oc-thorntail.jar"]
