getRIMONEImageClassInfo <- function(Input)
{
  InfoPath <- "/home/punsiriboo/thesis_workspace/ONH_segmentation/Dataset/RIM_ONE_r1/All_Resize/10/info.csv"
  Info <- read.csv(InfoPath)
  class <-  Info$class[match(Input,Info$name)]
  return(class)
}