# Visualizations Documentation

## 📊 Overview

This folder contains documentation and code for generating visualizations used in the portfolio optimization analysis. Due to the dynamic nature of charts and the large file sizes of high-quality images, this document provides instructions for recreating all visualizations.

---

## 📁 Visualization Categories

```
visualizations/
├── 01_efficient_frontier/
├── 02_capital_market_line/
├── 03_correlation_heatmap/
├── 04_portfolio_composition/
├── 05_risk_return_scatter/
├── 06_volatility_time_series/
└── python_scripts/
```

---

## 📈 Visualization 1: Efficient Frontier

### File Name: `efficient_frontier.png`

### Description
Scatter plot showing the efficient frontier - the set of optimal portfolios offering the highest expected return for each level of risk.

### Excel Method

**Steps:**
1. Open portfolio optimization workbook
2. Select data:
   - X-axis: Portfolio Risk (σp) - cells with portfolio standard deviations
   - Y-axis: Expected Return (Rp) - cells with target returns
3. Insert → Scatter → Scatter with Smooth Lines
4. Format:
   - Title: "Efficient Frontier of the Five-Asset Portfolio"
   - X-axis label: "Portfolio Risk (σp)"
   - Y-axis label: "Expected / Target Return"
   - Add data labels for each portfolio (8%, 10%, 12%, 15%, 18%)
   - Format axes to start at 0

**Data Points:**
```
Portfolio | Risk (σp) | Return (Rp)
1         | 0.1507    | 0.08
2         | 0.1557    | 0.10
3         | 0.1650    | 0.12
4         | 0.1802    | 0.15
5         | 0.1842    | 0.18
```

**Expected Appearance:**
- Upward-sloping curve
- Convex shape (bows to the left)
- Starts at minimum variance point (Portfolio 1)
- Ends at maximum return point (Portfolio 5)

---

### Python Code

```python
import matplotlib.pyplot as plt
import numpy as np

# Data
risk = [0.1507, 0.1557, 0.1650, 0.1802, 0.1842]
returns = [0.08, 0.10, 0.12, 0.15, 0.18]
labels = ['8%', '10%', '12%', '15%', '18%']

# Create figure
plt.figure(figsize=(10, 6))
plt.plot(risk, returns, 'b-o', linewidth=2, markersize=8)

# Add labels for each point
for i, label in enumerate(labels):
    plt.annotate(label, (risk[i], returns[i]), 
                textcoords="offset points", 
                xytext=(10, 5), 
                ha='left',
                fontsize=10)

# Formatting
plt.xlabel('Portfolio Risk (σp)', fontsize=12)
plt.ylabel('Expected / Target Return', fontsize=12)
plt.title('Efficient Frontier of the Five-Asset Portfolio', fontsize=14, fontweight='bold')
plt.grid(True, alpha=0.3)
plt.xlim(0, 0.20)
plt.ylim(0, 0.20)

# Save
plt.tight_layout()
plt.savefig('efficient_frontier.png', dpi=300, bbox_inches='tight')
plt.show()
```

---

### R Code

```r
# Data
risk <- c(0.1507, 0.1557, 0.1650, 0.1802, 0.1842)
returns <- c(0.08, 0.10, 0.12, 0.15, 0.18)
labels <- c('8%', '10%', '12%', '15%', '18%')

# Create plot
png("efficient_frontier.png", width=800, height=600, res=120)

plot(risk, returns, 
     type='b', 
     pch=19, 
     col='blue', 
     lwd=2,
     xlab='Portfolio Risk (σp)',
     ylab='Expected / Target Return',
     main='Efficient Frontier of the Five-Asset Portfolio',
     xlim=c(0, 0.20),
     ylim=c(0, 0.20),
     cex.main=1.2,
     cex.lab=1.1)

# Add labels
text(risk, returns, labels, pos=4, offset=0.5)

# Add grid
grid()

dev.off()
```

---

## 📊 Visualization 2: Capital Market Line (CML)

### File Name: `capital_market_line.png`

