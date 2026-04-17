#!/bin/bash

#SBATCH --job-name="T30_nf-core"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=48:00:00
#SBATCH --mem=8G
#SBATCH --partition=pibu_el8

module load fastp/0.23.4-GCC-10.3.0
module load FastQC/0.11.9-Java-11
module load BUSCO/5.4.2-foss-2021a
module load Bowtie2/2.4.4-GCC-10.3.0
module load SAMtools/1.13-GCC-10.3.0
module load prokka/1.14.5-gompi-2021a
module load BioPerl/1.7.8-GCCcore-10.3.0

export APPTAINER_TMPDIR=/data/users/mjacquey

#nextflow run nf-core/mag -r 2.5.4 -profile test,conda --outdir /data/users/mjacquey/test_nf_core 
#nextflow run nf-core/mag -r 2.5.4 -profile conda --input '/data/users/mjacquey/fastqc-cleaning/T10_*_L2_{1,2}.fq.gz' --outdir /data/users/mjacquey/nf-core_results/T10_results --coassemble_group --refine_bins_dastool -resume -c ignore_depthplot.config --skip_gtdbtk
nextflow run nf-core/mag -r 2.5.4 -profile apptainer --input '/data/users/mjacquey/fastqc-cleaning/T30_*_L2_{1,2}.fq.gz' --outdir /data/users/mjacquey/nf-core_results/T30_results --coassemble_group --refine_bins_dastool -resume --skip_gtdbtk

#nextflow run nf-core/mag -r 2.5.4 -profile unibe_ibu --input '/data/users/mjacquey/fastqc-cleaning/samplesheet.csv' --outdir /data/users/mjacquey/nf-core_results/results --coassemble_group --refine_bins_dastool -resume
#nextflow run nf-core/mag -r 2.5.4 -profile unibe_ibu --input '/data/users/mjacquey/fastqc-cleaning/T30_*{1,2}.fq.gz' --outdir /data/users/mjacquey/nf-core_results/T30_results -resume
#nextflow run nf-core/mag -r 2.5.4 -profile unibe_ibu --input '/data/users/mjacquey/fastqc-cleaning/T40_*{1,2}.fq.gz' --outdir /data/users/mjacquey/nf-core_results/T40_results -resume
#nextflow run nf-core/mag -r 2.5.4 -profile unibe_ibu --input '/data/users/mjacquey/fastqc-cleaning/T50_*{1,2}.fq.gz' --outdir /data/users/mjacquey/nf-core_results/T50_results -resume
#nextflow run nf-core/mag -r 2.5.4 -profile unibe_ibu --input '/data/users/mjacquey/fastqc-cleaning/B5S_*{1,2}.fq.gz' --outdir /data/users/mjacquey/nf-core_results/B5S_results -resume
#nextflow run nf-core/mag -r 2.5.4 -profile unibe_ibu --input '/data/users/mjacquey/fastqc-cleaning/B2S_*{1,2}.fq.gz' --outdir /data/users/mjacquey/nf-core_results/B2S_results -resume
