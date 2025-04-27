.onLoad <- function(libname, pkgname) {
  # First, try loading the backup if it exists
  if (file.exists("backup/harmonized_database_dynamic_backup.rds")) {
    harmonized_database_dynamic <<- readRDS("backup/harmonized_database_dynamic_backup.rds")
    packageStartupMessage("Loaded dynamic harmonization database from backup.")
  } else {
    # If not, initialize a fresh empty database
    harmonized_database_dynamic <<- tibble::tibble(
      `Harmonized Name` = character(),
      `UK Variable` = character(),
      `Source Label / Description` = character(),
      `Target Concept` = character(),
      `Standard Vocabulary` = character(),
      `Standard Concept Code` = character(),
      `Match Confidence` = character(),
      `Summary` = character(),
      `Timestamp Added` = as.POSIXct(character())
    )
    packageStartupMessage("No backup found. Initialized empty harmonized_database_dynamic.")
  }
}
