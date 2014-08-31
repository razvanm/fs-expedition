d <- read.table('d', head=T)

svg('hclust-simple.svg')
plot(hclust(dist(d, method='euc')))
dev.off()

svg('hclust-2d.svg')
plot(d$x, d$y, cex=3, pch=20, ann=F, axes=F)
text(d$x, d$y, rownames(d), pos=2)
dev.off()
