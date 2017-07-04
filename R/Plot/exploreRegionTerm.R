exploreRegionTerm <- data.frame(Probability=c(),Lambda=c(),RegionTerm=c())
for(l in seq(from=0.1, to=1, by=0.1)){
  for(p in seq(from=0, to=1, by=0.1)){
    exploreRegionTerm <- rbind(exploreRegionTerm,data.frame(
      Probability=p,Lambda=l,RegionTerm=-log(p)*l))
  }
}
jpeg(file="region_term.jpg",  units="in", width=6, height=4,res=300)
exploreRegionTerm$Probability <-  factor(exploreRegionTerm$Probability)
exploreRegionTerm$Lambda <-  factor(exploreRegionTerm$Lambda )
p<-ggplot(data=exploreRegionTerm, aes(x=Probability, y=RegionTerm, group=Lambda, colour=Lambda)) +
  geom_line() +
  geom_point()+
  xlab(expression(Pr(I))) + ylab("Region Term") +
  guides(colour=guide_legend(title=expression(lambda)))+
  theme(text=element_text(family="Times"))+
  theme(strip.text.x = element_text(size = 12))+
  theme(strip.text.y = element_text(size = 12))
print(p)
dev.off()