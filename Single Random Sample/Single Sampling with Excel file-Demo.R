#####################################################################
##            Sample Selection Reference Script                    ##             
#####################################################################

###############################
##  Set up data environment  ##
###############################
#load required packages
library(openxlsx)
library(dplyr)

###############################
##  Open data               ##
###############################
#click on the folder you need to pull from and click 'Copy Path' this works for sharefile!
#Paste into setwd('HERE') and change "/" so that they face the opposite direction "/"
#example setwd("C:/Users/jwindham/OneDrive - Arizona Auditor General/Documents/R")
setwd("C:/Users/jwindham/OneDrive - Arizona Auditor General/Documents/R Workshop/Data")

###import data
df<-read.csv('water-rights-complaints.csv')


###############################
##  Clean data               ##
###############################
###IF YoU HAVE A COLUMN WITH DATES
#Classify variable as a Date so R knows
#put variable name where it says date, leave "df$",
#you need to change the variable name in two places
#df$date_variable <- as.Date(df$date_variable,
                            #origin = "1899-12-30", format="%Y-%m-%d")



##CREATE SAMPLE NUMBER VARIABLE
###add a sample variable to number each observation in dataset, example would be for 2772 observations
##change 2772 below to the number of observations in dataset, which is shown in environment to the left
df$Sample <- 1:2772

#get seed number
#record the seed number randomly drawn below with a note
x<- 1:1000
sample(x,1)
#859

###############################
##  draw sample              ##
###############################
##draw sample 
#replace the number 2772 with the number of observations you have
y <- 1:2772

#set seed
#replace 859 with the seed number you got after running line 45
set.seed(859)

##get your sample numbers
#replace 10 with however many cases you need, otherwise you will only pull 10 for your sample
sample1 <-sample(y,10,replace=FALSE)
sample1

####IF YOU NEED THE SAMPLED OBSERVATIONS to BE LISTED IN NUMERICAL ORDER
#sample1a <-sort(sample(y,10,replace=FALSE))
  
#sample1a


##############################################################
##  pull randomly sampled observations from data            ##
##############################################################
# subset data to just have sample 1
df_new <- df[df$Sample %in% sample1,]
#sort by data so it keeps the order that the numbers were sampled in (important for stop and go)
df_new <-df_new %>% arrange(factor(Sample, levels = c(sample1)))
#look at Sample 1 subset 
View(df_new)

########################
##  EXPORT DATA       ##
########################
##IF saving to working directory
#export dataset
#replace "file_name" with what you'd like to name the file
write.xlsx(df_new, file = 'file_name.xlsx')

####IF saving exported data to a new place other than the working directory
#copy and paste the file path like you are setting the working directory
#replace "file_name" with what you'd like to name the file
write.xlsx(df_new, 'path/file_name.xlsx')

#you can also export multiple sheets
#what is in quotes would be the name of different tabs in the excel file, 
#what follows the equal sign is the dataset or table that goes on the excel sheet
#in the example below the sample dataset would go on the tab named 'Sample' in a file named "samples1.xlsx"
dataset_names <- list('Population' = df, 'Sample' = df_new, 'Results'=sample1)
write.xlsx(dataset_names, file = 'samples1.xlsx')

########################
##  EXPORT R SCRIPT   ##
########################
#This is if you need code for documentation purposes
#Make sure to save script before exporting

#copy and paste the file path like you are setting the working directory
#replace "filename" with what you'd like to name the file
path = "filepath/filename.txt"

#run this line to save the R script as a text file
cat(readChar(rstudioapi::getSourceEditorContext()$path, file.info(rstudioapi::getSourceEditorContext()$path)$size), file = path)
#I typically search for the text file and then save it manually as a PDF for documentation purposes
