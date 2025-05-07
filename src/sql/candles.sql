-- This SQL script creates a table for storing candlestick data
-- for a cryptocurrency trading application using TimescaleDB.
-- The table is designed to handle time-series data efficiently.

CREATE TABLE candles (
    id SERIAL,                             -- Unique identifier for each candle (not primary because of time-series nature)
    symbol TEXT NOT NULL,                  -- Trading pair symbol (e.g., BTCUSDT)
    interval TEXT NOT NULL,                -- Time interval for the candle (e.g., 1m, 5m, 1h)
    open_time TIMESTAMPTZ NOT NULL,        -- Start time of the candle
    close_time TIMESTAMPTZ NOT NULL,       -- End time of the candle  
    open DOUBLE PRECISION NOT NULL,        -- Opening price of the candle
    close DOUBLE PRECISION NOT NULL,       -- Closing price of the candle
    high DOUBLE PRECISION NOT NULL,        -- Highest price during the candle
    low DOUBLE PRECISION NOT NULL,         -- Lowest price during the candle
    volume DOUBLE PRECISION NOT NULL,      -- Trading volume during the candle
    usdt_volume DOUBLE PRECISION NOT NULL, -- Volume in USDT
    UNIQUE(symbol, interval, open_time)    -- Ensure unique entries for each symbol, interval, and open time
);

-- Create a hypertable for time-series data
SELECT create_hypertable('candles', 'open_time');

-- Create indexes to optimize queries
CREATE INDEX ON candles (symbol, interval, open_time DESC);