# 
file_conn <- file("outputs/outputDegra.txt")
#
sink(file_conn)
#-------------USINGS----
source("RCodes/usings.R")
#-------------Open File, Move to Data Folder and import data set from excel or csv file by getDataFileName Function----
selectedFile<-getDataFileName()
EgeriaDaphniaDegra <- ImportExcel(selectedFile,"EgeriaDaphniaDegra","A1:M1297",na="na")
# Filter by Empty and NOT NA
EgeriaDaphniaDegraFiltered<- EgeriaDaphniaDegra %>% filter(CopyNumberSelected!="", !is.na(CopyNumberSelected))
EgeriaDaphniaDegraFilteredCopyLoged<- EgeriaDaphniaDegra %>% filter(CopyNumberLoged!="", !is.na(CopyNumberLoged))

col_names<-colnames(EgeriaDaphniaDegraFiltered)
col_names
#-------------Mean by groups----
data_groupDegra <- dataMeanGroupBy(EgeriaDaphniaDegraFiltered, c(4, 5, 6, 2, 3), "CopyNumberSelected", TRUE)
data_groupDegraLoged <- dataMeanGroupBy(EgeriaDaphniaDegraFiltered, c(4, 5, 6, 2, 3), "CopyNumberLoged", TRUE)

#-------------Filters----
# Filter for Egeria
datagroupDegraEgeria <- filter(data_groupDegra, Organism == "E.densa")
datagroupDegraEgeriaLoged <- filter(data_groupDegraLoged, Organism == "E.densa")

EgeriaDegraFiltered<- filter(EgeriaDaphniaDegraFiltered, Organism=="E.densa")
EgeriaDegraFilteredCopy<- filter(EgeriaDaphniaDegraFilteredCopyLoged, Organism=="E.densa")
# dataDegraEgeria <- dataDegraEgeria %>%
#   mutate(Organism = if_else(Organism == "Egeria", "E.densa", Organism))

# Filter Egeria for Sediment
datagroupDegraEgeriaLogedforSediment<- filter(datagroupDegraEgeriaLoged, Substrat=="Sediment")

# EgeriaDegraFilteredCopyLogedSediment----
EgeriaDegraFilteredCopyLogedSediment<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Egeria densa" & Substrate=="Sediment")
EgeriaDegraFilteredCopyLogedSedimentSet1<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Egeria densa" & Substrate=="Sediment" & Set=="Set1")
EgeriaDegraFilteredCopyLogedSedimentSet2<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Egeria densa" & Substrate=="Sediment" & Set=="Set2")
EgeriaDegraFilteredCopyLogedSedimentSet3<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Egeria densa" & Substrate=="Sediment" & Set=="Set3")

nlsPlotModel6(EgeriaDegraFilteredCopyLogedSediment$Time,EgeriaDegraFilteredCopyLogedSediment$CopyNumberLoged, title = "E.densa Sediment All Sets")
nlsPlotModel6(EgeriaDegraFilteredCopyLogedSedimentSet1$Time,EgeriaDegraFilteredCopyLogedSedimentSet1$CopyNumberLoged, title = "E.densa Sediment Set1")
nlsPlotModel6(EgeriaDegraFilteredCopyLogedSedimentSet2$Time,EgeriaDegraFilteredCopyLogedSedimentSet2$CopyNumberLoged, title = "E.densa Sediment Set2")
nlsPlotModel6(EgeriaDegraFilteredCopyLogedSedimentSet3$Time,EgeriaDegraFilteredCopyLogedSedimentSet3$CopyNumberLoged, title = "E.densa Sediment Set3")

# DaphniaDegraFilteredCopyLogedSediment----
DaphniaDegraFilteredCopyLogedSediment<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Daphnia magna" & Substrate=="Sediment")
DaphniaDegraFilteredCopyLogedSedimentSet1<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Daphnia magna" & Substrate=="Sediment" & Set=="Set1")
DaphniaDegraFilteredCopyLogedSedimentSet2<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Daphnia magna" & Substrate=="Sediment" & Set=="Set2")
DaphniaDegraFilteredCopyLogedSedimentSet3<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Daphnia magna" & Substrate=="Sediment" & Set=="Set3")

