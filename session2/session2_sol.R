################################################################################
# Título:   Sesión práctica 2                                                  #
# Curso:    El poder para explotar tus datos                                   #
# Fecha:    29/10/2026                                                         #
# Objetivo: Estructuras de control y flujos de ejecución                       #
#                                                                              #
# Ponente:  Adrián Santiago                                                    #
# Descripción: session2.R es parte de un curso de iniciación a R impartido por #
#              la UCAIB Bioinformática y Bioestadística del IMIBIC.            #
#                                                                              #
################################################################################


## 🚀 ¡COMENZAMOS!
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 📂 Comprueba que estás en la carpeta "curso_R" (si no, usa setwd())
getwd()

# 📦 Paquetes (instala solo los que falten y cárgalos)
paquetes <- c("tidyverse",    # dplyr, purrr, stringr, ggplot2, tidyr...
              "janitor",      # limpiar nombres de columnas
              "skimr",        # resúmenes rápidos
              "medicaldata")  # datasets médicos de ejemplo

nuevos <- setdiff(paquetes, rownames(installed.packages()))
if (length(nuevos) > 0) install.packages(nuevos)

library(tidyverse)
library(janitor)
library(skimr)
library(medicaldata)


## 🔀 CONDICIONALES: if / else
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# if () evalúa UNA sola condición (un único TRUE/FALSE)
edad <- 52

if (edad < 40) {
  print("Joven")
} else if (edad <= 65) {
  print("Adulto")
} else {
  print("Mayor")
}

# ⚠️ if() NO está vectorizado: con un vector de condiciones da error
edades <- c(25, 52, 70, NA, 38)
try(if (edades < 40) print("Joven"))

# Para vectores usamos las versiones vectorizadas:
ifelse(edades < 40, "Joven", "No joven")        # R base
if_else(edades < 40, "Joven", "No joven")       # dplyr: más estricto con tipos

# case_when() es la forma moderna de encadenar varias condiciones
# (se evalúan en orden: gana la primera que se cumple)
case_when(
  edades < 40   ~ "Joven",
  edades <= 65  ~ "Adulto",
  edades > 65   ~ "Mayor"
)                                               # los NA se quedan como NA


## 🔁 BUCLE FOR
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

proteinas <- c("P53", "BRCA1", "PSA", "SOX2")

# Alternativa 1: iterar POR ELEMENTOS
for (proteina in proteinas) {
  print(proteina)
}

# Alternativa 2: iterar POR POSICIÓN
# ⚠️ Usa seq_along() en lugar de 1:length(): es más seguro.
# Con un vector vacío, 1:length() recorre c(1, 0) y rompe el código.
vacio <- character(0)
1:length(vacio)        # ¡Itera dos veces sobre algo que no existe!
seq_along(vacio)       # Correcto: no itera nada

for (i in seq_along(proteinas)) {
  print(paste("Posición", i, "->", proteinas[i]))
}

# Guardar resultados dentro de un bucle
longitudes <- numeric(length(proteinas))
for (i in seq_along(proteinas)) {
  longitudes[i] <- nchar(proteinas[i])
}
longitudes

# Control del bucle: next (salta a la siguiente iteración) y break (sale)
for (proteina in proteinas) {
  if (proteina == "BRCA1") next
  if (proteina == "SOX2") break
  print(proteina)
}

# WHILE: se repite mientras una condición sea TRUE
# (útil cuando no sabes cuántas iteraciones harán falta)
n <- 1
while (n < 100) {
  n <- n * 2
}
n



## 🧪 EJEMPLOS CON DATOS REALES
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Ensayo clínico sobre indometacina para prevenir la pancreatitis tras CPRE
indo <- indo_rct |>
  as_tibble() |>
  clean_names()

View(indo)
skim(indo)

# 💡 ANTES de filtrar, mira qué valores toma cada variable.
# count() es la forma más rápida de inspeccionar una variable categórica:
indo |> count(rx)
indo |> count(gender)
indo |> count(outcome)

# Identifica los pacientes con indometacina haciendo uso de los bucles for
for (i in seq_len(nrow(indo))) {
  if (indo$rx[i] == "1_indomethacin") {
    print(indo$id[i])
  }
}

# La misma tarea, sin bucle:
indo[indo$rx == "1_indomethacin", "id"]          # R base

