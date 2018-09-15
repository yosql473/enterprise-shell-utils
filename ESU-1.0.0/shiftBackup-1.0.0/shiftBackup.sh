#!/bin/bash

execute_path=`dirname $0`

is_detect=false
if [ `echo "$0 $1 $2 $3 $4"|grep '\-\-detect'|wc -l` == "1" ]
then
	is_detect=true
fi


if [ "$is_detect" == "true" ]
then
	## auto-detect and backup
	currentDir=`pwd`
	cat $execute_path/shiftBackup.config|while read line
	do
		field2=$(echo $line | awk '{print $2}')
		if [ "$(pwd)" == "$field2" ]
		then
			field1=$(echo $line | awk '{print $1}')
			bash $execute_path/shiftBackup.sh $2 $field1
		fi
	done
	exit
fi

echo "-----------------------------------------------"
echo " Enterprise Shell Utils 1.0.0"
echo " Welcome to backup something using ShiftBackup."
echo " Author:yosql473  Version:shiftBackup-1.0.0"
echo "-----------------------------------------------"

##############################################################
nickname=$1
isZip=false
if [ "`echo $0 $1 $2 $3 $4|grep '\-z'|wc -l`" == "1" ]
then
	# backup to a tarball
	isZip=true
	nickname=$2
fi


dateStr=$(date +%Y%m%d%H%M%s)

## read config file
cat $execute_path/shiftBackup.config|while read line
do
	p1=$(echo $line | awk '{print $1}')
	p2=`echo $line | awk '{print $2}'`
	p3=`echo $line | awk '{print $3}'`
	if [ $p1 == $nickname ]
	then
		#### execute backup
		if [ "$isZip" == "true" ] 
		then
			if [ "$p3" == "" ]
			then
				p3=`echo "$p2"-"$dateStr".tar.gz`
			else
				p3=`echo "$p3/$nickname-$dateStr".tar.gz`
			fi
			echo "[INFO] tar -zcf $p3 $p2"
			echo "[WARN] You'd better use absolute path:"
			tar -zcf $p3 $p2 &
		else
			if [ "$p3" == "" ]
			then
				p3=`echo "$p2"-"$dateStr".tar`
			else
				p3=`echo "$p3/$nickname-$dateStr".tar`
			fi
			echo "[INFO] tar -cf $p3 $p2"
			echo "[WARN] You'd better use absolute path:"
			tar -cf $p3 $p2 &
		fi	
	fi
done


echo "[INFO] Done."

