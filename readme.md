# ADMIXTURE CV Error Plotter

This project automates the process of running [ADMIXTURE](http://dalexander.github.io/admixture/) for a range of **K** values, extracting cross-validation (CV) errors, and plotting them to help determine the optimal number of ancestral populations.

---

## 📦 Features

- Runs ADMIXTURE for a specified range of K values (e.g. K=2 to K=10)
- Captures and stores verbose output
- Extracts CV errors automatically
- Generates a plot of CV Error vs. K using Python + matplotlib
- Saves the plot as `cv_error_plot.png`

---