nlsPlotModel6(DapniaDegraFilteredCopyLogedSediment$Time,DapniaDegraFilteredCopyLogedSediment$CopyNumberLoged, title = "D.magna Sediment All Sets")
nlsPlotModel6(DaphniaDegraFilteredCopyLogedSedimentSet1$Time,DaphniaDegraFilteredCopyLogedSedimentSet1$CopyNumberLoged, title = "D.maagna Sediment Set1")
nlsPlotModel6(DaphniaDegraFilteredCopyLogedSedimentSet2$Time,DaphniaDegraFilteredCopyLogedSedimentSet2$CopyNumberLoged, title = "D.maagna Sediment Set2")
# nlsPlotModel6(DaphniaDegraFilteredCopyLogedSedimentSet3$Time,DaphniaDegraFilteredCopyLogedSedimentSet3$CopyNumberLoged)

# EgeriaDegraFilteredCopyLogedWater----
EgeriaDegraFilteredCopyLogedWater<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Egeria densa" & Substrate=="Water")
EgeriaWaterSet1<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Egeria densa" & Substrate=="Water" & Set=="Set1")
EgeriaWaterSet2<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Egeria densa" & Substrate=="Water" & Set=="Set2")
EgeriaWaterSet3<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Egeria densa" & Substrate=="Water" & Set=="Set3")

nlsPlotModel6(EgeriaDegraFilteredCopyLogedWater$Time,EgeriaDegraFilteredCopyLogedWater$CopyNumberLoged, title = "E.densa Water All Sets")
nlsPlotModel6(EgeriaWaterSet1$Time,EgeriaWaterSet1$CopyNumberLoged, title = "E.densa Water Set1")
nlsPlotModel6(EgeriaWaterSet2$Time,EgeriaWaterSet2$CopyNumberLoged, title = "E.densa Water Set2")
nlsPlotModel6(EgeriaWaterSet3$Time,EgeriaWaterSet3$CopyNumberLoged, title = "E.densa Water Set3")


# DaphniaDegraFilteredCopyLogedWater----
DaphniaDegraFilteredCopyLogedWater<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Daphnia magna" & Substrate=="Water")
DaphniaDegraFilteredCopyLogedWaterSet1<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Daphnia magna" & Substrate=="Water" & Set=="Set1")
DaphniaDegraFilteredCopyLogedWaterSet2<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Daphnia magna" & Substrate=="Water" & Set=="Set2")
DaphniaDegraFilteredCopyLogedWaterSet3<- filter(EgeriaDaphniaDegraFilteredCopyLoged,Organism=="Daphnia magna" & Substrate=="Water" & Set=="Set3")

nlsPlotModel6(DaphniaDegraFilteredCopyLogedWater$Time,DaphniaDegraFilteredCopyLogedWater$CopyNumberLoged, title = "D.magna Water All Sets")
nlsPlotModel6(DaphniaDegraFilteredCopyLogedWaterSet1$Time,DaphniaDegraFilteredCopyLogedWaterSet1$CopyNumberLoged, title = "D.magna Water Set1")
nlsPlotModel6(DaphniaDegraFilteredCopyLogedWaterSet2$Time,DaphniaDegraFilteredCopyLogedWaterSet2$CopyNumberLoged, title = "D.magna Water Set2")
# nlsPlotModel6(DaphniaDegraFilteredCopyLogedWaterSet3$Time,DaphniaDegraFilteredCopyLogedWaterSet3$CopyNumberLoged)

# ----Filter Egeria for Sediment Set1----
datagroupDegraEgeriaLogedforSedimentSet1<- filter(datagroupDegraEgeriaLogedforSediment, Set=="Set1")

# ----Filter Egeria for Sediment Set2----
datagroupDegraEgeriaLogedforSedimentSet2<- filter(datagroupDegraEgeriaLogedforSediment, Set=="Set2")

# ----Filter Egeria for Sediment Set3----
datagroupDegraEgeriaLogedforSedimentSet3<- filter(datagroupDegraEgeriaLogedforSediment, Set=="Set3")

# Filter Egeria for Water----
datagroupDegraEgeriaLogedforWater<- filter(datagroupDegraEgeriaLoged, Substrat=="Water")

# ----Filter Egeria for Water Set1----
datagroupDegraEgeriaLogedforWaterSet1<- filter(datagroupDegraEgeriaLogedforWater, Set=="Set1")

