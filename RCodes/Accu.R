# 
file_conn <- file("outputs/outputAccu.txt")
#
sink(file_conn)

#-------------USINGS----
source("RCodes/usings.R")
#-------------Show Plots in Plot Window----
showPlot <- readChoice("Show Plot")
# Save is On/Off
isSaveOn <- readChoice("Save On/Off")

showMePlot <- function(mplot, mshowPlot ) {
  if(mshowPlot)
      mplot
}
saveMyPlot<- function(mplot,filename, mIsSaveOn){
  if(mIsSaveOn)
    plotSave(mplot, filename)  
}
#-------------Open File, Move to Data Folder and import data set from excel or csv file by getDataFileName Function----
selectedFile<-getDataFileName()
EgeriaDaphniaAccu <- ImportExcel(selectedFile,"EgeriaDaphniaAccu","A1:L257", na="na")
# CopyNUmbers Calculation and Added To Dataset
 # EgeriaDaphniaAccu <- mutate(EgeriaDaphniaAccu,DnaCopiesNumber = ifelse(Organism == "E.densa",getDnaCopiesNumber(CorrectedValue, "E.densa"), getDnaCopiesNumber(CorrectedValue, "D.magna")))

EgeriaDaphniaLogedAccuFiltered <-
  EgeriaDaphniaAccu %>% filter(CopyNumberLoged != "",!is.na(CopyNumberLoged))

EgeriaDaphniaCopyNumberAccuFiltered <-
  EgeriaDaphniaAccu %>% filter(CopyNumberSelected != "",!is.na(CopyNumberSelected))

col_names<-colnames(EgeriaDaphniaAccu)
col_names
#-------------Mean by groups----
data_group <- dataMeanGroupBy(EgeriaDaphniaCopyNumberAccuFiltered, c(4, 5, 3, 2), "CopyNumberSelected", TRUE)
data_group_Loged <- dataMeanGroupBy(EgeriaDaphniaCopyNumberAccuFiltered, c(4, 5, 3, 2), "CopyNumberLoged", TRUE)
#-------------Mean by groups for Substrat----
data_groupSubstrat <-dataMeanGroupBy(EgeriaDaphniaLogedAccuFiltered, c(5,1,3,4),"CopyNumberLoged",TRUE)
#-------------Mean by groups----
data_groupSubstratbyOrganism <-dataMeanGroupBy(EgeriaDaphniaCopyNumberAccuFiltered, c(5,1,4),"CopyNumberSelected",TRUE)

data_groupBySubstrat <- dataMeanGroupBy(EgeriaDaphniaCopyNumberAccuFiltered, c(5,4),"CopyNumberSelected",TRUE)
data_groupBySubstratLoged <- dataMeanGroupBy(EgeriaDaphniaCopyNumberAccuFiltered, c(5,4),"CopyNumberLoged",TRUE)

nlsPlotModel6(data_group_Loged$Time,data_group_Loged$mean$y)

#-------------Filters----
# Filter for Egeria
dataAccuEgeria <- filter(data_group, Organism == "E.densa")
dataAccuEgeriaLoged <- filter(data_group_Loged, Organism == "E.densa")
# dataAccuEgeria <- dataAccuEgeria %>%
#   mutate(Organism = if_else(Organism == "Egeria", "E.densa", Organism))
# Filter for Daphnia
dataAccuDaphnia <- filter(data_group, Organism == "D.magna")
dataAccuDaphniaLoged <- filter(data_group_Loged, Organism == "D.magna")
# dataAccuDaphnia <- dataAccuDaphnia %>%
#   mutate(Organism = if_else(Organism == "Daphnia", "D.magna", Organism))


