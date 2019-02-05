#week_4_assignment_NalinaAiem.R

#download file from url, and name the file with function destfile
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data/portal_data_joined.csv")

#create surveys dataframe
surveys <- read.csv(file = "data/portal_data_joined.csv")

#Subset to just the first column and columns five through 8
#Include only the first 400 rows
surveys_subset <- surveys[c(1:400),c(1,5:8)]

#Select all rows that have a hindfoot_length greater than 32
surveys_subset[surveys_subset$hindfoot_length[surveys_subset$hindfoot_length>32],]

#remove NA , save these in a new data.frame named  surveys_long_feet
surveys_long_feet<-surveys_subset[surveys_subset$hindfoot_length>32&!is.na(surveys_subset$hindfoot_length),]

#plot a histogram
hist(surveys_long_feet$hindfoot_length)

#plot a histogram when hindfoot_length as charactor...doesn't work
hist(as.character(surveys_long_feet$hindfoot_length))
