#' Lookup Asthma Harmonization Info (dynamic, LLM-enhanced)
#'
#' @param variable_name A string. The variable you want to lookup.
#' @return A tibble with harmonized information or triggers ChatGPT if not found.
#' @export
#'
#' @examples
#' if (interactive()) {
#'lookup_variable("age")
#'}

lookup_variable <- function(variable_name) {

  # Clean user input
  clean_var <- trimws(tolower(variable_name))
  clean_db_vars <- trimws(tolower(harmonized_database_dynamic$`UK Variable`))

  # Search inside harmonized_database_dynamic
  result <- harmonized_database_dynamic[clean_db_vars == clean_var, ]

  if (nrow(result) > 0) {
    return(result)
  }

  #If not found, activate the LLM workflow
  message("Variable not found in harmonization database.")
  user_choice <- readline(prompt = "Do you want to search with ChatGPT? (yes/no): ")

  if (tolower(user_choice) == "yes") {
    if (Sys.getenv("OPENAI_API_KEY") == "") {
      cat(" No API key set. Please set it first with:\nSys.setenv(OPENAI_API_KEY = 'your-key')\n")
      return(NULL)
    }

    # 1. Build a smart prompt
    prompt_text <- paste0(
      "**You are a data curator for asthma studies.**\n\n",
      "**Find the best harmonization mapping for the variable '**", variable_name, "**'.**\n\n",
      "**Fill these fields:**\n",
      "- Harmonized Name\n",
      "- UK Variable\n",
      "- Source Label / Description\n",
      "- Target Concept\n",
      "- Standard Vocabulary (ATC, FHIR, LOINC, SNOMED CT, RxNorm, OMOP, EuroQol)\n",
      "- Standard Concept Code\n",
      "- Match Confidence (High/Medium/Low)\n",
      "- Summary"
    )

    # 2. Send the prompt to ChatGPT
    llm_response <- query_chatgpt(prompt_text)

    cat("\nChatGPT suggests:\n\n")
    cat(llm_response, "\n\n")

    # 3. Ask if user wants to add it
    add_choice <- readline(prompt = "Add this new entry to harmonized_database_dynamic? (yes/no): ")

    if (tolower(add_choice) == "yes") {

      # Parse the ChatGPT text
      parsed_entry <- parse_chatgpt_response(llm_response)

      #  Double check parsing success
      if (all(is.na(parsed_entry))) {
        cat(" Failed to parse the response correctly. No entry added.\n")
        return(NULL)
      }

      # Add parsed entry
      harmonized_database_dynamic <<- dplyr::bind_rows(harmonized_database_dynamic, parsed_entry)

      # Auto-save full backup
      if (!dir.exists("backup")) {
        dir.create("backup")
      }

      saveRDS(harmonized_database_dynamic, file = file.path("backup", "harmonized_database_dynamic_backup.rds"))

      #  Save log
      # Save log inside log/ folder
      timestamp <- format(Sys.time(), "%Y%m%d_%H%M%S")
      log_folder <- "log"

      # Create 'log/' if it doesn't exist
      if (!dir.exists(log_folder)) {
        dir.create(log_folder)
      }

      log_filename <- file.path(log_folder, paste0("log_new_variables_", timestamp, ".csv"))
      readr::write_csv(parsed_entry, log_filename)

      cli::cli_h1("New Variable Added!")
      print(parsed_entry)

      cli::cli_alert_success("Full backup saved to: harmonized_database_dynamic_backup.rds")
      cli::cli_alert_info(glue::glue("Logged new entry to: {log_filename}"))


    } else {
      cat("No changes made.\n")
    }

    return(NULL)

  } else {
    message("No further search requested.")
    return(NULL)
  }
}
