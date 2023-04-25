 openSave <- function() {
  require(tcltk2)
  
  # # create a new Ttk toplevel window
  # ttop <- tktoplevel()
  # 
  # # Raise the file choose dialog to the front of other windows
  # tkfocus(ttop)
  # 

  # create a file.choose dialog box with only CSV and Excel files shown
  filepath <- tclvalue(tcl("tk_getOpenFile", filetypes = '{{Excel Workbook} {.xlsx}} {{Comma-Separated Values} {.csv}}'))
  
  
 # Raise the file choose dialog to the front of other windows
  tkraise(".")  
  
  if (length(filepath) == 0) {
    # no file selected
    message("No file selected.")
    return(NULL)
  } else {
    # file selected, copy to project folder
    dest_dir <- "./data"
    if (!dir.exists(dest_dir)) {
      dir.create(dest_dir)
    }
    file.copy(from = filepath, to = file.path(dest_dir, basename(filepath)))
    
    # return the file path in the project folder
    proj_filepath <- file.path(dest_dir, basename(filepath))
    message(substring(proj_filepath,3))
    return(substring(proj_filepath,3))
  }
}
