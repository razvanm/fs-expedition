d <- read.table('summary.tux3', head=T)

png('summary.tux3.png', width=800, height=900)
par(mar=c(0,6,0,6))
plot(as.integer(d$extcall), as.integer(d$fs), pch='|', cex=0.9, ann=F, axes=F)
axis(2, at=unique(d$fs), label=unique(d$fs), las=1, lwd=0, lwd.ticks=1)
axis(4, at=unique(d$fs), label=unique(d$fs), las=1, lwd=0, lwd.ticks=1)
#title('Linus branch from March 10, 2009 + tux3', cex.main=2, line=0)
dev.off()



## png('summary.tux3.fs.png', width=1000, height=500)
## par(mar=c(6,3,1,1))
## s <- tapply(d$fs, d$fs, length)
## s <- s[order(s, decreasing=T)]
## plot(s, cex=2, ylim=c(0, 350), pch=20, ann=F, axes=F)
## axis(1, at=1:dim(s), rownames(s), las=2, lwd=0, lwd.ticks=1)
## axis(2, at=seq(0, 350, 50), las=2, lwd=0, lwd.ticks=1)
## dev.off()

png('summary.tux3.fs.png', width=800, height=400)
par(mar=c(4,2,1,1))
s <- tapply(d$fs, d$fs, length)
s <- s[order(s, decreasing=T)]
b <- barplot(s, names.arg=F, col='black', axes=F, ann=F, yaxs='i', xaxs='i')[,1]
text(b-0.3, s-10, font=2, labels=s, col='white', srt=90, pos=1)

axis(1, at=b, rownames(s), las=2, tick=F, line=-0.5)
#axis(1, at=b, labels=paste('2.6', d$major, sep='.'), las=2, tick=F, line=-0.5)
#axis(2, las=2, line=0.5)
title(ylab='Number of external symbols', line=1)
dev.off()


png('summary.tux3.fs-cat.png', width=800, height=400)

par(mar=c(4,2,1,1))

s1 <- c('btrfs','ext2','ext3','ext4','fat','msdos','vfat','freevxfs','hfsplus','jfs','ntfs','qnx4','reiserfs','tux3','xfs')
s2 <- c('isofs','udf')
s3 <- c('cramfs','jffs2','romfs','squashfs','ubifs')
s4 <- c('9p','kafs','cifs','coda','ncpfs','nfs','nfsd','smbfs')
s5 <- c('gfs2','ocfs2')
s6 <- c('configfs','debugfs','devpts','dlm','ecryptfs','fuse','hugetlbfs','jbd2','jbd','lockd','proc','ramfs')
s7 <- c('adfs','affs','befs','bfs','efs','hfs','hpfs','minix','omfs','sysv','ufs')
rs <- rownames(s)
y <- c(s[rs %in% s1], s[rs %in% s2], s[rs %in% s3],
       s[rs %in% s4], s[rs %in% s5], s[rs %in% s6], s[rs %in% s7])
yy <- c(rs[rownames(s) %in% s1], rs[rownames(s) %in% s2], rs[rownames(s) %in% s3],
        rs[rownames(s) %in% s4], rs[rownames(s) %in% s5], rs[rownames(s) %in% s6], rs[rownames(s) %in% s7])
b <- barplot(y, names.arg=F, col='black', axes=F, ann=F, yaxs='i', xaxs='i')[,1]
print(b)
print(length(b))
text(b-0.3, y-10, font=2, labels=y, col='white', srt=90, pos=1)
axis(1, at=b, yy, las=2, tick=F, line=-0.5)
title(ylab='Number of external symbols', line=1)

par(fig=c(0,1,0.13,1), mar=c(0,2,1,1), new=T)

sep = c(1, length(s1), length(c(s1, s2)), length(c(s1, s2, s3)),
  length(c(s1, s2, s3, s4)), length(c(s1, s2, s3, s4, s5)),
  length(c(s1, s2, s3, s4, s5, s6)), length(c(s1, s2, s3, s4, s5, s6, s7)))
sep <- b[sep]
print(sep)
plot(range(0.2, sep+0.5), c(0, 100), type='n', axes=F, ann=F, yaxs='i', xaxs='i')
rect(sep[1]-0.5, 1, sep[2]+0.5, 2, col='black')
rect(sep[2]+0.7, 1, sep[3]+0.5, 2, col='black')
rect(sep[3]+0.7, 1, sep[4]+0.5, 2, col='black')
rect(sep[4]+0.7, 1, sep[5]+0.5, 2, col='black')
rect(sep[5]+0.7, 1, sep[6]+0.5, 2, col='black')
rect(sep[6]+0.7, 1, sep[7]+0.5, 2, col='black')
rect(sep[7]+0.7, 1, sep[8]+0.5, 2, col='black')


