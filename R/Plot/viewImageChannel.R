library(EBImage)
library(CRImage)
library(reshape2)
library(EBImage)
# load R function
source("../R/Graphcut/getImageData.R")


viewImageChannel <- function(path,channel= c("gray","red","green","blue","H","S","V","L",
                                             "A","B","O1","O2","O3","LAB","HSV","Opponent","RGB"),
                             isSave = FALSE,
                             save_path) 
{

  ch <-  match.arg(channel)

  img <- EBImage::readImage(path)
  width <- dim(img)[1]
  height <- dim(img)[2]
  
  if(ch %in% c("gray","red","green","blue","H","S","V","L",
               "A","B","O1","O2","O3"))
  {
    img<-getImageData(
      img,ch,"array"
    )
    selectedImg<-as.Image(img)
    colorMode(selectedImg) <- "Grayscale"
  }

  if(ch =="HSV")
  {

    H <- CRImage::convertRGBToHSV(img)[,,1]/360
    S <- CRImage::convertRGBToHSV(img)[,,2]
    V <- CRImage::convertRGBToHSV(img)[,,3]
    selectedImg <- array( c( H , S, V ) , dim = c( width,height,3))
    selectedImg<-as.Image(selectedImg)
    colorMode(selectedImg) <- "Color"
    
  }
  if(ch =="LAB")
  {


    H <- normalizeData(CRImage::convertRGBToLAB(img)[,,1])
    S <- normalizeData(CRImage::convertRGBToLAB(img)[,,2])
    V <- normalizeData(CRImage::convertRGBToLAB(img)[,,3])
    selectedImg <- array( c( H , S, V ) , dim = c( width,height, 3 ) )
    selectedImg<-as.Image(selectedImg)
    colorMode(selectedImg) <- "Color"
  }
  if(ch =="Opponent")
  {
    
    R_images <- EBImage::channel(img, "red")
    G_images <- EBImage::channel(img, "green")
    B_images <- EBImage::channel(img, "blue")
    O1 <- normalizeData((R_images - G_images)/sqrt(2))
    O2 <- normalizeData((R_images + G_images + B_images)/sqrt(3))
    O3 <- normalizeData((R_images + G_images + B_images)/sqrt(3))
    selectedImg <- array(c(O1,O2,O3), dim=c(width,height,3))
    selectedImg<-as.Image(selectedImg)
    colorMode(selectedImg) <- "Color"
  }
  
  #print(selectedImg)
  #print(summary(melt(selectedImg)))
  #EBImage::display(selectedImg,method = "raster")
  
  if(isSave==TRUE)
  {               
    EBImage::writeImage(selectedImg,save_path, quality = 100)
  }

}

color<-c("gray","red","green","blue","H","S","V","L",
         "A","B","O1","O2","O3")
for(c in 1:length(color))
{
  images_path = paste('../Dataset/RIM_ONE_r1/All_Resize/10/original',sep = "")
  all_img <- list.files(path=images_path, pattern="*.jpg") 
  
  savePath <- paste("../Dataset/RIM_ONE_r1/All_Resize/10/","original_",color[c],sep="")
  if(!file.exists(savePath)){
    dir.create(savePath)
  }
  for(i in 1:length(all_img))
  {
    print(paste(images_path,"/",all_img[i],sep=""))

    viewImageChannel(paste(images_path,"/",all_img[i],sep=""),
                     channel=color[c],
                     isSave = TRUE,
                     save_path=paste(savePath,"/",all_img[i],sep=""))
    
  }
  
}
