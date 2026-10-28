# The template pseudocode uses a first-element None and subsequent True/False strings.
crossunder <- function(arr1, arr2) {
  if (length(arr1) != length(arr2)) stop('Both arrays should have the same length')
  if (!is.numeric(arr1) || !is.numeric(arr2)) stop('Both arrays must be numeric')
  n <- length(arr1)
  crossunder_signals <- rep('False', n)
  if (n > 0) crossunder_signals[1] <- 'None'
  if (n >= 2) {
    for (i in 2:n) {
      if (any(is.na(c(arr1[i], arr2[i], arr1[i-1], arr2[i-1])))) {
        crossunder_signals[i] <- 'False'
      } else if (arr1[i] < arr2[i] && arr1[i-1] >= arr2[i-1]) {
        crossunder_signals[i] <- 'True'
      }
    }
  }
  return(crossunder_signals)
}
