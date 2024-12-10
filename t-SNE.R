# ==============================================
# t-SNE for Dimensionality Reduction
# Written by: Davide Bittelli
#
# Find brief-explanation of t-SNE (including advantages and disadvantages) at the end of the script
# ==============================================

# Load necessary libraries
library(Rtsne)       # For t-SNE analysis
library(ggplot2)     # For visualization
library(dplyr)       # For data manipulation
library(plotly)      # For 3D visualization

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

# t-SNE works best with continuous numerical data because it calculates pairwise distances or similarities between points 
# in a high-dimensional space.

# Remove duplicate rows also on the raw dataset (otherwise t-SNE wouldn't work)
# if you have many identical rows you can add a column 'ID' to make them unique (if you do so, you don't need to run the following command)
iris_unique <- distinct(as.data.frame(iris))

# t-SNE requires numerical data only. We'll exclude the categorical variable 'Species'.
iris_data <- iris_unique %>% select(-Species)

# Scale the data - t-SNE is sensitive to the scale of the variables.
# Scaling ensures all variables contribute equally to the analysis.
iris_scaled <- scale(iris_data)

# Verify the scaled data
head(iris_scaled)

# =========================
# 3. Perform t-SNE
# =========================

# Set a random seed for reproducibility
set.seed(123)

# Perform t-SNE on the scaled data
# - perplexity: Balances local and global aspects of the data (typical values: 5 to 50)
# - theta: Speed/accuracy trade-off (0 for exact t-SNE, higher values for faster approximation)
# - max_iter: Number of iterations (default is 1000)

# Perform t-SNE (on 2 dimensions) on the unique scaled data
tsne_result_2D <- Rtsne(as.matrix(iris_scaled), perplexity = 30, theta = 0.5, max_iter = 1000)
# Perform t-SNE (on 3 dimensions) on the unique scaled data
tsne_result_3D <- Rtsne(as.matrix(iris_scaled), dims = 3, perplexity = 30, theta = 0.5, max_iter = 1000)

# The result contains a 2D embedding

# =========================
# 4a. Visualize t-SNE Results in 2D
# =========================

# Combine the t-SNE results with the original 'Species' variable for plotting
tsne_data_2D <- data.frame(tsne_result_2D$Y, Species = iris_unique$Species)
colnames(tsne_data_2D) <- c("Dim1", "Dim2", "Species")

# Plot the t-SNE results with ggplot2
ggplot(tsne_data_2D, aes(x = Dim1, y = Dim2, color = Species)) +
  geom_point(size = 2) +
  labs(title = "t-SNE Visualization of Iris Dataset",
       x = "t-SNE Dimension 1",
       y = "t-SNE Dimension 2") +
  theme_minimal() +
  scale_color_brewer(palette = "Set1")

# =========================
# 4b. Visualize t-SNE Results in 3D
# =========================

# Combine the t-SNE results with the original 'Species' variable for plotting
# Note: Since we removed duplicates, we need to ensure the Species labels match the unique data
tsne_data_3D <- data.frame(tsne_result_3D$Y, Species = iris_unique$Species)
colnames(tsne_data_3D) <- c("Dim1", "Dim2", "Dim3", "Species")

# Plot the t-SNE results in 3D with plotly
plot_ly(tsne_data_3D, x = ~Dim1, y = ~Dim2, z = ~Dim3, color = ~Species, colors = c("#1f77b4", "#ff7f0e", "#2ca02c")) %>%
  add_markers(size = 5) %>%
  layout(title = "3D t-SNE Visualization of Iris Dataset",
         scene = list(xaxis = list(title = "t-SNE Dimension 1"),
                      yaxis = list(title = "t-SNE Dimension 2"),
                      zaxis = list(title = "t-SNE Dimension 3")))

# =========================
# 5. Interpretation of t-SNE Plot
# =========================

# In the plot:
# - Each point represents a flower.
# - Colors represent the three species: setosa, versicolor, and virginica.
# - t-SNE tries to preserve local neighborhood structures, so clusters in the plot suggest
#   that those points are similar in the original high-dimensional space.

# Interpretation:
# - The clusters for different species are well-separated, especially for setosa.
# - Some overlap between versicolor and virginica suggests these two species are more similar.

# =========================
# 6. Advantages and Disadvantages of t-SNE
# =========================

# Advantages of t-SNE:
# - Excellent for visualizing high-dimensional data in 2D or 3D.
# - Captures complex non-linear relationships and local structures.
# - Effective for identifying clusters and patterns.

# Disadvantages of t-SNE:
# - t-SNE does not provide a measure of explained variance for each dimension (PCA does):
#     used primarily for visualization and clustering purposes rather than for understanding the proportion of variance explained 
#     by each dimension
# - Computationally intensive for large datasets.
# - Sensitive to hyperparameters (e.g., perplexity, learning rate).
# - Not a deterministic method: results may vary with different seeds.
# - Difficult to interpret dimensions (t-SNE dimensions have no inherent meaning).
# - Not suitable for preserving global structure.

# =========================
# 7. Practical Tips for Using t-SNE
# =========================

# - **Perplexity**: Try values between 5 and 50. It affects the balance between local and global structures.
# - **Iterations**: Increase the number of iterations if the results are not stable.
# - **Multiple Runs**: Because t-SNE is stochastic, run it multiple times with different seeds.
# - **Scaling**: Always scale your data before applying t-SNE.

# =========================
# Conclusion
# =========================

# This script demonstrates how to perform t-SNE for dimensionality reduction
# and visualize the results using the 'iris' dataset.
# The comments provide insights into the advantages, disadvantages, and best practices for t-SNE.

# Use this approach for other datasets with high-dimensional data to uncover hidden patterns!
