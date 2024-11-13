################################################################################
# Título: Sesión práctica 2                                                    #
# Curso: El poder para explotar tus datos                                      #
# Fecha: 06/11/2024                                                            #
#                                                                              #
# Autor: Adrián Santiago                                                       #
# Descripción: session2.R es parte de un curso de iniciación a R impartido por #
#              la UCAIB Bioinformática y Bioestadística del IMIBIC.            # 
################################################################################




## Estructuras de control y flujo de ejecución
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# BUCLE FOR
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 
animales <- c("koala", "gato", "perro", "panda")

# Iteración de un vector (alternativa 1)  <-- POR ELEMENTOS
for (animal in animales) {
  print(animal)
}

# Iteración de un vector (alternativa 2)  <-- POR POSICIÓN DEL ELEMENTO
for (i in 1:length(animales)) {
  print(animales[i])
}




# Estructura de control IF/ELSEIF/ELSE/
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

animales

for (animal in animales) {
  if (animal == "perro") {
    print(animal)
  }
}




#Ejercicio. Evalua con if/else si un número es mayor o menor a cero
num <- -5
#  |
#  '--> Aquí va tú código
if(num > 0) {
    print ("El número es mayor que cero")

    } else {
      print ("El número es menor que cero")
}






## Ejemplo final (Cromosoma mitocondrial de Mus musculus)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

fasta <- read.table(file = "Mus_musculus.GRCm39.MT.fasta", header = FALSE,
                    sep = "", skip = 1)

fasta$G_count <- 0


# Recorre cada secuencia en el dataframe
for (i in 1:nrow(fasta)) {
  
  # Obtén la secuencia actual
  secuencia <- fasta[i, 1]
  
  # Inicializa contadores para esta secuencia
  G_count <- 0
  
  # Recorre cada carácter de la secuencia
  for (letra in strsplit(secuencia, "")[[1]]) {
    
    # Usa if para contar "G"
    
    if (letra == "G") {
      G_count <- G_count + 1
      
    } 
  }
  fasta$G_count[i] <- G_count   
}

View(fasta)



# Muestra por pantalla solo los números menores que 10 y mayores que 20 
# comprendidos entre 1 y 30.
#  |
#  '--> Aquí va tú código

for (i in 1:30) {
  if (i < 10) {
    print(i)
  } else if (i > 20) {
    print (i)
  }
}


for (i in 1:30) {
  if(i < 10 | i > 20) {
    print(i)
  }
}



# Cuando los niveles de glucosa en sangre se encuentran entre  110 y 128 mg/dl
# es considerado normal. Si superan los 128 se denomina hiperglucemia. 
# 
# Utiliza la estructura "if" para mostrar en pantalla "HPERGLUCEMIA" si la 
# medidas (medida1 y medida2) superan el valor citado.

medida1 <- 114
medida2 <- 137
#  |
#  '--> Aquí va tú código

if (medida1 > 128) {
  print("HIPERGLUCEMIA")
}


if (medida2 > 128) {
  print("HIPERGLUCEMIA")
}



# Utiliza la estructura "if/else" para mostrar en pantalla si la persona 
# sufre hiperglucemia o no para cada medida (medida1 y medida2).
#  |
#  '--> Aquí va tú código

if (medida1 > 128) {
  print("HIPERGLUCEMIA")
} else {
  print("NO HIPERGLUCEMIA")
}


if (medida2 > 128) {
  print("HIPERGLUCEMIA")
} else {
  print("NO HIPERGLUCEMIA")
}






# Se puede utilizar la estructura FOR para simplificar el código anterior

medidas <- c(medida1, medida2)
medidas
#  |
#  '--> Aquí va tú código

for (medida in medidas) {
  if (medida > 128) {
    print("HIPERGLUCEMIA")
  } else {
    print("NO HIPERGLUCEMIA")
  }
  
}




## Continuación del ejemplo final (Cromosoma mitocondrial de Mus musculus) 
## AÑADIMOS ELSE
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

fasta <- read.table(file = "Mus_musculus.GRCm39.MT.fasta", header = TRUE,
                    sep = "", skip = 1)

fasta$G_count <- 0
fasta$Others <- 0


