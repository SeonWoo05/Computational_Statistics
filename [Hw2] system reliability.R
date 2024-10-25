# 모의실험을 통한 시스템의 신뢰도 계산

p <- 0.7  # 성공 확률을 0.7로 설정
N_each <- 100  # 각 시뮬레이션에서 100번의 시도
Ntries <- rep(10^c(3:6), each = 2)*rep(c(0.5, 1), 4)  # 다양한 시도 횟수(실험 크기) 설정

## Series system reliability (직렬 시스템 신뢰도)
works_S <- matrix(0, nrow = N_each, ncol = length(Ntries))  # 직렬 시스템 신뢰도를 저장하는 행렬
for(i in seq_along(Ntries)){
  cat(i, "\n")
  for(j in 1:N_each){
    tmp <- matrix(rbinom(2*Ntries[i], 1, p), ncol = 2)  # 성공 확률 p로 각 시도에 대한 이진값 생성
    w <- sum(apply(tmp, 1, min) == 1)  # 직렬 시스템에서는 모든 요소가 성공해야 시스템이 성공
    # 각 시도의 성공 비율을 works_S에 저장
    works_S[j, i] <- w/Ntries[i]
  }
}

colnames(works_S) <- Ntries  # 열 이름 설정 (실험 횟수)
boxplot(works_S)  # 직렬 시스템의 신뢰도 상자 그림 시각화
abline(h = p*p)  # 직렬 시스템에서 이론적으로 기대되는 신뢰도를 시각적으로 보여줌


## Parallel system reliability (병렬 시스템 신뢰도)
works_P <- matrix(0, nrow = N_each, ncol = length(Ntries))  # 병렬 시스템 신뢰도를 저장하는 행렬
for(i in seq_along(Ntries)){
  cat(i, "\n")
  for(j in 1:N_each){
    tmp <- matrix(rbinom(2*Ntries[i], 1, p), ncol = 2)  # 성공 확률 p로 각 시도에 대한 이진값 생성
    w <- sum(apply(tmp, 1, max) == 1)  # 병렬 시스템에서는 하나라도 성공하면 전체 시스템이 성공
    # 각 시도의 성공 비율을 works_P에 저장
    works_P[j, i] <- w/Ntries[i]
  }
}

colnames(works_P) <- Ntries  # 열 이름 설정 (실험 횟수)
boxplot(works_P)  # 병렬 시스템의 신뢰도 상자 그림 시각화
abline(h = 1 - (1-p)^2)  # 병렬 시스템에서 이론적으로 기대되는 신뢰도를 시각적으로 보여줌