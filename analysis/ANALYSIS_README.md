# Analysis Documentation

## 📊 Overview

This folder contains detailed analytical outputs and supplementary analysis beyond the main academic report. The analysis is organized by task corresponding to the MA7008 coursework structure.

---

## 📁 Analysis Structure

```
analysis/
├── task1_descriptive_statistics/
├── task2_efficient_frontier/
├── task3_sharpe_ratios/
├── task4_risk_analysis/
└── task5_volatility_modeling/
```

---

## 📈 Task 1: Descriptive Statistics

### Returns Analysis

**File:** `returns_summary.md`

**Daily Returns Summary (Sample Period: Jan 2025 - Jan 2026):**

```
Stock: NFLX (Netflix)
-------------------
Mean Daily Return:      0.0479%
Median Daily Return:    0.0521%
Standard Deviation:     2.135%
Skewness:              -0.152    (slight left tail)
Kurtosis:               3.87     (fat tails, leptokurtic)
Min Daily Return:      -8.23%
Max Daily Return:       9.14%
```

```
Stock: V (Visa)
-------------------
Mean Daily Return:      0.0655%
Median Daily Return:    0.0701%
Standard Deviation:     1.430%
Skewness:              -0.089
Kurtosis:               3.42
Min Daily Return:      -5.67%
Max Daily Return:       6.12%
```

```
Stock: XOM (Exxon Mobil)
-------------------
Mean Daily Return:      0.0787%
Median Daily Return:    0.0823%
Standard Deviation:     1.518%
Skewness:               0.124    (slight right tail)
Kurtosis:               3.91
Min Daily Return:      -6.45%
Max Daily Return:       7.89%
```

```
Stock: PFE (Pfizer)
-------------------
Mean Daily Return:      0.0212%
Median Daily Return:    0.0189%
Standard Deviation:     1.646%
Skewness:              -0.201
Kurtosis:               4.12
Min Daily Return:      -7.01%
Max Daily Return:       6.78%
```

```
Stock: PG (Procter & Gamble)
-------------------
Mean Daily Return:     -0.0278%
Median Daily Return:   -0.0201%
Standard Deviation:     1.189%
Skewness:              -0.067
Kurtosis:               3.15
Min Daily Return:      -4.89%
Max Daily Return:       5.23%
```

**Key Observations:**
1. All stocks exhibit leptokurtic distributions (fat tails) → higher probability of extreme events
2. Negative skewness for most stocks → downside tail risk
3. XOM has highest mean return but also high volatility
4. PG has lowest volatility (defensive stock)
5. PG negative return due to consumer sector weakness in sample period

---

### Correlation Insights

**File:** `correlation_analysis.md`

**Pairwise Correlations:**

**Low Correlation Pairs (Diversification Benefit):**
- NFLX - PFE: -0.012 ⭐ (near zero, excellent diversification)
- NFLX - PG: 0.035 ⭐ (very low)
- NFLX - XOM: 0.077 ⭐ (low)

**Moderate Correlation Pairs:**
- XOM - PFE: 0.242
- XOM - PG: 0.224
- V - XOM: 0.287

**Higher Correlation Pairs:**
- V - PFE: 0.362
- V - NFLX: 0.363
- V - PG: 0.376 (highest)
- PFE - PG: 0.341

**Diversification Analysis:**
```
Average Correlation: 0.234
Maximum Correlation: 0.376 (V-PG)
Minimum Correlation: -0.012 (NFLX-PFE)

Interpretation:
- Moderate average correlation → good diversification potential
- No pairs have correlation > 0.5 → assets move somewhat independently
- Negative NFLX-PFE correlation → natural hedge
```

**Sector Analysis:**
- Communication (NFLX) has low correlation with Healthcare (PFE) and Consumer Staples (PG)
- Financial Services (V) has moderate correlation with most sectors
- Energy (XOM) somewhat isolated from other sectors

---

## 📊 Task 2: Efficient Frontier Analysis

### Portfolio Compositions

**File:** `optimal_portfolios.md`

**Portfolio 1: Conservative (8% target return)**
```
Risk: 15.07% (Lowest on efficient frontier)

Allocation:
├─ NFLX: 16.22%  (Communication Services)
├─ V:    18.77%  (Financial Services)
├─ XOM:  17.85%  (Energy)
├─ PFE:  21.87%  (Healthcare)
└─ PG:   25.29%  (Consumer Staples) ← Largest position

Characteristics:
- Well-diversified across all 5 stocks
- Defensive tilt with 47% in PFE + PG
- Lowest risk portfolio on frontier
- Suitable for: Conservative investors, near-retirees
```

**Portfolio 2: Moderate-Conservative (10% target)**
```
Risk: 15.57%

Allocation:
├─ NFLX: 21.79%
├─ V:    20.58%
├─ XOM:  21.02%
├─ PFE:  19.12%
└─ PG:   17.50%

Characteristics:
- Balanced allocation across all 5 stocks
- Slight shift toward growth (NFLX, V, XOM)
- Still maintains defensive exposure
- Suitable for: Moderate investors
```

