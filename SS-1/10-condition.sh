#!/bin/bash

NUMBER=$1

if [ $NUMBER -gt 20 ]
then
    echo "Number : $NUMBER is 20 above"
else 
    echo "Number : $NUMBER is 20 below"
fi