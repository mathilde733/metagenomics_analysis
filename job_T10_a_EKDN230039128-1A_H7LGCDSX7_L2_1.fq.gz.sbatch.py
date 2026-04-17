#!/bin/bash
#SBATCH --job-name="nf-core_test_T10_a_EKDN230039128-1A_H7LGCDSX7_L2_1.fq.gz"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=64
#SBATCH --time=48:00:00
#SBATCH --mem=32G
#SBATCH --partition=pibu_el8

kraken2 --db /data/users/mjacquey/kraken_bracken --paired /data/users/mjacquey/fastqc-cleaning/T10_a_EKDN230039128-1A_H7LGCDSX7_L2_1.fq.gz --report /data/users/mjacquey/kraken_bracken/kreport/kreport_T10_a_EKDN230039128-1A_H7LGCDSX7_L2_1.fq.gz

bracken -d /data/users/mjacquey/kraken_bracken -i kreport/kreport_T10_a_EKDN230039128-1A_H7LGCDSX7_L2_1.fq.gz -r 100 -l S -t 2 -o bracken_outputs/T10_a_EKDN230039128-1A_H7LGCDSX7_L2_1.fq.gz.bracken -w bracken_reports/T10_a_EKDN230039128-1A_H7LGCDSX7_L2_1.fq.gz.breport

python /data/users/mjacquey/miniconda3/bin/alpha_diversity.py -f bracken_outputs/T10_a_EKDN230039128-1A_H7LGCDSX7_L2_1.fq.gz.bracken -a BP 
python /data/users/mjacquey/miniconda3/bin/alpha_diversity.py -f bracken_outputs/T10_a_EKDN230039128-1A_H7LGCDSX7_L2_1.fq.gz.bracken -a Sh 
python /data/users/mjacquey/miniconda3/bin/alpha_diversity.py -f bracken_outputs/T10_a_EKDN230039128-1A_H7LGCDSX7_L2_1.fq.gz.bracken -a Si 
python /data/users/mjacquey/miniconda3/bin/alpha_diversity.py -f bracken_outputs/T10_a_EKDN230039128-1A_H7LGCDSX7_L2_1.fq.gz.bracken -a ISi

python /data/users/mjacquey/miniconda3/bin/kreport2krona.py -r bracken_reports/T10_a_EKDN230039128-1A_H7LGCDSX7_L2_1.fq.gz.breport -o b_krona_txt/T10_a_EKDN230039128-1A_H7LGCDSX7_L2_1.fq.gz.b.krona.txt --no-intermediate-ranks 
/data/users/mjacquey/kraken_bracken/KronaTools-2.8.1/scripts/ImportText.pl b_krona_txt/T10_a_EKDN230039128-1A_H7LGCDSX7_L2_1.fq.gz.b.krona.txt -o krona_html/T10_a_EKDN230039128-1A_H7LGCDSX7_L2_1.fq.gz.krona.html 