**Portfolio 3: Moderate (12% target)**
```
Risk: 16.50%

Allocation:
├─ NFLX: 27.36%  ← Increasing
├─ V:    22.39%
├─ XOM:  24.18%
├─ PFE:  16.37%
└─ PG:    9.70%  ← Decreasing

Characteristics:
- Growth tilt emerging (NFLX, XOM, V = 74%)
- Defensive stocks shrinking
- Balanced risk-return profile
- Suitable for: Growth-oriented investors
```

**Portfolio 4: Aggressive (15% target)**
```
Risk: 18.02%

Allocation:
├─ NFLX: 32.06%  ← Largest position
├─ V:    26.45%
├─ XOM:  31.30%
├─ PFE:  10.19%
└─ PG:    0.00%  ← Eliminated

Characteristics:
- Concentrated in 3 growth stocks (NFLX, V, XOM = 90%)
- PG dropped completely
- Minimal defensive exposure
- Suitable for: Aggressive growth investors
```

**Portfolio 5: Maximum Sharpe (18% target) - TANGENCY PORTFOLIO ⭐**
```
Risk: 18.42%
Sharpe Ratio: 0.896 (HIGHEST)

Allocation:
├─ NFLX:  6.90%  ← Reduced (high volatility)
├─ V:    39.29%  ← Largest position
├─ XOM:  53.80%  ← Second largest
├─ PFE:   0.00%  ← Eliminated
└─ PG:    0.00%  ← Eliminated

Characteristics:
- OPTIMAL risk-adjusted portfolio
- Concentrated in XOM (Energy) + V (Financials)
- NFLX reduced due to high idiosyncratic risk
- Best Sharpe ratio = most efficient
- Suitable for: Rational investors seeking optimal returns
```

---

### Efficient Frontier Properties

**File:** `frontier_analysis.md`

**Mathematical Properties:**
1. **Convexity:** Curve is convex (bows upward-left)
2. **Monotonicity:** Risk increases with return
3. **Minimum Variance Point:** Portfolio 1 (8%, 15.07%)
4. **Slope:** Increasing marginal risk per unit return

**Risk-Return Tradeoff:**
```
Return Increase | Risk Increase | Incremental Sharpe
8% → 10% (+2%)  | 15.07→15.57%  | Improving (slope steepening)
10% → 12% (+2%) | 15.57→16.50%  | Still improving
12% → 15% (+3%) | 16.50→18.02%  | Peak efficiency
15% → 18% (+3%) | 18.02→18.42%  | Slight deterioration
```

**Efficient vs. Inefficient:**
- Points ON the frontier → efficient (cannot improve return without increasing risk)
- Points BELOW the frontier → inefficient (dominated by frontier portfolios)
- Points ABOVE the frontier → unattainable with these 5 assets

---

## 💹 Task 3: Sharpe Ratio & CML Analysis

### Capital Market Line

**File:** `cml_analysis.md`

**CML Equation:**
```
E(Rp) = 0.015 + 0.8957 × σp

where:
- Rf = 0.015 (1.5% risk-free rate)
- Slope = 0.8957 (market price of risk)
```

**Economic Interpretation:**

1. **Risk-Free Asset (σp = 0):**
   - E(Rp) = 1.5%
   - Zero risk, certain return
   - T-bills, government bonds

2. **Tangency Portfolio (σp = 18.42%):**
   - E(Rp) = 18%
   - Optimal risky portfolio
   - Highest Sharpe ratio point

3. **Levered Positions (σp > 18.42%):**
   - Borrow at Rf and invest in tangency portfolio
   - E(Rp) = 0.015 + 0.8957 × (leverage × 18.42%)
   - Example: 2x leverage → σp = 36.84%, E(Rp) = 34.5%

**Market Price of Risk (0.8957):**
- For every 1% increase in risk, expect 0.8957% increase in return
- Compensation for bearing systematic risk
- Reflects market's risk-return preferences

**Investor Implications:**
```
Risk Tolerance | Optimal Strategy | Allocation
Low            | 50% Rf, 50% Tangency | σp = 9.21%, E(Rp) = 9.75%
Moderate       | 100% Tangency | σp = 18.42%, E(Rp) = 18%
High           | 150% Tangency (50% leverage) | σp = 27.63%, E(Rp) = 26.25%
```

---

## 📉 Task 4: Risk Analysis

### Beta Decomposition

**File:** `systematic_vs_unsystematic_risk.md`

**Total Risk Decomposition:**
```
σi² = βi² × σm² + σεi²

where:
- Total Risk = Systematic Risk + Unsystematic Risk
- βi² × σm² = Market risk (cannot diversify away)
- σεi² = Idiosyncratic risk (can diversify away)
```

**Results for Each Stock:**

