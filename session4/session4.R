################################################################################
# Título: Sesión práctica 4                                                    #
# Curso: El poder para explotar tus datos                                      #
# Fecha: 13/11/2024                                                            #
#                                                                              #
# Autor: Adrián Santiago                                                       #
# Descripción: session4.R es parte de un curso de iniciación a R impartido por #
#              la UCAIB Bioinformática y Bioestadística del IMIBIC.            # 
################################################################################

library(ggplot2)


## Función plot()
################################################################################

data(iris)

View(iris)

# Se guardan las columnas de interés en nuevos objetos
petal.length <- iris$Petal.Length
petal.width <- iris$Petal.Width

# Diagrama de dispersión (x e y numéricos)
plot(petal.length, petal.width)
plot(petal.length, petal.width, pch = 6) # Consultar otros parámetros


plot(petal.length, petal.width, pch = 6, col = "red") 
# Fuente (colores para plots en R): https://r-charts.com/colors/

speciesID <- as.numeric(iris$Species) # Los ID de pch son numéricos  
speciesID
plot(petal.length, petal.width, pch = speciesID, col = "green")


plot(petal.length, petal.width, pch = speciesID, col = speciesID)



# Personalización del plot
plot(petal.length, petal.width,           # x e y
     pch = speciesID,                     # Tipos de símbolos
     col = speciesID,                     # Color
     xlab = "Petal length (cm)",          # Nombre para el eje X
     ylab = "Petal width (cm)",           # Nombre para el eje y
     main = "Petal width vs. length"      # Título
) 



legend("topleft",            # Posición de la leyenda
       levels(iris$Species), # Valores diferentes en la columna Species
       pch = 1:3,            # Símbolos que usará
       col = 1:3             # Colores que usará
) 


# Matriz de correlación
plot(iris[, c(1:4)])
pairs(iris[,1:4], pch=as.numeric(iris$Species), col=iris$Species)


## Función ggplot()
################################################################################

## Dataset iris

ggplot(data = iris) # ¿Qué muestra? ¿Por qué?


ggplot(data = iris) +
    aes(x = Petal.Length, y = Petal.Width)  # ¿Y ahora?


ggplot(data = iris) +
    aes(x = Petal.Length, y = Petal.Width) +
    geom_point()


ggplot(data = iris) +
    aes(x = Petal.Length, y = Petal.Width) +
    geom_point(aes(color = Species, shape = Species))

p <- ggplot(data = iris) +
    aes(x = Petal.Length, y = Petal.Width) +
    geom_point(aes(color = Species, shape = Species), size = 2.5) +
    theme(
        axis.title = element_text(size = 14),   # Aumenta el tamaño de los títulos de los ejes
        axis.text = element_text(size = 14),    # Aumenta el tamaño de los valores en los ejes
        legend.text = element_text(size = 14)   # Aumenta el tamaño de la leyenda
    ) 

p + ggtitle("Petal widht vs. length") +
    xlab("Petal length (cm)") + ylab("Petal width (cm)")# +
  #  theme(plot.title = element_text(hjust = 0.5)) # Centrar el título





p_v2 <- ggplot(data = iris) +
    aes(x = Petal.Length, y = Petal.Width) +
    geom_point(aes(color = Species, shape = Species), size = 2.5) +
    theme(
        axis.title = element_text(size = 14),   
        axis.text = element_text(size = 14),   
        legend.text = element_text(size = 14)   
    ) +
    facet_wrap(~Species)  # Divide por la variable 'Species'

p_v2 + ggtitle("Petal widht vs. length") +
       xlab("Petal length (cm)") + ylab("Petal width (cm)")




ggplot(data = iris) +
  aes(x = Petal.Length, y = Petal.Width) +
  geom_point(aes(color = Species, shape = Species), size = 2.5) +
  theme(
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 14),
    legend.text = element_text(size = 14)
  ) +
  facet_wrap(~Species) +
  geom_smooth(method = "lm", 
              aes(color = Species), se = FALSE)  # Añade una línea de regresión 
                                                 # lineal sin intervalos de confianza

# add trend line
ggplot(data = iris) +
    aes(x = Petal.Length, y = Petal.Width) +
    geom_point(aes(color = Species, shape = Species)) +
    geom_smooth(method = lm)


ggplot(data = iris) +
    aes(x = Species, fill = Species) +
    geom_bar() +
    coord_polar()  # Convierte el gráfico a coordenadas polares (gráfico de sectores)



library(ggplot2)
ggplot(data = iris) +
    aes(x = Species, y = Sepal.Length, color = Species) +
    geom_boxplot()


ggplot(data = iris) +
    aes(x = Species, y = Sepal.Length, color = Species) +
    geom_boxplot() +
    geom_jitter(position = position_jitter(0.2)) #+ theme_minimal()




# Ejercicio complementario
################################################################################

# 1. Carga el dataset diabetes.csv y visualizalo
# Columna Outcome: 0 (mujeres no diabéticas), 1 (mujeres diabéticas)






# 2. Haz un diagrama de dispersión (scatterplot) de las variables "Glucose"
# e "Insulin"
# Nota: convierte previamente la columna Outcome a clase "Factor" con 
# la función as.factor()






# 3. Haz un histograma de la variable "Glucose" distinguiendo entre diabéticas 
# y no diabéticas (columna Outcome)






# 4. Haz dos boxplots, uno para la variable"Glucose" distinguiendo entre diabéticas 
# y no diabéticas (columna outcome) y otra con la variable IMC

