#!/bin/bash
# Bash script for backing up image folder on Asgard to AWS S3
# Needs to be used in conjunction with s3cmd installed on server and configured.
# Daniel Pett, 5th May 2015
# To use sh /path/to/script/s3LoopSync.sh

for d in /var/www/beowulf/public_html/images/*/ ; do
    echo "$d"
    dir=$(basename "$d")
    echo "$dir"
    s3cmd sync $d --skip-existing --preserve --verbose --recursive  --exclude 'zoom/' --exclude 'small/' --exclude 'medium/' --exclude 'display/' s3://findsorguk-images/$dir/
done;
