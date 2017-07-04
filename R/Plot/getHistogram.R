result_path<-"../../Experiment results/"
folder <-"Binning Experiment"
subfolder<-"gray"


folder_name <- list.dirs(path=paste(result_path,folder,sep=""),full.names = FALSE, recursive = FALSE)
fname <- subset(folder_name,grepl(subfolder,folder_name))

savePath <- paste(result_path,folder,'/Histogram/',sep="")
if(!file.exists(savePath)){
  dir.create(savePath)
}

for(t in 1:length(fname))
{

  currentfiles<-paste(result_path,folder,'/',fname[t],"/T1/F1_gray_histogram.Rdata",sep="")
  newlocation <-paste(savePath,"/",fname[t],"_gray_histogram.Rdata",sep="")
  file.copy(from=currentfiles, to=newlocation, 
            recursive = FALSE, 
            copy.mode = TRUE)
}