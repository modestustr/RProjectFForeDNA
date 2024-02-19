uploadDataFileToFTP <-
  function(local_file = "data/Data.xlsx",
           remote_file = "httpdocs/Data.xlsx") {
    # Ftp için gerekli RCurl paketi yükleniyor
    if (!requireNamespace("RCurl", quietly = TRUE))
      install.packages("RCurl")
    library(RCurl)
    
    # FTP sunucusu
    ftp_server <- "www.modestusnet.com"
    
    isLocalFileExist <- file.exists(local_file)
    
    if (!isLocalFileExist)
      stop("Dosya mevcut degil. Islem durduruldu.")
    
    # Kullanici ve sifre
    user <- readline(prompt = "FTP kullanici adi: ")
    password <- readline(prompt = "FTP sifre: ")
    
    tryCatch({
      # FTP baglantisi
      ftp_conn <- ftpUpload(local_file, paste0("ftp://", user, ":", password, "@", ftp_server, "/", remote_file))
      
      if (inherits(ftp_conn, "try-error")) {
        stop("FTP baglanti hatasi: Dosya yüklenemedi.")
      } else {
        message(paste0("Dosya basariyla yüklendi.\n", timestamp()))
      }
    }, error = function(e) {
      if (grepl("530", e$message)) {
        stop("FTP baglanti hatasi: Kullanici adi veya sifre hatali.")
      } else {
        stop("FTP baglanti hatasi: ", e$message)
      }
    })
  }