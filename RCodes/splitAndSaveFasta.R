# splitAndSaveFasta <-
#   function(fastaDosya, sayi, outputFolder = "data/sekanslar/") {
#     sekanslar <- list()
#     
#     eskiDosyalar <-
#       list.files(outputFolder, pattern = "dosya_\\d+\\.fasta")
#     if (length(eskiDosyalar) > 0) {
#       cat("Onceki dosyalar siliniyor...\n")
#       file.remove(paste0("data/sekanslar/", eskiDosyalar))
#       cat("Onceki dosyalar basariyla silindi.\n")
#     }
#     
#     dosya <- file(fastaDosya, "r")
#     satir <- readLines(dosya)
#     close(dosya)
#     
#     aktifSekans <- NULL
#     for (i in 1:length(satir)) {
#       if (substr(satir[i], 1, 1) == ">") {
#         if (!is.null(aktifSekans)) {
#           sekanslar[[length(sekanslar) + 1]] <- aktifSekans
#         }
#         aktifSekans <- list(ID = satir[i], Sequence = character())
#       } else {
#         aktifSekans$Sequence <- c(aktifSekans$Sequence, satir[i])
#       }
#     }
#     sekanslar[[length(sekanslar) + 1]] <- aktifSekans
#     nextIndex <- 0
#     # totalIndex <- ceiling(length(sekanslar) / sayi)
#     # numberOfLastSequences <- length(sekanslar) %% sayi
#     # fileContent <- list()
#     # 
#     # for (i in 1:length(sekanslar)) {
#     #   index <- ceiling(i / sayi)
#     #   entry <- list(
#     #     FileName = paste0("dosya_", index, ".fasta"),
#     #     ID = sekanslar[[i]]$ID,
#     #     Sequence = sekanslar[[i]]$Sequence
#     #   )
#     #   fileContent[[i]] <- entry
#     #   
#     #   cat(paste0("Dosya Adi: ", entry$FileName, " ID: ", entry$ID, " Sekans: ", entry$Sequence, "\n"))
#     # }
#     
#     totalLines <- length(sekanslar)
#     fileContentList <- list()
#     
#     remainingLines <- list(FileName = character(), ID = character(), Sequence = character())
#     
#     for (i in 1:totalLines) {
#       fileContent <- list(FileName = character(), ID = character(), Sequence = character())
#       
#       fileContent$FileName <- paste0("dosya_", ceiling(i / sayi), ".fasta")
#       fileContent$ID <- sekanslar[[i]]$ID
#       fileContent$Sequence <- sekanslar[[i]]$Sequence
#       
#       # Kalan satirlari önceki içerige ekleyin
#       fileContent$FileName <- c(remainingLines$FileName, fileContent$FileName)
#       fileContent$ID <- c(remainingLines$ID, fileContent$ID)
#       fileContent$Sequence <- c(remainingLines$Sequence, fileContent$Sequence)
#       
#       # Eger bu son satirsa veya bir sonraki satira geçtigimizde yeni bir grup baslayacaksa, 
#       # kalan satirlari bosaltin ve bir sonraki grup için saklayin
#       if (i == totalLines || i %% sayi == 0) {
#         fileContentList[[length(fileContentList) + 1]] <- fileContent
#         remainingLines <- list(FileName = character(), ID = character(), Sequence = character())
#       } else {
#         remainingLines <- fileContent
#       }
#       
#       cat(paste0("Dosya Adi: ", fileContent$FileName, " ID: ", fileContent$ID, " Sekans: ", fileContent$Sequence, "\n"))
#     }
#     
# 
#     for(i in 1: length(fileContent)){
#       
#       # dosyaAdi <- paste0(outputFolder, "dosya_",index , ".fasta")
#       # dosya <- file(dosyaAdi, "a")
#       # writeLines(fileContent[[i]]$ID, dosya)
#       # writeLines(fileContent[[i]]$Sequence, dosya)
#       # close(dosya)
#       # cat(paste("Dosya Adi: ",fileContent[[i]]$FileName,"ID: ", fileContent[[i]]$ID,"Sekans: ", fileContent[[i]]$Sequence))
#     }    
#     cat("Dosyalar basariyla olusturuldu.\n")
#   }
# 
# # # Kullanicidan fasta dosyasinin adini ve b???l???necek sekans sayisini alin
# # fastaDosya <- readline("Fasta dosyasinin adini girin: ")
# # sayi <- as.integer(readline("B???l???necek sekans sayisini girin: "))
# #
# # # Fonksiyonu ???agirin
# # splitAndSaveFasta(fastaDosya, sayi)


splitAndSaveFasta <- function(fastaDosya, sayi, outPutFolder="data/sekanslar/", outPutFileName="sekans_") {
  sekanslar <- list()
  
  eskiDosyalar <- list.files(outPutFolder, pattern = "dosya_\\d+\\.fasta")
  if (length(eskiDosyalar) > 0) {
    cat("Onceki dosyalar siliniyor...\n")
    file.remove(paste0("data/sekanslar/", eskiDosyalar))
    cat("Onceki dosyalar basariyla silindi.\n")
  }
  
  dosya <- file(fastaDosya, "r")
  satir <- readLines(dosya)
  close(dosya)

  aktifSekans <- NULL
  for (i in 1:length(satir)) {
    if (substr(satir[i], 1, 1) == ">") {
      if (!is.null(aktifSekans)) {
        sekanslar[[length(sekanslar) + 1]] <- aktifSekans
      }
      aktifSekans <- list(ID = satir[i], Sequence = character())
    } else {
      aktifSekans$Sequence <- c(aktifSekans$Sequence, satir[i])
    }
  }
  sekanslar[[length(sekanslar) + 1]] <- aktifSekans
  
  for (i in 1:length(sekanslar)) {
    index <- ceiling(i / sayi)
    dosyaAdi <- paste0(outPutFolder, outPutFileName,index , ".fasta")
    dosya <- file(dosyaAdi, "a")
    writeLines(sekanslar[[i]]$ID, dosya)
    writeLines(sekanslar[[i]]$Sequence, dosya)
    close(dosya)
  }
  
  cat("Dosyalar basariyla olusturuldu.\n")
}

# # Kullanicidan fasta dosyasinin adini ve bölünecek sekans sayisini alin
# fastaDosya <- readline("Fasta dosyasinin adini girin: ")
# sayi <- as.integer(readline("Bölünecek sekans sayisini girin: "))
# 
# # Fonksiyonu çagirin
# splitAndSaveFasta(fastaDosya, sayi)
