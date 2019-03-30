#Чалве Джефф создайте модель множественной линейной регрессии потоков ночных потоков паров воды за период 2013 года по данным измерений методом турбулентной пульсации

library(tidyverse)
library(stringr)
library(dplyr)
library(tibble)
library(ggplot2)
eddy=read_csv("eddypro.csv", skip=1, na=c(" ","NA","-9999","-9999.0"), comment=c("["));
eddy=eddy[-1,]
eddy=select(eddy,-(roll))
eddy=eddy %>% mutate_if(is.character,factor)
names(eddy) = names(eddy) %>%
  str_replace_all("[!]","_exclam_") %>%
  str_replace_all("[?]","_quest_") %>%
  str_replace_all("[*]","_star_") %>%
  str_replace_all("[+]","_plus_") %>%
  str_replace_all("[-]","_minus_") %>%
  str_replace_all("[@]","_at_") %>%
  str_replace_all("[$]","_dollar_") %>%
  str_replace_all("[#]","_hash_") %>%
  str_replace_all("[/]","_slash_") %>%
  str_replace_all("[%]","_pecent_") %>%
  str_replace_all("[&]","_amp_") %>%
  str_replace_all("[\\^]","_power_") %>%
  str_replace_all("[()]","_")
glimpse(eddy)
sapply(eddy,is.numeric)

#eddy_numeric=filter(eddy, daytime==FALSE)[,sapply(eddy, is.numeric)}
numeric_names = names(eddy)[sapply(eddy, is.numeric)]
eddy_numeric=select(eddy,numeric_names)
glimpse(eddy_numeric)


cor_td=cor(drop_na(eddy_num))%>%as.data.frame %>% select(h2o_flux)
var=row.names(cor_td)[cor_td$h2o_flux^2>.25] %>% na.exclude

formula=as.formula(paste("h2o_flux~",paste(var,collapse="+"),sep=""))

mod=lm(formula,data=eddy_numeric)

names(mod)

summary(mod)

predict(mod)

resid(mod)

coef(mod)

anova(mod)

cor_td=cor(drop_na(eddy_num)%>%as.data.frame %>% select(LE,rand_err_LE,rand_err_h2o_flux,RH,VPD,un_LE,un_h2o_flux,w_slash_h2o_cov))


cor_td = (cor_td)^2

# после проверки,толко остается LE И RH 

mod1=lm(h2o_flux~LE+RH,data=eddy_numeric)
coef(mod1)

resid(mod1)

summary(mod1)

anova(mod1)

plot(mod1)
















