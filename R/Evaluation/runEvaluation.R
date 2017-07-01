folder<-""
fname <- list.dirs(path=paste("../Results/",folder,sep=""),full.names = FALSE, recursive = FALSE)
fname <- subset(fname,grepl( "dis",fname))

for(t in 1:length(fname))
{
  load(paste("../Results/",fname[t],"/ExperimentsData.Rdata",sep=""))
  Evaluation(
    fname[t], #segmented folder name
    masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
    dataset="RIMONE r1",
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
}

