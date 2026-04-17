# ==============================================================================
# Statistical Analysis: Yield Components (Replicating Jamovi Results)
# ==============================================================================

# --- Load Required Libraries ---
library(car)      # For Type III ANOVA
library(emmeans)  # For Tukey Post-Hoc tests

# Note: 'stats_data' should contain your columns: grains_yield, treatment, etc.

# ------------------------------------------------------------------------------
# 1. ANALYSIS: Grains Yield
# ------------------------------------------------------------------------------

# Define the linear model for Grains Yield
model_yield <- lm(grains_yield ~ traitement, data = stats_data)

# ANOVA Type III
# Results from Jamovi: F(4, 19) = 92.9, p < .001
Anova(model_yield, type = "3")

# Tukey Post-Hoc Test
post_hoc_yield <- emmeans(model_yield, pairwise ~ traitement, adjust = "tukey")

# Display Post-Hoc Results
# Key findings from your data:
# - control vs N1 P1: Diff = -15.40, p < .001 (Significant)
# - N1 P1 vs N2 P2:   Diff = -20.82, p < .001 (Significant)
# - N2 vs N2 P2:      Diff = -17.79, p < .001 (Significant)
summary(post_hoc_yield$contrasts)


# ------------------------------------------------------------------------------
# 2. ANALYSIS: Number of Ears
# ------------------------------------------------------------------------------

model_ears <- lm(number_of_ears ~ traitement, data = stats_data)

# ANOVA Type III
# Results from Jamovi: F(4, 19) = 16.4, p < .001
Anova(model_ears, type = "3")

# Post-Hoc findings:
# - control vs N2 P2: Diff = -88.39, p < .001
# - N1 P1 vs control: Diff = 51.56, p = 0.014
summary(emmeans(model_ears, pairwise ~ traitement, adjust = "tukey")$contrasts)


# ------------------------------------------------------------------------------
# 3. ANALYSIS: Thousand Kernels 
# ------------------------------------------------------------------------------

model_tk <- lm(thousand_kernels ~ traitement, data = stats_data)

# ANOVA Type III
# Results from Jamovi: F(4, 19) = 22.0, p < .001
Anova(model_tk, type = "3")

# Post-Hoc findings:
# - control vs N2 P2: Diff = -8.97, p < .001
# - N1 P1 vs control: Diff = 5.69, p = 0.002
summary(emmeans(model_tk, pairwise ~ traitement, adjust = "tukey")$contrasts)


# ------------------------------------------------------------------------------
# 4. ANALYSIS: Number of Grains
# ------------------------------------------------------------------------------

model_ng <- lm(number_of_grains ~ traitement, data = stats_data)

# ANOVA Type III
# Results from Jamovi: F(4, 19) = 29.4, p < .001
Anova(model_ng, type = "3")

# Post-Hoc findings:
# - control vs N2 P2: Diff = -10.19, p < .001
# - N1 P1 vs N2 P2:   Diff = -5.65, p = 0.002
summary(emmeans(model_ng, pairwise ~ traitement, adjust = "tukey")$contrasts)


# ------------------------------------------------------------------------------
# 5. ANALYSIS: Theoretical Yields
# ------------------------------------------------------------------------------

model_theo <- lm(theoretical_yields ~ traitement, data = stats_data)

# ANOVA Type III
# Results from Jamovi: F(4, 19) = 72.2, p < .001
Anova(model_theo, type = "3")

# Post-Hoc findings:
# - control vs N2 P2: Diff = -38.59, p < .001
# - P2 vs control:    Diff = 15.85, p < .001
summary(emmeans(model_theo, pairwise ~ traitement, adjust = "tukey")$contrasts)
