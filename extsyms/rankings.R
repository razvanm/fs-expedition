d <- read.table('extsyms', head=T)



dd <- tapply(d$extsyms, d$fs, function(x) { length(x) } )
dd <- sort(dd)
n <- length(dd)
png('extsyms-longevity.png', width=900, height=500, antialias='subpixel')
par(mar=c(1,6,1,1))
plot(dd, type='n', xlim=c(0, n+0.5), ylim=c(-5,31), ann=F, axes=F, xaxs='i', yaxs='i')
#abline(h=unique(dd), lwd=0.5, col='gray')
#abline(v=1:n, lwd=0.5, col='gray')
points(dd, pch=20, cex=2)
text(1:length(dd), dd, paste(rownames(dd), '   ', sep=''), adj=c(1, 0.3), srt=90)

#axis(1, at=1:length(dd), labels=rownames(dd), lwd=0, lwd.tick=2, las=2)
axis(2, at=1:30, labels=F, lwd=0, lwd.tick=1)
p <- 1
for (i in unique(dd)) {
  count <- length(dd[dd == i])
  p <- p + count
  segments(0, i, p-1, i, lwd=0.5, lty=3)
  axis(2, at=i, labels=paste(i, '(', count, ')', sep=''), las=2, lwd=0, lwd.tick=2)
}
par(ps=10)
title(ylab='Number of releases (number of file systems)', line=4)

dev.off()



dd <- tapply(d$extsyms, d$fs, function(x) { min(x) } )
dd <- sort(dd)
n <- length(dd)
png('extsyms-min.png', width=900, height=500, antialias='subpixel')
par(mar=c(1,6,1,1))
plot(dd, type='n', xlim=c(0, n+0.5), ylim=c(-35,max(dd)+20), ann=F, axes=F, xaxs='i', yaxs='i')
points(dd, pch=20, cex=2)
text(1:length(dd), dd, paste(rownames(dd), '   ', sep=''), adj=c(1, 0.3), srt=90)
text(1:length(dd), dd, paste('   ', dd, sep=''), adj=c(0, 0.3), srt=90, col='gray')

axis(2, at=seq(0, max(dd), 10), lwd=0, lwd.tick=2, las=2)
par(ps=10)
title(ylab='Minimum number of symbols', line=4)

dev.off()


dd <- tapply(d$extsyms, d$fs, function(x) { max(x) } )
dd <- sort(dd)
n <- length(dd)
png('extsyms-max.png', width=900, height=500, antialias='subpixel')
par(mar=c(1,6,1,1))
plot(dd, type='n', xlim=c(0, n+0.5), ylim=c(-35,max(dd)+30), ann=F, axes=F, xaxs='i', yaxs='i')
points(dd, pch=20, cex=2)
text(1:length(dd), dd, paste(rownames(dd), '   ', sep=''), adj=c(1, 0.3), srt=90)
text(1:length(dd), dd, paste('   ', dd, sep=''), adj=c(0, 0.3), srt=90, col='gray')

axis(2, at=seq(0, max(dd), 20), lwd=0, lwd.tick=2, las=2)
par(ps=10)
title(ylab='Maximum number of symbols', line=4)

dev.off()



dd <- tapply(d$extsyms, d$fs, function(x) { max(x)-min(x) } )
dd <- sort(dd)
n <- length(dd)
png('extsyms-range.png', width=900, height=500, antialias='subpixel')
par(mar=c(1,6,1,1))
plot(dd, type='n', xlim=c(0, n+0.5), ylim=c(-35,max(dd)+20), ann=F, axes=F, xaxs='i', yaxs='i')
points(dd, pch=20, cex=2)
text(1:length(dd), dd, paste(rownames(dd), '   ', sep=''), adj=c(1, 0.3), srt=90)
text(1:length(dd), dd, paste('   ', dd, sep=''), adj=c(0, 0.3), srt=90, col='gray')

axis(2, at=seq(0, max(dd), 10), lwd=0, lwd.tick=2, las=2)
par(ps=10)
title(ylab='Range in number of symbols', line=4)

dev.off()


dd <- tapply(d$extsyms, d$fs, function(x) { x[length(x)]-x[1] } )
dd <- sort(dd)
n <- length(dd)
png('extsyms-last-first.png', width=900, height=500, antialias='subpixel')
par(mar=c(1,6,1,1))
plot(dd, type='n', xlim=c(0, n+0.5), ylim=c(-35,max(dd)+20), ann=F, axes=F, xaxs='i', yaxs='i')
points(dd, pch=20, cex=2)
text(1:length(dd), dd, paste(rownames(dd), '   ', sep=''), adj=c(1, 0.3), srt=90)
text(1:length(dd), dd, paste('   ', dd, sep=''), adj=c(0, 0.3), srt=90, col='gray')

axis(2, at=seq(0, max(dd), 10), lwd=0, lwd.tick=2, las=2)
par(ps=10)
title(ylab='Number of symbols between the last and first appearance', line=4)

dev.off()



