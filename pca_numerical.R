# ==============================================
# Revised PCA Tutorial for Continuous Numerical Variables
# Written by: Davide Bittelli
# ==============================================

# Load necessary libraries
library(ggplot2)    # For plotting
library(FactoMineR) # For PCA analysis
library(factoextra) # For PCA visualization
library(dplyr)      # For data manipulation
library(gridExtra)  # For plotting more graphs in the same window


# =========================
# 1. Load and Inspect the Data
# =========================

# Load the 'mtcars' dataset
data(mtcars)

# Preview the dataset
head(mtcars)

# Inspect the structure
str(mtcars)

# =========================
# 2. Data Preprocessing
#
# - If binary variables don't add meaningful insights to the PCA, it's often best to exclude them.
# - If your dataset contains a significant number of binary or categorical variables, 
#   MCA or Factor Analysis of Mixed Data (FAMD) might be more appropriate.
# - Run the PCA both with and without the binary variables to see how much they affect the principal components.
# Including Binary variables is not strictly wrong, however, they can distort the principal components because their variance structure 
# differs from continuous variables. Since PCA maximizes variance, binary variables with limited variance can influence the results 
# disproportionately.
# =========================

# Exclude binary and discrete variables: vs, am, gear, carb
mtcars_continuous <- mtcars %>%
  select(mpg, cyl, disp, hp, drat, wt, qsec)
# or not (try both)


# Check the structure of the continuous data
str(mtcars_continuous)

# Scale the data - PCA is sensitive to the scale of the variables
mtcars_scaled <- scale(mtcars_continuous)

# Verify the scaled data
head(mtcars_scaled)

# =========================
# 3. Perform PCA
# =========================

# Perform PCA using the prcomp function
pca_result <- prcomp(mtcars_scaled, center = TRUE, scale. = TRUE)

# Summary of PCA result
summary(pca_result)
# From here you can see the proportion of Variance explained by each component

# =========================
# 4. Interpret PCA Results
# =========================

# Scree plot to visualize the variance explained by each principal component
fviz_eig(pca_result, addlabels = TRUE)

# =========================
# 5. Biplot of PCA
# =========================

# Biplot to visualize variables and observations together
fviz_pca_biplot(pca_result, repel = TRUE)
# black dots are the observations
# blue arrows are the variables
# Variables pointing in the same direction are positively correlated
# Variables pointing in opposite directions are negatively correlated

# Interpretation:
# - Cars on the Right (e.g., Lincoln Continental, Cadillac Fleetwood, Chrysler Imperial):
#     - These cars are positioned in the direction of wt (weight), disp (Engine displacement), and cyl (Number of cylinders)
#     - They are characterized by large engines, high weight, and more cylinders
# - Cars on the Left (e.g., Honda Civic, Fiat 128, Toyota Corolla):
#     - These cars are in the opposite direction of wt, disp, and cyl
#     - They are characterized by being lighter, with smaller engines and fewer cylinders
#     - They are also characterized by being able to drive more miles per gallon (mpg)
# - Cars at the Bottom (e.g., Merc 230, Toyota Corona):
#   - These cars are associated with higher qsec values, indicating slower acceleration
# - Cars at the Top (e.g., Porsche 914-2, Lotus Europa):
#   - These cars balance between low weight and decent acceleration, differentiating them from the heavier, slower cars
# We could say that the first component separates heavy, powerful cars (right side) from light, efficient cars (left side)
# and
# the second component differentiates between fast-accelerating cars (top) and slower-accelerating cars (bottom)

# Key relationships:
# Weight, displacement, and number of cylinders are positively correlated and influence Dim1
# Acceleration time (qsec) is negatively correlated with weight and displacement, meaning heavier cars tend to be slower

# Same plot but colored by contribution
fviz_pca_var(pca_result, col.var="contrib",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE # Avoid text overlapping
)

# =========================
# 6. Contributions of Variables
# =========================

# Generate the plots
p1 <- fviz_contrib(pca_result, choice = "var", axes = 1, top = 10)
p2 <- fviz_contrib(pca_result, choice = "var", axes = 2, top = 10)

# Arrange them side by side
grid.arrange(p1, p2, ncol = 2)
# Interpretation:
# Dim-1 (72.7% of the variance) is primarily defined by variables related to engine size, power, and weight
# Dim-2 (16.5% of the variance) is primarily influenced by acceleration (qsec) and rear axle ratio (drat)
# Key Observations:
# - Dim-1:
#     - Explains a large proportion of the total variance (72.7%)
#     - Focuses on engine size, power, weight, and fuel efficiency
#     - Interpretation: Vehicles with more cylinders, higher displacement, and heavier weight tend to be 
#       less fuel-efficient (lower mpg)
# - Dim-2:
#     - Explains a smaller proportion of the variance (16.5%)
#     - Highlights acceleration (qsec) and gearing (drat)
#     - Interpretation: This component differentiates cars based on how quickly they accelerate (with qsec being a critical factor)
# - Red Dotted Lines:
#     - The red dashed lines represent the expected average contribution if all variables contributed equally
#     - Variables above this line contribute more than expected, indicating they play a significant role in defining the principal components
# =========================
# 7. Individual Plot
# =========================

# Plot observations (cars) with their principal component scores
fviz_pca_ind(pca_result, geom.ind = "point", repel = TRUE) # geom.ind = "text" if you want the name of the observations instead of the points

fviz_pca_ind(pca_result, col.ind = "contrib", # colored by qualitiy of their contrib # or "cos2" = the quality of the individuals on the factor map
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE # Avoid text overlapping (slow if many points)
)
# =========================
# Conclusion
# =========================

# This revised script excludes binary variables from PCA,
# ensuring a focus on continuous numerical data for accurate results.
