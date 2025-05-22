#!/bin/bash

#Script to practise functions and colours

#Checks
#1 Root user
#2 Software already installed
#3 Successfully installed

#Variables

USERID=$(id -u)

#Variables for colours

R='\e[31m'
G='\e[32m'
Y='\e[33m'
B='\e[34m'
C='\e[0m'

#LOGS
LOGS_FOLDER="/var/logs/shell_pract/"
LOG_SCRIPT=$(echo $0 | awk -F "." '{print $1F}') 
LOGS=$($LOGS_FOLDER/$LOG_SCRIPT.log)
mkdir -p $LOGS_FOLDER
#Functions:

VALIDATE () {
    if [ $1 -ne 0 ]
    then
        echo -e "$2 installation - $R FAILED $C"
    else
        echo -e "$2 installation is $G SUCCESSFUL $C" 
    fi

}

#1 Is the user root

if [ $USERID -ne 0 ]
then 
    echo -e "$R You don't have root access, hence exiting the script $C"
    exit 1 # to exit the script
else
    echo -e "$Y Proceeding to install the software $C"

fi

#2 Check if software is already installed and install it

dnf list installed mysql &>> $LOGS

if [ $? -ne 0 ]
then
    echo -e "$Y MYSQL is not installed, Hence installing it $C"
    dnf install mysql $>> $LOGS
    #3 Check if mysql installation is successul 
    VALIDATE $? mysql

else 
    echo -e "$G MYSQL is already installed... Hence skipping this step $C"
fi
    