# ----Filter Egeria for Water Set2----
datagroupDegraEgeriaLogedforWaterSet2<- filter(datagroupDegraEgeriaLogedforWater, Set=="Set2")

# ----Filter Egeria for Water Set3----
datagroupDegraEgeriaLogedforWaterSet3<- filter(datagroupDegraEgeriaLogedforWater, Set=="Set3")


# Filter for Daphnia ----
datagroupDegraDaphnia <- filter(data_groupDegra, Organism == "D.magna")
datagroupDegraDaphniaLoged <- filter(data_groupDegraLoged, Organism == "D.magna")

DaphniaDegraFiltered<- filter(EgeriaDaphniaDegraFiltered, Organism=="D.magna")

# Filter Daphnia for Sediment
datagroupDegraDaphniaLogedforSediment<- filter(datagroupDegraDaphniaLoged, Substrat=="Sediment")

# ----Filter Daphnia for Sediment Set1
datagroupDegraDaphniaLogedforSedimentSet1<- filter(datagroupDegraDaphniaLogedforSediment, Set=="Set1")

# ----Filter Daphnia for Sediment Set2
datagroupDegraDaphniaLogedforSedimentSet2<- filter(datagroupDegraDaphniaLogedforSediment, Set=="Set2")

# ----Filter Daphnia for Sediment Set3
datagroupDegraDaphniaLogedforSedimentSet3<- filter(datagroupDegraDaphniaLogedforSediment, Set=="Set3")

# Filter Daphnia for Water
datagroupDegraDaphniaLogedforWater<- filter(datagroupDegraDaphniaLoged, Substrat=="Water")

# ----Filter Daphnia for Sediment Set1
datagroupDegraDaphniaLogedforWaterSet1<- filter(datagroupDegraDaphniaLogedforWater, Set=="Set1")

# ----Filter Daphnia for Sediment Set2
datagroupDegraDaphniaLogedforWaterSet2<- filter(datagroupDegraDaphniaLogedforWater, Set=="Set2")

# ----Filter Daphnia for Sediment Set3
datagroupDegraDaphniaLogedforWaterSet3<- filter(datagroupDegraDaphniaLogedforWater, Set=="Set3")

#-----nlsPlots----
nlsPlotModel6(datagroupDegraEgeriaLogedforSediment$Time,datagroupDegraEgeriaLogedforSediment$mean$y)
nlsPlotModel6(EgeriaDegraFilteredCopyLogedSediment$Time,EgeriaDegraFilteredCopyLogedSediment$CopyNumberLoged)
nlsPlotModel6(OnlySediment$Time,OnlySediment$CopyNumberLoged)


nlsPlotModel6(datagroupDegraEgeriaLogedforSedimentSet1$Time,datagroupDegraEgeriaLogedforSedimentSet1$mean$y)
nlsPlotModel6(datagroupDegraEgeriaLogedforSedimentSet2$Time,datagroupDegraEgeriaLogedforSedimentSet2$mean$y)
nlsPlotModel6(datagroupDegraEgeriaLogedforSedimentSet3$Time,datagroupDegraEgeriaLogedforSedimentSet3$mean$y)

nlsPlotModel6(datagroupDegraEgeriaLogedforWater$Time,datagroupDegraEgeriaLogedforWater$mean$y)
nlsPlotModel6(datagroupDegraEgeriaLogedforWaterSet1$Time,datagroupDegraEgeriaLogedforWaterSet1$mean$y)
nlsPlotModel6(datagroupDegraEgeriaLogedforWaterSet2$Time,datagroupDegraEgeriaLogedforWaterSet2$mean$y)
nlsPlotModel6(datagroupDegraEgeriaLogedforWaterSet3$Time,datagroupDegraEgeriaLogedforWaterSet3$mean$y)

nlsPlotModel6(datagroupDegraDaphniaLogedforSediment$Time,datagroupDegraDaphniaLogedforSediment$mean$y)
nlsPlotModel6(datagroupDegraDaphniaLogedforSedimentSet1$Time,datagroupDegraDaphniaLogedforSedimentSet1$mean$y)
nlsPlotModel6(datagroupDegraDaphniaLogedforSedimentSet2$Time,datagroupDegraDaphniaLogedforSedimentSet2$mean$y)

