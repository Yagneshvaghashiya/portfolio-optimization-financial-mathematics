# Portfolio Optimization & Risk Analysis using Financial Mathematics

## 🎯 Project Overview

Quantitative finance project applying Modern Portfolio Theory (MPT) to optimize a diversified stock portfolio across five sectors. This analysis employs advanced financial mathematics including mean-variance optimization, Capital Asset Pricing Model (CAPM), Value at Risk (VaR), and GARCH volatility modeling to construct efficient portfolios and assess risk-adjusted returns.

**Student:** Yagnesh Vaghashiya  
**Course:** MA7008 Financial Mathematics  
**Institution:** London Metropolitan University  
**Supervisor:** Dr. Jonathan Iworiso  

---

## 📊 Portfolio Composition

### Selected Stocks (5 Sectors)

| Ticker | Company | Sector | Annual Return | Annual Volatility | Beta |
|--------|---------|--------|---------------|-------------------|------|
| NFLX | Netflix Inc. | Communication Services | 12.09% | 33.89% | 0.839 |
| V | Visa Inc. | Financial Services | 16.51% | 22.70% | 0.786 |
| XOM | Exxon Mobil | Energy | 19.84% | 24.09% | 0.533 |
| PFE | Pfizer Inc. | Healthcare | 5.35% | 26.13% | 0.482 |
| PG | Procter & Gamble | Consumer Staples | -7.01% | 18.87% | 0.145 |

**Data Period:** January 2025 - January 2026 (~250 trading days)  
**Data Source:** Yahoo Finance (daily adjusted closing prices)

---

## 🔬 Methodology & Analytical Framework

### Task 1: Returns, Volatility & Correlation Analysis

**Metrics Calculated:**
- **Daily Returns:** Simple returns computed from adjusted closing prices
- **Annualized Returns:** Daily returns × 252 trading days
- **Annualized Volatility:** Daily standard deviation × √252
- **Correlation Matrix:** Pairwise correlations between asset returns

**Key Findings:**
- **Highest Return:** Exxon Mobil (19.84%) with high volatility (24.09%)
- **Lowest Volatility:** Procter & Gamble (18.87%) - defensive stock
- **Diversification Benefit:** Low to moderate correlations (0.08 to 0.38)
- **Sector Rotation:** Energy outperformed, Consumer Staples underperformed in sample period

---

### Task 2: Mean-Variance Optimization & Efficient Frontier

**Optimization Problem:**
```
Minimize: Portfolio Variance = w'Σw
Subject to:
  1. E(Rp) = Target Return
  2. Σwi = 1 (weights sum to 100%)
  3. wi ≥ 0 (no short selling)
```

**Tool:** Excel Solver with quadratic programming

**Target Returns Tested:** 8%, 10%, 12%, 15%, 18%

**Efficient Portfolios:**

| Portfolio | Target Return | Portfolio Risk | Optimal Weights |
|-----------|---------------|----------------|-----------------|
| 1 | 8% | 15.07% | Diversified across all 5 stocks |
| 2 | 10% | 15.57% | Balanced allocation |
| 3 | 12% | 16.50% | Shift toward higher-return assets |
| 4 | 15% | 18.02% | XOM (31.3%), V (26.5%), NFLX (32.1%) |
| 5 | 18% | 18.42% | XOM (53.8%), V (39.3%), NFLX (6.9%) |

**Efficient Frontier:**
- Upward-sloping convex curve
- Demonstrates risk-return tradeoff
- Higher returns require higher volatility acceptance

---

### Task 3: Sharpe Ratio & Capital Market Line (CML)

**Risk-Free Rate (Rf):** 1.5% (assumed)

**Sharpe Ratio Formula:**
```
Sharpe Ratio = (Rp - Rf) / σp
```

**Sharpe Ratios Calculated:**

| Portfolio | Return | Risk | Sharpe Ratio |
|-----------|--------|------|--------------|
| 1 | 8% | 15.07% | 0.431 |
| 2 | 10% | 15.57% | 0.546 |
| 3 | 12% | 16.50% | 0.637 |
| 4 | 15% | 18.02% | 0.749 |
| **5** | **18%** | **18.42%** | **0.896** ⭐ |

**Tangency Portfolio:** Portfolio 5 (Highest Sharpe Ratio = 0.896)

**Capital Market Line Equation:**
```
E(Rp) = 0.015 + 0.8957 × σp
```

**Economic Significance:**
- CML represents optimal risk-return combinations
- Slope (0.8957) = market price of risk
- Tangency portfolio offers best risk-adjusted performance
- Investors can leverage or delever the tangency portfolio

