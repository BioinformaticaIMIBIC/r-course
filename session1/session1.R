################################################################################
# Título: Sesión práctica 1                                                    #
# Curso: El poder para explotar tus datos                                      #
# Fecha: 03/11/2025                                                            #
# Objetivo: Primeros pasos con R, estructuras de datos y operaciones básicas   #
#                                                                              #
# Ponente: Adrián Santiago                                                     #
# Descripción: session1.R es parte de un curso de iniciación a R impartido por #
#              la UCAIB Bioinformática y Bioestadística del IMIBIC.            #
################################################################################



## 🚀 ¡COMENZAMOS!
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 📂 Directorio de trabajo (working directory)
# Comprueba el directorio actual:
getwd()

# Establece tu propio directorio (modifica la ruta según corresponda)
# setwd("C:/Users/TuUsuario/Documents")

# 📦 Instalación y carga de paquetes
# La instalación solo es necesaria una vez; la carga se hace en cada sesión.
install.packages("readxl")  # Instala el paquete 'readxl' (para archivos Excel)
library(readxl)              # Carga el paquete en memoria


## 📊 Importar datasets
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 💡 ¿Qué hace el comando "read.csv"? ¿Qué parámetros acepta?
?read.csv

# Ejemplo: importar el dataset iris desde un archivo CSV
iris <- read.csv(file = "iris.csv", header = TRUE, sep = ",", dec = ".")
dim(iris)      # Muestra el número de filas y columnas
View(iris)     # Abre una vista tipo Excel

# Otro método para leer archivos de texto
?read.table
input_csv <- read.table("iris.csv", header = TRUE, sep = ",", dec = ".")

# 🧩 Ejercicio 1. Importa el dataset "titanic.csv"

# titanic <- ...


# Leer datos desde Excel (.xlsx)
input_xlsx <- read_excel("iris_dataset.xlsx")
View(input_xlsx)


## Operadores en R
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Aritméticos
# Ejercicio 2. Calcula el IMC de un paciente de 68 kg y 1.70 metros.




# Ejercicio 3. Calcula el crecimiento exponencial de una población bacteriana
#  Pobl_ini: 1e6
#  Tasa de crecimiento (r): 0.3
#  Tiempo transcurrido: 5h

   
   

# Relacionales y lógicos
vector <- c(1, 3, 5, 7, 9)
#  |
#  Sigue los ejemplos de la presentación
vector > 3



## 📦 Operaciones con vectores
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Asignación de variables
x <- 1
x
x <- 3
x
class(x)


# Pongamos a prueba a R...
x_v2 <- as.character(3)
x_v2
class(x_v2)

x + "cuatro"      # ¿Qué ocurre?
class("cuatro")

y <- c(1:10)
class(y)

# Operaciones con vectores
x + y

x_v2 + y

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

# Secuencias y operaciones
y <- 1:10
x + y
z <- x * y
z

# Indexación de vectores
z[4]          # Elemento 4
z[1:3]        # Elementos 1 al 3
z[-1]         # Todos menos el primero
z[c(-1, -2)]  # Elimina los dos primeros
length(z)     # Número de elementos


(n <- matrix(data = 4:12,
          nrow = 3,
          ncol = 3, byrow = TRUE)) # Por columnas (parámetro byrow)



## 🧮 Operaciones con matrices
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Crear una matriz
m <- matrix(data = 1:9, nrow = 3, ncol = 3)
m

# 🧩 Ejercicio 4. Crea una matriz (p) con la secuencia del 1 al 20
# de 4 filas y 5 columnas

# p <- ...


# Casos con diferentes números de elementos:
matrix(1:12, nrow = 5, ncol = 4)  
matrix(1:12, nrow = 2, ncol = 5)

# Añadir filas y columnas
new_row <- c(5, 10, 15)
rbind(m, new_row)

# 🧩 Ejercicio 5. Añade una nueva fila inventada a la matriz "m"



