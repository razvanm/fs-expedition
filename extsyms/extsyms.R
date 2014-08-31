d <- read.table('extsyms', head=T)
dd <- tapply(d$extsyms, d$fs, function(x) { (max(x) - min(x))/length(x) } )

my.rgb <- function(r,g,b) {
  rgb(r/255, b/255, b/255)
}


my.graph <- function(fs.group, fs.labels, oufile) {
  png(oufile, width=850, height=400, antialias='subpixel')

  par(mar=c(4,5,1,4))
  plot(d$major, d$extsyms, type='n', xlim=c(-0.5,29.5), ylim=c(-10, 350), ann=F, axes=F, xaxs='i', yaxs='i')

  for (fs in fs.group) {
    w <- floor(dd[fs]/10) + 1
    s <- d$fs == fs
    lines(d$major[s], d$extsyms[s], type='b', pch=20, lwd=2)
  }
  sel <- d$fs %in% fs.labels & d$major == 29
  cat(fs.group, fill=F)
  axis(1, at=0:29, labels=paste('2.6', 0:29, sep='.'), las=2)
  axis(2)
  axis(4, at=d$extsym[sel], labels=d$fs[sel], tick=F, las=2, line=-1)
  par(ps=10)
  title(ylab='Number of external symbols', line=3)
  dev.off()
}


#my.colors <- c(my.rgb(254,240,217), my.rgb(253,204,138), my.rgb(252,141,89), my.rgb(227,74,51), my.rgb(179,0,0), my.rgb(179,0,0), my.rgb(179,0,0))
my.colors <- c(my.rgb(254,240,217), my.rgb(254,240,217), my.rgb(253,204,138), my.rgb(252,141,89), my.rgb(227,74,51), my.rgb(179,0,0), my.rgb(179,0,0))
my.lwd <- c(1, 1, 1, 3, 5, 5, 5)

g1 <- strsplit('btrfs omfs squashfs efs freevxfs romfs adfs cramfs qnx4 befs vfat bfs msdos ramfs isofs sysv devfs coda minix intermezzo affs hpfs jbd smbfs jffs configfs debugfs hugetlbfs ncpfs ufs hfsplus udf hfs lockd ubifs', ' ')[[1]]
g2 <- strsplit('fat devpts jffs2 jfs ntfs', ' ')[[1]]
g3 <- strsplit('dlm ext3 jbd2 nfsd ext2', ' ')[[1]]
g4 <- strsplit('cifs reiserfs proc ecryptfs', ' ')[[1]]
g5 <- strsplit('kafs xfs gfs2', ' ')[[1]]
g6 <- strsplit('fuse 9p nfs ocfs2 ext4', ' ')[[1]]

my.graph(g1, c('btrfs', 'ubifs'), 'extsyms-1.png')
my.graph(g2, g2, 'extsyms-2.png')
my.graph(g3, g3, 'extsyms-3.png')
my.graph(g4, g4, 'extsyms-4.png')
my.graph(g5, g5, 'extsyms-5.png')
my.graph(g6, g6, 'extsyms-6.png')
#my.graph(rownames(sort(dd)), 'extsyms.png')

## q <- quantile(sort(dd), seq(0, 1, 0.1))
## my.graph(rownames(sort(dd[             dd < q[7]  ])), 'extsyms-1.png')
## my.graph(rownames(sort(dd[q[7]  < dd & dd < q[8]  ])), 'extsyms-2.png')
## my.graph(rownames(sort(dd[q[8]  < dd & dd < q[9]  ])), 'extsyms-3.png')
## my.graph(rownames(sort(dd[q[9]  < dd & dd < q[10] ])), 'extsyms-4.png')
## my.graph(rownames(sort(dd[q[10] < dd              ])), 'extsyms-5.png')
## my.graph(rownames(sort(dd)), 'extsyms.png')


png('extsyms.png', width=850, height=400, antialias='subpixel')
par(mar=c(4,5,1,1))
plot(d$major, d$extsyms, type='p', pch=20, cex=0.5, ann=F, axes=F)

b <- boxplot(d$extsyms ~ d$major, plot=F)
rect(0:29-0.25, b$stats[2,], 0:29+0.25, b$stats[4,], lwd=1)
segments(0:29-0.25, b$stats[3,], 0:29+0.25, b$stats[3,], lwd=3)

axis(1, at=0:29, labels=paste('2.6', 0:29, sep='.'), las=2)
axis(2)
par(ps=10)
title(ylab='Number of external symbols', line=3)

dev.off()