---

### Task 4: Market Risk (Beta) & Value at Risk (VaR)

#### Part A: Beta Estimation (CAPM)

**Regression Model:**
```
Ri = α + β × Rmarket + ε
```

**Market Benchmark:** S&P 500 Index

**Beta Results:**

| Stock | Beta | Interpretation | Statistical Significance |
|-------|------|----------------|--------------------------|
| NFLX | 0.839 | High market sensitivity | p < 0.001 |
| V | 0.786 | High market sensitivity | p < 0.001 |
| XOM | 0.533 | Moderate market exposure | p < 0.001 |
| PFE | 0.482 | Moderate market exposure | p < 0.001 |
| PG | 0.145 | Defensive (low beta) | p < 0.05 |

**Implications:**
- **β > 1:** Amplifies market movements (none in this portfolio)
- **β = 0.5-0.8:** Moderate systematic risk (NFLX, V, XOM, PFE)
- **β < 0.5:** Defensive, low market correlation (PG)

#### Part B: Value at Risk (5% VaR)

**Method:** Variance-Covariance (Parametric VaR)

**Portfolio:** Target Return 15%
- **Daily Portfolio Volatility:** 1.135%
- **1-Day VaR (5%):** $18,671.79
- **Interpretation:** 95% confidence that daily loss won't exceed $18,672

**VaR Formula:**
```
VaR = Portfolio Value × z × σp × √t
where z = 1.645 (5% quantile)
```

#### Part C: VaR Decomposition (Component Risk)

**Asset Contributions to Portfolio VaR:**

| Asset | VaR Contribution | % of Total VaR |
|-------|------------------|----------------|
| NFLX | $8,495.48 | 45.50% |
| V | $4,515.96 | 24.19% |
| XOM | $4,660.28 | 24.96% |
| PFE | $1,000.07 | 5.36% |
| PG | $0 | 0% |

**Insights:**
- Most downside risk driven by higher-volatility assets (NFLX, XOM, V)
- Defensive stock (PG) has zero allocation in 15% target portfolio
- Risk concentration in growth-oriented stocks

---

### Task 5: Volatility Modeling (ARCH/GARCH)

**Focus:** Netflix (NFLX) returns

**Stationarity Test:**
- **ADF Test:** p-value = 0.01 ✓ (stationary)

**ARCH Effects Test:**
- **ARCH-LM Test:** p-value < 0.05 ✓ (time-varying volatility present)

**Models Estimated:**

| Model | AIC | BIC | Selection |
|-------|-----|-----|-----------|
| ARCH(1) | 43.824 | 43.895 | |
| GARCH(1,1) | -4.816 | -4.732 | |
| **EGARCH(1,1)** | **-4.853** | **-4.755** | ✓ **BEST** |
| GJR-GARCH(1,1) | -4.811 | -4.712 | |

**Selected Model:** EGARCH(1,1)

**Why EGARCH?**
1. **Lowest AIC/BIC** - Best fit
2. **Asymmetric Response** - Negative shocks increase volatility more than positive shocks (leverage effect)
3. **Log Specification** - Guarantees positive variance
4. **Volatility Clustering** - Models periods of high/low volatility persistence

**R Implementation:** See `r-scripts/volatility_modeling.R`

---

## 📈 Key Findings & Results

### Optimal Portfolio Recommendation

**Tangency Portfolio (Highest Sharpe Ratio = 0.896):**
- **Expected Return:** 18% annualized
- **Risk (Volatility):** 18.42% annualized
- **Allocation:**
  - Exxon Mobil (XOM): 53.8%
  - Visa (V): 39.3%
  - Netflix (NFLX): 6.9%
  - Pfizer (PFE): 0%
  - Procter & Gamble (PG): 0%

**Risk-Adjusted Performance:**
- Delivers 0.896 units of excess return per unit of risk
- Lies on the Capital Market Line
- Optimal for risk-neutral investors

---

### Diversification Benefits

**Correlation Analysis:**
- **Low Correlation:** NFLX-PFE (-0.012), NFLX-XOM (0.077)
- **Moderate Correlation:** V-PG (0.376), V-PFE (0.362)
- **Result:** Combining assets reduces portfolio variance below weighted average

**Portfolio Variance Reduction:**
- Individual stock volatility range: 18.87% - 33.89%
- Portfolio volatility (efficient frontier): 15.07% - 18.42%
- **Diversification benefit:** ~40-50% risk reduction at lower return targets

---

### Market Risk Insights

