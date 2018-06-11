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

util.increment <- function(count=0) {
    if(count == 0) {
        return (1)
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

util.moda <- function(data) {
    #ordenar tabla de frecuencia de forma decresiente
    tableFreq <- as.data.frame(sort(table(data), decreasing = T,))
    return(
        as.numeric(as.character(tableFreq[1,1]))
    )
}

util.replaceCoincidences <- function(dataA, dataB, soughtValue=0, replaceBy=0) {
    size <- length(dataA)
    for(index in (1:size)) {
        if(dataA[index] == soughtValue) {
            dataB[index] = replaceBy
        }
    }
    return(dataB)
}
