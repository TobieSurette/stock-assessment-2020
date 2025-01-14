library(gulf.data)
library(gulf.graphics)

language <- language("en")

x <- read.csv("programs/recruitment/Bayesian Recruitment Model Output.csv")

if (language == "english") file <- "results/figures/english/recruitment/bayesian.recruitment.figure"
if (language == "french")  file <- "results/figures/français/recrutement/bayesian.recruitment.figure"

gdevice("pdf", file = file, width = 8.5, height = 10)

m <- kronecker(matrix(1:4), matrix(1, nrow = 4, ncol = 7))
m <- rbind(0, cbind(0, m, 0), 0, 0)
layout(m)
par(mar = c(0, 0, 0, 0))
xlim <- c(1994, 2023)
for (i in 1:4){
   ylab <- paste0("R", i)
   if (i == 1){
      ylim <- c(0, 120)
      yat <- seq(0, ylim[2], by = 20)
      ylab <- paste0(ylab, " (x 1000 t)")
   }
   if (i == 2){
      ylim <- c(0, 250)
      yat <- seq(0, 200, by = 50)
      ylab <- paste0(ylab, " (millions)")
   }
   if (i == 3){
      ylim <- c(0, 300)
      yat <- seq(0, 250, by = 50)
      ylab <- paste0(ylab, " (millions)")
   }
   if (i == 4){
      ylim <- c(0, 350)
      yat <- seq(0, 300, by = 100)
      ylab <- paste0(ylab, " (millions)")
   }

   xx <- x[x$variable == paste0("R", i), ]
   plot(xlim, ylim, type = "n", xlab = "", ylab = "", xaxs = "i", yaxs = "i", xaxt = "n", yaxt = "n")
   grid()
   index <- xx$year %in% 1997:2020
   lines(xx$year[index], xx$mean[index], lwd = 2)
   lines(xx$year[index], xx$lowerCI[index], lty = "dashed", lwd = 1)
   lines(xx$year[index], xx$upperCI[index], lty = "dashed", lwd = 1)

   index <- xx$year %in% 1994:1997
   if (sum(index) == 1) index <- NULL
   polygon(c(xx$year[index], rev(xx$year[index])), c(xx$lowerCI[index], rev(xx$upperCI[index])), col = "pink", border = "pink")
   lines(xx$year[index], xx$mean[index], lwd = 2, col = "red")
   lines(xx$year[index], xx$lowerCI[index], lwd = 1, lty = "dashed", col = "red")
   lines(xx$year[index], xx$upperCI[index], lwd = 1, lty = "dashed", col = "red")

   index <- xx$year %in% 2020:2023
   if (sum(index) == 1) index <- NULL
   polygon(c(xx$year[index], rev(xx$year[index])), c(xx$lowerCI[index], rev(xx$upperCI[index])), col = "pink", border = "pink")
   lines(xx$year[index], xx$mean[index], lwd = 2, col = "red")
   lines(xx$year[index], xx$lowerCI[index], lwd = 1, lty = "dashed", col = "red")
   lines(xx$year[index], xx$upperCI[index], lwd = 1, lty = "dashed", col = "red")

   axis(2, at = yat[seq(1, length(yat), by = 2)])
   axis(2, at = yat[seq(2, length(yat), by = 2)])

   mtext(ylab, 2, 3, cex = 1.0)
   box()
}
axis(1, at = seq(1994, 2024, 4), cex.lab = 1.35, las = 2)
axis(1, at = seq(1996, 2024, 4), cex.lab = 1.35, las = 2)
if (language == "french") mtext("Année", 1, 4.0, cex = 1.4) else mtext("Year", 1, 4.0, cex = 1.5)

dev.off()
