
  
  ```markdown
# asthmaHarmonizer

**Dynamic harmonization and enrichment tool for asthma research datasets.**  
  Seamlessly lookup, curate, and harmonize variables across diverse asthma studies — powered by a flexible, extendable database and optional ChatGPT integration.

---
  
  ##  Features
  
  - **Variable Lookup**: Quickly find harmonized metadata for asthma-related variables.
- **ChatGPT Integration** (Optional): If a variable is missing, ChatGPT suggests a harmonized entry.
- *Auto Parsing**: ChatGPT suggestions are parsed automatically into structured fields.
- **Auto-Backup and Logging**:  
  - New entries are saved dynamically.
- Full backup is created automatically (`backup/harmonized_database_dynamic_backup.rds`).
- Each addition is logged as a timestamped CSV in the `log/` folder.
- ️ **Safe Defaults**: If no ChatGPT API key is provided, the package falls back gracefully.
-  **Modular Architecture**: Easy to expand, improve, and integrate with larger projects like PRISM, U-BIOPRED, and others.

---
  
  ## Installation
  
  Install the package from source:
  
  ```r
devtools::install_local("path/to/asthmaHarmonizer_0.1.0.tar.gz")
```

or

Clone the repository and build:
  
  ```bash
git clone https://github.com/your_username/asthmaHarmonizer.git
cd asthmaHarmonizer
R
> devtools::install()
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
  
  ##  Directory Structure
  
  | Folder/File | Purpose |
  |:------------|:--------|
  | `data/` | Static harmonized database (e.g., `harmonized_database.rda`) |
  | `backup/` | Auto-saved backup of dynamic harmonization database |
  | `log/` | CSV logs of new variables added dynamically |
  
  ---
  
  ## Example Session
  
  ```r
> lookup_variable("blood eosinophils")
✔ Found exact match.

> lookup_variable("FEV1/FVC ratio")
Variable not found.
Do you want to search with ChatGPT? (yes/no): yes
# ChatGPT returns suggestion
# User chooses "yes" to add
 New Variable Added!
  Backup saved
 Entry logged
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
  
  ##  Contributing
  
  Contributions are very welcome!  
  Please open an issue or pull request if you want to suggest features, fixes, or improvements.

---

  ## ️ License
  
  MIT License.

---
  
  ## Acknowledgments
  
  - OpenAI for API services.
- R community for amazing development tools.
- PRISM and U-BIOPRED asthma cohorts inspiring this harmonization need.


    ```
