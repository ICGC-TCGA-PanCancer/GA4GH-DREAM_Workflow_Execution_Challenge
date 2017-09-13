#!/bin/bash

normal_bam1=$1
unmapped_bam1=$3
normal_bai1=$5
unmapped_bai1=$7
metrics1=$9
unmapped_metrics1="${11}"

normal_bam2=$2
unmapped_bam2=$4
normal_bai2=$6
unmapped_bai2=$8
metrics2="${10}"
unmapped_metrics2="${12}"

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

if [ $(check_md5 <(samtools view -f 64 $normal_bam1) <(samtools view -f 64 $normal_bam2)) -eq 0 ];then echo "overall: false" > checker_report.txt;echo "mismatch result found in "$normal_bam2 >> checker_report.txt;flag=1;fi
if [ $(check_md5 <(samtools view -f 64 $unmapped_bam1) <(samtools view -f 64 $unmapped_bam2)) -eq 0 ];then echo "overall: false" > checker_report.txt;echo "mismatch result found in "$unmapped_bam2 >> checker_report.txt;flag=1;fi
if [ $(check_md5 $normal_bai1 $normal_bai2) -eq 0 ];then echo "overall: false" > checker_report.txt;echo "mismatch result found in "$normal_bai2 >> checker_report.txt;flag=1;fi
if [ $(check_md5 $unmapped_bai1 $unmapped_bai2) -eq 0 ];then echo "overall: false" > checker_report.txt;echo "mismatch result found in "$unmapped_bai2 >> checker_report.txt;flag=1;fi
if [ $(check_md5 $metrics1 $metrics2) -eq 0 ];then echo "overall: false" > checker_report.txt;echo "mismatch result found in "$metrics2 >> checker_report.txt;flag=1;fi
if [ $(check_md5 $unmapped_metrics1 $unmapped_metrics2) -eq 0 ];then echo "overall: false" > checker_report.txt;echo "mismatch result found in "$unmapped_metrics2 >> checker_report.txt;flag=1;fi

if [ $flag -eq 0 ]
then
	echo "overall: true" > checker_report.txt
fi