new_col <- c(7, 14, 21)
cbind(m, new_col)

# Crear matriz por columnas (byrow = FALSE por defecto)
(n <- matrix(4:12, nrow = 3, ncol = 3))

# Operaciones entre matrices
m + n
m * n
m ^ 2
m / 2
t(n)     # Transponer matriz

# Multiplicación matricial
# (o <- matrix(6:1, nrow = 3, ncol = 2))
# n %*% o



## 🧾 Operaciones con DataFrames
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

df <- as.data.frame(n)
View(df)

head(df)
dim(df)

# ¿Cómo se llaman las columnas?
colnames(df)
colnames(df) <- c("Columna_1", "Columna_2", "Columna_3")
df

# ¿Cómo se llaman las filas?
rownames(df)
rownames(df) <- c("Fila_1", "Fila_2", "Fila_3")

# Acceso por índices o nombres
df[, 1]           # Primera columna
df[2, ]           # Segunda fila
df["Fila_2", ]    # Fila por nombre
df[2, c(1, 2)]    # Fila 2, columnas 1 y 2

# Sobreescribir elemento(s) del DataFrame
df[2, ] <- c(-3, -6, -9)
df[2, ] <- c(-3, -7) 
df

# Filtrado con condiciones
df[df$Columna_1 > 5, ]     # El simbolo "$" permite indexar una columna 
                           # por su nombre


# 🧩 Ejercicio 6. Cambia los nombres de las columnas del dataframe iris
# por "Sepalo_Largo", "Sepalo_Ancho", "Petalo_Largo", "Petalo_Ancho", "Especie"
data(iris)


## 📚 Operaciones con listas
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

mi_lista <- list(
    "objeto1" = 7,
    "objeto2" = "21",
    "objeto3" = as.factor(3),
    "objeto4" = matrix(1:4, nrow = 2)
)

mi_lista

mi_lista["objeto2"]
mi_lista[["objeto2"]]

mi_lista["objeto1", "objeto2"] # ¿Qué ha pasado?
mi_lista[c("objeto1", "objeto2")]

# Añadir y eliminar elementos
mi_lista["objeto5"] # ¿Por qué devuelve null?
mi_lista

mi_lista[[5]] <- data.frame(X = c(5, 2, 3), Y = c(7, 2, 9))
mi_lista[[3]] <- NULL # mi_lista[-3] es equivalente
mi_lista



## 🧠 Ejercicios complementarios
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Vamos a trabajar con un dataset de pruebas diagnósticas de COVID-19.
install.packages("medicaldata")

# 1. Carga el paquete medicaldata e importa el dataset covid_testing.


# 2. Visualiza el dataset y su estructura (nombres de columnas, filas, 
# dimensiones y tipos de variables).


# 3. Muestra las primeras y últimas filas del dataset.


# 4. Crea una nueva columna llamada "total_tat" que sea la suma de las columnas
# "col_rec_tat" y "rec_ver_tat" (tiempo total del proceso en horas).


# 5. Crea un nuevo data.frame llamado "positivos" que recoja solo las filas del 
# dataset cuyo resultado haya sido "positive".


# 6. Crea otro data.frame llamado "negativos" con las filas cuyo resultado haya 
# sido "negative".


# 7. Crea un nuevo data.frame llamado "tardio" que recoja solo las filas en las que
# el tiempo total de proceso (total_tat) haya sido superior a 24 horas.


# 8. Crea un data.frame "adultos_clientes" que contenga solo los sujetos cuyo
# demo_group sea "client" o "misc adult".


# 9. Crea un nuevo data.frame "sospechosos" con los registros cuyo resultado sea "invalid"
# y mantén solo las columnas "subject_id", "clinic_name" y "col_rec_tat".


# 10. Encuentra al último descendiente Targaryen varón, nonato (edad = 0) y 
# con resultado positivo

