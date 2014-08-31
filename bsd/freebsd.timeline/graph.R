png('timeline.png', width=850, height=500, antialias='subpixel')
par(mar=c(3,1,1,1))

d <- read.table('data', head=T)
d$date <- as.Date(d$date, '%d-%b-%Y')
d$major <- factor(d$major)
start <- as.Date('1993-01-01')
end <- as.Date('2010-01-01')

plot(d$date, d$index, type='n', xlim=c(start, end), ann=F, axes=F)
axis.Date(1, at=seq(start, end, 'year'))
par(ps=12)
for (major in levels(d$major)) {
  s <- d$major == major
  points(d$date[s], d$index[s], type='o', pch=20, cex=2)

  ss <- s & (d$minor == 0)
  par(ps=13)
  if (length(d$date[ss]) > 0) {
    text(d$date[ss], d$index[ss], d$release[ss], adj=c(1.2,-0.2), font=2)
  }
  ss <- s & (d$minor == 1)
  if (length(d$date[ss]) > 0) {
    par(ps=9)
    if (major != 2.2) {
      text(d$date[ss], d$index[ss], d$release[ss], adj=c(1.2,-0.2), font=1)
    } else {
      text(d$date[ss], d$index[ss], d$release[ss], adj=c(-0.3,0.2), font=1)
    }
  }  
}

dev.off()


