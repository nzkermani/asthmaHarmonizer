#' Lookup Asthma Harmonization Info
#'
#' Given a variable name, returns its harmonization mapping based on the
#' internal harmonized_database.
#'
#' @param variable_name A string. The variable you want to lookup.
#'
#' @return A tibble with harmonized information.
#' @export
#'
#' @examples
#' lookup_variable("age")
#' lookup_variable("sex")
lookup_variable <- function(variable_name) {
  clean_var <- trimws(tolower(variable_name))
  clean_db_vars <- trimws(tolower(harmonized_database$`UK Variable`))

  result <- harmonized_database[clean_db_vars == clean_var, ]

  if (nrow(result) == 0) {
    message("Variable not found in harmonization database.")
    return(NULL)
  }

  return(result)
}
