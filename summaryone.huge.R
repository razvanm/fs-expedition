d <- read.table('summary.tux3', head=T)
fs <- tapply(d$fs, d$fs, length)
fs <- fs[order(fs, decreasing=T)]
extcall <- tapply(d$extcall, d$extcall, length)
extcall <- extcall[order(extcall, decreasing=T)]

EXTCALLS <- dim(extcall)

png('summary.tux3.huge.png', width=1000, height=15000)
par(fig=c(0, 0.9, 0.01, 1), mar=c(1,17,6,1))

plot(c(0, dim(fs)+1), c(0, EXTCALLS+1), type='n', ann=F, axes=F, yaxs='i', xaxs='i')
for (i in 1:EXTCALLS) {
  ec <- rownames(extcall)[i]
  line <- d$fs[d$extcall==ec]
  for (j in 1:dim(fs)) {
    f <- rownames(fs)[j]
    if (f %in% line) {
      points(j, EXTCALLS-i+1, pch=15, cex=1)
    }
  }
}

## m <- matrix(0, dim(fs), EXTCALLS)
## for (i in 1:EXTCALLS) {
##   ec <- rownames(extcall)[i]
##   line <- d$fs[d$extcall==ec]
##   for (j in 1:dim(fs)) {
##     f <- rownames(fs)[j]
##     if (f %in% line) {
##       m[j,(EXTCALLS-i+1)] = 1
##     }
##   }
## }
## image(1:nrow(m), 1:ncol(m), m, col=c('white', 'black'), axes=F, ann=F, yaxs='i', xaxs='i')

par(ps=8, family='fixed')
axis(1, at=1:dim(fs), labels=F, lwd=0, lwd.ticks=1, line=0)
axis(3, at=1:dim(fs), labels=rownames(fs), las=2, lwd=0, lwd.ticks=1, line=0)
axis(2, at=EXTCALLS:1, labels=rownames(extcall)[1:EXTCALLS], las=2, cex.axis=1, lwd=0, lwd.ticks=1, line=0.5)
axis(4, at=EXTCALLS:1, labels=F, lwd=0, lwd.ticks=1, line=0.5)
par(ps=9, family='')

# right graph
par(fig=c(0.9, 1, 0.01, 1), mar=c(1,1,6,1), new=T)
plot(extcall[1:EXTCALLS], EXTCALLS:1, xlim=c(-1, dim(fs)+1), ylim=c(0, EXTCALLS+1), pch=20, cex=1, ann=F, axes=F, yaxs='i', xaxs='i')
axis(1, at=seq(0,55,5), labels=F, lwd=0, lwd.ticks=1, line=0)
axis(1, at=c(0,55), labels=F, lwd=0, lwd.ticks=2, line=0)
axis(3, at=c(0,55), lwd=0, lwd.ticks=2, line=0)
axis(3, at=seq(0,55,5), labels=F, lwd=0, lwd.ticks=1, line=0)
axis(3, at=55/2, labels='Number of', font=2, line=3, tick=F)
axis(3, at=55/2, labels='file systems', font=2, line=2, tick=F)

# bottom graph
par(fig=c(0, 0.9, 0, 0.01), mar=c(3,17,0,1), new=T)
plot(fs, xlim=c(0, dim(fs)+1), ylim=c(0, 350), pch=20, ann=F, axes=F, yaxs='i', xaxs='i')
axis(2, at=seq(0, 350, 50), labels=F, lwd=0, lwd.ticks=1, line=0)
axis(2, at=c(0, 350), las=2, lwd=0, lwd.ticks=2, line=0)
axis(4, at=seq(0, 350, 50), labels=F, lwd=0, lwd.ticks=1, line=0)
axis(4, at=c(0, 350), labels=F, las=2, lwd=0, lwd.ticks=2, line=0)
axis(1, at=1:dim(fs), labels=F, lwd=0, lwd.ticks=1, line=0.5)
axis(2, at=350/2, labels='Number of\nexternal symbols', font=2, line=3, tick=F, las=2)
#axis(2, at=350/2, labels='external symbols', font=2, line=2, tick=F, las=2)

dev.off()
