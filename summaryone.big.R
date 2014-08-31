d <- read.table('summary.tux3', head=T)
fs <- tapply(d$fs, d$fs, length)
fs <- fs[order(fs, decreasing=T)]
extcall <- tapply(d$extcall, d$extcall, length)
extcall <- extcall[order(extcall, decreasing=T)]

EXTCALLS <- 50

png('summary.tux3.big.png', width=1024, height=768)
par(fig=c(0, 0.8, 0.08, 1), mar=c(1,11,6,1))

plot(c(1, dim(fs)), c(1, EXTCALLS), type='n', ann=F, axes=F)

for (i in 1:EXTCALLS) {
  ec <- rownames(extcall)[i]
  line <- d$fs[d$extcall==ec]
  for (j in 1:dim(fs)) {
    f <- rownames(fs)[j]
    if (f %in% line) {
      points(j, EXTCALLS-i+1, pch=20, cex=2)
    }
  }
}

par(ps=8, family='fixed')
axis(1, at=1:dim(fs), labels=F, lwd=0, lwd.ticks=1, line=-0.5)
axis(3, at=1:dim(fs), labels=rownames(fs), las=2, lwd=0, lwd.ticks=1, line=-0.5)
axis(2, at=EXTCALLS:1, labels=rownames(extcall)[1:EXTCALLS], las=2, cex.axis=1, lwd=0, lwd.ticks=1, line=-0.5)
axis(4, at=EXTCALLS:1, labels=F, lwd=0, lwd.ticks=1, line=-0.5)
par(ps=9, family='')

# right graphs
par(fig=c(0.8, 0.9, 0.08, 1), mar=c(1,0,6,1), new=T)
plot(extcall[1:EXTCALLS], EXTCALLS:1, xlim=c(20, 55), pch=20, ann=F, axes=F)
axis(1, at=seq(25,55,5), labels=F, lwd=0, lwd.ticks=1, line=-0.5)
axis(1, at=c(25,55), labels=F, lwd=0, lwd.ticks=2, line=-0.5)
axis(3, at=seq(25,55,5), labels=F, lwd=0, lwd.ticks=1, line=-0.5)
axis(3, at=c(25,55), lwd=0, lwd.ticks=2, line=-0.5)

par(fig=c(0.9, 1, 0.08, 1), mar=c(1,0,6,1), new=T)
plot(extcall, dim(extcall):1, type='n', ann=F, axes=F)
rect(0,dim(extcall)-EXTCALLS,max(extcall),dim(extcall), border='gray', col='gray')
#lines(extcall, dim(extcall):1, type='l', lwd=3)
points(extcall, dim(extcall):1, pch=20)
axis(1, at=seq(0,55,5), labels=F, lwd=0, lwd.ticks=1, line=-0.5)
axis(1, at=c(0,55), labels=F, lwd=0, lwd.ticks=2, line=-0.5)
axis(3, at=seq(0,55,5), labels=F, lwd=0, lwd.ticks=1, line=-0.5)
axis(3, at=c(0,55), lwd=0, lwd.ticks=2, line=-0.5)

# bottom graph
par(fig=c(0, 0.8, 0, 0.09), mar=c(1,11,0,1), new=T)
plot(fs, ylim=c(0, 350), pch=20, ann=F, axes=F)
axis(2, at=seq(0, 350, 50), labels=F, lwd=0, lwd.ticks=1, line=-0.5)
axis(2, at=c(0, 350), las=2, lwd=0, lwd.ticks=2, line=-0.5)
axis(1, at=1:dim(fs), labels=F, lwd=0, lwd.ticks=1, )
axis(4, at=seq(0, 350, 50), labels=F, lwd=0, lwd.ticks=1, line=-0.5)
axis(4, at=c(0, 350), labels=F, lwd=0, lwd.ticks=2, line=-0.5)

dev.off()
