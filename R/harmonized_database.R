#' Harmonized Database for Asthma Variables
#'
#' A dataset containing harmonized mappings for asthma study variables,
#' including standardized concepts and vocabularies.
#'
#' @format A tibble with 8 columns:
#' \describe{
#'   \item{Harmonized Name}{Name of the harmonized variable}
#'   \item{UK Variable}{Original UK study variable name}
#'   \item{Source Label / Description}{Original label or description}
#'   \item{Target Concept}{Mapped concept name}
#'   \item{Standard Vocabulary}{Standard terminology used (e.g., SNOMED-CT)}
#'   \item{Standard Concept Code}{Code from the standard vocabulary}
#'   \item{Match Confidence}{Confidence of the mapping}
#'   \item{Summary}{Short summary of the variable meaning}
#' }
#'
#' @source PRISM UK Harmonization Project
"harmonized_database"
