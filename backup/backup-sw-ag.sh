#!/bin/bash

#example

#userName=man20820
#target=192.168.1.1

userName=admin
target=172.16.100.2

#getRouterID
getRouterID=$(ssh $userName@$target 'sys ide pr')
echo $getRouterID
getRealRouterID=$(echo ${getRouterID:7:-3}| cut -d':' -f 2)
echo $getRealRouterID

#getDate
getDate=`date +%Y%m%d`
echo $getDate

#setBackupName
backupName="${getRealRouterID}-${getDate}"
echo $backupName > file.txt

#backupRouter
ssh $userName@$target "system backup save name=$backupName"
#sleep 5s

#backupName1=" manmeja-20220606"
echo $backupName > file.txt

#sendBackupFileToLocal
scp $userName@$target:"/${backupName}.backup" backup

#deleteBackupFile
ssh $userName@$target "file remove ${backupName}.backup"
