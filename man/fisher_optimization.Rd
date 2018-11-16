\name{fisher_optimization}
\alias{fisher_optimization}
\title{Optimization of the sampling times (or doses) in Nonlinear Mixed Effect Models using Markov Chains Monte Carlo}
\description{
\code{fisher_optimization} is used to optimize the sampling times (or doses), through maximization of the determinant of the Fisher Information Matrix, for both continuous and discrete data in nonlinear mixed effect models using Markov Chains Monte Carlo.
}
\usage{
fisher_optimization(nb_t, set_t, y_ini, model, model2, model3, params, dim_b, 
set_seed=TRUE, seed=42, step_mc, n_samp_min=30, n_samp_max, n_rep=1, n_iter, 
n_burn, L_boot=1000, plot_graph=TRUE, nb_patients=1, det_graph=FALSE)
}

\arguments{                
  \item{nb_t}{Number of sampling times (or doses) to select.}
  \item{set_t}{A vector containing the set of possible sampling times in which to select the \code{nb_t} optimal ones.}
  \item{y_ini}{A possible value for the response y to initialize the MCMC process.}
  \item{model}{Compiled STAN model describing the response model to sample in the conditionnal distribution of b given y.}
  \item{model2}{Compiled STAN model describing the response model for calculating the derivative of the log-likelihood with respoect to each parameter.}
  \item{model3}{Compiled STAN model describing the response model to sample in the marginal distribution of the response y.}
  \item{params}{Vector of parameters given as follows: fixed effetcs, variances of the random effets, standard deviations of the residual errors (if continuous data). }
  \item{dim_b}{Number of random effects.}
  \item{set_seed}{Boolean indicating if the seed shoud be fixed. The default value is set at TRUE.}
  \item{seed}{Integer for the fixed seed. Used only if \code{set_seed} is TRUE. The default value is set at 42.}
  \item{step_mc}{Number of Monte Carlo (MC) samples after which the remaining combinations of sampling times are re-evaluated for optimum determination.}
  \item{n_samp_min}{Integer representing the minimum number of MC samples to perform at the first step to evaluate all combinations of sampling times (or doses).} 
  \item{n_samp_max}{Integer representing the maximum number of MC samples to perform (for one combination of sampling times). Either the algorithm will stop for finding a unique combination of optimal sampling times before reaching \code{n_samp_max} or for reaching it. In the second case, the sampling times corresponding to the highest determinant of the FIM will be selected as the optimum.}
  \item{n_rep}{Integer representing the number of repeated measures at the same time (or dose) for each patient. The default value is set at 1 (for continuous data).}
  \item{n_iter}{Integer representing the number of Markov Chains Monte Carlo (MCMC) samples.}
  \item{n_burn}{Integer representing the number of burn-in samples for MCMC.}
  \item{L_boot}{Number of samples for bootstrap estimation of the confidence intervals of the determinant of the FIM. The default value is set at 1000.} 
  \item{plot_graph}{A boolean indicating if at each step (every \code{step_mc}), a graph with the determinant of the FIM and its bootstrap confidence intervals for the remaining combinations of sampling times should be plotted and saved. The default value is set at TRUE.}
  \item{nb_patients}{Number of patients with the same elementary design for which the FIM and its determinant are evaluated. The default value is set at 1.}
  \item{det_graph}{A boolean indicating if the normalized determinant of the FIM for the selected optimal design should be plotted in function of the number of MC samples. The default value is set at FALSE.}
}

\details{
The algorithm will first test all combinations of \code{nb_t} sampling times (or doses) in \code{ens_t} on at least \code{n_samp_min} MC samples. Then and after each step (every \code{step_mc}), only combinations of sampling times for which the upper bound of the bootstrap confidence interval is above the maximum estimated determinant of the FIM will be selected for the next step. The algorithm will stop either for finding a unique combination of optimal sampling times before reaching \code{n_samp_max} or for reaching it. In the second case, the combination of sampling times corresponding to the highest determinant of the FIM will be selected as the optimum. However, in this case the graph (\code{plot_graph}=TRUE) could help to distinguish the remaining combinations of sampling times.
}

\value{
An list is returned, composed of the following variables: 
\item{opt_t}{Optimal protocol, i.e. sampling times (or doses).}
\item{FIM_opt_t}{Expected Fisher information matrix (FIM) for the optimal protocol. Of note, the FIM is an individual FIM and is calculated for \code{nb_patients} patients.} 
\item{FIM_covar_opt_t}{Variance-covariance matrix of the FIM for the optimal protocol. (Of note, its dimension is of size 4 as the FIM is in dimension 2.)}
\item{inv_FIM_opt_t}{Inverse of the FIM for the optimal protocol.}
\item{RSE_opt_t}{Relative standard errors for the optimal protocol (square root of the diagonal elements of the inverse of the FIM).} 
\item{RSE_inf_boot_opt_t}{Vector containing the lower bound of the bootstrap confidence interval of the RSEs for the optimal protocol.} 
\item{RSE_sup_boot_opt_t}{Vector containing the upper bound of the bootstrap confidence interval of the RSEs for the optimal protocol.}
\item{det_norm_FIM_opt_t}{Normalized determinant of the FIM for the optimal protocol.} 
\item{IC_normal_opt_t}{Vector containing the lower and upper bound of the confidence interval of the normalized determinant of the FIM assuming normal distribution for the optimal protocol.}
\item{IC_boot_opt_t}{Vector containing the lower and upper bound of the bootstrap confidence interval of the normalized determinant of the FIM for the optimal protocol.}
\item{list_select}{A list containing at each step the combinations of sampling times selected.}
\item{list_det}{A list containing at each step the determinant of the FIM for each combination of sampling times selected.}
\item{list_boot_inf}{A list containing at each step the lower bound of the bootstrap confidence interval of determinant of the FIM for each combination of sampling times selected.}
\item{list_boot_sup}{A list containing at each step the upper bound of the bootstrap confidence interval of determinant of the FIM for each combination of sampling times selected.} 
\item{list_fim}{A list containing at each step the FIM for each combination of sampling times selected.}

In addition, for the optimal protocol selected at the end, a graph of the normalized determinant of the FIM with normal and bootstrap confidence intervals in function of the number of MC samples is plotted.
}

\author{Marie-Karelle Riviere-Jourdan \email{eldamjh@gmail.com}}

\examples{

############################
# PLEASE UNCOMMENT EXAMPLE #
############################
#params = c(1,8,0.15,0.6,0.02,0.07,0.1)
#times_poss = c(0.1,0.5,1,2,3,6,12,24,36,48,72,120,240)

# Files can be found in external data
#model = stan_model("model_b_given_y.stan")
#model2 = stan_model("model_derivatives.stan")
#model3 = stan_model("model_y.stan")

#opt1 = fisher_optimization(nb_t=3, set_t=times_poss, y_ini=0.5, model=model, 
#model2=model2, model3=model3, params=params, dim_b=3, set_seed=TRUE, seed=42, 
#step_mc=100, n_samp_min=30, n_samp_max=2000, n_rep=1, n_iter=500, n_burn=500,
#nb_patients=32)
#opt1
}
