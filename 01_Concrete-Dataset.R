concrete_dataset <- read.csv("C:/Users/ashi/Downloads/concrete.csv")

sum(duplicated(concrete_dataset))
concrete_data <- concrete_dataset[!duplicated(concrete_dataset),]

# check for missing data
sum(is.na(concrete_data)) # no missing data so no data cleaning is required
# all our variables are numerical also, no categorical variables

View(concrete_data)

# see first few rows of the dataset
head(concrete_data)

#########
# Goal: we study the different factors influencing concrete strength and 
# the relationship between them
# 
# in this description part include a summary of all variables, their units
# of measurement under "key factors influencing concrete strength"
# include how many rows and columns
# also if there are any categorical variables
# missing values
#########

# display summary statistics
summary(concrete_data)

cement <- concrete_data$cement
slag <- concrete_data$slag
ash <- concrete_data$ash
water <- concrete_data$water
superplastic <- concrete_data$superplastic
coarseagg <- concrete_data$coarseagg
fineagg <- concrete_data$fineagg
age <- concrete_data$age
strength <- concrete_data$strength

boxplot(water)
boxplot(age)
boxplot(superplastic)
outlier_info <-boxplot.stats(age)
outliers <- outlier_info$out
print(outliers) # slag, water, superplastic, fineagg, age,strength

# slag outliers - 359.4 359.4
# water outliers - 247.0 246.9 121.8 121.8 121.8 237.0 121.8 236.7 121.8
# superplastic outliers - 28.2 28.2 32.2 32.2 28.2 32.2 32.2 28.2 32.2 28.2
# fineagg outliers - 992.6 992.6 992.6 992.6 992.6
# age - 180 365 180 180 180 365 180 270 180 360 365 365 180 180 270 270 270 270 180
## [20] 180 270 360 180 360 180 365 360 365 365 180 270 180 180 365 180 180 270 270
## [39] 180 180 365 365 180 365 360 180 270 180 270 180 365 360 270 365 180 180 365
## [58] 180 270
# strength outliers - 81.75 79.99 82.60 80.20
# main are: age, superplastic, water (fineagg, strength,slag) 

## handle outliers by capping

# Calculate the 1st and 99th percentiles for 'Age' and 'Superplastic'
age_lower <- quantile(age, 0.1)
age_upper <- quantile(age, 0.9)

superplastic_lower <- quantile(superplastic, 0.1)
superplastic_upper <- quantile(superplastic, 0.9)

water_lower <- quantile(water, 0.1)
water_upper <- quantile(water, 0.9)

# Cap 'Age' values below the 1st percentile and above the 99th percentile
age <- ifelse(age < age_lower, age_lower,
                          ifelse(age > age_upper, age_upper, age))

# Cap 'Superplastic' values below the 1st percentile and above the 99th percentile
superplastic <- ifelse(superplastic < superplastic_lower, superplastic_lower,
                                       ifelse(superplastic > superplastic_upper, superplastic_upper, superplastic))

# Cap 'Water' values below the 1st percentile and above the 99th percentile
water <- ifelse(water < water_lower, water_lower,
                       ifelse(water > water_upper, water_upper, water))

boxplot(water)

# Calculate correlation matrix for numeric columns
correlation_matrix <- cor(concrete_data[, sapply(concrete_data, is.numeric)], use = "complete.obs")
print(correlation_matrix)

# Find variables with high correlation (> 0.7 or < -0.7)
high_corr_pairs <- which(abs(correlation_matrix) > 0.7 & abs(correlation_matrix) < 1, arr.ind = TRUE)

# Display the high correlation pairs
high_corr_pairs ## we have no pairs with correlation > 0.7

# now we can proceed with our visualisation

library(ggplot2)
library(patchwork)

############################################################################
# univariate analysis #

# Create individual histograms
plot1 <- ggplot(concrete_data, aes(x = cement)) +
  geom_histogram(binwidth = 25, fill = "#cdb4db", color = "black") +
  ggtitle("Cement") + xlab("Cement Amount") +
  ylab("Frequency") +
  theme(
    plot.title = element_text(size = 15, face = "bold"),    # Plot title size
    axis.title.x = element_text(size = 12),                 # X-axis label size
    axis.title.y = element_text(size = 12),                 # Y-axis label size
  )

plot2 <- ggplot(concrete_data, aes(x = water)) +
  geom_histogram(binwidth = 10, fill = "#ffc8dd", color = "black") +
  ggtitle("Water") + xlab("Water Amount") +
  ylab("Frequency") +
  theme(
    plot.title = element_text(size = 15, face = "bold"),    # Plot title size
    axis.title.x = element_text(size = 12),                 # X-axis label size
    axis.title.y = element_text(size = 12),                 # Y-axis label size
  )

plot3 <- ggplot(concrete_data, aes(x = slag)) +
  geom_histogram(binwidth = 25, fill = "#bde0fe", color = "black") +
  ggtitle("Slag") + xlab("Slag Amount") +
  ylab("Frequency") +
  theme(
    plot.title = element_text(size = 15, face = "bold"),    # Plot title size
    axis.title.x = element_text(size = 12),                 # X-axis label size
    axis.title.y = element_text(size = 12),                 # Y-axis label size
  )
# esp w slag we can see that there is less slag per kg in mixture

plot1 + plot2 + plot3

plot4 <- ggplot(concrete_data, aes(x = ash)) +
  geom_histogram(binwidth = 20, fill = "#81b29a", color = "black") +
  ggtitle("Ash") + xlab("Ash Amount") +
  ylab("Frequency") +
  theme(
    plot.title = element_text(size = 15, face = "bold"),    # Plot title size
    axis.title.x = element_text(size = 12),                 # X-axis label size
    axis.title.y = element_text(size = 12),                 # Y-axis label size
  )

