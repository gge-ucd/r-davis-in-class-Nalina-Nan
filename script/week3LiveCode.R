read.csv("data/tidy.csv")

x <- 4

#vector

weight_g <- c(50,60,31,89)
weight_g


#now characters
animals <- c("mouse","rat","cat","dog")

#vector exploration tools
length(weight_g)

length(animals)

#everything in vector has to be the same type

class(weight_g)
class(animals)

str(x)

weight_g <- c(weight_g,105)

weight_g

weight_g <- c(25,weight_g)

weight_g

# 6 types of atomic vectors: "numeric" ("double"), "charactor", "logical" , "integer" (whole round number), "complex", "raw"

#first 4 we lists are the main one we'll work with 

typeof(weight_g)

weight_integer<-c(20L,21L,85L)

class(weight_integer)

num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE) 
tricky <- c(1, 2, 3, "4")


num_logical <- c(1, 2, 3, TRUE) #cha turn num to char
char_logical <- c("a", "b", "c", TRUE) #true become 1
combined_logical <- c(num_logical, char_logical)

# coercion - R force everything into the least specific one = chararactor > num > int > logical


#subsetting vectors
animals
animals[3] #want cat # still a vector

animals[c(2,3)]
animals[c(3,1,3)]

#conditional subsetting
weight_g
weight_g[c(T,F,T,T,F,T)]

weight_g>50

weight_g[weight_g>50]

#multiple conditions
weight_g[weight_g < 30 | weight_g > 50] #| = or

weight_g[weight_g >= 30 & weight_g == 90]


animals[animals=="cat"|animals=="rat"]

animals %in% c("rat","ant","jackal","hippo") # also in this list

animals[animals %in% c("rat","ant","jackal","hippo")]

#challenge 
"four">"five" #true
"eight" > "five" #false
#tricky!! this is sorted alphabetically

#missing value

heights <- c(2,4,4,NA,6)

mean(heights) #NA

str(heights)

mean(heights,na.rm = T)
max(heights)
?mean

is.na(heights)
na.omit(heights) #??
complete.cases(heights) #if any cell have missing value... throw it out
