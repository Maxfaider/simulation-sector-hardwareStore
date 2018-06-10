#funciones utilitarias

# Description:
#
#
util.timeToSeconds <- function(times) {
    seconds <- as.numeric(
        strptime(times, format="%H:%M:%S") - as.POSIXct(format(Sys.Date())),
        units="secs"
    )
    return(seconds)
}

util.getData <- function(file, sep=";") {
    tableResult <- read.table(file, sep=sep, header=TRUE)
    return(tableResult)
}

util.getFile <- function(directory, file) {
    return(
        paste(
            directory,
            file,
            sep="/"
        )
    )
}
