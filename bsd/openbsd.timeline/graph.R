png('timeline.png', width=850, height=400, antialias='subpixel')
par(mar=c(3,1,1,1))

d <- read.table('data', head=T)
d$date <- as.Date(d$date, '%d-%b-%Y')
d$major <- factor(d$major)
start <- as.Date('1996-01-01')
end <- as.Date('2010-01-01')

plot(d$date, d$index, type='n', xlim=c(start, end), ann=F, axes=F)
axis.Date(1, at=seq(start, end, 'year'))
par(ps=12)
for (major in levels(d$major)) {
  s <- d$major == major & d$release != '2.1.7.1'
  points(d$date[s], d$index[s], type='o', pch=20, cex=2)
  text(d$date[s], d$index[s], format(d$release[s]), adj=c(1.2,-0.2), font=2)
  #text(max(d$date[s]), max(d$index[s])+0.5, max(as.character(d$release[s])), adj=c(0.5,0), cex=2, font=2)
  
}

dev.off()
