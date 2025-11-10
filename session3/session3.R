################################################################################
# Título: Sesión práctica 3                                                    #
# Curso: El poder para explotar tus datos                                      #
# Fecha: 10/11/2025                                                            #
# Objetivo: Funciones                                                          #
#                                                                              #
# Ponente: Adrián Santiago                                                     #
# Descripción: session3.R es parte de un curso de iniciación a R impartido por #
#              la UCAIB Bioinformática y Bioestadística del IMIBIC.            # 
################################################################################


# ══════════════════════════════════════════════════════════════════════════════
# Práctica 1. Crea una función que calcule el índice de masa corporal 
# ══════════════════════════════════════════════════════════════════════════════

calcular_IMC <- function(peso = 70, altura = 1.73) {
  
  # Calcular el IMC
  imc <- peso / (altura ** 2)
  return(imc)
}

# Ejemplos de uso:
calcular_IMC(1.73, peso = 70)
calcular_IMC(, 1.73)
calcular_IMC(1.73, 70)
calcular_IMC()



# ══════════════════════════════════════════════════════════════════════════════
# 🔥 Práctica 2. Calcula tu tasa metabólica basal (TMB)
# ══════════════════════════════════════════════════════════════════════════════
# Fórmulas:
#  👨 Hombres:  (10 × peso kg) + (6.25 × altura cm) - (5 × edad años) + 5
#  👩 Mujeres:  (10 × peso kg) + (6.25 × altura cm) - (5 × edad años) - 161
# ──────────────────────────────────────────────────────────────────────────────

TMB <- function(sexo, altura, peso, edad) {
  if(sexo == "femenino" | sexo == "Femenino") {
    
    tmb_mujer <- (10 * peso) + (6.25 * altura) - (5 * edad) - 161
    resultado <- paste("Tu tasa de metabolismo basal (TBM) es de", 
                       tmb_mujer, "Kcal/día")
    
  } else if (sexo == "masculino" | sexo == "Masculino") {
    
    tmb_hombre <- (10 * peso) + (6.25 * altura) - (5 * edad) + 5
    mensaje <- paste("Tu tasa de metabolismo basal (TBM) es de", 
                       tmb_hombre, "Kcal/día.")
    
  }
  return (mensaje)
  
}

valor <- TMB("Masculino", 173, 71, 32)
valor



# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 1. Calcula el IMC promedio del grupo correspondiente a la
# universidad de Kentucky utilizando una nueva función (promedio_BMI)
# ══════════════════════════════════════════════════════════════════════════════



# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 2. Crea una función que filtre el dataset por clínica y edad 
# mínima
# 
# Recomendación: Usa la función subset (consulta sus ejemplos)
# ══════════════════════════════════════════════════════════════════════════════

?subset



# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 3. Crea una función que calcule la media de BMI por grupo de 
# tratamiento
# 
# Recomendación: Usa la función aggregate (consulta sus ejemplos)
# ══════════════════════════════════════════════════════════════════════════════
 


# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 4. Detección de outliers
# ══════════════════════════════════════════════════════════════════════════════
# Un valor es outlier si está fuera del rango [Q1 - 1.5*IQR, Q3 + 1.5*IQR]
# ──────────────────────────────────────────────────────────────────────────────
# Pista: Haz uso de la función quantile



# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 5. Crea una función conteo_clinica() que reciba el dataframe y 
# el nombre de una clínica, y devuelva cuántas personas pertenecen a ella.
# 
# Alternativa más eficiente: función ?sum
# ══════════════════════════════════════════════════════════════════════════════



# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 6. Evaluar riesgo de salud
#
# Crea una función riesgo_salud() que devuelva "Alto" si la persona tiene 
# hipertensión o diabetes y es mayor de 35 años, y "Bajo" en 
# otro caso.
# ══════════════════════════════════════════════════════════════════════════════



# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 7. Generar ficha de paciente
# 
# Crea una función tarjeta_paciente() que, dado un PID, imprima en 
# pantalla un pequeño resumen tipo ficha
# 
# Recomendación: Usa la función cat (consulta sus ejemplos)
# ══════════════════════════════════════════════════════════════════════════════



# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 8. Función para eliminar espacios en blanco de una columna
# Puedes probar con la columna Diabetes
# 
# Pista: haz uso de la función trimws
# ══════════════════════════════════════════════════════════════════════════════



# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 9. Revisar fumadores inconsistentes
# 
# Asegurate de que si una persona no es fumadora no tenga indicada ninguna
# cantidad de cigarrillos consumidos al día
# ══════════════════════════════════════════════════════════════════════════════

# Si no hay inconsistencias, forcemos un valor erróneo:
opt[2, "BL.Cig.Day"] <- 2



# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 10. Filtrar población según criterios definidos. Por ejemplo,
# contempla las columnas "clinic", "edad" y diabetes. 

# Opcional: Valora admitir en tu función un rango de endades 
# (edad_min y edad_max)
# ══════════════════════════════════════════════════════════════════════════════


