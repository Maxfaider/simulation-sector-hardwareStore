#Module util.R
#Funciones generales del sistema (utilitarias)

util.timeToSeconds <- function(times) {
    seconds <- as.numeric(
        strptime(times, format="%H:%M:%S") - as.POSIXct(format(Sys.Date())),
        units="secs"
    )
    return(seconds)
}

util.getTable <- function(file, sep=";") {
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

util.increment <- function(count=1) {
    if(count == 1) {
        return (count)
    }
    return(count + 1)
}

util.setDatos <- function(...) {
    files = c(...)
    tables <- list()
    top <- util.increment();

    for(index in files) {
        tables[[top]] <- util.getTable(
            util.getFile(
                env.data,
                index
            )
        )
        top <- util.increment(top)
    }
    return(tables)
}
