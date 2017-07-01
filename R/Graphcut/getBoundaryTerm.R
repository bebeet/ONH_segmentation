# load R function
source('../R/Graphcut/getImageData.R')
source('../R/Graphcut/computeBoundaryTerm.R')

getBoundaryTerm <- function(path,sigmaValue=1,colorMode = c("gray",
                                     "H","S","V","L","A","B","O1","O2","O3","blue","green","red","RGB","HSV","LAB","Opponent"),
                            save_path)
{
  weight.colorModel <-  match.arg(colorMode)
  #print(paste("n-link weight implementation on ",weight.colorModel))
  
  img <- EBImage::readImage(path)
  width <- dim(img)[1]
  height <- dim(img)[2]
  
  img <-getImageData(img,weight.colorModel,type="array") 
  nLink <- computeBoundaryTerm(img,sigmaValue)
  imname <- tail(unlist(strsplit(path, "/")), n=1)
  imname <-gsub(".jpg","",imname)
  write.csv(nLink,file = paste(save_path,"/",imname,"_nLink.csv",sep=""))
  return(nLink)
  
}