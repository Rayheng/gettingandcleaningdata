## Coursera: Data Science Specialization
## Subject: Getting and Cleaning Data
## Project: Course Project 1
## Author : Heng Rui Jie
## Date   : 22nd August 2015

## Initalization
#   Set up working directory and loading of library
#
setwd("/Users/kilopy82/Coursera/Data Science Specialization/Getting and Cleaning Data/Week3/Course Project/UCI HAR Dataset")

library(dplyr)
library(Hmisc)

# Approach
# 1. Work on creating a single dataset for Train
#    - Merge the Subject to the Training Set
#    - Create a new variable called Category (refer to Cookbook on variable description)
# 2. 
