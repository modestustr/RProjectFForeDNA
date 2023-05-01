#' Import data from an Excel file
#'
#' @param file_path Path to the Excel file
#' @param sheetName Name of the worksheet to import
#' @param xrange Range of cells to import, e.g. "A1:B10"
#' @param col_names Whether to use the first row as column names or not
#' @param col_types A vector of column types
#' @param na String representing missing values
#' @param trim_ws Whether to trim white space from strings
#' @param skip Number of rows to skip at the beginning
#' @param n_max Maximum number of rows to read
#' @param guess_max Maximum number of rows to use for guessing column types
#' @param progress Whether to display a progress bar or not
#' @param name_repair How to repair invalid column names
#'
#' @return A data frame with the imported data
ImportExcel <- function(file_path, sheetName = NULL, xrange = NULL, col_names = TRUE,
                        col_types = NULL, na = "", trim_ws = TRUE, skip = 0,
                        n_max = Inf, guess_max = min(1000, n_max), progress = FALSE,
                        name_repair = "unique") {
  
  result <- read_excel(file_path, sheet = sheetName, range = xrange, col_names = col_names,
                       col_types = col_types, na = na, trim_ws = trim_ws, skip = skip,
                       n_max = n_max, guess_max = guess_max, progress = progress,
                       .name_repair = name_repair)
  
  return(result)
}