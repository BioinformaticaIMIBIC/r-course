################################################################################
# Título: Sesión práctica 3                                                    #
# Curso: El poder para explotar tus datos                                      #
# Fecha: 03/11/2026                                                            #
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

promedio_BMI <- function(df, grupo) {
  resultado <- mean(df$BMI[df$Clinic == grupo], na.rm = TRUE)
  
  return (resultado)
}

# 💡 Ejemplo:
promedio_BMI(opt, "KY")
promedio_BMI(opt, "MS")



# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 2. Crea una función que filtre el dataset por clínica y edad 
# mínima
# 
# Recomendación: Usa la función subset (consulta sus ejemplos)
# ══════════════════════════════════════════════════════════════════════════════

?subset

filtrar_participantes <- function(data, clinica, edad_min) {
  subset(data, Clinic == clinica & Age >= edad_min)
}

# 💡 Ejemplo:
filtrar_participantes(opt, "MN", 30)



# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 3. Crea una función que calcule la media de BMI por grupo de 
# tratamiento
# 
# Recomendación: Usa la función aggregate (consulta sus ejemplos)
# ══════════════════════════════════════════════════════════════════════════════
 

media_BMI_por_grupo <- function(df) {
  aggregate(BMI ~ Group, data = df, FUN = mean, na.rm = TRUE)
}

# 💡 Ejemplo:
media_BMI_por_grupo(opt)




# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 4. Detección de outliers
# ══════════════════════════════════════════════════════════════════════════════
# Un valor es outlier si está fuera del rango [Q1 - 1.5*IQR, Q3 + 1.5*IQR]
# ──────────────────────────────────────────────────────────────────────────────
# Pista: Haz uso de la función quantile
# boxplot(opt$BMI)
boxplot.stats(opt$BMI)


encontrar_outliers <- function(var) {
  
  q1 <- quantile(var, 0.25, na.rm = TRUE)
  q3 <- quantile(var, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  
  lim_inf <- q1 - 1.5 * iqr
  lim_sup <- q3 + 1.5 * iqr
  
  outlier_ind <- which(var < lim_inf | var > lim_sup)
  # outlier_ind
  
  return (outlier_ind)
}

# 💡 Ejemplo:
outliers <- encontrar_outliers(opt$BMI)
opt[outliers, "BMI"]




# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 5. Crea una función conteo_clinica() que reciba el dataframe y 
# el nombre de una clínica, y devuelva cuántas personas pertenecen a ella.
# 
# Alternativa más eficiente: función ?sum
# ══════════════════════════════════════════════════════════════════════════════

conteo_clinica <- function(data, clinica) {
  
  contador = 0
  for (i in 1:nrow(data)) {
    if (data[i, "Clinic"] == clinica) {
      contador = contador + 1
    }
    
  }
  return (contador)
}

# 💡 Ejemplo:
conteo_clinica(opt, "KY")



# Alternativa más eficiente
conteo_clinica <- function(data, clinica) {
  sum(data$Clinic == clinica, na.rm = TRUE)
}

# 💡 Ejemplo:
conteo_clinica(opt, "KY")



# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 6. Evaluar riesgo de salud
#
# Crea una función riesgo_salud() que devuelva "Alto" si la persona tiene 
# hipertensión o diabetes y es mayor de 35 años, y "Bajo" en 
# otro caso.
# ══════════════════════════════════════════════════════════════════════════════


riesgo_salud <- function(edad, hipert, diab) {
  if ((hipert == "Y" | diab == "Yes") & edad > 35) {
    "Alto"
  } else {
    "Bajo"
  }
}

# 💡 Ejemplo:
riesgo_salud(opt$Age[1], opt$Hypertension[1], opt$Diabetes[1])



# Alternativa
riesgo_salud <- function(df) {
  if ((df[12] == "Y" | df[13] == "Yes") & df[4] > 35) {
    "Alto"
  } else {
    "Bajo"
  }
}

# 💡 Ejemplo:
riesgo_salud(opt[1, ])


# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 7. Generar ficha de paciente
# 
# Crea una función tarjeta_paciente() que, dado un PID, imprima en 
# pantalla un pequeño resumen tipo ficha
# 
# Recomendación: Usa la función cat (consulta sus ejemplos)
# ══════════════════════════════════════════════════════════════════════════════

tarjeta_paciente <- function(data, pid) {
  p <- data[data$PID == pid, ]
  
  cat("ID:", p$PID, 
      "\nEdad:", p$Age, "años",
      "\nClínica:", p$Clinic,
      "\nGrupo:", p$Group, "\n")
}

# 💡 Ejemplo:
tarjeta_paciente(opt, 100042)



# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 8. Función para eliminar espacios en blanco de una columna
# Puedes probar con la columna Diabetes
# 
# Pista: haz uso de la función trimws
# ══════════════════════════════════════════════════════════════════════════════

limpiar_espacios <- function(df, columna) {
  df[[columna]] <- trimws(df[[columna]])
  return(df)
}

opt_Diabetes <- limpiar_espacios(opt, "Diabetes")



# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 9. Revisar fumadores inconsistentes
# 
# Asegurate de que si una persona no es fumadora no tenga indicada ninguna
# cantidad de cigarrillos consumidos al día
# ══════════════════════════════════════════════════════════════════════════════


# Si no hay inconsistencias, forcemos un valor erróneo:
opt[2, "BL.Cig.Day"] <- 2

revisar_fumadores <- function(data) {
  df <- subset(data, Use.Tob == "No " & !is.na(BL.Cig.Day))
  return (df)
  }

d <- revisar_fumadores(opt)



# ══════════════════════════════════════════════════════════════════════════════
# 🧩 Ejercicio 10. Filtrar población según criterios definidos. Por ejemplo,
# contempla las columnas "clinic", "edad" y diabetes. 

# Opcional: Valora admitir en tu función un rango de endades 
# (edad_min y edad_max)
# ══════════════════════════════════════════════════════════════════════════════


filtrar_poblacion <- function(df, clinic = NULL, edad_min = 0, 
                              edad_max = 100, diabetes = NULL) {
  
  df_filtrado <- df
  
  if (!is.null(clinic)) { ## Contempla que NO se quiera filtrar por esta columna
    df_filtrado <- df_filtrado[df_filtrado$Clinic == clinic, ]
  }
  
  # df_filtrado <- df_filtrado[df_filtrado$Clinic == clinic, ] #Alternativa más simple
  if (!is.null(diabetes)) {
    df_filtrado <- df_filtrado[df_filtrado$Diabetes == diabetes, ]
  }
  
  df_filtrado <- df_filtrado[df_filtrado$Age >= edad_min & df_filtrado$Age <= edad_max, ]
  
  return (df_filtrado)
}

# Ejemplo:
new_opt <- filtrar_poblacion(opt, clinic = "MN", edad_min = 20, 
                             edad_max = 35, diabetes = "Yes")
