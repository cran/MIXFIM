\name{fisher_evaluation}
\alias{fisher_evaluation}
\title{Evaluation of the Fisher Information Matrix in Nonlinear Mixed Effect Models using Markov Chains Monte Carlo}
\description{
\code{fisher_evaluation} is used to evaluate the Fisher information matrix for both continuous and discrete data in nonlinear mixed effect models using Markov Chains Monte Carlo.
}
\usage{
fisher_evaluation(t, y_ini=1, model, model2, model3, params, dim_b, 
set_seed=TRUE, seed=42, n_samp, n_rep=1, n_iter, n_burn, CV=FALSE, 
plot_graph=0, L_boot=1000, nb_patients=1)
}

\arguments{                
  \item{t}{Vector of sampling times (or doses).}
  \item{y_ini}{A possible value for the response y to initialize the MCMC process. The default value is set at 1 (which works for many types of outcomes: continuous, binary, ...).}
  \item{model}{Compiled STAN model describing the response model to sample in the conditionnal distribution of b given y.}
  \item{model2}{Compiled STAN model describing the response model for calculating the derivative of the log-likelihood with respoect to each parameter.}
  \item{model3}{Compiled STAN model describing the response model to sample in the marginal distribution of the response y.}
  \item{params}{Vector of parameters given as follows: fixed effetcs, variances of the random effets, standard deviations of the residual errors (if continuous data). }
  \item{dim_b}{Number of random effects.}
  \item{set_seed}{Boolean indicating if the seed shoud be fixed. The default value is set at TRUE.}
  \item{seed}{Integer for the fixed seed. Used only if \code{set_seed} is TRUE. The default value is set at 42.}
  \item{n_samp}{Integer representing the number of Monte Carlo (MC) samples, (i.e. number of samples for the outcome y).}
  \item{n_rep}{Integer representing the number of repeated measures at the same time (or dose) for each patient. The default value is set at 1 (for continuous data).}
  \item{n_iter}{Integer representing the number of Markov Chains Monte Carlo (MCMC) samples.}
  \item{n_burn}{Integer representing the number of burn-in samples for MCMC. }
  \item{CV}{Boolean indicating if some convergence information (variance of the determinant, mean of b, mean log-likelihood, ...) should be returned. The default value is set at FALSE.} 
  \item{plot_graph}{An integer with value 0 (no graph should be plotted), 1 (graph of the determinant of the FIM), 2 (graph of the determinant of the FIM with confidence intervals assuming normal distribution), 3 (graph of the determinant of the FIM with bootstrap confidence intervals) or 4 (graph of the determinant of the FIM with both bootstrap confidence intervals and confidence intervals assuming normal distribution). The default value is set at 0.}
  \item{L_boot}{Number of samples for bootstrap estimation of the confidence intervals of the normalized determinant of the FIM. This argument is used/required only if plot_graph = 3 or 4. The default value is set at 1000.}
  \item{nb_patients}{Number of patients with the same elementary design for which the FIM is evaluated. The default value is set at 1.}
}

\value{
An list is returned, composed of the following variables: 
\item{FIM}{Expected Fisher information matrix (FIM). Of note, the FIM is an individual FIM and is calculated for \code{nb_patients} patients.}
\item{FIM_covar}{Variance-covariance matrix of the FIM. (Of note, its dimension is of size 4 as the FIM is in dimension 2.)}
\item{inv_FIM}{Inverse of the FIM.}
\item{RSE}{Relative standard errors (square root of the diagonal elements of the inverse of the FIM).}
\item{RSE_inf_boot}{Vector containing the lower bound of the bootstrap confidence interval of the RSEs.}
\item{RSE_sup_boot}{Vector containing the upper bound of the bootstrap confidence interval of the RSEs.}
\item{det_norm_FIM}{Normalized determinant of the FIM.}
\item{det_IC_normal}{Vector containing the lower and upper bound of the confidence interval of the normalized determinant of the FIM assuming normal distribution.}
\item{det_IC_boot}{Vector containing the lower and upper bound of the bootstrap confidence interval of the normalized determinant of the FIM.}
If CV=TRUE: 
\item{mean_dloglik1}{Mean of the partial derivatives of the log-likelihood according to the first MCMC sample and MC sample. Should be equal approximately to 0.} 
\item{mean_dloglik2}{Mean of the partial derivatives of the log-likelihood according to the second MCMC sample and MC sample. Should be equal approximately to 0.}
\item{var_dloglik1}{Variance of the partial derivatives of the log-likelihood according to the first MCMC sample and MC sample.} 
\item{var_dloglik2}{Variance of the partial derivatives of the log-likelihood according to the second MCMC sample and MC sample.}
\item{mean_b}{Mean of the samples in the conditionnal distribution of b given y. Should be equal approximately to 0.} 
\item{mat_A_k1}{Vector containing for each value sampled of the response y, the estimation of the integral of the partial derivatives of the log-likelihood over the random effects according to the first MCMC sample of the random effects b given y.}
\item{mat_A_k2}{Vector containing for each value sampled of the response y, the estimation of the integral of the partial derivatives of the log-likelihood over the random effects according to the second MCMC sample of the random effects b given y.}

In addition, \code{plot_graph} enables to plot a graph of the normalized determinant of the FIM with normal and bootstrap confidence intervals in function of the number of MC samples.
}

\references{
Riviere, M-K., Ueckert, S. and Mentre, F,. Evaluation of the Fisher information matrix in nonlinear mixed effect models using Markov Chains Monte Carlo.
}
\author{Marie-Karelle Riviere-Jourdan \email{eldamjh@gmail.com}}

\examples{
times = c(0.5,1,2,6,24,36,72,120)
params = c(1,8,0.15,0.6,0.02,0.07,0.1) 
 
# UNCOMMENT EXAMPLE
#model = stan_model("model_b_given_y.stan")
#model2 = stan_model("model_derivatives.stan")
#model3 = stan_model("model_y.stan")

#model_Warfarin = fisher_evaluation(t=times, y_ini=0.5, model=model, 
#model2=model2, model3=model3, params=params, dim_b=3, set_seed=TRUE, seed=42, 
#n_samp=1000, n_rep=1, n_iter=200, n_burn=500, CV=TRUE, plot_graph=4, 
#nb_patients=32)
#model_Warfarin
}
