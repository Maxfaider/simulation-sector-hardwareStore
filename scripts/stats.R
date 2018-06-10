#
#

##Extracción de datos para el analisis
day_1_table <- util.getData(
    util.getFile(
        env.data,
        "datos_ferreteria_el_empuje_31_05_16.csv"
    )
)

#clientes totales en dia 1
day_1_table.clientsTotal <- length(day_1_table[,1])

#cantidad de productos vendidos por categoria en el dia 1
day_1_table.product.builder <- sum(day_1_table$Builder)
day_1_table.product.carpentry <- sum(day_1_table$Carpentry)
day_1_table.product.plumbing  <- sum(day_1_table$Plumbing)
day_1_table.product.electricity. <- sum(day_1_table$Electricity.and.electronic)
day_1_table.product.painting  <- sum(day_1_table$Painting)
day_1_table.product.tools <- sum(day_1_table$Tools)
day_1_table.product.total <- sum(day_1_table$Total)

#calcular segundos trascurridos en el sistema en el dia 1
times <- util.timeToSeconds(
    c(
        as.character(day_1_table[day_1_table.clientsTotal, "coming.in.time"]),
        as.character(day_1_table[1, "coming.in.time"])
    )
)
day_1_table.secondsElapsed <- times[1] - times[2]

#Calcular nro de clientes por hr en el dia 1
day_1_table.nroClientsByHour <- (day_1_table.clientsTotal * 3600) / day_1_table.secondsElapsed

#Calcular tiempo de espera en segundos
waitingTime <- util.timeToSeconds(day_1_table$Init.purchase) -
    util.timeToSeconds(day_1_table$coming.in.time)

#Calcular tiempo del servicio en segundos
timeInService <- util.timeToSeconds(day_1_table$Final.purchase) -
    util.timeToSeconds(day_1_table$Init.purchase)