### Description
Combined plot showing the efficient frontier with the Capital Market Line overlaid. The CML is tangent to the efficient frontier at the tangency portfolio (highest Sharpe ratio).

### Data Components

**Efficient Frontier (from Viz 1):**
```
Risk: [0.1507, 0.1557, 0.1650, 0.1802, 0.1842]
Returns: [0.08, 0.10, 0.12, 0.15, 0.18]
```

**Capital Market Line:**
```
CML Equation: E(Rp) = 0.015 + 0.8957 × σp

Risk Points: [0, 0.05, 0.10, 0.15, 0.18, 0.20]
CML Returns: [0.015, 0.060, 0.105, 0.149, 0.176, 0.194]
```

**Risk-Free Point:**
```
Risk: 0
Return: 0.015 (1.5%)
```

**Tangency Portfolio:**
```
Risk: 0.1842
Return: 0.18
Sharpe: 0.896
```

---

### Python Code

```python
import matplotlib.pyplot as plt
import numpy as np

# Efficient Frontier data
ef_risk = [0.1507, 0.1557, 0.1650, 0.1802, 0.1842]
ef_returns = [0.08, 0.10, 0.12, 0.15, 0.18]

# CML data
cml_risk = np.linspace(0, 0.20, 50)
cml_returns = 0.015 + 0.8957 * cml_risk

# Risk-free point
rf_rate = 0.015

# Tangency portfolio
tangency_risk = 0.1842
tangency_return = 0.18

# Create figure
plt.figure(figsize=(12, 7))

# Plot Efficient Frontier
plt.plot(ef_risk, ef_returns, 'b-o', linewidth=2, markersize=8, label='Efficient Frontier')

# Plot CML
plt.plot(cml_risk, cml_returns, 'r--', linewidth=2, label='Capital Market Line')

# Plot risk-free point
plt.plot(0, rf_rate, 'gs', markersize=10, label=f'Risk-Free Asset (Rf={rf_rate:.1%})')

# Highlight tangency portfolio
plt.plot(tangency_risk, tangency_return, 'r*', markersize=15, 
         label=f'Tangency Portfolio (Sharpe={0.896:.3f})')

# Annotations
plt.annotate('Tangency Portfolio\n(Optimal)', 
            xy=(tangency_risk, tangency_return),
            xytext=(0.14, 0.19),
            arrowprops=dict(arrowstyle='->', color='red', lw=1.5),
            fontsize=10,
            bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.5))

# Formatting
plt.xlabel('Portfolio Risk (σp)', fontsize=12)
plt.ylabel('Expected Return', fontsize=12)
plt.title('Efficient Frontier and Capital Market Line', fontsize=14, fontweight='bold')
plt.legend(loc='lower right', fontsize=10)
plt.grid(True, alpha=0.3)
plt.xlim(-0.01, 0.21)
plt.ylim(0, 0.21)

# Save
plt.tight_layout()
plt.savefig('capital_market_line.png', dpi=300, bbox_inches='tight')
plt.show()
```

---

## 🔥 Visualization 3: Correlation Heatmap

### File Name: `correlation_heatmap.png`

### Description
Heatmap showing pairwise correlations between the 5 stocks, using color intensity to indicate correlation strength.

### Data (Correlation Matrix)

```
         NFLX    V      XOM    PFE    PG
NFLX    1.000  0.363  0.077 -0.012  0.035
V       0.363  1.000  0.287  0.362  0.376
XOM     0.077  0.287  1.000  0.242  0.224
PFE    -0.012  0.362  0.242  1.000  0.341
PG      0.035  0.376  0.224  0.341  1.000
```

---

### Python Code (seaborn)

