fnF1<- "data/5_S5_L001_R1_001.fastq.gz"
fnR1<- "data/5_S5_L001_R2_001.fastq.gz"

plotQualityProfile(fnF1)
plotQualityProfile(fnR1)


filterTrimForDada2(fnF1,fnR1, truncLen = c(270,210))

fnF_Trimmed<-"data/5F_4a84c2357d6.fastq.gz"
fnR_Trimmed<-"data/5R_4a842e441334.fastq.gz"

plotQualityProfile(fnF_Trimmed)
plotQualityProfile(fnR_Trimmed)
