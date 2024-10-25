
### Example 1.2.2
p <- seq(0,1,0.001) # 각 상태변수의 확률
h1 <- (1-(1-p)^2)*(1-(1-(1-(1-p)^2))^2) # 시스템1의 확률
h2 <- 1-(1-p*(1-(1-p)^2))^2
h.dif=h1-h2

summary(h.dif)
results <- cbind(p, h1, h2, h.dif)
results
head(results, 10)
tail(results, 10)
max(h.dif)
p.maxdif <- p[which.max(h.dif)]
p.maxdif

# Plotting
x11() # 새로운 그래픽 창을 연다
par(mfrow=c(1,2)) # 한 행에 두 개의 그래프를 나란히 그릴 수 있도록 설정
plot(p, h2, type="l", ylab="h", lty=2, lwd=2, cex.main=1.5, cex.lab=1.5, cex.axis=1.5)
text(0.4, 0.3, "h2", cex=1.5)
lines(p, h1)
text(0.4, 0.7, "h1", cex=1.5)

plot(p, h.dif, type="l", ylim=c(0,0.15), ylab="h1-h2",
     lwd=1.5, cex.main=1.5, cex.lab=1.5, cex.axis=1.5)
segments(p.maxdif, 0, p.maxdif, max(h.dif), col = "red") # 최대인 지점 표시


#f1p <- function(p) 2*(1-p)*(1-(1-p)^4) + (1-(1-p)^2)*4*(1-p)^3 
#f2p <- function(p) 2*(1-p*(1-(1-p)^2))*(1+2*p*(1-p)-(1-p)^2)
fp <- function(p) 2*(1-p)*(1-(1-p)^4) + (1-(1-p)^2)*4*(1-p)^3 - 2*(1-p*(1-(1-p)^2))*(1+2*p*(1-p)-(1-p)^2)
plot(p, fp(p), type="l", ylab="f'(p)")
abline(h=0, lty = 2, col = "red")

a <- 0.001; b <- 0.999
eps <- 1e-5
for(k in 1:1000){
  
  gam <- (a+b)/2
  fp_gam <- -fp(gam)
  
  cat("a: ", a, " gam: ", gam, " b: ", b, "f'(gam)", fp_gam)
  
  if(fp_gam < 0) a <- gam else b <- gam
  if(abs(a-b) < eps) break
  cat("\n")
}

uniroot(fp, c(0, 1))
uniroot(fp, c(0.001,0.999))

# x^2 - 1 이 0이 되는 지점 찾기
f <- function(x) x^2 - 1
result <- uniroot(f, c(-2, 0))
result
