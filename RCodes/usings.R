sink("outputs/output.txt")
#-------------INSTALL PACKAGES IF REQUIRED----
# Package List
pkg_list <- c(
  "ggplot2", "RColorBrewer","readxl","readr",
  "scales","dplyr","ggpmisc","gridExtra",
  "ggpubr","cowplot","progress","tidyverse",
  "hrbrthemes","viridis","tcltk","tcltk2",
  "rlang","pacman","BiocManager","easynls","openxlsx","dada2"
)

# All Installed Packages
installed_pkgs <- installed.packages()

# Install Packages in List
for (pkg in pkg_list) {
  if (!(pkg %in% installed_pkgs[, "Package"])) {
    install.packages(pkg)
  }
}

# Load library
lapply(pkg_list, library, character.only = TRUE)

#-------------Create data and outputs(includes tries folder) Folder if not exist----
if (!dir.exists("data")) {
  dir.create("data")
}
if (!dir.exists("outputs")) {
  dir.create("outputs")
}
if (!dir.exists("outputs/tries")) {
  dir.create("outputs/tries")
}
if(!file.exists("data/Data.xlsx")){
  
  url <- "http://www.modestusnet.com/Data.xlsx"
  filename <- "data/Data.xlsx"
  download.file(url, destfile = filename, mode = "wb")
  myGlobalDefaultFileName<-"data/Data.xlsx"
  message("\nData File has been download\n" )
}

#-------------Load mandatory files and iniquities----
source("RCodes/plotSave.R")
source("RCodes/ImportExcel.R")
source("RCodes/getDataFileName.R")
source("RCOdes/dataMeanGroupBy.R")
source("RCOdes/readChoice.R")
source("RCOdes/nlsPlotModel6.R")

message("\nLibraries and iniquities Installed \n" )
sink()