#-------------All Group by Organism and Substrate Type----
p1<-ggplot(data_group, aes(x = factor(Time), y = mean$y)) + 
  # geom_bar(aes(group=Substrat, color=Substrat), stat = "identity") +
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a")  +
  # stat_summary(aes(group=Substrat, color=Substrat),fun.y=mean, geom="point", shape=18, size=3, color="black") +
  # stat_summary(aes(group=Substrat, color=Substrat),fun = mean, geom = "pointrange",fun.max = function(x) mean(x) + sd(x), fun.min = function(x) mean(x) - sd(x)) +
  # stat_summary(fun = "mean", geom = "bar", alpha = .7) +
  stat_summary(aes(group=Substrat, color=Substrat), fun = "mean",fun.max = function(x) mean(x) + sd(x), fun.min = function(x) mean(x) - sd(x), geom = "point", size = 1) +
  # stat_summary(aes(group=Substrat, color=Substrat), fun = "mean", geom = "line")+
  # stat_summary(aes(group=Substrat, color=Substrat), fun.data = "mean_cl_normal", geom = "errorbar", width = .2) +
  labs(title = "", x = "Time(hours)", y = "Copies/gr;Copies/ml" ) +     
  facet_wrap(~ Organism, ncol = 1,  strip.position = "right") +
  scale_fill_brewer(palette="RdGy")+
  theme(
    #strip.background = element_rect((fill = brewer.pal(9, "Set1"))),
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position  = "none",
    panel.background = element_rect(fill = "white"),
    #panel.grid.major = element_line(color = "black",linetype = "dotted" ),
    #panel.grid.minor = element_line(color = "darkgray",linetype = "dashed" ),
    #panel.grid.major.x = element_line(color = "darkgreen")
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(-5, NA)) +
  expand_limits(x = 0, y = -5) 

# Save
  saveMyPlot(p1, "Accu_CopyNumbersMeanByAllGroup.png", isSaveOn)
# View
showMePlot(p1, showPlot)

ggplot(data_group, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a",outlier.size=3, outlier.shape=10, outlier.color="red")  +
  geom_point(aes(color=OrderByTime))+
  stat_summary(aes(group = Substrat), fun = "mean", 
               fun.max = function(x) mean(x) + sd(x), 
               fun.min = function(x) mean(x) - sd(x), 
               geom = "point", size = 1, position = position_dodge(width = 0.75)) +
  labs(title = "", x = "Time(hours)", y = "Copies/ml                        Copies/gr          Copies/ml             Copies/gr" ) +     
  facet_wrap(~Organism+ Substrat, ncol = 1, strip.position = "right", scales = "free_y") +
  scale_fill_brewer(palette = "Paired") +
  theme(
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position = "none",
    panel.background = element_rect(fill = "white"),
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(-5, NA)) +
  expand_limits(x = 0, y = -5)+
  scale_y_continuous(labels = scales::scientific_format(digits = 2))

#------------Copy Numbers----
egeriaSediment<-dataAccuEgeria%>% filter(Substrat=="Sediment")

e1<-ggplot(egeriaSediment, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a", outlier.size = 3, outlier.shape = 10, outlier.color = "red") +
  geom_point() +
  labs(title = "", x = "Time(hours)", y = "Copies/gr") +     
  facet_wrap(~Organism + Substrat, ncol = 1, strip.position = "top", scales = "free_y") +
  scale_fill_brewer(palette = "Paired") +
  theme(
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position = "none",
    panel.background = element_rect(fill = "white"),
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(0, NA)) +
  expand_limits(x = 0, y = 0) +
  scale_y_continuous(labels = scales::scientific_format(digits = 2), 
                     breaks = seq(0, max(egeriaSediment$mean), by = 100000), 
                     minor_breaks = seq(0, max(egeriaSediment$mean), by = 10000))

egeriaWater<-dataAccuEgeria%>% filter(Substrat=="Water")

e2<-ggplot(egeriaWater, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a", outlier.size = 3, outlier.shape = 10, outlier.color = "red") +
  geom_point() +
  labs(title = "", x = "Time(hours)", y = "Copies/ml") +     
  facet_wrap(~Organism + Substrat, ncol = 1, strip.position = "top", scales = "free_y") +
  scale_fill_brewer(palette = "Paired") +
  theme(
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position = "none",
    panel.background = element_rect(fill = "white"),
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(0, NA)) +
  expand_limits(x = 0, y = 0) +
  scale_y_continuous(labels = scales::scientific_format(digits = 2), 
                     breaks = seq(0, max(egeriaWater$mean), by = 100000), 
                     minor_breaks = seq(0, max(egeriaWater$mean), by = 10000))

common_title <- ggplot() + 
  labs(title = "E.densa By Copy Numbers") +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))

eger<-grid.arrange(
  common_title,
  arrangeGrob(e1, e2, ncol=2, widths = c(4, 4)),
  heights = c(0.5, 4))


# Save
saveMyPlot(eger, "AccuEgeria_CopyNumbers_Sedimentwater.png", isSaveOn)
# View
showMePlot(eger, showPlot)


daphniaSedimet<-dataAccuDaphnia%>% filter(Substrat=="Sediment")
d1<-ggplot(daphniaSedimet, aes(x = factor(Time), y = mean$y)) + 
   geom_boxplot(aes(fill = Substrat), color = "#b39b9a", outlier.size = 3, outlier.shape = 10, outlier.color = "red") +
  geom_point() +
  labs(title = "", x = "Time(hours)", y = "Copies/gr") +     
  facet_wrap(~Organism + Substrat, ncol = 1, strip.position = "top", scales = "free_y") +
  scale_fill_brewer(palette = "Paired") +
  theme(
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position = "none",
    panel.background = element_rect(fill = "white"),
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(0, NA)) +
  expand_limits(x = 0, y = 0) +
  scale_y_continuous(labels = scales::scientific_format(digits = 2))


daphniaWater<-dataAccuDaphnia %>% filter(Substrat=="Water")
d2<-ggplot(daphniaWater, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a", outlier.size = 3, outlier.shape = 10, outlier.color = "red") +
  geom_point() +
  labs(title = "", x = "Time(hours)", y = " Copies/ml") +     
  facet_wrap(~Organism + Substrat, ncol = 1, strip.position = "top", scales = "free_y") +
  scale_fill_brewer(palette = "Paired") +
  theme(
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position = "none",
    panel.background = element_rect(fill = "white"),
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(0, NA)) +
  expand_limits(x = 0, y = 0) +
  scale_y_continuous(labels = scales::scientific_format(digits = 2))                     


common_title <- ggplot() + 
  labs(title = "D.magna By Copy Numbers") +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))

