
Evaluate_result <-data.frame(name=c(),
                             Grid_size = c(),
                             Contrast=c(),
                             Entropy = c())
for(p in 1:8)
{
  images_path <- paste("../Dataset/RIM_ONE_r1/All_Resize/10/AHE/gray/",p,sep="")
  all_img <- list.files(path=images_path, pattern="*.jpg") 
  
  for(i in 1:length(all_img))
  {
    # Read images
    img <- EBImage::readImage(paste(images_path,all_img[i], sep = "/"))
    Evaluate_result<-rbind(Evaluate_result,
                           data.frame(
                             name=gsub(".jpg","",all_img[i]),
                             Grid_size = p,
                             Contrast = imContrast(img),
                             Entropy = imEntropy(img)
                             ))
  }

}

Evaluate_result <- reshape(Evaluate_result, direction="long", varying=list(names(Evaluate_result)[3:4]), 
                           v.names="Evaluation_rate", 
                           idvar=c("name","Grid_size"),timevar="Evaluation_method",
                           times = c("Contrast","Entropy"))

write.csv(Evaluate_result,file = "Preprocess_Summary_All.csv")

