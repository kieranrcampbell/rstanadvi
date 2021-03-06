% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rstanadvi.R
\name{rstanadvi}
\alias{rstanadvi}
\title{ADVI variational inference from within R}
\usage{
rstanadvi(stan_model_name, data, path_to_stanmodel = ".", init = NULL,
  path_to_cmdstan = "../cmdstan-2.9.0", data_file_name = "data.R",
  init_file_name = "init.R", output_file_name = paste0(stan_model_name,
  ".txt"))
}
\arguments{
\item{stan_model_name}{The name of the stan model (i.e. the stan model file name
without ".stan"). If ".stan" is found in the model name it is removed.}

\item{data}{A named list of data, identical to what would be passed to \code{stan}.}

\item{path_to_stanmodel}{The path (relative or absolute) to the stan model file}

\item{init}{A named list of initial values for parameters. Note that since variational inference
doesn't have chains, this is slightly different from \code{stan} and should just be a list of
length number of parameters.}

\item{path_to_cmdstan}{Relative or absolute path to installation of cmdstan.}

\item{data_file_name}{Name of intermediate file to which data is dumped (optional).}

\item{init_file_name}{Name of intermediate file to which initial values are dumped (optional).}

\item{output_file_name}{Name of output file (optional).}
}
\value{
A \code{data.frame} containing one column for each parameter and a row for each
of the posterior samples (default 1000).
}
\description{
ADVI currently only implemented in cmdStan. This function provides a small
wrapper round cmdStan enabling models to be built from within stan. This
functionality should be eventually incorporated into \code{rstan} itself.
}

