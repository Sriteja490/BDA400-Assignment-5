BDA400 Assignment 5 — Technical Analysis using R

REQUIREMENTS: Base R only; no package installation required.

1. Open RStudio and set its working directory to the unzipped BDA400_A5 folder.
2. Run source('tests.R') and take a screenshot showing 'All checks passed.'
3. Run source('run_demo.R') and take a screenshot showing the indicator results.
4. If you have the Assignment 1 stock-price CSV: copy it to the data folder, rename it YOUR_STOCK_DATA.csv (or update file_path), verify the columns Date, Open, High, Low, Close, Volume (optional Symbol), then run source('stock_analysis_template.R').
5. Review the generated stock_signals_output.csv and capture a screenshot if using your own actual data.
6. Put the nine individual scripts, documentation and supporting files into YOUR own repository; replace the placeholder name, repository URL and screenshot slots in the Word report. Submit the cover page and deliverables through LMS.

FILES:
scripts/sma.R, ema.R, macd.R, stdev.R, linreg.R, rsi.R, stoch_rsi.R, crossover.R, crossunder.R
run_demo.R: demonstrated calculations on a synthetic price vector (NOT real market data)
tests.R: assertions of independently computable mathematical examples
stock_analysis_template.R: optional real CSV data-frame / filter / trading rule integration

IMPLEMENTATION CHOICES TO REVIEW WITH INSTRUCTOR:
- stdev uses population deviation (divide by n), matching assignment formula.
- rsi uses initial n differences and Wilder recursive smoothing; returns NA warm-up values, and neutral 50 for flat prices.
- stoch_rsi uses a rolling range of RSI values over k_period; %K is normalized 0–1, %D is SMA of %K. The handout's alternative pseudocode instead normalizes to global min/max and then smooths %K. Clarify if exact test file expects the pseudocode variant.
- crossover returns Up/Down/None; crossunder returns 'None','True','False' STRINGS as in pseudocode; the handout prose also mentions Boolean results.
- linreg uses a complete regressionLength window ending regressionOffset observations before the most recent. The handout's start_index formula appears inconsistent with a complete window; ask instructor if test fixture assumes different indexing.

Execution status: These scripts were prepared but R/Rscript was unavailable in the creation environment. Run tests.R in your installation of RStudio before submission.
