imAccuracy <- function(ref,pred)
{
  library(SDMTools)
  ref <- melt(imageData(ref))
  pred <- melt(imageData(pred))
  mat = confusion.matrix(ref$value,pred$value)
  acc = accuracy(ref$value,pred$value)
  return(acc[6])
}
