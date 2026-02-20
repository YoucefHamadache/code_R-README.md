# Initialiser un vecteur pour stocker les valeurs de x
solutions <- numeric(length(MM$ft))
# Parcourir chaque ligne de MM
for (i in 1:length(MM$ft)) {
  # Exclure les lignes où Ut1 est NA
  if (!is.na(MM$Ut1[i])) {
    # Définir la fonction pour cette ligne
    equation <- function(x) {
      (1 - exp(-MM$ft[i] - x) )* x / (MM$ft[i] + x) * MM$Labourforce[i] + exp(-MM$ft[i] - x) * MM$All_individuals.1[i] - MM$Ut1[i]
    }
    # Trouver la solution de l'équation pour cette ligne
    solutions[i] <- uniroot(equation, interval = c(0, 1e6))$root
  } else {
    # Si Unemployed_ST1 est NA, attribuer NA à la solution
    solutions[i] <- NA
  }
}
print(solutions)




###              1. Less_Than_High_School                                 ###

MM$Labourforce_LH = MM$Less_than_high_school.1+ MM$Less_than_high_school

solutions_LH <- numeric(length(MM$ft_LH))
for (i in 1:length(MM$ft_LH)) {
  if (!is.na(MM$U_LH.t1[i])){
    equation_LH <- function(x) {
      (1 - exp(-MM$ft_LH[i] - x) )* x / (MM$ft_LH[i] + x) * MM$Labourforce_LH[i] + exp(-MM$ft_LH[i] - x) * MM$Less_than_high_school.1[i] - MM$U_LH.t1[i]
    }
  solutions_LH[i] <- uniroot(equation_LH, interval = c(0, 1e6))$root
} else {
  solutions_LH[i] <- NA
}
}

print(solutions_LH)

MM$x_LH  <- solutions_LH


###             2.High_School                                             ###


MM$Labourforce_HS = MM$High_school.1+MM$High_school

solutions_HS <- numeric(length(MM$ft_HS))
for (i in 1:length(MM$ft_HS)) {
  if (!is.na(MM$U_HS.t1[i])){
    equation_HS <- function(x) {
      (1 - exp(-MM$ft_HS[i] - x) )* x / (MM$ft_HS[i] + x) * MM$Labourforce_HS[i] + exp(-MM$ft_HS[i] - x) * MM$High_school.1[i] - MM$U_HS.t1[i]
    }
    solutions_HS[i] <- uniroot(equation_HS, interval = c(0, 1e6))$root
  } else {
    solutions_HS[i] <- NA
  }
}

print(solutions_HS)

MM$x_HS  <- solutions_HS



###             3.Some_College                                              ###


MM$Labourforce_SC = MM$Some_college.1 + MM$Some_college

solutions_SC <- numeric(length(MM$ft_SC))
for (i in 1:length(MM$ft_SC)) {
  if (!is.na(MM$U_SC.t1[i])){
    equation_SC <- function(x) {
      (1 - exp(-MM$ft_SC[i] - x) )* x / (MM$ft_SC[i] + x) * MM$Labourforce_SC[i] + exp(-MM$ft_SC[i] - x) * MM$Some_college.1[i] - MM$U_SC.t1[i]
    }
    solutions_SC[i] <- uniroot(equation_SC, interval = c(0, 1e6))$root
  } else {
    solutions_SC[i] <- NA
  }
}

print(solutions_SC)

MM$x_SC  <- solutions_SC



###             4. College                                                ###



MM$Labourforce_C = MM$College.1 + MM$College

solution_C <- numeric(length(MM$ft_C))
for (i in 1:length(MM$ft_C)) {
  if (!is.na(MM$U_C.t1[i])){
    equation_C <- function(x){
      (1 - exp(-MM$ft_C[i] - x) )* x / (MM$ft_C[i] + x) * MM$Labourforce_C[i] + exp(-MM$ft_C[i] - x) * MM$College.1[i] - MM$U_C.t1[i]
    }
    solution_C [i] <- uniroot(equation_C, interval =c(0, 1e6) )$root
    
  }else{
    solution_C[i] <-NA
  }
}

print(solution_C)


MM$x_C <- solution_C





