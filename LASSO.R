```{r}
# Load required libraries
library(glmnet)
library(caret)
library(ggplot2)

# Load dataset (replace with relative path for GitHub)
data <- read.csv("data/lasso_data.csv")

# Drop unnecessary columns
clean_data <- data[, !(names(data) %in% c('Unnamed: 0', 'Date', 'StockID'))]

# Define feature matrix X and target variable y
X <- as.matrix(clean_data[, !(names(clean_data) == 'Realized.Volatility')])
y <- clean_data$Realized.Volatility

# Split data into training and test sets
set.seed(565)
trainIndex <- createDataPartition(y, p = 0.8, list = FALSE)
X_train <- X[trainIndex, ]
y_train <- y[trainIndex]
X_test <- X[-trainIndex, ]
y_test <- y[-trainIndex]

# Fit LASSO model with cross-validation
set.seed(565)
cvfit <- cv.glmnet(X_train, y_train, alpha = 1)

# Predict on test set using best lambda
predictions <- predict(cvfit, newx = X_test, s = "lambda.min")

# Evaluate performance
mse <- mean((predictions - y_test)^2)
r_squared <- 1 - sum((predictions - y_test)^2) / sum((y_test - mean(y_test))^2)

mse
r_squared
```

```{r}
# Plot predicted vs actual
results <- data.frame(Actual = y_test, Predicted = as.numeric(predictions))

ggplot(results, aes(x = Actual, y = Predicted)) +
  geom_point(alpha = 0.6) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "red") +
  labs(title = "LASSO Regression: Predicted vs Actual",
       x = "Actual Volatility",
       y = "Predicted Volatility")
