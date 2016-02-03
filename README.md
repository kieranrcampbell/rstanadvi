# rstanadvi
Small R wrapper for variational inference in Stan

## Installation

```R
# install.packages("devtools")
devtools::install_github("kieranrcampbell/rstanadvi")
```

## Usage

Install [cmdStan](http://mc-stan.org/interfaces/cmdstan.html) to a directory (e.g. `../cmdstan-2.9.0'). 

As an example, say we're fitting a normal distribution to some data. We create a stan file in the current directory called `gauss.stan`. We would then fit variational inference as follows:

```R
x <- rnorm(100)
data <- list(N = length(x), x = x)
fit <- rstanadvi("gauss", data = data, path_to_cmdstan = "../cmdstan-2.9.0")
```

## Contact
`kieran` (dot) `campbell` (at) `well` (dot) `ox` (dot) `ac` (dot) `uk`