nlsPlotModel6(datagroupDegraDaphniaLogedforWater$Time,datagroupDegraDaphniaLogedforWater$mean$y)
nlsPlotModel6(datagroupDegraDaphniaLogedforWaterSet1$Time,datagroupDegraDaphniaLogedforWaterSet1$mean$y)
nlsPlotModel6(datagroupDegraDaphniaLogedforWaterSet2$Time,datagroupDegraDaphniaLogedforWaterSet2$mean$y)


#-------Egeria Copy Numbers-----
de1<-ggplot(datagroupDegraEgeria, aes(x = factor(Time), y = mean$y)) +
  geom_boxplot(fill = "lightblue", color = c("#b39b9a"),outlier.size = 3, outlier.shape = 10, outlier.color = "red") +
  # geom_point()+
  stat_summary(aes(group = Substrat, color = Substrat),fun = "mean",geom = "line",alpha = .7) +
  scale_y_continuous(labels = scales::scientific_format(digits = 2)) +
  facet_grid(Organism + Substrat ~ Set + ., scales = "free_y", switch = "x") +
  labs(title = "E.densa Copy Numbers By Time and Sets", x = "Time(Hours)", y = "Copies/ml              Copies/gr") +
  theme(strip.background = element_rect(fill = brewer.pal(6, "Set1")),
        strip.text = element_text(color = "white", size = 10, face = "bold"),
        axis.text.x = element_text(angle = 90, vjust = 0.5),
        axis.title.x = element_text(vjust = -0.5),
        panel.spacing.x = unit(0.5, "lines"),legend.position="bottom")
# Save
if(isSaveOn)
  plotSave(de1, "Degra_EgeriaCopyNumbers.png")
# View
if(showPlot)
  de1
#-------Egeria Loged Copy Numbers-----
de2<-ggplot(datagroupDegraEgeriaLoged, aes(x = factor(Time), y = mean$y)) +
  geom_boxplot(fill = "lightblue", color = c("#b39b9a"),outlier.size = 3, outlier.shape = 10, outlier.color = "red") +
  # geom_point()+
  stat_summary(aes(group = Substrat, color = Substrat),fun = "mean",geom = "line",alpha = .7) +
  scale_y_continuous(labels = scales::scientific_format(digits = 2)) +
  facet_grid(Organism + Substrat ~ Set + ., scales = "free_y", switch = "x") +
  labs(title = "E.densa Loged Copy Numbers By Time and Sets", x = "Time(Hours)", y = "Copies/ml          Copies/gr") +
  theme(strip.background = element_rect(fill = brewer.pal(6, "Set1")),
        strip.text = element_text(color = "white", size = 10, face = "bold"),
        axis.text.x = element_text(angle = 90, vjust = 0.5),
        axis.title.x = element_text(vjust = -0.5),
        panel.spacing.x = unit(0.5, "lines"),legend.position="none")
# Save
if(isSaveOn)
  plotSave(de2, "Degra_EgeriaLogedCopyNumbers.png")
# View
if(showPlot)
  de2
#-------Daphnia Copy Numbers-----
dd1<-ggplot(datagroupDegraDaphnia, aes(x = factor(Time), y = mean$y)) +
  geom_boxplot(fill = "lightblue", color = c("#b39b9a"),outlier.size = 3, outlier.shape = 10, outlier.color = "red") +
  # geom_point()+
  stat_summary(aes(group = Substrat, color = Substrat),fun = "mean",geom = "line",alpha = .7) +
  scale_y_continuous(labels = scales::scientific_format(digits = 2)) +
  facet_grid(Organism + Substrat ~ Set + ., scales = "free_y", switch = "x") +
  labs(title = "D.magna Copy Numbers By Time and Sets", x = "Time(Hours)", y = "Copies/ml              Copies/gr") +
  theme(strip.background = element_rect(fill = brewer.pal(6, "Set1")),
        strip.text = element_text(color = "white", size = 10, face = "bold"),
        axis.text.x = element_text(angle = 90, vjust = 0.5),
        axis.title.x = element_text(vjust = -0.5),
        panel.spacing.x = unit(0.5, "lines"),legend.position="bottom")
# Save
if(isSaveOn)
  plotSave(dd1, "Degra_DaphniaCopyNumbers.png")
# View
if(showPlot)
  dd1
