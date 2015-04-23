# read the training and test data and organize them in one dataset
# with subject and activity columns, and proper variable labels
aggregateTrainAndTestData <- function(rootDir) {
    
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
    features<-grepl("mean|std", featureNames)
    
    activities <- readDataFile("activity_labels")
    
    rbind(readDataset("test"), readDataset("train"))
}

levelToLabel <- function(level, table) {
    factor(level, levels = table[[1]], labels = table[[2]])
}

tideUp <- function() {
    data <- aggregateTrainAndTestData("UCI HAR Dataset")
    aggregate(data[,3:81], list(subject = data$subject, activity = data$activity), mean)
}