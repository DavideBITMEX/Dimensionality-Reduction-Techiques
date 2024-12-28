# Dimensionality Reduction Techniques

Welcome to the "Dimensionality Reduction Techniques" repository where we explore various dimensionality reduction methods using R-Studio. This repository is designed to provide a comprehensive guide to applying different dimensionality reduction techniques on both numerical and categorical data.

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
- `PCA.R`: Script applying PCA on both datasets with generation of 2D and 3D plots, and included comments.
- `MDS.R`: Script applying MDS with visualizations and interpretations.
- `FAMD.R`: Focuses on handling mixed data types with FAMD, includes visualizations and commentary.
- `tSNE.R`: Implementation of t-SNE, with detailed plot generation and analysis commentary.
- `UMAP.R`: Applies UMAP on the datasets, with corresponding plots and interpretations.

## Getting Started
To run the scripts in this repository, you will need to have R and R-Studio installed on your computer. Follow these steps to get started:
1. Clone this repository to your local machine using `git clone https://github.com/<your-username>/Dimensionality-Reduction-Techniques.git`.
2. Open the project in R-Studio.
3. Install the required R packages using the command `install.packages(c("ggplot2", "plotly", "factoextra", "Rtsne", "umap"))`.
4. Run the scripts you are interested in exploring.

## Visualizations
The scripts generate interactive 2D and 3D plots using `ggplot2` and `plotly`, allowing for an interactive exploration of the datasets under different dimensionality reduction techniques.

## Contributing
Contributions to this project are welcome! You can contribute in several ways:
- By providing suggestions on how to improve the analyses or the visualizations.
- By adding new techniques or datasets to be explored.
- By improving the existing documentation or code for better clarity or performance.

Please read `CONTRIBUTING.md` for details on our code of conduct, and the process for submitting pull requests to us.

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments
- Thanks to the creators of the `iris` and `mtcars` datasets for providing such rich data to explore.
- Shoutout to anyone whose code was used as inspiration or directly included in this project.

## Contact
If you have any questions, please feel free to contact me at [your-email@example.com](mailto:your-email@example.com).

Happy exploring!