dap<-grid.arrange(
  common_title,
  arrangeGrob(d1, d2, ncol=2, widths = c(4, 4)),
  heights = c(0.5, 4))

# Save
saveMyPlot(dap, "AccuDaphnia_CopyNumber_SedimentWater.png", isSaveOn)
# View
showMePlot(dap, showPlot)



#-------------Loged----
egeriaSediment<-dataAccuEgeriaLoged%>% filter(Substrat=="Sediment")

e1<-ggplot(egeriaSediment, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a", outlier.size = 3, outlier.shape = 10, outlier.color = "red") +
  geom_point() +
  labs(title = "", x = "Time(hours)", y = "Copies/gr") +     
  facet_wrap(~Organism + Substrat, ncol = 1, strip.position = "top", scales = "free_y") +
  scale_fill_brewer(palette = "Paired") +
  theme(
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position = "none",
    panel.background = element_rect(fill = "white"),
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(0, NA)) +
  expand_limits(x = 0, y = 0) +
  scale_y_continuous(labels = scales::scientific_format(digits = 2), 
                     breaks = seq(0, max(egeriaSediment$mean), by = 1), 
                     minor_breaks = seq(0, max(egeriaSediment$mean), by = 0.5))

egeriaWater<-dataAccuEgeriaLoged%>% filter(Substrat=="Water")

e2<-ggplot(egeriaWater, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a", outlier.size = 3, outlier.shape = 10, outlier.color = "red") +
  geom_point() +
  labs(title = "", x = "Time(hours)", y = "Copies/ml") +     
  facet_wrap(~Organism + Substrat, ncol = 1, strip.position = "top", scales = "free_y") +
  scale_fill_brewer(palette = "Paired") +
  theme(
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position = "none",
    panel.background = element_rect(fill = "white"),
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(0, NA)) +
  expand_limits(x = 0, y = 0) +
  scale_y_continuous(labels = scales::scientific_format(digits = 2), 
                     breaks = seq(0, max(egeriaWater$mean), by = 1), 
                     minor_breaks = seq(0, max(egeriaWater$mean), by = 0.5))

common_title <- ggplot() + 
  labs(title = "E.densa By Loged Copy Numbers") +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))

