library(dplyr)

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])

best <- function(state, outcome) {
    rankhospital(state, outcome)
}


rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    names(data)[c(11,17,23)] <- c("heart attack", "heart failure", "pneumonia")
    data <- data[,c(2, 7, 11, 17, 23)]
    
    if (num == "best") num <- 1
    
    ## Check that state and outcome are valid
    if (state %in% data[,2] &
        outcome %in% c("heart attack",
                       "heart failure",
                       "pneumonia")){
        data <- data[data[2] == state, ]
        data <- data[!(data[[outcome]] == "Not Available"), ]
        data[[outcome]] <- as.numeric(data[[outcome]])
        data <- arrange(data, data[[outcome]], Hospital.Name)
        
        if (num == "worst") num <- length(data[[1]])
        return(data[num,1])
    }
    
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    message("invalid state or outcome")
    invisible(NULL)
}

rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    names(data)[c(11,17,23)] <- c("heart attack", "heart failure", "pneumonia")
    data <- data[,c(2, 7, 11, 17, 23)]
    
    if (num == "best") num <- 1
    
    ## Check that state and outcome are valid
    if (outcome %in% c("heart attack",
                       "heart failure",
                       "pneumonia")){
        data <- data[!(data[[outcome]] == "Not Available"), ]
        data[[outcome]] <- as.numeric(data[[outcome]])
        data <- group_by(data, State)
        data <- arrange(data, State)

        if (num == "worst") num <- length(data[[1]])
        data <- sapply(tempy, function(x, n) x[n,], num)
        ##data <- arrange(data, State)
        
        return(data)
    }
    
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    message("invalid state or outcome")
    invisible(NULL)
}