#!bin/bash
aws iam list-users --profile ofs | grep "UserName" | cut -d '"' -f4 >> iam_users.txt
for i in `cat iam_users.txt`; do aws iam list-attached-user-policies --user-name $i --profile ofs | grep -v 'arn'| sed -e 's/^/'$i'/'; done >> policy
cat policy| grep "PolicyName" >> policyfinal
cat policyfinal --export table >> list.csv
echo  “Import to sheet with quotation” separtor”
