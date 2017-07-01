
Evaluate_result <-data.frame(name=c(),
                             Grid_size = c(),
                             Clipping_limit=c(),
                             Entropy = c())
for(s in seq(2.0,5.0,0.5))
{

  for(p in 2:8)
  {
    images_path <- paste("../Dataset/RIM_ONE_r1/All_Resize/10/CLAHE/gray/",p,"/",as.character(format(s, nsmall = 1)),sep="")
    print(images_path)
    all_img <- list.files(path=images_path, pattern="*.jpg") 
    
    for(i in 1:length(all_img))
    {
      # Read images
      img <- EBImage::readImage(paste(images_path,all_img[i], sep = "/"))
      Evaluate_result<-rbind(Evaluate_result,
                             data.frame(
                               name=gsub(".jpg","",all_img[i]),
                               Grid_size = p,
                               Clipping_limit =s,
                               Entropy = imEntropy(img)
                             ))
    }
    
  }
}



write.csv(Evaluate_result,file = "CLAHE_Preprocess_Summary_All.csv")
