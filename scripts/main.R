## Inicio de ejecucion de Scripts

# dependencias
source("./scripts/install.R")
source("./scripts/env.R")
source("./scripts/project.R")
source("./scripts/util.R")
source("./scripts/analytics.R")
source("./scripts/stats.R")
source("./scripts/simulation.R")

require(triangle)

## Main
stats.dataTablesCollected <- util.setDatos(
    "datos_ferreteria_el_empuje_31_05_18.csv",
    "datos_ferreteria_el_empuje_01_06_18.csv",
    "datos_ferreteria_el_empuje_07_06_18.csv"
)

result <- analytics.run(stats.dataTablesCollected)

stats.averageClientsByHour <- result$averageClientsByHour
stats.averageServiceTime <- result$averageServiceTime
stats.averageWaitingTime <- result$averageWaitingTime
stats.masculinoProb <- result$masculinoProb
stats.femeninoProb <- result$femeninoProb
stats.payCardProb <- result$payCardProb
stats.payCashProb <- result$payCashProb
stats.youngProb <- result$youngProb
stats.oldProb <- result$oldProb
stats.noPurchaseProb <- result$noPurchaseProb
stats.productBuilder <- result$productBuilder
stats.productCarpentry <- result$productCarpentry
stats.productPlumbing <- result$productPlumbing
stats.productElectricity <- result$productElectricity
stats.productPainting <- result$productPainting
stats.productTools <- result$productTools

#simulation.run(nSimulations=100, sizeSimulations=21)
