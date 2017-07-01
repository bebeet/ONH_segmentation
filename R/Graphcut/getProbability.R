###############################################################################
# Assign regional weight according to trained probabilitI distribution of intensitI (histogram) 

## input : intensitI value, lambda, trained probabilitI distribution of intensitI (histogram)
## output : matched value from trained histogram
###############################################################################

getProbability <- function(I,trainedHistogram,numbin,region=c("Source","Sink"))
{
  perbin <- 1/numbin
  bins <- apply(as.data.frame(c(I)), 1, cut,c(-Inf,seq(perbin,1-perbin, perbin), Inf),labels=0:(numbin-1))
  if(region=="Source")
  {
    wl <-  trainedHistogram$probs[trainedHistogram$intensity_level ==bins & trainedHistogram$label == 1]
  }
  if(region=="Sink")
  {
    wl <-  trainedHistogram$probs[trainedHistogram$intensity_level ==bins & trainedHistogram$label == 0]
  }
  
  return(wl)
}