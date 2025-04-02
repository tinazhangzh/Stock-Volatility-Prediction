# Install necessary library
!pip install tensorflow

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, Dense, Dropout
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_squared_error
from tensorflow.keras.callbacks import EarlyStopping
import datetime

# Load and preprocess data
df = pd.read_csv('data/222_scaled.csv')  # Path cleaned for GitHub usage

# Convert Date to datetime format and set as index
df['Date'] = pd.to_datetime(df['Date'], format='%m/%d/%y')
df.set_index('Date', inplace=True)

# Split into training and test sets
train = df['2017-01-01':'2022-12-31']
test = df['2023-01-01':]
print('train data size: ', len(train))
print('test data size: ', len(test))

# Define features and target
features = ['Open', 'High', 'Low', 'Close', 'Adj Close', 'Volume', 'Log_Ret']
target = 'Realized Volatility'

# Normalize feature and target data
scaler = MinMaxScaler(feature_range=(0, 1))
train_scaled = scaler.fit_transform(train[features])
test_scaled = scaler.transform(test[features])

target_scaler = MinMaxScaler(feature_range=(0, 1))
train_target_scaled = target_scaler.fit_transform(train[[target]])
test_target_scaled = target_scaler.transform(test[[target]])

# Create sequences for LSTM input
def create_dataset(X, y, time_steps=1):
    Xs, ys = [], []
    for i in range(len(X) - time_steps):
        v = X[i:(i + time_steps)]
        Xs.append(v)
        ys.append(y[i + time_steps])
    return np.array(Xs), np.array(ys)

time_steps = 1
