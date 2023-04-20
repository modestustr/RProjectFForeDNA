#-------------Saving generated plot that is based on the code----
plotSave <-
  function(plot,
           filename,
           width = 7,
           height = 5,
           dpi = 300) {
    # saving file by size and dpi
    ggsave(paste0("outputs/",filename),
           plot,
           width = width,
           height = height,
           dpi = dpi)
    
    # Notification for saved file
    cat(sprintf("\nPlot saved as %s\n", filename))
    
  }
