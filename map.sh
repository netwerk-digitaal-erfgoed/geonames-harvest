#! /bin/bash
DATA_DIR="$PWD/data"
BIN_DIR="$PWD/bin"
CONFIG_DIR="$PWD/config"
SPARQL_ANYTHING_VERSION="v1.0-DEV.6"
JAR="sparql-anything-${SPARQL_ANYTHING_VERSION}.jar"

# Download SPARQL Anything CLI.
echo "https://github.com/SPARQL-Anything/sparql.anything/releases/download/$SPARQL_ANYTHING_VERSION/$JAR"

curl --skip-existing -L "https://github.com/SPARQL-Anything/sparql.anything/releases/download/$SPARQL_ANYTHING_VERSION/$JAR" -o $BIN_DIR/$JAR

# Map admin codes.
java -jar $BIN_DIR/$JAR -q $CONFIG_DIR/admin-codes.rq > $DATA_DIR/admin-codes.ttl

# Map places, side-loading admin codes.
java -jar $BIN_DIR/$JAR -q $CONFIG_DIR/places.rq -l $DATA_DIR/admin-codes.ttl > $DATA_DIR/geonames.ttl
