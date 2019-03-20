corr <- function(directory, threshold = 0) {
    completeMonitors <- complete(directory)
    filtered <- completeMonitors[completeMonitors[["nobs"]] > threshold, ]
    pollCors <- vector(mode = "numeric")
    files <- list()
    
    if (length(filtered[[1]]) > 0){
        for (i in 1:length(filtered[[1]])){
            files[[i]] <- read.csv(paste0(directory,
                                          "/",
                                          formatC(filtered$id[i],width = 3, flag = "0"),
                                          ".csv"))
        }
        
        i <- 1
        
        for (csvFile in files){
            pollCors <- c(pollCors, cor(csvFile$sulfate,
                                        csvFile$nitrate,
                                        use = "na.or.complete"))
        }
    }
    
    pollCors
}
