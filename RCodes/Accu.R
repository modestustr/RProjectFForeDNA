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
#-------------USING LIBRARIES----
library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(scales)
library(gridExtra)
library(ggpmisc)
library(readr)
#-------------CALLING CUSTOM FUNCS----
source("RCodes/plotSave.R")
source("RCodes/importCSV.R")
#-------------import data set from csv file in data folder----
EgeriaDaphniaAccu <- ImportCSV("data/EgeriaDaphniaAccu.csv")
#-------------Mean by groups----
data_group <- EgeriaDaphniaAccu %>%
  group_by(Organism, Substrat, Sample, Time) %>%
  summarize(mean_copy = mean(CopyNumberLoged))
#-------------Filters----
# Filter for Egeria
dataAccuEgeria <- filter(data_group, Organism == "Egeria")
dataAccuEgeria <- dataAccuEgeria %>%
  mutate(Organism = if_else(Organism == "Egeria", "E.densa", Organism))

# Filter for Daphnia
dataAccuDaphnia <- filter(data_group, Organism == "Daphnia")
dataAccuDaphnia <- dataAccuDaphnia %>%
  mutate(Organism = if_else(Organism == "Daphnia", "D.magna", Organism))
# Show Plots in Plot Window
showPlot<-FALSE
#-------------All Group by Organism and Substrate Type----
p1<-ggplot(data_group, aes(x = factor(Time), y = mean_copy)) + 
  geom_boxplot(fill = "lightblue", color = c("#b39b9a"))  +
  # scale_x_continuous(labels = scales::scientific, breaks = scales::pretty_breaks(n = 10)) +
  #scale_y_continuous(labels = scales::comma) +
  labs(title = "Organism and Substrate", x = "Day", y = "Copy Numbers Mean") +     
  facet_wrap(~ Organism + Substrat, ncol = 1, scales = "fixed", strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))),strip.text = element_text(color = "white", size = 10, face = "bold"))
# Save
plotSave(p1, "Accu_CopyNumbersMeanByAllGroup.png")
# View
if(showPlot)
  p1
#-------------Only Egeria----
p2<-ggplot(dataAccuEgeria, aes(x = factor(Time), y = mean_copy)) + 
  geom_boxplot(fill = "lightblue", color = c("#b39b9a"))  +
  # scale_x_continuous(labels = scales::scientific, breaks = scales::pretty_breaks(n = 10)) +
  #scale_y_continuous(labels = scales::comma) +
  labs(title = "Organism and Substrate", x = "Day", y = "Copy Numbers Mean") +     
  facet_wrap(~ Organism + Substrat, ncol = 1, scales = "fixed", strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))),strip.text = element_text(color = "white", size = 10, face = "bold"))
# Save
plotSave(p2, "Accu_CopyNumbersMeanByOnlyEgeria.png")
# View
p2
#-------------Only Daphnia----
q2<-ggplot(dataAccuDaphnia, aes(x = factor(Time), y = mean_copy)) + 
  geom_boxplot(fill = "lightblue", color = c("#b39b9a"))  +
  # scale_x_continuous(labels = scales::scientific, breaks = scales::pretty_breaks(n = 10)) +
  #scale_y_continuous(labels = scales::comma) +
  labs(title = "Organism and Substrate", x = "Day", y = "Copy Numbers Mean") +     
  facet_wrap(~ Organism + Substrat, ncol = 1, scales = "fixed", strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))),
        strip.text = element_text(color = "white", size = 10, face = "bold"))
# Save
plotSave(q2, "Accu_CopyNumbersMeanByOnlyDaphnia.png")
# View
q2
#--------------------View plots at the same screen-p2-q2----
c1<-grid.arrange(p2,q2,ncol=2)
if(showPlot)
  c1
plotSave(c1,"Accu_CopyNumbersMean.png")
