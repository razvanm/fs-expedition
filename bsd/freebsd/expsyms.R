d <- read.table('expsyms', head=T)

png('expsyms.png', width=850, height=800, antialias='subpixel')

par(mar=c(3,6,1,1))
b <- barplot(d$text, ylim=c(0, 12100), col='black', axes=F, ann=F, yaxs='i', xaxs='i')[,1]
text(b-0.2, d$text, font=2, labels=paste(d$text, '  ', sep=''), col='white', srt=90, adj=c(1, 1))
rect(b-0.5, 8500, b+0.5, d$data+8500, col='black')
text(b-0.2, d$data+8500, font=2, labels=paste(d$data, '  ', sep=''), col='white', srt=90, adj=c(1, 1))
rect(b-0.5, 10200, b+0.5, d$rodata+10200, col='black')
text(b, d$rodata+10200+50, font=2, labels=d$rodata, col='black', adj=c(0.5, 0))
rect(b-0.5, 11000, b+0.5, d$bss+11000, col='black')
text(b, d$bss+11000+50, font=2, labels=d$bss, col='black', adj=c(0.5, 0))


axis(1, at=b, labels=d$release, las=2, tick=F, line=-0.5)
## axis(2, las=2, at=seq(0, 8000, 1000), line=0.5)
## y <- seq(8500, 9700, 200)
## axis(2, las=2, at=y, labels=y-y[1], line=0.5)
## y <- seq(11000, 12000, 200)
## axis(2, las=2, at=y, labels=y-y[1], line=0.5)
par(ps=12)
axis(2, at=4000, label='Text', tick=F, line=1.5, las=2)
axis(2, at=9000, label='Data', tick=F, line=1.5, las=2)
axis(2, at=10300, label='RO\nData', tick=F, line=1.5, las=2)
axis(2, at=11500, label='BSS', tick=F, line=1.5, las=2)
dev.off()
