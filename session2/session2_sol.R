################################################################################
# Título: Sesión práctica 2                                                    #
# Curso: El poder para explotar tus datos                                      #
# Fecha: 05/11/2025                                                            #
# Objetivo: Estructuras de control y flujos de ejecución                       #
#                                                                              #
# Autor: Adrián Santiago                                                       #
# Descripción: session2.R es parte de un curso de iniciación a R impartido por #
#              la UCAIB Bioinformática y Bioestadística del IMIBIC.            #
################################################################################


# 📂 Directorio de trabajo (working directory)
# Comprueba el directorio actual:
getwd()

## Estructuras de control y flujo de ejecución
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# 🔁 BUCLE FOR
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Ejemplo básico
proteinas <- c("P53", "BRCA1", "PSA", "SOX2")

# Iteración de un vector (alternativa 1)  <-- POR ELEMENTOS
for (proteina in proteinas) {
  print(proteina)
}

# Iteración de un vector (alternativa 2)  <-- POR POSICIÓN DEL ELEMENTO
for (i in 1:length(proteinas)) {
  print(proteinas[i])
}



# Ejemplos con datos reales
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

library(medicaldata)
data(indo_rct)

View(indo_rct)


# Identifica los pacientes con indometacina haciendo uso de los bucles for

for (i in 1:nrow(indo_rct)) {
  if (indo_rct$rx[i] == "1_indomethacin") {
    print(indo_rct[i, 1])
  }
}


indo_rct[indo_rct$rx == "1_indomethacin", 1] ## Alternativa


################################################################################
################################################################################

# 🧩 Ejercicio 1. Muestra por pantalla los IDs de los pacientes con risk > 4.5
for (i in 1:nrow(indo_rct)) {
  if (indo_rct[i, "risk"] > 4.5) {
    print(indo_rct[i, 1])
  }
}


indo_rct[indo_rct$risk > 4.5, 1]             ## Alternativa



# 🧩 Ejercicio 2. Convierte la edad de los pacientes, expresada en años, a días

edad_pacientes <- indo_rct$age
resultado <- c()

for (i in edad_pacientes) {
  edad_modificada <- i * 365
  resultado <- c(resultado, edad_modificada)
  
}
resultado

indo_rct$age_dias <- resultado



# 🧩 Ejercicio 3. Evaluar si hubo complicación post-ERCP
# Si outcome es 1 y bleed es 2, imprime “Paciente con pancreatitis y sangrado”.

indo_rct$bleed[is.na(indo_rct$bleed)] <- "no_data" # Completa las celdas vacías

for (i in 1:nrow(indo_rct)) {
  if (indo_rct[i, "outcome"] == "1_yes" & indo_rct[i, "bleed"] == 2) {
    # print(indo_rct[i, 1])
    # print("Paciente con pancreatitis y sangrado")
    
    print(paste0("El paciente ", i, " presenta pancreatitis y sangrado"))
  }
}



# 🧩 Ejercicio 4. Evalúa si el paciente de la fila 304 es una mujer

genero <- indo_rct$gender

if (genero[304] == "1_female") {
  print("La paciente en la fila 304 es una mujer.")
} else {
  print("El paciente es un hombre.")
}


ifelse(genero[304] == "1_female", "Es una mujer", "Es un hombre") ## Alternativa



# 🧩 Ejercicio 5. Muestra solo los pacientes con edades comprendidas en los rangos 
# [0, 20] y [75, 90)  


for (i in 1:nrow(indo_rct)) {
  if (indo_rct[i, "age"] <= 20 | indo_rct[i, "age"] >= 75 & indo_rct[i, "age"] < 90) {
    print(indo_rct[i, c("id", "age", "rx")])
  }
}



for (i in 1:nrow(indo_rct)) {
  if (indo_rct[i, "age"] <= 20)  {
    print(indo_rct[i, ])
  }
  else if (indo_rct[i, "age"] >= 75 & indo_rct[i, "age"] < 90) {
    print(indo_rct[i, c("id", "age", "rx")])
  }
}



# 🧩 Ejercicio 6. Usa un bucle for para recorrer los pacientes y mostrar:
# "Paciente hombre ambulatorio" o "Paciente mujer hospitalizada" según las 
# variables gender y status

for (i in 1:nrow(indo_rct)) {
  if (indo_rct[i, "gender"] == "1_female" & indo_rct[i, "status"] == "0_inpatient") {
    print(paste0("Paciente con ID ", i , ": mujer hospitalizada"))
  }
  else if (indo_rct[i, "gender"] == "2_male" & indo_rct[i, "status"] == "1_outpatient") {
    print(paste0("Paciente con ID ", i , ": hombre ambulatorio"))
  }
}



# 🧩 Ejercicio 7. Crea una nueva columna "grupo_edad" con las categorías:
# "Joven" (<40), "Adulto" (40–65) y "Mayor" (>65)

for (i in 1:nrow(indo_rct)) {
  if (indo_rct[i, "age"] < 40) {
    indo_rct[i, "grupo_edad"] <- "Joven"
  }
  
  else if (indo_rct[i, "age"] >= 40 & indo_rct[i, "age"] < 65) {
    indo_rct[i, "grupo_edad"] <- "Adulto"
  }
  
  else {
    indo_rct[i, "grupo_edad"] <- "Mayor"
  }
}


table(indo_rct$grupo_edad)


# 🧩 Ejercicio 8. Evaluar si la participación de personal en formación ha sido un factor de 
# riesgo en la intervención

contador = 0
for (i in 1:nrow(indo_rct)) {
  if (indo_rct[i , "train"] == "1_yes") {
    # print(indo_rct[, c("id", "outcome", "train")]) ## Opcional
    contador = contador + 1
  }
}
contador
contador * 100 /nrow(indo_rct)



# 🧩 Ejercicio 9. Usa un bucle for por “site” para contar cuántos pacientes 
# tuvieron outcome == 1 en cada centro.
# Consejo: Utiliza contadores (variables), una para cada centro
 
site_1_UM <- 0
site_2_IU <- 0
site3_UK <- 0
site_4_Case <- 0 

for (i in 1:nrow(indo_rct)) {
  if (indo_rct[i, "site"] == "1_UM") {
    site_1_UM <- site_1_UM + 1 
  }
  
  else if (indo_rct[i, "site"] == "2_IU") {
    site_2_IU <- site_2_IU + 1
  }
  else if (indo_rct[i, "site"] == "3_UK") {
    site3_UK <- site3_UK + 1
  }
  
  else {
    site_4_Case <- site_4_Case + 1
  }
}

table(indo_rct$site) ##Alternativa


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
