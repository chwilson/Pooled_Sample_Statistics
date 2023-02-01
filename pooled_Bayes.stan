data {
  int<lower=0> N; // number of samples per composite
  int<lower=0> K; // number of composited samples
  int<lower=0> P; // total samples
  vector[P] y_obs; // measured values from composite samples 
  int<lower=0,upper=2> samp[P]; // for each measured value, IDs the composited sample
}


parameters {
  real mu[K];
  real u[K];
  real<lower=0> cv_space;
  real<lower=0> cv_obs; 
}


model {
  
  // parameter model for the CVs 
  cv_obs ~ gamma(0.05,2);
  cv_space ~ gamma(0.5,1.5);
  
  // parameter model for the true means 
  
  // observation models
  
  // true mean in each composited sample 
 for(i in 1:K)  
  mu[i] ~ normal(u[i]+2,0.01*(u[i]+2)*cv_space/sqrt(N)); 

//print(u);
//print(cv_space);
//print(sqrt(N));
 // individual measurements for each composited sample 
  for(i in 1:P)
  y_obs[i] ~ normal((mu[samp[i]]+2), 0.01*cv_obs*(mu[samp[i]]+2));
}

generated quantities{
  real mean_infer = u[1] - u[2]; 
}