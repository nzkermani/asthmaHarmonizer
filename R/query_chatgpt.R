#' Query ChatGPT API
#'
#' Sends a prompt to ChatGPT using the OpenAI API and returns the response.
#'
#' @param prompt A string containing your question or text.
#' @return A string with ChatGPT's response.
#' @export
query_chatgpt <- function(prompt) {
  api_key <- Sys.getenv("OPENAI_API_KEY")

  response <- httr::POST(
    url = "https://api.openai.com/v1/chat/completions",
    httr::add_headers(
      Authorization = paste("Bearer", api_key),
      "Content-Type" = "application/json"
    ),
    body = jsonlite::toJSON(list(
      model = "gpt-4",
      messages = list(list(role = "user", content = prompt)),
      temperature = 0.0
    ), auto_unbox = TRUE)
  )

  result <- httr::content(response, as = "parsed", simplifyVector = FALSE) # <- FALSE here

  # Check if response has 'choices'
  if (!is.null(result$choices)) {
    return(result$choices[[1]]$message$content)
  } else if (!is.null(result$error$message)) {
    stop("Something went wrong: ", result$error$message)
  } else {
    stop("Unknown error occurred.")
  }
}
