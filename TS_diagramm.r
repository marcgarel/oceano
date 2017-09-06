#Code to plot TS diagram automaticaly. Work on .cnv file from SBE data processing
#All plot are saved in .pdf 
#Independant to the cnv file number


#Author :MG
#verion : V1.0

#before to begin do stwd()
#please to change something use the github link or send me an email

#usefull package (don(t forget to install it befor))
require(oce)
require (lattice)


#The loop. 
files <- system("ls *.cnv", intern=TRUE)
pdf("TS_Selected_data.pdf")
for (i in 1:length(files)) {
  print(i)
  cat(files[i], "\n")
  x <- read.ctd(files[i])
  D=x[["depth"]]
  
  omar <- par('mar')
  drawPalette(zlim=c(min(D),max(D)), col=oce.colorsJet(length(D)))
  plot(x[["salinity"]],x[["theta"]], xlim=c(35,36), col=oce.colorsJet(length(D))[1:length(D)],pch=20,cex=2, xlab="Salinity", ylab="Potential Temperature", main=x@metadata$header[2], sub=paste("Lat=",x@metadata$latitude, "Long", x@metadata$longitude))
    drawIsopycnals(nlevels=6, rotate=TRUE, rho1000=FALSE, digits=2,
                   eos=getOption("oceEOS", default="gsw"),
                   cex=0.75*par('cex'), col="darkgray", lwd=par("lwd"), lty=par("lty"))
    par(mar=omar) 

}
dev.off()