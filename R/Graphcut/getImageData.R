
# load R function
source("../R/Graphcut/normalizeData.R")

getImageData <- function(img,
                         channel= c("gray","red","green","blue","H","S","V",
                                    "L","A","B","O1","O2","O3","mask","mesh_x","mesh_y",
                                    "RGB","HSV","LAB","Opponent"),
                         type="dataframe") 
{
  width <- dim(img)[1]
  height <- dim(img)[2]
  mat <- matrix(seq(width*height), ncol = width, nrow = height,byrow = TRUE)

  ch <-  match.arg(channel)
  selectedImg <-img

  if(ch=="mask"||ch=="mesh_x"||ch=="mesh_y")
  {selectedImg <- EBImage::channel(img,"gray")
   selectedImg <- apply(apply(selectedImg, 1, cut,c(-Inf,0.5, Inf), labels=seq(0, 1, 1)),1,as.numeric)}
  
  if(ch %in% c("gray","blue","green","red"))
  {selectedImg <- EBImage::channel(img,ch)}
  
  if(ch=="H")
  {selectedImg <- CRImage::convertRGBToHSV(img)[,,1]/360}
  
  if(ch=="S")
  {selectedImg <- CRImage::convertRGBToHSV(img)[,,2]}
  
  if(ch=="V")
  {selectedImg <- CRImage::convertRGBToHSV(img)[,,3]}
  
  if(ch=="L")
  {selectedImg <- normalizeData(CRImage::convertRGBToLAB(img)[,,1])}
  
  if(ch=="A")
  {selectedImg <- normalizeData(CRImage::convertRGBToLAB(img)[,,2])}
  
  if(ch=="B")
  {selectedImg <- normalizeData(CRImage::convertRGBToLAB(img)[,,3])}
  
  if(ch=="O1")
  {  
    R_images <- EBImage::channel(img, "red")
    G_images <- EBImage::channel(img, "green")
    selectedImg <- normalizeData(((R_images - G_images)/sqrt(2)))
  }
  
  if(ch=="O2")
  {  
    R_images <- EBImage::channel(img, "red")
    G_images <- EBImage::channel(img, "green")
    B_images <- EBImage::channel(img, "blue")
    selectedImg <- normalizeData(((R_images + G_images -(2* B_images))/sqrt(6)))
  }
  
  if(ch=="O3")
  {  
    R_images <- EBImage::channel(img, "red")
    G_images <- EBImage::channel(img, "green")
    B_images <- EBImage::channel(img, "blue")
    selectedImg <- normalizeData(((R_images + G_images + B_images)/sqrt(3)))
  }

  if(ch=="RGB")
  {selectedImg<-img}
  
  if(ch=="HSV")
  {selectedImg <- CRImage::convertRGBToHSV(img)  }
  
  if(ch=="LAB")
  {selectedImg <- normalizeData(CRImage::convertRGBToLAB(img))  }
  
  if(ch=="Opponent")
  {
    R_images <- EBImage::channel(img, "red")
    G_images <- EBImage::channel(img, "green")
    B_images <- EBImage::channel(img, "blue")
    O1 <- normalizeData((R_images - G_images)/sqrt(2))
    O2 <- normalizeData(((R_images + G_images -(2* B_images))/sqrt(6)))
    O3 <- normalizeData((R_images + G_images + B_images)/sqrt(3))
    selectedImg <- array(c(O1,O2,O3), dim=c(width,height,3))
  }
  if(ch=="mesh_x")
  {
    mw = floor(width/2)
    mh = floor(height/2)
    x = -mw:mw
    y = -mh:mh
    mesh <- meshgrid(x, y)
    if(ncol(mesh$x)>width)
    {
      mesh$x <- mesh$x[,-ncol(mesh$x)]
    }
    if(nrow(mesh$x)>height)
    {
      mesh$x <- mesh$x[-nrow(mesh$x),]
    }
    ImageData <- data.frame(nodeid=melt(mesh$x)$value,Intensity = melt(selectedImg@.Data)$value)
    return(ImageData)
  }
  
  if(ch=="mesh_y")
  {
    mw = floor(width/2)
    mh = floor(height/2)
    x = -mw:mw
    y = -mh:mh
    mesh <- meshgrid(x, y)
    if(ncol(mesh$y)>width)
    {
      mesh$y <- mesh$y[,-ncol(mesh$y)]
    }
    if(nrow(mesh$y)>height)
    {
      mesh$y <- mesh$y[-nrow(mesh$y),]
    }
    ImageData <- data.frame(nodeid=melt(mesh$y)$value,Intensity = melt(selectedImg@.Data)$value)
    return(ImageData)
  }
  
  if(type=="dataframe")
  {
    ImageData <- data.frame(nodeid=melt(mat)$value,Intensity = melt(transpose(selectedImg@.Data))$value)
    ImageData <- ImageData[order(ImageData$nodeid),] 
    ImageData$nodeid<-ImageData$nodeid-1  
    return(ImageData)
  }
  
  if(type=="array")
  {
    if( ch %in% c("gray","blue","green","red","H","S","V",
                  "L","A","B","O1","O2","O3","mask"))
    {return(array(selectedImg@.Data,dim=c(height,width,1)))}
    else return(selectedImg)
    
  }
 
}