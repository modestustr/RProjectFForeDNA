filterTrimForDada2 <-
  function(F_FileNameWithPath,
           R_FileNameWithPath,
           isShowF = TRUE,
           isShowR = TRUE,
           maxN = 0,
           trimLeft = 10,
           truncLen = NULL,
           maxEE = 2,
           compress = TRUE,
           verbose = TRUE) {
    #-----Filter and Trim
    fnF1 <- F_FileNameWithPath  #"data/4_S4_L001_R1_001.fastq.gz"
    fnR1 <- R_FileNameWithPath  #"data/4_S4_L001_R2_001.fastq.gz"
    
    # Split by "_"
    segments <- strsplit(fnF1, "_")[[1]]
    
    # Get the first segment and remove "data/"
    fileNumber <- gsub("^data/", "", segments[1])
    patternF <- paste0(fileNumber, "F_")
    patternR <- paste0(fileNumber, "R_")
    
    filtF1 <-
      tempfile(fileext = ".fastq.gz",
               tmpdir = "data",
               pattern = patternF)
    filtR1 <-
      tempfile(fileext = ".fastq.gz",
               tmpdir = "data",
               pattern = patternR)
    
    # if (isShowF)
    # {
      plotQualityProfile(fnF1) # Forward
      message("plot F generated")
    # }
    # if (isShowR) {
      plotQualityProfile(fnR1) # Reverse
      message("plot R generated")
    # }
     

    #------Filter and Trim
    filterAndTrim(
      fwd = fnF1,
      filt = filtF1,
      rev = fnR1,
      filt.rev = filtR1,
      trimLeft = trimLeft,
      truncLen = truncLen,
      maxN = maxN,
      maxEE = maxEE,
      compress = compress,
      verbose = verbose
    )
    #-----Dereplicate
    derepF1 <- derepFastq(filtF1, verbose = TRUE)
    derepR1 <- derepFastq(filtR1, verbose = TRUE)

    #------Learn the error rates
    errF <- learnErrors(derepF1, multithread = FALSE)
    errR <- learnErrors(derepR1, multithread = FALSE)

    #------Infer sample composition
    dadaF1 <- dada(derepF1, err = errF, multithread = FALSE)
    dadaR1 <- dada(derepR1, err = errR, multithread = FALSE)

    #------Merge forward/reverse reads
    merger1 <-
      mergePairs(dadaF1, derepF1, dadaR1, derepR1, verbose = TRUE)

    #------Remove chimeras
    merger1.nochim <-
      removeBimeraDenovo(merger1, multithread = FALSE, verbose = TRUE)

    #------Export Excel
    library(openxlsx)
    fileName <- paste0("data/", fileNumber, ".xlsx")
    write.xlsx(merger1, file = fileName)
    
    result <-
      paste(
        "Excel File Named ",
        fileName,
        " and fastq.gz Files named ",
        filtF1,
        "and ",
        filtR1,
        " have been created. truncLen =",  paste(truncLen, collapse = ","),
        ", trimLeft =", trimLeft,
        ",  maxN = ",   maxN,
        ",  maxEE = ",  maxEE
      )
    selectedColor<-"blue"
    coloredMessage(result, selectedColor)
  }