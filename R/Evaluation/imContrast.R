# load R function
source('../R/Graphcut/getImageData.R')

imContrast <- function(img)
{
  imdata <- getImageData(img,"gray")
  contr = (max(imdata$Intensity)-min(imdata$Intensity))/(max(imdata$Intensity)+min(imdata$Intensity))
  return(contr)
}