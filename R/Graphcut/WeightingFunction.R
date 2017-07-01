
WeightingFunction <- function(maskList,save_name,t,f,wtype=c("GAUSSIAN","LAPLACIAN"),amp=1)
{  
  type = match.arg(wtype)

  source('../R/Graphcut/getImageData.R')
  e = 2.71828182846

  mask_path=maskList[1]
  mask_image = EBImage::readImage(mask_path)
  width=dim(mask_image)[1]
  height=dim(mask_image)[2]
  trainingList=1:length(maskList)
  
  estimateParameter <- function(maskList)
  {
    # Parameter estimatimation for weighting function
    
    # run the cluster
    # initiate 3 cluster
    clus <- makeCluster(3)
    # export img and function to cluster 
    clusterExport(clus,c("maskList","getImageData"),envir=environment())
    clusterEvalQ(clus, library(reshape2))
    clusterEvalQ(clus, library(EBImage))
    clusterEvalQ(clus, library(RTOMO))
    
    # get all training image data position in x dimesion
    ImgDatas_x <- parLapply(clus,trainingList,function(i){
      mask_path <- maskList[i]
      mask_image<-EBImage::readImage(mask_path)
      ImgData <- getImageData(mask_image,"mesh_x")
      return(ImgData)
    })
    
    ImgDatas_y <- parLapply(clus,trainingList,function(i){
      mask_path <- maskList[i]
      mask_image <-EBImage::readImage(mask_path)
      ImgData <- getImageData(mask_image,"mesh_y")
      return(ImgData)
    })
    
    stopCluster(clus)
    gc()
    
    dir_x<-bind_rows(ImgDatas_x) 
    mu_x <- mean(dir_x[which(dir_x$Intensity==1),]$nodeid)
    sigma_x <- sd(dir_x[which(dir_x$Intensity==1),]$nodeid)
    
    dir_y<-bind_rows(ImgDatas_y)
    mu_y <- mean(dir_y[which(dir_y$Intensity==1),]$nodeid)
    sigma_y <- sd(dir_y[which(dir_y$Intensity==1),]$nodeid)
    
    return(list(mu_x,sigma_x,mu_y,sigma_y))
  }

  getGuassian<-function(amplitude,width,height,mu_x,mu_y,sigma_x,sigma_y)
  {
    x = -mw:mw
    y = -mh:mh
    mesh <- meshgrid(x, y)
    
    sigma_sq_x = sigma_x^2
    sigma_sq_y = sigma_y^2
    
    x_dir = (((mesh$x-mu_x)^2)/(2*sigma_sq_x))
    y_dir = (((mesh$y-mu_y)^2)/(2*sigma_sq_y))
    res = e^(-(x_dir+y_dir))
    res = (1/((sqrt(2*pi))*sigma_x*sigma_y))*res
    res = res*amplitude
    matPlt <-res
    
    if(ncol(res)>width)
    {
      res <- res[,-ncol(res)]
    }
    if(nrow(res)>height)
    {
      res <- res[-nrow(res),]
    }
    #print(res)
    mat <<- matrix(seq(width*height), ncol = width, nrow = height,byrow=TRUE)
    #print(mat)
    res <- data.frame(nodeid=melt(mat)$value,weight = melt(res)$value)
    res <- res[order(res$nodeid),] 
    res$nodeid <- res$nodeid-1 
    #print(res)
    return(list(res,matPlt))
    
  }
  
  getLaplacian<-function(amplitude,width,height,mu_x,mu_y,sigma_x,sigma_y)
  {      
    type<<-"Laplacian"
    x = -mw:mw
    y = -mh:mh
    mesh <- meshgrid(x, y)
    
    sigma_sq_x = ratio*sigma_x^2
    sigma_sq_y = ratio*sigma_y^2
    
    x_dir = (((mesh$x-mu_x)^2)/(2*sigma_sq_x))
    y_dir = (((mesh$y-mu_y)^2)/(2*sigma_sq_y))
    res1 = 1/(pi*(sigma_sq_x*sigma_sq_y))
    res2 = 1-(x_dir+y_dir)
    res3 = e^(-(x_dir+y_dir))
    res = res1*res2*res3
    res = res*amplitude
    matPlt <-res
    
    if(ncol(res)>width)
    {
      res <- res[,-ncol(res)]
    }
    if(nrow(res)>height)
    {
      res <- res[-nrow(res),]
    }
    #print(res)
    mat <<- matrix(seq(width*height), ncol = width, nrow = height,byrow=TRUE)
    #print(mat)
    res <- data.frame(nodeid=melt(mat)$value,weight = melt(res)$value)
    res <- res[order(res$nodeid),] 
    res$nodeid <- res$nodeid-1  
    return(list(res,matPlt))
  }

  saveWeightingFunction=function(wf,save_name,t,f)
  {
    file_path = paste('../Results/',save_name,'/T',t,'/F',f,'_',type,'_weightingFunction.Rdata',sep="")
    save(wf,file=file_path) 
  }
  
  paramters <- estimateParameter(maskList)
  mu_x=paramters[[1]]
  variance_x=paramters[[2]]
  
  mu_y=paramters[[3]]
  variance_y=paramters[[4]]


  mw = floor(width/2)
  mh = floor(height/2)
  
  if(type == "GAUSSIAN")
  {result = getGuassian(amp,width,height,mu_x,mu_y,variance_x,variance_y)}

  if(type== "LAPLACIAN")
  {result = getLaplacian(amp,width,height,mu_x,mu_y,variance_x,variance_y)}
  

  me <- list(
    type=match.arg(wtype),
    width=width,
    height= height,
    mu_x=mu_x,
    mu_y=mu_y,
    variance_x=variance_x,
    variance_y=variance_y,
    amplitude=amp,
    weight=result[[1]],
    mat=result[[2]],

    showPlot =function()
    { matPlt=result[[2]]
      if(!is.null(matPlt))
      {
        color.palette <- colorRampPalette(c("white", "blue"))
        print(summary(melt(matPlt)))
        print(levelplot(matPlt, main=paste("2d-",type," distribution",sep=""),
                        col.regions=color.palette))
        
        df <- data.frame(x= -mw:mw,y= matPlt[mw,])
        plt<-ggplot(data = df,aes(x=df$x, y=df$y)) +
          geom_line()+
          geom_point()+
          geom_hline(yintercept=0)+
          labs(title=paste("Plot of 1d ",type," X-asix "," Variance =",round(variance_x,3), "Mean = ",round(mu_x,3)),
               x = "pixel",y = "weight")+
          theme(text=element_text(family="Times New Roman", size=12))
        print(plt)
        
        df <- data.frame(x= -mw:mw,y= matPlt[,mw])
        plt<-ggplot(data = df,aes(x=df$x, y=df$y)) +
          geom_line()+
          geom_point()+
          geom_hline(yintercept=0)+
          labs(title=paste("Plot of 1d ",type," Y-asix "," Variance =",round(variance_y,3), "Mean = ",round(mu_y,3)),
               x = "pixel",y = "weight")+
          theme(text=element_text(family="Times New Roman", size=12))
        print(plt)
      }
      else
      {
          print("Please running getGaussain/getLaplacian")
      }
    }
    
  )

  ## Set the name for the class
  class(me) <- append(class(me),"WeightingFunction")
  saveWeightingFunction(me,save_name,t,f)
  return(me)
}

WeightingFunction.load <- function(loadPath)
{
  return(load(loadPath))
}