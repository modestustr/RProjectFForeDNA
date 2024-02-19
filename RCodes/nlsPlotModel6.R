nlsPlotModel6 <- function(x, y, title="Title") {
  data<- data.frame(x, y)
  lm_model <- lm(data$y ~ data$x)
  
  a<-lm_model[["coefficients"]][["(Intercept)"]]
  b<-lm_model[["coefficients"]][["data$x"]] 
  
  # Baslangiç tahmin degerlerini belirleme
  start <- list(a = a , b = b )
  
  # Modeli tahmin etme
  expected <- nls(y ~ a * exp(b * x), start = start, algorithm = "default", data = data)
  
  coefficients <- coef(expected)
  a <- coefficients["a"]
  b <- coefficients["b"]
  start <- list(a = a , b = b )  
  dataSetName<-gsub("DegraFilteredCopyLoged", "",  gsub("\\$", "-", deparse(substitute(x)) , ignore.case = TRUE))
  
  
  file_name<- paste0("outputs/",dataSetName, ".txt")
 
   sink(file_name)
  result <-nlsfit(data, model=6, start =start)
  print(paste0(dataSetName))
  print(result)
  sink()
 
  graphic_file_name<- paste0("outputs/", dataSetName,".png")
  png(graphic_file_name)
  mNlsplot(data,model=6, start = start, xlab="Time", ylab="DNA Copy Numbers", title = title)
  dev.off()
  
  # nlsplot(data,model=6, start = start, xlab="Time", ylab="Loged Copy Numbers")
  return (result)
}
