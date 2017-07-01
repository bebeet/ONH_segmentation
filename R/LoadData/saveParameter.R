
saveParameter <- function(result_path,times,numfolds,runningTrainData,lambdas,sigmas,histogram_binning,color,weighType,amplitude)
{
  times=times
  numfolds =numfolds
  runningTrainData = runningTrainData
  lambdas=lambdas
  sigmas=sigmas
  histogram_binning=histogram_binning
  color=color
  weighType=weighType
  amplitude=amplitude
  save(times,numfolds,runningTrainData,lambdas,sigmas,histogram_binning,color,weighType,amplitude,
         file=paste(result_path,"/ExperimentsData.Rdata",sep=""))
}
