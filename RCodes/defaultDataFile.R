# myGlobalDefaultFileName <<- "data/Daphnia_Egeria_raw data (2).xlsx"

defaultDataFile <- function(filename=NULL) {
  if(!is.null(filename))
    myGlobalDefaultFileName <<- filename
  else
    myGlobalDefaultFileName<<- "data/Data.xlsx"
}