plot5 <- ggplot(concrete_data, aes(x = superplastic)) +
  geom_histogram(binwidth = 3, fill = "#669bbc", color = "black") +
  ggtitle("Superplastic") + xlab("Superplastic Amount") +
  ylab("Frequency") +
  theme(
    plot.title = element_text(size = 15, face = "bold"),    # Plot title size
    axis.title.x = element_text(size = 12),                 # X-axis label size
    axis.title.y = element_text(size = 12),                 # Y-axis label size
  )

plot6 <- ggplot(concrete_data, aes(x = coarseagg)) +
  geom_histogram(binwidth = 30, fill = "#ffbf69", color = "black") +
  ggtitle("Coarse Agg.") + xlab("Coarse Agg Amount") +
  ylab("Frequency") +
  theme(
    plot.title = element_text(size = 15, face = "bold"),    # Plot title size
    axis.title.x = element_text(size = 12),                 # X-axis label size
    axis.title.y = element_text(size = 12),                 # Y-axis label size
  )

plot4 + plot5 + plot6
# there is less ash in kg per mixture

plot7 <- ggplot(concrete_data, aes(x = fineagg)) +
  geom_histogram(binwidth = 25, fill = "#adc178", color = "black") +
  ggtitle("Fine Agg.") + xlab("Fine Agg Amount") +
  ylab("Frequency") +
  theme(
    plot.title = element_text(size = 15, face = "bold"),    # Plot title size
    axis.title.x = element_text(size = 12),                 # X-axis label size
    axis.title.y = element_text(size = 12),                 # Y-axis label size
  )

avg_strength <- mean(strength)
plot8 <- ggplot(concrete_data, aes(x = factor(age))) +
  geom_histogram(stat="count",binwidth = 20, fill = "#ffc8dd",color = "black") +
  labs(x = "Age (days)") + ggtitle("Age")+
  theme(
    plot.title = element_text(size = 15, face = "bold"),    # Plot title size
    axis.title.x = element_text(size = 12),                 # X-axis label size
    axis.title.y = element_text(size = 12),                 # Y-axis label size
  )

plot7 + plot8
# most of the samples are less than 100 days old and there seem to be a lot of
# samples with age around 28 days.

##############################################################################

# bivariate analysis
# we create a correlation matrix to see which variables seem to have the most
# correlation between them

pairs(concrete_data[, sapply(concrete_data, is.numeric)], main = "Scatterplot Matrix")

cor_matrix <- cor(concrete_data)
cor_strength <- cor_matrix[, "strength"]
cor_strength <- sort(cor_strength, decreasing = TRUE)

# Convert the correlation values and factors into a data frame correctly
correlation_df <- data.frame(`correlation wrt strength` = cor_strength  # Correlation values
)

# Use knitr::kable to present the correlation matrix
kable(correlation_df, caption = "Correlation of strength with different factors")



# we can see it has the highest correlations with cement, superplastic and age

# plotting scatterplots between compressive strength and the three factors
# that seem to have the highest correlation with it

# wrt cement #
ggplot(concrete_data, aes(x = cement, y = strength)) +
  geom_point(color = "darkblue") + geom_smooth(method = "lm", color = "darkred") +
  labs(title = "Scatter Plot: Cement vs Compressive Strength")
# there seems to be a positive correlation between cement content and 
# compressive strength. at low cement values (0-200) compressive strength
# seems to be between 0-60
# when cement is between 400-500, the general trend seems to point upwards,
# and strength ranges from 20-80

# wrt age #
ggplot(concrete_data, aes(x = strength)) +
  geom_histogram(binwidth = 5, fill = "darkblue") +
  facet_wrap(~ age) +
  labs(title = "Distribution of Compressive Strength by Age",
       x = "Compressive Strength (MPa)",
       y = "Count")
# at lesser age, the data shows a lot of variability. by the 28 day mark, 
# the data seems to get most of its strength. after the 28 day
# benchmark the data plateaus and keeps increasing slowly.

# wrt water #
ggplot(concrete_data, aes(x = water, y = strength)) +
  geom_point(color = "darkred") +
  labs(title = "Scatter Plot: Water vs Compressive Strength") + 
  geom_vline(xintercept = 145, linetype = "dashed", color = "darkblue", size = 1)
# wrt water, we see the general trend seems to be going downwards
# this implies that around water = 145 the relationship between
# addition of water and strength seems to be positive, following which
# it seems to decline. so the ideal amount of water seems to be 145

############################################################################

# exploratory data analysis:


# wrt slag #
ggplot(concrete_data, aes(x = slag, y = strength)) +
  geom_point(color = "darkgreen") +
  labs(title = "Scatter Plot: Slag vs Compressive Strength")

# wrt ash #
ggplot(concrete_data, aes(x = ash, y = strength)) +
  geom_point(color = "darkred") +
  labs(title = "Scatter Plot: Ash vs Compressive Strength")

# wrt coarseagg #
ggplot(concrete_data, aes(x = coarseagg, y = strength)) +
  geom_point(color = "darkred") +
  labs(title = "Scatter Plot: Coarse Agg. vs Compressive Strength")

# wrt fineagg #
ggplot(concrete_data, aes(x = fineagg, y = strength)) +
  geom_point(color = "darkred") +
  labs(title = "Scatter Plot: Fine Agg. vs Compressive Strength")

# wrt superplastic #

# dont include this
ggplot(concrete_data, aes(x = superplastic, y = strength)) +
  geom_point(color = "darkred") +
  labs(title = "Scatter Plot: Superplastic vs Compressive Strength")
# we have less data corresponding to higher superplastic use
# at lower levels of superplastic, the data shows high variability
# which may imply that its not as important a factor to affect compressive
# strength



