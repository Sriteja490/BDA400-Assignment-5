# Optional integration with your Assignment 1 CSV. Edit path and mapping as needed.
for (nm in c('sma','ema','macd','stdev','linreg','rsi','stoch_rsi','crossover','crossunder')) source(file.path('scripts', paste0(nm, '.R')))
file_path <- 'data/YOUR_STOCK_DATA.csv' # replace with your file name
if (!file.exists(file_path)) stop('Place your CSV at data/YOUR_STOCK_DATA.csv or edit file_path')
df <- read.csv(file_path, stringsAsFactors=FALSE)
required <- c('Date','Open','High','Low','Close','Volume')
if (!all(required %in% names(df))) stop(paste('CSV must have columns:', paste(required, collapse=', ')))
if (!'Symbol' %in% names(df)) df$Symbol <- 'SINGLE_STOCK'
df$Date <- as.Date(df$Date)
df <- df[order(df$Symbol, df$Date), ]
stocks <- split(df, df$Symbol)
results <- lapply(stocks, function(s) {
  prices <- as.numeric(s$Close)
  if (length(prices) < 20) return(NULL)
  s$EMA_12 <- ema(prices, 12)
  s$EMA_26 <- ema(prices, 26)
  m <- macd(prices, 12, 26, 9)
  s$MACD <- m$macd_line
  s$MACD_signal <- m$signal_line
  s$RSI_14 <- rsi(prices, 14)
  s$MACD_event <- crossover(s$MACD, s$MACD_signal)
  s$TradeSignal <- ifelse(s$MACD_event == 'Up' & s$RSI_14 < 70, 'BUY', ifelse(s$MACD_event == 'Down', 'SELL', 'HOLD'))
  s
})
results <- Filter(Negate(is.null), results)
if (length(results) == 0) stop('Need at least 20 rows per symbol')
output <- do.call(rbind, results)
write.csv(output, 'stock_signals_output.csv', row.names=FALSE)
print(tail(output[, c('Date','Symbol','Close','MACD','MACD_signal','RSI_14','TradeSignal')], 10))
cat('Saved stock_signals_output.csv\n')
