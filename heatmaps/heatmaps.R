my.read <- function(f) {
  d <- read.table(f, head=T)
  colnames(d) <- gsub('^X','', gsub('.o$','',colnames(d)))
  rownames(d) <- gsub('.o$','',rownames(d))
  d
}


for (i in seq(0, 29)) {
  cat(i, fill=T)
  d <- my.read(paste('heatmap-2.6', i, sep='.'))

  png(paste('heatmap.hamm.2.6', i, 'png', sep='.'), width=400, height=400)
  par(mar=c(1,1,3,1), ps=16, pty='s')
  image(as.matrix(d), zlim=c(0, 400), axes=F)
  box()
  title(paste('2.6', i, sep='.'))
  dev.off()
}
