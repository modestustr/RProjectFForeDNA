#-------------Open File, Move to Data Folder and import data set from excel or csv file----
getDataFileName <- function() {
  source("RCodes/openSave.R")
  source("RCodes/defaultDataFile.R")
  
  defaultFile <-  defaultDataFile()
  selectedFile <- ""
  if (!file.exists(defaultFile)) {
    selectedFile <- openSave()
    # defaultDataFile(selectedFile)
  } else {
    selectedFile = defaultFile
  }
  
  
  if (selectedFile == "data" || selectedFile=="")
    selectedFile = myGlobalDefaultFileName
  
  
  return(selectedFile)
}
