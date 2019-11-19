library(tidyverse)
library(R.matlab)

raw <- readMat('./datasets/jaffe.mat')

raw_X <- raw$X

scaled_X <- raw_X %>% scale() %>% as_tibble()
#Visualization using TSNE 
###### 

library(Rtsne)

res.tsne <- Rtsne(scaled_X)$Y %>% 
  as_tibble()
res.tsne$y <- raw$y %>% as.vector() %>% as.factor()
  
ggplot(res.tsne) + geom_point(aes(V1, V2, color=y))
  

###### 2.Obtenir à l’aide de EM la meilleure partition, voir le package mclust.
library(mclust)
res.mc <- Mclust(scaled_X)
plot(res.mc, what = 'BIC')
# multinomiale ==> only six model (from documentation)
# execution eliminate 2 VVI, EVI at G=5 ==> only four models at 10
# EII       VII       EEI       VEI
res.mc <- Mclust(scaled_X, G=10)
plot(res.mc, what = 'BIC')
BIC <- mclustBIC(scaled_X, G=10)
summary(BIC)

#Best BIC values:
#            VEI,10     EEI,10     VII,10
#BIC      -237664.1 -252959.20 -259330.23
#BIC diff       0.0  -15295.11  -21666.15