**Beta Analysis:**
- **Defensive Allocation:** PG (β=0.145) provides downside protection
- **Growth Exposure:** NFLX (β=0.839), V (β=0.786) capture market upside
- **Balanced Approach:** XOM, PFE offer moderate systematic risk

**Portfolio Beta (Weighted):**
```
βp = Σ(wi × βi)
```
For 15% target portfolio: βp ≈ 0.62 (moderate market sensitivity)

---

### Downside Risk Management

**5% VaR Analysis:**
- **1-Day VaR:** $18,672 (95% confidence)
- **10-Day VaR (scaled):** ~$59,000 (assuming i.i.d. returns)
- **Component VaR:** 70% of risk from NFLX + XOM

**Risk Mitigation Strategies:**
1. Include defensive stocks (PG, PFE) to reduce tail risk
2. Dynamic rebalancing based on volatility forecasts
3. Consider hedging strategies for high-beta positions

---

### Volatility Forecasting

**EGARCH(1,1) Findings:**
- **Volatility Clustering:** High volatility begets high volatility
- **Asymmetry:** Bad news (negative returns) increases volatility ~30% more than good news
- **Conditional Variance:** Predictable time-varying risk patterns

**Applications:**
- Option pricing (volatility input)
- Dynamic portfolio allocation
- Risk budgeting

---

## 🛠️ Technologies & Tools

### Software & Languages
- **Microsoft Excel** - Portfolio optimization (Solver add-in)
- **R** - Volatility modeling (ARCH/GARCH)
- **Python** - Data preprocessing (optional)

### R Packages
```r
library(rugarch)     # GARCH modeling
library(tseries)     # Time series analysis (ADF test)
library(zoo)         # Time series data
library(FinTS)       # ARCH-LM test
```

### Excel Add-ins
- **Solver** - Quadratic programming for mean-variance optimization
- **Data Analysis ToolPak** - Regression analysis for beta estimation

### Statistical Methods
- **Mean-Variance Optimization** (Markowitz 1952)
- **Capital Asset Pricing Model (CAPM)** (Sharpe 1964)
- **Value at Risk (VaR)** - Parametric method
- **GARCH Family Models** (Bollerslev 1986, Nelson 1991)

---

## 📁 Repository Structure

```
portfolio-optimization-financial-mathematics/
├── excel-workbooks/                                      # Excel workbooks with formulas
│   ├── portfolio_optimization.xlsx                   # Mean-variance optimization (Solver-ready)
│   └── var_calculation.xlsx                          # Value at Risk calculations
│
├── visualizations/                                   # High-quality charts (300 DPI)
│   ├── efficient_frontier.png                        # Efficient frontier curve
│   ├── capital_market_line.png                       # CML with tangency portfolio
│   ├── correlation_heatmap.png                       # 5×5 correlation matrix
│   ├── risk_return_scatter.png                       # Stocks vs. efficient frontier
│   └── beta_comparison.png                           # Beta bar chart
│
├── Sector-Focused_Stock_Data__2025-2026_.xlsx       # Historical stock prices (Yahoo Finance)
├── 25002034_Case_Study_Report_2025.pdf              # Complete academic report
├── volatility_modeling.R                             # GARCH volatility modeling (R script)
├── README.md                                         # This file
├── requirements.txt                                  # R package dependencies
├── LICENSE                                           # MIT License
└── .gitignore                                        # Git ignore rules
```

---

## 🚀 How to Reproduce Analysis

### Prerequisites
```r
# R version 4.0+
install.packages(c("rugarch", "tseries", "zoo", "FinTS"))
```

### Step 1: Data Preparation
1. Download stock data from Yahoo Finance (NFLX, V, XOM, PFE, PG)
2. Compute daily returns: `R_t = (P_t - P_{t-1}) / P_{t-1}`
3. Annualize returns: `R_annual = R_daily × 252`
4. Calculate covariance matrix

### Step 2: Portfolio Optimization (Excel)
1. Open `portfolio_optimization.xlsx`
2. Set target return (8%, 10%, 12%, 15%, 18%)
3. Run Solver:
   - Objective: Minimize portfolio variance
   - Variables: Asset weights
   - Constraints: Σw=1, w≥0, E(Rp)=target
4. Record optimal weights and portfolio risk

### Step 3: Sharpe Ratio & CML
1. Calculate: `Sharpe = (Rp - 0.015) / σp` for each portfolio
2. Identify tangency portfolio (max Sharpe)
3. Plot CML: `E(Rp) = 0.015 + Sharpe_max × σp`

