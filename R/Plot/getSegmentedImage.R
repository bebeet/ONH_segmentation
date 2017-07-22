result_path<-"/home/punsiriboo/thesis_workspace/Experiment results/"
folder <-"ColorSpace_Gauss"
subfolder<-"*"
runningTrainData <- FALSE
getImageName<-c("Im001","Im013","Im103","Im035","Im135","Im053","Im077","Im138","Im141",
                "Im019","Im045")

folder_name <- list.dirs(path=paste(result_path,folder,sep=""),full.names = FALSE, recursive = FALSE)
fname <- subset(folder_name,grepl(subfolder,folder_name))

savePath <- paste(result_path,folder,'/SelectedImage/',sep="")
if(!file.exists(savePath)){
  dir.create(savePath)
}

for(t in 1:length(fname))
{
  foldData<- read.csv(paste(result_path,folder,"/",fname[t],"/foldsDatas.csv",sep=""))
  if(runningTrainData){type <- c("train","test")}
  else{  type <- c("test")}
  
  segmented_images <- foldData[ which(foldData$type %in% type),]
  segmented_images$segment_path <- paste(result_path,folder,
                                         "/",fname[t],"/T",segmented_images$time,"/",
                                         segmented_images$type,"/F",segmented_images$folds,"/",segmented_images$name,".png",sep="")
  for(im in 1:length(getImageName))
  {
    im_path<-subset(segmented_images,as.character(name)== getImageName[im],select=c(segment_path))
    images <- EBImage::readImage(im_path$segment_path[1])
    EBImage::writeImage(images,
                        paste(savePath,"/",getImageName[im],"_",
                              fname[t],".jpg",sep=""), quality = 100)
  }
  
  
  
}

