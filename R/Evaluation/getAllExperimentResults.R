

folder <-"lamda_experiment"
savename <- "lamda_experiment.csv"

fname <- list.dirs(path=paste("../Results/",folder,sep=""),full.names = FALSE, recursive = FALSE)


All<-data.frame()
for(t in 1:length(fname))
{
  eval_file<- read.csv(paste("../Results/",folder,
                             "/",fname[t],"/evaluation/",fname[t],"_Evaluate_result.csv"
                             ,sep=""))
  All<-rbind(All,eval_file)
  
}
write.csv(All,file = paste("../Results/",savename,sep=""))

