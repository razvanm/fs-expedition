my.colors58 <- rainbow(58)
my.colors30 <- rainbow(30)

d <- read.table('data.all.leafs')
names(d) <- c("name", "x", "y")
d$name <- as.character(d$name)
d$fs <- factor(unlist(lapply(strsplit(d$name, '-'), function(x) { x[1] })))
d$major <- factor(unlist(lapply(strsplit(d$name, '-'), function(x) { x[2] })))
scale.alpha <- 1/(max(d$x)+1) * 1.99*pi
offset.r <- 30
d$r <- offset.r + d$y
d$alpha <- d$x*scale.alpha
l <- read.table('data.all.lines')
names(l) <- c("line", "x0", "y0", "x1", "y1")
l$r0 <- offset.r + l$y0
l$alpha0 <- l$x0*scale.alpha
l$r1 <- offset.r + l$y1
l$alpha1 <- l$x1*scale.alpha

radius <- max(d$r)*1

png('pars.all.circos.png', width=800, height=800, type='cairo', antialias='subpixel')

par(mar=c(1,1,1,1))
plot(d$r*sin(d$alpha), d$r*cos(d$alpha), xlim=c(-radius, radius), ylim=c(-radius, radius), type='n', ann=F, axes=F)
#text(d$r*sin(d$alpha), d$r*cos(d$alpha), d$name, adj=c(0.5, 0.5), srt=0)
r <- radius-60
rs <- max(d$r)
for (i in 1:nrow(d)) {
  alpha <-  - d$alpha[i]/2/pi*360 + 90
  adjx <- 0
  if (alpha < -90) {
    alpha <- alpha + 180
    adjx <- 1
  }
  r <- d$r[i] + 15
  par(ps=1+20*r/radius)
  #text(r*sin(d$alpha[i]), r*cos(d$alpha[i]), d$name[i], adj=c(adjx, 0.4), srt=alpha, family='DejaVu Sans Condensed')
  #segments(r*sin(d$alpha[i]), r*cos(d$alpha[i]), rs*sin(d$alpha[i]), rs*cos(d$alpha[i]), lwd=1)
  #segments(d$r[i]*sin(d$alpha[i]), d$r[i]*cos(d$alpha[i]), rs*sin(d$alpha[i]), rs*cos(d$alpha[i]), lwd=0.5, col='grey')
  #points(d$r[i]*sin(d$alpha[i]), d$r[i]*cos(d$alpha[i]), pch=20, cex=0.3, col=my.colors58[d$fs[i]])
  rinc <- radius*0.0125
  segments((radius+rinc)*sin(d$alpha[i]),   (radius+rinc)*cos(d$alpha[i]),
           (radius+2*rinc)*sin(d$alpha[i]), (radius+2*rinc)*cos(d$alpha[i]), col=my.colors58[d$fs[i]], lwd=2)
  rspace <- rinc
  segments((radius+rspace+2*rinc)*sin(d$alpha[i]), (radius+rspace+2*rinc)*cos(d$alpha[i]),
           (radius+rspace+3*rinc)*sin(d$alpha[i]), (radius+rspace+3*rinc)*cos(d$alpha[i]), col=my.colors30[d$major[i]], lwd=2)
}

for (i in 1:nrow(l)) {
  if (l$r0[i] == l$r1[i]) {
    inc <- 2*pi/200
    if (l$alpha0[i] > l$alpha1[i]) inc <- -inc
    a <- c(seq(l$alpha0[i], l$alpha1[i], inc), l$alpha1[i])
    r <- l$r0[i]
    lines(r*sin(a), r*cos(a), lwd=1)
    #cat(l$alpha0[i], l$alpha1[i], a[1], a[length(a)], fill=T)
  } else {
    segments(l$r0[i]*sin(l$alpha0[i]), l$r0[i]*cos(l$alpha0[i]), l$r1[i]*sin(l$alpha1[i]), l$r1[i]*cos(l$alpha1[i]), lwd=1)
  }
}

dev.off()
