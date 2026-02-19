# Assembly

NOTE
>This document makes the assumption:
>- That you have installed conda and the required software.
>- That you have run the command `conda activate genomics_env`

### Assembly datasets and anaylsis provided:
[DATA](https://github.com/acdarby/LIFE748/blob/main/data_downloads.md)

Pacbio E. coli three genomes at 30x coverage:

| raw reads      | fastqc | flye | quast |
| ---------------| ------ |------|-------|
| GN3_hifix30.fastq |        |      |        |
| GN6_hifix30.fastq |        |      |        |
| GN9_hifix30.fastq |        |      |        |

ONT Salonella genome at 30X coverage:

| raw reads      | fastqc | flye | quast |
| ---------------| ------ |------|-------|
| S_longx30.fastq |        |      |        |
| S_shortx30.fastq |        |      |        |
| S_raw_longx30.fastq |        |      |        |
| S_longx10.fastq |        |      |        |
| S_longx100.fastq |        |      |        |

Pacbio Salonella genome at 30X coverage:
| raw reads      | fastqc | flye | quast |
| ---------------| ------ |------|-------|
| S_hifi_longx30.fastq |        |      |        |





### We can use `fastqc` to check the error profiles of the reads
```
fastqc --help
```


### We are using the assemblier called `flye` [Flye github](https://github.com/fenderglass/Flye)
```
flye --help
```
This command for ONT raw (uncorrected) reads:
```
flye --nano-raw S_ONT_raw_short.fastq --out-dir S_ONT_raw_short
```
This command for PacBio HiFi:
```
flye --pacbio-hifi GN3_long.fastq --out-dir GN3_long
```
Here's a ready-to-use **QUAST protocol** for multiple assemblies, formatted for GitHub:

---

## Running QUAST on Multiple Assemblies

Instructions to run QUAST on multiple genome assemblies in a single command.

### Steps

1. **Prepare Your Assembly Files**:  
   Place all assembly files (e.g., FASTA files) into a single directory.

2. **Run QUAST on Multiple Assemblies**:
   You can specify all assembly files individually or use the directory path containing all assemblies.

   - **Directly Specifying Files**:
     ```bash
     quast.py assembly1.fasta assembly2.fasta assembly3.fasta -o quast_output
     ```

   - **Using a Directory**:
     ```bash
     quast.py /path/to/assemblies/* -o quast_output
     ```

3. **Optional: Use a Reference Genome**  
   If you have a reference genome, include it to get alignment-based metrics.
   ```bash
   quast.py /path/to/assemblies/* -r reference_genome.fasta -o quast_output
   ```

4. **Additional Options**:  
   QUAST offers various parameters for customization:
   - `--gene-finding` to predict genes
   - `--threads <num>` to specify thread count
   - `--min-contig <size>` to set a minimum contig length (default is 500 bp)

5. **Example Command with Options**:
   ```bash
   quast.py /path/to/assemblies/* -r reference_genome.fasta --gene-finding --threads 4 -o quast_output
   ```

### Results
All results will be saved in the `quast_output` directory, including summary reports, assembly metrics, and additional analyses.
