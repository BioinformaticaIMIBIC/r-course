################################################################################
# Título: Sesión práctica 2                                                    #
# Curso: El poder para explotar tus datos                                      #
# Fecha: 05/11/2025                                                            #
# Objetivo: Estructuras de control y flujos de ejecución                       #
#                                                                              #
# Ponente: Adrián Santiago                                                     #
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



# 🧩 Ejercicio 2. Convierte la edad de los pacientes, expresada en años, a días



# 🧩 Ejercicio 3. Evaluar si hubo complicación post-ERCP
# Si outcome es 1 y bleed es 2, imprime “Paciente con pancreatitis y sangrado”.

indo_rct$bleed[is.na(indo_rct$bleed)] <- "no_data" # Completa las celdas vacías



# 🧩 Ejercicio 4. Evalúa si el paciente de la fila 304 es una mujer



# 🧩 Ejercicio 5. Muestra solo los pacientes con edades comprendidas en los rangos 
# [0, 20] y [75, 90)  



# 🧩 Ejercicio 6. Usa un bucle for para recorrer los pacientes y mostrar:
# "Paciente hombre ambulatorio" o "Paciente mujer hospitalizada" según las 
# variables gender y status



# 🧩 Ejercicio 7. Crea una nueva columna "grupo_edad" con las categorías:
# "Joven" (<40), "Adulto" (40–65) y "Mayor" (>65)



# 🧩 Ejercicio 8. Evaluar si la participación de personal en formación ha sido un factor de 
# riesgo en la intervención



# 🧩 Ejercicio 9. Usa un bucle for por “site” para contar cuántos pacientes 
# tuvieron outcome == 1 en cada centro.
# Consejo: Utiliza contadores (variables), una para cada centro
 


# 🧩 Ejercicio 10. Crea una columna stent_protector con "Sí" si el paciente 
# tiene cualquiera de estos factores



