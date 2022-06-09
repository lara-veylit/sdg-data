# SDG data 

## Goal 
Pull data on year, country, and values for certain indicators. 

## Method
- Used [goalie](https://github.com/gpw13/goalie/) and R
- Pulled data using sdg_data() based on series corresponding to indicators (may have multiple series related to an indicator)
- In the for loop at the end of the script you can explore other columns to include (you can just run the line of code with df_temp to see what kind of data is available). As not all columns are the same, you can also easily run this as nested lists (as I did for the sdg_dimensions data I pulled in the second for loop) for all the possible dimensions associated with a series. For silmplicity, I selected what would be the minimum data to use (I am guessing)

## Notes

- 4 series are in sdg_series() but not sdg_data(); 3.4.1 SH_DTH_DIABTS, 3.4.1 SH_DTH_CANCER, 3.4.1 SH_DTH_CARDIO, 3.4.1 SH_DTH_CRESPD
- In data/sdg_dimension.xlsx you will find more information on each series (related to the selected indicators). Each tab is a series with data pulled