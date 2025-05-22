#!/bin/bash

#Loops Practice

#Colours
R='\e[31m'
G='\e[32m'
Y='\e[33m'
B='\e[34m'
C='\e[0m'

echo -e "$R Script execution started at $(date) $C" | tee -a $LOGS


USERID=$(id -u)



#LOGS
LOG_FOLDER="/var/log/shell_pract"
LOG_SCRIPT=$(echo $0 | awk -F "." '{print $1F}')
LOGS="$LOG_FOLDER/$LOG_SCRIPT.log"

mkdir -p $LOG_FOLDER

VALIDATE () {

if [ $1 -ne 0 ]
then 
    echo -e " Installation of $R $2 Failed $C" | tee -a $LOGS
else 
    echo -e "Installation of $G $2 is Successful $C" | tee -a $LOGS
fi

}

if [ $USERID -ne 0 ]
then 
    echo -e "$R You don not have root access, can not proceed to install $C " | tee -a $LOGS
    exit 1
else 
    echo -e "$G You have root access, proceeding to install the software $C" | tee -a $LOGS
fi



SOFTWARE=("nginx" "mysql" "python3")

for i in ${SOFTWARE[@]}
do 


    dnf list installed $i &>>$LOGS

    if [ $? -ne 0 ]

    then 
        echo -e " $Y Installing $i $C "
        dnf install $i -y  &>>$LOGS
        VALIDATE $? $i 
    else 
        echo -e " $G $i is already installed No action required" | tee -a $LOGS 
    fi

done