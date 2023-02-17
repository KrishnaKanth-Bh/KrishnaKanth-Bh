#!bin/bash

if [ -z "$1" ]
then
   echo "No username supplied"
exit
fi

sleep 3s
email = "echo '$1' | sed 's/'$1'/'$1'@olacabs.com/'"

echo "Checking username in AWS"
if
username = aws iam get-user --user-name $1 | grep UserName | cut -d '"' -f4
then
echo $username
exit
fi
