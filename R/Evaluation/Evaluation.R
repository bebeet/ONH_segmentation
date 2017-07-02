# load R function
source('../R/Graphcut/getImageData.R')

Evaluation <- function(
  masks_path,
  result_path,
  experiment_name,
  dataset=c("RIMONE r1","RIMONE r2"),
  times,
  numfolds,
  histogram_binning,
  lambdas,
  sigmas,
  color,
  runningTrainData,
  amplitude,
  weighType
)
{
  source('../R/Evaluation/imOratio.R')
  source('../R/Evaluation/imAccuracy.R')
  source('../R/Evaluation/imPrecision.R')
  source('../R/Evaluation/imSensitivity.R')
  source('../R/Evaluation/imSpecificity.R')
  source('../R/Evaluation/summarySE.R')
  
  foldData <- read.csv(paste(result_path ,"/foldsDatas.csv",sep=""))

  if(runningTrainData){type <- c("train","test")}
  else{  type <- c("test")}
  segmented_images <- foldData[ which(foldData$type %in% type),]
  segmented_images$segment_path <- paste(result_path,"/T",segmented_images$time,"/",
                                         segmented_images$type,"/F",segmented_images$folds,"/",segmented_images$name,".png",sep="")

  
  Evaluate_result <-data.frame(name=c(),
                               time = c(),
                               fold = c(),
                               dataType = c(),
                               histogram_binning=c(),
                               lambdas=c(),
                               sigmas=c(),
                               color=c(),
                               amplitude=c(),
                               weighType=c(),
                               Sensitivity=c(),
                               Specificity=c(),
                               Precision = c(),
                               Accuracy=c(),
                               Oratio=c()
                               
  )

  EvaluationList <- 1:nrow(segmented_images)
  # run the cluster
  # initiate 3 cluster
  clus <- makeCluster(3)
  # export img and functions to cluster 
  clusterExport(clus,c("segmented_images",
                       "Evaluate_result","getImageData","imSensitivity","imSpecificity",
                       "imPrecision","imAccuracy","imOratio"),envir=environment())
  clusterEvalQ(clus, library(reshape2))
  clusterEvalQ(clus, library(EBImage))
  
  # get all EvaluationList
  Evaluation_all <- lapply(EvaluationList,function(i){
    # Read images
    seg_img <- EBImage::readImage(paste(result_path,"/T",segmented_images$time[i],"/",
                                        segmented_images$type[i],
                                        "/F",segmented_images$folds[i],"/",
                                        segmented_images$name[i],".png",sep=""))
    
    gt_img <- EBImage::readImage(paste(masks_path,"/",segmented_images$name[i],".jpg",sep=""))
    
    seg_img <-getImageData(seg_img,"mask",type="array") 
    gt_img <-getImageData(gt_img,"mask",type="array") 
    
    #EBImage::display(seg_img,method = "raster")
    
    eval_Sen <- imSensitivity(gt_img,seg_img)
    eval_Spec <- imSpecificity(gt_img,seg_img)
    eval_Pre <- imPrecision(gt_img,seg_img)
    eval_Acc <- imAccuracy(gt_img,seg_img)
    eval_Oratio <- imOratio(gt_img,seg_img)
    
    
    Evaluation_all<-data.frame(
      name=segmented_images$name[i],
      time = segmented_images$times[i],
      fold = segmented_images$folds[i],
      dataType = segmented_images$type[i],
      histogram_binning=histogram_binning,
      lambdas=lambdas,
      sigmas=sigmas,
      color=color,
      amplitude=amplitude,
      weighType=weighType,
      Sensitivity=eval_Sen,
      Specificity=eval_Spec,
      Precision = eval_Pre,
      Accuracy=eval_Acc,
      Oratio=eval_Oratio
    )
    return(Evaluation_all)

  })
  
  stopCluster(clus)
  gc()
  
  # get all Evaluation
  Evaluate_result<-bind_rows(Evaluation_all) 
 
  #names(Evaluate_result)<-c("name","time","fold","dataType","histogram_binning","lambdas",
  #                         "sigmas","color","amplitude","weighType","Sensitivity","Specificity","Precision","Accuracy","Oratio")

  Evaluate_result <- reshape(Evaluate_result, direction="long", varying=list(names(Evaluate_result)[11:15]), 
                             v.names="Evaluation_rate", 
                             idvar=c("name","time","fold","dataType","histogram_binning","lambdas",
                                     "sigmas","color","amplitude"),timevar="Evaluation_method",
                             times = c("Sensitivity","Specificity","Precision","Accuracy","Oratio"))
  
  Evaluate_result$Evaluation_method <- gsub( "Sensitivity" ,"Sensitivity (TPR)",Evaluate_result$Evaluation_method )
  Evaluate_result$Evaluation_method <- gsub( "Specificity" ,"Specificity (TNR)",Evaluate_result$Evaluation_method )
  Evaluate_result$Evaluation_method <- gsub( "Precision" ,"Precision (PPV)",Evaluate_result$Evaluation_method )
  Evaluate_result$Evaluation_method <- gsub( "Accuracy" ,"Accuracy (ACC)",Evaluate_result$Evaluation_method )
  
  Evaluate_result$Evaluation_method <- factor(Evaluate_result$Evaluation_method, 
                                              levels = c("Sensitivity (TPR)", "Specificity (TNR)",
                                                         "Precision (PPV)","Accuracy (ACC)","Oratio"))
  

  # get RIMONE r1 class information
  if(dataset=="RIMONE r1")
  {
    InfoPath <- "../Dataset/RIM_ONE_r1/All_Resize/10/info.csv"
    Info <- read.csv(InfoPath)
    class <-Info$class[match(Evaluate_result$name,Info$name)]
    Evaluate_result$class <- class
    Evaluate_result$class <- factor(Evaluate_result$class, levels = c("Normal", "Early", "Moderate","Deep","OHT"))
  }
  
  # create evaluation results directory
  savePath <- paste(result_path ,"/evaluation/",sep="")
  if(!file.exists(savePath)){
    dir.create(savePath)
  }
  
  
  write.csv(Evaluate_result,file = paste(savePath,experiment_name,"_Evaluate_result.csv",sep=""))
  
  sum_all <- summarySE(Evaluate_result, measurevar="Evaluation_rate", groupvars=c("Evaluation_method"))
  sum_all$sum <- paste(format(round(sum_all$Evaluation_rate,3), nsmall = 3),
                       "$","//","pm","$",format(round(sum_all$ci,3), nsmall = 3),sep="")
  sum_all<-sum_all[c("N","Evaluation_method","sum")]
  sum_all <- reshape(sum_all, idvar = "N", timevar = "Evaluation_method", direction = "wide")
  write.csv(sum_all,file = paste(savePath,experiment_name,"_Summary_All.csv",sep=""))
  

  source('../R/Plot/OratioPlot.R')
  OratioPlot(savePath,experiment_name,Evaluate_result)
  
  source('../R/Plot/PlotByClass.R')
  PlotByClass(savePath,experiment_name,Evaluate_result)
  
  source('../R/Plot/MinMedMax.R')
  MinMedMax(savePath,experiment_name,segmented_images,Evaluate_result)
  
}#function

