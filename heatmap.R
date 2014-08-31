my.read <- function(f) {
  d <- read.table(f, head=T)
  colnames(d) <- gsub('^X','', gsub('.o$','',colnames(d)))
  rownames(d) <- gsub('.o$','',rownames(d))
  d
}

## d <- my.read('summary.tux3.heatmap')

## png('summary.tux3.heatmap.png', width=900, height=900)
## par(mar=c(6,6,6,6))
## image(as.matrix(d), col=rev(gray.colors(256)), axes=F)
## axis(1, at=(1:dim(d)[1] - 1)/(dim(d)[1]-1), labels=rownames(d), las=2)
## axis(3, at=(1:dim(d)[1] - 1)/(dim(d)[1]-1), labels=rownames(d), las=2)
## axis(2, at=(1:dim(d)[2] - 1)/(dim(d)[2]-1), labels=colnames(d), las=2)
## axis(4, at=(1:dim(d)[2] - 1)/(dim(d)[2]-1), labels=colnames(d), las=2)
## box()
## dev.off()

## png('summary.tux3.heatmap+hclust.png', width=900, height=900)
## par(mar=c(6,6,6,6))
## heatmap(as.matrix(d), scale='none', revC=T, col=rev(gray.colors(256)), cexRow=1.2, cexCol=1.2)
## dev.off()



## d <- my.read('summary.tux3.heatmap-prop')

## png('summary.tux3.heatmap-prop.png', width=900, height=900)
## par(mar=c(6,6,6,6))
## image(as.matrix(d), col=rev(gray.colors(256)), axes=F)
## axis(1, at=(1:dim(d)[1] - 1)/(dim(d)[1]-1), labels=rownames(d), las=2)
## axis(3, at=(1:dim(d)[1] - 1)/(dim(d)[1]-1), labels=rownames(d), las=2)
## axis(2, at=(1:dim(d)[2] - 1)/(dim(d)[2]-1), labels=colnames(d), las=2)
## axis(4, at=(1:dim(d)[2] - 1)/(dim(d)[2]-1), labels=colnames(d), las=2)
## box()
## dev.off()

## png('summary.tux3.heatmap-prop+hclust.png', width=900, height=900)
## par(mar=c(6,6,6,6))
## heatmap(as.matrix(d), scale='none', revC=T, col=rev(gray.colors(256)), cexRow=1.2, cexCol=1.2)
## dev.off()


d <- my.read('summary.tux3.heatmap-hamm')

png('summary.tux3.heatmap.hamm.png', width=900, height=900)
par(mar=c(6,6,6,6))
image(as.matrix(d), axes=F)
axis(1, at=(1:dim(d)[1] - 1)/(dim(d)[1]-1), labels=rownames(d), las=2)
axis(3, at=(1:dim(d)[1] - 1)/(dim(d)[1]-1), labels=rownames(d), las=2)
axis(2, at=(1:dim(d)[2] - 1)/(dim(d)[2]-1), labels=colnames(d), las=2)
axis(4, at=(1:dim(d)[2] - 1)/(dim(d)[2]-1), labels=colnames(d), las=2)
box()
dev.off()

## png('summary.tux3.heatmap-hamm+hclust.png', width=900, height=900)
## par(mar=c(6,6,6,6))
## heatmap(as.matrix(d), scale='none', revC=T, col=rev(gray.colors(256)), cexRow=1.2, cexCol=1.2)
## dev.off()

my.heatmap <- function(d, method) {
  png(paste('summary.tux3.heatmap.hamm', method, 'png', sep='.'), width=900, height=900)
  layout(rbind(c(0, 3), 2:1), c(1, 4), c(1, 4), respect=T)
  par(mar=c(6,0,0,6), ps=11)

  h <- hclust(as.dist(rev(d)), method)
  m <- as.matrix(rev(d))[h$order, h$order]
  n <- dim(d)[1]
  image(1:n, 1:n, m, axes=F, ann=F)
  axis(1, 1:n, h$labels[h$order], las=2)
  axis(3, 1:n, labels=F)
  axis(2, 1:n, labels=F)
  axis(4, 1:n, h$labels[h$order], las=2)
  cat(method, h$labels[h$order], fill=T)
  box()

  ddr <- as.dendrogram(h)
  par(mar=c(6,1,0,6))
  plot(ddr, horiz=T, axes=F, yaxs="i")
  par(mar=c(6,0,1,6))
  plot(ddr, axes=F, xaxs="i")

  dev.off()

  png(paste('summary.tux3.hclust.hamm', method, 'png', sep='.'), width=800, height=400)
  par(mar=c(0,0,0,3))
  plot(h, axes=F, ann=F)
#  plot(as.dendrogram(h, hang=0.1), horiz=T, axes=F, ann=F)
  dev.off()
}

my.heatmap(d, 'ward')
my.heatmap(d, 'complete')
my.heatmap(d, 'average')
my.heatmap(d, 'mcquitty')
