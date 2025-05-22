#!/bin/bash

#script to uninstall packages

USERID=$(id -u)
R='\e[31m'
G='\e[32m'
Y='\e[33m'
B='\e[34m'
O='\e[35m'
C='\e[0m'

LOG_FOLDER="/var/log/shell_pract"
LOG_FILE=$(echo $0 | awk -F '{print $1F}')
LOGS="$LOG_FOLDER/$LOG_FILE.log"
#SOFTWARES=$($@)
echo -e "$O Script Execution started at $(date)$C" | tee -a $LOGS

if [ $USERID -ne 0 ]
then 
    echo -e "$R You don't have access to unistall the software $C " | tee -a $LOGS
    exit 1
else 
    echo -e "$Y Proceeding to unistall the software $@ $C" | tee -a $LOGS
fi

VALIDATE () {
    if [ $1 -ne 0 ]
    then 
        echo -e " $2 Unistallation is $R Failed $C " | tee -a $LOGS
    else
        echo -e  " $2 Unistallation is $G Successfully $C " | tee -a $LOGS
    fi

}

for software in $@
do 
    dnf list installed $software &>>$LOGS
    if [ $? -ne 0 ]

    then 
        echo -e " $R $software not found, No action required $C" | tee -a $LOGS
    
    else
        echo -e " $Y Unstalling the $software $C " | tee -a $LOGS
        dnf remove $software -y &>>$LOGS
        VALIDATE $? $software
    fi
done