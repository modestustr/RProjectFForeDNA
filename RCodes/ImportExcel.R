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

