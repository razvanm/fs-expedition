d <- read.table('summary.7.2', head=T)

png('summary.7.2.png', width=800, height=400)
par(mar=c(0,6,0,6))
plot(as.integer(d$extcall), as.integer(d$fs), pch='|', cex=0.9, ann=F, axes=F)
axis(2, at=unique(d$fs), label=unique(d$fs), las=1, lwd=0, lwd.ticks=1)
axis(4, at=unique(d$fs), label=unique(d$fs), las=1, lwd=0, lwd.ticks=1)
#title('Linus branch from March 10, 2009 + tux3', cex.main=2, line=0)
dev.off()


