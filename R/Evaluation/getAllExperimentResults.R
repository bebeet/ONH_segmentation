
result_path<-"../../Experiment results/"
folder <-"Binning Experiment"
savename <- "orihinal_binning.csv"

fname <- list.dirs(path=paste(result_path,folder,sep=""),full.names = FALSE, recursive = FALSE)


All<-data.frame()
for(t in 1:length(fname))
{
  eval_file<- read.csv(paste(result_path,folder,
                             "/",fname[t],"/evaluation/",fname[t],"_Evaluate_result.csv"
                             ,sep=""))
  All<-rbind(All,eval_file)
  
}
write.csv(All,file = paste(result_path,savename,sep=""))

