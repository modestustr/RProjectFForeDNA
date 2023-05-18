library(dada2)
#-----------Single File------------

fnF1<- "data/C1_S58_L001_R1_001.fastq.gz"
fnR1<- "data/C1_S58_L001_R2_001.fastq.gz"

plotQualityProfile(fnF1)
plotQualityProfile(fnR1)


trimmedFiles<-filterTrimForDada2(fnF1,fnR1, truncLen = c(270,210))

fnF_Trimmed<-trimmedFiles[1]
fnR_Trimmed<-trimmedFiles[2]

plotQualityProfile(fnF_Trimmed)
plotQualityProfile(fnR_Trimmed)

# -----------Batch------------------------------------------
data<- "data/miSeq"
list.files(data)
dataF<- sort(list.files(data, pattern = "_R1_001.fastq", full.names = TRUE))
dataR<- sort(list.files(data, pattern = "_R2_001.fastq", full.names = TRUE))

list.sample.names<- sapply(strsplit(basename(dataF),"_"), '[',1)
list.sample.names

# plotQualityProfile(dataF[1:6])
# plotQualityProfile(dataR[1:6])
# 
# plotQualityProfile(dataF[7:12])
# plotQualityProfile(dataR[7:12])
# 
# plotQualityProfile(dataF[13:18])
# plotQualityProfile(dataR[13:18])
# 
# plotQualityProfile(dataF[19:24])
# plotQualityProfile(dataR[19:24])
# 
# plotQualityProfile(dataF[25:30])
# plotQualityProfile(dataR[25:30])
# 
# plotQualityProfile(dataF[31:36])
# plotQualityProfile(dataR[31:36])
# 
# plotQualityProfile(dataF[37:42])
# plotQualityProfile(dataR[37:42])
# 
# plotQualityProfile(dataF[43:48])
# plotQualityProfile(dataR[43:48])
# 
# plotQualityProfile(dataF[49:53])
# plotQualityProfile(dataR[49:53])
# 
# plotQualityProfile(dataF[54:59])
# plotQualityProfile(dataR[54:59])
# 
# plotQualityProfile(dataF[60:65])
# plotQualityProfile(dataR[60:65])
# 
# plotQualityProfile(dataF[66:71])
# plotQualityProfile(dataR[66:71])
# 
# plotQualityProfile(dataF[72:77])
# plotQualityProfile(dataR[72:77])
# 
# plotQualityProfile(dataF[78:83])
# plotQualityProfile(dataR[78:83])
# 
# plotQualityProfile(dataF[84:89])
# plotQualityProfile(dataR[84:89])
# 
# plotQualityProfile(dataF[90:95])
# plotQualityProfile(dataR[90:95])
# 
# plotQualityProfile(dataF[96:101])
# plotQualityProfile(dataR[96:101])


filT.dataF<-file.path(data,"filtered",paste0(list.sample.names,"_F_filt.fastq.gz"))
filT.dataR<-file.path(data,"filtered",paste0(list.sample.names,"_R_filt.fastq.gz"))
names(filT.dataF)<- list.sample.names
names(filT.dataR)<- list.sample.names

out <-
  filterAndTrim(
    dataF,
    filT.dataF,
    dataR,
    filT.dataR,
    truncLen = c(270, 210),
    maxN = 0,
    maxEE = c(2, 2),
    truncQ = 2,
    rm.phix = TRUE,
    compress = TRUE,
    multithread = FALSE
  )

errF<-learnErrors(filT.dataF)
errR<-learnErrors(filT.dataR)

plotErrors(errF, nominalQ = TRUE)
# plotErrors(errR, nominalQ = TRUE)
