## Warfarin example from software comparison in:
## Nyberg et al., "Methods and software tools for design evaluation 
##   for population pharmacokinetics-pharmacodynamics studies", 
##   Br. J. Clin. Pharm., 2014. 

library(PopED)

ff <- function(model_switch,xt,parameters,poped.db){
  ##-- Model: One comp first order absorption
  with(as.list(parameters),{
    y=xt
    y=(DOSE*Favail*KA/(V*(KA-CL/V)))*(exp(-CL/V*xt)-exp(-KA*xt))
    return(list(y=y,poped.db=poped.db))
  })
}

sfg <- function(x,a,bpop,b,bocc){
  ## -- parameter definition function 
  parameters=c(CL=bpop[1]*exp(b[1]),
               V=bpop[2]*exp(b[2]),
               KA=bpop[3]*exp(b[3]),
               Favail=bpop[4],
               DOSE=a[1])
  return(parameters) 
}

feps <- function(model_switch,xt,parameters,epsi,poped.db){
  ## -- Residual Error function
  ## -- Proportional 
  returnArgs <- ff(model_switch,xt,parameters,poped.db) 
  y <- returnArgs[[1]]
  poped.db <- returnArgs[[2]]
  y = y*(1+epsi[,1])
  
  return(list(y=y,poped.db=poped.db)) 
}


## -- Define initial design  and design space
poped.db <- create.poped.database(ff_file="ff",
                                  fg_file="sfg",
                                  fError_file="feps",
                                  bpop=c(CL=0.15, V=8, KA=1.0, Favail=1), 
                                  notfixed_bpop=c(1,1,1,0),
                                  d=c(CL=0.07, V=0.02, KA=0.6), 
                                  sigma=0.01,
                                  groupsize=32,
                                  xt=c( 0.5,1,2,6,24,36,72,120),
                                  minxt=0,
                                  maxxt=120,
                                  a=70)

##  create plot of model without variability 
plot_model_prediction(poped.db)

##  create plot of model with variability 
plot_model_prediction(poped.db,IPRED=T,DV=T)

## get predictions from model
model_prediction(poped.db)

## evaluate initial design
evaluate_design(poped.db)

## Evaluate with full FIM
evaluate_design(poped.db, fim.calc.type=0)

# Examine efficiency of sampling windows
plot_efficiency_of_windows(poped.db,xt_windows=0.5)

