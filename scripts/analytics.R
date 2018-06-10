## Module analytics.R
# Funciones encargadas de analizar y extraer información.

analytics.getAverages <- function(dataTablesCollected) {
    top <- util.increment()
    waitingTime <- c()
    timeInService <- c()
    nroClientsByHour <- c()

    for(index in dataTablesCollected) {
        clientsTotal <- length(index[,1])
        ## Calcular tiempo de espera promedio
        waitingTime[top] <- mean(util.timeToSeconds(index$Init.purchase) -
            util.timeToSeconds(index$coming.in.time))

        ## Calcular tiempo de servicio promedio
        timeInService[top] <- mean(util.timeToSeconds(index$Final.purchase) -
            util.timeToSeconds(index$Init.purchase))

        ## Calcular nro de clientes por hr
        #Calcular segundos trascurridos del primero al ultimo cliente
        times <- util.timeToSeconds(
            c(
                as.character(index[clientsTotal, "coming.in.time"]),
                as.character(index[1, "coming.in.time"])
            )
        )
        secondsElapsed <- times[1] - times[2]

        nroClientsByHour[top] <- (clientsTotal * 3600) / secondsElapsed
        top <- util.increment(top)
    }
    ## Calcular tiempo de servicio promedio de todas las tablas recorridas
    results <- list(
        mean(waitingTime),
        mean(timeInService),
        mean(nroClientsByHour)
    )
    ## Etiquetar Valores
    names(results) <- c(
        "averageWaitingTime",
        "averageServiceTime",
        "averageClientsByHour"
    )
    return(results)
}
