#-------------CALLING CUSTOM FUNCS----
source("RCodes/usings.R")
source("RCodes/plotSave.R")
source("RCodes/ImportExcel.R")
#-------------import data set from excel file in data folder----
EgeriaDaphniaDegra <- ImportExcel("data/Daphnia_Egeria_raw data.xlsx","EgeriaDaphniaDegraCombinedCorr","A1:K1405",na="NA")
# Filter by Empty and NOT NA
EgeriaDaphniaDegraFiltered<- EgeriaDaphniaDegra %>% filter(CopyNumberLoged!="", !is.na(CopyNumberLoged))
#-------------Mean by groups----
data_group <- EgeriaDaphniaDegraFiltered %>%
  group_by(Organism, Substrat, Set, Sample, Time) %>%
  summarize(mean_copy = mean(CopyNumberLoged,na.rm = TRUE))
#-------------Filters----
# Filter for Egeria
dataDegraEgeria <- filter(data_group, Organism == "Egeria")
dataDegraEgeria <- dataDegraEgeria %>%
  mutate(Organism = if_else(Organism == "Egeria", "E.densa", Organism))

# Filter for Daphnia 
dataDegraDaphnia <- filter(data_group, Organism == "Daphnia")
dataDegraDaphnia <- dataDegraDaphnia %>%
  mutate(Organism = if_else(Organism == "Daphnia", "D.magna", Organism))
# Show Plots in Plot Window
showPlot<-TRUE
# Save is On/Off
isSaveOn<-FALSE
#-------------All Group by Organism and Substrate Type----
p1 <- ggplot(data_group, aes(x = factor(Time), y = mean_copy)) +
  geom_boxplot() +
  # geom_boxplot(fill = "lightblue", color = c("#b39b9a")) +
  # scale_x_continuous(labels = scales::scientific, breaks = scales::pretty_breaks(n = 10)) +
  #scale_y_continuous(labels = scales::comma) +
  scale_fill_viridis(discrete = TRUE, alpha=0.9) +
  labs(title = "Organism and Substrate", x = "Time", y = "Copy Numbers Mean") +
  facet_wrap(~Organism + Substrat, ncol = 1, scales = "free_y", strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))), strip.text = element_text(color = "white", size = 10, face = "bold"))
# Save
if(isSaveOn)
plotSave(p1, "CopyNumbersMeanByAllGroup.png")
# View
if(showPlot)
  p1

#-------------Only Egeria----
p2 <- ggplot(dataDegraEgeria, aes(x = factor(Time), y = mean_copy)) +
  geom_boxplot(fill = "lightblue", color = c("#b39b9a")) +
  # scale_x_continuous(labels = scales::scientific, breaks = scales::pretty_breaks(n = 10)) +
  #scale_y_continuous(labels = scales::comma) +
  labs(title = "Organism and Substrate", x = "Time", y = "Copy Numbers Mean") +
  facet_wrap(~Organism + Substrat, ncol = 1, scales = "free_y", strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))), strip.text = element_text(color = "white", size = 10, face = "bold"))
# Save
if(isSaveOn)
plotSave(p2, "Degra_CopyNumbersMeanByOnlyEgeria.png")
# View 
if(showPlot)
  p2

#-------------Only Daphnia----
q2 <- ggplot(dataDegraDaphnia, aes(x = factor(Time), y = mean_copy)) +
  geom_boxplot(fill = "lightblue", color = c("#b39b9a")) +
  # scale_x_continuous(labels = scales::scientific, breaks = scales::pretty_breaks(n = 10)) +
  #scale_y_continuous(labels = scales::comma) +
  labs(title = "Organism and Substrate", x = "Time", y = "Copy Numbers Mean") +
  facet_wrap(~Organism + Substrat, ncol = 1, scales = "free_y", strip.position = "right") +
  theme(strip.background = element_rect((fill = brewer.pal(6, "Set1"))), strip.text = element_text(color = "white", size = 10, face = "bold"))
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
p3 <- ggplot(dataDegraEgeria, aes(x = factor(Time), y = mean_copy, group = interaction(Organism, Substrat, Set))) +
  geom_point() +
  #geom_boxplot(fill = "lightblue", color = c("#b39b9a"))  +
  scale_y_continuous(labels = scales::comma) +
  facet_grid(Organism + Substrat ~ Set + ., scales = "free_y", switch = "x") +
  labs(title = "Organism and Substrate", x = "Time(Hours)", y = "Copy Numbers Mean") +
  theme(strip.background = element_rect(fill = brewer.pal(6, "Set1")),
        strip.text = element_text(color = "white", size = 10, face = "bold")) +
  geom_smooth(aes(group = interaction(Organism, Substrat, Set)), method = "lm")
