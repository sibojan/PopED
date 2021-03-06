PopED: Population (and individual) Experimental Design in R
======

[![Travis-CI Build Status](https://travis-ci.org/andrewhooker/PopED.svg?branch=master)](https://travis-ci.org/andrewhooker/PopED)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/PopED)](https://CRAN.R-project.org/package=PopED)
[![codecov.io](https://codecov.io/github/andrewhooker/PopED/coverage.svg?branch=master)](https://codecov.io/github/andrewhooker/PopED?branch=master)

PopED computes optimal experimental designs for both population 
and individual studies based on nonlinear mixed-effect models. 
Often this is based on a computation of the Fisher Information Matrix (FIM). 

## Installation

You need to have R installed.  Download the latest version of R from www.r-project.org.
Install PopED in R using one of the following methods:

* latest stable release -- From CRAN.  Write at the R command line:

```
install.packages("PopED")
```

* Latest development version -- from Github. Note that the command below installs the "master" 
(development) branch; if you want the release branch from Github add `ref="release"` to the
`install_github()` call. The `install_github()` approach requires that you build from source, 
i.e. `make` and compilers must be installed on your system -- see the R FAQ for your operating system; 
you may also need to install dependencies manually.

```
devtools::install_github("andrewhooker/PopED")
```

## Getting started

To get started you need to define 

1. A model.
2. An initial design (and design space if you want to optimize). 
3. The tasks to perform. 

Learn more in this [introduction to PopED](https://andrewhooker.github.io/PopED/articles/intro-poped.html)


## Contact

You are welcome to:

* submit suggestions and bug-reports at: https://github.com/andrewhooker/PopED/issues 
* send a pull request on: https://github.com/andrewhooker/PopED
* compose a friendly e-mail to: andrew.hooker@farmbio.uu.se 




