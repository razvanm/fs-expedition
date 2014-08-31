d <- read.table('summary', head=T)

png('summary.png', width=700, height=1000)
par(mar=c(11,6,0,6))
plot(d$major, d$fs, type='n', ann=F, axes=F, xlim=c(-0.7, 29.7), ylim=c(0, length(unique(d$fs))+0.7), xaxs='i', yaxs='i')
s <- d$type == 'first' & d$fs != 'ext4dev' & d$fs != 'ext4'
points(d$major[s], d$fs[s], pch=21, cex=1.5)
#s <- d$type == 'second'
#points(d$major[s], d$fs[s], pch=21, bg='red', cex=1.5)
s <- d$type == 'ok'
points(d$major[s], d$fs[s], pch=21, bg='black', cex=1.5)
axis(1, at=unique(d$major), label=paste('2.6.', unique(d$major), sep=''),
     las=2, lwd=0, lwd.ticks=1, cex.axis=1)
axis(2, at=unique(d$fs), label=unique(d$fs), las=1, lwd=0, lwd.ticks=1)
axis(4, at=unique(d$fs), label=unique(d$fs), las=1, lwd=0, lwd.ticks=1)
abline(v=12.5, lwd=0.3)
#title(paste(length(d$fs[d$type == 'ok']), 'file systems'), cex.main=2)

d <- read.table('timeline/data-2.6', head=T)
d$date <- as.Date(d$date, '%d-%b-%Y')
s <- d$minor == 0

par(mar=c(0,0,0,0), fig=c(0,1,0,0.1), new=T, ps=9)
plot(d$date[s], rep(0.9, length(d$date[s])), ylim=c(0, 1.45), pch=20, ann=F, axes=F)
x <- seq(as.Date('2004-07-20'), as.Date('2008-10-01'), by=51.6)
y <- rep(0.9, length(x))
segments(d$date[s], y, d$date[s], y+0.1)
segments(d$date[s], y+0.1, x, y+0.5)
segments(x, y+0.5, x, y+0.6)
segments(x-10, y+0.6, x+10, y+0.6)
s <- d$minor == 0 & !(d$major %in% c(1, 2, 3, 4))
text(d$date[s]-10, rep(0.55, length(d$date[s])), format(d$date[s], '%Y/%m'), srt=90, pos=1)
#axis.Date(1, at=d$date[s], format='%Y/%m', cex.axis=1, las=2, tick=F)
dev.off()
