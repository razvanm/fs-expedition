d <- read.table('data.one.leafs')
names(d) <- c("name", "x", "y")
scale.alpha <- 1/(max(d$x)+1) * 0.5*pi
offset.r <- 600
d$r <- offset.r + d$y
d$alpha <- d$x*scale.alpha
l <- read.table('data.one.lines')
names(l) <- c("line", "x0", "y0", "x1", "y1")
l$r0 <- offset.r + l$y0
l$alpha0 <- l$x0*scale.alpha
l$r1 <- offset.r + l$y1
l$alpha1 <- l$x1*scale.alpha

radius <- max(d$r)*1+50

png('pars.one.circos-90.png', width=800, height=800, type='cairo', antialias='subpixel')

par(mar=c(1,1,1,1))
plot(d$r*sin(d$alpha), d$r*cos(d$alpha), xlim=c(0, radius), ylim=c(0, radius), pch=20, cex=1, ann=F, axes=F)
rs <- max(d$r)
for (i in 1:nrow(d)) {
  alpha <-  - d$alpha[i]/2/pi*360 + 90
  adjx <- 0
  if (alpha < -90) {
    alpha <- alpha + 180
    adjx <- 1
  }
  r <- d$r[i] + 15
  par(ps=16*r/radius)
  text(r*sin(d$alpha[i]), r*cos(d$alpha[i]), d$name[i], adj=c(adjx, 0.4), srt=alpha, family='DejaVu Sans Condensed')
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
