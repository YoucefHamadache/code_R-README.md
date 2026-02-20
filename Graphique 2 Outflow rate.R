Year <- MM$Year
Outflow_LH <- MM$ft_LH * 100
Outflow_HS <- MM$ft_HS * 100
Outflow_SC <- MM$ft_SC * 100
Outflow_C <- MM$ft_C * 100

clean_data <- function(year, ...){
  df <- data.frame(year, ...)
  df <- df[complete.cases(df), ]
  return(df)
}

cleaned_data <- clean_data(Year, Outflow_LH, Outflow_HS, Outflow_SC, Outflow_C)

Year <- cleaned_data$year
Outflow_LH <- cleaned_data$Outflow_LH
Outflow_HS <- cleaned_data$Outflow_HS
Outflow_SC <- cleaned_data$Outflow_SC
Outflow_C <- cleaned_data$Outflow_C


loess_TLH <- loess(Outflow_LH ~ Year, span = 0.2, na.action = na.exclude)
loess_TC <- loess(Outflow_C ~ Year, span = 0.2, na.action = na.exclude)
loess_TSC <- loess(Outflow_SC ~ Year, span = 0.2, na.action = na.exclude)
loess_THS <- loess(Outflow_HS ~ Year, span = 0.2, na.action = na.exclude)

smoothed_TLH <- predict(loess_TLH, newdata = data.frame(Year=Year))
smoothed_THS <- predict(loess_THS, newdata = data.frame(Year=Year))
smoothed_TC <- predict(loess_TC, newdata = data.frame(Year=Year))
smoothed_TSC <- predict(loess_TSC, newdata = data.frame(Year=Year))

plot(Year, Outflow_LH, type = "n", ylim = range(c(smoothed_TLH, smoothed_THS, smoothed_TC, smoothed_TSC), na.rm = TRUE), xlab = "Année", ylab = "Outflow", main = "Outflow during the years")
lines(Year, smoothed_TLH, col = "blue", lwd = 2)
lines(Year, smoothed_THS, col = "purple", lwd = 2)
lines(Year, smoothed_TSC, col = "yellow", lwd = 2)
lines(Year, smoothed_TC, col = "green", lwd = 2)

legend("topright", legend = c("Less than High School", "High School", "Some College", "College"), col = c("blue", "purple", "yellow", "green"), lty = 1, lwd = 2)
