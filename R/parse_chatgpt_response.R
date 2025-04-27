#' Parse ChatGPT Response for Harmonization Fields
#'
#' @param response_text ChatGPT output text
#' @return A tibble with all harmonized fields extracted
#' @export
parse_chatgpt_response <- function(response_text) {
  fields <- c(
    "Harmonized Name",
    "UK Variable",
    "Source Label / Description",
    "Target Concept",
    "Standard Vocabulary",
    "Standard Concept Code",
    "Match Confidence",
    "Summary"
  )

  # Initialize an empty list
  extracted <- setNames(rep(NA_character_, length(fields)), fields)

  # Loop over each field and try to extract using regular expressions
  for (field in fields) {
    pattern <- paste0("-\\s*", field, ":\\s*(.*)")
    match <- regmatches(response_text, regexpr(pattern, response_text, perl = TRUE))

    if (length(match) > 0 && match != "") {
      # Clean up extracted value (remove "- Field: " prefix)
      value <- sub(paste0("-\\s*", field, ":\\s*"), "", match)
      extracted[[field]] <- trimws(value)
    }
  }

  # Return a tibble
  tibble::tibble(
    `Harmonized Name` = extracted[["Harmonized Name"]],
    `UK Variable` = extracted[["UK Variable"]],
    `Source Label / Description` = extracted[["Source Label / Description"]],
    `Target Concept` = extracted[["Target Concept"]],
    `Standard Vocabulary` = extracted[["Standard Vocabulary"]],
    `Standard Concept Code` = extracted[["Standard Concept Code"]],
    `Match Confidence` = extracted[["Match Confidence"]],
    `Summary` = extracted[["Summary"]],
    `Timestamp Added` = Sys.time()
  )
}
