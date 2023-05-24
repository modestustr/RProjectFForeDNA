library(dada2)
source("~/eDNA_RProject/RCodes/filterTrimForDada2.R")
#-----------Single File------------

fnF1<- "data/miSeq/C/C01_S58_L001_R1_001.fastq"
fnR1<- "data/miSeq/C/C01_S58_L001_R2_001.fastq"

plotQualityProfile(fnF1)
plotQualityProfile(fnR1)


trimmedFiles<-filterTrimForDada2(fnF1,fnR1, truncLen = c(300,270))

fnF_Trimmed<-trimmedFiles[1]
fnR_Trimmed<-trimmedFiles[2]

plotQualityProfile(fnF_Trimmed)
plotQualityProfile(fnR_Trimmed)

# -----------Batch------------------------------------------
data<- "data/miSeq/C"
list.files(data)
dataF<- sort(list.files(data, pattern = "_R1_001.fastq", full.names = TRUE))
dataR<- sort(list.files(data, pattern = "_R2_001.fastq", full.names = TRUE))

list.sample.names<- sapply(strsplit(basename(dataF),"_"), '[',1)
list.sample.names

# plotQualityProfile(dataF[1:6])
# plotQualityProfile(dataR[1:6])


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
    truncLen = c(300, 280),
    maxN = 0,
    maxEE = c(2, 2),
    truncQ = 2,
    rm.phix = TRUE,
    compress = TRUE,
    multithread = FALSE
  )

errF<-learnErrors(filT.dataF)
errR<-learnErrors(filT.dataR)

plotErrors(errR,nti = c("A", "C", "G", "T"), ntj = c("A", "C", "G", "T"), obs = TRUE, err_out = TRUE, err_in = FALSE, nominalQ = TRUE)
# plotErrors(errR, nominalQ = TRUE)


dadaFs <- dada(filT.dataF, err=errF, multithread=TRUE)
dadaRs <- dada(filT.dataR, err=errR, multithread=TRUE)

mergers <- mergePairs(dadaFs, filT.dataF, dadaRs, filT.dataR, verbose=TRUE)
# Inspect the merger data.frame from the first sample
head(mergers[[1]])



# Create empty List
merged_data <- list()

#  Add each dataframe to end of the list
for (i in 1:length(mergers)) {
  root       = mergers[[i]]
  station    = strsplit((names(mergers)[i]), "_")[[1]][1]
  seq        = root[["sequence"]]
  abundance  = root[["abundance"]]
  forward    = root[["forward"]]
  reverse    = root[["reverse"]]
  nmatch     = root[["nmatch"]]
  nmismatch  = root[["nmismatch"]]
  nindel     = root[["nindel"]]
  prefer     = root[["prefer"]]
  accept     = root[["accept"]]
  
  merged_data[[i]] <- data.frame(
    station    = station,
    sequence   = seq,
    abundance  = abundance,
    forward    = forward,
    reverse    = reverse,
    nmatch     = nmatch,
    nmismatch  = nmismatch,
    nindel     = nindel,
    prefer     = prefer,
    accept     = accept
  )
}

# Merge All dataframes
dfMerge <- do.call(rbind, merged_data)
# Export Excel
write.xlsx(dfMerge, file = "data/output/seqtab_excel.xlsx", sheetName = "Sequences")

seqtab <- makeSequenceTable(mergers)
dim(seqtab)

# Inspect distribution of sequence lengths
table(nchar(getSequences(seqtab)))

#------Remove chimeras
mergers.nochim <- removeBimeraDenovo(mergers, multithread = FALSE, verbose = TRUE)

# Create empty List
merged_data <- list()

removed<-mergers.nochim
#  Add each dataframe to end of the list
for (i in 1:length(removed)) {
  root       = removed[[i]]
  station    = strsplit((names(removed)[i]), "_")[[1]][1]
  seq        = root[["sequence"]]
  abundance  = root[["abundance"]]
  forward    = root[["forward"]]
  reverse    = root[["reverse"]]
  nmatch     = root[["nmatch"]]
  nmismatch  = root[["nmismatch"]]
  nindel     = root[["nindel"]]
  prefer     = root[["prefer"]]
  accept     = root[["accept"]]
  
  merged_data[[i]] <- data.frame(
    station    = station,
    sequence   = seq,
    abundance  = abundance,
    forward    = forward,
    reverse    = reverse,
    nmatch     = nmatch,
    nmismatch  = nmismatch,
    nindel     = nindel,
    prefer     = prefer,
    accept     = accept
  )
}