# Recorre cada secuencia en el dataframe
for (i in 1:nrow(fasta)) {
  
  # Obtén la secuencia actual
  secuencia <- fasta[i, 1]
  
  # Inicializa contadores para esta secuencia
  G_count <- 0
  Others <- 0
  
  # Recorre cada carácter de la secuencia
  for (letra in strsplit(secuencia, "")[[1]]) {
    
    # Usa if para contar "G"
    
    if (letra == "G") {
      G_count <- G_count + 1
      
    } else {
      Others <- Others + 1
    }
  }
  
  fasta$G_count[i] <- G_count 
  fasta$Others[i] <- Others  
  
}

View(fasta)



## Ejercicios complementarios
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


# Mejora el ejercicio sobre hiperglucemia. Considerando los casos de 
# hipoglucemia (valores inferiores a 110). Utiliza la estructura else if vista
# en el curso y el nuevo vector "medidas"
medidas <- c(112, 117, 105, 128, 131)
#  |
#  '--> Aquí va tú código


for (medida in medidas) {
  if (medida > 128) {
    print("HIPERGLUCEMIA")
  } else if (medida < 110 ) {
    print("HIPOGLUCEMIA")
  } else {
    print ("VALOR NORMAL")
  }
  
}



# Muestra por pantalla solo los números pares comprendidos entre 1 y 100 
#  |
#  '--> Aquí va tú código
for (i in 1:100) {
  if (i %% 2 == 0) {
    print (i)
  }
}




# Dado un vector "notas" utiliza un bucle FOR para mostrar por pantalla si
# la persona ha sacado un aprobado, notable, sobresaliente o suspenso en cada 
# examen 
#  |
#  '--> Aquí va tú código

notas <- c(4.25, 5, 6.5, 8.75, 9.5)


for (nota in notas) {
  if (nota > 5 & nota < 7) {
    print("APROBADO")
  } else if (nota >= 7 & nota < 9) {
    print("NOTABLE")
  } else if (nota >= 9 ) {
    print("SOBRESALIENTE")
  } else {
    print ("SUSPENSO")
  }
  
}




## Funciones "apply"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

# Función apply
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

iris <- read.csv(file = "iris.csv", header = TRUE, sep = ",", dec = ".")
head(iris)

?mean
results <- apply(iris[, c(1:4)], 2, mean)
results


# Pero... ¿y con bucle FOR?

results <- c()
for (i in 1:4) {
  results <- c(results, mean(iris[, i]))
}
names(results) <- colnames(iris[1:4])
results





?sum
apply(iris[, c(1:4)], 2, sum) # Suma de valores por columna


# Función lappy
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

# Caso especial de apply, devuelve una LISTA
a <- list(A = c(4, 6, 1, 5),
          B = data.frame(x = 1:5, y = c(3, 1, 2, 2, 4)))
a


lapply(a, sum)


# Raíces cuadradas
b <- c(12, 9, 21)
?sqrt
class(lapply(b, sqrt))




# Función sapply
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

# Vector de secuencias de ADN
sequences <- c("ATCG", "GGCATG", "TTAAGGCC", "CGT")

# Usamos sapply para calcular la longitud de cada secuencia
sequence_lengths <- sapply(sequences, nchar)

# Imprimimos los resultados
print(sequence_lengths)



## Ejemplo final completo (Cromosoma mitocondrial de Mus musculus)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

fasta <- read.table(file = "Mus_musculus.GRCm39.MT.fasta", header = TRUE,
                    sep = "", skip = 1)

fasta$G_count <- 0
fasta$A_count <- 0
fasta$T_count <- 0
fasta$C_count <- 0


# Recorre cada secuencia en el dataframe
for (i in 1:nrow(fasta)) {
  # Obtén la secuencia actual
  secuencia <- fasta[i, 1]
  
  # Inicializa contadores para esta secuencia
  G_count <- 0
  A_count <- 0
  T_count <- 0
  C_count <- 0
  
  # Recorre cada carácter de la secuencia
  for (letra in strsplit(secuencia, "")[[1]]) {
    
    # Usa if para contar cada nucleótido
    
    if (letra == "G") {
      G_count <- G_count + 1
      
    } else if (letra == "A") {
      A_count <- A_count + 1
      
    } else if (letra == "T") {
      T_count <- T_count + 1
      
    } else if (letra == "C") {
      C_count <- C_count + 1
    }
  }
  
  # Guarda las cuentas en el dataframe
  fasta$G_count[i] <- G_count
  fasta$A_count[i] <- A_count
  fasta$T_count[i] <- T_count
  fasta$C_count[i] <- C_count
}

# Muestra el dataframe con las cuentas
View(fasta)


conteos <- apply(fasta[, c("G_count", "A_count", "T_count", "C_count")], 2, sum)
