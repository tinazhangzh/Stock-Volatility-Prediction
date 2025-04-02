```{r}
# Load necessary libraries
library(forecast)

# Read realized volatility data
vol_data <- read.csv("data/updated_volatility_data.csv")

# Filter for a specific stock (e.g., GILD)
gild_data <- subset(vol_data, StockID == 'GILD')

# Remove rows with missing values
gild_data <- na.omit(gild_data)

# Convert Date column to Date type
gild_data$Date <- as.Date(gild_data$Date)

# Create a time series object of Realized Volatility
vol_ts <- ts(gild_data$Realized_Volatility, start = c(2016), end = c(2023))

# Split into training and test sets
train_vol <- window(vol_ts, end = c(2022))
test_vol <- window(vol_ts, start = c(2023))
```

```{r}
# Fit ARIMA model to training set
fit_vol <- auto.arima(train_vol)

# Forecast for test period
forecast_vol <- forecast(fit_vol, h = length(test_vol))

# Plot forecast vs actual
plot(forecast_vol, main = "Forecast of Realized Volatility")
lines(test_vol, col = 'red')
legend("bottomleft", legend = c("Forecast", "Actual"), col = c("blue", "red"), lty = 1)
