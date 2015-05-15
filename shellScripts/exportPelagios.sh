#!/bin/bash
DATE=$(date +"%F")
FILE="pelagios-$DATE.rdf"
ZIP="pelagios-$DATE"
BACK="/var/www/beowulf/public_html/rdf/"
curl "http://81.29.66.140:8080/solr/objects/select?indent=on&version=2.2&q=objecttype%3Acoin+pleiadesID%3A%5B*+TO+*%5D&fq=&start=0&rows=10000000&fl=id%2Cobjecttype%2CnomismaMintID%"
cd $BACK
zip $ZIP.zip $FILE
rm $FILE
s3cmd sync $BACK s3://findsorguk-pelagios/
find $BACK* -type f -mtime +5 -exec rm '{}' \;

