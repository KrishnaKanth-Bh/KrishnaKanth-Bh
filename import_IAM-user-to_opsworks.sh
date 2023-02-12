#!/bin/bash

if [ -z "$1" ]
  then
    echo "No AWS userarn provided, Please follow the below syntax to execute"
    sleep 2
    echo "Syntax: <occbot run 'command'> <AWS IAM userarn> <ssh username>"
    exit
fi

if [ -z "$2" ]
  then
    echo "No ssh username provided"
    exit
fi

if [[ ! $2 =~ ^[[:alnum:]]+$ ]];then
      echo "ssh username contains special character..exiting"
      exit
   else
      echo "Importing $2 to (ap-southeast-1,us-east-1,ap-south-1)"
fi

if [ -z "$3" ]
  then
    echo "No ssh key provided"
    exit
fi

aws opsworks --region ap-southeast-1 create-user-profile --iam-user-arn $1 --ssh-username $2 --ssh-public-key "$3 $4 $5" --no-allow-self-management > /dev/null

if [ $? -eq 0 ]; then
   echo "Successfully imported to ap-southeast-1 (Singapore)"
else
   echo "Failed in importing $2 to ap-southeast-1 (Singapore)"
fi

aws opsworks --region us-east-1 create-user-profile --iam-user-arn $1 --ssh-username $2 --ssh-public-key "$3 $4 $5" --no-allow-self-management > /dev/null

if [ $? -eq 0 ]; then
   echo "Successfully imported to us-east-1 (N. Virginia)"
else
   echo "Failed in importing $2 to us-east-1 (N. Virginia)"
fi

aws opsworks --region ap-south-1 create-user-profile --iam-user-arn $1 --ssh-username $2 --ssh-public-key "$3 $4 $5" --no-allow-self-management > /dev/null

if [ $? -eq 0 ]; then
   echo "Successfully imported to ap-south-1 (Mumbai)"
else
   echo "Failed in importing $2 to ap-south-1 (Mumbai)"
fi

sleep 1
echo Done!
exit
