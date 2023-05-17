fnF1<- "data/4_S4_L001_R1_001.fastq.gz"
fnR1<- "data/4_S4_L001_R2_001.fastq.gz"

plotQualityProfile(fnF1)
plotQualityProfile(fnR1)


trimmedFiles<-filterTrimForDada2(fnF1,fnR1, truncLen = c(270,210))

fnF_Trimmed<-trimmedFiles[1]
fnR_Trimmed<-trimmedFiles[2]

plotQualityProfile(fnF_Trimmed)
plotQualityProfile(fnR_Trimmed)
