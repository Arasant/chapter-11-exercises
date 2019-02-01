# Exercise 1: working with data frames (review)
library(dplyr)

# Install devtools package: allows installations from GitHub
install.packages("devtools")

# Install "fueleconomy" dataset from GitHub
devtools::install_github("hadley/fueleconomy")

# Use the `libary()` function to load the "fueleconomy" package
library(fueleconomy)

# You should now have access to the `vehicles` data frame
# You can use `View()` to inspect it
data("vehicles")
View(vehicles)

# Select the different manufacturers (makes) of the cars in this data set. 
# Save this vector in a variable
manufacturers <- vehicles["make",  ]

# Use the `unique()` function to determine how many different car manufacturers
# are represented by the data set
manus <- unique(manufacturers)

# Filter the data set for vehicles manufactured in 1997
year_1997 <- vehicles[which(vehicles$year == "1997"), ]

# Arrange the 1997 cars by highway (`hwy`) gas milage
# Hint: use the `order()` function to get a vector of indices in order by value
# See also:
# https://www.r-bloggers.com/r-sorting-a-data-frame-by-the-contents-of-a-column/
ordered_1997 <- year_1997[order(year_1997$hwy), ]

# Mutate the 1997 cars data frame to add a column `average` that has the average
# gas milage (between city and highway mpg) for each car
avg_1997 <- mutate(year_1997, average = (hwy + cty) / 2)

# Filter the whole vehicles data set for 2-Wheel Drive vehicles that get more
# than 20 miles/gallon in the city. 
# Save this new data frame in a variable.
two_wheel_drive <- filter(vehicles, drive == "2-Wheel Drive", cty >= 20)

# Of the above vehicles, what is the vehicle ID of the vehicle with the worst 
# hwy mpg?
# Hint: filter for the worst vehicle, then select its ID.
worse_vehicle <- two_wheel_drive[which.min(two_wheel_drive$hwy), ]
worse_ID <- worse_vehicle["id"]

# Write a function that takes a `year_choice` and a `make_choice` as parameters, 
# and returns the vehicle model that gets the most hwy miles/gallon of vehicles 
# of that make in that year.
# You'll need to filter more (and do some selecting)!
most_mile <- function(year_choice, make_choice) {
  vehicle_models <- filter(vehicles, year == year_choice, make == make_choice)
  best_vehicle <- vehicle_models[which.max(vehicle_models$hwy), ]
  model <- best_vehicle["model"]
  print(model)
}

# What was the most efficient Honda model of 1995?
most_mile("1995", "Honda")
