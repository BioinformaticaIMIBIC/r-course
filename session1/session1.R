################################################################################
# Título:   Sesión práctica 1                                                  #
# Curso:    El poder para explotar tus datos                                   #
# Fecha:    27/10/2026                                                         #
# Objetivo: Primeros pasos con R, estructuras de datos y operaciones básicas   #
#                                                                              #
# Autor:    Adrián Santiago                                                    #
# Descripción: session1.R es parte de un curso de iniciación a R impartido por #
#              la UCAIB Bioinformática y Bioestadística del IMIBIC.            #
#                                                                              #
################################################################################


## 🚀 ¡COMENZAMOS!
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Estructura recomendada:
#   curso_R/
#   ├── session1.R
#   └── datasets/           <- iris.csv, titanic.csv, iris_dataset.xlsx
#
getwd()
#Ajusta el directorio de trabajo hasta el directorio "curso_R" con setwd()
?setwd()

# 📦 Instalación y carga de paquetes
# La instalación solo es necesaria una vez; la carga se hace en cada sesión.
# Este bloque instala únicamente los paquetes que falten:
paquetes <- c("tidyverse",    # readr, dplyr, ggplot2, tibble, tidyr...
              "readxl",       # leer archivos Excel
              "janitor",      # limpiar nombres de columnas
              "skimr",        # resúmenes rápidos de datos
              "medicaldata")  # datasets médicos de ejemplo

nuevos <- setdiff(paquetes, rownames(installed.packages()))
if (length(nuevos) > 0) install.packages(nuevos)

library(tidyverse)
library(readxl)
library(janitor)
library(skimr)
library(medicaldata)

# 💡 Cómo buscar ayuda (¡lo vais a usar constantemente!)
# ?read_csv            -> ayuda de una función

