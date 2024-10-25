
### Atomic vector types
dbl_var <- c(1, 1.5, 2.5) # 실수형 벡터
int_var <- c(10L, 4L, 3L) # 정수형 벡터 / L : integer 지정정
log_var <- c(TRUE, FALSE, T, F)
chr_var <- c("these are", "some strings")

typeof(dbl_var)
typeof(int_var)
typeof(log_var)
typeof(chr_var)

### Atomic vector coercion
str(c("a", 1)) # 가장 유연한 type 강제제

x <- c(FALSE, FALSE, TRUE) # logical과 numeric의 대응관계
as.numeric(x)

### List - 서로 다른 type들의 원소 => type 유지가능능
x <- list(3:5, "bcd", c(TRUE, FALSE, TRUE), c(2.3, 5.9))
typeof(x)
str(x)


### Factors - 미리 정의된 값들만 포함할 수 있는 vector
x <- factor(c("a", "b", "b", "a"))
x
levels(x)
table(x)

x[2] <- "c" # levels에 미리 들어있지 않은 값들은 사용 불가
x


### Matrix
a <- matrix(1:6, ncol = 3, nrow = 2)
a
b <- array(1:12, c(2, 3, 2))
b
c <- 1:6
dim(c) <- c(3, 2)
c
dim(c) <- c(2, 3)
c

length(a)
nrow(a)
ncol(a)

rownames(a) <- c("A", "B")
colnames(a) <- c("a", "b", "c")
a

### Data frame
df <- data.frame(x = 1:3, y = c("a", "b", "c"))
str(df)

df <- data.frame(x = 1:3, y = c("a", "b", "c"),
                 stringsAsFactors = FALSE)
str(df)

df <- data.frame(x = 1:3, y = c("a", "b", "c"),
                 stringsAsFactors = TRUE)
str(df)

typeof(df)
class(df)
is.data.frame(df)

# unlist(df) : 리스트, 벡터 등을 단일 벡터로 변환 (flatten)


### object size
if (!require("BiocManager", quietly = TRUE)) # 설치되어 있다면 True 반환
  install.packages("BiocManager")
BiocManager::install("multtest")
library(lobstr)
library(multtest)

letters
obj_size(letters)
data(golub)
str(golub)
obj_size(golub)


1L:10L
typeof(1L:10L)
a <- matrix(sample(1L:10L, size = 10000*5, replace = TRUE), ncol = 5)
obj_size(a)

1.1:10.1
typeof(1.1:10.1)
b <- matrix(sample(1.1:10.1, size = 10000*5, replace = TRUE), ncol = 5)
obj_size(b)

# List로 묶이면 값들을 '참조'만 => 크기 down
x <- runif(1e7)
length(x)
obj_size(x)

y <- list(x, x, x) # list가 같은 객체 3번 참조 
obj_size(y) 
obj_size(y) - obj_size(x)
obj_size(list(NULL, NULL, NULL)) # list 자체의 메타데이터 크기 존재

obj_size(1:1000)
obj_size(1:100000)
z <- 1e9
obj_size(1:z) # 벡터가 큰 경우, 연속된 메모리 블록을 사용하여 더 효율적으로 할당


### Bisection algorithm
a <- -1; b <- 2
eps <- 1e-3
for(k in 1:1000){ # maxiter = 1000
  
  gam <- (a+b)/2 # 구간의 중앙
  fp_gam <- a + b # f'(gamma)
  
  cat("a: ", a, " gam: ", gam, " b: ", b, "f'(gam)", fp_gam)
  
  if(fp_gam < 0) a <- gam else b <- gam
  if(abs(a-b) < eps) break
  cat("\n")
}


### Logical variables 1
3 < 4
3 <= 4
3 > 4
3 >= 4
3 == 4
3 != 4
as.numeric(3 == 4) # False -> 0
as.numeric(3 != 4) # True -> 1

### Logical variables 2
x <- c(1, 2, 3, 4, 5, 6, 7)
y <- c(7, 6, 5, 4, 3, 2, 1)
z <- c(4)
x > y
x > z # 재활용

### Logical variables 3
c(1, 1, 1, 0, 0) & c(1, 1234, 0, 1, 0) # & : logical => 1234는 True가 됨
c(1, 1, 1, 0, 0) | c(1, 1234, 0, 1, 0)
xor(c(1, 1, 1, 0, 0), c(1, 1234, 0, 1, 0))
!c(1, 1, 1, 0, 0)

### Logical variables 4
c(1, 1, 1, 0, 0) && c(1, 1234, 0, 1, 0) # 연산자 두개 -> 단일 원소에만 적용
c(1, 1, 1, 0, 0) || c(1, 1234, 0, 1, 0) # 다중 원소이면 첫번째 원소에 적용 // 근데 경고문구 뜸
0 || 0
0 || 1
1 || 1
c(0, 1) || c(0, 1)
0 && 0
1 && 0

### Logical variables 5
2*2 == 4
sqrt(2)*sqrt(2)
sqrt(2)*sqrt(2) == 2
all.equal(sqrt(2)*sqrt(2), 2) # all.equal: is a utility to compare R objects x and y testing ‘near equality’
2-sqrt(2)*sqrt(2)
