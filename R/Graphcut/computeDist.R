# compute distance from node to node according to color vector value
computeDist <- function(x){
  dist(rbind(
    c(x['px'],x['py']),
    c(x['qx'],x['qy'])
  ), upper=TRUE)
}