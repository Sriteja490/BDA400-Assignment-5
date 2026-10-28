stdev <- function(data) {
  if (!is.numeric(data) || any(!is.finite(data)) || length(data) == 0) stop('data must be a nonempty finite numeric vector')
  mean_value <- sum(data) / length(data)
  diff_values <- data - mean_value
  squared_diff <- diff_values^2
  variance <- sum(squared_diff) / length(squared_diff) # population variance, per assignment
  standard_deviation <- sqrt(variance)
  return(standard_deviation)
}
