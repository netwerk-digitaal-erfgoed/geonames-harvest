#!/bin/bash
CONFIG_DIR="$PWD/config"
DATA_DIR="./data"
mkdir -p $DATA_DIR

# specify countries to download
#country_files="NL BE DE "
country_files="allCountries"
cp $CONFIG_DIR/headers-gn.csv $DATA_DIR/geonames.csv
for cfile in $country_files; do
    mkdir temp
    cd temp
    curl -O "https://download.geonames.org/export/dump/$cfile.zip"
    unzip "$cfile.zip"
    cd ..
    cat "temp/$cfile.txt" >> $DATA_DIR/geonames.csv
    rm -rf temp
done

# create foreign keys 'adm1' and 'adm2' for the admin1code and admin2code tables
# $9=country code, $11=admin1 code, $12=admin2 code
# Explicit NONE so we don't need OPTIONAL joins, which speeds up the mapping process.
awk 'BEGIN{FS=OFS="\t"} {print $0, (NR > 1 ? $9"."$11 : "adm1"), (NR > 1 ? ($12 != "" ? $9"."$11"."$12 : "NONE") : "adm2")}' $DATA_DIR/geonames.csv > $DATA_DIR/geonamesplus.csv
rm $DATA_DIR/geonames.csv

# download latest version of generic files
cp $CONFIG_DIR/headers-admin1-codes.csv $DATA_DIR/admin1-codes.csv
curl "https://download.geonames.org/export/dump/admin1CodesASCII.txt" >> $DATA_DIR/admin1-codes.csv

cp $CONFIG_DIR/headers-admin2-codes.csv $DATA_DIR/admin2-codes.csv
curl "https://download.geonames.org/export/dump/admin2Codes.txt" >> $DATA_DIR/admin2-codes.csv
