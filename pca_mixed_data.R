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
    Cylinders = factor(cyl, levels = c(4, 6, 8), labels = c("FourCy", "SixCy", "EightCy"))
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

# Scree plot: visualize the percentage of variance explained by each dimension
fviz_eig(famd_result, addlabels = TRUE, ylim = c(0, 60))

# Interpretation of Scree Plot:
# - Dim1 explains 53.5% of the variance, and Dim2 explains 21.2%.
# - Together, Dim1 and Dim2 capture 74.7% of the total variance.
# - Focus on the first two dimensions for most of the insights.

# =========================
# 4. Biplot of FAMD
# =========================

# Biplot showing both numerical and categorical variables
fviz_famd_var(famd_result, repel = TRUE)
# Visualize the variables and the direction (numerical and categorical)
fviz_pca_var(famd_result, col.var = "black")
# Visualize the variables, the direction and the contribution (numerical and categorical)
fviz_pca_var(famd_result, col.var="contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE # Avoid text overlapping
)
# For example, 'Gears' and 'carb' contribute significantly to Dim2, while 'Cylinders', 'disp', and 'mpg' contribute to Dim1

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

# Interpretation:
# - In Dim1, 'Cylinders', 'disp', and 'mpg' contribute the most among numerical variables
# - In Dim2, 'Gears' and 'qsec' have the highest contributions
# - Among categorical variables, 'FiveG' and 'Manual' are significant contributors to Dim2
# - Among categorical variables, 'FourCy' and 'EightCy' are significant contributors to Dim1 but, since they're below the red line,
#   I decided to not comment them
# - Red Dotted Lines:
#     - The red dashed lines represent the expected average contribution if all variables contributed equally
#     - Variables above this line contribute more than expected, indicating they play a significant role in defining the principal components

# =========================
# 6. Individuals Plot
# =========================

# Visualize the individuals, colored in blue
fviz_famd_ind(famd_result, repel = TRUE)

# Plot individuals, colored by Transmission type
fviz_famd_ind(famd_result, 
              habillage = "Transmission", 
              addEllipses = TRUE, 
              repel = TRUE)

# Interpretation of Individuals Plot (Transmission):
# - Points represent cars, colored by Transmission type (Manual or Automatic).
# - Cars with Manual transmissions tend to cluster on the left side of Dim1.
# - Cars with Automatic transmissions are on the right side of Dim1.

# Plot individuals, colored by Engine Shape
fviz_famd_ind(famd_result, 
              habillage = "Engine_Shape", 
              addEllipses = TRUE, 
              repel = TRUE)

# Interpretation of Individuals Plot (Engine Shape):
# - Cars with Straight engines are clustered on the left side of Dim1.
# - Cars with V-shaped engines are on the right side of Dim1.

# =========================
# Conclusion
# =========================

# This script demonstrates how to perform FAMD on mixed data (numerical and categorical),
# visualize the results, and interpret the contributions of variables and observations.
# The plots provide insights into how the cars cluster based on their numerical and categorical attributes.
