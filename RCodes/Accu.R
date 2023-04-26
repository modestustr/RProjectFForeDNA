#-------------USINGS----
source("RCodes/usings.R")

#-------------Open File, Move to Data Folder and import data set from excel or csv file by getDataFileName Function----
selectedFile<-getDataFileName()
EgeriaDaphniaAccu <- ImportExcel(selectedFile,"EgeriaDaphniaAccu","A1:J257", na="na")
EgeriaDaphniaAccuFiltered<- EgeriaDaphniaAccu %>% filter(CopyNumberLoged!="", !is.na(CopyNumberLoged))
col_names<-colnames(EgeriaDaphniaAccuFiltered)
col_names
#-------------Mean by groups----
data_group <- dataMeanGroupBy(EgeriaDaphniaAccuFiltered, c(3, 4, 1, 2), "CopyNumberLoged", TRUE)
#-------------Mean by groups----
data_groupSubstrat <-dataMeanGroupBy(EgeriaDaphniaAccuFiltered, c(4,1,2,3),"CopyNumberLoged",TRUE)

#-------------Filters----
# Filter for Egeria
dataAccuEgeria <- filter(data_group, Organism == "E.densa")
# dataAccuEgeria <- dataAccuEgeria %>%
#   mutate(Organism = if_else(Organism == "Egeria", "E.densa", Organism))

# Filter for Daphnia
dataAccuDaphnia <- filter(data_group, Organism == "D.magna")
# dataAccuDaphnia <- dataAccuDaphnia %>%
#   mutate(Organism = if_else(Organism == "Daphnia", "D.magna", Organism))
#-------------Show Plots in Plot Window----
showPlot<-TRUE
# Save is On/Off
isSaveOn<-TRUE
#-------------All Group by Organism and Substrate Type----
p1<-ggplot(data_group, aes(x = factor(Time), y = mean_copy)) + 
  #geom_boxplot(aes(fill = Substrat), color = "#b39b9a")  +
  #stat_summary(fun = mean, geom = "pointrange", fun.max = function(x) mean(x) + sd(x),               fun.min = function(x) mean(x) - sd(x)) +
  #stat_summary(fun = "mean", geom = "bar", alpha = .7) +
  stat_summary(aes(group=Substrat), fun = "mean", geom = "point", size = 1) +
  stat_summary(aes(group=Substrat, color=Substrat), fun = "mean", geom = "line")+
  stat_summary(aes(group=Substrat, color=Substrat), fun.data = "mean_cl_normal", geom = "errorbar", width = .2) +
  labs(title = "", x = "Time(hours)", y = "Copies/gr;Copies/ml" ) +     
  facet_wrap(~ Organism, ncol = 1,  strip.position = "right") +
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
if(isSaveOn)
  plotSave(p1, "Accu_CopyNumbersMeanByAllGroup.png")
# View
if(showPlot)
  p1
#-------------All Group by Substrate Type----
p3<-ggplot(data_groupSubstrat, aes(x = factor(Time), y = mean_copy)) + 
  geom_boxplot(aes(fill = Organism), color = "#b39b9a")  +
  #scale_x_discrete(limits = c(0,168)) +
  labs(title = "", x = "Time(hours)", y = "Copies/gr;Copies/ml") +     
  facet_wrap(~ Substrat, ncol = 1,  strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))),strip.text = element_text(color = "white", size = 10, face = "bold"),
        legend.position = "bottom")
# Save
if(isSaveOn)
  plotSave(p3, "Accu_CopyNumbersMeanBySubstrat.png")
# View
if(showPlot)
  p3
#-------------Only Egeria----
p2<-ggplot(dataAccuEgeria, aes(x = factor(Time), y = mean_copy)) + 
  geom_boxplot(fill = "lightblue", color = c("#b39b9a"))  +
  # scale_x_continuous(labels = scales::scientific, breaks = scales::pretty_breaks(n = 10)) +
  #scale_y_continuous(labels = scales::comma) +
  labs(title = "", x = "Time(hours)", y = "Copies/gr;Copies/ml") +     
  facet_wrap(~ Organism + Substrat, ncol = 1, scales = "fixed", strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))),
        strip.text = element_text(color = "white", size = 10, face = "bold"))
# Save
if(isSaveOn)
  plotSave(p2, "Accu_CopyNumbersMeanByOnlyEgeria.png")
# View
p2
#-------------Only Daphnia----
q2<-ggplot(dataAccuDaphnia, aes(x = factor(Time), y = mean_copy)) + 
  geom_boxplot(fill = "lightblue", color = c("#b39b9a"))  +
  # scale_x_continuous(labels = scales::scientific, breaks = scales::pretty_breaks(n = 10)) +
  #scale_y_continuous(labels = scales::comma) +
  labs(title = "", x = "Time(hours)", y = "") +     
  facet_wrap(~ Organism + Substrat, ncol = 1, scales = "fixed", strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))),
        strip.text = element_text(color = "white", size = 10, face = "bold"))
# Save
if(isSaveOn)
  plotSave(q2, "Accu_CopyNumbersMeanByOnlyDaphnia.png")
# View
q2
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

if(showPlot)
  c1
if(isSaveOn)
  plotSave(c1,"Accu_CopyNumbersMean.png")

cat("\nAccu Run Finished \n" )