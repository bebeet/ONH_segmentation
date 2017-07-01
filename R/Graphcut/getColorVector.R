getColorVector <- function(color=c("RGB","HSV","LAB","Opponent"))
{
  weight.ColorModel <-  match.arg(color)
  if(weight.ColorModel=="RGB")
  { 
    colorVector <- c("red","green","blue")
  }
  
  if(weight.ColorModel=="HSV")
  {  
    colorVector <- c("H","S","V")
  }
  
  if(weight.ColorModel=="LAB")
  {  
    colorVector <- c("L","A","B")
  }
  
  if(weight.ColorModel=="Opponent")
  {  
    colorVector <- c("O1","O2","O3")
  }
  return(colorVector)
}