### Step 4: Beta Estimation
1. Download S&P 500 returns
2. Run regression: `R_stock = α + β × R_SP500`
3. Extract beta coefficient and p-value

### Step 5: VaR Calculation
1. Compute portfolio daily variance: `σp² = w'Σw`
2. Calculate VaR: `1.645 × σp × Portfolio Value`
3. Decompose VaR by asset contributions

### Step 6: GARCH Modeling (R)
```r
# Run volatility_modeling.R
source("r-scripts/volatility_modeling.R")
```

---

## 📊 Mathematical Formulations

### Portfolio Variance
```
σp² = w'Σw = Σᵢ Σⱼ wᵢwⱼ Cov(Rᵢ, Rⱼ)
```

### Sharpe Ratio
```
SR = (E[Rp] - Rf) / σp
```

### Beta (CAPM)
```
βᵢ = Cov(Rᵢ, Rm) / Var(Rm)
```

### Value at Risk (5%)
```
VaR₀.₀₅ = Portfolio Value × 1.645 × σp × √(t/252)
```

### EGARCH(1,1) Specification
```
log(σt²) = ω + α[|zt-1| - E|zt-1|] + γzt-1 + β log(σt-1²)
```

---

## 💡 Investment Implications

### For Conservative Investors
- **Recommended:** Portfolio 1 or 2 (8-10% target)
- **Allocation:** Diversified across all 5 stocks
- **Risk:** ~15% volatility
- **Benefit:** Lower VaR, defensive exposure (PG, PFE)

### For Moderate Investors
- **Recommended:** Portfolio 3 (12% target)
- **Allocation:** Balanced between growth and defensive
- **Risk:** ~16.5% volatility
- **Sharpe:** 0.637

### For Aggressive Investors
- **Recommended:** Portfolio 5 (tangency portfolio)
- **Allocation:** Concentrated in XOM, V, NFLX
- **Risk:** ~18.4% volatility
- **Sharpe:** 0.896 (optimal risk-adjusted)

---

## 🎓 Theoretical Framework

### Modern Portfolio Theory (Markowitz)
- Diversification reduces unsystematic risk
- Efficient frontier represents optimal portfolios
- Investors choose based on risk tolerance

### Capital Asset Pricing Model (CAPM)
- Beta measures systematic (market) risk
- Expected return = Rf + β(Rm - Rf)
- Only systematic risk is priced

### Efficient Market Hypothesis
- Prices reflect all available information
- Historical returns ≠ future returns
- Risk-return tradeoff is persistent

---

## ⚠️ Limitations & Assumptions

1. **Historical Data:** Past performance ≠ future results
2. **Normal Distribution:** VaR assumes Gaussian returns (fat tails ignored)
3. **Constant Parameters:** Returns/volatility may be time-varying
4. **No Transaction Costs:** Real trading involves fees
5. **Sample Period:** 1-year window may not capture long-term patterns
6. **Short Selling Constraint:** Limits optimization flexibility
7. **Static Allocation:** No dynamic rebalancing modeled

---

## 📚 References

- Markowitz, H. (1952). Portfolio Selection. *Journal of Finance*, 7(1), 77-91.
- Sharpe, W. F. (1964). Capital Asset Prices. *Journal of Finance*, 19(3), 425-442.
- Bollerslev, T. (1986). Generalized Autoregressive Conditional Heteroskedasticity. *Journal of Econometrics*, 31(3), 307-327.
- Nelson, D. B. (1991). Conditional Heteroskedasticity in Asset Returns. *Econometrica*, 59(2), 347-370.

*Full references in academic report PDF*

---

## 📄 License

MIT License - See [LICENSE](LICENSE) file

**Data:** Yahoo Finance (publicly available market data)

---

## 📞 Contact

**Yagnesh Vaghashiya**  
London Metropolitan University  
Email: yagneshvaghashiya602@gmail.com
Mobile Number:+44 7887 172884

**Supervisor:** Dr. Jonathan Iworiso

---

## 🌟 Acknowledgments

- Dr. Jonathan Iworiso - Course supervision
- Yahoo Finance - Historical stock data
- R Core Team - Statistical computing environment

---

![Python](https://img.shields.io/badge/R-276DC3?style=flat&logo=r&logoColor=white)
![Excel](https://img.shields.io/badge/Excel-217346?style=flat&logo=microsoft-excel&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Status](https://img.shields.io/badge/Status-Complete-success.svg)

---



*This project demonstrates practical application of quantitative finance techniques to construct optimal investment portfolios with rigorous risk management.*
