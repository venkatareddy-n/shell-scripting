#!/bin/bash

USERID=$(id -u)

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo "Please Run Script with ROOR USER...."
        exit 1  # Exit 1 means fail and stop executing script
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 is FAILED check it"
        exit 1
    else
        echo "$2 is SUCCESS"
    fi
}

CHECK_ROOT

dnf list installed mysql

if [ $? -ne 0 ]
then 
    echo "MYSQL is not installed, going to install now..."
    dnf install mysql -y
    VALIDATE $? "Installing MYSQL"
else    
    echo "MYSQL is already installed, Nothing to do..."
fi

dnf list installed nginx

if [ $? -ne 0 ]
then 
    echo "NGINX is not installed, going to install now..."
    dnf install nginx -y
    VALIDATE $? "Installing NGINX"
else    
    echo "NGINX is already installed, Nothing to do..."
fi