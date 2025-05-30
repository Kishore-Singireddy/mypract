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
LOGS_FOLDER="/var/logs/shell_pract"
LOG_SCRIPT=$(echo $0 | awk -F "." '{print $1F}') 
LOGS="$LOGS_FOLDER/$LOG_SCRIPT.log"
mkdir -p $LOGS_FOLDER
#Functions:

VALIDATE () {
    if [ $1 -ne 0 ]
    then
        echo -e "$2 installation - $R FAILED $C" | tee -a $LOGS
    else
        echo -e "$2 installation is $G SUCCESSFUL $C" | tee -a $LOGS
    fi

}

#1 Is the user root

if [ $USERID -ne 0 ]
then 
    echo -e "$R You don't have root access, hence exiting the script $C" | tee -a $LOGS
    exit 1 # to exit the script
else
    echo -e "$Y Proceeding to install the software $C" | tee -a $LOGS

fi

#2 Check if software is already installed and install it

dnf list installed mysql &>>$LOGS

if [ $? -ne 0 ]
then
    echo -e "$Y MYSQL is not installed, Hence installing it $C" | tee -a $LOGS
    dnf install mysql -y &>>$LOGS
    #3 Check if mysql installation is successul 
    VALIDATE $? "mysql"

else 
    echo -e "$G MYSQL is already installed... Hence skipping this step $C" | tee -a $LOGS
fi
    
dnf list installed nginx &>>$LOGS

if [ $? -ne 0 ]
then
    echo -e "$Y NGINX is not installed, Hence installing it $C" | tee -a $LOGS
    dnf install nginx -y &>>$LOGS
    #3 Check if nginx installation is successul 
    VALIDATE $? "nginx"

else 
    echo -e "$G NGINX is already installed... Hence skipping this step $C" | tee -a $LOGS
fi

dnf list installed python3 &>>$LOGS

if [ $? -ne 0 ]
then
    echo -e "$Y PYTHON3 is not installed, Hence installing it $C" | tee -a $LOGS
    dnf install python3 -y &>>$LOGS
    #3 Check if pyton3 installation is successul 
    VALIDATE $? "python3"

else 
    echo -e "$G python3 is already installed... Hence skipping this step $C" | tee -a $LOGS
fi
