runEvalution <- function(result_prefix,masks_path,folder_name)
{
    fname <- list.dirs(path=paste(result_prefix,sep=""),full.names = FALSE, recursive = FALSE)
    fname <- subset(fname,grepl(folder_name,fname))

    for(t in 1:length(fname))
    {
      load(paste(result_prefix,fname[t],"/ExperimentsData.Rdata",sep=""))
      Evaluation(
        result_path=paste(result_prefix,fname[t],sep=""), #segmented folder name
        masks_path=masks_path,
        experiment_name = fname[t],
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
}




