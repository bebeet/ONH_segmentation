imPrecision <- function(ref,pred)
{
  library(SDMTools)
  
  ref <- melt(imageData(ref))
  pred <- melt(imageData(pred))
  mat = confusion.matrix(ref$value,pred$value)
  TP = mat[4]
  FP = mat[2]
  pre = TP/(TP+FP)
  return(pre)
}