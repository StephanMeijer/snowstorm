FROM openjdk:8-jdk-alpine
LABEL maintainer="SNOMED International <tooling@snomed.org>"

ARG SUID=1042
ARG SGID=1042

VOLUME /tmp

# Create a working directory
RUN mkdir /app
WORKDIR /app

RUN mkdir /snomed-drools-rules

RUN wget https://github.com/IHTSDO/snowstorm/releases/download/4.1.0/snowstorm-4.1.0.jar -O snowstorm.jar

ADD Procfile .

# Create the snowstorm user
RUN addgroup -g $SGID snowstorm && \
    adduser -D -u $SUID -G snowstorm snowstorm

# Change permissions.
RUN chown -R snowstorm:snowstorm /app

RUN apk --no-cache add curl

# Run as the snowstorm user.
USER snowstorm
