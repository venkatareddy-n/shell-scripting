#!/bin/bash

# Reading input and timeout
read -p "Enter your name: " name

read -t 10 -p "Enter your password in 10 seconds: " password

echo "Hello $name your password is: $password"