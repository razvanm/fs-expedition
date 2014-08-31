d <- read.table('extsyms', head=T)

my.graph <- function(fs.group, fs.labels, outfile) {
  png(outfile, width=850, height=400, antialias='subpixel')

  par(mar=c(4,5,1,4))
  plot(d$index, d$extsyms, type='n', ylim=c(-10, 300), yaxs='i', ann=F, axes=F)
# , xaxs='i', yaxs='i'
# xlim=c(-0.5,29.5), ylim=c(-10, 350), 
  for (fs in fs.group) {
    s <- d$fs == fs
    #cat(fs, '--', d$index[s], '--', d$extsyms[s], fill=T)
    lines(d$index[s], d$extsyms[s], type='b', pch=20, lwd=2)
  }

  sel <- d$fs %in% fs.labels & d$index == max(d$index)
  axis(1, at=unique(d$index), labels=unique(d$release))
  axis(2)
  axis(4, at=d$extsym[sel], labels=d$fs[sel], tick=F, las=2, line=-1)
  par(ps=10)
  title(ylab='Number of external symbols', line=3)
  dev.off()
}

gall <- strsplit('cd9660 coda coda5 ext2fs fdescfs geom_vol_ffs linprocfs linsysfs mqueuefs msdosfs nfsclient nfslockd nfsmb nfsserver ntfs nullfs nwfs portalfs procfs pseudofs reiserfs smbfs tmpfs udf umapfs unionfs xfs zfs', ' ')[[1]]

g1 <- strsplit('coda coda5 nfsclient nfsclient nwfs pseudofs smbfs nfsmb', ' ')[[1]]
g1l <- strsplit('coda      nfsclient nfsclient nwfs pseudofs smbfs nfsmb', ' ')[[1]]
g2 <- strsplit('linprocfs linsysfs nullfs procfs unionfs', ' ')[[1]]
g3 <- strsplit('cd9660 udf nfslockd nfsmb portalfs tmpfs', ' ')[[1]]
g4 <- strsplit('ext2fs msdosfs ntfs reiserfs xfs zfs', ' ')[[1]]
g5 <- strsplit('mqueuefs procfs fdescfs nfslockd', ' ')[[1]]
my.graph(g1, g1l, 'extsyms-1.png')
my.graph(g2, g2, 'extsyms-2.png')
my.graph(g3, g3, 'extsyms-3.png')
my.graph(g4, g4, 'extsyms-4.png')
my.graph(g5, g5, 'extsyms-5.png')

