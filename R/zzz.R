.onLoad <- function(libname, pkgname) {
  # First, try loading the  if it exists


    harmonized_database <<- load("data/harmonized_database.rda")
    harmonized_database_dynamic <<- harmonized_database


}
