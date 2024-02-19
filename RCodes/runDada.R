library(dada2); packageVersion("dada2")
source("~/eDNA_RProject/RCodes/filterTrimForDada2.R")
# Filtering
truncLen<-c(260,210)
#-----------Single File------------

fnF1<- "data/miSeq/04_S4_L001_R1_001_trimmed.fastq"
fnR1<- "data/miSeq/04_S4_L001_R2_001_trimmed.fastq"

plotQualityProfile(fnF1)
plotQualityProfile(fnR1)


trimmedFiles<-filterTrimForDada2(fnF1,fnR1, truncLen = c(300,290))

fnF_Trimmed<-trimmedFiles[1]
fnR_Trimmed<-trimmedFiles[2]

plotQualityProfile(fnF_Trimmed)
plotQualityProfile(fnR_Trimmed)

# -----------Batch------------------------------------------
data<- "data/miSeq/C/cutadapt"
list.files(data)
dataF<- sort(list.files(data, pattern = "_R1_001_cutadapt.fastq", full.names = TRUE))
dataR<- sort(list.files(data, pattern = "_R2_001_cutadapt.fastq", full.names = TRUE))

list.sample.names<- sapply(strsplit(basename(dataF),"_"), '[',1)
list.sample.names

# plotQualityProfile(dataF[1:4])
# plotQualityProfile(dataR[1:4])


filT.dataF<-file.path(data,sprintf("filtered/%s", paste(truncLen, collapse = "-")),paste0(list.sample.names,"_F_CA.fastq.gz"))
filT.dataR<-file.path(data,sprintf("filtered/%s", paste(truncLen, collapse = "-")),paste0(list.sample.names,"_R_CA.fastq.gz"))
names(filT.dataF)<- list.sample.names
names(filT.dataR)<- list.sample.names

out <-
  filterAndTrim(
    dataF,
    filT.dataF,
    dataR,
    filT.dataR,
    truncLen = truncLen,
    maxN = 0,
    maxEE = c(2, 2),
    truncQ = 2,
    rm.phix = TRUE,
    compress = TRUE,
    multithread = FALSE,
    verbose = TRUE
  )

errF<-learnErrors(filT.dataF, verbose = TRUE)
errR<-learnErrors(filT.dataR, verbose = TRUE)

plotErrors(errR, nominalQ = TRUE)
# plotErrors(errR, nominalQ = TRUE)


dadaFs <- dada(filT.dataF, err=errF)

# Baslangiç ve bitis zamanlarini tanimla
start_time <- as.POSIXct(Sys.time())
dadaRs <- dada(filT.dataR, err=errR)
end_time <- as.POSIXct(Sys.time())

# Geçen süreyi hesapla
elapsed_time <- difftime(end_time, start_time, units = "secs")

# Dakika ve saniye olarak ayristir
minutes <- as.integer(elapsed_time / 60)
seconds <- as.integer(elapsed_time - minutes * 60)

# Sonucu yazdir
print(paste("Geçen süre:", minutes, "dakika", seconds, "saniye"))


mergers <- mergePairs(dadaFs, filT.dataF, dadaRs, filT.dataR, verbose=TRUE)
# Inspect the merger data.frame from the first sample
head(mergers[[1]])

# Export Excel-------
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





# Make Sequence Table-----
seqtab <- makeSequenceTable(mergers)
dim(seqtab)

# Inspect distribution of sequence lengths
table(nchar(getSequences(seqtab)))

#------Remove chimeras
mergers.nochim <- removeBimeraDenovo(mergers, verbose = TRUE)




# Export Excel-------
# Create empty List
merged_data <- list()

