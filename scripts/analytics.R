## Module analytics.R
# Funciones encargadas de analizar y extraer información.

analytics.tags <- c( "averageWaitingTime", "averageServiceTime",
    "averageClientsByHour", "masculinoProb", "femeninoProb",
    "payCardProb", "payCashProb", "youngProb", "oldProb",
    "noPurchaseProb", "productBuilder", "productCarpentry",
    "productPlumbing", "productElectricity",
    "productPainting", "productTools"
)

analytics.getProb <- function(element, flag, clientsTotal, nFlag="") {
    elementNovalid <- 0
    if(nFlag != "") {
        elementNovalid <- sum(as.character(element) == nFlag)
    }
    return (
        sum(as.character(element) == flag)/(clientsTotal - elementNovalid)
    )
}

analytics.getAverage <- function(initTimes, finalTimes) {
    return (
        mean(
            util.timeToSeconds(initTimes) - util.timeToSeconds(finalTimes)
        )
    )
}

analytics.getTriangular <- function(data) {
    return(c(
        min(data),
        max(data),
        util.moda(data)
    ))
}

analytics.run <- function(dataTablesCollected) {
    top <- util.increment()
    #tiempos
    waitingTime <- c()
    timeInService <- c()
    nroClientsByHour <- c()
    #metodo de pago
    payCardProb <- c()
    payCashProb <- c()
    #Datos persona
    masculinoProb <- c()
    femeninoProb <- c()
    youngProb <- c()
    oldProb <- c()
    #Producto
    noPurchaseProb <- c()
    productBuilder <- c()
    productCarpentry <- c()
    productPlumbing <- c()
    productElectricity <- c()
    productPainting <- c()
    productTools <- c()

    for(index in dataTablesCollected) {
        clientsTotal <- length(index[,1])
        ## Calcular tiempo de espera promedio
        waitingTime[top] <- analytics.getAverage(index$Init.purchase,
            index$coming.in.time)

        ## Calcular tiempo de servicio promedio
        timeInService[top] <- analytics.getAverage(index$Final.purchase,
            index$Init.purchase)

        ## Calcular nro de clientes por hr
        # Obtener tiempo en segundos de la llegada del primer cliente y el ultimo
        times <- util.timeToSeconds(
            c(
                as.character(index[clientsTotal, "coming.in.time"]),
                as.character(index[1, "coming.in.time"])
            )
        )
        ## Calcular segundos trascurridos del primero al ultimo cliente
        secondsElapsed <- times[1] - times[2]

        nroClientsByHour[top] <- (clientsTotal * 3600) / secondsElapsed

        ## Calcular la probabilidad del Sexo Masculino y femenino
        masculinoProb[top] <- analytics.getProb(index$Sex,
            "M",
            clientsTotal
        )
        femeninoProb[top] <- (1 - masculinoProb[top])

        ## Calcular la probabilidad del metodo de pago
        payCardProb[top] <- analytics.getProb(
            index$Payment.method,
            2,
            clientsTotal,
            nFlag = 0
        )
        payCashProb[top] <- (1 - payCardProb[top])

        ## Calcular la prrobabilidad de la edad
        youngProb[top] <- analytics.getProb(
            index$Age,
            "J",
            clientsTotal
        )
        oldProb[top] <- (1 - youngProb[top])

        ## Calcular la Probabilidad de que un cliente no compre
        noPurchaseProb[top] <- analytics.getProb(
            index$Total,
            0,
            clientsTotal
        )

        ## calcular minimo, maximo y moda de los productos para la distribución triangular
        ##obtener productos
        productBuilder <- append(productBuilder, index$Builder)
        productCarpentry <- append(productCarpentry, index$Carpentry)
        productPlumbing <- append(productPlumbing, index$Plumbing)
        productElectricity <- append(productElectricity, index$Electricity.and.electronic)
        productPainting <- append(productPainting, index$Painting)
        productTools  <- append(productTools, index$Tools)

        top <- util.increment(top)
    }
    ## Calcular tiempo de servicio promedio de todas las tablas recorridas
    results <- list(
        mean(waitingTime),
        mean(timeInService),
        mean(nroClientsByHour),
        mean(masculinoProb),
        mean(femeninoProb),
        mean(payCardProb),
        mean(payCashProb),
        mean(youngProb),
        mean(oldProb),
        mean(noPurchaseProb),
        analytics.getTriangular(productBuilder),
        analytics.getTriangular(productCarpentry),
        analytics.getTriangular(productPlumbing),
        analytics.getTriangular(productElectricity),
        analytics.getTriangular(productPainting),
        analytics.getTriangular(productTools)
    )
    ## Etiquetar Valores
    names(results) <- analytics.tags

    return(results)
}
