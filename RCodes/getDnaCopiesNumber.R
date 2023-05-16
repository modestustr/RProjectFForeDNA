# (DNA concentration (ng/µl) x [6.022 x 1023]) / (length of template (bp) x [1x109] x 650)
# Length of Template
# E.densa	75
# D.magna	81

# Avagadro	6,0221E+023
# NgDa	650000000000
getDnaCopiesNumber <- function(x, species) {
  avagadro <- 6.0221 * 10 ^ 23
  ngDa <- 6.5 * 10 ^ 11
  
  lot <- switch(species, "E.densa" = 75, "D.magna" = 81, 75)
  result <- (x * avagadro) / (lot * ngDa)
  
  return(result)
}
