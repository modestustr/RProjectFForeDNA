#-------------CALLING CUSTOM FUNCS----
source("RCodes/usings.R")
source("RCodes/plotSave.R")
source("RCodes/ImportExcel.R")
source("RCodes/getDataFileName.R")
#-------------Open File, Move to Data Folder and import data set from excel or csv file by getDataFileName Function----
selectedFile<-getDataFileName()
EgeriaDaphniaAccu <- ImportExcel(selectedFile,
                                 "EgeriaDaphniaAccu","A1:J257",
                                 na="na")
EgeriaDaphniaAccuFiltered<- EgeriaDaphniaAccu %>% filter(CopyNumberLoged!="", !is.na(CopyNumberLoged))
#-------------Mean by groups----
data_group <- EgeriaDaphniaAccu %>%
  group_by(Organism, Sample, Time,Substrat) %>%
  summarize(mean_copy = mean(CopyNumberLoged))
#-------------Mean by groups----
data_groupSubstrat <- EgeriaDaphniaAccu %>%
  group_by(Substrat,Sample, Time,Organism) %>%
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
showPlot<-TRUE
# Save is On/Off
isSaveOn<-TRUE
#-------------All Group by Organism and Substrate Type----
p1<-ggplot(data_group, aes(x = factor(Time), y = mean_copy)) + 
  geom_boxplot(aes(fill = Substrat), color = "#b39b9a")  +
  labs(title = "", x = "Time(hours)", y = "Copies/gr;Copies/ml") +     
  facet_wrap(~ Organism, ncol = 1,  strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))),strip.text = element_text(color = "white", size = 10, face = "bold"),
        legend.position = "bottom")

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
  labs(title = "", x = "Time(hours)", y = "Copies/gr;Copies/ml") +     
  facet_wrap(~ Organism + Substrat, ncol = 1, scales = "fixed", strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))),
        strip.text = element_text(color = "white", size = 10, face = "bold"))
# Save
if(isSaveOn)
  plotSave(q2, "Accu_CopyNumbersMeanByOnlyDaphnia.png")
# View
q2
#--------------------View plots at the same screen-p2-q2----
c1<-grid.arrange(p2,q2,ncol=2)
if(showPlot)
  c1
if(isSaveOn)
  plotSave(c1,"Accu_CopyNumbersMean.png")

cat("\nAccu Run Finished \n" )