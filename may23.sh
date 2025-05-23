#!/bin/bash
#variable,datatype(array),function,error handing, for loop, command line arguments
#Programm to install software


#cosmotic
R='\e[31m'
G='\e[32m'
Y='\e[33m'
B='\e[34m'
N='\e[0m'

#LOG Files

#1 check if user has root access
USERID=$(id -u)


LOG_FOLDER="/var/log/may23"
LOG_PREFIX=$(echo $0 | awk -F "." '{print $1F}')
LOGS="$LOG_FOLDER/$LOG_PREFIX.log"

mkdir -p $LOG_FOLDER

echo -e "$Y Script execution started at $(date) $N " | tee -a $LOGS 

PACKAGE=$#

echo -e "Softwares requested for installation $Y $@ $N"

USAGE () {

    if [ $PACKAGE -le 0 ]
    then 
        echo -e " $R Please enter the sofware followed by the script name, as shown below $N exiting the installation " | tee -a $LOGS
        echo -e " $R Usagae is $0 software1 software2 software3 $N "
        exit 1
    fi
}

VALIDATE () {
    if [ $1 -ne 0 ]
    then 
        echo -e " $2 Installation $R Failed $N " | tee -a $LOGS
        echo -e " check the logs $R $LOGS $N "
    else 
        echo -e " $2 Installation $G Successful $N " | tee -a $LOGS
    fi


}

#1 check if the current user has root access
USAGE
if [ $USERID -ne 0 ]
then
    echo -e " $R You don't have root access, hence can not install software.... exiting... $N "  | tee -a $LOGS
    exit 1
else
    echo -e " $Y You have root access, proceding to execute the script $N " | tee -a $LOGS

fi


#2 Check if the software is installed already

for package in $@
do 
    dnf list installed $package &>> $LOGS
    if [ $? -ne 0 ]
    then
        echo -e "$package not installed $Y Installing $package $N " | tee -a $LOGS
        dnf install $package -y &>> $LOGS
        VALIDATE $? $package
    else 
        echo -e "$package is already installed $Y No Action required $N " | tee -a $LOGS
    fi 
done