indo |>                                          # dplyr (se lee como una frase)
  filter(rx == "1_indomethacin") |>
  select(id)

indo |>
  filter(rx == "1_indomethacin") |>
  pull(id)                                       # pull() devuelve un vector

# Un valor perdido (NA) puede romper un if() dentro de un bucle.
# filter() y las funciones vectorizadas gestionan los NA sin dar error.


################################################################################
################################################################################
# Para cada ejercicio, intenta resolverlo de las DOS formas cuando se pida:
#   (a) con bucle for / if   (b) con la herramienta vectorizada (dplyr, etc.)
################################################################################

# 🧩 Ejercicio 1. Muestra por pantalla los IDs de los pacientes con risk > 4.5
# (a) bucle for + if     (b) filter() + pull()

# (a) bucle for + if
for (i in seq_len(nrow(indo))) {
  if (indo$risk[i] > 4.5) {
    print(indo$id[i])
  }
}


# (b) filter() + pull() <--- Vectorizado
indo |>
  filter(risk > 4.5) |>
  pull(id)


# 🧩 Ejercicio 2. Convierte la edad de los pacientes, expresada en años, a días
# Pista: no necesitas bucle, las operaciones aritméticas están vectorizadas.
# Usa mutate() para guardar el resultado en una nueva columna.
indo_days <- indo |> mutate(age_days = age * 365.25)
indo_days |> select(id, age, age_days) |> head()


# 🧩 Ejercicio 3. Evaluar si hubo complicación post-ERCP
# Si outcome es 1 y bleed es 2, imprime "Paciente con pancreatitis y sangrado".
# Primero completa las celdas vacías de bleed:
indo <- indo |> mutate(bleed = replace_na(as.character(bleed), "no_data"))
indo |> count(outcome, bleed)     # Mira cómo están codificadas las variables
# (a) bucle for + if     (b) filter() y count()

# (a) bucle for + if
 for (i in seq_len(nrow(indo))) {
   if (indo$outcome[i] == "1_yes" && indo$bleed[i] == 2) {
     print(paste("Paciente", indo$id[i], "con pancreatitis y sangrado."))
   }
 }
 

# (b) filter() y count()
casos <- indo |>
  filter(outcome == "1_yes", bleed == 2)

# Opción 1: un mensaje por paciente (igual que el bucle)
print(paste("Paciente", casos$id, "con pancreatitis y sangrado."))


# 🧩 Ejercicio 4. Evalúa si el paciente de la fila 304 es una mujer
# Pista: slice() selecciona filas por su posición.
indo$gender[304] == "1_female"

indo |> slice(304) |> select(gender)


# 🧩 Ejercicio 5. Muestra solo los pacientes con edades comprendidas en los
# rangos [0, 20] y [75, 90)
# Pista: between() y los operadores | y &
indo |> filter(between(age, 0, 20 ) | (age >=75 & age < 90)) |>
  select(id, age)


seleccion <- c()                      # vector vacío para guardar posiciones
for (i in seq_len(nrow(indo))) {
  if (between(indo$age[i], 0, 20) | (indo$age[i] >= 75 & indo$age[i] < 90)) {
    seleccion <- c(seleccion, i)
  }
}

indo[seleccion, c("id", "age")] 


# 🧩 Ejercicio 6. Usa un bucle for para recorrer los pacientes y mostrar:
# "X Paciente hombre ambulatorio" o "X Paciente mujer hospitalizada" según las
# variables gender y status.
# Pista: mira primero los valores con count(gender, status).
# Para agilizar el output, recorre solo los 10 primeros pacientes.
# Después, haz lo mismo sin bucle con case_when() o paste().
indo |> count(gender, status)

for (i in 1:10) {
  if(indo[i, "gender"] == "2_male") {
    if (indo[i, "status"] == "1_outpatient") {
      print(paste(indo$id[i], "Paciente hombre ambulatorio"))
    } else {
      print(paste(indo$id[i], "Paciente hombre hospitalizado"))
    }
  } else if(indo[i, "gender"] == "1_female") {
    if (indo[i, "status"] == "0_inpatient") {
      print(paste(indo$id[i], "Paciente mujer hospitalizada"))
    } else {
      print(paste(indo$id[i], "Paciente mujer ambulatorio"))
    }
  }
}


