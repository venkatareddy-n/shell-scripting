#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=/home/ec2-user/logs

if [ -d $SOURCE_DIR ]
then
    echo -e "$SOURCE_DIR Directory $G Available $N"
else    
    echo -e "$SOURCE_DIR Directory $R Not Available $N"
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)

echo "old log files are $FILES"

while IFS= read -r file #IFS,internal field seperatpor, empty it will ignore while space.-r is for not to ingore special charecters like /
do
    echo "Deleting log files: $file"
    rm -rf $file
done <<< $FILES