# load R function
source('../R/Graphcut/getImageData.R')

imEntropy <- function(img)
{
  imdata <- getImageData(img,"gray")
  bins <- apply(as.data.frame(imdata$Intensity), 1, cut,c(-Inf,seq(0.1, 1, 0.1), Inf), labels=seq(0, 1, 0.1))
  freqs <- table(bins)/length(bins)
  # ignore bin zero to avoid -Inf from calculation of log 
  freqs <- freqs[freqs!=0]
  # calculate shannon-entropy
  etp  <-  (-sum(freqs * log2(freqs)))
  return(etp)
}





