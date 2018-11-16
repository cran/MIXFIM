\name{template_model}
\alias{template_model}
\title{Creation of a Pre-Filled Template for STAN Model.}
\description{
\code{template_model} is used to create a pre-filled template for the STAN models used in \code{fisher_evaluation}.
}
\usage{
template_model(path=getwd(), dloglik, nb_t, outcome, nb_params, ind_RE, 
Cov_list=list(), Sigma_b=FALSE, n_rep=1, name)
}
\arguments{                
  \item{path}{[Optional] String containing the path where the text file with the model should be created.}
  \item{dloglik}{Boolean indicating if the model is used to calculate the partial derivatives of the log-likelihood (TRUE), or if the model is used to sample in the condtional distribution of b given y (FALSE).}
  \item{nb_t}{Number of sampling times (or doses).}
  \item{outcome}{String indicating the type of outcome. For now, "continuous", "binary", "longitudinal_binary", "count" and "time_to_event" are available.}
  \item{nb_params}{Number of parameters.}
  \item{ind_RE}{Indices for the variance of the random effects in the vector of parameters. It is assumed that the vector of parameters is filled as follows: fixed effetcs, variances of the random effets, standard deviations of the residual errors (if \code{outcome} is "continuous").}
  \item{Cov_list}{[Optional] A list of vectors to specify covariances between random effets. Each element of the list must contain a vector with: the row position, the column position and the value of the covariance in the variance-covariance matrix for the random effects.}
  \item{Sigma_b}{Boolean indicating if the residual errors matrix depends on the random effetcs b. The default value is set at FALSE.}
  \item{n_rep}{Integer representing the number of repeated measures at the same time (or dose) for each patient. The default value is set at 1 (for "continuous" outcome).}
  \item{name}{String to name the output text file.}
}

\value{
Create a text file containing a pre-filled template for the STAN models used in \code{fisher_evaluation} in the chosen directory.
}
\references{
Riviere, M-K., Ueckert, S. and Mentre, F,. Evaluation of the Fisher information matrix in nonlinear mixed effect models using Markov Chains Monte Carlo.
}
\author{Marie-Karelle Riviere-Jourdan \email{eldamjh@gmail.com}}
\examples{
# UNCOMMENT EXAMPLES
#test2 = template_model(dloglik=TRUE, nb_t=13, outcome="binary", 
#nb_params=3, ind_RE=c(3), n_rep=1, name="test2")

#test3 = template_model(dloglik=TRUE, nb_t=8, outcome="continuous", 
#nb_params=13, ind_RE=c(5,6,7,8), Cov_list =
#list(c(1,2,0.06),c(2,1,0.06),c(1,3,0.04)), Sigma_fun_b=FALSE, name="test3")

#test4 = template_model( dloglik=FALSE, nb_t=4, outcome="count", 
#nb_params=4, ind_RE=c(3,4), n_rep=30, name="test4")

#test5 = template_model(dloglik=FALSE, nb_t=0, 
#outcome="time_to_event", nb_params=2, ind_RE=c(2), n_rep=10, name="test5")

#test6 = template_model(dloglik=FALSE, nb_t=4, outcome="continuous", 
#nb_params=4, ind_RE=c(3), Sigma_fun_b=FALSE, name="test6")

#test = template_model(dloglik=FALSE, nb_t=7, outcome="continuous", 
#nb_params=7, ind_RE=c(4,5,6), Sigma_fun_b=TRUE, n_rep=1, name="test_pk")
}
