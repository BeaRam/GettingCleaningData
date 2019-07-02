# GettingCleaningData


Getting and Cleaning Data Course Project for JHU Coursera 

The code and items contained within this repo are the submission for **Lorenzo Ramirez** as part of the Course 3: Getting and Cleaning Data Course Project. I do not own any of the data used in this project, below is additional description for the project aims and data source. 


**Background**
An exciting area in data science right now (2019) is wearable computing.
Interested in reading more: 
  http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/


**Datasets**


The data are linked here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 


**Files within the GettingCleaningData Repo**


- run_analysis.R Codebook: defines the variables, data, and steps to clean up the data.


- run_analysis.R Script: 


        - Downloads and unzips dataset.
        
        
        - Extracts the Data Frames from the UCI HAR Dataset Folder.
        
        
        - Merges the training and the test data sets to create one data set.
        
        
        - Extract only the measurements on the mean & standard deviation for each measurement.
        
        
        - Use descriptive activity names to name the activities in the Tidy data set.
        
        
        - Appropriately label the data set with descriptive variable names.
        
        
        - From the data set in the prior step, creates a 2nd, independent tidy data set with the average of each variable for           each activity and each subject.
        
        
- FinalStep_Data.txt: a tidy dataset created using the run_analysis.R script
