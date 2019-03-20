complete <- function(directory, id=1:332) {
    files <- list()
    for (i in 1:length(id)){
        files[[i]] <- read.csv(paste0(directory,
                                      "/",
                                      formatC(id[i],width = 3, flag = "0"),
                                      ".csv"))
    }
    
    pollCount <- data.frame()
    i <- 1
    
    for (csvFile in files){
        pollCount <- rbind(pollCount, c(csvFile$ID[1],
                                        sum(!is.na(csvFile$sulfate) &
                                                !is.na(csvFile$nitrate)))
        )
    }
    
    names(pollCount) <- c("id", "nobs")
    pollCount
}