#-------Daphnia Loged Copy Numbers-----
dd2<-ggplot(datagroupDegraDaphniaLoged, aes(x = factor(Time), y = mean$y)) +
  geom_boxplot(fill = "lightblue", color = c("#b39b9a"),outlier.size = 3, outlier.shape = 10, outlier.color = "red") +
  # geom_point()+
  stat_summary(aes(group = Substrat, color = Substrat),fun = "mean",geom = "line",alpha = .7) +
  scale_y_continuous(labels = scales::scientific_format(digits = 2)) +
  facet_grid(Organism + Substrat ~ Set + ., scales = "free_y", switch = "x") +
  labs(title = "D.magna Loged Copy Numbers By Time and Sets", x = "Time(Hours)", y = "Copies/ml          Copies/gr") +
  theme(strip.background = element_rect(fill = brewer.pal(6, "Set1")),
        strip.text = element_text(color = "white", size = 10, face = "bold"),
        axis.text.x = element_text(angle = 90, vjust = 0.5),
        axis.title.x = element_text(vjust = -0.5),
        panel.spacing.x = unit(0.5, "lines"),legend.position="none")
# Save
if(isSaveOn)
  plotSave(dd2, "Degra_DaphniaLogedCopyNumbers.png")
# View
if(showPlot)
  dd2
#----------
EgeriaDegraSet1FilteredCopy<- filter(datagroupDegraEgeria, Set=="Set1")


