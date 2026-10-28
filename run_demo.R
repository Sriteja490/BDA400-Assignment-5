# Run from the project root: source('run_demo.R')
for (nm in c('sma','ema','macd','stdev','linreg','rsi','stoch_rsi','crossover','crossunder')) {
  source(file.path('scripts', paste0(nm, '.R')))
}
prices <- c(45, 50, 48, 55, 52, 49, 58, 60, 65, 62, 68, 66, 71, 69, 73, 74, 70, 76, 79, 77, 81, 78, 83, 85, 82, 86, 89, 87, 91, 90)
cat('SMA (3):\n'); print(sma(prices, 3))
cat('EMA (3):\n'); print(ema(prices, 3))
cat('MACD (3, 5, 2), last rows:\n'); print(tail(as.data.frame(macd(prices, 3, 5, 2)), 5))
cat('Population standard deviation:\n'); print(stdev(prices))
cat('Linear regression, last 10 values:\n'); print(linreg(prices, 10, 0))
cat('RSI (5), last rows:\n'); print(tail(rsi(prices, 5)))
cat('Stochastic RSI (5,3,3), last rows:\n'); print(tail(as.data.frame(stoch_rsi(prices, 5, 3, 3))))
cat('Crossover:\n'); print(crossover(c(1, 3, 4, 2), c(2, 2, 3, 3)))
cat('Crossunder:\n'); print(crossunder(c(1, 3, 4, 2), c(2, 2, 3, 3)))
