d <- read.table('building', head=T)
d$psize <- d$psize/1024/1024
png('building.png', width=800, height=400)

par(mar=c(4,5,1,1))
b <- barplot(d$csize, col='black', axes=F, ann=F, yaxs='i', xaxs='i')[,1]
text(b-0.2, d$csize-15, font=2, labels=d$csize, col='white', srt=90, pos=1)

diff <- (b[2]-b[1])/2
segments(b-diff, d$usize, b+diff, d$usize, col='white', lwd=2)
text(b-0.2, d$usize-20, font=2, labels=d$usize, col='white', srt=90, pos=1)

segments(b-diff, d$psize, b+diff, d$psize, col='white', lwd=2)
text(b-0.2, d$psize+45, font=2, labels=trunc(d$psize), col='white', srt=90, pos=1)

axis(1, at=b, labels=paste('2.6', d$major, sep='.'), las=2, tick=F, line=-0.5)
axis(2, las=2, line=0.5)
title(ylab='Megabytes', line=4)

dev.off()
