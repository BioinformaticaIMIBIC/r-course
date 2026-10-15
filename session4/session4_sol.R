################################################################################
# Título: Sesión práctica 4                                                    #
# Curso: El poder para explotar tus datos                                      #
# Fecha: 05/11/2026                                                            #
#                                                                              #
# Autor: Adrián Santiago                                                       #
# Descripción: session4.R es parte de un curso de iniciación a R impartido por #
#              la UCAIB Bioinformática y Bioestadística del IMIBIC.            # 
################################################################################
################################################################################


## Librerías
################################################################################

library(ggplot2)

install.packages("MedDataSets")
library(MedDataSets)

library(medicaldata)

install.packages("patchwork")


## Practica con el dataset heart_transplant_tbl_df
################################################################################


data(babies_tbl_df)

ggplot(data = babies_tbl_df) # ¿Qué muestra? ¿Por qué?


ggplot(data = babies_tbl_df) +
  aes(x = gestation, y = bwt) # ¿Y ahora?


ggplot(data = babies_tbl_df) +
  aes(x = gestation, y = bwt) +
  geom_point()
    

babies_tbl_df$parity <- as.factor(babies_tbl_df$parity)
ggplot(data = babies_tbl_df) +
       aes(x = gestation, y = bwt) +
       geom_point(aes(color = parity), size = 2) +
       theme(axis.title = element_text(size = 14),
             axis.text  = element_text(size = 14),
             legend.text = element_text(size = 14)) + 
       labs(title = "Estudio gestación vs tiempo",
            x = "Tiempo de gestación",
            y = "Peso del recien nacido (gramos)") +
            facet_wrap(~ parity)


ggplot(data = babies_tbl_df ) +
  aes(x = smoke, y = age) +
  geom_boxplot(aes(color = factor(smoke)))


ggplot(data = babies_tbl_df) +
  aes(x = smoke, y = age, color = factor(smoke)) +
  geom_boxplot() +
  geom_jitter(position = position_jitter(0.2))


valores_na <- is.na(babies_tbl_df$smoke)
ggplot(data = babies_tbl_df[!valores_na, ]) +
  aes(x = smoke, y = age, color = factor(smoke)) +
  geom_boxplot() +
  geom_jitter(position = position_jitter(0.2))


# Mejora con etiquetas
ggplot(data = babies_tbl_df) +
  aes(x = factor(smoke), y = age, color = factor(smoke)) +
  geom_boxplot() +
  scale_color_discrete(
    name = "Hábito de fumar",
    labels = c("No fuma", "Fuma")
  ) +
  labs(x = "Hábito de fumar", y = "Edad de la madre")



## Practica con el dataset indometh de medicaldata
################################################################################

data(indometh)

graficar_paciente <- function(df, subject_id) {
  
  df_filtrado <- subset(df, Subject == subject_id)
  
  ggplot(df_filtrado, aes(x = time, y = conc)) +
    geom_line(color = "steelblue", size = 1.2) +
    geom_point(color = "darkblue") +
    labs(
      title = paste("Perfil del paciente", subject_id),
      x = "Tiempo (h)",
      y = "Concentración (µg/mL)"
    ) +
    theme_minimal()
}

# 💡 Ejemplo:
plot1 <- graficar_paciente(indometh, "1")
plot2 <- graficar_paciente(indometh, "2")
plot3 <- graficar_paciente(indometh, "3")


## Combinación de gráficos con patchwork
################################################################################

# install.packages("patchwork")
library(patchwork)

(plot1 | plot2) / plot3


## Practica con el dataset strep_tb de medicaldata
################################################################################

data(strep_tb)

bxplot <- ggplot(strep_tb, aes(x = arm, y = rad_num, fill = arm)) +
  geom_boxplot() +
  labs(
    title = "Respuesta radiológica según grupo",
    x = "Grupo de estudio",
    y = "Puntuación radiológica (1 = peor, 6 = mejor)"
  )


hist <- ggplot(strep_tb, aes(x = baseline_condition, fill = improved)) +
  geom_bar(position = "fill") +
  facet_wrap(~ arm) +
  labs(
    title = "Porcentaje de mejora según condición basal y tratamiento",
    x = "Condición basal",
    y = "Proporción de pacientes mejorados"
  )


# Composición final
(plot1 | plot2 | plot3) / (bxplot | hist)


## Ejercicio complementario
################################################################################

# 🧩 Ejercicio 1. Carga el dataset diabetes.csv y visualízalo
# Columna Outcome: 0 (no diabéticas), 1 (diabéticas)

diabetes <- read.csv("X:/Documentos y Gestion UCAIB/cursoR/diabetes.csv")
View(diabetes)



# 🧩 Ejercicio 2. Diagrama de dispersión (Glucose vs Insulin) separando los dos grupos de
# en función a la variable Outcome

diabetes$Outcome <- as.factor(diabetes$Outcome)

plot_compl1 <- ggplot(diabetes,
                  aes(x = Glucose, y = Insulin, colour = Outcome)) +
                  geom_point() +
                  facet_wrap(~ Outcome)



# 🧩 Ejercicio 3. Histograma de la variable Glucose por Outcome
plot_compl2 <- ggplot(data = diabetes, aes(x = Glucose, fill = Outcome)) +
                  geom_histogram() +
                  labs(
                  title = "Distribución de Glucosa según Outcome",
                           x = "Glucosa") +
                  theme_minimal()



# 🧩 Ejercicio 4. Boxplots de Glucose y BMI por Outcome

plot_compl3 <- ggplot(data = diabetes, 
                      aes(x = Outcome, y = Glucose, fill = Outcome)) +
                      geom_boxplot() +
                      labs(title = "Boxplot de Glucosa por Outcome", 
                           x = "Outcome", y = "Glucosa") +
                      theme_minimal()

plot_compl4 <- ggplot(data = diabetes, 
                      aes(x = Outcome, y = BMI, fill = Outcome)) +
                      geom_boxplot() +
                      labs(title = "Distribución de IMC por Outcome", 
                           x = "Outcome", y = "IMC") +
                      theme_minimal()



# 🧩 Ejercicio 5. Muestra todos los gráficos en una misma visualización
# haciendo uso de patchwork
(plot_compl1 | plot_compl2) / (plot_compl3 | plot_compl4)








