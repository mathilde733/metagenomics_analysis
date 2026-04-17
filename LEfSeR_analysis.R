# ==============================================================================
# Microbial Community Analysis: Phyloseq to LEfSeR and Heatmap Visualization
# ==============================================================================

# --- Step 1: Load Data and Initialize Phyloseq ---

# Import BIOM file containing OTU and taxonomy data
# Note: Ensure the file path is correct in your working directory
test <- import_biom("breportT50_5S.biom")

# Load metadata/sample information
tab_sam = read.csv("sample_table25.csv")

# Process metadata: Convert a specific column to row names to match Phyloseq requirements
samples_df <- tab_sam %>% 
  tibble::column_to_rownames("replicat") 

# Create phyloseq components
samples = sample_data(samples_df)
otu_inf = test@otu_table
phy_inf = test@tax_table

# Assemble the master phyloseq object
all_data <- phyloseq(otu_inf, phy_inf, samples)

# --- Step 2: Taxonomy Cleaning ---

# Remove the prefix (e.g., "k__", "p__") from taxonomy strings for better readability
all_data@tax_table@.Data <- substring(all_data@tax_table@.Data, 4)

# Assign standard taxonomic rank names to columns
colnames(all_data@tax_table@.Data) <- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species")

# --- Step 3: Data Filtering and Transformation ---

# Subset the dataset to include only specific experimental groups (T50 and B5S)
two_sample_data <- subset_samples(all_data, groupe == "T50" | groupe == "B5S")

# Melt phyloseq object into a long-format dataframe for manipulation
counts <- psmelt(two_sample_data)
counts$Genus <- as.character(counts$Genus)

# Aggregate abundance data at the Genus level per sample
counts_genus <- counts %>% 
  select(Genus, Sample, Abundance) %>%
  group_by(Genus, Sample) %>%
  mutate(sum_col = sum(Abundance)) %>%
  ungroup() %>%
  distinct(Genus, Sample, .keep_all = TRUE)

# Reshape data from long to wide format (Genera as rows, Samples as columns)
counts_genus <- as.data.frame(counts_genus)
counts_genus$Abundance <- NULL
count_genus_wide <- spread(counts_genus, Sample, sum_col)

# Handle potential empty taxa (unclassified) and set row names
count_genus_wide <- count_genus_wide[-1,] 
rownames(count_genus_wide) <- count_genus_wide$Genus
count_genus_wide$Genus <- NULL

# --- Step 4: Differential Abundance Analysis (LEfSeR) ---

# Prepare Metadata for SummarizedExperiment
colData <- as(sample_data(two_sample_data), "data.frame")

# Manually update row names to ensure match between assay and colData
new_rownames <- c("B5S_a","B5S_b","B5S_c","T50_a","T50_b","T50_c") 
rownames(colData) <- new_rownames

# Construct the SummarizedExperiment object required by lefser
se <- SummarizedExperiment(assays = list(counts = count_genus_wide), colData = colData)

# Run LEfSe (Linear Discriminant Analysis Effect Size)
res <- lefser(se, groupCol = "groupe")

# Plot LEfSe results
lefserPlot(res)

# --- Step 5: Consolidating Results from Multiple Comparisons ---

# Extract LDA scores into a data frame
lda_table16 <- data.frame(Genus = res$Names, LDA_Score = res$scores)

# List of previously generated LDA tables for different comparisons
lda_tables_list <- list(lda_table4, lda_table5, lda_table10, lda_table11, lda_table12, lda_table16)

# Rename columns dynamically to identify source comparisons
for (i in seq_along(lda_tables_list)) {
  colnames(lda_tables_list[[i]]) <- c("Genus", paste0("LDA_Score_", i))
}

# Perform an outer join to merge all LDA comparisons into a single master table
final_table <- Reduce(function(x, y) merge(x, y, by = "Genus", all = TRUE), lda_tables_list)

# Assign meaningful headers to the comparisons
colnames(final_table) <- c("Genus", "T10_T50", "T10_B2S", "T10_B5S", "B2S_T50", "B2S_B5S", "T50_B5S")

# Export final consolidated table to CSV
write.csv(final_table, file = "~/Desktop/final_table4.csv", row.names = FALSE)

# --- Step 6: Interactive Heatmap Visualization ---

library(heatmaply)

# Load the merged LDA table
final_table <- read.csv("final_table4.csv", header = TRUE, row.names = 1)

# Data Cleaning: Replace NAs with 0 and apply a significance threshold (|LDA| > 3)
final_table[is.na(final_table)] <- 0
final_table_filtered <- final_table
final_table_filtered[final_table > -3 & final_table < 3] <- 0

# Remove rows (genera) that do not meet the threshold in any comparison
sums_per_row <- rowSums(final_table_filtered != 0)
final_table_filtered <- final_table_filtered[sums_per_row != 0, ]

# Generate Interactive Heatmap
heatmaply(final_table_filtered,
          scale = "none",
          margins = c(80, 80),
          k_col = 6,          # Cluster columns into 6 groups
          k_row = 68,         # Cluster rows (adjusted based on taxa count)
          plot_method = "plotly",
          width = 1000,
          height = 1000
)
