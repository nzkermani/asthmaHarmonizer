# asthmaHarmonizer

> A lightweight R package for harmonizing asthma-related variables across studies.

## Overview
`asthmaHarmonizer` provides tools to map different variable names from various asthma studies to a common harmonized vocabulary. This helps standardize multi-cohort data analysis.

## Features
- Quickly look up harmonized names and metadata for variables.
- Internal harmonization database included.
- Standard vocabulary codes and mappings (e.g., SNOMED-CT).

## Installation
```r
# You can install it locally:
devtools::load_all()
```

## Example Usage
```r
# Lookup a variable
lookup_variable("age")

# Example output
dplyr::glimpse(harmonized_database)
```

## Documentation
- `lookup_variable(variable_name)`: Search for a harmonized mapping.
- `harmonized_database`: Internal tibble with all mappings.

## License
MIT License. See `LICENSE` file for details.

---

Developed with ❤️ by Nazanin.

