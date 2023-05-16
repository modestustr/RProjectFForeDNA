coloredMessage <- function(messageBlock, mColor) {
  colorCode <- switch(tolower(mColor),
                      "red" = "\033[31m",  # red
                      "green" = "\033[32m",    # green
                      "blue" = "\033[34m",     # blue
                      "yellow" = "\033[33m",     # yellow
                      "purple" = "\033[35m",      # purple
                      "white" = "\033[37m",    # white
                      "black" = "\033[30m"     # black
  )
  
  resetCode <- "\033[0m" # reset to black
  
  message(paste0(colorCode, messageBlock, resetCode))
}