ggplot(EgeriaDegraSet1FilteredCopy, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a",outlier.size=3, outlier.shape=10, outlier.color="red")  +
  geom_point()+
  stat_summary(aes(group = Substrat), fun = "mean", 
               fun.max = function(x) mean(x) + sd(x), 
               fun.min = function(x) mean(x) - sd(x), 
               geom = "point", size = 1, position = position_dodge(width = 0.75)) +
  labs(title = "", x = "Time(hours)", y = "DNA Copies/ml                 DNA Copies/gr" ) +     
  facet_wrap(~Organism+ Substrat+Set, ncol = 1, strip.position = "right", scales = "free_y") +
  scale_fill_brewer(palette = "Paired") +
  theme(
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position = "bottom",
    panel.background = element_rect(fill = "white"),
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(-5, NA)) +
  expand_limits(x = 0, y = -5)+
  scale_y_continuous(labels = scales::scientific_format(digits = 2))

EgeriaDegraSet2FilteredCopy<- filter(datagroupDegraEgeria, Set=="Set2")


ggplot(EgeriaDegraSet2FilteredCopy, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a",outlier.size=3, outlier.shape=10, outlier.color="red")  +
  geom_point()+
  stat_summary(aes(group = Substrat), fun = "mean", 
               fun.max = function(x) mean(x) + sd(x), 
               fun.min = function(x) mean(x) - sd(x), 
               geom = "point", size = 1, position = position_dodge(width = 0.75)) +
  labs(title = "", x = "Time(hours)", y = "DNA Copies/ml                 DNA Copies/gr" ) +     
  facet_wrap(~Organism+ Substrat+Set, ncol = 1, strip.position = "right", scales = "free_y") +
  scale_fill_brewer(palette = "Paired") +
  theme(
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position = "bottom",
    panel.background = element_rect(fill = "white"),
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(-5, NA)) +
  expand_limits(x = 0, y = -5)+
  scale_y_continuous(labels = scales::scientific_format(digits = 2))

EgeriaDegraSet3FilteredCopy<- filter(datagroupDegraEgeria, Set=="Set3")


ggplot(EgeriaDegraSet3FilteredCopy, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a",outlier.size=3, outlier.shape=10, outlier.color="red")  +
  geom_point()+
  # stat_summary(aes(group = Substrat), fun = "mean", fun.max = function(x) mean(x) + sd(x), fun.min = function(x) mean(x) - sd(x),             geom = "point", size = 1, position = position_dodge(width = 0.75)) +
  labs(title = "", x = "Time(hours)", y = "DNA Copies/ml                 DNA Copies/gr" ) +     
  facet_wrap(~Organism+ Substrat+Set, ncol = 1, strip.position = "right", scales = "free_y") +
  scale_fill_brewer(palette = "Paired") +
  theme(
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position = "bottom",
    panel.background = element_rect(fill = "white"),
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(-5, NA)) +
  expand_limits(x = 0, y = -5)+
  scale_y_continuous(labels = scales::scientific_format(digits = 2))


DaphniaGroupDegraFilteredCopy<- filter(data_groupDegra, Organism=="D.magna")

ggplot(DaphniaGroupDegraFilteredCopy, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a",outlier.size=3, outlier.shape=10, outlier.color="red")  +
  geom_point()+
  # stat_summary(aes(group = Substrat), fun = "mean", fun.max = function(x) mean(x) + sd(x), fun.min = function(x) mean(x) - sd(x),             geom = "point", size = 1, position = position_dodge(width = 0.75)) +
  labs(title = "", x = "Time(hours)", y = "DNA Copies/ml                 DNA Copies/gr" ) +     
  facet_wrap(~Organism+ Substrat+Set, ncol = 1, strip.position = "right", scales = "free_y") +
  scale_fill_brewer(palette = "Paired") +
  theme(
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position = "bottom",
    panel.background = element_rect(fill = "white"),
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(-5, NA)) +
  expand_limits(x = 0, y = -5)+
  scale_y_continuous(labels = scales::scientific_format(digits = 2))


DaphniaDegraSet1FilteredCopy<- filter(datagroupDegraDaphnia, Set=="Set1")

ggplot(DaphniaDegraSet1FilteredCopy, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a",outlier.size=3, outlier.shape=10, outlier.color="red")  +
  geom_point()+
  # stat_summary(aes(group = Substrat), fun = "mean", fun.max = function(x) mean(x) + sd(x), fun.min = function(x) mean(x) - sd(x),             geom = "point", size = 1, position = position_dodge(width = 0.75)) +
  labs(title = "", x = "Time(hours)", y = "DNA Copies/ml                 DNA Copies/gr" ) +     
  facet_wrap(~Organism+ Substrat+Set, ncol = 1, strip.position = "right", scales = "free_y") +
  scale_fill_brewer(palette = "Paired") +
  theme(
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position = "bottom",
    panel.background = element_rect(fill = "white"),
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(-5, NA)) +
  expand_limits(x = 0, y = -5)+
  scale_y_continuous(labels = scales::scientific_format(digits = 2))


DaphniaDegraSet2FilteredCopy<- filter(datagroupDegraDaphnia, Set=="Set2")

ggplot(DaphniaDegraSet2FilteredCopy, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a",outlier.size=3, outlier.shape=10, outlier.color="red")  +
  geom_point()+
  # stat_summary(aes(group = Substrat), fun = "mean", fun.max = function(x) mean(x) + sd(x), fun.min = function(x) mean(x) - sd(x),             geom = "point", size = 1, position = position_dodge(width = 0.75)) +
  labs(title = "", x = "Time(hours)", y = "DNA Copies/ml                 DNA Copies/gr" ) +     
  facet_wrap(~Organism+ Substrat+Set, ncol = 1, strip.position = "right") +
  scale_fill_brewer(palette = "Paired") +
  theme(
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position = "bottom",
    panel.background = element_rect(fill = "white"),
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(-5, NA)) +
  expand_limits(x = 0, y = -5)+
  scale_y_continuous(labels = scales::scientific_format(digits = 2))



# dataDegraDaphnia <- dataDegraDaphnia %>%
#   mutate(Organism = if_else(Organism == "Daphnia", "D.magna", Organism))

#-------------Show Plots in Plot Window----
showPlot <- readChoice("Show Plot")
# Save is On/Off
isSaveOn <- readChoice("Save On/Off")

#-------------All Group by Organism and Substrate Type----
p1 <- ggplot(data_groupDegraLoged, aes(x = factor(Time), y = mean$y)) +
  geom_boxplot() +
  # geom_boxplot(fill = "lightblue", color = c("#b39b9a")) +
  # scale_x_continuous(labels = scales::scientific, breaks = scales::pretty_breaks(n = 10)) +
  #scale_y_continuous(labels = scales::comma) +
  scale_fill_viridis(discrete = TRUE, alpha=0.9) +
  labs(title = "", x = "Time(hours)", y = "Copies/gr;Copies/ml") +
  facet_wrap(~Organism + Substrat, ncol = 1, scales = "free_y", strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))), strip.text = element_text(color = "white", size = 10, face = "bold"))
# Save
if(isSaveOn)
  plotSave(p1, "CopyNumbersMeanByAllGroup.png")
# View
if(showPlot)
  p1

#-------------Only Egeria----
p2 <- ggplot(dataDegraEgeria, aes(x = factor(Time), y = mean$y)) +
  geom_boxplot(fill = "lightblue", color = c("#b39b9a")) +
  # scale_x_continuous(labels = scales::scientific, breaks = scales::pretty_breaks(n = 10)) +
  #scale_y_continuous(labels = scales::comma) +
  labs(title = "", x = "Time(hours)", y = "Copies/gr;Copies/ml") +
  facet_wrap(~Organism + Substrat, ncol = 1, scales = "free_y", strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))), strip.text = element_text(color = "white", size = 10, face = "bold"),legend.position="bottom")
