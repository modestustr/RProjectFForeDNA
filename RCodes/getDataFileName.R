#-------------Open File, Move to Data Folder and import data set from excel or csv file----
getDataFileName <- function() {
  source("RCodes/openSave.R")
  
  defaultFile <- "data/Daphnia_Egeria_raw data (2).xlsx"
  selectedFile <- ""
  if (!file.exists(defaultFile)) {
    selectedFile <- openSave()
  } else {
    selectedFile = defaultFile
  }
  
  return(selectedFile)
}
