imDICE<- function(ref,pred)
{
  ref <- melt(imageData(ref))
  pred <- melt(imageData(pred))
  
  if(!is.na(dim(ref)[3])) ref <- ref[ref$Var3==1,]
  if(!is.na(dim(pred)[3])) pred <- pred[pred$Var3==1,]
  
  intersect_pixel = ref$value * pred$value
  
  dice <- 2*sum(intersect_pixel)/(sum(ref$value)+sum(pred$value))
  dice <- round(dice, digits = 2)
  return(dice)
}