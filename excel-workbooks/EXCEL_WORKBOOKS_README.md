# Excel Workbooks Documentation

## 📊 Overview

This folder contains Excel workbooks used for portfolio optimization analysis. Due to GitHub file size considerations and the interactive nature of Excel Solver, the complete workbooks are not included in this repository. However, this document provides detailed instructions on how to recreate them.

---

## 📁 Workbook 1: Portfolio Optimization with Solver

### File Name: `portfolio_optimization.xlsx`

### Purpose
Perform mean-variance optimization to construct the efficient frontier using Excel Solver.

### Sheets Included

#### Sheet 1: Data Input
**Contents:**
- Historical daily adjusted closing prices (250 trading days)
- Stocks: NFLX, V, XOM, PFE, PG
- S&P 500 index prices
- Dates: January 2025 - January 2026

**Columns:**
```
| Date | NFLX_AdjClose | V_AdjClose | XOM_AdjClose | PFE_AdjClose | PG_AdjClose | S&P500_AdjClose |
```

**Data Source:** Yahoo Finance

---

#### Sheet 2: Returns Calculation
**Formulas:**

**Daily Returns (Simple):**
```excel
=(B3-B2)/B2
```

**Annualized Expected Return:**
```excel
=AVERAGE(daily_returns) * 252
```

**Daily Volatility:**
```excel
=STDEV(daily_returns)
```

**Annualized Volatility:**
```excel
=daily_volatility * SQRT(252)
```

**Results Table:**
```
Stock | Mean Daily Return | Annual Expected Return | Daily Volatility | Annual Volatility
NFLX  | 0.000479667      | 0.120876175           | 0.021351179      | 0.338939466
V     | 0.000655342      | 0.165146299           | 0.014297797      | 0.226970484
XOM   | 0.000787437      | 0.198434015           | 0.015176196      | 0.24091465
PFE   | 0.000212468      | 0.05354192            | 0.016459982      | 0.261294115
PG    | -0.000278174     | -0.070099845          | 0.011888645      | 0.188726382
```

---

#### Sheet 3: Correlation & Covariance Matrix

**Correlation Matrix:**
```excel
=CORREL(NFLX_returns, V_returns)
```

**Result:**
```
         NFLX     V       XOM     PFE     PG
NFLX     1.000   0.363   0.077  -0.012   0.035
V        0.363   1.000   0.287   0.362   0.376
XOM      0.077   0.287   1.000   0.242   0.224
PFE     -0.012   0.362   0.242   1.000   0.341
PG       0.035   0.376   0.224   0.341   1.000
```

**Annualized Covariance Matrix:**
```excel
=correlation * NFLX_volatility * V_volatility
```

**Result (partial):**
```
         NFLX        V           XOM         PFE         PG
NFLX     0.114880    0.027939    0.006283   -0.001080    0.002244
V        0.027939    0.051516    0.015707    0.021496    0.016117
...
```

---

#### Sheet 4: Portfolio Optimization (Solver)

**Decision Variables:**
```
Row 1: Portfolio Weights
Cell B1: =0.2  (NFLX weight - initial guess)
Cell C1: =0.2  (V weight)
Cell D1: =0.2  (XOM weight)
Cell E1: =0.2  (PFE weight)
Cell F1: =0.2  (PG weight)
```

**Constraints:**
```
Cell G1: =SUM(B1:F1)  [Must equal 1]
```

**Portfolio Expected Return:**
```
Cell B3: =SUMPRODUCT(B1:F1, B5:F5)
where B5:F5 = Annual Expected Returns
```

**Portfolio Variance:**
```
Cell B4: =MMULT(MMULT(B1:F1, Covariance_Matrix), TRANSPOSE(B1:F1))
```

**Portfolio Standard Deviation:**
```
Cell B5: =SQRT(B4)
```

**Target Return:**
```
Cell B6: =0.08  (8% for Portfolio 1)
```

---

**Solver Setup:**

1. **Set Objective:** Cell B4 (Portfolio Variance)
2. **To:** Min
3. **By Changing Variable Cells:** B1:F1 (weights)
4. **Subject to Constraints:**
   - B3 (Portfolio Return) = B6 (Target Return)
   - G1 (Sum of Weights) = 1
   - B1:F1 >= 0 (no short selling)

5. **Solving Method:** GRG Nonlinear

6. **Run Solver** for each target return (8%, 10%, 12%, 15%, 18%)

7. **Record Results:**

