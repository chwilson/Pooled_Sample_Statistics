


conant_soc <- c(0.11, 0.3, 0.35, 0.35, 1.01, 0.75, 2.35, 3.04, 0.54)
conant_n <- c(2,42,45,42,23,6,2,5,167)

mean(conant_soc)
sd(conant_soc)
# naive is around N(1,1)

# weighted mean
conant_soc2 <- conant_soc*(conant_n/sum(conant_n))
sum(conant_soc2) # weighted mean is 0.54 

# E[SOC^2]
conant_soc2sq <- (conant_soc^2)*(conant_n/sum(conant_n))

# Var(SOCw)
sum(conant_soc2sq) - (0.54^2)

# SD sqrt(sum(conant_soc2sq) - (0.54^2)) # 0.38 

# So, in short, with weighted approach we would have mean = 0.54, and SD  = 0.38 
# to accomodate the skew, I would fit a Gamma 




var(conant_soc)
mean(conant_soc^2) - mean(conant_soc)^2


conant_df <- data.frame(soc = conant_soc, socw = conant_soc2)
library(dplyr); library(ggplot2)

ggplot(data = data.frame(x=c(0,5)),aes(x=x)) +
  stat_function(fun = dgamma, args = list(shape = (0.54^2)/0.38^2, rate = 0.54/0.38^2)) +
  theme_bw(base_size=20) + 
  xlab("SOC sequestration MgC/ha*yr") +
  ylab("") +
  ggtitle("Default shrinkage prior for SOC sequestration studies")

