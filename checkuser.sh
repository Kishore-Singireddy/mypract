#!/bin/bash
user=$(id -u)
echo "$user"

if [ $user -eq 0 ]
then
	echo "You are loggedin as root user $USER"
else 
	echo "You are not a root user $USER, you can not install mysql"
fi