dd <- tapply(d$extsyms, d$fs, function(x) { if (length(x) > 1) max(x[-1] - x[1:length(x)-1]) else 0 } )
dd <- sort(dd)
n <- length(dd)
png('extsyms-max-jump.png', width=900, height=500, antialias='subpixel')
par(mar=c(1,6,1,1))
plot(dd, type='n', xlim=c(0, n+0.5), ylim=c(-12,max(dd)+5), ann=F, axes=F, xaxs='i', yaxs='i')
points(dd, pch=20, cex=2)
text(1:length(dd), dd, paste(rownames(dd), '   ', sep=''), adj=c(1, 0.3), srt=90)
text(1:length(dd), dd, paste('   ', dd, sep=''), adj=c(0, 0.3), srt=90, col='gray')

axis(2, at=seq(0, max(dd)+1, 5), lwd=0, lwd.tick=2, las=2)
par(ps=10)
title(ylab='Biggest increase in the number of external symbols', line=4)
title(ylab='between two consecutive releases', line=3)

dev.off()




dd <- tapply(d$extsyms, d$fs, function(x) { if (length(x) > 1) -min(x[-1] - x[1:length(x)-1]) else 0 } )
dd <- sort(dd)
n <- length(dd)
png('extsyms-min-jump.png', width=900, height=500, antialias='subpixel')
par(mar=c(1,6,1,1))
plot(dd, type='n', xlim=c(0, n+0.5), ylim=c(min(dd)-4,max(dd)+2), ann=F, axes=F, xaxs='i', yaxs='i')
points(dd, pch=20, cex=2)
text(1:length(dd), dd, paste(rownames(dd), '   ', sep=''), adj=c(1, 0.3), srt=90)
text(1:length(dd), dd, paste('   ', dd, sep=''), adj=c(0, 0.3), srt=90, col='gray')

axis(2, at=seq(0, max(dd), 1), lwd=0, lwd.tick=2, las=2)
par(ps=10)
title(ylab='Biggest decrease in the number of external symbols', line=4)
title(ylab='between two consecutive releases', line=3)

dev.off()



my.points <- function(d, y) {
  points((d-min(d))/(max(d)-min(d)), rep(y, n), pch=20, cex=2)
}

d.len <- rank(tapply(d$extsyms, d$fs, function(x) { length(x) } ), ties.method='first')
d.min <- rank(tapply(d$extsyms, d$fs, function(x) { min(x) } ), ties.method='first')
d.max <- rank(tapply(d$extsyms, d$fs, function(x) { max(x) } ), ties.method='first')
d.range <- rank(tapply(d$extsyms, d$fs, function(x) { max(x)-min(x) } ), ties.method='first')
d.fl <- rank(tapply(d$extsyms, d$fs, function(x) { x[length(x)]-x[1] } ), ties.method='first')
d.maxjump <- rank(tapply(d$extsyms, d$fs, function(x) { if (length(x) > 1) max(x[-1] - x[1:length(x)-1]) else 0 } ), ties.method='first')
d.minjump <- rank(tapply(d$extsyms, d$fs, function(x) { if (length(x) > 1) -min(x[-1] - x[1:length(x)-1]) else 0 } ), ties.method='first')
n <- length(d.len)

png('extsyms-rankings.png', width=900, height=1000, antialias='subpixel')
par(mar=c(1,1,1,1))

plot(c(1-0.3,7.3), c(0,n+1), type='n', ann=F, axes=F, xaxs='i', yaxs='i')
for (i in names(d.len)) {
  y <- c(d.len[i], d.min[i], d.max[i], d.range[i], d.fl[i], d.maxjump[i], d.minjump[i])
  leftx <- 1:6+strwidth(i)/2+0.1
  lefty <- y[1:6]
  rightx <- 2:7-strwidth(i)/2-0.1
  righty <- y[2:7]
  points(leftx, lefty, pch=20, cex=1.6)
  points(rightx, righty, pch=20, cex=1.6)
  #segments(leftx, lefty, rightx, righty)
  for (k in 1:6) {
    incx <- 0.05
    incy <- (righty[k] - lefty[k])/40
    s <- spline(c(leftx[k], leftx[k]+incx, rightx[k]-incx, rightx[k]),
                c(lefty[k], lefty[k]+incy, righty[k]-incy, righty[k]), n=30)
    #points(leftx[k]+incx, lefty[k]+incy, pch=20, cex=0.2)
    #points(rightx[k]-incx, righty[k]-incy, pch=20, cex=0.2)
    #lines(c(leftx[k], rightx[k]), c(lefty[k], righty[k]))
    #cat(leftx[k], rightx[k], lefty[k], righty[k], fill=T)
    if (max(s$y)-min(s$y) > 10) {
      lines(s$x, s$y, lwd=1, col=rgb(0,0,0,0.4))
    } else {
      lines(s$x, s$y, lwd=2)
    }
    #cat(max(s$y)-min(s$y), ' ')
  }
  text(1:7, y, rep(i, 7))
}
par(ps=10)
axis(3, at=1:7, labels=c('Length', 'Min', 'Max', 'Range', 'First-Last', 'Max Jump', 'Min Jump'), font=2, tick=F, line=-1)

dev.off()
