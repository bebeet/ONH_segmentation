
imMSE <- function(ref,pred)
{ 
  ref <- melt(imageData(ref))
  pred <- melt(imageData(pred))

  error = ref$value - pred$value
  MSE = mean(error^2)
  return(MSE)
}