# Save
if(isSaveOn)
  plotSave(p2, "Degra_CopyNumbersMeanByOnlyEgeria.png")
# View 
if(showPlot)
  p2

#-------------Only Daphnia----
q2 <- ggplot(dataDegraDaphnia, aes(x = factor(Time), y = mean$y)) +
  geom_boxplot(fill = "lightblue", color = c("#b39b9a")) +
  # scale_x_continuous(labels = scales::scientific, breaks = scales::pretty_breaks(n = 10)) +
  #scale_y_continuous(labels = scales::comma) +
  labs(title = "", x = "Time(hours)", y = "Copies/gr;Copies/ml") +
  facet_wrap(~Organism + Substrat, ncol = 1, scales = "free_y", strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))), strip.text = element_text(color = "white", size = 10, face = "bold"),legend.position="bottom")
# Save
if(isSaveOn)
  plotSave(q2, "Degra_CopyNumbersMeanByOnlyDaphnia.png")
# View 
if(showPlot)
  q2

#--------------------View plots at the same screen-p2-q2----
c1 <- grid.arrange(p2, q2, ncol = 2)
if(showPlot)
  c1
if(isSaveOn)
  plotSave(c1, "Degra_CopyNumbersMean.png")
#-------------Curve lineer model----
# For Egeria
p3 <- ggplot(dataDegraEgeria, aes(x = factor(Time), y = mean$y, group = interaction(Organism, Substrat, Set))) +
  geom_point() +
  #geom_boxplot(fill = "lightblue", color = c("#b39b9a"))  +
  scale_y_continuous(labels = scales::comma) +
  facet_grid(Organism + Substrat ~ Set + ., scales = "free_y", switch = "x") +
  labs(title = "", x = "Time(Hours)", y = "Copies/gr;Copies/ml") +
  theme(strip.background = element_rect(fill = brewer.pal(6, "Set1")),
        strip.text = element_text(color = "white", size = 10, face = "bold"),legend.position="bottom") +
  geom_smooth(aes(group = interaction(Organism, Substrat, Set)), method = "lm")
# Save
if(isSaveOn)
  plotSave(p3, "Degra_AddLMCurveForEgeria.png")
# View
if(showPlot)
  p3


# For Daphnia
q3 <- ggplot(dataDegraDaphnia, aes(x = factor(Time), y = mean$y, group = interaction(Organism, Substrat, Set))) +
  geom_point() +
  #geom_boxplot(fill = "lightblue", color = c("#b39b9a"))  +
  scale_y_continuous(labels = scales::comma) +
  facet_grid(Organism + Substrat ~ Set + ., scales = "free_y", switch = "x") +
  labs(title = "", x = "Time(Hours)", y = "Copies/gr;Copies/ml") +
  theme(strip.background = element_rect(fill = brewer.pal(6, "Set1")),
        strip.text = element_text(color = "white", size = 10, face = "bold"),legend.position="bottom") +
  geom_smooth(aes(group = interaction(Organism, Substrat, Set)), method = "lm")
# Save
if(isSaveOn)
  plotSave(q3, "Degra_AddLMCurveForDaphina.png")
# view 
if(showPlot)
  q3
#--------------------View plots at the same screen-p3-q3----
c2 <- grid.arrange(p3, q3, ncol = 2)
if(showPlot)
  c2
if(isSaveOn)
  plotSave(c2, "Degra_AddLMCurve.png")