```python
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

# Correlation matrix
stocks = ['NFLX', 'V', 'XOM', 'PFE', 'PG']
corr_matrix = np.array([
    [1.000,  0.363,  0.077, -0.012,  0.035],
    [0.363,  1.000,  0.287,  0.362,  0.376],
    [0.077,  0.287,  1.000,  0.242,  0.224],
    [-0.012, 0.362,  0.242,  1.000,  0.341],
    [0.035,  0.376,  0.224,  0.341,  1.000]
])

# Create heatmap
plt.figure(figsize=(10, 8))
sns.heatmap(corr_matrix, 
            annot=True,           # Show correlation values
            fmt='.3f',            # 3 decimal places
            cmap='RdYlGn',        # Red-Yellow-Green colormap
            center=0,             # Center colormap at 0
            square=True,          # Square cells
            linewidths=1,         # Grid lines
            cbar_kws={'label': 'Correlation Coefficient'},
            xticklabels=stocks,
            yticklabels=stocks,
            vmin=-0.5,           # Min correlation for color scale
            vmax=1.0)            # Max correlation

plt.title('Stock Return Correlation Matrix', fontsize=14, fontweight='bold', pad=20)
plt.tight_layout()
plt.savefig('correlation_heatmap.png', dpi=300, bbox_inches='tight')
plt.show()
```

**Color Interpretation:**
- **Green:** Positive correlation (move together)
- **Yellow:** Low/neutral correlation
- **Red:** Negative correlation (move opposite)
- **Darker Green:** Stronger positive correlation

---

## 🥧 Visualization 4: Portfolio Composition (Pie Charts)

### File Name: `portfolio_compositions.png`

### Description
Multiple pie charts showing asset allocation for each of the 5 efficient portfolios.

### Data

```
Portfolio 1 (8% target):
NFLX: 16.22%, V: 18.77%, XOM: 17.85%, PFE: 21.87%, PG: 25.29%

Portfolio 2 (10% target):
NFLX: 21.79%, V: 20.58%, XOM: 21.02%, PFE: 19.12%, PG: 17.50%

Portfolio 3 (12% target):
NFLX: 27.36%, V: 22.39%, XOM: 24.18%, PFE: 16.37%, PG: 9.70%

Portfolio 4 (15% target):
NFLX: 32.06%, V: 26.45%, XOM: 31.30%, PFE: 10.19%, PG: 0%

Portfolio 5 (18% target - Tangency):
NFLX: 6.90%, V: 39.29%, XOM: 53.80%, PFE: 0%, PG: 0%
```

---

### Python Code

```python
import matplotlib.pyplot as plt

# Portfolio data
portfolios = {
    'Portfolio 1\n(8% target)': [16.22, 18.77, 17.85, 21.87, 25.29],
    'Portfolio 2\n(10% target)': [21.79, 20.58, 21.02, 19.12, 17.50],
    'Portfolio 3\n(12% target)': [27.36, 22.39, 24.18, 16.37, 9.70],
    'Portfolio 4\n(15% target)': [32.06, 26.45, 31.30, 10.19, 0],
    'Portfolio 5\n(18% target)': [6.90, 39.29, 53.80, 0, 0]
}

stocks = ['NFLX', 'V', 'XOM', 'PFE', 'PG']
colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#FFA07A', '#98D8C8']

# Create subplots
fig, axes = plt.subplots(2, 3, figsize=(15, 10))
axes = axes.flatten()

# Plot each portfolio
for idx, (name, weights) in enumerate(portfolios.items()):
    # Filter out zero weights
    non_zero = [(s, w, c) for s, w, c in zip(stocks, weights, colors) if w > 0]
    labels = [item[0] for item in non_zero]
    sizes = [item[1] for item in non_zero]
    pie_colors = [item[2] for item in non_zero]
    
    axes[idx].pie(sizes, labels=labels, colors=pie_colors, autopct='%1.1f%%',
                  startangle=90, textprops={'fontsize': 10})
    axes[idx].set_title(name, fontsize=12, fontweight='bold')

# Remove extra subplot
axes[5].axis('off')

plt.suptitle('Portfolio Allocations Across Efficient Frontier', 
             fontsize=16, fontweight='bold', y=0.98)
plt.tight_layout(rect=[0, 0, 1, 0.96])
plt.savefig('portfolio_compositions.png', dpi=300, bbox_inches='tight')
plt.show()
```

---

## 📉 Visualization 5: Risk-Return Scatter (Individual Stocks)

