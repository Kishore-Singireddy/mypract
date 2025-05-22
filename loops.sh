#!/bin/bash

#Loops Practice

echo "Script execution started at $(date)"



SOFTWARE=("nginx" "mysql" "python3")

for i in ${SOFTWARE[@]}
do 

    USERID=$(id -u)

    #Colours
    R='\e[31m'
    G='\e[32m'
    Y='\e[33m'
    B='\e[34m'
    C='\e[0m'

    #LOGS
    LOG_FOLDER="/var/log/shell_pract"
    LOG_SCRIPT=$(echo $0 | awk -F "." '{print $1F}')
    LOGS="$LOG_FOLDER/$LOG_SCRIPT.log"

    mkdir -p $LOG_FOLDER

    VALIDATE () {

    if [ $1 -ne 0 ]
    then 
        echo " Installation of $R $2 Failed $C" | tee -a $LOGS
    else 
        echo "Installation of $G $2 is Successful $C" | tee -a $LOGS
    fi

    }

    if [ $USERID -ne 0 ]
    then 
        echo "$R You don not have root access, can not proceed to install $C " | tee -a $LOGS
    else 
        echo "$G You have root access, proceeding to install the software $C" | tee -a $LOGS
    fi

    dnf list installed $i &>>$LOGS

    if [ $? -ne 0 ]

    then 
        echo " $Y Installing $i $C "
        dnf install $i -y  &>>$LOGS
        VALIDATE $? $i 
    else 
        echo " $G $i is already installed No action required" | tee -a $LOGS 
    fi

done