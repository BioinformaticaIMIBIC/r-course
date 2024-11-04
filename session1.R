################################################################################
# Título: Sesión práctica 1                                                    #
# Curso: El poder para explotar tus datos                                      #
# Fecha: 04/11/2024                                                            #
#                                                                              #
# Autor: Adrián Santiago                                                       #
# Descripción: session1.R es parte de un curso de iniciación a R impartido por #
#              la UCAIB Bioinformática y Bioestadística del IMIBIC.            # 
################################################################################


## ¡COMENZAMOS!
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Directorio de trabajo (wd)
getwd()
#setwd("C:/Users/Documents")

# Instalar paquetes de R
install.packages("readxl") # este comando sirve para instalar un paquete
library(readxl)



## Importar datasets
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Cargar tablas
# 
# ¿Qué hace el comando "X" y cuáles son sus parámetros?
?read.csv
iris <- read.csv(file = "iris.csv", header = TRUE, sep = ",", dec = ".")
dim(iris)
View(iris)


?read.table
input_csv <- read.table("iris.csv", header = TRUE, 
                        sep = ",", dec = ".")

# Importa el dataset titanic.csv
#  |
#  '--> Aquí va tú código
   


input_xlsx <- read_excel("iris_dataset.xlsx" )


## Operadores en R
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Aritméticos
# Ejercicio 1. Calcula el área de un círculo con radio 5
#  |
#  '--> Aquí va tú código
   


# Ejercicio 2. Calcula el contenido de Guanina-Citosina (GC) en una secuencia 
# de ADN
seq <- "GCCATGAGGGTC"
#  |
#  '--> Aquí va tú código
   
   

# Relacionales y lógicos
vector <- c(1, 3, 5, 7, 9)
#  |
#  '--> Aquí va tú código (Sigue los ejemplos de la presentación)




## Operaciones con vectores
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Asignación de variables
x <- 3

x + "cuatro"

class(x)
class("cuatro")

y <- c(1:10)
class(y)

# Operaciones con vectores
x + y
z <- x * y

# Indexando vectores
z[4] 
z[1:3]
z[8:12]

length(z) # ¿Cuántos elementos tengo?

z
z[-1] # Descarta el primer elemento
z[c(-1, -2)]
z[c(-1: -5)]






## Operaciones con matrices
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Crear una matriz
m <- matrix(data = 1:9, nrow = 3, ncol = 3) 
m

# Crea una matriz (p) de 20 elementos con la secuencia del 1 al 20
#  |
#  '--> Aquí va tú código

# ¿Menos valores que espacios?
matrix(1:12, nrow = 5, ncol = 4)

# ¿Más valores que espacios?
matrix(1:12, nrow = 2, ncol = 5)

new_row <- c(5, 10, 15)
rbind(m, new_row) # Añadir nueva fila

# Inventa y añade una nueva fila a la matriz "m"
#  |
#  '--> Aquí va tú código


new_col <- c(7, 14, 21)
cbind(m, new_col) # Añadir nueva columna

(n <- matrix(data = 4:12,
          nrow = 3,
          ncol = 3)) # Por columnas (parámetro byrow)


m + n
m * n
m ^ 2
m / 2

t(n) # Trasponer matriz


# Multiplicación matricial
# (o <- matrix(6:1, nrow = 3, ncol = 2))
# 
# dim(n)
# dim(o)
# 
# n %*% o


## Operaciones con DataFrames
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

df <- as.data.frame(n)
View(df)

head(df)
dim(df)
head(iris)

colnames(df) # ¿Cómo se llaman las columnas?
colnames(df) <- c("Columna 1", "Columna 2", "Columna 3")
df

colnames(df) <- c("Columna_1", "Columna_2")
colnames(df) <- c("Columna_1", "Columna_2", "Columna_3", "Columna_4")

rownames(df) # ¿Cómo se llaman las filas?
rownames(df) <- c("Fila 1", "Fila 2", "Fila 3")

dimnames(df)

df[, 1] # Extrae la 1º columna (igual que df[c(1,2,3), 1])
df[2, ] # Extrae la 2º fila
df["Fila 2",]

df[2, ] <- c(-3, -6, -9) # Sobreescribir elemento(s) del DataFrame
df[2, ] <- c(-3, -7) 
df

df[2, c(1,2)]

df[df$Columna_1 > 5, ] # El simbolo "$" permite indexar una columna 
                       # por su nombre





## Operaciones con listas
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

mi_lista <- list("objeto1" = 7, "objeto2" = "21", "objeto3" = as.factor(3),
                 "objeto4" = matrix(1:4, nrow = 2))
mi_lista

mi_lista["objeto2"]
mi_lista[["objeto2"]]

mi_lista["objeto1", "objeto2"] # ¿Qué ha pasado?
mi_lista[c("objeto1", "objeto2")]

mi_lista["objeto5"] # ¿Por qué devuelve null?

mi_lista[[5]] <- data.frame(X = c(5, 2, 3), Y = c(7, 2, 9))
mi_lista

mi_lista[[3]] <- NULL
mi_lista
mi_lista[-3] # Equivalente



## Ejercicios complementarios
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Vamos a trabajar con un dataset de marcas comerciales de cereales.

# 1. Importa el dataset cereal.csv.


# 2. Visualiza el dataset y su estructura (nombre de columnas, filas, 
# dimesiones, tipos de clases en sus columnas).


# 3. Crea una nueva columna llamada "totalcarb" que sea la suma de las columnas
# "carbo" y "sugars".


# 4. Crea un nuevo data.frame "kelloggs" que recoja solo las filas del dataset 
# cuyo manufacturador sea "Kelloggs".


# 4. Crea un nuevo data.frame "no_health" que recoja solo las filas (cereales)
#con más de 80 calorías y menos de 20 vitaminas y minerales.


# 5. Crea un data.frame con aquellos cereales con al menos  1 unidad de
# azúcar, manteniendo solo las columnas "Cereal.name", "Calories" y 
# "Vitamins.and.Minerals".

