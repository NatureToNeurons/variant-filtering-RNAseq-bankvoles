#!/usr/bin/env bash

set -euo pipefail

###############################################################################
# Variant Filtering RNA-Seq Bank Voles
#
# Repository Structure Generator
#
# Author: Ayushi Pathak
###############################################################################

echo "Creating project structure..."

###############################################################################
# Directories
###############################################################################

directories=(

config

data/raw
data/reference
data/intermediate
data/results

docs

figures/results

logs

metadata

notebooks

output/bam
output/vcf
output/filtered_vcf
output/reports

scripts

slurm

)

for dir in "${directories[@]}"
do
    mkdir -p "$dir"

    case "$dir" in
        scripts|slurm|config|docs)
            ;;
        *)
            touch "$dir/.gitkeep"
            ;;
    esac
done

###############################################################################
# Configuration Files
###############################################################################

config_files=(

config/config.yaml
config/paths.yaml
config/samples.tsv

)

for file in "${config_files[@]}"
do
    touch "$file"
done

###############################################################################
# Pipeline Scripts
###############################################################################

scripts=(

00_utils.sh

01_pre_trim_fastqc.sh

02_trimmomatic.sh

03_post_trim_fastqc.sh

04_star_index.sh

05_star_alignment.sh

06_alignment_metrics.sh

07_mark_duplicates.sh

08_add_read_groups.sh

09_sort_index_bam.sh

10_split_ncigar.sh

11_gatk_variant_calling.sh

12_merge_gvcfs.sh

13_genotype_gvcfs.sh

14_freebayes_variant_calling.sh

15_variant_filtering.sh

16_statistics.sh

17_expressed_genes.sh

)

for script in "${scripts[@]}"
do
    touch "scripts/${script}"
    chmod +x "scripts/${script}"
done

###############################################################################
# SLURM Scripts
###############################################################################

slurm_scripts=(

01_pre_trim_fastqc.slurm

02_trimmomatic.slurm

03_post_trim_fastqc.slurm

04_star_index.slurm

05_star_alignment.slurm

06_alignment_metrics.slurm

07_mark_duplicates.slurm

08_add_read_groups.slurm

09_sort_index_bam.slurm

10_split_ncigar.slurm

11_gatk_variant_calling.slurm

12_merge_gvcfs.slurm

13_genotype_gvcfs.slurm

14_freebayes_variant_calling.slurm

15_variant_filtering.slurm

16_statistics.slurm

17_expressed_genes.slurm

submit_pipeline.sh

)

for script in "${slurm_scripts[@]}"
do
    touch "slurm/${script}"
    chmod +x "slurm/${script}"
done

###############################################################################
# Root Files
###############################################################################

root_files=(

README.md

LICENSE

CITATION.cff

Snakefile

environment.yml

requirements.txt

.gitignore

)

for file in "${root_files[@]}"
do
    touch "$file"
done

echo ""
echo "=============================================="
echo "Repository structure created successfully."
echo "=============================================="
