\name{LinMatrixH}
\alias{LinMatrixH}
\title{Model linearization with respect to epsilon.}
\usage{
LinMatrixH(model_switch, xt_ind, x, a, bpop, b_ind, bocc_ind, poped.db)
}
\arguments{
  \item{xt_ind}{A vector of the individual/group sample
  times}

  \item{b_ind}{vector of individual realization of the BSV
  terms b}

  \item{bocc_ind}{Vector of individual realizations of the
  BOV terms bocc}

  \item{model_switch}{A matrix that is the same size as xt,
  specifying which model each sample belongs to.}

  \item{x}{A matrix for the discrete design variables.
  Each row is a group.}

  \item{a}{A matrix of covariates.  Each row is a group.}

  \item{bpop}{The fixed effects parameter values.  Supplied
  as a vector.}

  \item{poped.db}{A PopED database.}
}
\value{
A matrix of size (samples per individual x number of
epsilons)
}
\description{
The function performs a linearization of the model with
respect to the residual variability. Derivative of model
w.r.t. eps evaluated at eps=0
}
\examples{
## Warfarin example from software comparison in:
## Nyberg et al., "Methods and software tools for design evaluation 
##   for population pharmacokinetics-pharmacodynamics studies", 
##   Br. J. Clin. Pharm., 2014. 

## Optimization using an additive + proportional reidual error to 
##   avoid sample times at very low concentrations (time 0 or very late samoples).
library(PopED)

## find the parameters that are needed to define from the structural model
ff.PK.1.comp.oral.sd.CL

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
                                  fError_file="feps.add.prop",
                                  bpop=c(CL=0.15, V=8, KA=1.0, Favail=1), 
                                  notfixed_bpop=c(1,1,1,0),
                                  d=c(CL=0.07, V=0.02, KA=0.6), 
                                  sigma=c(0.01,0.25),
                                  groupsize=32,
                                  xt=c( 0.5,1,2,6,24,36,72,120),
                                  minxt=0,
                                  maxxt=120,
                                  a=70,
                                  mina=0,
                                  maxa=100)
# warfarin optimization model

#for the FO approximation
ind=1
LinMatrixH(model_switch=t(poped.db$global_model_switch[ind,,drop=FALSE]),
          xt_ind=t(poped.db$gxt[ind,,drop=FALSE]),
          x=zeros(0,1),
          a=t(poped.db$ga[ind,,drop=FALSE]),
          bpop=poped.db$gbpop[,2,drop=FALSE],
          b_ind=zeros(poped.db$NumRanEff,1),
          bocc_ind=zeros(poped.db$NumDocc,1),
          poped.db)["y"]


}
\seealso{
Other FIM: \code{\link{LinMatrixLH}};
\code{\link{LinMatrixL_occ}}; \code{\link{ed_mftot}};
\code{\link{evaluate.e.ofv.fim}};
\code{\link{evaluate.fim}}; \code{\link{gradf_eps}};
\code{\link{mf3}}; \code{\link{mf5}}; \code{\link{mf6}};
\code{\link{mf7}}; \code{\link{mf8}}; \code{\link{mftot0}};
\code{\link{mftot1}}; \code{\link{mftot2}};
\code{\link{mftot3}}; \code{\link{mftot4}};
\code{\link{mftot5}}; \code{\link{mftot6}};
\code{\link{mftot7}}; \code{\link{mftot}};
\code{\link{mf}}; \code{\link{ofv_criterion}};
\code{\link{ofv_fim}}
}
