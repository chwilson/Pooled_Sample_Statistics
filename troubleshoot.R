install.packages("StanHeaders", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
install.packages("rstan", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))

library(dplyr); library(ggplot2); library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)
rstan_options(threads_per_chain = 1)

getwd()
s1 <- stan(file = "pooled_Bayes.stan", data = pooled_bayes_data, chains = 1, iter = 1000)
s1b <- stan(fit=s1, data = pooled_bayes_data, chains = 6, iter = 4000)

print(s1b)
pairs(s1b, pars = c("cv_space","cv_obs","u"))

hist(rgamma(1e5,0.25,0.5))
mean(rgamma(1e5,0.5,1.5))
mean(rgamma(1e5,0.05,2))
sd(rgamma(1e5,0.05,2))


s2 <- stan(file = "pooled_Bayes_ez.stan", data = pooled_bayes_ez, chains = 6, iter = 2000)
print(s2)
