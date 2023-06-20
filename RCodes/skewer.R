# Skewer komutunu çalistirmak için system2 kullanimi
command <- "skewer -x adapter_sequence -m any -o data/miSeq/output_05_S5_L001_R1_001.fastq data/miSeq/05_S5_L001_R1_001.fastq"
system2(command, wait = TRUE)

# Skewer'in çiktisini yakalamak ve sonucu bir degiskene atamak için
result <- system2(command, wait = TRUE, stdout = TRUE)

# Skewer komutunun basari durumunu kontrol etmek için
if (attr(result, "status") == 0) {
  print("Skewer komutu basariyla tamamlandi.")
} else {
  print("Skewer komutunda bir hata olustu.")
}

