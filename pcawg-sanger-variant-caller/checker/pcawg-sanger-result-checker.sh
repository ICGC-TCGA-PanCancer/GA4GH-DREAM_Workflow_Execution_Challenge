#!/usr/bin/env bash

set -u

declare -A files_to_check

files_to_check=(
    ["var/spool/cwl/0/ascat/HCC1143.copynumber.caveman.vcf"]="*.somatic.cnv.tar.gz" \
    ["var/spool/cwl/0/brass/HCC1143_vs_HCC1143_BL.annot.vcf"]="*.somatic.sv.tar.gz" \
    ["var/spool/cwl/0/caveman/HCC1143_vs_HCC1143_BL.muts.ids.vcf"]="*.somatic.snv_mnv.tar.gz" \
    ["var/spool/cwl/0/caveman/HCC1143_vs_HCC1143_BL.flagged.muts.vcf"]="*.somatic.snv_mnv.tar.gz" \
    ["var/spool/cwl/0/caveman/HCC1143_vs_HCC1143_BL.snps.ids.vcf"]="*.somatic.snv_mnv.tar.gz" \
    ["var/spool/cwl/0/pindel/HCC1143_vs_HCC1143_BL.flagged.vcf"]="*.somatic.indel.tar.gz" \
)

#less HCC1143_vs_HCC1143_BL.muts.ids.vcf.1 |perl -nae 'next if /^#/; chomp;  @F=split/\t/; print join("\t", @F[0..1, 3..10]); print "\n"' > HCC1143_vs_HCC1143_BL.muts.ids.vcf.1.eff

# let's first unpack reference result files
USAGE="Usage: $0 dir file1 file2 file3 ... fileN"

if [ "$#" -lt "2" ]; then
    echo "$USAGE"
    echo "Need to provide one dir and at least one file"
    exit 1
fi

# unpack reference result
reference_result_dir=$1
for f in `ls ${reference_result_dir}/*.tar.gz`; do
tar xzf $f -C $reference_result_dir
done

shift

# unpack test result
checker_temp_dir="checker_temp_dir"

[ ! -d $checker_temp_dir ] && mkdir $checker_temp_dir

while (( "$#" )); do
tar xzf $1 -C $checker_temp_dir
shift
done

# now we can compare them
mismatch=()
:> checker_report.log

for f in "${!files_to_check[@]}"; do

if [ $f == "var/spool/cwl/0/ascat/HCC1143.copynumber.caveman.vcf" ] || [ $f == "var/spool/cwl/0/brass/HCC1143_vs_HCC1143_BL.annot.vcf" ]; then
    gunzip -c $reference_result_dir/$f.gz | grep -v '^#' > $reference_result_dir/$f.effective
    gunzip -c $checker_temp_dir/$f.gz | grep -v '^#' > $checker_temp_dir/$f.effective
else
    gunzip -c $reference_result_dir/$f.gz | grep -v '^#' | cut -d$'\t' -f-2,4- > $reference_result_dir/$f.effective
    gunzip -c $checker_temp_dir/$f.gz | grep -v '^#' | cut -d$'\t' -f-2,4- > $checker_temp_dir/$f.effective
fi

# diff now
echo "diff $reference_result_dir/$f.effective $checker_temp_dir/$f.effective" >> checker_report.log
diff $reference_result_dir/$f.effective $checker_temp_dir/$f.effective >> checker_report.log 2>&1

rc=$?
if [[ $rc != 0 ]]; then
    mismatch+=(${files_to_check[$f]})
fi   

done

if [ "${#mismatch[@]}" -eq "0" ]; then
    echo "overall: true" > checker_report.txt
else
    echo "overall: false" > checker_report.txt
    echo "mismatch result found in: ${mismatch[@]}" >> checker_report.txt
fi