dev.off()

quit()




png('summary.tux3.calls.png', width=1200, height=500)
par(fig=c(0,1,0,1))
par(mar=c(12,3,1,1))
s <- tapply(d$extcall, d$extcall, length)
s <- s[order(s, decreasing=T)]
s <- s[s > 10]
plot(s, xlim=c(0, 100), pch=20, ann=F, axes=F)
#plot(s, type='l', lwd=3, ann=F, axes=F)
axis(1, at=1:dim(s), rownames(s), las=2)
axis(2, las=2)

par(fig=c(0.7,1,0.7,1), new=T)
par(mar=c(1,1,1,1))
s <- tapply(d$extcall, d$extcall, length)
s <- s[order(s, decreasing=T)]
plot(s, type='n', lwd=3, ann=F, axes=F)
rect(0,0,length(s[s>10]),max(s), border='gray', col='gray')
lines(s, type='l', lwd=3)
axis(1, las=2)
axis(2, las=2)
dev.off()


dm <- matrix(0, nrow=length(levels(d$fs)), ncol=length(levels(d$extcall)))
rownames(dm) <- levels(d$fs)
d$fs <- as.integer(d$fs)
d$extcall <- as.integer(d$extcall)
for (i in seq(1, dim(d)[1])) {
  dm[d$fs[i], d$extcall[i]] = 1
}

my.dendrogram <- function(dist.method, hclust.method) {
  png(paste('summary.tux3.hclust', dist.method, hclust.method, 'png', sep='.'), width=750, height=400)
  par(mar=c(0,0,0,0))
  plot(hclust(dist(dm, method=dist.method), method=hclust.method), ann=F, axes=F)
  dev.off()
}

my.dendrogram('canberra', 'ward')
my.dendrogram('canberra', 'complete')
my.dendrogram('canberra', 'average')
my.dendrogram('canberra', 'mcquitty')
my.dendrogram('canberra', 'single')

my.dendrogram('binary', 'ward')
my.dendrogram('binary', 'complete')
my.dendrogram('binary', 'average')
my.dendrogram('binary', 'mcquitty')

my.tick <- function(dist.method, hclust.method) {
  png(paste('summary.tux3.tick', dist.method, hclust.method, 'png', sep='.'), width=750, height=900)
  layout(rbind(1, 2), heights=c(1, 4))

  par(mar=c(5,1,0,1))
  h <- hclust(dist(dm, method=dist.method), method=hclust.method)
  ddr <- as.dendrogram(h)
  plot(ddr, ann=F, axes=F, xaxs="i")

  par(mar=c(6,1,0,1))
  x <- as.integer(lapply(d$fs, function(x) { which(x == h$order) }))
  y <- as.integer(d$extcall)
  plot(c(min(x)-0.5, max(x)+0.5), range(y), type='n', cex=1, ann=F, axes=F, xaxs="i", yaxs="i")
  segments(x-0.4, y, x+0.4, y)
  x = 1:length(h$labels)
  y = h$labels[h$order]
  axis(1, x, y, line=0.5, las=2, lwd=0, lwd.ticks=1)
  axis(3, x, labels=F, line=0.5, lwd=0, lwd.ticks=1)
  
  dev.off()
}

my.tick('canberra', 'ward')
my.tick('canberra', 'complete')
my.tick('canberra', 'average')
my.tick('canberra', 'mcquitty')
my.tick('canberra', 'single')

my.tick('binary', 'ward')
my.tick('binary', 'complete')
my.tick('binary', 'average')
my.tick('binary', 'mcquitty')

## png('summary.tux3.reordered.canberra.png', width=800, height=900)
## par(mar=c(0,6,2,6))
## h <- hclust(dist(dm, method='canberra'), method='ward')
## y <- as.integer(lapply(d$fs, function(x) { which(x == rev(h$order)) }))
## plot(as.integer(d$extcall), y, pch='|', cex=0.9, ann=F, axes=F)
## x = length(h$labels):1
## y = h$labels[h$order]
## axis(2, x, y, las=2)
## axis(4, x, y, las=2)
## title('Linus branch from March 10, 2009 + tux3', cex.main=2, line=0)
## dev.off()

## png('summary.tux3.reordered.binary.png', width=800, height=900)
## par(mar=c(0,6,2,6))
## h <- hclust(dist(dm, method='binary'), method='single')
## y <- as.integer(lapply(d$fs, function(x) { which(x == rev(h$order)) }))
## plot(as.integer(d$extcall), y, pch='|', cex=0.9, ann=F, axes=F)
## x = length(h$labels):1
## y = h$labels[h$order]
## axis(2, x, y, las=2)
## axis(4, x, y, las=2)
## title('Linus branch from March 10, 2009 + tux3', cex.main=2, line=0)
## dev.off()


