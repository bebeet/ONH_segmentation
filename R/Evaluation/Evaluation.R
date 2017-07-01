
# load R function
source('../R/Graphcut/getImageData.R')

Evaluation <- function(
  segmented_images_folder,
  masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
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

  
  if(runningTrainData){type <- c("train","test")}
  else{  type <- c("test")}
  
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
                               Oratio=c(),
                               Accuracy=c(),
                               Sensitivity=c(),
                               Specificity=c(),
                               Precision = c()

  )
  for (t in 1:times)
  {
    for( ty in 1:length(type))
    {
      for (f in 1:numfolds)
      {
        # Retrive all segmented image and groundtruth
        segmented_images_path = paste('../Results/',segmented_images_folder,'/T',t,'/',type[ty],'/F',f,'/',sep = "")
        all_seg_img <- list.files(path=segmented_images_path, pattern="*.png") 
        all_gt_img <- gsub(".png",".jpg",all_seg_img)

        for(i in 1:length(all_seg_img))
        {
          # Read images
          seg_img <- EBImage::readImage(paste(segmented_images_path,all_seg_img[i], sep = "/"))
          gt_img <- EBImage::readImage(paste(masks_path,all_gt_img[i], sep = "/"))

          seg_img <-getImageData(seg_img,"mask",type="array") 
          gt_img <-getImageData(gt_img,"mask",type="array") 
          
          #EBImage::display(seg_img,method = "raster")

          eval_Oratio <- imOratio(gt_img,seg_img)
          eval_Acc <- imAccuracy(gt_img,seg_img)
          eval_Sen <- imSensitivity(gt_img,seg_img)
          eval_Spec <- imSpecificity(gt_img,seg_img)
          eval_Pre <- imPrecision(gt_img,seg_img)
          
          Evaluate_result<-rbind(Evaluate_result,
                                 data.frame(
                                   name=gsub(".png","",all_seg_img[i]),
                                   time = t,
                                   fold = f,
                                   dataType = type[ty],
                                   histogram_binning=histogram_binning,
                                   lambdas=lambdas,
                                   sigmas=sigmas,
                                   color=color,
                                   amplitude=amplitude,
                                   weighType=weighType,
                                   Oratio=eval_Oratio,
                                   Accuracy=eval_Acc,
                                   Sensitivity=eval_Sen,
                                   Specificity=eval_Spec,
                                   Precision = eval_Pre))
        
        }#image
      }#numfolds
    }#data type
  }#times
  names(Evaluate_result)<-c("name","time","fold","dataType","histogram_binning","lambdas",
                            "sigmas","color","amplitude","weighType","Oratio","Accuracy","Sensitivity","Specificity","Precision")
  Evaluate_result <- reshape(Evaluate_result, direction="long", varying=list(names(Evaluate_result)[11:15]), 
               v.names="Evaluation_rate", 
               idvar=c("name","time","fold","dataType","histogram_binning","lambdas",
                       "sigmas","color","amplitude"),timevar="Evaluation_method",
               times = c("Oratio","Accuracy","Sensitivity","Specificity","Precision"))
  
  if(dataset=="RIMONE r1")
  {
    source('../R/LoadData/getRIMONEImageClassInfo.R')
    Evaluate_result$class <-getRIMONEImageClassInfo(Evaluate_result$name)
  }
  
  
  savePath <- paste("../Results/",segmented_images_folder,"/evaluation/",sep="")
  if(!file.exists(savePath)){
    dir.create(savePath)
  }
  
  
  Evaluate_result$class <- factor(Evaluate_result$class, levels = c("Normal", "Early", "Moderate","Deep","OHT"))

  Evaluate_result$Evaluation_method <- gsub( "Sensitivity" ,"Sensitivity (TPR)",Evaluate_result$Evaluation_method )
  Evaluate_result$Evaluation_method <- gsub( "Specificity" ,"Specificity (TNR)",Evaluate_result$Evaluation_method )
  Evaluate_result$Evaluation_method <- gsub( "Precision" ,"Precision (PPV)",Evaluate_result$Evaluation_method )
  Evaluate_result$Evaluation_method <- gsub( "Accuracy" ,"Accuracy (ACC)",Evaluate_result$Evaluation_method )
  
  Evaluate_result$Evaluation_method <- factor(Evaluate_result$Evaluation_method, 
                                              levels = c("Sensitivity (TPR)", "Specificity (TNR)",
                                                         "Precision (PPV)","Accuracy (ACC)","Oratio"))
  
  write.csv(Evaluate_result,file = paste(savePath,segmented_images_folder,"_Evaluate_result.csv",sep=""))
  sum_all <- summarySE(Evaluate_result, measurevar="Evaluation_rate", groupvars=c("Evaluation_method"))
  sum_all$sum <- paste(format(round(sum_all$Evaluation_rate,3), nsmall = 3),
                       "$","//","pm","$",format(round(sum_all$ci,3), nsmall = 3),sep="")
  
  write.csv(sum_all,file = paste(savePath,segmented_images_folder,"_Summary_All.csv",sep=""))
  
  source('../R/Plot/OratioPlot.R')
  OratioPlot(segmented_images_folder,Evaluate_result)
  
  source('../R/Plot/PlotByClass.R')
  PlotByClass(segmented_images_folder,Evaluate_result)
  
  #source('../R/Plot/MinMedMax.R')
  #MinMedMax(segmented_images_folder,Evaluate_result)
  
}#function

