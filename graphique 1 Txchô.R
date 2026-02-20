Year <- MM$Year
TxchoSC <- MM$TxchôSC
TxchoHS <- MM$TxchôHS
TxchoC <- MM$TxchôC
TxchoLH <- MM$TxchôLH

loess_SC <- loess(TxchoSC ~ Year, span = 0.2)
loess_HS <- loess(TxchoHS ~ Year, span = 0.2)
loess_C <- loess(TxchoC ~ Year, span = 0.2)
loess_LH <- loess(TxchoLH ~ Year, span = 0.2)


smoothed_SC <- predict(loess_SC)
smoothed_HS <- predict(loess_HS)
smoothed_C <- predict(loess_C)
smoothed_LH <- predict(loess_LH)

plot(Year, TxchoSC, type = "n", ylim = range(c(TxchoSC, TxchoHS, TxchoC, TxchoLH)), xlab = "Année", ylab = "Taux de chômage", main = "Taux de chômage par année")
lines(Year, smoothed_SC, col = "blue", lwd = 2)
lines(Year, smoothed_HS, col = "purple", lwd = 2)
lines(Year, smoothed_C, col = "red", lwd = 2)
lines(Year, smoothed_LH, col = "green", lwd = 2)

legend("topright", legend = c("TxchôSC", "TxchôHS", "TxchôC", "TxchôLH"), col = c("blue", "purple", "red", "green"), lty = 1, lwd = 2)