removed<-mergers.nochim
#  Add each dataframe to end of the list
for (i in 1:length(removed)) {
  root       = removed[[i]]
  station    = names(as.list(removed))[i]
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
library(openxlsx)
write.xlsx(dfMergeRemoved, file =sprintf("data/miSeq/C/cutadapt/nochimera_CA_P2_%s_excel.xlsx", paste(truncLen, collapse = "-")), sheetName = "Sequences")


# Remove Bimera-----
seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", verbose=TRUE)
dim(seqtab.nochim)
sum(seqtab.nochim)/sum(seqtab)

seqtabNochim <- makeSequenceTable(mergers.nochim)

filename <- sprintf("data/miSeq/C/cutadapt/seqtab_CA_%s.rds", paste0(truncLen, collapse = "-"))
filename_nochim <- sprintf("data/miSeq/C/cutadapt/seqtab_nochim_CA_%s.rds", paste0(truncLen, collapse = "-"))
saveRDS(seqtab, filename) 
saveRDS(seqtab.nochim, filename_nochim)

# Get Track File-----
getN <- function(x) sum(getUniques(x))
track <- cbind(out, sapply(dadaFs, getN), sapply(dadaRs, getN), sapply(mergers, getN), rowSums(seqtab.nochim))
# If processing a single sample, remove the sapply calls: e.g. replace sapply(dadaFs, getN) with getN(dadaFs)
colnames(track) <- c("input", "filtered", "denoisedF", "denoisedR", "merged", "nonchim")
rownames(track) <- list.sample.names
head(track)

dfTrack <- data.frame(station = rownames(track), track)
write.xlsx(dfTrack, file=sprintf("data/miSeq/C/cutadapt/trackFile_P2_%s.xlsx",paste(truncLen, collapse = "-")), sheetName="AllStations")



uniquesToFasta(getUniques(seqtab.nochim), fout=sprintf("data/miSeq/cutadapt/uniqueSeqs_%s.fasta",
              paste(truncLen, collapse = "-")), ids=paste0("Seq", seq(length(getUniques(seqtab.nochim)))))


#  Read from rds------
seqtab<-readRDS("data/miSeq/C/cutadapt/seqtab_nochim_CA_260-210.rds")
seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", verbose=TRUE)

# Veri çerçevesi olusturma
df <- as.data.frame(seqtab.nochim)
df <- cbind(stationns = rownames(seqtab.nochim), df)
# write.xlsx ile Excel dosyasina aktarma
write.xlsx(df, file = "data/miSeq/C/cutadapt/setabnochim.xlsx", sheetName = "Sheet1")

transposed_mat <- t(seqtab.nochim)
# Veri çerçevesi olusturma
df <- as.data.frame(transposed_mat)
# Ilk sütuna satir adlarini ekleyin
df <- cbind(sequences = rownames(transposed_mat), df)


# write.xlsx ile Excel dosyasina aktarma
write.xlsx(df, file = "data/miSeq/C/cutadapt/setabnochim_transposed.xlsx", sheetName = "Sheet1")


# taxa-----
seqtab_subset<- seqtab.nochim[1:2, ]
path <- "C:/Users/uysal/OneDrive/Documents/eDNA_RProject/data/taxa/UNITE_9_All_eukaryotes_sh_dynamic_no_unclassified.fas"
dada2:::makeTaxonomyFasta_Silva(file.path(path, "silva.nr_v132.align"), 
                                file.path(path, "silva.nr_v132.tax"), 
                                "~/tax/silva_nr_v132_train_set.fa.gz")
dada2:::makeSpeciesFasta_Silva("~/Desktop/Silva/SILVA_132_SSURef_tax_silva.fasta.gz", 
                               "~/tax/silva_species_assignment_v132.fa.gz")

taxa <- assignTaxonomy(seqtab.nochim, path, verbose = TRUE)
taxa <- addSpecies(taxa, "C:/Users/uysal/OneDrive/Documents/eDNA_RProject/data/taxa/silva_128.18s.99_rep_set.dada2.fa.gz")

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







# Big Data Parsing---------
# Filename parsing
path <- "data/miSeq/cutadapt" # CHANGE ME to the directory containing your demultiplexed fastq files
filtpath <- file.path(path, "filtered/200") # Filtered files go into the filtered/ subdirectory
fns <- list.files(path, pattern="fastq") # CHANGE if different file extensions

filterAndTrim(file.path(path,fns), file.path(filtpath,fns), 
              truncLen=truncLen, maxEE=1, truncQ=11, rm.phix=TRUE,
              compress=TRUE, verbose=TRUE)

# File parsing
filtpath <- "data/miSeq/cutadapt/filtered/200" # CHANGE ME to the directory containing your filtered fastq files
filts <- list.files(filtpath, pattern="fastq", full.names=TRUE) # CHANGE if different file extensions
sample.names <- sapply(strsplit(basename(filts), "_"), `[`, 1) # Assumes filename = sample_XXX.fastq.gz
names(filts) <- sample.names
# Learn error rates
set.seed(100)
err <- learnErrors(filts, nbases = 1e8, randomize=TRUE)
# Infer sequence variants
dds <- vector("list", length(sample.names))
names(dds) <- sample.names
for(sam in sample.names) {
  cat("Processing:", sam, "\n")
  derep <- derepFastq(filts[[sam]])
  dds[[sam]] <- dada(derep, err=err)
}
# Create empty List
merged_data <- list()

for (i in 1:length(dds)) {
 for (j in 1:length(dds[[i]][[1]])){ 
  station    <- strsplit(names(dds), "_")[[i]][1]
  seq        <- dds[[i]][["clustering"]][["sequence"]]
  abundance  <- dds[[i]][["clustering"]][["abundance"]]
  }         

    merged_data[[i]] <- data.frame(
                      station    = station,
                      sequence   = seq,
                      abundance  = abundance
                      )
}


merged_data <- list()

for (i in 1:length(dds)) {
  station    <- strsplit(names(dds), "_")[[i]][1]
  seq        <- dds[[i]][["clustering"]][["sequence"]]
  abundance  <- dds[[i]][["clustering"]][["abundance"]]
  
  if (length(seq) > 0 && length(abundance) > 0) {
    merged_data[[i]] <- data.frame(
      station    = station,
      sequence   = seq,
      abundance  = abundance
    )
  }
}


df <- do.call(rbind, merged_data)
# Export Excel
formatted <- format(truncLen, big.mark = "_")
write.xlsx(df, file = sprintf("data/output/seqtab_%s_excel.xlsx", paste0(formatted[1],"_",formatted[2])), sheetName = "Sequences")

# Construct sequence table and write to disk
seqtab <- makeSequenceTable(df)

filename <- sprintf("data/output/seqtab_%s.rds", paste0(formatted[1],"_",formatted[2]))
saveRDS(seqtab, filename) 

# Read sequence table
st1 <- readRDS(filename)

# Remove chimeras
seqtab <- removeBimeraDenovo(st1, method="consensus", verbose=TRUE)
# Assign taxonomy
tax <- assignTaxonomy(seqtab[1:1, 1:1], path)
# Write to disk
saveRDS(seqtab, "data/output/seqtab_final.rds") # CHANGE ME to where you want sequence table saved
saveRDS(tax, "data/output/tax_final.rds") 
