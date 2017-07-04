MinMedMax  <- function(savePath,segmented_images_folder,segmented_images,Evaluate_result)
{
  savePath <- paste(savePath,'/outlier/',sep="")
  if(!file.exists(savePath)){
    dir.create(savePath)
  }
  
  sum_byName <- summarySE(Evaluate_result, measurevar="Evaluation_rate", groupvars=c("Evaluation_method","name","class"))
  sum_byName$sum <- paste(round(sum_byName$Evaluation_rate,3),"$","//","pm","$",round(sum_byName$ci,3),sep="")
  result <-data.frame(name=c(), class=c(),Evaluation_method = c(), MinMaxValue = c())
  
  eval_method<-unique(sum_byName$Evaluation_method)
  img_class<-unique(sum_byName$class)

  for(c in 1:length(img_class))
  {
    sum_byName_Class <- subset(sum_byName, class == img_class[c])
    for(i in 1:length(eval_method))
    {
      sum_byName_Class_Method <- subset(sum_byName_Class, Evaluation_method == eval_method[i])

      min <-subset(sum_byName_Class_Method, Evaluation_rate == min(Evaluation_rate),select=c(name))
      if(length(min$name)!=0 )
      {
        im_path<-subset(segmented_images,as.character(name)== min$name[1],select=c(segment_path))
        images <- EBImage::readImage(im_path$segment_path[1])
        EBImage::writeImage(images,paste(savePath,"/",img_class[c],"_",eval_method[i],"_min_",min$name[1],".jpg",sep=""), quality = 100)
        
        q2 <-sum_byName_Class_Method$name[which.min(abs(sum_byName_Class_Method$Evaluation_rate - quantile(sum_byName_Class_Method$Evaluation_rate,0.25)))]
        if(length(q2!=0))
        {
          im_path<-subset(segmented_images,as.character(name)== q2[1],select=c(segment_path))
          images <- EBImage::readImage(im_path$segment_path[1])
          EBImage::writeImage(images,paste(savePath,"/",img_class[c],"_",eval_method[i],"_q2_",q2[1],".jpg",sep=""), quality = 100)
          
        }
        
        med <-sum_byName_Class_Method$name[which.min(abs(sum_byName_Class_Method$Evaluation_rate - median(sum_byName_Class_Method$Evaluation_rate)))]
        if(length(med!=0))
        {
          im_path<-subset(segmented_images,as.character(name)== med[1],select=c(segment_path))
          images <- EBImage::readImage(im_path$segment_path[1])
          EBImage::writeImage(images,paste(savePath,"/",img_class[c],"_",eval_method[i],"_med_",med[1],".jpg",sep=""), quality = 100)
        }
        
        q4 <-sum_byName_Class_Method$name[which.min(abs(sum_byName_Class_Method$Evaluation_rate - quantile(sum_byName_Class_Method$Evaluation_rate,0.75)))]
        if(length(q4!=0))
        {
          im_path<-subset(segmented_images,as.character(name)== q4[1],select=c(segment_path))
          images <- EBImage::readImage(im_path$segment_path[1])
          EBImage::writeImage(images,paste(savePath,"/",img_class[c],"_",eval_method[i],"_q4_",q4[1],".jpg",sep=""), quality = 100)
          
        }
        
        max <-subset(sum_byName_Class_Method, Evaluation_rate == max(Evaluation_rate),select=c(name))
        if(length(max$name!=0))
        {
          im_path<-subset(segmented_images,as.character(name)== max$name[1],select=c(segment_path))
          images <- EBImage::readImage(im_path$segment_path[1])
          EBImage::writeImage(images,paste(savePath,"/",img_class[c],"_",eval_method[i],"_max_",max$name[1],".jpg",sep=""), quality = 100)
        }
      }
      
      

      result<-rbind(result,data.frame(name=min$name[1],class=img_class[c],Evaluation_method = eval_method[i], MinMaxValue = "min"))
      result<-rbind(result,data.frame(name=q2[1],class=img_class[c],Evaluation_method = eval_method[i], MinMaxValue = "q2"))
      result<-rbind(result,data.frame(name=med[1],class=img_class[c],Evaluation_method = eval_method[i], MinMaxValue = "med"))
      result<-rbind(result,data.frame(name=q4[1],class=img_class[c],Evaluation_method = eval_method[i], MinMaxValue = "q4"))
      result<-rbind(result,data.frame(name=max$name[1],class=img_class[c],Evaluation_method = eval_method[i], MinMaxValue = "max"))
    }
  }
  write.csv(result,file = paste(savePath,segmented_images_folder,"_Outlier.csv",sep=""))

}