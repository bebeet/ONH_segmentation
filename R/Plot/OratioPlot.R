OratioPlot  <- function(savePath,segmented_images_folder,Evaluate_result)
{
  sum_byImg <- summarySE(Evaluate_result, measurevar="Evaluation_rate", groupvars=c("Evaluation_method","name"))
  sum_byImg$sum <- paste(round(sum_byImg$Evaluation_rate,3),"$","//","pm","$",round(sum_byImg$ci,3),sep="")
  write.csv(sum_byImg,file = paste(savePath,segmented_images_folder,"_Summary_byImg.csv",sep=""))
  
  df <- sum_byImg[ which(sum_byImg$Evaluation_method=='Oratio'), ]
  df$name <- as.numeric(gsub("Im","",df$name))
  df$Method <-segmented_images_folder
  
  jpeg(file=paste(savePath,segmented_images_folder,"_Oratio_byImg.jpg",sep=""),
      units="in", width=5, height=4,res=300)
    p<-ggplot(df, aes(name,Evaluation_rate))+ geom_point(size=2, colour = "blue")+
      theme(strip.text.y = element_text(size = 15))+
      facet_wrap(~Method,ncol=1) +
      theme(strip.text.x = element_text(size = 15))+
      theme(axis.title.x=element_blank())+
      theme(axis.title.y=element_blank())+
      theme(text=element_text(family="Times New Roman"))+
      geom_hline(yintercept=c(0.5),linetype="dashed", color = "red" ,size=0.8)+
      scale_y_continuous(breaks = seq(0,1, by = 0.5),limits = c(0, 1))+ 
      labs(y="Oratio", x="Image number")
    print(p)
  dev.off()
}