# Merge All dataframes
dfMergeRemoved <- do.call(rbind, merged_data)
# Export Excel
write.xlsx(dfMergeRemoved, file = "data/output/nochimera_excel.xlsx", sheetName = "Sequences")



seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", multithread=TRUE, verbose=TRUE)
dim(seqtab.nochim)

sum(seqtab.nochim)/sum(seqtab)


getN <- function(x) sum(getUniques(x))
track <- cbind(out, sapply(dadaFs, getN), sapply(dadaRs, getN), sapply(mergers, getN), rowSums(seqtab.nochim))
# If processing a single sample, remove the sapply calls: e.g. replace sapply(dadaFs, getN) with getN(dadaFs)
colnames(track) <- c("input", "filtered", "denoisedF", "denoisedR", "merged", "nonchim")
rownames(track) <- list.sample.names
head(track)

taxa <- assignTaxonomy(seqtab.nochim, "data/taxa.gz", multithread=TRUE)

taxa <- addSpecies(taxa, "~/tax/silva_species_assignment_v132.fa.gz")

taxa.print <- taxa # Removing sequence rownames for display only
rownames(taxa.print) <- NULL
head(taxa.print)



## [1] '2.14.0'
dna <- DNAStringSet(getSequences(seqtab.nochim)) # Create a DNAStringSet from the ASVs
load("~/tax/IDTaxa/SILVA_SSU_r132_March2018.RData") # CHANGE TO THE PATH OF YOUR TRAINING SET
ids <- IdTaxa(dna, trainingSet, strand="top", processors=NULL, verbose=FALSE) # use all processors
ranks <- c("domain", "phylum", "class", "order", "family", "genus", "species") # ranks of interest
# Convert the output object of class "Taxa" to a matrix analogous to the output from assignTaxonomy
taxid <- t(sapply(ids, function(x) {
  m <- match(ranks, x$rank)
  taxa <- x$taxon[m]
  taxa[startsWith(taxa, "unclassified_")] <- NA
  taxa
}))
colnames(taxid) <- ranks; rownames(taxid) <- getSequences(seqtab.nochim)







# Big Data Parsing
# Filename parsing
path <- "data/miSeq" # CHANGE ME to the directory containing your demultiplexed fastq files
filtpath <- file.path(path, "filtered") # Filtered files go into the filtered/ subdirectory
fns <- list.files(path, pattern="fastq.gz") # CHANGE if different file extensions
# Filtering
filterAndTrim(file.path(path,fns), file.path(filtpath,fns), 
              truncLen=c(300,295), maxEE=1, truncQ=11, rm.phix=TRUE,
              compress=TRUE, verbose=TRUE, multithread=TRUE)

# File parsing
filtpath <- "path/to/FWD/filtered" # CHANGE ME to the directory containing your filtered fastq files
filts <- list.files(filtpath, pattern="fastq.gz", full.names=TRUE) # CHANGE if different file extensions
sample.names <- sapply(strsplit(basename(filts), "_"), `[`, 1) # Assumes filename = sample_XXX.fastq.gz
names(filts) <- sample.names
# Learn error rates
set.seed(100)
err <- learnErrors(filts, nbases = 1e8, multithread=TRUE, randomize=TRUE)
# Infer sequence variants
dds <- vector("list", length(sample.names))
names(dds) <- sample.names
for(sam in sample.names) {
  cat("Processing:", sam, "\n")
  derep <- derepFastq(filts[[sam]])
  dds[[sam]] <- dada(derep, err=err, multithread=TRUE)
}

df<-data.frame(sequence=character(),abundance=numeric(), stringsAsFactors = FALSE)

for (i in 1:length(dds)) {
  seq <- dds[[i]][["clustering"]][["sequence"]]
  abundance <- dds[[i]][["clustering"]][["abundance"]]
  df <- rbind(df, data.frame(sequence = seq, abundance = abundance))
}

