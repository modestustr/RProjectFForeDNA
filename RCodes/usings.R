#-------------INSTALL PACKAGES IF REQUIRED----
# ggplot2
if (!require(ggplot2))
  install.packages("ggplot2")

# RColorBrewer
if (!require(RColorBrewer))
  install.packages("RColorBrewer")

# readxl
if (!require(readxl))
  install.packages("readxl")

# readr
if (!require(readr))
  install.packages("readr")

# scales
if (!require(scales))
  install.packages("scales")

# dplyr
if (!require(dplyr))
  install.packages("dplyr")

# ggpmisc
if (!require(ggpmisc))
  install.packages("ggpmisc")

# gridExtra
if (!require(gridExtra))
  install.packages("gridExtra")

# progress
if (!require(progress))
  install.packages("progress")

# tidyverse
if (!require(tidyverse))
  install.packages("tidyverse")

# hrbrthemes
if (!require(hrbrthemes))
  install.packages("hrbrthemes")

# viridis
if (!require(viridis))
  install.packages("viridis")


#-------------USING LIBRARIES----
library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(scales)
library(gridExtra)
library(ggpmisc)
library(readr)
library(progress)
library(tidyverse)
library(hrbrthemes)
library(viridis)
#-------------Create data and outputs Folder if not exist
if (!dir.exists("data")) {
  dir.create("data")
}
if (!dir.exists("outputs")) {
  dir.create("outputs")
}
cat("\nLibraries Installed \n" )
