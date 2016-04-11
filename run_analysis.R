#=====================================================================
#  Installing and loading packages                                   #
#=====================================================================
install.packages("dplyr")
install.packages("reshape2")
install.packages("R.utils")


library(dplyr)
library(reshape2)
library(R.utils)
#============================================================
# Downloading and Unzippig files in local drive
#============================================================
setwd("c:/")
if(!file.exists("Getting and Cleaning Assignment")){
    dir.create("Getting and Cleaning Assignment")
}

setwd("./Getting and Cleaning Assignment")

urlfile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip?accessType=DOWNLOAD"
if(!file.exists("Dataset.zip")){
    download.file(urlfile, destfile = "Dataset.zip", mode = "wb")
}
unzip("Dataset.zip",unzip = getOption("unzip"), exdir = getwd())


#===================================================================
#  Creating Data Tables                                            #    
#===================================================================

activity_labels_raw <- read.table("./UCI HAR Dataset/activity_labels.txt")
features_raw <- read.table("./UCI HAR Dataset/features.txt")
x_test_raw <- tbl_df(read.table("./UCI HAR Dataset/test/X_test.txt"))
y_test_raw <- read.table("UCI HAR Dataset/test/y_test.txt")
Subject_test_raw <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_train_raw <- tbl_df(read.table("./UCI HAR Dataset/train/X_train.txt"))
y_train_raw <- read.table("UCI HAR Dataset/train/y_train.txt")
Subject_train_raw <- read.table("UCI HAR Dataset/train/subject_train.txt")

#=====================================================================
#  1.Merges the training and the test sets to create one data set.   #
#=====================================================================

# Append both tables (x_test and x_train)
  x_test_train <- rbind(x_test_raw,x_train_raw)
  
#=====================================================================
#   2. Extracts only the measurements on the mean and standard       #
#      deviation for each measurement.                               #  
#=====================================================================
  var_name <- as.character(features_raw[,2]) # extract the header 
  meanstd_index <-   grep("mean|std",var_name) # extracts header containing mean or std
  
# Extracts only the measurements on the mean and standard
  mean_std <- x_test_train[,meanstd_index]

  
#=====================================================================
#  3. Uses descriptive activity names to name the activities in      #
#     the data set                                                   #
#=====================================================================

    # Add subject in table
    mean_std$subject <- c(as.character(Subject_test_raw$V1),as.character(Subject_train_raw$V1)) 
  
    # Add type_activity and activity description in the table
    mean_std$type_act <- c(as.character(y_test_raw[,1]),
                           as.character(y_train_raw[,1])) 
    colnames(activity_labels_raw)<- c("type_act","activity_description")
    activity_labels_raw$type_act <- as.character(activity_labels_raw$type_act)
    mean_std <- merge(mean_std,activity_labels_raw, by = "type_act")
    
    # Re-organizing the columns
    mean_std <- mean_std[,c(81,1,82,2:80)]
    
    
#=====================================================================
#  4. Appropriately labels the data set with descriptive variable    #
#     names                                                          #
#=====================================================================

    col_names <- var_name[meanstd_index]
    colnames(mean_std) <- c(colnames(mean_std)[1:3],col_names)
    
#=====================================================================
#  5. From the data set in step 4, creates a second, independent     # 
#     tidy data set with the average of each variable for each       #
#     activity and each subject.                                     #
#=====================================================================
    # Sort table by subject and type_act
    mean_std <- tbl_df(mean_std)

    tidy_data <-  mean_std %>%
                  # re-arrange the variables mean and std into observations
                  melt(id=c(1:3), measure.vars=c(4:82)) %>% 
                  # Calculate the mean of each variables by activity and subject
                  dcast(subject + type_act + activity_description ~ variable, mean)%>%
                  # Sort the table by subject and type_activity
                  arrange(as.integer(subject),as.integer(type_act))

    
#=====================================================================
#  Saving the tidy_data in txt format                                #
#=====================================================================
    write.table(tidy_data,"tidy_data.txt", sep = ",")    