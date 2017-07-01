###############################################################################
# Online calculation of boundary term from neighboring pixel

## input : image,sigma value
## output : nLink weight (boundary term)
###############################################################################

# load R function

source('../R/Graphcut/getNeighbors.R')
source('../R/Graphcut/computeSimilarity.R')
source('../R/Graphcut/computeDist.R')

computeBoundaryTerm <- function(img,sigma)
{
  #time <- Sys.time()
  width <- dim(img)[1]
  height <- dim(img)[2]

  # get list of neighboring pixel
  neigh <- getNeighbors(width,height,TRUE)
  nLink <- getNeighbors(width,height,TRUE)

  # split task to run in parallel
  nclust = 3
  neigh <- lapply(
    1:nclust
    , function(n){
      x <- rep(1:nclust, nrow(neigh)/nclust)
      neigh[x==n,]
    }
  )
  
  # run the cluster
  # initiate 3 cluster
  cl <- makeCluster(3)
  
  # export img and computeSimilarity function to cluster 
  clusterExport(cl,c("img","neigh","computeSimilarity","computeDist"),envir=environment())
  
  neigh.similarity <- parLapply(cl, neigh, function(df){
    apply(df,1, computeSimilarity)
  })
  
  neigh.dist <- parLapply(cl, neigh, function(df){
    apply(df,1, computeDist)
  })
  

  stopCluster(cl)
  gc()
  
  #time[2] <- Sys.time()
  #print(time[2]-time[1])
  
  nLink$similarity <- melt(neigh.similarity)$value
  nLink$dist <- melt(neigh.dist)$value
  nLink$weight <- exp((-1*(nLink$similarity))/(2*(sigma^2)*nLink$dist))

  return(nLink)
}







