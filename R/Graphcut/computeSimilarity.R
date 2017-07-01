
computeSimilarity <- function(x){
  
  if(dim(img)[3]==1)
  {
    return(dist(rbind(
      img[seq(x['node_p'],length.out=dim(img)[3],by=length(img)/dim(img)[3])] 
      ,img[seq(x['node_q'],length.out=dim(img)[3],by=length(img)/dim(img)[3])] 
    ), upper=TRUE)^2)
  }
  
  if(dim(img)[3]==3)
  {
    return(dist(rbind(
      img[seq(x['node_p'],length.out=dim(img)[3],by=length(img)/dim(img)[3])] 
      ,img[seq(x['node_q'],length.out=dim(img)[3],by=length(img)/dim(img)[3])] 
    ), upper=TRUE))
  }
  

}