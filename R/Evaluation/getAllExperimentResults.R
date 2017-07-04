
result_path<-"../../Experiment results/"
folder <-"Lamda Experiment"
savename <- "lamda_all_evaluation.csv"
subfolder <- "lam"

fname <- list.dirs(path=paste(result_path,folder,sep=""),full.names = FALSE, recursive = FALSE)
fname <- subset(fname,grepl(subfolder,fname))

All<-data.frame()
for(t in 1:length(fname))
{
  eval_file<- read.csv(paste(result_path,folder,
                             "/",fname[t],"/evaluation/",fname[t],"_Evaluate_result.csv"
                             ,sep=""))
  All<-rbind(All,eval_file)
  
}
write.csv(All,file = paste(result_path,savename,sep=""))

