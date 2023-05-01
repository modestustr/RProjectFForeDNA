if (!require(RCurl))
  install.packages("RCurl")

library(RCurl)

# FTP serve
ftp_server <- "www.modestusnet.com"
remote_file <- "httpdocs/Data.xlsx"
local_file<-"data/Data.xlsx"

isLocalFileExist<- file.exists(local_file)

if(!isLocalFileExist)
  stop("File does not exist. Execution stopped.")


# user and pass
user <- readline(prompt = "FTP username: ")
password <- readline(prompt = "FTP password: ")

# FTP connection
ftp_conn <- ftpUpload(local_file, paste0("ftp://", user, ":", password, "@", ftp_server, "/", remote_file))

message("File Uploaded succesfully")