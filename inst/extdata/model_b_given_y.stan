data {
  int dim_b;
  vector[dim_b] mu_b;
  int nb_t;
  vector[nb_t] t;
  vector[nb_t] y;
  vector[7] params;
}
transformed data { 
  vector[dim_b] Omega;
  for(i in 1:dim_b){
    Omega[i] = sqrt(params[4+i-1]);
  }
}
parameters {
  vector[dim_b] b;
}
transformed parameters { 
  vector[nb_t] SdEps;
  vector[dim_b] param_rand;
  vector[nb_t] f;  
  param_rand = segment(params, 1, dim_b) .* exp(b);
  f <- 70/param_rand[2] * param_rand[1] / (param_rand[1] - param_rand[3]/param_rand[2]) * ( exp(-param_rand[3]/param_rand[2]*t) - exp(-param_rand[1]*t) );
  SdEps = params[7] * f;
}
model {
  b ~ normal(mu_b, Omega);
  y ~ normal(f, SdEps);
}

