
#' Dump a list of values to file
#' 
#' This function dumps a named list of data to a file in the format
#' required by cmdStan, but accepting the data as a list (as in 
#' \code{stan}) rather than
#' variable names in the local environment (as in \code{stan_rdump}).
#' 
#' @param l A named list containing data
#' @param file The output file
#' 
#' @export
stan_rdump_list <- function(l, file) {
  e <- new.env()
  for(n in names(l)) e[[n]] <- l[[n]]
  stan_rdump(names(l), file = file, envir = e)
}

#' ADVI variational inference from within R
#' 
#' ADVI currently only implemented in cmdStan. This function provides a small
#' wrapper round cmdStan enabling models to be built from within stan. This
#' functionality should be eventually incorporated into \code{rstan} itself.
#' 
#' @param path_to_stanmodel The path (relative or absolute) to the stan model file
#' @param stan_model_name The name of the stan model (i.e. the stan model file name
#' without ".stan"). If ".stan" is found in the model name it is removed.
#' @param data A named list of data, identical to what would be passed to \code{stan}.
#' @param init A named list of initial values for parameters. Note that since variational inference
#' doesn't have chains, this is slightly different from \code{stan} and should just be a list of
#' length number of parameters.
#' @param path_to_cmdstan Relative or absolute path to installation of cmdstan.
#' @param data_file_name Name of intermediate file to which data is dumped (optional).
#' @param init_file_name Name of intermediate file to which initial values are dumped (optional).
#' @param output_file_name Name of output file (optional).
#' 
#' @import rstan
#' @importFrom readr read_csv
#' 
#' @export
#' @return A \code{data.frame} containing one column for each parameter and a row for each
#' of the posterior samples (default 1000).
stan_variational <- function(stan_model_name, data, path_to_stanmodel = ".", init = NULL,
                             path_to_cmdstan = "../cmdstan-2.9.0",
                             data_file_name = "data.R", init_file_name = "init.R",
                             output_file_name = paste0(stan_model_name, ".txt")) {
  # dump data to file
  stan_rdump_list(data, data_file_name)
  if(!is.null(init)) stan_rdump_list(init, init_file_name)
  
  stan_model_name <- gsub(".stan", "", stan_model_name, fixed = TRUE)
  
  # construct commands
  make_cmd <- paste0("cd ", path_to_cmdstan, "; make ", file.path(path_to_stanmodel, stan_model_name))
  run_cmd <- paste0("./", stan_model_name, " variational data file=", data_file_name)
  if(!is.null(init)) run_cmd <- paste0(run_cmd, " init=", init_file_name)
  run_cmd <- paste0(run_cmd, " output file=", output_file_name)
  
  # run commands
  system(make_cmd)
  system(run_cmd)
  
  return( read_csv(output_file_name, comment="#") )
}

