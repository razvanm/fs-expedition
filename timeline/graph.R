png('timeline.png', width=1024, height=700)
par(mar=c(2,2,0,2))

start <- as.Date('1993-12-01')
end <- as.Date('2009-10-01')

# Dev releases

par(fig=c(0,1,0,1))
plot(c(start, end), c(-1,135), type='n', yaxs='i', xaxs='i', ann=F, axes=F)
axis(4, at=seq(0, 132, 3), label=seq(0, 132, 3), las=1, tick=F, line=-0.5, col.axis='gray')

d <- read.table('data-1.1', head=T)
d$date <- as.Date(d$date, '%d-%b-%Y')
#abline(v=max(d$date), lwd=0.3)
text(max(d$date), max(d$major), paste('1.1', max(d$major), sep='.'), pos=3, cex=1.2, font=2, col='gray')
s <- d$minor == 0
points(d$date[s], d$major[s], pch=20, col='gray', type='o')

d <- read.table('data-1.3', head=T)
d$date <- as.Date(d$date, '%d-%b-%Y')
#abline(v=max(d$date), lwd=0.3)
text(max(d$date), max(d$major), paste('1.3', max(d$major), sep='.'), pos=3, cex=1.2, font=2, col='gray')
s <- d$minor == 0
points(d$date[s], d$major[s], pch=20, col='gray', type='o')

d <- read.table('data-2.1', head=T)
d$date <- as.Date(d$date, '%d-%b-%Y')
#abline(v=max(d$date), lwd=0.3)
text(max(d$date), max(d$major), paste('2.1', max(d$major), sep='.'), adj=c(1.3,0), cex=1.2, font=2, col='gray')
s <- d$minor == 0
points(d$date[s], d$major[s], pch=20, col='gray', type='o')

d <- read.table('data-2.3', head=T)
d$date <- as.Date(d$date, '%d-%b-%Y')
#abline(v=max(d$date), lwd=0.3)
text(max(d$date), max(d$major), paste('2.3', max(d$major), sep='.'), pos=3, cex=1.2, font=2, col='gray')
points(d$date, d$major, pch=20, col='gray', type='o')

d <- read.table('data-2.5', head=T)
d$date <- as.Date(d$date, '%d-%b-%Y')
#abline(v=max(d$date), lwd=0.3)
text(max(d$date), max(d$major), paste('2.5', max(d$major), sep='.'), pos=3, cex=1.2, font=2, col='gray')
s <- d$minor == 0
points(d$date[s], d$major[s], pch=20, col='gray', type='o')

# Stable releases

par(fig=c(0,1,0,1), new=T)
plot(c(start, end), c(-1,135/3), type='n', yaxs='i', xaxs='i', ann=F, axes=F)
abline(h=0:44, col='gray80', lwd=0.1)

d <- read.table('data-1.0', head=T)
d$date <- as.Date(d$date, '%d-%b-%Y')
#abline(v=max(d$date), lwd=0.3)
text(max(d$date), max(d$major), '1.0', pos=3, cex=2, font=2)
s <- d$minor == 0
points(d$date[s], d$major[s], pch=20, cex=2)

d <- read.table('data-1.2', head=T)
d$date <- as.Date(d$date, '%d-%b-%Y')
#abline(v=max(d$date), lwd=0.3)
text(max(d$date), max(d$major), paste('1.2', max(d$major), sep='.'), pos=3, cex=2, font=2)
s <- d$minor == 0
points(d$date[s], d$major[s], pch=20, cex=2, type='o')

d <- read.table('data-2.0', head=T)
d$date <- as.Date(d$date, '%d-%b-%Y')
#abline(v=max(d$date), lwd=0.3)
text(max(d$date), max(d$major), paste('2.0', max(d$major), sep='.'), pos=3, cex=2, font=2)
s <- d$minor == 0
points(d$date[s], d$major[s], pch=20, cex=2, type='o')

d <- read.table('data-2.2', head=T)
d$date <- as.Date(d$date, '%d-%b-%Y')
#abline(v=max(d$date), lwd=0.3)
text(max(d$date), max(d$major), paste('2.2', max(d$major), sep='.'), adj=c(0.9,-0.5), cex=2, font=2)
s <- d$minor == 0
points(d$date[s], d$major[s], pch=20, cex=2, type='o')

d <- read.table('data-2.4', head=T)
d$date <- as.Date(d$date, '%d-%b-%Y')
#abline(v=max(d$date), lwd=0.3)
text(max(d$date), max(d$major), paste('2.4', max(d$major), sep='.'), adj=c(0.9,-0.5), cex=2, font=2)
s <- d$minor == 0
points(d$date[s], d$major[s], pch=20, cex=2, type='o')

d <- read.table('data-2.6', head=T)
d$date <- as.Date(d$date, '%d-%b-%Y')
text(max(d$date), max(d$major), paste('2.6', max(d$major), sep='.'), pos=3, cex=2, font=2)
s <- d$minor > 0
points(d$date[s], d$major[s], pch='|', cex=0.4)
s <- d$minor == 0
points(d$date[s], d$major[s], pch=20, cex=2, type='o')

# Axis and title

axis(2, at=0:40, label=0:40, las=1, tick=F, line=-0.5)
axis.Date(1, at=seq(as.Date('1994-01-01'), end, 'year'))
#title('Timeline of Linux Kernel releases', cex.main=2)

dev.off()
