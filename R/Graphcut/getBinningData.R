###############################################################################
## input : image
## output : divided image intensity into 10 bin histogram
##############################################################################

getBinningData <- function(image_df,numbin)
{
  # Split image intensity into n-bin
  perbin <- 1/numbin
  bins <- apply(as.data.frame(image_df$intensity_level), 1, cut,c(-Inf,seq(perbin,1-perbin, perbin), Inf), labels=0:(numbin-1))
  image_df$intensity_level <-bins
  return(image_df)
}