# (b) Vectorizado: calcula todos de golpe
indo |>
  mutate(
    sexo   = if_else(gender == "1_female", "mujer", "hombre"),
    estado = if_else(str_detect(status, "outpatient"), 
                     "ambulatorio", "hospitalizado"),
    descripcion = paste("Paciente", sexo, estado)
  ) |>
  select(id, descripcion) |>
  head(10)


# 🧩 Ejercicio 7. Crea una nueva columna "grupo_edad" con las categorías:
# "Joven" (<40), "Adulto" (40–65) y "Mayor" (>65)
# Pista: mutate() + case_when()

indo$grupo_edadTRAD <- NA
for (i in seq_len(nrow(indo))) {
  if (indo[i , "age"] < 40) {
    indo[i, "grupo_edadTRAD"] <- "Joven"
  } else if (indo[i , "age"] >= 40 & indo[i , "age"] <= 65) {
    indo[i, "grupo_edadTRAD"] <- "Adulto"
    
  } else {
    indo[i, "grupo_edadTRAD"] <- "Mayor"
  }
}


indo <- indo |>
  mutate(
    grupo_edad = case_when(
      age < 40   ~ "Joven",
      age <= 65  ~ "Adulto",
      age > 65   ~ "Mayor"
    )
  )
indo |> count(grupo_edad)
indo |> select(id, grupo_edad, grupo_edadTRAD)



# 🧩 Ejercicio 8. Evaluar si la participación de personal en formación ha sido
# un factor de riesgo en la intervención.
# Pista: variable "train". Compara el porcentaje de pacientes con 
# outcome == "1_yes" entre quienes tuvieron personal en formación y quienes no.

contador = 0
for (i in 1:nrow(indo)) {
  if (indo[i , "train"] == "1_yes" & indo[i , "outcome"] == "1_yes") {
    # print(indo_rct[, c("id", "outcome", "train")]) ## Opcional
    contador = contador + 1
  }
}
contador
contador * 100 / nrow(indo)


table(indo$train, indo$outcome) * 100 / nrow(indo) # Alternativa



# 🧩 Ejercicio 9. Usa un bucle for por "site" para contar cuántos pacientes
# tuvieron outcome == 1 en cada centro.
# Consejo: usa contadores (variables), uno para cada centro.
# Después, compruébalo sin bucle con count().

site_1_UM <- 0
site_2_IU <- 0
site3_UK <- 0
site_4_Case <- 0 

for (i in 1:nrow(indo)) {
  if (indo[i, "site"] == "1_UM") {
    site_1_UM <- site_1_UM + 1 
  }
  
  else if (indo[i, "site"] == "2_IU") {
    site_2_IU <- site_2_IU + 1
  }
  else if (indo[i, "site"] == "3_UK") {
    site3_UK <- site3_UK + 1
  }
  
  else {
    site_4_Case <- site_4_Case + 1
  }
}

indo |> count(indo$site) # Alternativa
table(indo_rct$site) # Alternativa

# 🧩 Ejercicio 10. Crea una columna stent_protector con "Sí" si el paciente 
# tiene cualquiera de estos factores

indo_rct$stent_protector <- NA

for (i in 1:nrow(indo_rct)) {
  if (indo_rct[i, "prophystent"] == "1_yes") {
    indo_rct[i, "stent_protector"] <- "Sí"
  }
  
  else if (indo_rct[i, "therastent"] == "1_yes") {
    indo_rct[i, "stent_protector"] <- "Sí"
  }
  
  else if (indo_rct[i, "pdstent"] == "1_yes") {
    indo_rct[i, "stent_protector"] <- "Sí" 
  } 
  # else (                                     ## Mejora del código
  #   indo_rct[i, "stent_protector"] <- "No"
  # )
}


## Alternativa

indo_rct$stent_protectorV2 <- NA

for (i in 1:nrow(indo_rct)) {
  if ("1_yes" %in% c(indo_rct[i, "prophystent"], indo_rct[i, "therastent"], 
                     indo_rct[i, "pdstent"])) {
    indo_rct[i, "stent_protectorV2"] <- "Sí"
  }
  # else (                                     ## Mejora del código
  #   indo_rct[i, "stent_protectorV2"] <- "No"
  # )
}



## 📌 PARA SABER MÁS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# - R for Data Science (2e): https://r4ds.hadley.nz
#     · Capítulo "Iteration" (across(), purrr) y "Functions"
# - ?case_when   ?if_else   ?map   ?across
