library(jsonlite)
library(openxlsx)

convertJson2Excel <-
  function(jsonFilePathWithName,
           excelFilePathWithName) {
    jsonContent <- readLines(jsonFilePathWithName)
    jsonData <- fromJSON(jsonContent, flatten = TRUE)
    hitsData <-
      jsonData$BlastOutput2$report.results.search.hits[[1]]
    hitsDataDescription <- hitsData[["description"]]
    hitsDataHsps <- hitsData[["hsps"]]
    
    if (length(hitsData) == 0) {
      stop("No data found in hitsData")
    }
    
    # Excel dosyasini olustur
    wb <- createWorkbook()
    
    # Excel sayfasini olustur
    addWorksheet(wb, "Sheet1")
    addWorksheet(wb, "Sheet2")
    
    # Baslik sütunlarini ekle
    columnCount <- 1
    for (i in 1:length(hitsDataDescription)) {
      if (i == 1) {
        headers <- names(hitsDataDescription[[i]])
      }
    }
    
    for (header in headers) {
      writeData(wb,
                "Sheet1",
                header,
                startRow =  1,
                startCol = columnCount)
      columnCount <- columnCount + 1
    }
    
    
    # # Verileri Excel tablosuna ekle
    rowCount <- 2
    for (i in 1:length(hitsDataDescription)) {
      columnCount <- 1
      for (j in 1:length(headers)) {
        writeData(wb,
                  "Sheet1",
                  hitsDataDescription[[i]][[j]],
                  columnCount,
                  rowCount)
        columnCount <- columnCount + 1
      }
      rowCount <- rowCount + 1
    }
    
    nHeaders <- c("sciname")
    
    for (i in 1:length(hitsDataHsps)) {
      if (i == 1) {
        nHeaders <- c(nHeaders, names(hitsDataHsps[[i]]))
      }
    }
    
    message(nHeaders)
    columnCount <- 1
    for (header in nHeaders) {
      writeData(wb,
                "Sheet2",
                header,
                startRow =  1,
                startCol = columnCount)
      message(paste0(header, columnCount))
      columnCount <- columnCount + 1
    }
    
    tryCatch({
      rowCount <- 2
      columnCount <- 1
      for (i in 1:length(hitsDataHsps)) {
        if(i==1) message(paste("Toplam i sayisi",length(hitsDataHsps)))
        for (j in 1:length(nHeaders)) {
          
            if (columnCount == 1) {
            writeData(wb,
                      "Sheet2",
                      paste0("No Name", j),
                      1,
                      rowCount)
            # message(paste("Ilk Sutun",columnCount,"-", rowCount))
          } else {
            writeData(wb,
                      "Sheet2",
                      hitsDataHsps[[i]][[j-1]],
                      columnCount,
                      rowCount)
            # message(paste("Sonraki Sutun",columnCount,"-", rowCount))
          }
          # message(paste("Simdiki Sutun",columnCount, "Simdiki Satir", rowCount))
          columnCount <- columnCount + 1
          # message(paste("Gelecek Sutun",columnCount))
          # message(paste("Geçerli Satir",rowCount, "i degeri: ", i, "j degeri: ",j))
          
          }
        
        rowCount <- rowCount + 1
        columnCount <- 1
         
      }
      
    }, error = function(e) {
      # Hata durumunda burasi çalisacak
      print("Hata olustu!")
      print(e)
    })
    
    
    
    
    
    # Hedef dosyayi sil
    if (file.exists(excelFilePathWithName)) {
      file.remove(excelFilePathWithName)
    }
    
    # Excel dosyasini kaydet
    saveWorkbook(wb, excelFilePathWithName)
  }



prepend <- function(x, value) {
  c(value, x)
}