```
Portfolio | Target Return | Optimal Weights (NFLX, V, XOM, PFE, PG) | Portfolio Risk
1         | 8%           | 16.2%, 18.8%, 17.8%, 21.9%, 25.3%      | 15.07%
2         | 10%          | 21.8%, 20.6%, 21.0%, 19.1%, 17.5%      | 15.57%
3         | 12%          | 27.4%, 22.4%, 24.2%, 16.4%, 9.7%       | 16.50%
4         | 15%          | 32.1%, 26.5%, 31.3%, 10.2%, 0%         | 18.02%
5         | 18%          | 6.9%, 39.3%, 53.8%, 0%, 0%             | 18.42%
```

---

#### Sheet 5: Efficient Frontier Chart

**Create Scatter Plot:**
1. X-axis: Portfolio Risk (σp)
2. Y-axis: Expected Return (Rp)
3. Data Points: 5 portfolios from Solver results
4. Chart Title: "Efficient Frontier of the Five-Asset Portfolio"

**Expected Shape:** Upward-sloping convex curve

---

## 📁 Workbook 2: Sharpe Ratio & Capital Market Line

### File Name: `sharpe_ratio_cml.xlsx`

### Purpose
Calculate Sharpe ratios and construct the Capital Market Line (CML).

### Sheets Included

#### Sheet 1: Sharpe Ratio Calculation

**Input Parameters:**
```
Risk-Free Rate (Rf): 0.015 (1.5%)
```

**Formula:**
```excel
Sharpe Ratio = (Portfolio Return - Rf) / Portfolio Risk
```

**Calculation Table:**
```
Portfolio | Return (Rp) | Risk (σp) | Sharpe Ratio
1         | 0.08       | 0.150723  | 0.431
2         | 0.10       | 0.155742  | 0.546
3         | 0.12       | 0.164959  | 0.637
4         | 0.15       | 0.180186  | 0.749
5         | 0.18       | 0.184193  | 0.896  ← HIGHEST (Tangency Portfolio)
```

**Identify Tangency Portfolio:**
```excel
=MAX(Sharpe_Ratios)  → 0.896
```

---

#### Sheet 2: Capital Market Line

**CML Equation:**
```
E(Rp) = Rf + S* × σp

where S* = Maximum Sharpe Ratio = 0.8957
```

**CML Data Points:**
```
Risk (σp) | CML Return
0.00      | 0.015
0.05      | 0.060
0.10      | 0.105
0.15      | 0.149
0.18      | 0.176
0.20      | 0.194
```

**Chart:**
- Scatter plot with Efficient Frontier + CML
- CML is a straight line tangent to the efficient frontier
- Tangent point = Portfolio 5

---

## 📁 Workbook 3: Beta Estimation (CAPM)

### File Name: `beta_estimation_capm.xlsx`

### Purpose
Estimate beta for each stock using linear regression against S&P 500.

### Sheets Included

#### Sheet 1-5: Individual Stock Regressions

**For each stock (NFLX, V, XOM, PFE, PG):**

**Regression Model:**
```
Stock Return = α + β × (S&P 500 Return) + ε
```

**Excel Data Analysis ToolPak:**
1. Data → Data Analysis → Regression
2. Input Y Range: Stock returns
3. Input X Range: S&P 500 returns
4. Output to: New worksheet

**Extract:**
- **Beta (β):** Slope coefficient
- **Alpha (α):** Intercept
- **R-squared:** Goodness of fit
- **P-value:** Statistical significance

**Results Summary:**
```
Stock | Beta   | Alpha      | R²     | P-value   | Interpretation
NFLX  | 0.839  | 0.000244   | 0.479  | < 0.001   | High market sensitivity
V     | 0.786  | 0.000349   | 0.642  | < 0.001   | High market sensitivity
XOM   | 0.533  | 0.000489   | 0.178  | < 0.001   | Moderate exposure
PFE   | 0.482  | -0.000088  | 0.165  | < 0.001   | Moderate exposure
PG    | 0.145  | -0.000357  | 0.043  | 0.0128    | Defensive (low beta)
```

---

## 📁 Workbook 4: Value at Risk (VaR)

### File Name: `value_at_risk_calculation.xlsx`

### Purpose
Calculate 5% VaR using variance-covariance method.

### Sheets Included

#### Sheet 1: Portfolio Variance Calculation

**For Portfolio 4 (15% target return):**

**Weights:**
```
w = [0.3206, 0.2645, 0.3130, 0.1019, 0]
```

**Daily Covariance Matrix:** (annualized covariance / 252)

**Portfolio Daily Variance:**
```excel
=MMULT(MMULT(weights, daily_covariance_matrix), TRANSPOSE(weights))

Result: 0.000128837
```

