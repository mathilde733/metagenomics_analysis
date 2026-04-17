# ==============================================================================
# Microbial Community Analysis: PCoA Ordination Plotting
# ==============================================================================

# --- Step 1: Load Required Packages ---
library("phyloseq")   # Core microbiome analysis package
library("patchwork")  # For combining multiple plots
library("magrittr")   # Provides pipe operators
library("dplyr")      # Data manipulation
library("tidyr")      # Data tidying
library("otuSummary") # Summary statistics for OTU tables
library("lefser")     # LEfSe analysis in R

# --- Step 2: Data Import ---

# Import the BIOM file (contains OTU table and Taxonomy)
test <- import_biom("breportPCOA.biom")

# Import sample metadata
tab_sam = read.csv("sample_table23.csv")

# --- Step 3: Phyloseq Object Construction ---

# Convert the "replicat" column into row names to match OTU table headers
samples_df <- tab_sam %>% 
  tibble::column_to_rownames("replicat") 

# Create sample data, OTU table, and Taxonomy table components
samples = sample_data(samples_df)
otu_inf = test@otu_table
phy_inf = test@tax_table

# Assemble the final Phyloseq object containing all experiment information
all_data <- phyloseq(otu_inf, phy_inf, samples)

# Redundant check/reassembly to ensure object integrity
physeq <- phyloseq(otu_table(all_data), tax_table(all_data), sample_data(all_data))

# --- Step 4: PCoA Ordination Analysis ---

# Perform Principal Coordinates Analysis (PCoA) using Weighted UniFrac/Distance
# Note: Ensure a phylogenetic tree is present if using Weighted UniFrac
ordu = ordinate(physeq, "PCoA", weighted = TRUE)

# --- Step 5: Data Visualization ---

# Generate the base ordination plot
# Grouping samples by 'treatment' (color) and 'varieties' (shape)
p = plot_ordination(physeq, ordu, color = "treatment", shape = "varieties")

# Customize plot aesthetics
p = p + geom_point(size = 7, alpha = 0.75) +             # Increase point size and add transparency
    scale_colour_brewer(type = "qual", palette = "Set1") + # Apply high-contrast color palette
    ggtitle("PCoA of Microbial Communities")            # Add plot title

# Display the final plot
print(p)
