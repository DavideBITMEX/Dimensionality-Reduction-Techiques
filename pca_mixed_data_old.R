# ==============================================
# PCA Tutorial for Mixed Data (FAMD, Numerical + Categorical)
# Written by: Davide Bittelli
# ==============================================

# Load necessary libraries
library(FactoMineR) # For FAMD analysis
library(factoextra) # For visualization
library(dplyr)      # For data manipulation

# =========================
# 1. Load and Prepare the Data
# =========================

# Load the 'mtcars' dataset
data(mtcars)

# Add multiple categorical variables to the dataset
mtcars_mixed <- mtcars %>%
  mutate(
    # Transmission type: Automatic or Manual
    Transmission = factor(ifelse(am == 0, "Automatic", "Manual")),
    
    # Engine shape: V-shaped or Straight (from 'vs' variable)
    Engine_Shape = factor(ifelse(vs == 0, "V-Shaped", "Straight")),
    
    # Number of gears: 3, 4, or 5 (categorical)
    Gears = factor(gear, levels = c(3, 4, 5), labels = c("ThreeG", "FourG", "FiveG")),
    
    # Number of cylinders: 4, 6, or 8 (categorical)
    Cylinders = factor(cyl, levels = c(4, 6, 8), labels = c("FourCy", "SixCy", "EightCy")) # don't call them the same as other factor --> FourG != FourCy
  ) %>%
  # Exclude redundant variables ('am', 'vs', 'gear', and 'cyl')
  select(-am, -vs, -gear, -cyl)

# Preview the modified dataset
head(mtcars_mixed)

# Inspect the structure of the dataset
str(mtcars_mixed)

# =========================
# 2. Perform FAMD
# =========================

# Perform Factor Analysis of Mixed Data (FAMD)
famd_result <- FAMD(mtcars_mixed, ncp = 5, graph = FALSE)

# Summary of the FAMD result
summary(famd_result)

famd_result$eig
# eigenvalue percentage of variance cumulative percentage of variance
# comp 1  6.9520584              53.477372                          53.47737
# comp 2  2.7512584              21.163526                          74.64090
# comp 3  1.2180147               9.369344                          84.01024
# comp 4  0.6957658               5.352045                          89.36229
# comp 5  0.4984026               3.833866                          93.19615

# =========================
# 3. Visualize FAMD Results
# =========================

# Scree plot: visualize the percentage of variance explained
fviz_eig(famd_result, addlabels = TRUE)

# =========================
# 4. Biplot of FAMD
# =========================

# Visualize the variables (numerical and categorical)
fviz_famd_var(famd_result, repel = TRUE)
# Visualize the variables and the direction (numerical and categorical)
fviz_pca_var(famd_result, col.var = "black")
# Visualize the variables, the direction and the contribution (numerical and categorical)
fviz_pca_var(famd_result, col.var="contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE # Avoid text overlapping
)

# =========================
# 5. Contributions of Variables
# =========================


# Contributions of numerical variables to the first dimension
p1 <- fviz_contrib(famd_result, choice = "var", axes = 1, top = 10)
# Contributions of categorical variables to the first dimension
p2 <- fviz_contrib(famd_result, choice = "quali.var", axes = 1, top = 10)
# Arrange them side by side
grid.arrange(p1, p2, ncol = 2)

# Contributions of numerical variables to the second dimension
p3 <- fviz_contrib(famd_result, choice = "var", axes = 2, top = 10)
# Contributions of categorical variables to the seconf dimension
p4 <- fviz_contrib(famd_result, choice = "quali.var", axes = 2, top = 10)
# Arrange them side by side
grid.arrange(p3, p4, ncol = 2)

# Arrange them side by side
grid.arrange(p1, p2, p3, p4, nrow = 2, ncol = 2)

# =========================
# 6. Individual Plot
# =========================

# Visualize the individuals, colored in blue
fviz_famd_ind(famd_result, repel = TRUE)

# Plot observations colored by Transmission type
fviz_famd_ind(famd_result,
              habillage = "Transmission",
              addEllipses = TRUE,
              repel = TRUE)

# Plot observations, colored by Transmission type
fviz_famd_ind(famd_result, 
              habillage = "Engine_Shape",
              addEllipses = TRUE,
              repel = TRUE)


# =========================
# Conclusion
# =========================

# This script demonstrates how to perform FAMD with multiple categorical variables,
# how to visualize results using biplots and contribution plots, and how to interpret them.
