#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Please Run Script with ROOT USER to install packages"
    exit 1  # Exit 1 means fail and stop executing script
fi

dnf list installed mysql

if [ $? -ne 0 ]
then 
    echo "MYSQL is not installed, going to install now..."
    dnf install mysql -y
    if [ $? -ne 0]
    then
        echo "mysql installation is FAIL check it"
        exit 1
    else
        echo "mysql installation is SUCCESS"
    fi
else    
    echo "MYSQL is already installed, Nothing to do..."
fi

dnf list installed nginx

if [ $? -ne 0 ]
then 
    echo "NGINX is not installed, going to install now..."
    dnf install nginx -y
    if [ $? -ne 0 ]
    then
        echo "NGINX installation is FAIL check it"
        exit 1
    else
        echo "NGINX installation is SUCCESS"
    fi
else    
    echo "NGINX is already installed, Nothing to do..."
fi