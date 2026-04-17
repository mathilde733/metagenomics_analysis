#!/bin/bash

#SBATCH --job-name="test_magflow"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=64
#SBATCH --time=06:00:00
#SBATCH --mem=128G
#SBATCH --partition=pibu_el8

nextflow run MAGFlow/main.nf -profile apptainer --csv_files '/data/users/mjacquey/magflow_results/sample_sheet_maxbin.csv' --outdir '/data/users/mjacquey/test_magflow/mag_maxbin' --gtdbtk2_db '/data/users/mjacquey/test_magflow/databases/release214' --gunc_db '/data/users/mjacquey/test_magflow/test_result/databases/GUNC_db/gunc_db_progenomes2.1.dmnd' --directory_to_bind '/data/users/mjacquey'
