### if/else if 1
a <- 3
if(a%%2 == 0) { # 논리식으로 T,F
  print("짝수")
} else {
  print("홀수")
}
a%%2

if(a%%2) { #  0 : False / 이외 True
  print("홀수")
} else {
  print("짝수")
}


### if/else if 2
a <- 3
if(a%%2 == 0) {
  print("짝수")
} 
else {        # 에러 -> 실행종료
  print("홀수")
}

### if/else 3
x <- 7
y <- 5
if(x + y) {
  print("True")
}

if(x+y-12){
  print("FALSE")
}

if(-3) {
  print("True")
}

### if/else 4
x <- 7
y <- 5
if(x > y) print("x is greater")

### if/else 5
x <- 7
y <- 5
z <- 2
if(x > y) {
  print("x is greater than y")
  if(x > z) print("x is greater than y and z")
}

### if/else 6
if(x > y) {
  print("x is greater")
} else {
  print("y is greater")
}


### if/else 7
x <- 5
y <- 5
if(x > y) {
  print("x is greater")
} else if(x < y) {
  print("y is greater")
} else {
  print("x and y are equal")
}


### ifelse 1
?ifelse
a <- 3
ifelse(a%%2==0, "짝수", "홀수")

a = c(5,7,2,9)
ifelse(a %% 2 == 0,"even","odd") # 벡터의 각 원소에 대해 하나씩 처리


### ifelse 2
x <- c(6:-4)
x
sqrt(x)  #- gives warning
sqrt(ifelse(x >= 0, x, NA))  # no warning

# vector 연산의 가능 유무
if(x >= 0) print(x) else print(NA) # error
ifelse(x > 0, x, NA) # 가능

# Na : 결측값 / NaN : not a number
y <- c(1,2,NA)
sum(y)
sum(y ,na.rm=T)
# lm(y~x, na.action="") : 결측치 처리


### for loop 1
for(i in 1:5){
  print(i^2)
}

i <- 1
while(i <= 5){
  print(i^2)
  i <- i+1
}

i <- 1
while(i <= 5){
  i <- i+1
  print(i^2)
}


### for loop 2
x <- seq(1, 10, by = 2)
x
for (val in x) {
  if (val == 7){
    break
  }
  print(val)
}
val


### for loop 3
x <- seq(1, 10, by = 2)
x
for (val in x) {
  if (val == 7){
    next
  }
  print(val)
}
val


### for loop 4
for(i in 1:1000){
  if(!(i%%100)) cat("iteration: ", i, '\n')
} # 100의 배수일 때만 출력력




