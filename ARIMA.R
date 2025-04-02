```{r}
# Load necessary libraries
library(forecast)
library(readr)
library(dplyr)
library(lubridate)
library(tidyr)

# Read preprocessed stock return data
forecast_data <- read_csv("data/aal_forecast_data.csv")

# Convert Date column to Date type and sort
forecast_data <- forecast_data %>%
  mutate(Date = as.Date(Date)) %>%
  arrange(Date) %>%
  drop_na()

# Create a time series object for log returns
log_ret_ts <- ts(forecast_data$Log_Ret,
                 start = c(year(min(forecast_data$Date)), yday(min(forecast_data$Date))),
                 frequency = 252)  # assuming daily trading data

# Identify the last trading day in 2022
last_index_2022 <- max(yday(forecast_data$Date[year(forecast_data$Date) == 2022]))

# Create training set ending in 2022
train_set <- window(log_ret_ts, end = c(2022, last_index_2022))

# Create test set starting in 2023
test_set <- window(log_ret_ts, start = c(2023, 1))
```

```{r}
# Fit ARIMA model to training set
fit_arima <- auto.arima(train_set)

# Forecast for the length of the test set
forecast_result <- forecast(fit_arima, h = length(test_set))

# Plot forecast with actual values
plot(forecast_result, main = "ARIMA Forecast vs Actual")
lines(test_set, col = "red")
legend("bottomleft", legend = c("Forecast", "Actual"), col = c("blue", "red"), lty = 1)
```

```{r}
# Compute RMSE for forecast accuracy
rmse <- sqrt(mean((forecast_result$mean - test_set)^2))
rmse
