#!/usr/bin/env bash

###############################################################################
# Repository Setup Script
#
# Creates the complete directory structure for the RNA-Seq Variant Filtering
# project directly inside the CURRENT repository.
#
# Usage:
#   chmod +x setup_repository.sh
#   ./setup_repository.sh
###############################################################################

set -euo pipefail

echo "===================================================="
echo "Initializing repository structure..."
echo "===================================================="

###############################################################################
# Safety Check
###############################################################################

if [ ! -d ".git" ]; then
    echo ""
    echo "ERROR: No .git directory found."
    echo "Run this script from the ROOT of your GitHub repository."
    exit 1
fi

###############################################################################
# Create Directory Structure
###############################################################################

directories=(
"config"
"data"
"data/raw"
"data/reference"
"data/intermediate"
"data/results"
"docs"
"figures"
"figures/results"
"logs"
"metadata"
"notebooks"
"output"
"output/bam"
"output/vcf"
"output/filtered_vcf"
"output/reports"
"scripts"
)

echo ""
echo "Creating directories..."

for dir in "${directories[@]}"
do
    mkdir -p "$dir"
    touch "$dir/.gitkeep"
done

###############################################################################
# Create Pipeline Scripts
###############################################################################

scripts=(
"01_quality_control.sh"
"02_alignment.sh"
"03_sort_index.sh"
"04_mark_duplicates.sh"
"05_split_ncigar.sh"
"06_variant_calling.sh"
"07_variant_filtering.sh"
"08_variant_annotation.sh"
"utils.sh"
)

echo ""
echo "Creating Bash scripts..."

for script in "${scripts[@]}"
do

cat > "scripts/$script" <<EOF
#!/usr/bin/env bash

###############################################################################
# ${script}
###############################################################################

set -euo pipefail

echo "========================================="
echo "Running ${script}"
echo "========================================="

###############################################################################
# TODO
#
# Add implementation here.
###############################################################################

echo ""
echo "Finished ${script}"

EOF

chmod +x "scripts/$script"

done

###############################################################################
# Create Additional Files
###############################################################################

echo ""
echo "Creating project files..."

touch README.md
touch LICENSE
touch CITATION.cff
touch .gitignore
touch environment.yml
touch requirements.txt
touch Snakefile

###############################################################################
# Create Documentation Files
###############################################################################

touch docs/workflow.md
touch docs/methodology.md
touch docs/troubleshooting.md
touch docs/references.md

###############################################################################
# Create Metadata Files
###############################################################################

touch metadata/project_description.md
touch metadata/samples.csv

###############################################################################
# Create Config Files
###############################################################################

touch config/config.yaml
touch config/paths.yaml

###############################################################################
# Create Notebook
###############################################################################

touch notebooks/Variant_Filtering_Exploration.ipynb

###############################################################################
# Final Message
###############################################################################

echo ""
echo "===================================================="
echo "Repository structure created successfully!"
echo "===================================================="
echo ""

echo "Directory Tree:"
echo ""

cat <<'TREE'
.
├── README.md
├── LICENSE
├── CITATION.cff
├── .gitignore
├── environment.yml
├── requirements.txt
├── Snakefile
│
├── config/
│   ├── config.yaml
│   └── paths.yaml
│
├── data/
│   ├── raw/
│   ├── reference/
│   ├── intermediate/
│   └── results/
│
├── docs/
│   ├── workflow.md
│   ├── methodology.md
│   ├── references.md
│   └── troubleshooting.md
│
├── figures/
│   └── results/
│
├── logs/
│
├── metadata/
│   ├── project_description.md
│   └── samples.csv
│
├── notebooks/
│   └── Variant_Filtering_Exploration.ipynb
│
├── output/
│   ├── bam/
│   ├── filtered_vcf/
│   ├── reports/
│   └── vcf/
│
└── scripts/
    ├── 01_quality_control.sh
    ├── 02_alignment.sh
    ├── 03_sort_index.sh
    ├── 04_mark_duplicates.sh
    ├── 05_split_ncigar.sh
    ├── 06_variant_calling.sh
    ├── 07_variant_filtering.sh
    ├── 08_variant_annotation.sh
    └── utils.sh
TREE

echo ""
echo "Done!"
