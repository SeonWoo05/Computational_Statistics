# ex 1.2.1

# (1)
p <- 0.7
N_each <- 100
Ntries <- rep(10^c(3:6), each = 2)*rep(c(0.5, 1), 4)
works_mixed <- matrix(0, nrow = N_each, ncol = length(Ntries))
for(i in seq_along(Ntries)){
  cat(i, "\n")
  for(j in 1:N_each){
    comp1 <- rbinom(Ntries[i], 1, p)
    tmp <- matrix(rbinom(2 * Ntries[i], 1, p), ncol = 2)
    parallel_part <- apply(tmp, 1, max)
    w <- sum(comp1 * parallel_part == 1)
    works_mixed[j, i] <- w / Ntries[i]
  }
}
colnames(works_mixed) <- Ntries
boxplot(works_mixed)
abline(h = p * (1 - (1 - p)^2), col = "red")
text(x = 1, y = p * (1 - (1 - p)^2), labels = round(p * (1 - (1 - p)^2), 3), col = "red", pos = 2)


#(2)
p <- 0.7
N_each <- 100
Ntries <- rep(10^c(3:6), each = 2) * rep(c(0.5, 1), 4)
calc_reliability <- function(p, n_trials) {
  comp3_on <- matrix(0, nrow = N_each, ncol = length(n_trials))
  for (i in seq_along(n_trials)) {
    for (j in 1:N_each) {
      tmp_12 <- matrix(rbinom(2 * n_trials[i], 1, p), ncol = 2)
      parallel_12 <- apply(tmp_12, 1, max)
      tmp_45 <- matrix(rbinom(2 * n_trials[i], 1, p), ncol = 2)
      parallel_45 <- apply(tmp_45, 1, max)
      success <- parallel_12 & parallel_45
      comp3_on[j, i] <- sum(success) / n_trials[i]
    }
  }
  
  comp3_off <- matrix(0, nrow = N_each, ncol = length(n_trials))
  for (i in seq_along(n_trials)) {
    for (j in 1:N_each) {
      tmp_14 <- matrix(rbinom(2 * n_trials[i], 1, p), ncol = 2)
      series_14 <- apply(tmp_14, 1, min)
      tmp_25 <- matrix(rbinom(2 * n_trials[i], 1, p), ncol = 2)
      series_25 <- apply(tmp_25, 1, min)
      success <- series_14 | series_25
      comp3_off[j, i] <- sum(success) / n_trials[i]
    }
  }
  
  reliability <- p * comp3_on + (1 - p) * comp3_off
  return(reliability)
}
reliability <- calc_reliability(p = p, n_trials = Ntries)
colnames(reliability) <- Ntries
boxplot(reliability)
theoretical_reliability <- ((1 - (1 - p)^2) * (1 - (1 - p)^2) * p) + 
  ((1 - (1 - p^2)^2) * (1 - p))
abline(h = theoretical_reliability, col = "red")
text(x = 1, y = theoretical_reliability, labels = round(theoretical_reliability, 3), col = "red", pos = 2)
