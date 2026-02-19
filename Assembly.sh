##🔬 Integrated Bioinformatics Workflow
# Comparative Genomics & AMR Profiling of Clinical E. coli (GN3, GN6, GN9)
## 🖥 1️⃣ System Preparation (Ubuntu 24.04)
sudo apt update && sudo apt upgrade -y
sudo apt install -y wget git curl build-essential unzip

## 🐍 2️⃣ Install Miniconda (Recommended for Reproducibility)
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc
conda update -n base -c defaults conda -y

#Add channels:
conda config --add channels bioconda
conda config --add channels conda-forge
conda config --add channels defaults

## 📁 3️⃣ Create Project Directory
mkdir ecoli_project
cd ecoli_project

mkdir raw fastqc_output assembly annotation panaroo_output amr_output quast_results
---
## 📥 4️⃣ Download Samples (PacBio HiFi Reads)
cd raw

wget https://cgr.liv.ac.uk/454/acdarby/LIFE748/GN3.fastq
wget https://cgr.liv.ac.uk/454/acdarby/LIFE748/GN6.fastq
wget https://cgr.liv.ac.uk/454/acdarby/LIFE748/GN9.fastq

cd ..

## 🔎 5️⃣ Quality Control – FastQC
#Create environment:
conda create -n qc_env fastqc -y
conda activate qc_env
#Run FastQC:
fastqc raw/*.fastq -o fastqc_output/
#Deactivate:
conda deactivate

## 🧬 6️⃣ Genome Assembly – Flye
#Create environment:
conda create -n assembly_env flye quast -y
conda activate assembly_env
#Run Flye for each sample:
flye --pacbio-hifi raw/GN3.fastq --out-dir assembly/GN3 --genome-size 5m
flye --pacbio-hifi raw/GN6.fastq --out-dir assembly/GN6 --genome-size 5m
flye --pacbio-hifi raw/GN9.fastq --out-dir assembly/GN9 --genome-size 5m
---
## 📊 7️⃣ Assembly Evaluation – QUAST
quast assembly/GN3/assembly.fasta -o quast_results/GN3
quast assembly/GN6/assembly.fasta -o quast_results/GN6
quast assembly/GN9/assembly.fasta -o quast_results/GN9
#Deactivate:
conda deactivate
---
## 🧾 8️⃣ Genome Annotation – Prokka & Bakta
#Create annotation environment:
conda create -n annotation_env prokka bakta -y
conda activate annotation_env
#Run Prokka:
prokka assembly/GN3/assembly.fasta --outdir annotation/GN3 --prefix GN3
prokka assembly/GN6/assembly.fasta --outdir annotation/GN6 --prefix GN6
prokka assembly/GN9/assembly.fasta --outdir annotation/GN9 --prefix GN9
#(Optional Bakta annotation)
bakta assembly/GN3/assembly.fasta -o annotation/GN3_bakta
bakta assembly/GN6/assembly.fasta -o annotation/GN6_bakta
bakta assembly/GN9/assembly.fasta -o annotation/GN9_bakta
#Deactivate:
conda deactivate
---
## 🌍 9️⃣ Pangenome Analysis – Panaroo
#Create pangenome environment:
conda create -n panaroo_env panaroo roary -y
conda activate panaroo_env
#Run Panaroo:
panaroo -i annotation/GN3/GN3.gff \
         annotation/GN6/GN6.gff \
         annotation/GN9/GN9.gff \
         -o panaroo_output \
         --clean-mode strict
#Deactivate:
conda deactivate

##🧪 🔟 AMR Gene Identification – AMRFinderPlus
#Create AMR environment:
conda create -n amr_env ncbi-amrfinderplus -y
conda activate amr_env
#Run AMRFinder:
amrfinder -n assembly/GN3/assembly.fasta -o amr_output/GN3_amr.txt
amrfinder -n assembly/GN6/assembly.fasta -o amr_output/GN6_amr.txt
amrfinder -n assembly/GN9/assembly.fasta -o amr_output/GN9_amr.txt
#Deactivate:
conda deactivate

##📈 1️⃣1️⃣ Optional: Visualize Panaroo Output (R)
conda create -n r_env r-base r-ggplot2 -y
conda activate r_env
#Then in R:
data <- read.csv("panaroo_output/gene_presence_absence.csv")
summary(data)
