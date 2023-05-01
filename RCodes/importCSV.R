#' ImportCSV Function
#'
#' Reads a CSV file from a specified file path and returns a data frame.
#'
#' @param file_path A character string indicating the file path of the CSV file.
#' @param col_names A logical value indicating if the first row of the CSV file should be used as column names. Default is TRUE.
#' @param col_types A character vector of column types to use instead of the automatically detected type. Default is NULL.
#' @param locale A locale object specifying the locale settings to use for reading the file. Default is locale().
#' @param na A character vector indicating strings to be treated as missing values. Default is c("", "NA").
#' @param quoted_na A logical value indicating if quoted values should be treated as missing values. Default is TRUE.
#' @param quote A character string indicating the quote used in the CSV file. Default is \".
#' @param comment A character string indicating the comment character used in the CSV file. Default is "".
#' @param trim_ws A logical value indicating if white spaces around fields should be trimmed. Default is TRUE.
#' @param skip An integer value indicating the number of rows to skip from the beginning of the file. Default is 0.
#' @param n_max An integer value indicating the maximum number of rows to read. Default is Inf.
#' @param guess_max An integer value indicating the maximum number of rows to use for guessing column types. Default is the minimum value of 1000 and n_max.
#' @param progress A logical value indicating if a progress bar should be displayed. Default is interactive().
ImportCSV <- function(file_path,
                      col_names = TRUE,
                      col_types = NULL,
                      locale = locale(),
                      na = c("", "NA"),
                      quoted_na = TRUE,
                      quote = "\"",
                      comment = "",
                      trim_ws = TRUE,
                      skip = 0,
                      n_max = Inf,
                      guess_max = min(1000, n_max),
                      progress = interactive()) {
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
  
  result <-
    read_csv(
      file = file_path,
      col_names = col_names,
      col_types = col_types,
      locale = locale,
      na = na,
      quoted_na = quoted_na,
      quote = quote,
      comment = comment,
      trim_ws = trim_ws,
      skip = skip,
      n_max = n_max,
      guess_max = guess_max,
      progress = progress
    )
  
  if (!isNative) {
    result <-
      read_csv(
        file = file_path,
        col_names = col_names,
        col_types = col_types,
        locale = locale(decimal_mark = ",", grouping_mark = "."),
        na = na,
        quoted_na = quoted_na,
        quote = quote,
        comment = comment,
        trim_ws = trim_ws,
        skip = skip,
        n_max = n_max,
        guess_max = guess_max,
        progress = progress
      )
  }
  return (result)
}