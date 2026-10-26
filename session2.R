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


?pull
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



# (b) filter() + pull() <--- Vectorizado



# 🧩 Ejercicio 2. Convierte la edad de los pacientes, expresada en años, a días
# Pista: no necesitas bucle, las operaciones aritméticas están vectorizadas.
# Usa mutate() para guardar el resultado en una nueva columna.



# 🧩 Ejercicio 3. Evaluar si hubo complicación post-ERCP
# Si outcome es 1 y bleed es 2, imprime "Paciente con pancreatitis y sangrado".
# Primero completa las celdas vacías de bleed:
indo <- indo |> mutate(bleed = replace_na(as.character(bleed), "no_data"))
indo |> count(outcome, bleed)     # Mira cómo están codificadas las variables
# (a) bucle for + if     (b) filter() y count()

# (a) bucle for + if

 

# (b) filter() y count()



# 🧩 Ejercicio 4. Evalúa si el paciente de la fila 304 es una mujer
# Pista: slice() selecciona filas por su posición.



# 🧩 Ejercicio 5. Muestra solo los pacientes con edades comprendidas en los
# rangos [0, 20] y [75, 90)
# Pista: between() y los operadores | y &



# 🧩 Ejercicio 6. Usa un bucle for para recorrer los pacientes y mostrar:
# "X hombre ambulatorio" o "X Paciente mujer hospitalizada" según las
# variables gender y status.
# Pista: mira primero los valores con count(gender, status).
# Para agilizar el output, recorre solo los 10 primeros pacientes.
# Después, haz lo mismo sin bucle con case_when() o paste().
indo |> count(gender, status)

# (a) bucle for + if


# (b) Vectorizado: calcula todos de golpe


# 🧩 Ejercicio 7. Crea una nueva columna "grupo_edad" con las categorías:
# "Joven" (<40), "Adulto" (40–65) y "Mayor" (>65)
# Pista: mutate() + case_when()



# 🧩 Ejercicio 8. Evaluar si la participación de personal en formación ha sido
# un factor de riesgo en la intervención.
# Pista: variable "train". Compara el porcentaje de pacientes con 
# outcome == "1_yes" entre quienes tuvieron personal en formación y quienes no.



# 🧩 Ejercicio 9. Usa un bucle for por "site" para contar cuántos pacientes
# tuvieron outcome == 1 en cada centro.
# Consejo: usa contadores (variables), uno para cada centro.
# Después, compruébalo sin bucle con count().

site_1_UM <- 0
site_2_IU <- 0
site3_UK <- 0
site_4_Case <- 0 



# 🧩 Ejercicio 10. Crea una columna stent_protector con "Sí" si el paciente 
# tiene cualquiera de estos factores: prophystent, therastent o pdstent





## 📌 PARA SABER MÁS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# - R for Data Science (2e): https://r4ds.hadley.nz
#     · Capítulo "Iteration" (across(), purrr) y "Functions"
# - ?case_when   ?if_else   ?map   ?across
