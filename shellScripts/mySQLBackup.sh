#!/bin/sh
# Replace variables in curly brackets please
BACK={PATH/TO/BACKUPS}
cd $BACK
DATE=$(date +"%F")
FILE=$DATE.sql
PATH=$BACK$FILE
/usr/bin/mysqldump -u {USERNAME} -p{PASSWORD} {DBNAME} finds findspots coins bibliography publications people users hoards organisations archaeology coinsummary content news events rallies researchprojects > $BACK$DA$
BUCKET={BUCKETNAME}
/bin/gzip $BACK$FILE
/usr/bin/find $BACK* -type f -mtime +30 -exec rm '{}' \;
/usr/bin/s3cmd sync --delete-removed --exclude '*.sql' $BACK $BUCKET