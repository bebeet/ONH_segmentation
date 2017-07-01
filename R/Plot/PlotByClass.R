PlotByClass <- function(segmented_images_folder,Evaluate_result)
{
  savePath <- paste('../Results/',segmented_images_folder,'/evaluation/',sep="")
  
  sum_byClass <- summarySE(Evaluate_result, measurevar="Evaluation_rate", groupvars=c("Evaluation_method","class"))
  sum_byClass$sum <- paste(round(sum_byClass$Evaluation_rate,3),"$","//","pm","$",round(sum_byClass$ci,3),sep="")
  write.csv(sum_byClass,file = paste(savePath,segmented_images_folder,"_Summary_byClass.csv",sep=""))
  df <- sum_byClass[ which(sum_byClass$Evaluation_method!='Oratio'), ]
  df$class <- factor(df$class, levels = c("Normal", "Early", "Moderate","Deep","OHT"))

  jpeg(file=paste(savePath,segmented_images_folder,"_Summary_byClass.jpg",sep=""),
       units="in", width=5, height=4,res=300)
    p<-ggplot(df, aes(class,Evaluation_rate)) + geom_point(size=2)+
      theme(axis.title.x=element_blank())+
      theme(axis.title.y=element_blank())+
      facet_wrap(~Evaluation_method,ncol=2) +
      geom_errorbar(aes(ymin=Evaluation_rate-ci, ymax=Evaluation_rate+ci),width=0.5)+  
      labs(y="Evaluation rate", x="Class") +
      theme(text=element_text(family="Times New Roman"))+
      theme(strip.text.x = element_text(size = 12))+
      theme(strip.text.y = element_text(size = 12))
    print(p)
  dev.off()
  
  
  
  df <- Evaluate_result[ which(Evaluate_result$Evaluation_method!='Oratio'), ]
  jpeg(file=paste(savePath,segmented_images_folder,"_Boxplot_byClass.jpg",sep=""),
       units="in", width=6, height=4,res=300)
  p<-ggplot(df, aes(class,Evaluation_rate))+ geom_boxplot()+
     facet_wrap(~Evaluation_method,ncol=2) +
     theme(strip.text.y = element_text(size = 10))+
     labs(y="Evaluation rate")
  print(p)
  dev.off()
  
  
}