#-------------By Time and Set----
# Only Egeria 
p4 <- ggplot(datagroupDegraEgeria, aes(x = factor(Time), y = mean$y, color = Set)) +
  geom_boxplot() +
  geom_point(aes(color=Set))+
  scale_y_continuous(labels = scales::scientific_format(digits = 2)) +
  facet_wrap(Organism + Substrat ~ ., scales = "free_y", strip.position = "top") +
  labs(title = "", x = "Time(Hours) and Set", y = "Copies") +
  theme(
    strip.background = element_rect(fill = brewer.pal(9, "Set1")),
    #strip.text = element_text(color = "white",size = 0, face = "bold.italic"),
    axis.text.x = element_text(angle = 0, vjust = 0.5),
    axis.title.x = element_text(vjust = -0.5),
    panel.spacing.x = unit(0.5, "lines"),legend.position="bottom"
  )
# Save
if(isSaveOn)
  plotSave(p4, "Degra_CopyNumbersMeanByTimeSetsForEgeria.png")
# view
if(showPlot)
  p4

# Only Daphnia By Time and Set
q4 <- ggplot(datagroupDegraDaphnia, aes(x = factor(Time), y = mean$y, color = Set)) +
  geom_boxplot() +
  geom_point(aes(color=Set))+
  scale_y_continuous(labels = scales::scientific_format(digits = 2)) +
  facet_wrap(Organism + Substrat ~ ., scales = "free_y", strip.position = "top") +
  labs(title = "", x = "Time(Hours) and Set", y = "Copies") +
  theme(
    strip.background = element_rect(fill = brewer.pal(9, "Set1")),
    #strip.text = element_text(color = "white",size = 0, face = "bold.italic"),
    axis.text.x = element_text(angle = 90, vjust = 0.5),
    axis.title.x = element_text(vjust = -0.5),
    panel.spacing.x = unit(0.5, "lines"),legend.position="bottom"
  )
# Save
if(isSaveOn)
  plotSave(q4, "Degra_CopyNumbersMeanByTimeSetsForDaphina.png")
# view
if(showPlot)
  q4
#--------------------View plots at the same screen-p4-q4----
c3 <- grid.arrange(p4, q4, ncol = 2)
if(showPlot)
  c3
if(isSaveOn)
  plotSave(c3, "Degra_CopyNumbersMeanByTimeSets.png")
#-------------By Sets----
#-------------Only Egeria---- 
p5 <- ggplot(dataDegraEgeria, aes(x = factor(Time), y = mean$y)) +
  geom_boxplot(fill = "lightblue", color = c("#b39b9a")) +
  scale_y_continuous(labels = scales::comma) +
  facet_grid(Organism + Substrat ~ Set + ., scales = "free_y", switch = "x") +
  labs(title = "", x = "Time(Hours)", y = "Copies/gr;Copies/ml") +
  theme(strip.background = element_rect(fill = brewer.pal(6, "Set1")),
        strip.text = element_text(color = "white", size = 10, face = "bold"),
        axis.text.x = element_text(angle = 90, vjust = 0.5),
        axis.title.x = element_text(vjust = -0.5),
        panel.spacing.x = unit(0.5, "lines"),legend.position="bottom")

# Save
if(isSaveOn)
  plotSave(p5, "Degra_CopyNumbersMeanBySetsForEgeria.png")
# view
if(showPlot)
  p5


# Only Daphnia By Sets
q5 <- ggplot(dataDegraDaphnia, aes(x = factor(Time), y = mean$y)) +
  geom_boxplot(fill = "lightblue", color = c("#b39b9a")) +
  scale_y_continuous(labels = scales::comma) +
  facet_grid(Organism + Substrat ~ Set + ., scales = "free_y", switch = "x") +
  labs(title = "", x = "Time(Hours)", y = "Copies/gr;Copies/ml") +
  theme(strip.background = element_rect(fill = brewer.pal(6, "Set1")),
        strip.text = element_text(color = "white", size = 10, face = "bold"),
        axis.text.x = element_text(angle = 90, vjust = 0.5),
        axis.title.x = element_text(vjust = -0.5),
        panel.spacing.x = unit(0.5, "lines"),legend.position="bottom")

# Save
if(isSaveOn)
  plotSave(q5, "Degra_CopyNumbersMeanBySetsForDaphnia.png")
# view
if(showPlot)
  q5
#--------------------View plots at the same screen-p5-q5----
c4 <- grid.arrange(p5, q5, ncol = 2)
if(showPlot)
  c4
if(isSaveOn)
  plotSave(c4, "Degra_CopyNumbersMeanBySets.png")


message("\nDegra Run Finished \n" )
sink()
close(file_conn)