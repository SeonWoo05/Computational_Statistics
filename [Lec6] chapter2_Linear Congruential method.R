## maximum integer
.Machine$integer.max #32bit의 최대 정수 개수
2^31-1

### Linear Congruential Generator example

## modular operation: %% 
## Returns remainder 
9%%3 #0
9%%2 #1 
7331%%331 #49 : 나머지 연산자
7331%/%331 #22 : 정수 나눗셈 연산자
7331/331 #22.14804 : 나눗셈 연산자
331*22 + 49

LCG_ex <- function(n, m, a, c, x0){ # 선형 합동 생성기
  out <- rep(0, n) # 배열 out을 0 n개로 설정
  out[1] <- (a*x0 + c)%%m
  for(i in 2:n) out[i] <- (a*out[i-1]+c)%%m
  return(out/m) # 0~1 사이의 값 반환 위해 생성된 난수를 m으로 나누어 반환
}
LCG_ex2 <- function(n, m, a, c, x0){
  #out <- rep(0, n)
  out <- (a*x0 + c)%%m
  for(i in 2:n) out[i] <- (a*out[i-1]+c)%%m # 동적 배열 확장은 매번 배열의 크기를 늘려야 하기 때문에 성능 상의 불이익
  return(out/m)
}


system.time(re1 <- LCG_ex(n = 1000000, m = 8, a = 3, c = 1, x0 = 3))
system.time(re2 <- LCG_ex2(n = 1000000, m = 8, a = 3, c = 1, x0 = 3))
identical(re1, re2)

### More examples
# 완전 주기 조건
# a=1인 경우 법수 m의 소인수에 관계없이 a=1 (mod p)
# But  Xn+1 = 1*Xn + 1 (mod p) 이므로 Xn+1 이 Xn + 1 혹은 0이 됨
# 과연 좋은 난수열인가?
re3 <- LCG_ex(n = 32, m = 16, a = 1, c = 1, x0 = 1)
re3*16
re4 <- LCG_ex(n = 32, m = 16, a = 1, c = 1, x0 = 2) 
re4*16
# m=15인 경우 a=1 (mod 3),(mod 5) 을 만족함 => 없음
re5 <- LCG_ex(n = 32, m = 15, a = 1, c = 1, x0 = 1)
re5*15
re6 <- LCG_ex(n = 32, m = 15, a = 2, c = 1, x0 = 1)
re6*15
re7 <- LCG_ex(n = 32, m = 15, a = 3, c = 1, x0 = 1)
re7*15
re8 <- LCG_ex(n = 32, m = 15, a = 4, c = 1, x0 = 1)
re8*15
re9 <- LCG_ex(n = 32, m = 15, a = 5, c = 1, x0 = 1)
re9*15
re10 <- LCG_ex(n = 32, m = 15, a = 6, c = 1, x0 = 1)
re10*15
re11 <- LCG_ex(n = 32, m = 15, a = 7, c = 1, x0 = 1)
re11*15
re12 <- LCG_ex(n = 32, m = 15, a = 8, c = 1, x0 = 1)
re12*15
re13 <- LCG_ex(n = 32, m = 15, a = 9, c = 1, x0 = 1)
re13*15
re14 <- LCG_ex(n = 32, m = 15, a = 10, c = 1, x0 = 1)
re14*15
re15 <- LCG_ex(n = 32, m = 15, a = 11, c = 1, x0 = 1)
re15*15
re16 <- LCG_ex(n = 32, m = 15, a = 12, c = 1, x0 = 1)
re16*15
re17 <- LCG_ex(n = 32, m = 15, a = 13, c = 1, x0 = 1)
re17*15
re18 <- LCG_ex(n = 32, m = 15, a = 14, c = 1, x0 = 1)
re18*15

# 31개 => 주기 15
LCG_ex(n = 33, m = 31, a = 19, c = 1, x0 = 1)*31