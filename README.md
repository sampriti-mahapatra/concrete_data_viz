# Analysing Concrete Compressive Strength

## Overview
This repository contains a comprehensive analysis and visualization of a concrete dataset obtained from Kaggle. The objective of this project is to explore the relationship between various concrete components and its compressive strength through data visualization techniques using R.

## Dataset Description

The dataset contains various features of concrete mixtures along with their compressive strength. It includes the following columns:

- **Cement**: Amount of cement in kg/m³
- **Blast Furnace Slag**: Amount of slag in kg/m³
- **Fly Ash**: Amount of fly ash in kg/m³
- **Water**: Amount of water in kg/m³
- **Superplasticizer**: Amount of superplasticizer in kg/m³
- **Coarse Aggregate**: Amount of coarse aggregate in kg/m³
- **Fine Aggregate**: Amount of fine aggregate in kg/m³
- **Age**: Age of the concrete in days
- **Compressive Strength**: Compressive strength of the concrete in MPa

## Methods 
1. **Pre-Processing**: Checked and removed duplicate entries, handled outliers by capping at a relevant maximum/minimum value and made sure no data was missing.
2. **Correlation Analysis**: Used correlation analysis to find which factors affect strength the most.
3. **Visualisation**: Proceeded to use data visualisation libraries (ggplot2) to confirm our hypothesis, and draw other relevant conclusions.

## Visualisation
This project includes the following visualizations:

### Univariate Analysis:
Histograms of cement, water, slag, ash, superplasticizer, coarse aggregate, fine aggregate, and age.
Boxplots for identifying outliers in relevant variables.

### Bivariate Analysis:
Scatter plots illustrating the relationships between compressive strength and key variables (cement, age, water).

## Key Findings
1. Cement: There is a positive correlation between cement content and compressive strength. As the cement content increases, the compressive strength tends to increase as well.

2. Age: The strength of concrete significantly increases around the 28-day mark, indicating that concrete reaches most of its strength within the first month and continues to strengthen slowly thereafter.

3. Water: An optimal water content around 145 kg/m³ is identified. Below this amount, the compressive strength increases, while above it, the strength begins to decline, suggesting excessive water negatively affects concrete strength.

4. Slag and Ash: Scatter plots indicate varying impacts on compressive strength, but further exploration is needed to quantify their contributions.

## Conclusions
The analysis provides insights into the factors influencing the compressive strength of concrete. Key findings highlight the importance of cement content, age, and optimal water content in achieving desired strength levels. Future work may include deeper statistical analysis and the application of predictive modeling techniques to enhance understanding.

## References
[Concrete Dataset on Kaggle]([URL](https://www.kaggle.com/datasets/vinayakshanawad/cement-manufacturing-concrete-dataset))








