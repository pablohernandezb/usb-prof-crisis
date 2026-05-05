# USB Academic Positions Analysis — 2026 Credentials Competition

## Overview

This project analyzes and visualizes the academic positions ("cargos académicos") available through the **USB (Universidad Simón Bolívar) 2026 Credentials Competition** (Concurso de Credenciales 2026).

The analysis is based on official position requests submitted by the four academic divisions of the university and includes comprehensive visualizations of position distribution across divisions, departments, and employment types.

---

## Data Scope

- **Total positions:** 335 open positions
- **Call period:** May 2–18, 2026
- **Classes begin:** September 1, 2026
- **Coverage:** All 4 academic divisions across 24+ departments

### Academic Divisions

1. **CB** — Ciencias Básicas (Basic Sciences)
2. **CTAI** — Ciencias y Tecnologías Administrativas e Industriales (Administrative & Industrial Technologies)
3. **FyM** — Física y Matemáticas (Physics & Mathematics)
4. **SyH** — Ciencias Sociales y Humanidades (Social Sciences & Humanities)

### Position Types (by dedication level)

- **DE** — Dedicación Exclusiva (Full-time, 40 hours/week) — *Blue (#003087)*
- **TI** — Tiempo Integral (Integral time, 36 hours/week) — *Amber (#E8A020)*
- **TC** — Tiempo Convencional (Part-time, ≤12 hours/week) — *Red (#CC2200)*

---

## Script Workflow

### 1. **Data Loading**
The script loads position data from all division PDFs into a single tidy data frame (`cargos`) containing:
- Division and department identifiers
- Position ID and department name
- Dedication type and weekly hours
- Number of positions

### 2. **Summary Calculations**
Three summary tables are generated:
- **`por_div`** — Total positions by division
- **`por_div_ded`** — Positions by division and dedication type
- **`global_ded`** — Overall distribution of dedication types
- **`por_depto`** — Positions by department

### 3. **Console Output**
- Formatted summary table showing positions by division and dedication type
- Top 10 departments ranked by number of positions
- Total position count (335)

### 4. **Visualizations**
Five publication-ready plots are generated as PNG files:

#### **Plot 1: Positions by Division**
- Bar chart showing total positions per division
- Color-coded by division
- Includes position counts above each bar
- File: `plot1_cargos_por_division.png`

#### **Plot 2: Positions by Division & Dedication Type**
- Stacked bar chart showing the composition of each division
- Demonstrates the dedication type breakdown within divisions
- File: `plot2_division_por_dedicacion.png`

#### **Plot 3: Global Distribution of Dedication Types**
- Horizontal bar chart showing overall position distribution
- Includes both counts and percentages
- File: `plot3_distribucion_dedicacion.png`

#### **Plot 4: Top 15 Departments**
- Horizontal bar chart ranking departments by position count
- Color-coded by division
- Shows the most competitive departments
- File: `plot4_top15_departamentos.png`

#### **Plot 5: All Departments by Division (Faceted)**
- Four-panel grid showing all departments within each division
- Allows comparison across similar groups
- File: `plot5_todos_departamentos_facetado.png`

---

## Technical Details

### Libraries Used
- **`ggplot2`** — Data visualization
- **`dplyr`** — Data manipulation and summarization
- **`tidyr`** — Data reshaping
- **`forcats`** — Factor manipulation for ordering and labeling
- **`scales`** — Formatting utilities (percentages, etc.)
- **`tibble`** — Modern data frame container

### Customizations
- **USB Theme:** Custom `tema_usb` applies consistent formatting
  - USB brand colors (navy blue primary color)
  - Clean, minimal aesthetic
  - Optimized font sizes and spacing
- **Color Palettes:** Two custom palettes
  - `colores_ded` — Dedication type colors (USB brand aligned)
  - `colores_div` — Division colors (distinct and accessible)

### Output Files
All plots are saved as high-resolution PNG files (150 dpi) in the working directory:
- `plot1_cargos_por_division.png` — 10 × 7 inches
- `plot2_division_por_dedicacion.png` — 11 × 7.5 inches
- `plot3_distribucion_dedicacion.png` — 10 × 6.5 inches
- `plot4_top15_departamentos.png` — 11 × 8 inches
- `plot5_todos_departamentos_facetado.png` — 14 × 12 inches

---

## How to Use

### Prerequisites
Ensure you have R installed with the following packages:
```r
install.packages(c("ggplot2", "dplyr", "tidyr", "forcats", "scales", "tibble"))
```

### Running the Script
```r
source("analisis_cargos_usb.R")
```

The script will:
1. Load all position data
2. Print summary statistics to the console
3. Generate and save all 5 visualization plots
4. Display confirmation messages for each saved file

### Output
- **Console:** Summary tables and statistics
- **Files:** Five PNG plots (150 dpi, publication-ready)

---

## Key Findings

The analysis reveals:
- Distribution of positions across divisions
- Demand for different employment types (full-time vs. part-time)
- Departments with the most open positions
- Overall composition of the hiring effort by division

---

## Source Data

Position information sourced from official USB Academic Personnel Requests ("Solicitud de Personal Académico") by division:
- `CB Solicitud de Personal Académico.pdf`
- `CTAI Solicitud de Personal Académico.pdf`
- `FyM Solicitud de Personal Académico.pdf`
- `SyH Solicitud de Personal Académico.pdf`

---

## Notes

- All hours are per week (horas/semana)
- The `n` column in the data represents the number of identical positions
- Some positions may appear as multiples if the department requested several identical roles
- Data compiled from official 2026 credentials competition documents

---

## Contact & Attribution

**Project:** USB Academic Positions Analysis 2026  
**Data period:** May 2–18, 2026  
**Institution:** Universidad Simón Bolívar (USB)
