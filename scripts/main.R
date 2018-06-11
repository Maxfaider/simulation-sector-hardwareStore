## Inicio de ejecucion de Scripts

#dependencias
source("./scripts/env.R")
source("./scripts/project.R")
source("./scripts/util.R")
source("./scripts/analytics.R")
source("./scripts/stats.R")
#source("./scripts/simulation.R")

## Main
stats.dataTablesCollected <- util.setDatos(
    "datos_ferreteria_el_empuje_31_05_18.csv",
    "datos_ferreteria_el_empuje_01_06_18.csv",
    "datos_ferreteria_el_empuje_07_06_18.csv"
)

result <- analytics.run(stats.dataTablesCollected)
