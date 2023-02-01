data {
  int<lower=0> N; // number of composite samples
  int<lower=0> K; // number of samples per composite
  vector[N] y_obs; // measured values from composite samples 
}


parameters {
  real mu[N];
  real<lower=0> cv_space;
}


model {
  
  // parameter model for the CVs 
   cv_space ~ normal(0.4,0.1);
   for(i in 1:N)
   y_obs[i] ~ normal(mu[i], cv_space*(mu[i])/sqrt(K));
   
}

generated quantities{
  real mean_infer1 = mu[2] - mu[1]; 
  real mean_infer3 = mu[3] - mu[1];
  real avg_effect = 0.5*(mu[2]+mu[3]-2*mu[1]);
}