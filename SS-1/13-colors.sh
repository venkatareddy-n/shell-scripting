#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo -e "$Y Please Run Script with ROOR USER....$N"
        exit 1  # Exit 1 means fail and stop executing script
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R FAILED $N check it"
        exit 1
    else
        echo -e "$2 is $G SUCCESS $N"
    fi
}

CHECK_ROOT

dnf list installed mysql

if [ $? -ne 0 ]
then 
    echo -e "$Y MYSQL is not installed, going to install now... $N"
    dnf install mysql -y
    VALIDATE $? "Installing MYSQL"
else    
    echo -e "$Y MYSQL is already installed, Nothing to do... $N"
fi

dnf list installed nginx

if [ $? -ne 0 ]
then 
    echo -e " $Y NGINX is not installed, going to install now... $N"
    dnf install nginx -y
    VALIDATE $? "Installing NGINX"
else    
    echo -e " $Y NGINX is already installed, Nothing to do...$N"
fi