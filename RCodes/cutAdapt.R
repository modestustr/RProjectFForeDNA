library(system)
library(stringr)

# py -m cutadapt -a CTGTCTCTTATACACATCT  04_S4_L001_R2_001.fastq >outputCan2.fastq 2> report.txt
# py -m cutadapt -a AATGATACGGCGACCACCGAGATCTACAC -A CAAGCAGAAGACGGCATACGAGAT -o out.1.fastq -p out.2.fastq 04_S4_L001_R1_001.fastq 04_S4_L001_R2_001.fastq

# Cutadapt komutu ve parametreleri
cutadapt_cmd <- "py -m cutadapt"
param_options <- "-a CTGTCTCTTATACACATCT -o"

# Hedef klasör veya dosya listesi
target_folder <- "data/miSeq/C"
target_files <- list.files(target_folder, pattern = "_001.fastq", full.names = TRUE)
# target_filesF <- list.files(target_folder, pattern = "R1_001.fastq", full.names = TRUE)
# target_filesR <- list.files(target_folder, pattern = "R2_001.fastq", full.names = TRUE)
# target_filesF
# target_filesR
target_files

digits <- nchar(as.character(length(target_files)))

# Döngü ile cutadapt uygulama
for (i in 1:length(target_files)) {
  
  # Çikti dosyasinin adini olustur
  # output_file <-str_replace(str_replace(target_files[i], ".fastq", "_cutadapt.fastq"),"data/miSeq/","")
  output_file <-str_replace(target_files[i], ".fastq", "_cutadapt.fastq")
  # output_fileF <- str_replace(target_filesF[i], ".fastq", "_trimmed.fastq")
  # output_fileR <- str_replace(target_filesR[i], ".fastq", "_trimmed.fastq")

  # fileF<- target_filesF[i]
  # fileR<- target_filesR[i]
  # file<-str_replace(target_files[i],"data/miSeq/","")
  file<-target_files[i]
  # file <- shQuote(target_files[i])
  formatted_i <- sprintf("%0*d", digits, i)  # i'yi basamak sayisina göre biçimlendirme
  reportFile<-sprintf("report_%s.txt", formatted_i)
  
  cmd <- paste(cutadapt_cmd, param_options, output_file, file)
  # cmd<- paste(cutadapt_cmd, param_options, paste0(output_fileF, " -p ", output_fileR, " ", fileF," ", fileR))
  # out.1.fastq -p out.2.fastq 04_S4_L001_R1_001.fastq 04_S4_L001_R2_001.fastq
  # cmd <- paste(cutadapt_cmd, param_options, file, ">", output_file, "2>", reportFile)
  # system(cmd)
  
 
  
  system(cmd)
  coloredMessage(cmd,"blue")
}

