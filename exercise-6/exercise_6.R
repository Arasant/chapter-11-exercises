# Exercise 6: dplyr join operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# Create a dataframe of the average arrival delays for each _destination_, then 
# use `left_join()` to join on the "airports" dataframe, which has the airport
# information
# Which airport had the largest average arrival delay?
avg_arr_delay <- flights %>% 
  group_by(dest) %>%
  summarize(mean(arr_delay, na.rm = TRUE))

join_data <- left_join(avg_arr_delay, airports, by = c("dest" = "faa"))
airport_best_arr <- join_data %>%
  select(name, `mean(arr_delay, na.rm = TRUE)`) %>%
  summarize(min(`mean(arr_delay, na.rm = TRUE)`, na.rm = TRUE))

# Create a dataframe of the average arrival delay for each _airline_, then use
# `left_join()` to join on the "airlines" dataframe
# Which airline had the smallest average arrival delay?
View(airlines)
avg_airline_arr <- flights %>%
  group_by(carrier) %>%
  summarize(mean(arr_delay, na.rm = TRUE))

combine_data <- left_join(avg_airline_arr, airlines, by = c("carrier" = "carrier"))
airport_worst_arrival <- combine_data %>%
  select(carrier, `mean(arr_delay, na.rm = TRUE)`) %>%
  summarize(max(`mean(arr_delay, na.rm = TRUE)`))
