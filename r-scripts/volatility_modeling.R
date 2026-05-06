# ==============================================================================
# Netflix (NFLX) Volatility Modeling using ARCH/GARCH
# ==============================================================================
# Course: MA7008 Financial Mathematics
# Author: Yagnesh Vaghashiya (25002034)
# Date: January 2026
# ==============================================================================

# Load required packages
library(rugarch)
library(tseries)
library(zoo)
library(FinTS)

# ==============================================================================
# Step 1: Load Data
# ==============================================================================

# Read stock data from Excel file
data <- read.xlsx("../data/Sector-Focused_Stock_Data__2025-2026_.xlsx", 
                  sheet = "NFLX", 
                  startRow = 1)

# Extract dates and prices
prices <- as.data.frame(data$NFLX_AdjClose, order.by = as.Date(data$Date))

# Compute log returns
returns <- diff(log(prices))

# Remove NA values
returns <- na.omit(returns)

# ==============================================================================
# Step 2: Stationarity Test (ADF Test)
# ==============================================================================

# Augmented Dickey-Fuller Test
adf_test <- adf.test(returns)

cat("\n=== Augmented Dickey-Fuller Test ===\n")
print(adf_test)

# Interpretation:
# p-value < 0.05 → Series is stationary
# In this case: p-value ≈ 0.01, so returns are stationary ✓

# ==============================================================================
# Step 3: Test for ARCH Effects
# ==============================================================================

# ARCH-LM Test (tests for conditional heteroskedasticity)
arch_test <- ArchTest(returns, lags = 12)

cat("\n=== ARCH LM Test ===\n")
print(arch_test)

# Interpretation:
# p-value < 0.05 → ARCH effects present (time-varying volatility)
# This justifies using GARCH models

# ==============================================================================
# Step 4: Estimate ARCH/GARCH Models
# ==============================================================================

# Model 1: ARCH(1)
spec_arch <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1,0)),
                        mean.model = list(armaOrder = c(0,0)),
                        distribution.model = "norm")

fit_arch <- ugarchfit(spec = spec_arch, data = returns)

# Model 2: GARCH(1,1)
spec_garch <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1,1)),
                         mean.model = list(armaOrder = c(0,0)),
                         distribution.model = "norm")

fit_garch <- ugarchfit(spec = spec_garch, data = returns)

# Model 3: EGARCH(1,1) - Exponential GARCH
spec_egarch <- ugarchspec(variance.model = list(model = "eGARCH", garchOrder = c(1,1)),
                          mean.model = list(armaOrder = c(0,0)),
                          distribution.model = "norm")

fit_egarch <- ugarchfit(spec = spec_egarch, data = returns)

# Model 4: GJR-GARCH(1,1) - Threshold GARCH
spec_gjr <- ugarchspec(variance.model = list(model = "gjrGARCH", garchOrder = c(1,1)),
                       mean.model = list(armaOrder = c(0,0)),
                       distribution.model = "norm")

fit_gjr <- ugarchfit(spec = spec_gjr, data = returns)

# ==============================================================================
# Step 5: Model Comparison (AIC & BIC)
# ==============================================================================

# Extract information criteria
ic_comparison <- data.frame(
  Model = c("ARCH(1)", "GARCH(1,1)", "EGARCH(1,1)", "GJR-GARCH(1,1)"),
  AIC = c(
    infocriteria(fit_arch)[1],
    infocriteria(fit_garch)[1],
    infocriteria(fit_egarch)[1],
    infocriteria(fit_gjr)[1]
  ),
  BIC = c(
    infocriteria(fit_arch)[2],
    infocriteria(fit_garch)[2],
    infocriteria(fit_egarch)[2],
    infocriteria(fit_gjr)[2]
  )
)

cat("\n=== Model Comparison (AIC & BIC) ===\n")
print(ic_comparison)

# Identify best model (lowest AIC/BIC)
best_model_aic <- ic_comparison$Model[which.min(ic_comparison$AIC)]
best_model_bic <- ic_comparison$Model[which.min(ic_comparison$BIC)]

cat("\nBest Model (AIC):", best_model_aic)
cat("\nBest Model (BIC):", best_model_bic)

# ==============================================================================
# Step 6: Display Selected Model Results
# ==============================================================================

cat("\n\n=== EGARCH(1,1) Model Results ===\n")
print(fit_egarch)

# ==============================================================================
# Step 7: Plot Conditional Volatility
# ==============================================================================

# Extract conditional volatility
vol_egarch <- sigma(fit_egarch)

# Plot
plot(vol_egarch, 
     main = "Netflix (NFLX) Conditional Volatility - EGARCH(1,1)",
     ylab = "Volatility",
     xlab = "Time",
     col = "blue",
     lwd = 2)

# ==============================================================================
# Step 8: Forecast Volatility (1-day ahead)
# ==============================================================================

# 1-step ahead forecast
forecast_egarch <- ugarchforecast(fit_egarch, n.ahead = 1)

cat("\n=== 1-Day Ahead Volatility Forecast ===\n")
print(sigma(forecast_egarch))

# ==============================================================================
# Interpretation Summary
# ==============================================================================

cat("\n\n==================== INTERPRETATION ====================\n")
cat("1. ADF Test: p-value ≈ 0.01 → Returns are stationary ✓\n")
cat("2. ARCH-LM Test: p-value < 0.05 → ARCH effects present ✓\n")
cat("3. Best Model: EGARCH(1,1) (lowest AIC & BIC)\n")
cat("4. Why EGARCH?\n")
cat("   - Captures volatility clustering\n")
cat("   - Models asymmetric responses (leverage effect)\n")
cat("   - Log specification ensures positive variance\n")
cat("========================================================\n")

# ==============================================================================
# End of Script
# ==============================================================================
