sma <- function(data, period) {
  if (!is.numeric(data) || any(!is.finite(data))) stop('data must contain finite numbers')
  if (length(period) != 1 || is.na(period) || period < 1 || period != as.integer(period)) stop('period must be a positive integer')
  if (length(data) < period) stop('Data length should be greater than or equal to the period')
  sma_values <- numeric(length(data) - period + 1)
  for (i in seq_along(sma_values)) {
    current_window <- data[i:(i + period - 1)]
    sma_values[i] <- sum(current_window) / period
  }
  return(sma_values)
}
