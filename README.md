# Variant Filtering from RNA-Seq Data in Bank Voles

> A reproducible RNA-Seq variant calling and filtering pipeline developed using **Bash**, **Linux**, and **GATK Best Practices** for transcriptome variant discovery.

![Platform](https://img.shields.io/badge/Platform-Linux-blue)
![Language](https://img.shields.io/badge/Language-Bash-green)
![Workflow](https://img.shields.io/badge/Workflow-RNA--Seq-orange)
![Bioinformatics](https://img.shields.io/badge/Bioinformatics-GATK-red)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

---

# Table of Contents

- [Project Overview](#project-overview)
- [Research Background](#research-background)
- [Objectives](#objectives)
- [Workflow](#workflow)
- [Repository Structure](#repository-structure)
- [Software Requirements](#software-requirements)
- [Installation](#installation)
- [Pipeline Execution](#pipeline-execution)
- [Pipeline Description](#pipeline-description)
- [Outputs](#outputs)
- [Future Improvements](#future-improvements)
- [References](#references)
- [Author](#author)
- [License](#license)

---

# Project Overview

This repository contains a modular and reproducible workflow for identifying genomic variants from RNA sequencing (RNA-Seq) data using the **Genome Analysis Toolkit (GATK) Best Practices**.

The project was developed during my **Master's studies in Bioinformatics** and demonstrates an end-to-end computational workflow for RNA-Seq variant discovery in **Bank Voles (*Myodes glareolus*)**.

Unlike DNA sequencing, RNA-Seq reads span splice junctions and require additional preprocessing before reliable variant calling can be performed. This repository implements these preprocessing steps together with alignment, variant calling, filtering, and optional annotation.

The project demonstrates practical experience in:

- Linux command-line computing
- Bash scripting
- RNA-Seq analysis
- Variant discovery
- Reproducible bioinformatics workflows
- Version control using Git and GitHub

---

# Research Background

RNA sequencing is widely used for transcriptome analysis and differential gene expression studies. In addition to measuring gene expression, RNA-Seq data can also be used to detect expressed genetic variants including:

- Single Nucleotide Polymorphisms (SNPs)
- Small Insertions and Deletions (INDELs)

Because RNA molecules contain exon-exon splice junctions, conventional DNA variant calling pipelines cannot be directly applied. The GATK RNA-Seq Best Practices pipeline addresses these challenges by introducing RNA-specific preprocessing steps such as splice-aware alignment and read splitting.

This repository implements these best practices to generate high-confidence variant calls from transcriptomic sequencing data.

---

# Objectives

The goals of this project are to:

- Build a reproducible RNA-Seq variant calling workflow
- Align RNA-Seq reads using a splice-aware aligner
- Process BAM files following GATK recommendations
- Detect SNPs and INDELs
- Filter low-quality variants
- Generate reproducible Variant Call Format (VCF) files
- Demonstrate best practices in computational genomics

---

# Workflow

```
Raw FASTQ Files
        │
        ▼
Quality Assessment (FastQC)
        │
        ▼
Reference Genome Preparation
        │
        ▼
Read Alignment (STAR)
        │
        ▼
Sorted BAM Files
        │
        ▼
Mark PCR Duplicates (Picard)
        │
        ▼
Split'N'Trim (SplitNCigarReads)
        │
        ▼
Variant Calling (GATK HaplotypeCaller)
        │
        ▼
Raw Variants (VCF)
        │
        ▼
Variant Filtering
        │
        ▼
High-Confidence Variants
        │
        ▼
Variant Annotation (Optional)
```

---

# Repository Structure

```
VariantFiltering_RNASeq_BankVoles/

├── config/
├── data/
├── docs/
├── figures/
├── logs/
├── metadata/
├── notebooks/
├── output/
├── scripts/
│
├── README.md
├── LICENSE
├── CITATION.cff
├── Snakefile
├── environment.yml
├── requirements.txt
└── .gitignore
```

---

# Software Requirements

## Operating System

- Linux (Ubuntu recommended)

## Programming Languages

- Bash
- Python (optional)
- R (optional)

## Bioinformatics Software

- GATK 4
- STAR
- Samtools
- Picard
- BCFtools
- FastQC
- MultiQC

## Workflow Management (Future)

- Snakemake

---

# Installation

Clone the repository

```bash
git clone https://github.com/NatureToNeurons/variant-filtering-RNAseq-bankvoles.git

cd VariantFiltering_RNASeq_BankVoles
```

Create the Conda environment

```bash
conda env create -f environment.yml

conda activate rnaseq_variant_pipeline
```

---

# Pipeline Execution

Run each processing step sequentially.

```bash
bash scripts/01_quality_control.sh

bash scripts/02_alignment.sh

bash scripts/03_sort_index.sh

bash scripts/04_mark_duplicates.sh

bash scripts/05_split_ncigar.sh

bash scripts/06_variant_calling.sh

bash scripts/07_variant_filtering.sh

bash scripts/08_variant_annotation.sh
```

---

# Pipeline Description

## Step 1 — Quality Assessment

Raw sequencing reads are evaluated using **FastQC** to assess sequencing quality, GC content, adapter contamination, and per-base sequence quality.

---

## Step 2 — Read Alignment

RNA-Seq reads are aligned to the reference genome using the splice-aware aligner **STAR**.

---

## Step 3 — BAM Processing

Aligned reads are sorted and indexed using **Samtools**.

---

## Step 4 — Duplicate Marking

PCR duplicates are identified and marked using **Picard MarkDuplicates**.

---

## Step 5 — Split'N'Trim

The **SplitNCigarReads** module from GATK prepares RNA alignments for variant calling by handling reads spanning splice junctions.

---

## Step 6 — Variant Calling

Variants are detected using **GATK HaplotypeCaller** in RNA-Seq mode.

---

## Step 7 — Variant Filtering

Quality filters are applied to remove low-confidence SNPs and INDELs according to GATK Best Practices.

---

## Step 8 — Variant Annotation (Optional)

Filtered variants can be annotated using tools such as:

- SnpEff
- Ensembl Variant Effect Predictor (VEP)

---

# Outputs

The workflow produces:

```
output/

├── bam/
│   ├── *.bam
│   └── *.bai
│
├── vcf/
│   └── raw_variants.vcf
│
├── filtered_vcf/
│   └── filtered_variants.vcf
│
└── reports/
```

Additional outputs include:

- FastQC reports
- Alignment statistics
- Variant statistics
- Pipeline logs

---

# Skills Demonstrated

This project demonstrates practical experience with:

- RNA-Seq Analysis
- Variant Calling
- Computational Genomics
- Bash Scripting
- Linux
- Bioinformatics Pipeline Development
- GATK Best Practices
- STAR Alignment
- Samtools
- Picard
- Version Control (Git)
- Reproducible Research

---

# Future Improvements

Planned enhancements include:

- Snakemake workflow
- Docker containerization
- GitHub Actions CI/CD
- MultiQC integration
- Functional variant annotation
- HPC (SLURM) support
- Cloud deployment
- YAML configuration files
- Interactive reports

---

# References

1. Van der Auwera GA, O'Connor BD. *Genomics in the Cloud*. O'Reilly Media.

2. GATK Best Practices for RNA-Seq Variant Discovery.

3. Dobin A. et al. STAR: Ultrafast universal RNA-seq aligner. *Bioinformatics*. 2013.

4. Li H. et al. The Sequence Alignment/Map format and SAMtools. *Bioinformatics*. 2009.

5. Picard Toolkit. Broad Institute.

---

# Author

**Ayushi Pathak**

M.Sc. Bioinformatics

Computational Biology • Biomedical Data Science • Genomics • RNA-Seq Analysis

GitHub: **github.com/AyushiPathak**

---

# License

This project is licensed under the MIT License. See the **LICENSE** file for details.

---

## Acknowledgements

This repository is based on the Genome Analysis Toolkit (GATK) RNA-Seq Best Practices workflow and was developed as part of academic training in Bioinformatics. It has since been refactored into a modular, reproducible, and well-documented repository for educational and portfolio purposes.
