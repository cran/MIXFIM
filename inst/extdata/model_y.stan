data {
  int dim_b;
  vector[dim_b] mu_b;
  int nb_t;
  vector[nb_t] t;
  vector[7] params;
}
transformed data { 
  vector[dim_b] Omega;
  for(i in 1:dim_b){
    Omega[i] = sqrt(params[4+i-1]);
  }
}
model{
}
generated quantities {
  vector[dim_b] b;
  vector[nb_t] SdEps;
  vector[dim_b] param_rand;
  vector[nb_t] f;
  vector[nb_t] y;
  for(i in 1:dim_b){
    b[i] <- normal_rng(mu_b[i], Omega[i]);
  }
  param_rand = segment(params, 1, dim_b) .* exp(b);
  for(ti in 1:nb_t){
    f[ti] <- 70/param_rand[2] * param_rand[1] / (param_rand[1] - param_rand[3]/param_rand[2]) * ( exp(-param_rand[3]/param_rand[2]*t[ti]) - exp(-param_rand[1]*t[ti]) );
    SdEps[ti] = params[7] * f[ti];
    y[ti] = normal_rng(f[ti], SdEps[ti]);
  }
}

