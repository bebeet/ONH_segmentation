###############################################################################
# Calculate T-link weight for original GC on selected color channel
# Offline calculation of regional term from training data

## input : image path (testing data), lambda, trained probability distribution of intensity (histogram), channel
## output : regoinal term assign to t-link,s-link by node id 
###############################################################################

# load R function
source('../R/Graphcut/getImageData.R')
source('../R/Graphcut/getProbability.R')

getRegionTerm <- function(path,lamda,histogram,weightingFunction=NULL,save_path)
{ 
  weight.ColorModel <-  histogram$color

  img <- EBImage::readImage(path)
  
  if(weight.ColorModel %in%  c("gray","blue","green","red","H","S","V","L","A","B","O1","O2","O3"))
  {  
    tLink <- getImageData(img,weight.ColorModel)

    # run the cluster
    # initiate 3 cluster
    clus <- makeCluster(3)
  
    clusterExport(clus,c("tLink","histogram","getProbability"),envir=environment())
  
    tLink$s_probs <- parApply(clus,tLink, 1, function(y) 
      getProbability(y['Intensity'],histogram$trainedHistogram,histogram$binning,"Source"))
    
    tLink$t_probs <- parApply(clus,tLink, 1, function(y) 
      getProbability(y['Intensity'],histogram$trainedHistogram,histogram$binning,"Sink"))
    
    stopCluster(clus)
    gc()
  }
  
  if(weight.ColorModel%in%  c("RGB","HSV","LAB","Opponent"))
  { 
    tLink <- getImageData(img,"gray")
    
    colorVector <- getColorVector(weight.ColorModel)
    ImDatas <-lapply(colorVector, function(x) getImageData(img,x))
    # run the cluster
    # initiate 3 cluster
    clus <- makeCluster(3)
    # export img and computeDist function to cluster 

    clusterExport(clus,c("ImDatas","histogram","getProbability"), envir=environment())
    
    Probabilities_source <- mapply(function(X,Y) {
      parApply(clus,X, 1, function(y) 
        getProbability(y['Intensity'],Y,histogram$binning,"Source"))
    }, X=ImDatas, Y=histogram$trainedHistogram)
    

    Probabilities_sink <- mapply(function(X,Y) {
      parApply(clus,X, 1, function(y) 
        getProbability(y['Intensity'],Y,histogram$binning,"Sink"))
    }, X=ImDatas, Y=histogram$trainedHistogram)

    #print(Probabilities_source)
    tLink$s_probs <- Probabilities_source[,1]* Probabilities_source[,2] * Probabilities_source[,3]
    tLink$t_probs <- Probabilities_sink[,1]* Probabilities_sink[,2] * Probabilities_sink[,3]
    
    stopCluster(clus)
    gc()
  }

  # calculate negative log-likelihood for s-link weight
  tLink$s_weight <- as.numeric(tLink$s_probs)
  tLink$s_weight <- -log(tLink$s_weight)
  tLink$s_weight <- tLink$s_weight * lamda
  tLink$s_weight[tLink$s_weight == Inf] <- 9999  
  
  # calculate negative log-likelihood for t-link weight
  if(is.null(weightingFunction))
  {
    tLink$t_weight <- as.numeric(tLink$t_probs)
    tLink$t_weight <- -log(tLink$t_weight)
    tLink$t_weight <-  tLink$t_weight *lamda
    tLink$t_weight[tLink$t_weight == Inf] <- 9999
  }
  else
  {
    # calculate negative log-likelihood for t-link weight
    tLink$t_weight <- as.numeric(tLink$t_probs)
    tLink$t_weight <- -log(tLink$t_weight)    
    tLink$t_weight <- tLink$t_weight *lamda
    tLink$t_weight <- tLink$t_weight+weightingFunction$weight$weight
    tLink$t_weight[tLink$t_weight == Inf] <- 9999
    
  }
  
  #imname <- tail(unlist(strsplit(path, "/")), n=1)
  #imname <-gsub(".jpg","",imname)
  #write.csv(tLink,file = paste(save_path,"/",imname,"_tLink.csv",sep=""))

  return(tLink[,c("nodeid","Intensity","s_weight","t_weight")])
  
}

#t<-t_link("/home/punsiriboo/thesis_workspace/dataset/RIM_ONE_r1/deep_image/10/Im002.jpg",0.25,trainedHistogram)

