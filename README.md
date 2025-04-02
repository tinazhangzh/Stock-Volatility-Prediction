# 📈 Financial Time Series Modeling

This project applies a range of statistical and machine learning models to analyze and forecast financial time series data such as log returns and realized volatility. Both R and Python are used in the workflow.

## 🗂 Project Structure

| File | Description |
|------|-------------|
| `Preprocessing.R` | Cleans and visualizes log return data for selected stocks. |
| `ARIMA.R` | Fits ARIMA models on log return series and generates out-of-sample forecasts. |
| `Stationarity Check.R` | Performs ADF test and ACF/PACF plotting to validate model assumptions. |
| `Volatility Forecasting.R` | Models realized volatility using ARIMA and compares predictions with test data. |
| `LASSO.R` | Implements LASSO regression to predict volatility with regularization. |
| `time_series_lstm.py` | Builds and trains an LSTM neural network to model volatility trends. |
| `README.md` | Project documentation. |

## 📊 Methods Used

- Linear regression
- ARIMA and time series diagnostics (ACF, PACF, ADF)
- LASSO regression (with `glmnet`)
- LSTM (Long Short-Term Memory) neural network (with TensorFlow)

## 🧪 How to Run

### R Scripts

Make sure the following R packages are installed:

```r
install.packages(c("forecast", "tseries", "zoo", "xts", "glmnet", "caret", "ggplot2", "readr", "dplyr"))
```

You can knit each `.R` script in RStudio or run line-by-line interactively.

### Python Script

Ensure you have the required packages:

```bash
pip install numpy pandas matplotlib scikit-learn tensorflow
```

Then run:

```bash
python time_series_lstm.py
```

## 📁 Data

All scripts assume cleaned datasets are stored under a `data/` folder. Example filenames:
- `updated_data.csv`
- `aal_forecast_data.csv`
- `updated_volatility_data.csv`
- `lasso_data.csv`
- `222_scaled.csv`

(Replace or modify paths as needed in your local setup.)
---

This repository combines interpretable models with modern deep learning for a comprehensive analysis of financial time series.
