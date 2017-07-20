###############################################################################
# Calculate 8-Neighbors and return node-id telling neighboring combination 
# The result will be used for calculate in Boundary term

## input : width,height
## output : dataframe telling who neighboring from which id to which id (p,q)
###############################################################################

library(reshape2)
getNeighbors <- function(width,height,order=FALSE)
{
  
  #guide index of image
  mat<-matrix(seq(width*height), ncol = width, nrow = height)
  if(order == TRUE)
  {  mat<-matrix(seq(width*height), ncol = width, nrow = height,byrow = TRUE) }
  
  lookup <- melt(mat)
  #print(mat)
  # Direction implementation for 8-neigbors
  # Select 
  #(NW)(N)[NE]
  #(W)     [E]
  #(SW)[S][SE]
  
  #North Direction
  N_mat <- rbind(matrix(0,1,width),mat)
  N_mat <- N_mat[-(height+1),]
  #print(N_mat)
  
  N_neighbors <- data.frame(node_p=melt(mat)$value,node_q=melt(N_mat)$value)
  N_neighbors <- N_neighbors[ which(N_neighbors$node_q!=0),]
  #print("North neighbors Direction")
  #print(N_neighbors)
  
  #North North West  Direction
  NNW_mat <- rbind(matrix(0,2,width),mat)
  NNW_mat <- cbind(matrix(0,height+2),NNW_mat)
  NNW_mat <- NNW_mat[-c((height+1):(height+2)),-(width+1)]
  #print(NNW_mat)
  
  NNW_neighbors <- data.frame(node_p=melt(mat)$value,node_q=melt(NNW_mat)$value)
  NNW_neighbors <- NNW_neighbors[ which(NNW_neighbors$node_q!=0),]
  #print("North neighbors Direction")
  #print(NNW_neighbors)
  
  #West Direction
  W_mat <- cbind(matrix(0,height),mat)
  W_mat <- W_mat[,-(width+1)]
  #print(W_mat)
  
  W_neighbors <- data.frame(node_p=melt(mat)$value,node_q=melt(W_mat)$value)
  W_neighbors <- W_neighbors[ which(W_neighbors$node_q!=0),]
  #print("West neighbors Direction")
  #print(W_neighbors)
  
  #Northwest Direction
  NW_mat <- rbind(matrix(0,1,width),mat)
  NW_mat <- cbind(matrix(0,height+1),NW_mat)
  NW_mat <- NW_mat[-(height+1),-(width+1)]
  #print(NW_mat)
  
  NW_neighbors <- data.frame(node_p=melt(mat)$value,node_q=melt(NW_mat)$value)
  NW_neighbors <- NW_neighbors[ which(NW_neighbors$node_q!=0),]
  #print("Northwest neighbors Direction")
  #print(NW_neighbors)
  
  #West Northwest Direction
  WNW_mat <- rbind(matrix(0,1,width),mat)
  WNW_mat <- cbind(matrix(0,height+1,2),WNW_mat)
  WNW_mat <- WNW_mat[-(height+1),-(c((width+1):(width+2)))]
  #print(WNW_mat)
  
  WNW_neighbors <- data.frame(node_p=melt(mat)$value,node_q=melt(WNW_mat)$value)
  WNW_neighbors <- WNW_neighbors[ which(WNW_neighbors$node_q!=0),]
  #print("West Northwest neighbors Direction")
  #print(WNW_neighbors)
  
  #Southwest Direction
  SW_mat <- rbind(mat,matrix(0,1,width))
  SW_mat <- cbind(matrix(0,height+1),SW_mat)
  SW_mat <- SW_mat[-1,-(width+1)]
  #print(SW_mat)
  
  SW_neighbors <- data.frame(node_p=melt(mat)$value,node_q=melt(SW_mat)$value)
  SW_neighbors <- SW_neighbors[ which(SW_neighbors$node_q!=0),]
  #print("Southwest neighbors Direction")
  #print(SW_neighbors)
  
  #West Southwest Direction
  WSW_mat <- rbind(mat,matrix(0,1,width))
  WSW_mat <- cbind(matrix(0,height+1,2),WSW_mat)
  WSW_mat <- WSW_mat[-1,-(c((width+1):(width+2)))]
  #print(WSW_mat)
  
  WSW_neighbors <- data.frame(node_p=melt(mat)$value,node_q=melt(WSW_mat)$value)
  WSW_neighbors <- WSW_neighbors[ which(WSW_neighbors$node_q!=0),]
  #print("West Southwest neighbors Direction")
  #print(WSW_neighbors)
  
  #South Southwest Direction
  SSW_mat <- rbind(mat,matrix(0,2,width))
  SSW_mat <- cbind(matrix(0,height+2),SSW_mat)
  SSW_mat <- SSW_mat[-c((height-2):(height-1)),-(width+1)]
  #print(SSW_mat)
  
  SSW_neighbors <- data.frame(node_p=melt(mat)$value,node_q=melt(SSW_mat)$value)
  SSW_neighbors <- SSW_neighbors[ which(SSW_neighbors$node_q!=0),]
  #print("South Southwest neighbors Direction")
  #print(SSW_neighbors)
  
  #Combine all direction to neighbors dataframe
  neighbors <- data.frame(node_p=c(),node_q=c())
  neighbors <- rbind(neighbors,N_neighbors)
  #neighbors <- rbind(neighbors,NNW_neighbors)
  #neighbors <- rbind(neighbors,WNW_neighbors)
  neighbors <- rbind(neighbors,W_neighbors)
  neighbors <- rbind(neighbors,NW_neighbors)
  neighbors <- rbind(neighbors,SW_neighbors)
  #neighbors <- rbind(neighbors,WSW_neighbors)
  #neighbors <- rbind(neighbors,SSW_neighbors)
  
  neighbors$px <- lookup$Var1[match(neighbors$node_p,lookup$value)]
  neighbors$py <- lookup$Var2[match(neighbors$node_p,lookup$value)]
  
  neighbors$qx <- lookup$Var1[match(neighbors$node_q,lookup$value)]
  neighbors$qy <- lookup$Var2[match(neighbors$node_q,lookup$value)]
  
  return(neighbors)
}