### File Name: `risk_return_scatter.png`

### Description
Scatter plot showing individual stock positions in risk-return space, compared to the efficient frontier.

### Data

**Individual Stocks:**
```
Stock | Expected Return | Volatility
NFLX  | 12.09%         | 33.89%
V     | 16.51%         | 22.70%
XOM   | 19.84%         | 24.09%
PFE   | 5.35%          | 26.13%
PG    | -7.01%         | 18.87%
```

---

### Python Code

```python
import matplotlib.pyplot as plt

# Individual stock data
stocks_data = {
    'NFLX': (0.3389, 0.1209),
    'V': (0.2270, 0.1651),
    'XOM': (0.2409, 0.1984),
    'PFE': (0.2613, 0.0535),
    'PG': (0.1887, -0.0701)
}

# Efficient frontier
ef_risk = [0.1507, 0.1557, 0.1650, 0.1802, 0.1842]
ef_returns = [0.08, 0.10, 0.12, 0.15, 0.18]

# Create plot
plt.figure(figsize=(12, 8))

# Plot efficient frontier
plt.plot(ef_risk, ef_returns, 'b-', linewidth=2, label='Efficient Frontier', zorder=2)

# Plot individual stocks
for stock, (vol, ret) in stocks_data.items():
    plt.scatter(vol, ret, s=200, alpha=0.6, zorder=3)
    plt.annotate(stock, (vol, ret), 
                textcoords="offset points", 
                xytext=(10, 5),
                fontsize=11,
                fontweight='bold')

# Formatting
plt.xlabel('Volatility (Annualized)', fontsize=12)
plt.ylabel('Expected Return (Annualized)', fontsize=12)
plt.title('Individual Stocks vs. Efficient Frontier\n(Diversification Benefit)', 
         fontsize=14, fontweight='bold')
plt.legend(loc='upper left', fontsize=11)
plt.grid(True, alpha=0.3)
plt.axhline(y=0, color='k', linestyle='--', linewidth=0.5)
plt.xlim(0.10, 0.36)
plt.ylim(-0.10, 0.22)

plt.tight_layout()
plt.savefig('risk_return_scatter.png', dpi=300, bbox_inches='tight')
plt.show()
```

**Key Insight:**
All individual stocks lie ABOVE or to the RIGHT of the efficient frontier, showing that diversified portfolios reduce risk for the same (or better) return.

---

## 📊 Visualization 6: GARCH Conditional Volatility

### File Name: `netflix_volatility_timeseries.png`

### Description
Time series plot showing Netflix daily returns and conditional volatility estimated from EGARCH(1,1) model.

### R Code (Using rugarch output)

```r
library(ggplot2)
library(rugarch)

# Assume fit_egarch is the fitted EGARCH model from volatility_modeling.R

# Extract conditional volatility
cond_vol <- sigma(fit_egarch)
dates <- index(returns)  # Date index from returns

# Create data frame
df <- data.frame(
    Date = dates,
    Returns = as.numeric(returns),
    Volatility = as.numeric(cond_vol)
)

# Create plot
png("netflix_volatility_timeseries.png", width=1200, height=800, res=120)

par(mfrow=c(2,1), mar=c(4,4,3,2))

# Plot 1: Returns
plot(df$Date, df$Returns, type='l', col='darkblue', lwd=1,
     xlab='Date', ylab='Daily Returns',
     main='Netflix (NFLX) Daily Returns - Jan 2025 to Jan 2026',
     cex.main=1.2)
abline(h=0, col='red', lty=2)
grid()

# Plot 2: Conditional Volatility
plot(df$Date, df$Volatility, type='l', col='darkred', lwd=1.5,
     xlab='Date', ylab='Conditional Volatility',
     main='EGARCH(1,1) Conditional Volatility (Volatility Clustering)',
     cex.main=1.2)
grid()

dev.off()
```

**Observations to Highlight:**
1. Volatility clustering (high volatility periods cluster together)
2. Asymmetric response (spikes after negative returns)
3. Mean reversion (volatility eventually returns to long-run average)

---

