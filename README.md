## Integrated Bioinformatics Workflow for Comparative Genomics and AMR Profiling of Clinical E. coli Isolates
### 📌 Project Overview

This project presents a comprehensive bioinformatics workflow for comparative genomic and antimicrobial resistance (AMR) profiling of three clinical Escherichia coli isolates (GN3, GN6, GN9) obtained from septic patients and sequenced using PacBio HiFi technology.

The study integrates:

1.Quality control

2.Long-read genome assembly

3.Genome annotation

4.Pangenome analysis

5.Antimicrobial resistance gene detection

### 🧬 Dataset Information

Organism: Escherichia coli
Strains: GN3, GN6, GN9
Sequencing Platform: PacBio Sequel IIe
Coverage: ~30x
File Format: FASTQ (HiFi reads)

Data source: [DATA](https://cgr.liv.ac.uk/454/acdarby/LIFE748/)

## Workflow Overview
## 1️⃣ Quality Control

Tool: FastQC v0.12.1
Command:

``` 
fastqc raw/*.fastq -o fastqc_output/
```

## 2️⃣ Genome Assembly

Tool: Flye v2.9.2

```
flye --nano-raw raw/GN3.fastq --out-dir flye_output_GN3 --genome-size 5m
```

Assembly Evaluation:

```
quast flye_output_GN3/assembly.fasta -o quast_results_GN3/
```

## 3️⃣ Genome Annotation

Tools:

Prokka v1.14.6
Bakta v1.8.1

```
prokka --outdir annotation_GN3 --prefix GN3 flye_output_GN3/assembly.fasta
```

## 4️⃣ Pangenome Analysis

Tools:

Panaroo v1.3.3
Roary v3.13.0

```
panaroo -i annotation/*.gff -o panaroo_output --clean-mode strict
```
## Results:

3728 core genes
2387 shell genes
GN6 showed highest number of unique genes

## 5️⃣ AMR Gene Identification

Tool: AMRFinderPlus v3.11.2

```
amrfinder -n flye_output_GN3/assembly.fasta -o amr_output_GN3.txt
```

Detected genes:

acrF
emrD
blaEC
GN9 showed highest AMR gene count (12 genes)

## 📊 Key Results

High-quality assemblies (N50 ~5 Mb)
4 contigs per strain
4841 CDS per strain
3728 core genes identified
Multidrug resistance efflux genes detected
GN9 exhibited elevated resistance profile
