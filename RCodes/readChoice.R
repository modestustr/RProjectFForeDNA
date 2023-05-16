readChoice <- function(prompt_title="[y/n]:" ) {
  isToogled <- FALSE
  response <- readline(prompt = paste0(prompt_title,"[y/n]:"))
  if (tolower(response) == "y") {
    isToogled <- TRUE
  }
  return(isToogled)
}