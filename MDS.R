# ==============================================
# Multi-dimensional Scaling (MDS) Tutorial
# Written by Davide Bittelli
#
# Find brief-explanation of MDS (including advantages and disadvantages) at the end of the script
# ==============================================

# Load necessary libraries
library(ggplot2)     # For visualization
library(dplyr)       # For data manipulation
library(stats)       # For MDS function

# =========================
# 1. Load and Inspect the Data
# =========================

# Use the built-in 'mtcars' dataset
# The dataset contains information about various car models
# Variables:
# - mpg: Miles per gallon (numerical)
# - cyl: Number of cylinders (numerical)
# - disp: Displacement (numerical)
# - hp: Gross horsepower (numerical)
# - drat: Rear axle ratio (numerical)
# - wt: Weight (numerical)
# - qsec: 1/4 mile time (numerical)
# - vs: Engine shape (0 = V-shaped, 1 = Straight) (categorical)
# - am: Transmission (0 = Automatic, 1 = Manual) (categorical)
# - gear: Number of forward gears (numerical)
# - carb: Number of carburetors (numerical)

data(mtcars)

# Preview the dataset
head(mtcars)

# Inspect the structure of the dataset
str(mtcars)

# =========================
# 2. Data Preprocessing
# =========================

# MDS requires numerical data only. We'll exclude the categorical variables 'vs' and 'am'.
mtcars_numerical <- mtcars %>% select(mpg, cyl, disp, hp, drat, wt, qsec, gear, carb)

# Scale the data - MDS is sensitive to the scale of the variables.
# Scaling ensures all variables contribute equally to the analysis.
mtcars_scaled <- scale(mtcars_numerical)

# Verify the scaled data
head(mtcars_scaled)

# =========================
# 3. Compute Distance Matrix
# =========================

# Compute the Euclidean distance matrix
mtcars_dist <- dist(mtcars_scaled, method = "euclidean")

# =========================
# 4. Perform MDS
# =========================

# Set a random seed for reproducibility
set.seed(123)

# Perform classical (metric) MDS
# - k: Number of dimensions to reduce to (2 for 2D visualization)
mds_result <- cmdscale(mtcars_dist, k = 2, eig = TRUE)

# Convert the MDS result to a data frame
mds_data <- data.frame(Dim1 = mds_result$points[, 1],
                       Dim2 = mds_result$points[, 2],
                       Car = rownames(mtcars))

# =========================
# 5. Visualize MDS Results
# =========================

# Plot the MDS results with ggplot2
ggplot(mds_data, aes(x = Dim1, y = Dim2, label = Car)) +
  geom_point(color = "blue", size = 2) +
  geom_text(vjust = 1.5, hjust = 0.5) +
  labs(title = "MDS Visualization of mtcars Dataset",
       x = "MDS Dimension 1",
       y = "MDS Dimension 2") +
  theme_minimal()

# =========================
# 6. Interpretation of MDS Plot
# =========================

# In the plot:
# - Each point represents a car model.
# - The distances between points reflect the dissimilarities between car models
#   based on the numerical features (e.g., mpg, horsepower, weight).
#
# Interpretation:
# - Car models that are closer together are more similar based on the numerical variables.
# - Car models that are far apart are more dissimilar.

# =========================
# 7. Advantages and Disadvantages of MDS
# =========================

# Advantages of MDS:
# - Provides a visual representation of the dissimilarities between observations.
# - Works well with distance matrices derived from numerical data.
# - Can be used for exploratory data analysis to identify patterns and clusters.

# Disadvantages of MDS:
# - Not suitable for categorical or mixed data.
# - Computationally intensive for large datasets.
# - Sensitive to the choice of distance metric.
# - The dimensions in MDS do not have an inherent meaning.

# =========================
# 8. When to Use MDS
# =========================

# Use MDS when:
# - You have numerical data and want to visualize the similarities or dissimilarities between observations.
# - You want a low-dimensional representation of your data for exploratory analysis.
#
# Consider other methods (e.g., PCA, t-SNE, UMAP) when:
# - You need to handle mixed or categorical data.
# - You are interested in preserving local or global structures in a non-linear way.

# =========================
# Conclusion
# =========================

# This script demonstrates how to perform Multi-dimensional Scaling (MDS) for dimensionality reduction
# and visualize the results using the 'mtcars' dataset.
# The comments provide insights into the advantages, disadvantages, and best practices for MDS.

# Use this approach for other datasets with numerical data to explore patterns and relationships!
