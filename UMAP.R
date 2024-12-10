# ==============================================
# UMAP Tutorial for Dimensionality Reduction
# Written by Davide Bittelli
#
# Find brief-explanation of UMAP (including advantages and disadvantages) at the end of the script
# ==============================================

# Load necessary libraries
library(umap)        # For UMAP analysis
library(ggplot2)     # For 2D visualization
library(plotly)      # For 3D visualization
library(dplyr)       # For data manipulation

# =========================
# 1. Load and Inspect the Data
# =========================

# Use the built-in 'iris' dataset
# The dataset contains measurements of 150 iris flowers
# Variables:
# - Sepal.Length: Length of the sepal (numerical)
# - Sepal.Width: Width of the sepal (numerical)
# - Petal.Length: Length of the petal (numerical)
# - Petal.Width: Width of the petal (numerical)
# - Species: Categorical variable with three species (setosa, versicolor, virginica)

data(iris)

# Preview the dataset
head(iris)

# Inspect the structure of the dataset
str(iris)

# =========================
# 2. Data Preprocessing
# =========================

# UMAP works best with continuous numerical data because it calculates pairwise distances or similarities between points 
# in a high-dimensional space.

# Remove duplicate rows also on the raw dataset (otherwise UMAP wouldn't work)
# if you have many identical rows you can add a column 'ID' to make them unique (if you do so, you don't need to run the following command)
iris_unique <- distinct(as.data.frame(iris))

# UMAP requires numerical data only. We'll exclude the categorical variable 'Species'.
iris_data <- iris_unique %>% select(-Species)

# Scale the data - UMAP is sensitive to the scale of the variables.
# Scaling ensures all variables contribute equally to the analysis.
iris_scaled <- scale(iris_data)

# Verify the scaled data
head(iris_scaled)

# =========================
# 3. Perform UMAP
# =========================

# Set a random seed for reproducibility
set.seed(123)

# Perform UMAP on the scaled data in 3 dimensions
umap_result_2D <- umap(iris_scaled, n_neighbors = 15, min_dist = 0.1, n_components = 2)
# Perform UMAP on the scaled data in 3 dimensions
umap_result_3D <- umap(iris_scaled, n_neighbors = 15, min_dist = 0.1, n_components = 3)

# =========================
# 4a. Visualize UMAP Results in 2D
# =========================

# Combine the UMAP results with the original 'Species' variable for plotting
umap_data_2D <- data.frame(umap_result_2D$layout, Species = iris_unique$Species)
colnames(umap_data_2D) <- c("Dim1", "Dim2", "Species")

# Plot the UMAP results with ggplot2
ggplot(umap_data_2D, aes(x = Dim1, y = Dim2, color = Species)) +
  geom_point(size = 2) +
  labs(title = "UMAP Visualization of Iris Dataset",
       x = "UMAP Dimension 1",
       y = "UMAP Dimension 2") +
  theme_minimal() +
  scale_color_brewer(palette = "Set1")

# =========================
# 4b. Visualize UMAP Results in 3D
# =========================

# Combine the UMAP results with the original 'Species' variable for plotting
umap_data_3D <- data.frame(umap_result_3D$layout, Species = iris_unique$Species)
colnames(umap_data_3D) <- c("Dim1", "Dim2", "Dim3", "Species")

# Plot the UMAP results in 3D with plotly
plot_ly(umap_data_3D, x = ~Dim1, y = ~Dim2, z = ~Dim3, color = ~Species, colors = c("#1f77b4", "#ff7f0e", "#2ca02c")) %>%
  add_markers(size = 5) %>%
  layout(title = "3D UMAP Visualization of Iris Dataset",
         scene = list(xaxis = list(title = "UMAP Dimension 1"),
                      yaxis = list(title = "UMAP Dimension 2"),
                      zaxis = list(title = "UMAP Dimension 3")))

# =========================
# 5. Interpretation of 3D UMAP Plot
# =========================

# In the plot:
# - Each point represents a flower.
# - Colors represent the three species: setosa, versicolor, and virginica.
# - UMAP tries to preserve both local and global structure, so clusters suggest similar characteristics in the original space.

# Interpretation:
# - The clusters for different species are well-separated, especially for setosa.
# - Some overlap between versicolor and virginica suggests these two species are more similar.

# =========================
# 6. Advantages and Disadvantages of UMAP
# =========================

# Advantages of UMAP:
# - Faster computation compared to t-SNE, especially for large datasets.
# - Preserves both local and global structure effectively.
# - Can scale to very large datasets.
# - Deterministic by default (results are reproducible with the same seed).

# Disadvantages of UMAP:
# - UMAP does not provide a measure of explained variance for each dimension (PCA does):
#     used primarily for visualization and clustering purposes rather than for understanding the proportion of variance explained 
#     by each dimension
# - Sensitive to hyperparameters (e.g., n_neighbors, min_dist).
# - Interpretability of dimensions is limited (like t-SNE).
# - May struggle with extremely high-dimensional or noisy data.

# =========================
# 7. When to Use UMAP
# =========================

# Use UMAP when:
# - You have large datasets where t-SNE would be too slow.
# - You want to preserve both local and global structure in your data.
# - You need deterministic results (reproducibility).
#
# Consider t-SNE when:
# - Your dataset is small to medium-sized, and local structure is more important.
# - You want to explore different stochastic outcomes (t-SNE can produce varied results).

# =========================
# Conclusion
# =========================

# This script demonstrates how to perform UMAP for dimensionality reduction
# and visualize the results using the 'iris' dataset in both 2D and 3D.
# The comments provide insights into the advantages, disadvantages, and best practices for UMAP.

# Use this approach for other datasets with high-dimensional data to uncover hidden patterns!