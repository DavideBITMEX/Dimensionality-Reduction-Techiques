# Dimensionality Reduction Techniques

Welcome to the "Dimensionality Reduction Techniques" repository where various dimensionality reduction methods are explored using R-Studio. This repository is designed to provide a comprehensive guide to applying different dimensionality reduction techniques on both numerical and categorical data.

## Techniques Covered
- PCA (Principal Component Analysis)
- MDS (Multidimensional Scaling)
- FAMD (Factor Analysis of Mixed Data)
- t-SNE (t-Distributed Stochastic Neighbor Embedding)
- UMAP (Uniform Manifold Approximation and Projection)

## Datasets
This repository utilizes two datasets:
- `iris` dataset: Famous dataset containing measurements in centimeters of the variables sepal length and width and petal length and width, based on 150 iris flowers from three species.
- `mtcars` dataset: Comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models).

## Repository Structure
Each dimensionality reduction technique is contained in its own R script within the repository. The files are organized as follows:
- `pcs_numerical.R`: Script applying PCA on both datasets with generation of 2D and 3D plots, and included comments.
- `MDS.R`: Script applying MDS with visualizations and interpretations.
- `pca_mixed_data.R`: Focuses on handling mixed data types with FAMD, includes visualizations and commentary.
- `t-SNE.R`: Implementation of t-SNE, with detailed plot generation and analysis commentary.
- `UMAP.R`: Applies UMAP on the datasets, with corresponding plots and interpretations.

## Visualizations
The scripts generate interactive 2D and 3D plots using `ggplot2` and `plotly`, allowing for an interactive exploration of the datasets under different dimensionality reduction techniques.

Happy exploring!
