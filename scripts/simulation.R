#Module simulation.R
# Generar aleatorio de tablas a partir de los datos estadísticos almacenados

simulation.run <- function(nSimulations, sizeSimulation) {

    ## Simular tiempos de llegada
    for() {
        comingInTime <- cumsum(
            round(
                rexp(
                    sizeSimulation,
                    1/stats.averageClientsByHour
                )
            )
        )
        ## Simular tiempos de espera
        waitingTime <- round(
            rexp(
                sizeSimulation, 1/stats.averageWaitingTime
            ), 2
        )
        ## Simular tiempos de servicio
        serviceTime <- round(
            rexp(
                sizeSimulation, 1/stats.averageServiceTime
            ), 2
        )
        ## Simuelar el Sexo de la persona
        colmSex <- simulation.getSamples(
            stats.dataTablesCollected[[1]]$Sex,
            sizeSimulation,
            c(stats.femeninoProb, stats.masculinoProb)
        )
        ## Simular el rango de edad de la persona
        colmAge <- simulation.getSamples(
            stats.dataTablesCollected[[1]]$Age,
            sizeSimulation,
            c(stats.oldProb, stats.youngProb)
        )
        ## Simular del pago de la persona
        Payment <- simulation.getSamples(
            factor(c(1,2)),
            sizeSimulation,
            c(stats.payCashProb, stats.payCardProb)
        )
        ## Simular la compra de productos de construcción
        Builder <- trunc(rtriangle(sizeSimulation,
            stats.productBuilder[1],
            stats.productBuilder[2],
            stats.productBuilder[3]
        ))
        ## Simular la compra de productos de carpintería
        Carpentry <- trunc(rtriangle(sizeSimulation,
           stats.productCarpentry[1],
           stats.productCarpentry[2],
           stats.productCarpentry[3]
       ))
        ## Simular la compra de productos de fontanería
        Plumbing <- trunc(rtriangle(sizeSimulation,
            stats.productPlumbing[1],
            stats.productPlumbing[2],
            stats.productPlumbing[3]
        ))
        ## Simular la compra de productos de electricidad
        Electricity <- trunc(rtriangle(sizeSimulation,
            stats.productElectricity[1],
            stats.productElectricity[2],
            stats.productElectricity[3]
        ))

        ## Simular la compra de productos de pintura
        Painting <- trunc(rtriangle(sizeSimulation,
            stats.productPainting[1],
            stats.productPainting[2],
            stats.productPainting[3]
        ))
        ## Simular la compra de productos de herramienta
        Tools <- trunc(rtriangle(sizeSimulation,
            stats.productTools[1],
            stats.productTools[2],
            stats.productTools[3]
        ))
        ## Columna Total
        Total = Builder + Carpentry + Plumbing +
            Electricity + Painting + Tools
        #calculo del tiempo total en el sistema
        timeTotal = waitingTime + serviceTime
        #Payment <- util.replaceCoincidences(Total, Payment)
        simulatedTable[[index]] <- data.frame(
            comingInTime,
            waitingTime,
            serviceTime,
            "time.in.the.system" = timeTotal,
            "Age" = colmAge,
            "Sex" = colmSex,
            Builder,
            Carpentry,
            Plumbing,
            "Electricity.and.electronic" = Electricity,
            Painting,
            Tools,
            Total,
            "Payment.method" = Payment
        )
    }
    return(simulatedTable)
}

simulation.getSamples <- function(elements, size, prob) {
    return (
        sample(
            sort(levels(elements)),
            size,
            replace = T,
            prob=prob
        )
    )
}

simulation.betweenTimes <- function(columnX, columnY) {
    size <- length(colmnX)
    new.column <- c()
    previusTime <- 0

    for(index in (1:size) ) {
        new.column <- max(previusTime, columnX[index]) - columnX[index]
        previusTime <- columnY[index]
    }
}