**Portfolio Daily Volatility:**
```excel
=SQRT(daily_variance)

Result: 0.01135063 (1.135%)
```

---

#### Sheet 2: VaR Calculation

**Parameters:**
- Confidence Level: 95% (5% VaR)
- Z-score (5% quantile): 1.645
- Portfolio Value: $1,000,000
- Time Horizon: 1 day

**Formula:**
```excel
VaR = Portfolio Value × Z × Daily Volatility

=1000000 × 1.645 × 0.01135063

Result: $18,671.79
```

**Interpretation:**
"With 95% confidence, the maximum expected loss over 1 trading day is $18,672."

---

#### Sheet 3: Component VaR

**Marginal Contribution to Risk (MCi):**
```excel
MCi = (Σw)i / σp

where (Σw)i is the i-th element of the covariance-weight product
```

**Component Contribution (CCi):**
```excel
CCi = wi × MCi
```

**VaR Contribution:**
```excel
VaRi = CCi × Z × Portfolio Value
```

**Results:**
```
Asset | Weight  | Marginal Contrib | Component Contrib | VaR Contrib | % of Total VaR
NFLX  | 32.06%  | 0.01611          | 0.00516          | $8,495      | 45.50%
V     | 26.45%  | 0.01038          | 0.00275          | $4,516      | 24.19%
XOM   | 31.30%  | 0.00905          | 0.00283          | $4,660      | 24.96%
PFE   | 10.19%  | 0.00597          | 0.00061          | $1,000      | 5.36%
PG    | 0%      | 0.00345          | 0                | $0          | 0%
```

**Verification:**
```
Sum of VaR Contributions = $18,671 ✓
```

---

## 📁 How to Recreate the Workbooks

### Step 1: Download Historical Data
1. Go to Yahoo Finance
2. Download daily adjusted closing prices for:
   - NFLX, V, XOM, PFE, PG, ^GSPC (S&P 500)
3. Date range: January 1, 2025 - January 31, 2026

### Step 2: Create Workbook Structure
1. Create new Excel file
2. Add sheets as described above
3. Input historical prices

### Step 3: Calculate Returns
1. Compute daily simple returns
2. Annualize returns and volatility

### Step 4: Build Covariance Matrix
1. Calculate correlation matrix using CORREL()
2. Convert to covariance using volatilities

### Step 5: Run Solver
1. Enable Solver add-in (File → Options → Add-ins)
2. Set up optimization problem
3. Run for each target return

### Step 6: Perform Regression
1. Enable Data Analysis ToolPak
2. Run regression for each stock vs. S&P 500
3. Extract beta coefficients

### Step 7: Calculate VaR
1. Use portfolio weights from Solver
2. Compute daily portfolio variance
3. Apply VaR formula

---

## 📊 Alternative: Python/R Implementation

If you prefer programmatic approaches:

**Python (pandas + scipy):**
```python
import pandas as pd
import numpy as np
from scipy.optimize import minimize

# Mean-variance optimization
def portfolio_variance(weights, cov_matrix):
    return weights @ cov_matrix @ weights

# Solver alternative
result = minimize(
    portfolio_variance,
    x0=initial_weights,
    args=(cov_matrix,),
    method='SLSQP',
    constraints=constraints,
    bounds=bounds
)
```

**R (quadprog package):**
```r
library(quadprog)

# Quadratic programming
solve.QP(
    Dmat = cov_matrix,
    dvec = rep(0, n_assets),
    Amat = constraints_matrix,
    bvec = constraints_vector
)
```

---

## 📁 Files Not Included (Why)

**Why Excel files are not in the repository:**
1. **Size:** Excel with data can be 5-10MB (GitHub prefers < 100MB but optimal < 1MB)
2. **Interactivity:** Solver requires manual setup, cannot be version-controlled
3. **Platform:** Excel formulas may differ between Windows/Mac
4. **Data Source:** Yahoo Finance data should be downloaded fresh

**What IS included:**
- ✅ Raw data (CSV/XLSX format)
- ✅ Complete documentation (this file)
- ✅ R scripts for automation
- ✅ Results in PDF report

---

## 🎯 Learning Outcomes

By recreating these workbooks, you will:
1. ✅ Master Excel Solver for optimization
2. ✅ Understand mean-variance portfolio theory
3. ✅ Calculate risk metrics (VaR, beta)
4. ✅ Build efficient frontiers
5. ✅ Perform regression analysis

---

**For complete worked examples, see the academic report PDF in `/reports` folder.**

**Last Updated:** January 2026  
**Author:** Yagnesh Vaghashiya (25002034)
