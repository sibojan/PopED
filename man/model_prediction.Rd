\name{model_prediction}
\alias{model_prediction}
\title{Model predictions}
\usage{
model_prediction(poped.db, models_to_use = "all", model_num_points = NULL,
  model_minxt = NULL, model_maxxt = NULL, include_sample_times = T,
  groups_to_use = "all", IPRED = FALSE, DV = FALSE, num_ids = 100)
}
\arguments{
  \item{models_to_use}{Which model number should we use?}

  \item{model_num_points}{How many points should be
  plotted.  If not a number then the design in poped.db is
  used.}

  \item{model_minxt}{The minimum of the sample times for
  the predictions.}

  \item{model_maxxt}{The maximum of the sample times for
  the predictions.}

  \item{include_sample_times}{Should the sample times from
  poped.db be included in the predictions?}

  \item{IPRED}{Should we simulate individual predictions?}

  \item{DV}{should we simulate observations?}

  \item{num_ids}{The number of individuals to simulate if
  using IPRED or DV.}

  \item{groups_to_use}{Which groups should we use for
  predictions from the poped.db.}

  \item{poped.db}{A PopED database.}
}
\value{
A dataframe of simulated data, either with some dense grid
of samples or based on the design in the poped database.
}
\description{
Function generates model predictions for the typical value
in the population, individual predictions and data
predictions.
}
\examples{
## Warfarin example from software comparison in:
## Nyberg et al., "Methods and software tools for design evaluation 
##   for population pharmacokinetics-pharmacodynamics studies", 
##   Br. J. Clin. Pharm., 2014. 

library(PopED)

## find the parameters that are needed to define from the structural model
ff.PK.1.comp.oral.md.CL

## -- parameter definition function 
## -- names match parameters in function ff
sfg <- function(x,a,bpop,b,bocc){
  parameters=c(CL=bpop[1]*exp(b[1]),
               V=bpop[2]*exp(b[2]),
               KA=bpop[3]*exp(b[3]),
               Favail=bpop[4],
               DOSE=a[1])
    return(parameters) 
}

## -- Define initial design  and design space
poped.db <- create.poped.database(ff_file="ff.PK.1.comp.oral.sd.CL",
                                  fg_file="sfg",
                                  fError_file="feps.prop",
                                  bpop=c(CL=0.15, V=8, KA=1.0, Favail=1), 
                                  notfixed_bpop=c(1,1,1,0),
                                  d=c(CL=0.07, V=0.02, KA=0.6), 
                                  sigma=0.01,
                                  groupsize=32,
                                  xt=c( 0.5,1,2,6,24,36,72,120),
                                  minxt=0,
                                  maxxt=120,
                                  a=70)

## data frame with model predictions
model_prediction(poped.db)

##  data frame with with variability 
model_prediction(poped.db,IPRED=TRUE,DV=TRUE,num_ids=poped.db$groupsize)


}
\seealso{
Other Simulation: \code{\link{plot_efficiency_of_windows}};
\code{\link{plot_model_prediction}}

Other evaluate_design: \code{\link{evaluate.fim}};
\code{\link{get_rse}};
\code{\link{plot_efficiency_of_windows}};
\code{\link{plot_model_prediction}}
}
