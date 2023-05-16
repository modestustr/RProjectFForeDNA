nlsPlotModel6 <- function(x, y) {
  data<- data.frame(x, y)
  lm_model <- lm(data$y ~ data$x)
  
  a<-lm_model[["coefficients"]][["(Intercept)"]]
  b<-lm_model[["coefficients"]][["data$x"]] 
  
  # Baslangiç tahmin degerlerini belirleme
  start <- list(a = a , b = b )
  
  # Modeli tahmin etme
  expected <- nls(y ~ a * exp(b * x), start = start, algorithm = "port", data = data)

  coefficients <- coef(expected)
  a <- coefficients["a"]
  b <- coefficients["b"]
  start <- list(a = a , b = b )  
  
  result <-nlsfit(data, model=6, start =start)
  
  dataSetName<-gsub("datagroupDegra", "",  gsub("\\$", "-", deparse(substitute(x)) , ignore.case = TRUE))
  
  nlsplot(data,model=6, start = start, xlab=dataSetName, ylab="Loged Copy Numbers")
  
  return (result)
}
