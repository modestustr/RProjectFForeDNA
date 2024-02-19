PackageInstallAndLoad <- function(paketAdi) {
  # Paket adlarini virgülle ayrilmis bir string haline getir
  if (is.vector(paketAdi)) {
    paketAdi <- paste0(paketAdi, collapse = ",")
  }
  
  # Paket adlarini vektöre dönüstür
  paketListesi <- strsplit(paketAdi, ",")[[1]]
  
  # Her bir paket adi için islemi gerçeklestir
  for (paket in paketListesi) {
    paket <- trimws(paket)  # Paket adindaki gereksiz bosluklari kaldir
    if (!requireNamespace(paket, quietly = TRUE)) {
      install.packages(paket, dependencies = TRUE)
      if (!requireNamespace(paket, quietly = TRUE)) {
        stop("Paket yüklenemedi: ", paket)
      }
    } else {
      cat(paket, " paketi zaten yüklü.\n")
    }
    library(paket, character.only = TRUE)
  }
}

# Örnek kullanimlar
# PackageInstallAndLoad(c("dplyr", "ggplot2", "tidyr"))
# PackageInstallAndLoad("dplyr, ggplot2, tidyr")
