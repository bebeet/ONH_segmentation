computeProbability <- function(imageList,maskList,histogramBinning,
                                      colorChannel=c("gray","red","green","blue",
                                                     "H","S","V","L","A","B","O1","O2","O3"))
{
  imageHistogram_df <- data.frame(intensity=c(),intensity_level=c(),label =c())
  trainingList <- 1:length(imageList)

  # run the cluster
  # initiate 3 cluster
  clus <- makeCluster(3)
  # export img and functions to cluster 
  clusterExport(clus,c("maskList","imageList","imageHistogram_df","getImageData",
                       "getBinningData","normalizeData"),envir=environment())
  clusterEvalQ(clus, library(reshape2))
  clusterEvalQ(clus, library(EBImage))
  
  # get all training image data compared with mask
  Histograms <- parLapply(clus,trainingList,function(i){
    im_path <-imageList[i]
    mask_path <- maskList[i]
    
    images = EBImage::readImage(im_path)
    mask_image = EBImage::readImage(mask_path)
    
    Histogram <- data.frame(intensity= getImageData(images,colorChannel)$Intensity
                          ,intensity_level= getImageData(images,colorChannel)$Intensity
                          ,label =getImageData(mask_image,"mask")$Intensity)
    
    # assign image into pre-defined binning number    
    Histogram <- getBinningData(Histogram,histogramBinning)
    return(Histogram)
    
  })
  
  stopCluster(clus)
  gc()
  
  # get image intensity histogram from all training data
  imageHistogram_df<-bind_rows(Histograms) 
  # calculate probability
  ftable <-table(imageHistogram_df$intensity_level,imageHistogram_df$label)
  ProbSpaces <- as.data.frame(ftable)
  names(ProbSpaces) <- c("intensity_level","label","probs")
  ProbSpaces$sum<-1
  ProbSpaces[which(ProbSpaces$label==0),]$sum <- sum(ProbSpaces[which(ProbSpaces$label==0),]$probs)
  ProbSpaces[which(ProbSpaces$label==1),]$sum <- sum(ProbSpaces[which(ProbSpaces$label==1),]$probs)
  ProbSpaces$probs <- ProbSpaces$probs/ProbSpaces$sum
  ProbSpaces <- ProbSpaces[,c("intensity_level","label","probs")]
  ProbSpaces$intensity_level <-  factor(ProbSpaces$intensity_level)
  ProbSpaces$label <- factor(ProbSpaces$label)

  return(ProbSpaces)
}
