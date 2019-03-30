
library(tidyverse)
library(stringr)
eddy=read_csv("eddypro.csv", skip=1, na=c(" ","NA","-9999","-9999.0"), comment=c("["));
eddy=eddy[-1,]
eddy=select(eddy,-(roll))
eddy=eddy %>% mutate_if(is.character, factor)
