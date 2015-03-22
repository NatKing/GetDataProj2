
## This function is to write out a tidy dataset given a set of data
## for wearable computing.
Run_Analysis <- function() {
        
        ## Read the test data
        dftest <- read.table("UCI HAR Dataset/test/X_test.txt", stringsAsFactors=FALSE)
        
        ## Do the same as above with the training data; Read the train data
        dftrain <- read.table("UCI HAR Dataset/train/X_train.txt", stringsAsFactors=FALSE)

        ## Read the activity associated with each record in the test dataset
        y_test <- read.table("UCI HAR Dataset/test/y_test.txt", stringsAsFactors=FALSE)

        ## and the subject associated with each record in the test data
        sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt", stringsAsFactors=FALSE)
        
        ## Read the activity associated with each record in the train dataset
        y_train <- read.table("UCI HAR Dataset/train/y_train.txt", stringsAsFactors=FALSE)

        ## and the subject associated with each record in the train data
        sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt", stringsAsFactors=FALSE)
        
        ## combine dftest and dftrain into one data frame called dftotal
        dftotal <- rbind(dftest, dftrain)

        ## combine y_test and sub_test to combine subject & activity
        dfsubtest <- cbind(sub_test, y_test)
        
        ## combine y_train and sub_train to combine subject & activity
        dfsubtrain <- cbind(sub_train, y_train)
        
        ## combine dfsubtest and dfsubtrain to make one data frame that contains
        ## the subject and the activity for each record in dftotal
        dfsubact <- rbind(dfsubtest, dfsubtrain)
        colnames(dfsubact) <- c("SUBJECT", "ACTIVITY")
        
        ## So, now we have dftotal containing all the various measurements
        ## and dfsubact containing the corresponding subject and activity
        ## in the same row.
                
        ## Let's make the activity more descriptive and self-explanatory
        ## by replacing the numbers with their real meaning
        dfsubact$ACTIVITY[dfsubact$ACTIVITY==1] <- "WALKING"
        dfsubact$ACTIVITY[dfsubact$ACTIVITY==2] <- "WALKING UPSTAIRS"
        dfsubact$ACTIVITY[dfsubact$ACTIVITY==3] <- "WALKING DOWNSTAIRS"
        dfsubact$ACTIVITY[dfsubact$ACTIVITY==4] <- "SITTING"
        dfsubact$ACTIVITY[dfsubact$ACTIVITY==5] <- "STANDING"
        dfsubact$ACTIVITY[dfsubact$ACTIVITY==6] <- "LAYING"
        
        ## Read the column names from the features.txt file
        dfcols <- read.table("UCI HAR DATASET/features.txt", stringsAsFactors=FALSE)

        ## set column names of dftotal from dfcols
        colnames(dftotal) <- dfcols$V2

        ## Since we are only interested in std and mean data,
        ## let's subset dftotal by only having columns that contain "std"
        ## or "mean" as part of its name
        stdmean_names <- dfcols[grep("std|mean", dfcols$V2), "V2"]
        dftotal <- dftotal[, stdmean_names]
        
        ## add the subject and the activity columns for each record
        dftotal <- cbind(dftotal, dfsubact)
        
        ## group our data frame by the two interested fields
        df2 <- group_by(dftotal, SUBJECT, ACTIVITY)
        
        ## Now, summarize every column by its mean for these groups
        dfTidy <- summarise_each(df2, funs(mean))
        
        ## Now that we have our tidy data - which is just the mean
        ## of all the interesting columns grouped by each subject
        ## and by each activity, write it to a file called "tidy.csv"
        write.table(dfTidy, file="tidy.txt", sep=",", row.names=FALSE)
}