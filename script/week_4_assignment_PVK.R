# Week 4 Assignment, R-DAVIS
# Read portal_data_joined.csv into R using the read.csv command and create a dataframe named surveys.
surveys <- read.csv(file = "data/portal_data_joined.csv")

# Subset to just the first column and columns five through 8. Include only the first 400 rows. 
# Save this as a dataframe called  surveys_subset.
surveys_subset <- surveys[1:400,c(1,5:8)]

# CHALLENGE: Select all rows that have a hindfoot_length greater than 32, save these in a new data.frame 
# named  surveys_long_feet, then plot its hindfoot_length values as a histogram using the hist function.
surveys_long_feet <- surveys_subset[which(surveys_subset$hindfoot_length > 32),]
hist(surveys_long_feet$hindfoot_length)

# Change the column hindfoot_lengths into a character vector.
surveys_long_feet$hindfoot_length = as.character(surveys_long_feet$hindfoot_length)

# Plot the hindfoot_lengths in a histogram (if this doesn’t work, just leave it, and think about it during 
# Part II of the assignment, wink wink).
hist(surveys_long_feet$hindfoot_length)
# Error message: "Error in hist.default(surveys_long_feet$hindfoot_length) : 'x' must be numeric"

# Commit & Push the R script to GitHub - check your repository on GitHub and make sure your script is there

#Nalina-the description is easy to understand

#failed to push some refs to 'https://github.com/gge-ucd/r-davis-in-class-Nalina-Nan.git'

#Updates were rejected because the tip of your current branch is behind