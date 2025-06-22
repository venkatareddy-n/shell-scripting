#!/bin/bash

SOURCE_DIR=$1
BACKUP_DIR=$2
DAYS=${3:-14} #if $3 is empty, default is 14 days.
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

USAGE(){
    echo -e "$R USAGE:: $N sh 19-backup.sh <source> <destination> <days(optional)>"
}
#check the source and destination are provided

if [ $# -lt 2 ]
then
    USAGE
    exit 1
fi

if [ ! -d $SOURCE_DIR ]
then
    echo "$SOURCE_DIR does not exist...Please check"
fi

if [ ! -d $BACKUP_DIR ]
then
    echo "$BACKUP_DIR does not exist...Please check"
fi

FILES=$(find ${SOURCE_DIR} -name "*.log" -mtime +14)

if [ ! -z "$FILES" ] #true if FILES is empty, ! nakes it expression false
then
    echo "Files are found"
    ZIP_FILE="$BACKUP_DIR/Backup-logs-$TIMESTAMP.zip"
    find ${SOURCE_DIR} -name "*.log" -mtime +14 | zip "$ZIP_FILE" -@

    #check if zip file is successfully created or not
    if [ -f $ZIP_FILE ]
    then
        echo "Successfully zippped files older than $DAYS"
        #remove the files after zipping
        while IFS= read -r file #IFS,internal field seperatpor, empty it will ignore while space.-r is for not to ingore special charecters like /
        do
            echo "Deleting file: $file"
            rm -rf $file
        done <<< $FILES
    else
        echo "Zipping the files is failed"
        exit 1
    fi
else
    echo "No files older than $DAYS"
fi