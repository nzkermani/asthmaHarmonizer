# asthmaHarmonizer

**Dynamic harmonization and enrichment tool for asthma research datasets.**  
Seamlessly lookup, curate, and harmonize variables across diverse asthma studies — powered by a flexible, extendable database and optional ChatGPT integration.

---

## Features

- **Variable Lookup**: Quickly find harmonized metadata for asthma-related variables.
- **ChatGPT Integration** (Optional): If a variable is missing, ChatGPT suggests a harmonized entry.
- **Auto Parsing**: ChatGPT suggestions are parsed automatically into structured fields.
- **Auto-Backup and Logging**:  
  - New entries are saved dynamically.
  - Full backup is created automatically (`backup/harmonized_database_dynamic_backup.rds`).
  - Each addition is logged as a timestamped CSV in the `log/` folder.
- **Safe Defaults**: If no ChatGPT API key is provided, the package falls back gracefully.
- **Modular Architecture**: Easy to expand, improve, and integrate with larger projects like PRISM, U-BIOPRED, and others.

---

## Installation

Install the package from source:

```r
devtools::install_local("path/to/asthmaHarmonizer_0.1.0.tar.gz")
```

or

Clone the repository and build manually:

```bash
git clone https://github.com/nzkermani/asthmaHarmonizer.git
cd asthmaHarmonizer
R
> devtools::install(pkg = ".", upgrade = FALSE, dependencies = FALSE)

```

---

## Quick Start

### 1. Load the package

```r
library(asthmaHarmonizer)
```

### 2. Lookup a variable

```r
lookup_variable("FEV1/FVC ratio")
```

If the variable is not found:

- You are asked if you want to query ChatGPT.
- If you say **yes** and have set your API key, a suggestion will be retrieved.
- You can **accept** or **reject** adding it.

---

## Set up your OpenAI API key (Optional)

If you want ChatGPT functionality:

```r
Sys.setenv(OPENAI_API_KEY = "your-openai-api-key-here")
```

Without an API key, the package will **still work normally** for known variables.

---

## Directory Structure

| Folder/File | Purpose |
|:------------|:--------|
| `data/` | Static harmonized database (e.g., `harmonized_database.rda`) |
| `backup/` | Auto-saved backup of dynamic harmonization database |
| `log/` | CSV logs of new variables added dynamically |

---

## Example Session

```r
> library(asthmaHarmonizer)
> lookup_variable("FEV1/FVC ratio")
# A tibble: 1 × 9
  `Harmonized Name`        `UK Variable` Source Label / Descr…¹ `Target Concept` `Standard Vocabulary`
  <chr>                    <chr>         <chr>                  <chr>            <chr>                
1 Ratio of Forced Expirat… FEV1/FVC rat… The ratio of the volu… FEV1/FVC ratio   LOINC                
# ℹ abbreviated name: ¹​`Source Label / Description`
# ℹ 4 more variables: `Standard Concept Code` <chr>, `Match Confidence` <chr>, Summary <chr>,
#   `Timestamp Added` <dttm>
> lookup_variable("blood eosinophils")
Variable not found in harmonization database.
Do you want to search with ChatGPT? (yes/no): yes

ChatGPT suggests:

- Harmonized Name: Blood Eosinophils Count
- UK Variable: Blood Eosinophils
- Source Label / Description: The number of eosinophils in a volume of blood. Eosinophils are a type of white blood cell that play a key role in the immune response, particularly in the context of allergies and asthma.
- Target Concept: Eosinophils count in Blood
- Standard Vocabulary: LOINC
- Standard Concept Code: 711-2
- Match Confidence: High
- Summary: The variable 'Blood Eosinophils' from the UK dataset can be harmonized to the LOINC standard vocabulary with the concept 'Eosinophils count in Blood' and the concept code 711-2. The match confidence is high as the definitions and context align closely. 

Add this new entry to harmonized_database_dynamic? (yes/no): yes

── New Variable Added! ───────────────────────────────────────────────────────────────────────────────
# A tibble: 1 × 9
  `Harmonized Name`       `UK Variable`  Source Label / Descr…¹ `Target Concept` `Standard Vocabulary`
  <chr>                   <chr>          <chr>                  <chr>            <chr>                
1 Blood Eosinophils Count Blood Eosinop… The number of eosinop… Eosinophils cou… LOINC                
# ℹ abbreviated name: ¹​`Source Label / Description`
# ℹ 4 more variables: `Standard Concept Code` <chr>, `Match Confidence` <chr>, Summary <chr>,
#   `Timestamp Added` <dttm>
✔ Full backup saved to: harmonized_database_dynamic_backup.rds
ℹ Logged new entry to: log/log_new_variables_20260619_113035.csv
NULL
> lookup_variable("FEV1/FVC ratio")
# A tibble: 1 × 9
  `Harmonized Name`        `UK Variable` Source Label / Descr…¹ `Target Concept` `Standard Vocabulary`
  <chr>                    <chr>         <chr>                  <chr>            <chr>                
1 Ratio of Forced Expirat… FEV1/FVC rat… The ratio of the volu… FEV1/FVC ratio   LOINC                
# ℹ abbreviated name: ¹​`Source Label / Description`
# ℹ 4 more variables: `Standard Concept Code` <chr>, `Match Confidence` <chr>, Summary <chr>,
#   `Timestamp Added` <dttm>
```

---

## Roadmap

- [x] Basic variable lookup
- [x] Dynamic harmonization with ChatGPT fallback
- [x] Automatic backup and logging
- [ ] Batch lookup and enrichment
- [ ] Shiny App interface
- [ ] CRAN release (optional)

---

## Contributing

Contributions are very welcome!  
Please open an issue or pull request if you want to suggest features, fixes, or improvements.

---

## License

MIT License.

---

## Acknowledgments

- OpenAI for API services.
- R community for amazing development tools.
- PRISM and U-BIOPRED asthma cohorts inspiring this harmonization effort.

