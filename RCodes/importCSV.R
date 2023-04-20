ImportCSV <- function(file_path) {
  
  # Get the absolute file path
  file_path <- file.path(getwd(), file_path)
  
  
  locale <- Sys.getlocale()
  locale_parts <- strsplit(locale, "_")[[1]]
  
  language <- locale_parts[1] # "en"
  country <- locale_parts[2]  # "US"
  encoding <- locale_parts[3] # "UTF-8"
  
  if (language == "en" && country == "us")
    isNative = TRUE
  else
    isNative = FALSE
  
  result <- read_csv(file_path)
  
  if (!isNative) {
    result <-
      read_csv(file_path, locale = locale(decimal_mark = ",", grouping_mark = "."))
    return(result)
  }
  return (result)
}