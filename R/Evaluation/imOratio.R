imOratio <- function(ref,pred)
{
  ref <- melt(imageData(ref))
  pred <- melt(imageData(pred))

  overlap = as.numeric(ref$value&pred$value)
  unions = as.numeric(ref$value|pred$value)
  percent = sum(overlap)/sum(unions)
  return(percent)
}


