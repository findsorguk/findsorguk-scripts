#!/bin/bash
# Daniel Pett, 6th May 2015
DATE=$(date +"%F")
FILE="allfinds-$DATE.csv"
BACK="/var/www/beowulf/backups/csv/allFinds/"
FIELDS="id,old_findID,objecttype,broadperiod,subperiodFrom,subperiodTo,periodFromName,periodToName,fromdate,todate,description,notes,workflow,materialTerm,secondaryMaterialTerm,sub"
#zip=/usr/bin/zip
BUCKET="s3://findsorguk"
curl "http://81.29.66.141:8080/solr/beowulf/select?indent=on&version=2.2&q=*%3A*&fq=&start=0&rows=10000000&fl=$FIELDS&qt=&wt=csv&explainOther=&hl.fl=" -o $BACK$FILE
cd $BACK
zip $FILE.zip $FILE
#rm $BACK$FILE
find $BACK* -type f -mtime +5 -exec rm '{}' \;
/usr/local/bin/s3cmd sync --delete-removed $BACK $BUCKET
/usr/local/bin/s3cmd sync setacl --acl-public --recursive