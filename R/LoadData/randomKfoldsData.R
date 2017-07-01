randomKFoldsdata <- function(Impath.path,Mask.path,savepath,times,numfolds)
{
  set.seed(Sys.time())
  KFoldsdata<-list()
  ## Read all images
  All_img <- list.files(path=Impath.path, pattern="*.jpg")

  
  foldsData <-data.frame(name=c(),path=c(),times=c(),folds=c(),type=c())
  
  for(t in 1:times)
  {
    ## Randomly saperated to train and test
    randomData <- sample(All_img)
    bound <- floor(length(All_img)/numfolds)
    nrFolds = numfolds
    # Generate array containing fold-number for each sample (row)
    folds <- rep_len(1:nrFolds, length(randomData))
    for(k in 1:numfolds)
    {
      fold <- which(folds == k )
      
      dataTest <- randomData[fold]
      dataTrain <- randomData[-fold]
      
      dataTest <- gsub(".jpg","",dataTest)
      dataTrain <- gsub(".jpg","",dataTrain)
      
      ## Save images list of test and train to CSV file
      dataTest <- data.frame(name = dataTest,path=paste(Impath.path,'/',dataTest,".jpg", sep=''))
      dataTrainMask <- data.frame(name = dataTrain,path=paste(Mask.path,'/',dataTrain,".jpg", sep=''))
      dataTrain <- data.frame(name = dataTrain,path=paste(Impath.path,'/',dataTrain,".jpg", sep=''))
      
      # Drop factor level
      dataTest$name<-levels(droplevels(dataTest)$name)
      dataTest$path<-levels(droplevels(dataTest)$path)
      dataTrain$name<-levels(droplevels(dataTrain)$name)
      dataTrain$path<-levels(droplevels(dataTrain)$path)
      dataTrainMask$name<-levels(droplevels(dataTrainMask)$name)
      dataTrainMask$path<-levels(droplevels(dataTrainMask)$path)
      
      # Assisn value to global environment in order to futhur used for train Histogram
      assign(paste("dataTest_T",t,"_F",k,sep = ""), dataTest,envir = .GlobalEnv)
      assign(paste("dataTrain_T",t,"_F",k, sep=""), dataTrain,envir = .GlobalEnv)
      assign(paste("dataTrainMask_T",t,"_F",k, sep=""), dataTrainMask,envir = .GlobalEnv)
      
      # Collect and save folds information as csv
      foldsData<-rbind(foldsData,data.frame(
        name=dataTest$name,path = dataTest$path,times=t,folds=k,type = "test"))
      foldsData<-rbind(foldsData,data.frame(
        name=dataTrain$name,path = dataTrain$path,times=t,folds=k,type = "train"))
      foldsData<-rbind(foldsData,data.frame(
        name=dataTrainMask$name,path = dataTrainMask$path,times=t,folds=k,type = "mask"))
      
    }
  }
  write.csv(foldsData, file = paste(savepath,"/foldsDatas.csv",sep=""))
}


############### For Validation
#Impath.path='/home/punsiriboo/thesis_workspace/ONH_segmentation/Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe'
#Mask.path='/home/punsiriboo/thesis_workspace/ONH_segmentation/Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts'
#result_path="/home/punsiriboo/thesis_workspace/ONH_segmentation/Results/test"
#times=1
#numfolds = 10
#randomKFoldsdata(Impath.path,Mask.path,result_path,times,numfolds)