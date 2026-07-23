###############################################################################
# RNA-Seq Variant Calling Workflow
#
# Repository:
# https://github.com/NatureToNeurons/variant-filtering-RNAseq-bankvoles
#
# Author:
# Ayushi Pathak
#
# Description:
# Snakemake workflow implementing the GATK Best Practices
# for RNA-Seq Variant Calling.
#
# Status:
# Pipeline currently under development.
# Individual Bash scripts in scripts/ are fully functional.
###############################################################################

configfile: "config/config.yaml"

rule all:
    input:
        "output/reports/pipeline_complete.txt"


rule pipeline_complete:

    output:
        "output/reports/pipeline_complete.txt"

    shell:
        """
        mkdir -p output/reports
        echo "Pipeline complete." > {output}
        """