# Save
if(isSaveOn)
plotSave(p3, "Degra_AddLMCurveForEgeria.png")
# View
if(showPlot)
  p3


# For Daphnia
q3 <- ggplot(dataDegraDaphnia, aes(x = factor(Time), y = mean_copy, group = interaction(Organism, Substrat, Set))) +
  geom_point() +
  #geom_boxplot(fill = "lightblue", color = c("#b39b9a"))  +
  scale_y_continuous(labels = scales::comma) +
  facet_grid(Organism + Substrat ~ Set + ., scales = "free_y", switch = "x") +
  labs(title = "Organism and Substrate", x = "Time(Hours)", y = "Copy Numbers Mean") +
  theme(strip.background = element_rect(fill = brewer.pal(6, "Set1")),
        strip.text = element_text(color = "white", size = 10, face = "bold")) +
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
p4 <- ggplot(dataDegraEgeria, aes(x = factor(Time), y = mean_copy, color = Set)) +
  geom_boxplot() +
  scale_y_continuous(labels = scales::comma) +
  facet_wrap(Organism + Substrat ~ ., scales = "free_y", strip.position = "top") +
  labs(title = "Organism and Substrate", x = "Time(Hours) and Set", y = "Copy Numbers Mean") +
  theme(
    strip.background = element_rect(fill = brewer.pal(9, "Set1")),
    #strip.text = element_text(color = "white",size = 0, face = "bold.italic"),
    axis.text.x = element_text(angle = 0, vjust = 0.5),
    axis.title.x = element_text(vjust = -0.5),
    panel.spacing.x = unit(0.5, "lines")
  )
# Save
if(isSaveOn)
plotSave(p4, "Degra_CopyNumbersMeanByTimeSetsForEgeria.png")
# view
if(showPlot)
  p4

# Only Daphnia By Time and Set
q4 <- ggplot(dataDegraDaphnia, aes(x = factor(Time), y = mean_copy, color = Set)) +
  geom_boxplot() +
  scale_y_continuous(labels = scales::comma) +
  facet_wrap(Organism + Substrat ~ ., scales = "free_y", strip.position = "top") +
  labs(title = "Organism and Substrate", x = "Time(Hours) and Set", y = "Copy Numbers Mean") +
  theme(
    strip.background = element_rect(fill = brewer.pal(9, "Set1")),
    #strip.text = element_text(color = "white",size = 0, face = "bold.italic"),
    axis.text.x = element_text(angle = 90, vjust = 0.5),
    axis.title.x = element_text(vjust = -0.5),
    panel.spacing.x = unit(0.5, "lines")
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
# Only Egeria 
p5 <- ggplot(dataDegraEgeria, aes(x = factor(Time), y = mean_copy)) +
  geom_boxplot(fill = "lightblue", color = c("#b39b9a")) +
  scale_y_continuous(labels = scales::comma) +
  facet_grid(Organism + Substrat ~ Set + ., scales = "free_y", switch = "x") +
  labs(title = "Organism and Substrate", x = "Time(Hours)", y = "Copy Numbers Mean") +
  theme(strip.background = element_rect(fill = brewer.pal(6, "Set1")),
        strip.text = element_text(color = "white", size = 10, face = "bold"),
        axis.text.x = element_text(angle = 90, vjust = 0.5),
        axis.title.x = element_text(vjust = -0.5),
        panel.spacing.x = unit(0.5, "lines"))

# Save
if(isSaveOn)
plotSave(p5, "Degra_CopyNumbersMeanBySetsForEgeria.png")
# view
if(showPlot)
  p5


# Only Daphnia By Sets
q5 <- ggplot(dataDegraDaphnia, aes(x = factor(Time), y = mean_copy)) +
  geom_boxplot(fill = "lightblue", color = c("#b39b9a")) +
  scale_y_continuous(labels = scales::comma) +
  facet_grid(Organism + Substrat ~ Set + ., scales = "free_y", switch = "x") +
  labs(title = "Organism and Substrate", x = "Time(Hours)", y = "Copy Numbers Mean") +
  theme(strip.background = element_rect(fill = brewer.pal(6, "Set1")),
        strip.text = element_text(color = "white", size = 10, face = "bold"),
        axis.text.x = element_text(angle = 90, vjust = 0.5),
        axis.title.x = element_text(vjust = -0.5),
        panel.spacing.x = unit(0.5, "lines"))

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
cat("\nDegra Run Finished \n" )