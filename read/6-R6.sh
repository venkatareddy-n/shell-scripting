#!/bin/bash

# Reading input and timeout
read -p "Enter your name: " name

# -s secure
# -p prompt
# -t time seconds
read -t 10 -s -p "Enter your password in 10 seconds: " password

if [ -z "$password" ]; then
    echo "Hello $name you are not entered Password in 10 seconds"
else
    echo "Hello $name your password is: $password"
fi