d <- read.table('data.one.leafs')
names(d) <- c("name", "x", "y")
d$y <- -d$y
l <- read.table('data.one.lines')
names(l) <- c("line", "x0", "y0", "x1", "y1")
l$y0 <- -l$y0
l$y1 <- -l$y1

png('pars.one.dendrogram.png', width=800, height=400)

par(mar=c(1,1,1,1))
plot(d$x, d$y, pch=20, cex=0, xlim=c(-1, max(d$x)+1), ylim=c(min(d$y)-20, max(d$y)+10), ann=F, axes=F, xaxs='i', yaxs='i')
text(d$x, d$y-5, d$name, adj=c(1, 0.3), srt=90)
segments(l$x0, l$y0, l$x1, l$y1, lwd=1)

dev.off()
