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

# ggpubr
if (!require(ggpubr))
  install.packages("ggpubr")

# cowplot
if (!require(cowplot))
  install.packages("cowplot")


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

# tcltk
if (!require(tcltk))
  install.packages("tcltk")

# tcltk2
if (!require(tcltk2))
  install.packages("tcltk2")

# rlang
if (!require(rlang))
  install.packages("rlang")

#-------------USING LIBRARIES----
library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(scales)
library(gridExtra)
library(ggpubr)
library(cowplot)
library(ggpmisc)
library(readr)
library(progress)
library(tidyverse)
library(hrbrthemes)
library(viridis)
library(tcltk)
library(tcltk2)
library(rlang)

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
#-------------Load mandatory files and iniquities----
source("RCodes/plotSave.R")
source("RCodes/ImportExcel.R")
source("RCodes/getDataFileName.R")
source("RCOdes/dataMeanGroupBy.R")

cat("\nLibraries and iniquities Installed \n" )