eger<-grid.arrange(
  common_title,
  arrangeGrob(e1, e2, ncol=2, widths = c(4, 4)),
  heights = c(0.5, 4))

# Save
saveMyPlot(eger, "AccuEgeria_CopyNumbersLoged_Sedimentwater.png", isSaveOn)
# View
showMePlot(eger, showPlot)


daphniaSedimet<-dataAccuDaphniaLoged%>% filter(Substrat=="Sediment")
d1<-ggplot(daphniaSedimet, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a", outlier.size = 3, outlier.shape = 10, outlier.color = "red") +
  geom_point() +
  labs(title = "", x = "Time(hours)", y = "Copies/gr") +     
  facet_wrap(~Organism + Substrat, ncol = 1, strip.position = "top", scales = "free_y") +
  scale_fill_brewer(palette = "Paired") +
  theme(
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position = "none",
    panel.background = element_rect(fill = "white"),
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(0, NA)) +
  expand_limits(x = 0, y = 0) +
  scale_y_continuous(labels = scales::scientific_format(digits = 2))


daphniaWater<-dataAccuDaphniaLoged %>% filter(Substrat=="Water")
d2<-ggplot(daphniaWater, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a", outlier.size = 3, outlier.shape = 10, outlier.color = "red") +
  geom_point() +
  labs(title = "", x = "Time(hours)", y = " Copies/ml") +     
  facet_wrap(~Organism + Substrat, ncol = 1, strip.position = "top", scales = "free_y") +
  scale_fill_brewer(palette = "Paired") +
  theme(
    strip.background.y = element_blank(),
    strip.text = element_text(color = "black", size = 10, face = "bold"),
    legend.position = "none",
    panel.background = element_rect(fill = "white"),
    axis.title = element_text(color = "black"), 
    axis.line = element_line(color = "black"), 
    axis.text = element_text(color = "black"), 
    axis.ticks = element_line(color = "black")
  ) +
  coord_cartesian(xlim = c(1, NA), ylim = c(0, NA)) +
  expand_limits(x = 0, y = 0) +
  scale_y_continuous(labels = scales::scientific_format(digits = 2))                     


common_title <- ggplot() + 
  labs(title = "D.magna By Loged Copy Numbers") +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))

dap<-grid.arrange(
  common_title,
  arrangeGrob(d1, d2, ncol=2, widths = c(4, 4)),
  heights = c(0.5, 4))

# Save
saveMyPlot(dap, "AccuDaphnia_CopyNumberLoged_SedimentWater.png", isSaveOn)
# View
showMePlot(dap, showPlot)


#-------------All Group by Substrate Type----
p3<-ggplot(data_groupSubstrat, aes(x = factor(Time), y = mean$y)) +
  geom_boxplot(aes(fill = Organism), color = "#b39b9a")  +
  #scale_x_discrete(limits = c(0,168)) +
  labs(title = "", x = "Time(hours)", y = "Copies/gr;Copies/ml") +
  facet_wrap(~ Substrat, ncol = 1,  strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))),strip.text = element_text(color = "white", size = 10, face = "bold"),
        legend.position = "bottom")
# Save
saveMyPlot(p3, "Accu_LogedCopyNumbersMeanBySubstrat.png", isSaveOn)
# View
showMePlot(p3, showPlot)


#-------------Only Egeria----
p2<-ggplot(dataAccuEgeria, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(fill = "lightblue", color = c("#b39b9a"))  +
  # scale_x_continuous(labels = scales::scientific, breaks = scales::pretty_breaks(n = 10)) +
  #scale_y_continuous(labels = scales::comma) +
  labs(title = "", x = "Time(hours)", y = "Copies/gr;Copies/ml") +     
  facet_wrap(~ Organism + Substrat, ncol = 1, scales = "fixed", strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))),
        strip.text = element_text(color = "white", size = 10, face = "bold"))
# Save
saveMyPlot(p2, "Accu_CopyNumbersMeanByOnlyEgeria.png", isSaveOn)
# View
showMePlot(p2, showPlot)

