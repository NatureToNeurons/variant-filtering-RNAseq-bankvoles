#!/usr/bin/env bash

###############################################################################
#
# File: 01_quality_control.sh
#
# Description:
# Performs quality assessment of paired-end RNA-Seq FASTQ files using FastQC.
#
# Project:
# Variant Filtering from RNA-Seq Data in Bank Voles
#
# Repository:
# https://github.com/NatureToNeurons/variant-filtering-RNAseq-bankvoles
#
# Author:
# Ayushi Pathak
#
###############################################################################

set -euo pipefail

###############################################################################
# Load Utility Functions
###############################################################################

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_DIR}/utils.sh"

###############################################################################
# Configuration
###############################################################################

RAW_DIR="data/raw"
OUTPUT_DIR="data/results/fastqc"

THREADS=8

###############################################################################
# Start Pipeline
###############################################################################

print_header "RNA-Seq Quality Control"

log_info "Checking software dependencies..."

check_program fastqc

log_info "Creating output directory..."

create_dir "${OUTPUT_DIR}"

###############################################################################
# Locate FASTQ Files
###############################################################################

FASTQ_FILES=("${RAW_DIR}"/*_R1*.fastq.gz)

if [[ ! -e "${FASTQ_FILES[0]}" ]]; then
    die "No paired-end FASTQ files were found in ${RAW_DIR}"
fi

###############################################################################
# Run FastQC
###############################################################################

for R1 in "${FASTQ_FILES[@]}"
do

    R2="${R1/_R1/_R2}"

    check_file "${R1}"
    check_file "${R2}"

    SAMPLE=$(basename "${R1}")
    SAMPLE=${SAMPLE%%_R1*}

    log_info "Processing sample: ${SAMPLE}"

    fastqc \
        --threads "${THREADS}" \
        --outdir "${OUTPUT_DIR}" \
        "${R1}" \
        "${R2}"

done

###############################################################################
# Summary
###############################################################################

print_footer "FastQC completed successfully."

log_info "Reports saved in:"
log_info "    ${OUTPUT_DIR}"