## 🎨 Visualization 7: Beta Comparison Bar Chart

### File Name: `beta_comparison.png`

### Description
Bar chart comparing beta values across the 5 stocks.

### Python Code

```python
import matplotlib.pyplot as plt

# Beta data
stocks = ['PG', 'PFE', 'XOM', 'V', 'NFLX']
betas = [0.145, 0.482, 0.533, 0.786, 0.839]
colors = ['green', 'lightgreen', 'yellow', 'orange', 'red']

# Create bar chart
plt.figure(figsize=(10, 6))
bars = plt.bar(stocks, betas, color=colors, edgecolor='black', linewidth=1.5)

# Add value labels on bars
for bar, beta in zip(bars, betas):
    height = bar.get_height()
    plt.text(bar.get_x() + bar.get_width()/2., height + 0.02,
            f'{beta:.3f}',
            ha='center', va='bottom', fontsize=11, fontweight='bold')

# Reference line at beta=1
plt.axhline(y=1.0, color='blue', linestyle='--', linewidth=2, label='Market Beta = 1.0')

# Formatting
plt.xlabel('Stock', fontsize=12)
plt.ylabel('Beta (Market Sensitivity)', fontsize=12)
plt.title('Stock Beta Comparison\n(Systematic Risk Relative to S&P 500)', 
         fontsize=14, fontweight='bold')
plt.legend(fontsize=10)
plt.ylim(0, 1.0)
plt.grid(axis='y', alpha=0.3)

plt.tight_layout()
plt.savefig('beta_comparison.png', dpi=300, bbox_inches='tight')
plt.show()
```

**Interpretation:**
- **Green (PG):** Defensive stock, low market sensitivity
- **Orange/Red (V, NFLX):** Growth stocks, high market sensitivity
- All betas < 1.0 → Less volatile than overall market

---

## 📁 Python Script: Generate All Visualizations

### File Name: `generate_all_plots.py`

Save this in `visualizations/python_scripts/`

```python
"""
Portfolio Optimization - Visualization Generator
Generates all charts for the project
Author: Yagnesh Vaghashiya (25002034)
"""

import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

# Set style
plt.style.use('seaborn-v0_8-darkgrid')
sns.set_palette("husl")

def plot_efficient_frontier():
    """Generate efficient frontier plot"""
    risk = [0.1507, 0.1557, 0.1650, 0.1802, 0.1842]
    returns = [0.08, 0.10, 0.12, 0.15, 0.18]
    
    plt.figure(figsize=(10, 6))
    plt.plot(risk, returns, 'b-o', linewidth=2, markersize=8)
    plt.xlabel('Portfolio Risk (σp)')
    plt.ylabel('Expected Return')
    plt.title('Efficient Frontier')
    plt.grid(True, alpha=0.3)
    plt.savefig('../01_efficient_frontier/efficient_frontier.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Efficient Frontier generated")

def plot_cml():
    """Generate Capital Market Line plot"""
    ef_risk = [0.1507, 0.1557, 0.1650, 0.1802, 0.1842]
    ef_returns = [0.08, 0.10, 0.12, 0.15, 0.18]
    cml_risk = np.linspace(0, 0.20, 50)
    cml_returns = 0.015 + 0.8957 * cml_risk
    
    plt.figure(figsize=(12, 7))
    plt.plot(ef_risk, ef_returns, 'b-o', linewidth=2, label='Efficient Frontier')
    plt.plot(cml_risk, cml_returns, 'r--', linewidth=2, label='CML')
    plt.plot(0, 0.015, 'gs', markersize=10, label='Risk-Free')
    plt.plot(0.1842, 0.18, 'r*', markersize=15, label='Tangency')
    plt.xlabel('Risk')
    plt.ylabel('Return')
    plt.title('Capital Market Line')
    plt.legend()
    plt.grid(True, alpha=0.3)
    plt.savefig('../02_capital_market_line/cml.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Capital Market Line generated")

def plot_correlation_heatmap():
    """Generate correlation heatmap"""
    stocks = ['NFLX', 'V', 'XOM', 'PFE', 'PG']
    corr = np.array([
        [1.000,  0.363,  0.077, -0.012,  0.035],
        [0.363,  1.000,  0.287,  0.362,  0.376],
        [0.077,  0.287,  1.000,  0.242,  0.224],
        [-0.012, 0.362,  0.242,  1.000,  0.341],
        [0.035,  0.376,  0.224,  0.341,  1.000]
    ])
    
    plt.figure(figsize=(10, 8))
    sns.heatmap(corr, annot=True, fmt='.3f', cmap='RdYlGn',
                xticklabels=stocks, yticklabels=stocks, center=0)
    plt.title('Correlation Matrix')
    plt.tight_layout()
    plt.savefig('../03_correlation_heatmap/correlation.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Correlation Heatmap generated")

def plot_beta_comparison():
    """Generate beta comparison chart"""
    stocks = ['PG', 'PFE', 'XOM', 'V', 'NFLX']
    betas = [0.145, 0.482, 0.533, 0.786, 0.839]
    
    plt.figure(figsize=(10, 6))
    plt.bar(stocks, betas, color=['green', 'lightgreen', 'yellow', 'orange', 'red'])
    plt.axhline(y=1.0, color='blue', linestyle='--', label='Market Beta = 1.0')
    plt.xlabel('Stock')
    plt.ylabel('Beta')
    plt.title('Beta Comparison')
    plt.legend()
    plt.grid(axis='y', alpha=0.3)
    plt.savefig('../05_risk_return_scatter/beta_comparison.png', dpi=300, bbox_inches='tight')
    plt.close()
    print("✓ Beta Comparison generated")

if __name__ == "__main__":
    print("\n=== Generating Portfolio Optimization Visualizations ===\n")
    
    plot_efficient_frontier()
    plot_cml()
    plot_correlation_heatmap()
    plot_beta_comparison()
    
    print("\n✓ All visualizations generated successfully!")
    print("Check the respective folders for output files.\n")
```