#-------------Only Daphnia----
q2<-ggplot(dataAccuDaphnia, aes(x = factor(Time), y = mean$y)) + 
  geom_boxplot(fill = "lightblue", color = c("#b39b9a"))  +
  # scale_x_continuous(labels = scales::scientific, breaks = scales::pretty_breaks(n = 10)) +
  #scale_y_continuous(labels = scales::comma) +
  labs(title = "", x = "Time(hours)", y = "") +     
  facet_wrap(~ Organism + Substrat, ncol = 1, scales = "fixed", strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))),
        strip.text = element_text(color = "white", size = 10, face = "bold"))
# Save
saveMyPlot(q2, "Accu_CopyNumbersMeanByOnlyDaphnia.png", isSaveOn)
# View
showMePlot(q2, showPlot)

#--------------------View plots at the same screen-p2-q2----
#c1<-grid.arrange(p2,q2,ncol=2)
# Common Title
common_title <- ggplot() + 
  labs(title = "My common title") +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))

# Add Common Title to Graphic
c1<-grid.arrange(
  common_title,
  arrangeGrob(p2, q2, ncol=2, widths = c(4, 4)),
  heights = c(0.5, 4))
# Save
saveMyPlot(c1, "Accu_CopyNumbersMean.png", isSaveOn)
# View
showMePlot(c1, showPlot)

#-------------Lineer Moddel Curve----
p4<-ggplot(EgeriaDaphniaLogedAccuFiltered, aes(x = factor(Time), y = CopyNumberLoged)) +
  geom_point(aes(color=Substrat)) +
  scale_y_continuous(labels = scales::comma) +
  facet_grid(~Organism + ., scales = "free_y", switch = "x") +
  labs(title = "", x = "Time(Hours)", y = "Log10((DNACopies/g+1))") +
  theme(strip.background = element_rect(fill = brewer.pal(6, "Set1")),
        strip.text = element_text(color = "white", size = 10, face = "bold"),legend.position="bottom") +
  geom_smooth(aes(group = interaction(Substrat), color=Substrat), method = "lm")
# Save
saveMyPlot(p4, "Accu_LogedCopyNumbersbyOrganisms.png", isSaveOn)
# View
showMePlot(p4, showPlot)

p5<-ggplot(EgeriaDaphniaCopyNumberAccuFiltered, aes(x = factor(Time), y = CopyNumberSelected)) +
  geom_point(aes(color=Substrat)) +
  scale_y_continuous(labels = scales::comma) +
  facet_grid(~Organism + ., scales = "free_y", switch = "x") +
  labs(title = "", x = "Time(Hours)", y = "DNACopies/g") +
  theme(strip.background = element_rect(fill = brewer.pal(6, "Set1")),
        strip.text = element_text(color = "white", size = 10, face = "bold"),legend.position="bottom") +
  geom_smooth(aes(group = interaction(Substrat), color=Substrat), method = "lm")
# Save
saveMyPlot(p5, "Accu_CopyNumbersbyOrganisms.png", isSaveOn)
# View
showMePlot(p5, showPlot)

common_title <- ggplot() + 
  labs(title = "Loged(DNACopies/g+1)-DNACopies/g") +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))

# Add Common Title to Graphic
c2<-grid.arrange(
  common_title,
  arrangeGrob(p4, p5, ncol=2, widths = c(4, 4)),
  heights = c(0.5, 4))

# Save
saveMyPlot(c2, "Accu_CopyNumbersLineerCurve.png", isSaveOn)
# View
showMePlot(c2, showPlot)

#-----------Shedding----  
dataShedding<-ImportExcel(selectedFile,"Shedding",xrange = "A1:C241")
dataSheddingGrouped<- dataMeanGroupBy(dataShedding, c(2,1),"Value")

s1<-ggplot(dataShedding, aes(x = factor(Group), y = Value)) + 
  geom_boxplot(aes(group=Group), fill = "lightblue", color = c("#b39b9a"))  +
  labs(title = "", x = "Groups", y = "Value") +     
  # facet_wrap(~ Group, ncol = 1, scales = "fixed", strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))),
        strip.text = element_text(color = "white", size = 10, face = "bold"))+
  coord_cartesian(xlim = c(1, NA), ylim = c(0, 0.18)) +
  expand_limits(x = 0, y = 0)




message("\nAccu Run Finished \n" )
sink()
close(file_conn)