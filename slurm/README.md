# Running the Pipeline on UPPMAX (SLURM)

## Overview

This directory contains SLURM submission scripts for executing the RNA-Seq
Variant Calling pipeline on UPPMAX or any HPC cluster running the SLURM
scheduler.

The scientific workflow is implemented in the `scripts/` directory.

The SLURM scripts are responsible only for:

- Requesting computational resources
- Loading required software modules
- Executing the corresponding pipeline script

This separation keeps the pipeline portable across local workstations,
cloud environments, and HPC systems.

---

## Directory Structure

```
slurm/

01_quality_control.slurm
02_alignment.slurm
03_sort_index.slurm
04_mark_duplicates.slurm
05_split_ncigar.slurm
06_variant_calling.slurm
07_variant_filtering.slurm
08_variant_annotation.slurm

submit_pipeline.sh
```

---

## Required Modules

Example:

```bash
module load bioinfo-tools

module load FastQC

module load STAR

module load samtools

module load picard

module load GATK
```

Module names may differ depending on the cluster configuration.

---

## Running Individual Steps

Example:

```bash
sbatch 01_quality_control.slurm

sbatch 02_alignment.slurm
```

---

## Running the Entire Pipeline

```bash
bash submit_pipeline.sh
```

The submission script automatically schedules each job using SLURM job
dependencies.

---

## Notes

The Bash scripts under `scripts/` are independent of SLURM and can be run on
any Linux system where the required software is installed.
