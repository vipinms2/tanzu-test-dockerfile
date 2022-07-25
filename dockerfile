ARG BUILDER_IMAGE=tapvipins2.azurecr.io/images/maven:latest
ARG RUNTIME_IMAGE=tapvipins2.azurecr.io/images-java/java17-debian11:latest


FROM $BUILDER_IMAGE AS build

        ADD . .
        RUN unset MAVEN_CONFIG && ./mvnw clean package -B -DskipTests


FROM $RUNTIME_IMAGE AS runtime

        COPY --from=build /target/demo-0.0.1-SNAPSHOT.jar /demo.jar
        CMD [ "/demo.jar" ]
