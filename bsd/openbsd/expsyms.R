d <- read.table('expsyms', head=T)

png('expsyms.png', width=850, height=800, antialias='subpixel')

par(mar=c(3,6,1,1))
b <- barplot(d$text, ylim=c(0, 23000), col='black', axes=F, ann=F, yaxs='i', xaxs='i')[,1]
text(b-0.15, d$text, font=2, labels=paste(d$text, '  ', sep=''), col='white', srt=90, adj=c(1, 1))
rect(b-0.5, 18000, b+0.5, d$data+18000, col='black')
text(b-0.15, d$data+18000, font=2, labels=paste(d$data, '  ', sep=''), col='white', srt=90, adj=c(1, 1))
rect(b-0.5, 20500, b+0.5, d$rodata+20500, col='black')
text(b, d$rodata+20500+100, font=2, labels=d$rodata, col='black', adj=c(0.5, 0))
rect(b-0.5, 22000, b+0.5, d$bss+22000, col='black')
text(b, d$bss+22000-100, font=2, labels=d$bss, col='white', adj=c(0.5, 1))


axis(1, at=b, labels=d$release, las=2, tick=F, line=-0.5)
## axis(2, las=2, at=seq(0, 13000, 1000), line=0.5)
## y <- seq(13500, 15500, 500)
## axis(2, las=2, at=y, labels=y-y[1], line=0.5)
## y <- seq(16000, 17000, 500)
## axis(2, las=2, at=y, labels=y-y[1], line=0.5)
## y <- seq(17500, 18500, 500)
## axis(2, las=2, at=y, labels=y-y[1], line=0.5)
par(ps=12)
axis(2, at=18000/2, label='Text', tick=F, line=1.5, las=2)
axis(2, at=19000, label='Data', tick=F, line=1.5, las=2)
axis(2, at=21000, label='RO\nData', tick=F, line=1.5, las=2)
axis(2, at=22500, label='BSS', tick=F, line=1.5, las=2)
dev.off()
