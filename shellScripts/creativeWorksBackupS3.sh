#!/bin/bash
FILE="creativeworks.csv"
ZIPFILE="creativeworks.zip"
BACK="/var/www/beowulf/backups/csv/creativeworks/"
FIELDS="id,fourFigureLat,fourFigureLon,fromdate,todate,ruler,broadperiod,mint,material,denomination,objecttype,knownas,countyID,discovered,created,updated"
BUCKET="s3://findsorguk-creativeworks"
#zip=/usr/bin/zip
curl "http://81.29.66.141:8080/solr/objects/select?indent=on&version=2.2&q=*%3A*&fq=gridref:*&start=0&rows=1000000&fl=$FIELDS&qt=&wt=csv&explainOther=&hl.fl=" -o $BACK$FILE
cd $BACK
zip $ZIPFILE $FILE
rm $BACK$FILE
/usr/local/bin/s3cmd sync --delete-removed  $BACK $BUCKET
find $BACK* -type f -mtime +5 -exec rm '{}' \;
/usr/local/bin/s3cmd setacl  $BUCKET --acl-public --recursive