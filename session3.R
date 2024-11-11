################################################################################
# Título: Sesión práctica 3                                                    #
# Curso: El poder para explotar tus datos                                      #
# Fecha: 11/11/2024                                                            #
#                                                                              #
# Autor: Adrián Santiago                                                       #
# Descripción: session3.R es parte de un curso de iniciación a R impartido por #
#              la UCAIB Bioinformática y Bioestadística del IMIBIC.            # 
################################################################################



## RESUMEN SESIÓN 2
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

horas_sueño <- 6
desayuno <- TRUE

if (horas_sueño >= 8 & desayuno == TRUE) { 
  mensaje <- "¡A comerte el día!" 

} else if (horas_sueño >= 8 & desayuno == FALSE) {
  mensaje <- "No está mal pero igual necesitas un café."

} else if (horas_sueño < 8 & desayuno == TRUE) {
  mensaje <- "Un poco de sueño, pero al menos desayunaste."
  
} else { 
  mensaje <- "¡Sobrevivir al lunes será tu misión!"
} 

# Mostrar el mensaje 
print(mensaje)



## FUNCIONES
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Ejemplo resuelto 1
maximo <- function(a, b) {
    if (a > b) {
        m <- a
    } else {
        m <- b
    }
    return (m)
}

resultado <- maximo(12, 10)
resultado

y <- 18
resultado <- maximo(20, y + 7)
resultado


################################################################################
################################################################################


# Ejercicio 1. Crea una función que calcule la tabla de multiplicar del 
# número n





################################################################################
################################################################################


# Ejemplo resuelto 2
suma_cuadrados <- function(...) {
  valores <- list(...)
  res <- 0
  for (valor in valores) {
    res <- res + valor ^ 2
  }
  return (res)
}

suma_cuadrados(-4, 2, 0, 3)


# Alternativa simplificada
# Suma de los cuadrados
suma_cuadrados <- sum(c(-4, 2, 0, 3) ^ 2)

# Resultado
suma_cuadrados


################################################################################
################################################################################


# Ejercicio 2. Calcula el área de un trapezoide cuya base mayor (b1) es igual 
# a 6, su base menor (b2) es igual a 4 y su altura es 5.






################################################################################
################################################################################

# Ejercicio 3. Crea una función que tome un vector y un número y devuelva el
# cuantas veces aparece este último en el vector.
vector <- c(12, 5, 7, 6, 6, 4, 3, 6, 5, 11, 12)
num <- 6





################################################################################
################################################################################

# Ejercicio 4. Crea una función que calcule el índice de masa corporal 





################################################################################
################################################################################

# Ejercicio 5. Tasa metabólica basal (resuelto en session3.R)

# Formula para hombres: 
# TMB (kcal) = (10 x peso en kg) + (6,25 × altura en cm) - (5 × edad en años) + 5
# 
# Formula para mujeres:
# TMB (kcal) = (10 x peso en kg) + (6,25 × altura en cm) - (5 × edad en años) - 161







# Ejercicios complementarios
################################################################################
################################################################################

# Crea una función que devuelva el valor absoluto de un número








################################################################################
################################################################################

# Crea una función que tome un vector de números enteros y devuelva otro vector
# de la misma longitud con 1 si el número es positivo, -1 si es negativo y 0 si
# el valor original es 0.

vector <- c(-4, 2, 0, 3) # Puedes utilizar este u otro
# Resultado esperado: c(-1, 1, 0, 1)




################################################################################
################################################################################


# Crea una función que determine si un número es primo o no







################################################################################
################################################################################



