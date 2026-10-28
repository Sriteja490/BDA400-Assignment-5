# Requires rsi.R. Rolling RSI range reflects the indicator definition (rather than global extrema).
stoch_rsi <- function(data, period, k_period, d_period) {
  if (length(k_period) != 1 || is.na(k_period) || k_period < 1 || k_period != as.integer(k_period)) stop('k_period must be a positive integer')
  if (length(d_period) != 1 || is.na(d_period) || d_period < 1 || d_period != as.integer(d_period)) stop('d_period must be a positive integer')
  rsi_values <- rsi(data, period)
  n <- length(data)
  raw_k <- rep(NA_real_, n)
  # Use a rolling k_period observation window of valid RSI observations.
  for (i in seq_len(n)) {
    if (i >= period + k_period) {
      window <- rsi_values[(i - k_period + 1):i]
      if (all(!is.na(window))) {
        low <- min(window)
        high <- max(window)
        raw_k[i] <- if (high == low) 0 else (rsi_values[i] - low) / (high - low)
      }
    }
  }
  # %K is raw StochRSI; %D is the SMA of the last d_period %K readings.
  k_line <- raw_k
  d_line <- rep(NA_real_, n)
  for (i in seq_len(n)) {
    if (i >= d_period) {
      window <- k_line[(i - d_period + 1):i]
      if (all(!is.na(window))) d_line[i] <- sum(window) / d_period
    }
  }
  result <- list(k_line = k_line, d_line = d_line)
  return(result)
}
