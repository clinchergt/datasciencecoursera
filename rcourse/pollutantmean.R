pollutantmean <- function(directory, pollutant, id=1:332) {
    files <- list()
    for (i in 1:length(id)){
        files[[i]] <- read.csv(paste0(directory,
                                    "/",
                                    formatC(id[i],width = 3, flag = "0"),
                                    ".csv"))
    }
    
    pollSum <- 0
    pollCount <- 0
    for (csvFile in files){
        pollSum <- pollSum + sum(csvFile[[pollutant]], na.rm = T)
        pollCount <- pollCount + sum(!is.na(csvFile[pollutant]))
    }
    
    pollSum / pollCount
}
