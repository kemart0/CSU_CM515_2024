print("Hello World")
date()
getwd()
x<-5+7
x
# assign a series of words to the vector object called organism:
organism <- c("human", "mouse", "worm", "yeast", "maize")

# Then, recall it:
organism

# How many elements are in this vector?
length(organism)

# What is the third element?
organism[3]


kingdom <- c("animalia", "animalia", "animalia", "fungi", "plantae")
class(kingdom)
#it is character

#switch into factor vector

kingdom<-as.factor(kingdom)
class(kingdom)
str(kingdom)
