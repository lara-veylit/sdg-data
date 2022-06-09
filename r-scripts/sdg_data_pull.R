# Goal here is to select data for all countries for indicators from Kirsten
# Can find list of indicators in /indicators_list.xlsx
# Here I first try out the goalie package

library("goalie")
library("dplyr")
library("ggplot2")
library("here")
library("purrr")

# First need to pull indicators and clean list from Kirsten
meta <- read.csv(file = 'indicators_list.csv', sep = ";")
# Remove quotation marks around indicators 
# I stored these codes with "" to avoid Excel funny business 
meta = as.data.frame(sapply(meta, function(x) gsub("\"", "", x)))

#All sdg data pulled using goalie
full = sdg_overview()

# Filter indicator and series based on list from Kirsten. 
# Need series name for a given indicator to get all data for countries, years

filtered = full %>% 
  semi_join(meta, by = "indicator") %>%
  select(indicator, series)

# OBS! More unique series (26) than indicators (13)
# Not all series are matching a valid series in the SDG database
# Need to check this in sdg_series() looks to be analogous to code
for_use = data.frame(code = unique(filtered$series))
code_check = sdg_series()

can_pull = for_use %>% 
  semi_join(code_check, by = "code")

# Here we lost data on 4 series since they do not appear to have data up?
df = data.frame()

for (s in 1:length(can_pull$code)){
df_temp = sdg_data(series = can_pull$code[s])
#print(df_temp)
df_t = df_temp %>% select(Indicator, GeoAreaName, Time_Detail, Value, Units, Source, SeriesDescription, SeriesCode)
df = rbind(df_t,df)
}

# Store as a csv and save to data
write.csv(df, "data/sdg_data.csv", row.names = F)


###################################
## Pulling and storing tables with information for each series
list_dims = list()

for (i in 1:length(can_pull$code)){
  df2_temp = sdg_dimensions(series = can_pull$code[i])
  list_dims[[i]]= df2_temp
}


names(list_dims) = paste(can_pull$code)
## Need to name sheets based on series/indicator
list_dims %>%
  writexl::write_xlsx(path = "data/sdg-dimension-excel.xlsx")


