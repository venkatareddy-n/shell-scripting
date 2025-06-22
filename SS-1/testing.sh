#!/bin/bash

DAYS=10

FILES=$(find /home/ec2-user/logs -name "*.log" -mtime +$DAYS)

echo "$DAYS days old Log files are $FILES"

