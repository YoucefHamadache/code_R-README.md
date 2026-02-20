# Préparer les données
Year <- MM$Year
Inflow_LH <- MM$x_LH * 100
Inflow_HS <- MM$x_HS * 100
Inflow_SC <- MM$x_SC * 100
Inflow_C <- MM$x_C * 100

# Fonction pour nettoyer les données
clean_data <- function(year, ...){
  df <- data.frame(year, ...)
  df <- df[complete.cases(df), ]
  return(df)
}

cleaned_data <- clean_data(Year, Inflow_C, Inflow_HS, Inflow_LH, Inflow_SC)

Year <- cleaned_data$year
Inflow_C <- cleaned_data$Inflow_C
Inflow_HS <- cleaned_data$Inflow_HS
Inflow_LH <- cleaned_data$Inflow_LH
Inflow_SC <- cleaned_data$Inflow_SC

# Appliquer loess pour lisser les courbes
loess_IC <- loess(Inflow_C ~ Year, span = 0.2, na.action = na.exclude)
loess_IHS <- loess(Inflow_HS ~ Year, span = 0.2, na.action = na.exclude)
loess_ISC <- loess(Inflow_SC ~ Year, span = 0.2, na.action = na.exclude)
loess_ILH <- loess(Inflow_LH ~ Year, span = 0.2, na.action = na.exclude)

liss_C <- predict(loess_IC, newdata = data.frame(Year = Year))
liss_HS <- predict(loess_IHS, newdata = data.frame(Year = Year))
liss_SC <- predict(loess_ISC, newdata = data.frame(Year = Year))
liss_LH <- predict(loess_ILH, newdata = data.frame(Year = Year))

# Tracer les courbes lissées
plot(Year, Inflow_LH, type = "n", ylim = range(c(liss_C, liss_SC, liss_HS, liss_LH), na.rm = TRUE), 
     xlab = "Année", ylab = "Inflow", main = "Inflow during the years")

lines(Year, liss_C, col = "blue", lwd = 2)
lines(Year, liss_SC, col = "purple", lwd = 2)
lines(Year, liss_LH, col = "yellow", lwd = 2)
lines(Year, liss_HS, col = "green", lwd = 2)

# Ajouter une légende
legend("topright", legend = c("College", "Some College", "Less than High School", "High School"), 
       col = c("blue", "purple", "yellow", "green"), lty = 1, lwd = 2)