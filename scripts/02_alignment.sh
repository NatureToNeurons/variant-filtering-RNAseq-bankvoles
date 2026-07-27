#!/usr/bin/env bash

###############################################################################
#
# File: 02_alignment.sh
#
# Description:
# Performs splice-aware alignment of paired-end RNA-Seq reads
# using STAR.
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
REFERENCE_DIR="data/reference"
OUTPUT_DIR="output/bam"

GENOME_INDEX="${REFERENCE_DIR}/STAR_index"
ANNOTATION="${REFERENCE_DIR}/annotation.gtf"

THREADS=8

###############################################################################
# Start Pipeline
###############################################################################

print_header "RNA-Seq Read Alignment"

log_info "Checking software dependencies..."

check_program STAR

log_info "Checking input directories..."

check_directory "${RAW_DIR}"
check_directory "${REFERENCE_DIR}"

create_dir "${OUTPUT_DIR}"

###############################################################################
# Validate Reference Files
###############################################################################

check_directory "${GENOME_INDEX}"
check_file "${ANNOTATION}"

###############################################################################
# Locate FASTQ Files
###############################################################################

shopt -s nullglob

FASTQ_FILES=("${RAW_DIR}"/*_R1*.fastq.gz)

if (( ${#FASTQ_FILES[@]} == 0 ))
then
    die "No paired-end FASTQ files found in ${RAW_DIR}"
fi

###############################################################################
# Run STAR Alignment
###############################################################################

for R1 in "${FASTQ_FILES[@]}"
do

    R2="${R1/_R1/_R2}"

    check_file "${R1}"
    check_file "${R2}"

    SAMPLE=$(basename "${R1}")
    SAMPLE=${SAMPLE%%_R1*}

    log_info "Aligning sample: ${SAMPLE}"

    ###########################################################################
    # STAR command
    ###########################################################################

    # TODO:
    # Add STAR alignment command from the original UPPMAX workflow.

done

###############################################################################
# Summary
###############################################################################

print_footer "STAR alignment completed successfully."

log_info "Samples processed : ${#FASTQ_FILES[@]}"
log_info "Output directory  : ${OUTPUT_DIR}"
