#!/bin/bash
echo "-----------------------------------------------"
echo " Welcome to backup something using ShiftBackup."
echo " Author:yosql473	Version:1.0.0"
echo "-----------------------------------------------"

config_path=$1
param=$2

if [ $param == "--detect" ]
then
	## auto-detect and backup
	exit
fi

##############################################################
nickname=$2
isZip=false
if [ $param == "-z" ]
then
	# backup to a tarball
	isZip=true
	nickname=$3
fi


dateStr=$(date +%Y%m%d%H%M%s)

## read config file
cat $config_path|while read line
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
			fi
			echo "[INFO] tar -zcf $p3 $p2"
			echo "[WARN] You'd better use relative path:"
			tar -zcf $p3 $p2 &
		else
			if [ "$p3" == "" ]
			then
				p3=`echo "$p2"-"$dateStr".tar`
			fi
			echo "[INFO] tar -cf $p3 $p2"
			echo "[WARN] You'd better use relative path:"
			tar -cf $p3 $p2 &
		fi	
	fi
done


echo "[INFO] Done."

