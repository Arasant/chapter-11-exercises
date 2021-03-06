# Exercise 4: practicing with dplyr

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
library("nycflights13")
library("dplyr")

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
flights_data <- flights[row.names(flights), colnames(flights)]

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
flights_time <- mutate(flights, time_change = arr_delay - dep_delay)

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
flights_time_order <- arrange(flights_time, time_change)

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
flight_change <- flights %>%
  mutate(time_change = arr_delay - dep_delay) %>%
  arrange(time_change)

# Make a histogram of the amount of time gained using the `hist()` function
time_gained <- hist(flight_change$time_change)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
average_change <- mean(flight_change$time_change, na.rm = TRUE) #avg gained time

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
SeaTac <- flight_change %>%
  filter(dest == "SEA") %>%
  select(origin, dest, time_change)

# On average, did flights to SeaTac gain or loose time?
avg_change_sea <- mean(SeaTac$time_change, na.rm = TRUE) #avg gained time

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
jfk_sea <- flights %>%
  filter(origin == "JFK", dest == "SEA") %>%
  summarize(mean(air_time, na.rm = TRUE), min(air_time, na.rm = TRUE), max(air_time, na.rm = TRUE)) 


