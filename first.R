library(tidyverse)
library(R.matlab)

raw <- readMat('./datasets/jaffe.mat')

df <- raw$X %>% as_tibble()
