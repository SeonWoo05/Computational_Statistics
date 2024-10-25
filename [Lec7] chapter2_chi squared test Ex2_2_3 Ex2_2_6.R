### chi-square goodness of test and Kolmogorov-Smirnov test
set.seed(123)
a <- runif(100)
plot(ecdf(a), verticals = TRUE, do.points = FALSE, col.01line = NULL)
# ecdf : 경험분포함수 / verticals : 세로 연결선 / do.points : 각 자료에 점찍기 / col.01line : y=0,1에 선
abline(0, 1, col = "red")

a.tab <- table(cut(a, breaks = seq(0, 1, by = 0.1), right = FALSE,
                   include.lowest = TRUE)) # a 데이터를 구간별로 나누고, 각 구간에 속하는 값들의 개수를 계산하여 빈도표 생성
# right=FALSE : 오른쪽을 포함하지 않도록 지정
a.tab
a[1:5]
cut(a[1:5], breaks = seq(0, 1, by = 0.1), right = FALSE)
sort(a)[1:20]

a.chi <- chisq.test(x = a.tab, p = rep(0.1, 10)) # p는 가정된 기대확률
# 표준균일 분포 => rep(0.1, 10)은 0.1이 10번 반복된 벡터로, 각 구간에 포함될 확률이 동일하다는 가정을 의미
a.chi
a.chi$p.value # p-값은 관측된 데이터가 가정된 균일분포로부터 얼마나 벗어나는지 / 0.05보다 작으면 H0 기각
a.chi$statistic
sum((a.tab-10)^2/10) # 관측빈도와 기대빈도 차이를 제곱, 기대빈도로 나눈 값 => 합하면 카이제곱 검정통계량
1-pchisq(sum((a.tab-10)^2/10), df = 9) # pchisq(): 카이제곱 누적분포함수를 사용하여 통계량의 누적 확률을 계산
# 1 - pchisq(): 누적 확률 값을 1에서 빼서 오른쪽 꼬리 확률, 즉 p-값을 계산
# 검정통계량보다 작은 값이 나올 확률을 계산 => 검정통계량이 크다면 pchisq() 값이 커지고, 1-pchisq() 가 매우 작아짐 => 유의수준보다 작으면 Ho기각
a.chi$expected


a.tab2 <- table(cut(a, breaks = seq(0, 1, by = 0.05), right = FALSE,
                    include.lowest = TRUE))
a.chi2 <- chisq.test(x = a.tab2, p = rep(0.05, 20))
a.chi2

# Kolmogorov-Smirnov (K-S) 검정
ks.test(runif(100), "punif") # 두 분포가 동일한지 확인
ks.test(runif(100), "pnorm") # 균일분포에서 생성하고 정규분포와 같은지 비교 => 당연히 p-value 낮게나옴 => 다르다고 판단


###############################################################################################
### Example 2.2.3 & 2.2.6
Rand1 <- c(0.672, 0.240, 0.597, 0.716, 0.173, 0.464, 0.945, 0.148, 0.476, 0.577,
           0.747, 0.887, 0.941, 0.994, 0.932, 0.279, 0.300, 0.402, 0.891, 0.467, 
           0.027, 0.421, 0.981, 0.355, 0.566, 0.250, 0.992, 0.488, 0.996, 0.013,
           0.910, 0.295, 0.233, 0.024, 0.833, 0.686, 0.364, 0.698, 0.377, 0.445, 
           0.208, 0.306, 0.407, 0.412, 0.693, 0.319, 0.459, 0.914, 0.144, 0.539,
           0.675, 0.404, 0.080, 0.749, 0.601, 0.794, 0.607, 0.090, 0.705, 0.441,
           0.008, 0.891, 0.937, 0.247, 0.618, 0.176, 0.187, 0.869, 0.578, 0.546, 
           0.990, 0.469, 0.570, 0.680, 0.311, 0.008, 0.113, 0.159, 0.751, 0.531, 
           0.525, 0.831, 0.037, 0.422, 0.141, 0.445, 0.120, 0.093, 0.877, 0.763,
           0.729, 0.078, 0.747, 0.879, 0.738, 0.997, 0.400, 0.949, 0.166, 0.369)

### Chi-squared test
Rand1.tab <- table(cut(Rand1, breaks = seq(0, 1, by = 0.1), right = FALSE,
                       include.lowest = TRUE))
Rand1.tab
Rand1.chi <- chisq.test(x = Rand1.tab, p = rep(0.1, 10))
Rand1.chi
1 - pchisq(6.4, df = 9)


### Kolmogorov-Smirnov test
ks.test(Rand1, "punif")
# 결과해석
# Asymptotic one-sample Kolmogorov-Smirnov test : 단일 표본 검정인데 근사적 방법 사용
# D = 0.059 : ECDF와 CDF의 최대 차이
# alternative hypothesis: two-sided : 대립가설이 two-sided => 양측검정 수행했음

?rle
### Up-and-Down test
# 값의 증가 또는 감소 패턴을 분석하여 데이터의 독립성을 평가
N <- length(Rand1)
# sign(): diff(Rand1)의 차이를 기호로 변환
Rand1.run <- sign(diff(Rand1)) # 연속된 값들의 차이 => 처음 원소는 사라질 것
diff(Rand1)[1:5]
Rand1.run[1:10]
rle(Rand1.run) # Run Length Encoding 함수 : 동일한 값이 연속해서 몇 번 등장하는지를 계산
Z <- (64 - (2*N - 1)/3)/sqrt((16*N-29)/90) # 기대되는 런(run)의 수를 기반으로 표준 정규분포로 검정 통계량을 변환
Z
pnorm(Z) # Z 통계량에 대한 누적 분포 함수 : 표준 정규분포에서 Z 값보다 작은 값이 나올 확률
2*pnorm(Z) # 양측 => p-value 높음 => 독립적이라 할 수 있다!

### Run above and below the mean test
(m <- mean(Rand1))
Rand1.run2 <- sign(Rand1 - m) # R에서는 변수 이름에 .(점)을 포함 가능
Rand1.run2[1:10]
rle(Rand1.run2) # 같은 부호(1 또는 -1)가 연속되는 구간을 계산
table(Rand1.run2) # table로 평균값보다 큰, 작은 값의 개수를 알려줌. m=49, n=51
Z2 <- (50 - (2*49*51/N+1))/sqrt((2*49*51*(2*49*51-N))/(N^2*(N-1)))
Z2
pnorm(Z2)
2*pnorm(Z2)