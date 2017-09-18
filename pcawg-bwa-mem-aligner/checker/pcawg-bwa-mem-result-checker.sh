#!/bin/bash

normal_bam1=$1
normal_bam2=$2

function check_md5 {
	md5_1=`md5sum $1 | cut -d' ' -f1`
	md5_2=`md5sum $2 | cut -d' ' -f1`
	if [ "$md5_1" != "$md5_2" ]
	then
		echo 0
		return
	fi
	echo 1
}

flag=0

echo $normal_bam1
echo "ok"
#/usr/bin/samtools view $normal_bam1
exit

if [ $(check_md5 <(/usr/bin/samtools view -f 64 $normal_bam1) <(/usr/bin/samtools view -f 64 $normal_bam2)) -eq 0 ];then echo "overall: false" > checker_report.txt;echo "mismatch result found in "$normal_bam2 >> checker_report.txt;flag=1;fi

if [ $flag -eq 0 ]
then
	echo "overall: true" > checker_report.txt
fi
