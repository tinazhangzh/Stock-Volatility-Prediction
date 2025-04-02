```{r}
# Load necessary libraries
library(zoo)
library(forecast)
library(tseries)
library(xts)

# Read stock return data
log_ret_data <- read.csv("data/aal_forecast_data.csv")

# Convert Date column to Date type
log_ret_data$Date <- as.Date(log_ret_data$Date, format="%m/%d/%y")

# Create a time series object with daily frequency (252 trading days per year)
log_ret_ts <- ts(log_ret_data$Log_Ret, frequency = 252, start = c(2016, 1))

# Conduct Augmented Dickey-Fuller test for stationarity
adf_result <- adf.test(log_ret_ts)
adf_result
```

```{r}
# Plot ACF and PACF to inspect autocorrelation structure
Acf(log_ret_ts)
Pacf(log_ret_ts)

# Fit ARIMA model automatically
fit_auto <- auto.arima(log_ret_ts)
summary(fit_auto)

# Forecast future values
forecast_values <- forecast(fit_auto, h = 30)

# Plot forecast
plot(forecast_values, main = "30-Day Forecast using ARIMA")
