FROM eclipse-temurin:17
LABEL org.opencontainers.image.source="https://github.com/netwerk-digitaal-erfgoed/geonames-harvester"
WORKDIR /app
RUN mkdir bin
RUN curl -L https://github.com/SPARQL-Anything/sparql.anything/releases/download/v1.0-DEV.6/sparql-anything-v1.0-DEV.6.jar -o bin/sparql-anything-v1.0-DEV.6.jar
RUN apt-get update && apt-get install zip -y && rm -rf /var/lib/apt/lists/*
COPY . .
