loadExperimentData<-function(kfold_path,expdata_path)
{
  load(expdata_path,envir = .GlobalEnv)
  Kfolds <- read.csv(kfold_path)
  for(t in 1:times)
  {
    for(k in 1:numfolds)
    {
      dataTest<-subset(Kfolds, times==t& folds==k & type=="test", select=name:path)
      dataTrain<-subset(Kfolds, times==t& folds==k & type=="train", select=name:path)
      dataTrainMask <-subset(Kfolds, times==t& folds==k & type=="mask", select=name:path)
      
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
    }
  }
}