---

## 🎨 Style Guidelines

### Color Scheme
- **Primary (Efficient Frontier):** Blue (#0066CC)
- **Secondary (CML):** Red (#CC0000)
- **Accent (Risk-Free):** Green (#00CC66)
- **Highlight (Tangency):** Gold star

### Font Sizes
- Title: 14pt, bold
- Axis labels: 12pt
- Annotations: 10pt
- Legends: 10pt

### Resolution
- **Screen:** 150 DPI
- **Print/Publication:** 300 DPI
- **Presentation:** 200 DPI

---

## 📊 Summary of All Visualizations

| # | Visualization | Type | Purpose |
|---|---------------|------|---------|
| 1 | Efficient Frontier | Line chart | Show optimal portfolios |
| 2 | Capital Market Line | Line chart | Show CML tangency |
| 3 | Correlation Heatmap | Heatmap | Show diversification potential |
| 4 | Portfolio Compositions | Pie charts | Show asset allocations |
| 5 | Risk-Return Scatter | Scatter plot | Compare stocks vs. portfolio |
| 6 | Volatility Time Series | Time series | Show GARCH volatility |
| 7 | Beta Comparison | Bar chart | Compare market sensitivities |

---

## 🚀 Quick Start

**Generate all visualizations:**

```bash
# Using Python
cd visualizations/python_scripts
python generate_all_plots.py

# Using R
cd visualizations/r_scripts
Rscript generate_all_plots.R
```

---

## 📁 Why Image Files Are Not Included

**Reasons:**
1. **File size:** High-quality PNGs are 500KB-2MB each
2. **Customization:** Users can adjust colors, sizes, labels
3. **Reproducibility:** Code allows recreation with updated data
4. **Version control:** Images bloat Git repositories

**What IS included:**
- ✅ Complete code to generate all visualizations
- ✅ Data for all charts
- ✅ Detailed instructions
- ✅ Style guidelines

---

**For examples of the final visualizations, see the academic report PDF in `/reports` folder.**

**Last Updated:** January 2026  
**Author:** Yagnesh Vaghashiya (25002034)
