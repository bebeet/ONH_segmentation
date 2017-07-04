Boundary_termx <-function(IpminusIq,sigma)
{
  Bpq = exp(-1*((IpminusIq)^2)/(2*(sigma^2)))
  return(Bpq)
}

exploreBoundary <- data.frame(Different=c(),Sigma=c(),BoundaryTerm=c())
for(s in seq(from=0.1, to=1, by=0.1)){
  for(d in seq(from=0, to=1, by=0.1)){
    exploreBoundary <- rbind(exploreBoundary,data.frame(Different=d,Sigma=s,BoundaryTerm=Boundary_termx(d,s)))
  }
}

exploreBoundary$Different <-  factor(exploreBoundary$Different)
exploreBoundary$Sigma <-  factor(exploreBoundary$Sigma )

jpeg(file="boundary_term1.jpg",  units="in", width=6, height=4,res=300)
p<-ggplot(data=exploreBoundary, aes(x=Different, y=BoundaryTerm, group=Sigma, colour=Sigma)) +
  geom_line() +
  geom_point()+
  theme(text=element_text(family="Times"))+
  theme(strip.text.x = element_text(size = 12))+
  theme(strip.text.y = element_text(size = 12))+
  guides(colour=guide_legend(title=expression(sigma)))+
  xlab(expression(bgroup("(",I["p"]-I["q"],")")^2 )) + ylab("Boundary Term") 
print(p)
dev.off()

jpeg(file="boundary_term2.jpg",  units="in", width=6, height=4,res=300)
p<-ggplot(data=exploreBoundary, aes(x=Sigma, y=BoundaryTerm,group=Different, colour=Different)) +
  geom_line() +
  geom_point()+
  xlab(expression(sigma)) + ylab("Boundary Term") + 
  guides(colour=guide_legend(title=expression(bgroup("(",I["p"]-I["q"],")")^2 )))+
  theme(text=element_text(family="Times"))+
  theme(strip.text.x = element_text(size = 12))+
  theme(strip.text.y = element_text(size = 12))
print(p)
dev.off()
