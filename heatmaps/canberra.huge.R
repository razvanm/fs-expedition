my.colors58 <- rainbow(58)
my.colors30 <- rainbow(30)
d <- read.table('summaryall', head=T)

dm <- matrix(0, nrow=length(levels(d$fs)), ncol=length(levels(d$extcall)))
rownames(dm) <- levels(d$fs)
d$fs <- as.integer(d$fs)
d$extcall <- as.integer(d$extcall)
for (i in seq(1, dim(d)[1])) {
  dm[d$fs[i], d$extcall[i]] = 1
}

my.plot <- function(method) {
  h <- hclust(dist(dm, method='canberra'), method=method)
  #h <- hclust(as.dist(rev(d)), method)
  n <- length(h$labels)
  h$x <- sapply(1:n, function(x) { which (x == h$order) })
  h$y <- rep(0, n)
  h$fs <- factor(unlist(lapply(strsplit(h$labels, '-'), function(x) { x[1] })))
  h$major <- factor(unlist(lapply(strsplit(h$labels, '-'), function(x) { x[2] })))
  for (i in 1:length(h$height)) {
    m <- h$merge[i,]
    if (m[1] < 0) h$y[-m[1]] <- h$height[i]
    if (m[2] < 0) h$y[-m[2]] <- h$height[i]
  }
  
  scale.alpha <- 1/(max(h$x)+1) * 1.99*pi
  offset.r <- max(h$height) 
  h$r <- offset.r - h$y
  h$alpha <- h$x*scale.alpha

  radius <- max(h$height)*1.1

  png(paste('circos.canberra', method, 'huge.png', sep='.'), width=5500, height=5500, type='cairo', antialias='subpixel')
  
  par(mar=c(1,1,1,1), ps=9)
  plot(h$r*sin(h$alpha), h$r*cos(h$alpha), xlim=c(-radius, radius), ylim=c(-radius, radius), type='n', ann=F, axes=F)
  points(0, 0, pch=20, cex=2)
  rs <- max(h$r)*1.07
  for (i in 1:n) {
    i <- h$order[i]
    alpha <-  - h$alpha[i]/2/pi*360 + 90
    adjx <- 1
    if (alpha < -90) {
      alpha <- alpha + 180
      adjx <- 0
    }
    rinc <- radius*0.0125
    r <- radius
    text(r*sin(h$alpha[i]), r*cos(h$alpha[i]), h$fs[i], adj=c(adjx, 0.4), srt=alpha, family='DejaVu Sans Condensed')
    r <- r + 4.5*rinc
    text(r*sin(h$alpha[i]), r*cos(h$alpha[i]), paste('2.6.',h$major[i], sep=''), adj=c(1-adjx, 0.4), srt=alpha, family='DejaVu Sans Condensed')
    segments(h$r[i]*sin(h$alpha[i]), h$r[i]*cos(h$alpha[i]), rs*sin(h$alpha[i]), rs*cos(h$alpha[i]), lwd=0.5, col='grey')
    segments((radius+rinc)*sin(h$alpha[i]),   (radius+rinc)*cos(h$alpha[i]),
             (radius+2*rinc)*sin(h$alpha[i]), (radius+2*rinc)*cos(h$alpha[i]), col=my.colors58[h$fs[i]], lwd=10)
    rspace <- rinc
    segments((radius+rspace+2*rinc)*sin(h$alpha[i]), (radius+rspace+2*rinc)*cos(h$alpha[i]),
             (radius+rspace+3*rinc)*sin(h$alpha[i]), (radius+rspace+3*rinc)*cos(h$alpha[i]), col=my.colors30[h$major[i]], lwd=10)

##     rinc <- radius*0.0125
##     segments((radius+rinc)*sin(h$alpha[i]),   (radius+rinc)*cos(h$alpha[i]),
##              (radius+2*rinc)*sin(h$alpha[i]), (radius+2*rinc)*cos(h$alpha[i]), col=my.colors58[h$fs[i]], lwd=2)
##     rspace <- rinc
##     segments((radius+rspace+2*rinc)*sin(h$alpha[i]), (radius+rspace+2*rinc)*cos(h$alpha[i]),
##              (radius+rspace+3*rinc)*sin(h$alpha[i]), (radius+rspace+3*rinc)*cos(h$alpha[i]), col=my.colors30[h$major[i]], lwd=2)
##     par(ps=8)
##     #text(radius*sin(h$alpha[i]), radius*cos(h$alpha[i]), h$label[i], adj=c(adjx, 0.4), srt=alpha, family='DejaVu Sans Condensed')
  }

  for (i in 1:length(h$height)) {
    m <- h$merge[i,]
    l <- data.frame(x0=c(0, 0), y0=c(0, 0), x1=c(0, 0), y1=c(0, 0))

    if (m[1] < 0) {
      l$x0[1] <- which(h$order == -m[1])
      l$y0[1] <- 0
    } else {
      l$x0[1] <- h$mid[m[1]]
      l$y0[1] <- h$height[m[1]]
    }
    l$x1[1] <- l$x0[1]
    l$y1[1] <- h$height[i]

    if (m[2] < 0) {
      l$x0[2] <- which(h$order == -m[2])
      l$y0[2] <- 0
    } else {
      l$x0[2] <- h$mid[m[2]]
      l$y0[2] <- h$height[m[2]]
    }
    l$x1[2] <- l$x0[2]
    l$y1[2] <- h$height[i]

    h$mid[i] <- (l$x0[1] + l$x0[2])/2

    l$r0 <- offset.r - l$y0
    l$alpha0 <- l$x0*scale.alpha
    l$r1 <- offset.r - l$y1
    l$alpha1 <- l$x1*scale.alpha
    
    segments(l$r0*sin(l$alpha0), l$r0*cos(l$alpha0), l$r1*sin(l$alpha1), l$r1*cos(l$alpha1), lwd=3)

    alpha0 <- l$x1[1]*scale.alpha
    alpha1 <- l$x1[2]*scale.alpha

    inc <- 2*pi/200
    if (alpha0 > alpha1) inc <- -inc
    a <- c(seq(alpha0, alpha1, inc), alpha1)
    r <- offset.r - h$height[i]
    lines(r*sin(a), r*cos(a), lwd=3)
  }

  dev.off()

}

my.plot('ward')
my.plot('complete')
my.plot('average')
my.plot('mcquitty')
my.plot('single')
