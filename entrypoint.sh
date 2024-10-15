#!/bin/bash

# lyx 2/10/2024

# Directory paths
INPUT_DIR="/mnt/in"
OUTPUT_DIR="/mnt/out"

# Source the script to set THREAD_NUM
echo -e "\e[0;34mInfo: Running set.thread.num.sh to set THREAD_NUM...\e[0m"
source /root/set.thread.num.sh

# Check if input directory contains BAM files and process them
for bamfile in "$INPUT_DIR"/*.bam; do
  if [ ! -e "$bamfile" ]; then
    echo -e "\e[0;31mError: No BAM files found in $INPUT_DIR.\e[0m"
    continue
  fi

  # Generate the VCF file path from the BAM file path
  vcf_file="${bamfile%.bam}.vcf"

  # Start processing with Sniffles2
  echo -e "\e[0;34mInfo: Processing $bamfile with Sniffles2...\e[0m"
  sniffles --threads $THREAD_NUM --input "$bamfile" --vcf "$vcf_file"
  
  # Check if VCF file was created
  if [ -f "$vcf_file" ]; then
    echo -e "\e[0;34mInfo: SV detection completed: $vcf_file\e[0m"
  else
    echo -e "\e[0;31mError: SV detection failed for $bamfile\e[0m"
  fi
done