**NFLX:**
```
Total Variance: 0.1149
Beta: 0.839
Market Variance: 0.0203
R²: 0.479

Systematic Risk: 0.839² × 0.0203 = 0.0143 (12.4% of total)
Unsystematic Risk: 0.1149 - 0.0143 = 0.1006 (87.6% of total)

Interpretation:
- 87.6% of NFLX volatility is company-specific
- Can be diversified away
- High idiosyncratic risk (content creation, competition)
```

**V:**
```
Total Variance: 0.0515
Beta: 0.786
R²: 0.642

Systematic Risk: 0.0331 (64.2% of total)
Unsystematic Risk: 0.0184 (35.8% of total)

Interpretation:
- Majority (64%) is market risk
- Lower diversification benefit
- Financial services tied to economy
```

**XOM:**
```
Total Variance: 0.0580
Beta: 0.533
R²: 0.178

Systematic Risk: 0.0103 (17.8% of total)
Unsystematic Risk: 0.0477 (82.2% of total)

Interpretation:
- 82% is oil-specific risk
- Commodity price fluctuations
- Geopolitical factors
```

---

### VaR Scenarios

**File:** `var_scenarios.md`

**Base Case (Portfolio 4, 15% target):**
```
1-Day VaR (95%): $18,672
10-Day VaR: $59,039 (assuming √10 scaling)
1-Month VaR (21 days): $85,602
```

**Stress Scenarios:**

**Scenario 1: Market Crash (-3σ event)**
```
Assumption: S&P 500 drops 5% in 1 day
Expected Portfolio Loss (using betas):

Portfolio Beta = Σ(wi × βi)
= 0.3206×0.839 + 0.2645×0.786 + 0.3130×0.533 + 0.1019×0.482
= 0.690

Expected Loss = 0.690 × (-5%) × $1,000,000 = -$34,500

Actual Loss Range (95% CI):
-$34,500 ± 1.96 × $11,350 = [-$56,746, -$12,254]
```

**Scenario 2: Sector-Specific Shock**
```
Assumption: Oil prices crash 15%

Direct Impact on XOM:
Estimated XOM drop: 12% (beta to oil ≈ 0.8)
Portfolio impact: 0.3130 × (-12%) = -3.76%
Dollar loss: -$37,600

Indirect impacts through correlations...
Total estimated loss: ~$42,000
```

---

## 📊 Task 5: Volatility Clustering

### GARCH Model Insights

**File:** `volatility_persistence.md`

**EGARCH(1,1) Parameter Estimates (Netflix):**
```
log(σt²) = ω + α[|zt-1| - E|zt-1|] + γzt-1 + β log(σt-1²)

Estimated Parameters:
ω (omega): -0.1234   (long-run log variance)
α (alpha):  0.1456   (magnitude effect)
γ (gamma): -0.0678   (asymmetry parameter) ← KEY
β (beta):   0.9456   (persistence)

Interpretation:
1. γ < 0 → Leverage effect present
   - Negative shocks increase volatility MORE than positive shocks
   - -1% return → 1.48× volatility impact vs. +1% return
   
2. β = 0.9456 → High persistence
   - Volatility shocks decay slowly
   - Half-life ≈ 13 days
   
3. α + β ≈ 1.09 → Volatility clustering
   - High volatility periods tend to persist
```

**Volatility Forecast:**
```
Unconditional Volatility (long-run): 2.12% daily (33.7% annualized)

Conditional Forecasts:
After calm period (σt-1 = 1.5%):
  1-day ahead: 1.62%
  5-day ahead: 1.81%
  20-day ahead: 1.98%

After volatile period (σt-1 = 3.5%):
  1-day ahead: 3.28%
  5-day ahead: 2.95%
  20-day ahead: 2.52%
```

---

## 🎯 Key Analytical Findings

### Summary of Insights

1. **Diversification Works:**
   - Individual stock volatility: 18.9% - 33.9%
   - Portfolio volatility: 15.1% - 18.4%
   - Reduction: ~40-50%

2. **Risk-Return Tradeoff:**
   - Higher returns require accepting higher volatility
   - Efficient frontier quantifies this tradeoff
   - Sharpe ratio identifies optimal balance

3. **Market Sensitivity:**
   - Growth stocks (NFLX, V): High beta (0.78-0.84)
   - Defensive stocks (PG): Low beta (0.15)
   - Portfolio construction can target desired beta

4. **Downside Risk:**
   - VaR provides concrete dollar loss estimates
   - Most risk from high-weight, high-volatility assets
   - Diversification reduces but doesn't eliminate tail risk

5. **Time-Varying Volatility:**
   - Volatility is NOT constant
   - Clustering and asymmetry present
   - GARCH models improve risk forecasts

---

## 📁 Future Analysis (Not Included)

**Potential Extensions:**
1. Monte Carlo simulation for VaR
2. Backtesting portfolio performance
3. Transaction cost analysis
4. Rebalancing strategies
5. Multi-period optimization
6. Black-Litterman asset allocation
7. Factor model attribution

---

**For complete methodology and results, see the main academic report in `/reports` folder.**

**Last Updated:** January 2026  
**Author:** Yagnesh Vaghashiya (25002034)
