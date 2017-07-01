###############################################################################
# Train probability distribution of intensity (histogram)

## input : training set and mask,color model
## output : trained histogram intensity
##############################################################################

Histogram <- function(dataTrain,dataTrainMask,save_name,t,f,
                      ColorMode= c("gray", "H","S","V","L","A","B","O1","O2","O3",
                                   "blue","green","red","RGB","HSV","LAB","Opponent"),histogramBinning=10
                      )
{

  source('../R/Graphcut/computeProbability.R')
  source('../R/Graphcut/getColorVector.R')
  source('../R/Graphcut/getImageData.R')
  source('../R/Graphcut/getBinningData.R')
  

  weight.ColorModel <-  match.arg(ColorMode)
  #print(paste("train histogram on",weight.ColorModel))
  
  if(weight.ColorModel %in%  c("gray","blue","green","red","H","S","V","L","A","B","O1","O2","O3"))
  {  
    trainedHistogram <- computeProbability(dataTrain,dataTrainMask,histogramBinning,weight.ColorModel)
  }
  
  if(weight.ColorModel%in%  c("RGB","HSV","LAB","Opponent"))
  { 
    colorVector <- getColorVector(weight.ColorModel)
    trainedHistogram <-lapply(colorVector, function(x) computeProbability(dataTrain,dataTrainMask,histogramBinning,x))
  }
  
  me <- list(
    trainedHistogram = trainedHistogram,
    binning= histogramBinning,
    color = weight.ColorModel
  )
  
  saveHistogram=function(hist,save_name,t,f)
  {
    file_path = paste('../Results/',save_name,'/T',t,'/F',f,'_',weight.ColorModel,'_histogram.Rdata',sep="")
    save(hist,file=file_path) 
  }
  
  
  ## Set the name for the class
  class(me) <- append(class(me),"Histogram")
  saveHistogram(me,save_name,t,f)
  return(me)
}

plotHistogram<-function(hist)
{
  if(hist$color %in%  c("gray","blue","green","red","H","S","V","L","A","B","O1","O2","O3"))
  {  
    plt <- ggplot(data=hist$trainedHistogram, aes(x=intensity_level, y=probs, group=label, colour=label)) +
      geom_line(aes(linetype=label),size=0.8)+
      labs(  x="I" ,y="Pr(I)" )+
      scale_y_continuous(breaks=seq(0,1,0.2))+
      geom_line(aes(linetype=label, color=label),size=0.6)+
      scale_linetype_manual(name="Pr(I)",values=c(1,2),labels=c("Pr(I|'bkg')", "Pr(I|'ohn')"))+
      scale_color_manual(name="Pr(I)",values=c('blue','red'),labels=c("Pr(I|'bkg')", "Pr(I|'ohn')"))+
      theme(text=element_text(family="Times"))+
      theme(strip.text.x = element_text(size = 12))+
      theme(strip.text.y = element_text(size = 12))
    print(plt)
  }
  
  
  if(hist$color %in%  c("RGB","HSV","LAB","Opponent"))
  {     
    colorVector <- getColorVector(hist$color)
    for(i in 1:3)
    {
      plt <- ggplot(data=hist$trainedHistogram[[i]], aes(x=intensity_level, y=probs, group=label, colour=label)) +
        geom_line(aes(linetype=label),size=0.8)+
        labs(  x="I" ,y="Pr(I)" )+
        scale_y_continuous(breaks=seq(0,1,0.2))+
        geom_line(aes(linetype=label, color=label),size=0.6)+
        scale_linetype_manual(name="Pr(I)",values=c(1,2),labels=c("Pr(I|'bkg')", "Pr(I|'ohn')"))+
        scale_color_manual(name="Pr(I)",values=c('blue','red'),labels=c("Pr(I|'bkg')", "Pr(I|'ohn')"))+
        theme(text=element_text(family="Times"))+
        theme(strip.text.x = element_text(size = 12))+
        theme(strip.text.y = element_text(size = 12))
      print(plt)
      
    }
    
  }
}

plotRegionTerm<-function()
{
  if(hist$color %in%  c("gray","blue","green","red","H","S","V","L","A","B","O1","O2","O3"))
  {  
    plt <- ggplot(data=hist$trainedHistogram, aes(x=probs, y=-log(probs), group=label)) +
      geom_line(aes(linetype=label, color=label),size=1) +
      geom_point(aes(color=label))+
      scale_linetype_manual(name="R(i)",values=c(1,2),labels=c("-lnPr(I|'bkg')", "-lnPr(I|'ohn')"))+
      scale_color_manual(name="R(i)",values=c('blue','red'),labels=c("-lnPr(I|'bkg')", "-lnPr(I|'ohn')"))+
      xlab("Pr(I)") + ylab("Region Term") +
      theme(text=element_text(family="Times"))+
      theme(strip.text.x = element_text(size = 12))+
      theme(strip.text.y = element_text(size = 12))
    print(plt)
  }
  
  
  if(hist$color %in%  c("RGB","HSV","LAB","Opponent"))
  {     
    colorVector <- getColorVector(hist$color)
    for(i in 1:3)
    {
      plt <- ggplot(data=hist$trainedHistogram[[i]], aes(x=probs, y=-log(probs), group=label)) +
        geom_line(aes(linetype=label, color=label),size=1) +
        geom_point(aes(color=label))+
        scale_linetype_manual(name="R(i)",values=c(1,2),labels=c("-lnPr(I|'bkg')", "-lnPr(I|'ohn')"))+
        scale_color_manual(name="R(i)",values=c('blue','red'),labels=c("-lnPr(I|'bkg')", "-lnPr(I|'ohn')"))+
        xlab("Pr(I)") + ylab("Region Term") +
        theme(text=element_text(family="Times"))+
        theme(strip.text.x = element_text(size = 12))+
        theme(strip.text.y = element_text(size = 12))
      print(plt)
      
    }
    
  }
}

#h<-Histogram(dataTrain_T1_F1$path,dataTrainMask_T1_F1$path,"test",1,1,"red",10)
#tLink = getRegionTerm(dataTrain_T1_F1$path[1], 1, h,"NONE")
