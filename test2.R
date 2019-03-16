library(tidyverse)
library(rnoaa)
library(lubridate)
station_data = ghcnd_stations() #Может занять несколько минут лучше выполнить один раз в месте с хорошим интернетом и сохранить результат
all
#После получения всписка всех станций, получите список станций ближайших к столице вашего региона,создав таблицу с именем региона и координатами его столицы
ELISTA = data.frame(id = "ELISTA", latitude = 46.3077800,  longitude = 44.2558300)
ELISTA_around = meteo_nearby_stations(lat_lon_df = ELISTA, station_data = station_data,
                                        limit = 10, var = c("PRCP", "TAVG"),
                                        year_min = 1993, year_max = 2000)
#Kalmykia_around это список единственным элементом которого является таблица, содержащая идентификаторы метеостанций отсортированных по их 
# удалленности от Kalmykia, очевидно что первым элементом таблицы будет идентификатор метеостанции Тулы, его то мы и попытаемся получить

#Для получения всех данных с метеостанции, зная ее идентификатор, используйте след. команду

all_data = data.frame()

for(i in 1:10){
  ELISTA_id =ELISTA_around[["ELISTA"]][["id"]][i]
  station_data = meteo_tidy_ghcnd(stationid = ELISTA_id)
  station_data = station_data %>% select(id,date,tavg)
  all_data = rbind(all_data, station_data)
  }

all_data=read.csv("all.data.csv")

all_data=all_data %>% mutate(year= date %>% year())
month(all_data$date)
all_data=all_data %>% mutate(month=date %>% month())
yday(all_data$date)
all_data=all_data %>% mutate(yday=date%>% yday())
all_data =filter(all_data,year<2001)
all_data=filter(all_data,year>1992)


all_data = all_data %>%  group_by(yday,month,year)
all_data=all_data%>% summarize(mean_temp=mean(tavg/10, na.rm=T))


summary_of_all_data=read.csv("summary of all.data.csv")

all_data=filter(all_data,mean_temp>=27)
