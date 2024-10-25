### Internal representation of R object

library(lobstr)

x <- c(1, 2, 3)
y <- x
obj_addr(x) # 메모리 주소 출력
obj_addr(y)

y[[3]] <- 4
obj_addr(x)
obj_addr(y)
y

### use of [[]]
x
x[[3]]
x[[1:2]]
aa <- c(a=1, b=2)
aa
aa[1]
aa[[1]]

## tracemem()
cat(tracemem(x), "\n")
y <- x
y[[3]] <- 4
obj_addr(y)

## copy of objects in for loop
a <- data.frame(matrix(runif(5 * 1e4), ncol = 5))
head(a)
medians <- apply(a, 2, median)
medians
identical(a[,1], a[[1]])
cat(tracemem(a), "\n")

for (i in 1:5) {
  cat(i, "\n")
  a[[i]] <- a[[i]] - medians[[i]]
}  
# 데이터 프레임 대신 리스트를 사용하면 복사를 피할 수 있음 (내부의 C코드 이용)
b <- as.list(a)
str(b)
str(a)
cat(tracemem(b), "\n")
for (i in 1:5) {
  b[[i]] <- b[[i]] - medians[[i]]
}

# [[<- operator : R에서 리스트나 벡터의 특정 요소를 수정할 때 사용되는 함수
# X <- 1:2
# "[<-"(X, 2, 100)
# => X[2] <- 100과 같은 동작


