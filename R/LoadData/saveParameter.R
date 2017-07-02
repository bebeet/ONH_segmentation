
saveParameter <- function(result_path,image_path,mask_path,times,numfolds,runningTrainData,lambdas,sigmas,histogram_binning,color,weighType,amplitude)
{
  image_path =image_path
  mask_path=mask_path
  times=times
  numfolds =numfolds
  runningTrainData = runningTrainData
  lambdas=lambdas
  sigmas=sigmas
  histogram_binning=histogram_binning
  color=color
  weighType=weighType
  amplitude=amplitude
  save(image_path,mask_path,times,numfolds,runningTrainData,lambdas,sigmas,histogram_binning,color,weighType,amplitude,
         file=paste(result_path,"/ExperimentsData.Rdata",sep=""))
}