## 📊 Importar datasets
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Forma moderna: readr::read_csv() (más rápido, detecta tipos de columna y
# devuelve un tibble, un data.frame mejorado)
# 💡 ¿Qué parámetros acepta?
?read_csv

# ⚠️ Evitamos llamar al objeto "iris": pisaría el dataset que R ya trae
# incorporado. Usamos un nombre descriptivo.
iris_csv <- read_csv("datasets/iris_dataset.csv")
dim(iris_csv)     # Número de filas y columnas
View(iris_csv)    # Vista tipo Excel

# "Por debajo": las funciones de R base que hacen lo mismo
# (las veréis en muchísimo código antiguo)
iris_base <- read.csv("datasets/iris_dataset.csv", 
                      header = TRUE, 
                      sep = ",", 
                      dec = ".")

iris_tabla <- read.table("datasets/iris_dataset.csv", 
                         header = TRUE, 
                         sep = ",", 
                         dec = ".")
?read.csv
?read.table

# 💡 Atajo: rio::import() lee casi cualquier formato con una sola función
# (csv, xlsx, sav, dta, rds...). Solo hay que instalar 'rio' si os interesa.

# 🧩 Ejercicio 1. Importa el dataset "titanic.csv"

# titanic <- ...


# Leer datos desde Excel (.xlsx)
iris_xlsx <- read_excel("datasets/iris_dataset.xlsx")
View(iris_xlsx)

# Excel y nombres de columna: a menudo vienen con espacios, tildes, mayúsculas...
# janitor::clean_names() los convierte a un formato cómodo para programar.
ejemplo_df <- tibble("Edad (años)" = 1:3, 
                     "Peso Kg" = c(60, 72, 80), 
                     "ID Paciente" = 1:3)
names(ejemplo_df)
names(clean_names(ejemplo_df))


## 🔧 Operadores en R
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Aritméticos: + - * / ^ %% (resto) %/% (división entera)
5 + 3
7 %% 2
7 %/% 2

# 🧩 Ejercicio 2. Calcula el IMC de un paciente de 68 kg y 1.70 metros.
# (IMC = peso / altura^2). Guarda los datos en variables.



# 🧩 Ejercicio 3. Calcula el crecimiento exponencial de una población bacteriana
#  Pobl_ini: 1e6
#  Tasa de crecimiento (r): 0.3
#  Tiempo transcurrido: 5h
#  Fórmula: Pobl_final = Pobl_ini * exp(r * t)



# Relacionales (> < >= <= == !=) y lógicos (& | !)
vector <- c(1, 3, 5, 7, 9)
vector > 3
vector > 3 & vector < 9
vector %in% c(3, 9)       # ¿Pertenece cada elemento al conjunto?
which(vector > 3)         # ¿En qué posiciones se cumple?
sum(vector > 3)           # TRUE cuenta como 1: ¿cuántos cumplen?


## 📦 Operaciones con vectores
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Asignación de variables
x <- 1
x
x <- 3
x
class(x)

# Pongamos a prueba a R...
# 💡 try() muestra el error SIN detener el script (útil para mostrar errores)
x_v2 <- as.character(3)
x_v2
class(x_v2)

try(x + "cuatro")      # ¿Qué ocurre? Lee el mensaje de error
class("cuatro")

y <- 1:10
class(y)

# Operaciones con vectores
x + y                  # "Reciclaje": x se suma a cada elemento de y
try(x_v2 + y)          # ¿Y con un texto?

z <- x * y
z

# Indexando vectores
z[4]                   # Elemento 4
z[1:3]                 # Elementos 1 al 3
z[8:12]                # ¿Qué pasa al pedir posiciones que no existen?
length(z)              # ¿Cuántos elementos tengo?

z[-1]                  # Descarta el primer elemento
z[c(-1, -2)]           # Descarta los dos primeros
z[-(1:5)]              # Descarta del 1 al 5

# Valores perdidos (NA): omnipresentes en datos reales
edades <- c(25, 31, NA, 47, 52)
mean(edades)                  # ¿Por qué da NA?
mean(edades, na.rm = TRUE)    # Ignora los NA
is.na(edades)
sum(is.na(edades))            # ¿Cuántos NA hay?


## 🧮 Operaciones con matrices
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Rellenar por filas (byrow = TRUE) o por columnas (por defecto)
(n_filas <- matrix(data = 4:12, nrow = 3, ncol = 3, byrow = TRUE))
(m <- matrix(data = 1:9, nrow = 3, ncol = 3))

# 🧩 Ejercicio 4. Crea una matriz (p) con la secuencia del 1 al 20
# de 4 filas y 5 columnas

# p <- ...


# Casos con diferente número de elementos (fijaos en el aviso -warning-)
matrix(1:12, nrow = 5, ncol = 4)
matrix(1:12, nrow = 2, ncol = 5)

# Añadir filas y columnas
new_row <- c(5, 10, 15)
rbind(m, new_row)
?cbind


# Operaciones entre matrices
(n <- matrix(4:12, nrow = 3, ncol = 3))
m + n                  # Elemento a elemento
m * n                  # Elemento a elemento (NO es multiplicación matricial)
m^2
m / 2
t(n)                   # Transponer



## 🧾 Operaciones con DataFrames y tibbles
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

df <- as.data.frame(n)
View(df)

head(df)
dim(df)

# ¿Cómo se llaman las columnas y las filas?
colnames(df)
rownames(df)

# Renombrar: por NOMBRE (robusto) con rename()  ->  nuevo = antiguo
df <- df |> rename(Columna_1 = V1, Columna_2 = V2, Columna_3 = V3)
df

# En R base se hace por posición (frágil: si cambia el orden, se rompe sin avisar)
# colnames(df) <- c("Columna_1", "Columna_2", "Columna_3")
rownames(df) <- c("Fila_1", "Fila_2", "Fila_3")
df

# Acceso por índices o nombres (R base)
df[, 1]                # Primera columna
df[2, ]                # Segunda fila
df["Fila_2", ]         # Fila por nombre
df[2, c(1, 2)]         # Fila 2, columnas 1 y 2
df$Columna_1           # "$" indexa una columna por su nombre

# Sobreescribir elemento(s)
df[2, ] <- c(-3, -6, -9)
try(df[2, ] <- c(-3, -7))   # Error a propósito: longitud incorrecta
df

# Filtrado con condiciones: R base vs dplyr
df[df$Columna_1 > 5, ]                      # R base
df |> filter(Columna_1 > 5)                 # dplyr (lee como una frase)

# ⚠️ El filtrado en R base y los NA: ¡cuidado!
datos_na <- data.frame(id = c("a", "b", "c"), valor = c(1, NA, 7))
datos_na[datos_na$valor > 5, ]              # Aparece una fila de NA
datos_na |> filter(valor > 5)               # filter() descarta los NA

# El "pipe" |> pasa el resultado de la izquierda como primer argumento
# a la función de la derecha. Permite encadenar pasos de izquierda a derecha:
datos_na |>
    filter(!is.na(valor)) |>
    mutate(doble = valor * 2) |>
    select(id, doble)

# 🧩 Ejercicio 5. Cambia los nombres de las columnas del dataframe iris
# por "Sepalo_Largo", "Sepalo_Ancho", "Petalo_Largo", "Petalo_Ancho", "Especie"
# Pista: rename(nuevo = antiguo). Usa as_tibble(iris) como punto de partida.


# Visión general del dataframe
skim(iris_csv)

?rename
# as_tibble(iris)... 


# Mas ejemplos de las bondades del paquete dplyr
select(iris, -Species)
select(iris, 3:5)
select(iris, contains("Sepal"))

filter(iris, Sepal.Length >= 5.0 & Sepal.Width >= 4.0)
filter(iris, Sepal.Length < 5.0)

?mutate
iris |> 
    mutate(Sepal.Ratio = Sepal.Length/Sepal.Width, .keep = "used")

iris %>% 
    group_by(Species) %>% 
    summarize(sl_mean = mean(Sepal.Length), sw_mean = mean(Sepal.Width), 
              pl_mean = mean(Petal.Length), pw_mean = mean(Petal.Width))

## 📚 Operaciones con listas
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

mi_lista <- list(
    "objeto1" = 7,
    "objeto2" = "21",
    "objeto3" = as.factor(3),
    "objeto4" = matrix(1:4, nrow = 2)
)

mi_lista

mi_lista["objeto2"]     # Corchete simple: devuelve una LISTA con ese elemento
mi_lista[["objeto2"]]   # Corchete doble: devuelve el CONTENIDO del elemento
class(mi_lista["objeto2"])
class(mi_lista[["objeto2"]])

try(mi_lista["objeto1", "objeto2"])   # ¿Qué ha pasado? (las listas no tienen filas/columnas)
mi_lista[c("objeto1", "objeto2")]     # Así se seleccionan varios elementos

# Añadir y eliminar elementos
mi_lista["objeto5"]                   # ¿Por qué devuelve NULL? No existe todavía
mi_lista[["objeto5"]] <- data.frame(X = c(5, 2, 3), Y = c(7, 2, 9))
mi_lista[["objeto3"]] <- NULL         # mi_lista[-3] es equivalente (crea una copia)
mi_lista
names(mi_lista)
str(mi_lista)                         # Estructura compacta de cualquier objeto



## 🧠 Ejercicios complementarios
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Vamos a trabajar con un dataset de pruebas diagnósticas de COVID-19.
# install.packages("medicaldata")

# 1. Carga el dataset covid_testing del paquete medicaldata.


# 2. Visualiza el dataset y su estructura (nombres de columnas, filas,
#    dimensiones y tipos de variables).


# 3. Muestra las primeras y últimas filas del dataset.


# 4. Crea una nueva columna llamada "total_tat" que sea la suma de las columnas
#    "col_rec_tat" y "rec_ver_tat" (tiempo total del proceso en horas).


# 5. Crea un nuevo data.frame llamado "positivos" que recoja solo las filas del
#    dataset cuyo resultado haya sido "positive".


# 6. Crea otro data.frame llamado "negativos" con las filas cuyo resultado haya
#    sido "negative".


# 7. Crea un nuevo data.frame llamado "tardio" que recoja solo las filas en las
#    que el tiempo total de proceso (total_tat) haya sido superior a 24 horas.


# 8. Crea un data.frame "adultos_clientes" que contenga solo los sujetos cuyo
#    demo_group sea "client" o "misc adult".  Pista: %in%


# 9. Crea un nuevo data.frame "sospechosos" con los registros cuyo resultado sea
#    "invalid" y mantén solo las columnas "subject_id", "clinic_name" y
#    "col_rec_tat".  Pista: filter() y select()



# 10. Encuentra al último descendiente Targaryen varón, nonato (edad = 0) y
#     con resultado positivo.



## 📌 PARA SABER MÁS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# - R for Data Science (2e): https://r4ds.hadley.nz  (gratuito, en inglés)
# - Cheat sheets de RStudio: Help > Cheat Sheets