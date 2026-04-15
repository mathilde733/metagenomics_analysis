<p align="center">
  <img src="https://cdn.unifr.ch/uf/v2.4.5/gfx/logo.png" width="200" alt="Logo Université de Fribourg">
</p>

# Bachelor's Thesis
## Metagenomics Analysis of wheat rhizosphere samples collected in Algeria 

Code is available under the MIT license. \
I would like to express my gratitude to **Professor Dr. Laurent Falquet (UniFr, Swiss Institute of Bioinformatics)** for allowing me to be a part of his team. I am sincerely thankful to **PhD. Jeferyd Yepes Garcia (UniFr)** for the valuable assistance provided throughout my thesis, and his kindness. Special thanks to Dr. Bilal Rahmoune (ENSA) for facilitating sample collection in Algeria and enabling collaboration during this project.

### Abstract
This thesis provides an **overview of the advantages of bioinformatics research by highlighting its importance in addressing evolving climatic conditions and the necessity of developing sustainable agriculture**. Specifically, it focuses on the supplementation of nitrogen and phosphate at various concentration on Triticum aestivum (wheat) cultures. It seems that the varieties do not affect significantly the microbial composition of the rhizosphere Velázquez-Sepúlveda I et al., (2011) but the treatments (meaning the different ratios of supplementation) do have an effect. However, the influence of previous crop remains largely unknown and further analysis are required. As described in the paper written by Zerrouk et al., (2022) the **importance of the wheat production is worldwide recognized, yet its vulnerability varies across regions**. The necessity to develop strategies to deal with the global warming’s impact on agriculture is based on the development of sustainable supplement that help plants with the extreme environmental conditions. That is why this thesis is a part of a more global research about strategies against periods of extreme climatic conditions. 

### Dataset
The data comes from various cultures of Triticum aestivum (wheat) listed as a table in the supportive information. They were carefully collected by Doctor Bilal Rahmoune in Algeria and were sequenced using the method Illumina (NGS). This dataset contains two different wheat varieties (Semito and Oued Elbared), four different treatments and two different previous crops (cereals and legumes). These different growth conditions will allow observations of the influence (positive or negative) of these treatments on the growth of wheat plants.

### Pipeline
- Quality Control and cleaning of the data using FastQC, fastp (Shifu Chen et al., 2018), MultiQC \
  Corresponding scripts: run-fastqc.sh; run_fastp.sh; run_multiqc.sh
- Metagenome assembly: co-assembly of the triplicates with **nfcore-mag pipeline** in Nextflow (Krakau et al., 2022 and Ewels et al., 2020) \
  Corresponding scripts: {SAMPLE}sbatch_run_nf-core-mag.sh 
- Taxonomic annotation using BIgMAG dashboard \
  Corresponding scripts: sbatch_mag_flow \
  Link to the github: [BIgMAG dashboard](https://github.com/jeffe107/BIgMAG.git)
- Direct read taxonomic classification: Kraken/Bracken pipeline (Lu et al. 2022), LEfSeR, PCoA and ANOVA analysis in R \
  Corresponding scripts: job_{SAMPLE}.gz.sbatch

  ### References
  - [Krakau et al., 2022](https://doi.org/10.1093/nargab/lqac007)
  - [Ewels et al., 2020](https://doi.org/10.1038/s41587-020-0439-x)
  - [Lu et al., 2022](https://doi.org/10.1038/s41596-022-00738-y)
  - [Shifu Chen et al., 2018](https://doi.org/10.1093/bioinformatics/bty560)
  - Velázquez-Sepúlveda I et al., (2011), *« Bacterial diversity associated with the rhizosphere of wheat plants (Triticum aestivum): Toward a metagenomic analysis »* 81 (2012): 81‑87.
  - [Zerrouk et al., 2022](https://doi.org/10.35516/jjas.v18i4.813)
  
  
