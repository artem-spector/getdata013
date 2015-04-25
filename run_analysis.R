# read the training and test data and organize them in one dataset
# with subject and activity columns, and proper variable labels
mergeTestAndTrainData <- function(rootDir) {
    
    readDataFile <- function(name, ...) {
        file <- paste(rootDir, "/", name, ".txt", sep = "")
        read.table(file, ...)
    }
    
    readDataset <- function(dir) {

        readDataFile <- function(name, ...) {
            file <-  paste(rootDir, "/", dir, "/", name, "_", dir, ".txt", sep="")
            read.table(file, ...)
        }
        
        
        act <- readDataFile("y", col.names = "activity")
        act <- sapply(act, levelToLabel, activities)
        
        subj <- readDataFile("subject", col.names = "subject")
        
        data <- readDataFile("X", col.names=featureNames)[,features]
        
        res <- data.frame(subj, act)
        for (col in names(data)) {
            res[[col]] <- data[[col]]
        }  
        
        res
    }

    featureNames<-readDataFile("features")[[2]]
    features<-grepl("mean\\(\\)|std\\(\\)", featureNames)
    featureNames <- sub("\\(\\)", "", featureNames)
    
    activities <- readDataFile("activity_labels")
    
    rbind(readDataset("test"), readDataset("train"))
}

levelToLabel <- function(level, table) {
    factor(level, levels = table[[1]], labels = table[[2]])
}

run_analysis <- function() {
    data <- mergeTestAndTrainData("UCI HAR Dataset")
    
    res <- aggregate(data[,3:length(data)], list(subject = data$subject, activity = data$activity), mean)
    write.table(res, file = "subject_activity_summary.txt", row.names = FALSE)
}