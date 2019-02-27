library(tidyverse)
library(rnoaa)
station_data = ghcnd_stations() #Может занять несколько минут лучше выполнить один раз в месте с хорошим интернетом и сохранить результат
station_data2 = read.csv("station_data.csv")
#После получения всписка всех станций, получите список станций ближайших к столице вашего региона,создав таблицу с именем региона и координатами его столицы
Kalmykia = data.frame(id = "KALMYKIA", latitude = 46.3077800,  longitude = 44.2558300)
Kalmykia_around = meteo_nearby_stations(lat_lon_df = Kalmykia, station_data = station_data,
                                    limit = 10, var = c("PRCP", "TAVG"),
                                    year_min = 1993, year_max = 2000)
#Kalmykia_around это список единственным элементом которого является таблица, содержащая идентификаторы метеостанций отсортированных по их 
# удалленности от Kalmykia, очевидно что первым элементом таблицы будет идентификатор метеостанции Тулы, его то мы и попытаемся получить
ELISTA_id =Kalmykia_around[["Kalmykia"]][["id"]][1]
#Для получения всех данных с метеостанции, зная ее идентификатор, используйте след. команду
all_ELISTA_data = meteo_tidy_ghcnd(stationid = ELISTA_id)

