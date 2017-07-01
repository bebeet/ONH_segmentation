MinMedMax  <- function(segmented_images_folder,Evaluate_result)
{
  
  savePath <- paste('../Results/',segmented_images_folder,'/evaluation/',sep="")
  sum_byName <- summarySE(Evaluate_result, measurevar="Evaluation_rate", groupvars=c("Evaluation_method","name"))
  sum_byName$sum <- paste(round(sum_byName$Evaluation_rate,3),"$","//","pm","$",round(sum_byName$ci,3),sep="")
  
  eval_method<-unique(sum_byName$Evaluation_method)
  result <-data.frame(name=c(), Evaluation_method = c(), MinMaxValue = c())
  for(i in 1:length(eval_method))
  {
    min <- sum_byName$name[ which(sum_byName$Evaluation_method==eval_method[i]
                                 & sum_byName$Evaluation_rate == min(sum_byName$Evaluation_rate) ), ]
    med <- sum_byName$name[ which(sum_byName$Evaluation_method==eval_method[i]
                                 & sum_byName$Evaluation_rate == median(sum_byName$Evaluation_rate) ), ]
    max <- sum_byName$name[ which(sum_byName$Evaluation_method==eval_method[i]
                                 & sum_byName$Evaluation_rate == max(sum_byName$Evaluation_rate) ), ]
    result<-rbind(result,data.frame(name=min,Evaluation_method = eval_method[i], MinMaxValue = "min"))
    result<-rbind(result,data.frame(name=med,Evaluation_method = eval_method[i], MinMaxValue = "med"))
    result<-rbind(result,data.frame(name=max,Evaluation_method = eval_method[i], MinMaxValue = "max"))
  }
  write.csv(result,file = paste(savePath,'../Results/',segmented_images_folder,"_MinMedMax.csv",sep=""))
  

}