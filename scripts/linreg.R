linreg <- function(regressionSource, regressionLength, regressionOffset) {
  if (!is.numeric(regressionSource) || any(!is.finite(regressionSource))) stop('regressionSource must be finite numeric data')
  n <- length(regressionSource)
  if (length(regressionLength) != 1 || is.na(regressionLength) || regressionLength < 2 || regressionLength != as.integer(regressionLength)) stop('regressionLength must be an integer >= 2')
  if (length(regressionOffset) != 1 || is.na(regressionOffset) || regressionOffset < 0 || regressionOffset != as.integer(regressionOffset)) stop('regressionOffset must be a nonnegative integer')
  if (regressionLength > n) stop('regressionLength cannot be greater than the number of elements in regressionSource')
  if (regressionOffset >= regressionLength) stop('regressionOffset must be less than regressionLength')
  # Offset denotes observations back from the latest point. Retain the full requested window.
  start_index <- n - regressionOffset - regressionLength + 1
  end_index <- n - regressionOffset
  if (start_index < 1) stop('not enough observations for the selected length and offset')
  source_subset <- regressionSource[start_index:end_index]
  index_values <- seq_along(source_subset)
  mean_index <- sum(index_values) / length(index_values)
  mean_source <- sum(source_subset) / length(source_subset)
  numerator <- sum((index_values - mean_index) * (source_subset - mean_source))
  denominator <- sum((index_values - mean_index)^2)
  slope <- numerator / denominator
  intercept <- mean_source - slope * mean_index
  predicted_values <- slope * index_values + intercept
  result <- list(slope = slope, intercept = intercept, predicted_values = predicted_values)
  return(result)
}
