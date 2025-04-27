#' View Added Variables Log
#'
#' Displays all variables that were added via ChatGPT harmonization.
#'
#' @return A tibble with the log entries.
#' @export
#'
#' @examples
#' view_added_variables()
view_added_variables <- function() {
  log_path <- "data/added_variables_log.txt"

  if (!file.exists(log_path)) {
    message("No variables have been logged yet.")
    return(NULL)
  }

  # Read the log file
  log_content <- readLines(log_path)
  log_blocks <- split(log_content, cumsum(grepl("^==========", log_content)))

  # Parse each block into a structured format
  parsed <- lapply(log_blocks, function(block) {
    if (length(block) < 8) return(NULL)  # Skip incomplete blocks

    list(
      Timestamp = sub("========== (.*) ==========", "\\1", block[1]),
      UK_Variable = sub("Variable added: ", "", block[2]),
      Harmonized_Name = sub("Harmonized Name: ", "", block[3]),
      Source_Label = sub("Source Label: ", "", block[4]),
      Target_Concept = sub("Target Concept: ", "", block[5]),
      Standard_Vocabulary = sub("Standard Vocabulary: ", "", block[6]),
      Standard_Concept_Code = sub("Standard Concept Code: ", "", block[7]),
      Match_Confidence = sub("Match Confidence: ", "", block[8]),
      Summary = ifelse(length(block) >= 9, sub("Summary: ", "", block[9]), NA)
    )
  })

  # Convert to a tibble
  tibble::tibble(do.call(rbind, parsed))
}
