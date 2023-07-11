require(geoR)
require(ggplot2)
set.seed(362)

# Read data
data <- read.csv("C:\\Users\\amika\\OneDrive\\Documents\\R
                 Stats\\GrandBanks_Dec_1997.csv")
gdata <- as.geodata(data,coords.col=2:3,data.col=6)
dup <-dup.coords(gdata)
gdata2 <- jitterDupCoords(gdata,max=0.1,min=0.05)

# Plot data
par(mfrow=c(1,1))
plot(gdata2)

# Remove data that seem like outliers
data <- read.csv("C:\\Users\\amika\\OneDrive\\Documents\\R
                 Stats\\GrandBanks_Dec_1997.csv")[-
                                                    c(36,216,339,366,395,481,485,562,609,664,678,687,742,748,822,843,1151,1188,1192,1195
                                                      ,1211,1226,1272,1290,1311),]
gdata <- as.geodata(data,coords.col=2:3,data.col=6)
dup <-dup.coords(gdata)
gdata2 <- jitterDupCoords(gdata,max=0.1,min=0.05)

# Plot new data
par(mfrow=c(1,1))
plot(gdata2)

# Plot variogram
plot(variog(gdata2,option='bin'))

# Check for isotropy, with addition of trend
plot(variog4(gdata2))
par(mfrow=c(1,2))
plot(variog4(gdata2, trend = "1st"))
plot(variog4(gdata2, trend = "2nd"))

# Determine which spatial model to fit; Gausian Processes are used to model data and Maximum Likelihood (ML) for parameter 
# estimation
## (0) Exponential without trend, 0 nugget and data is isotropic
fit_mle0 <- likfit(gdata2,
                   fix.nugget=FALSE,nugget=0,
                   cov.model="exponential",
                   ini = c(45,12))
## (1) Exponential without trend and data is isotropic
fit_mle1 <- likfit(gdata2,
                   fix.nugget=FALSE,nugget=1.5,
                   cov.model="exponential",
                   ini = c(45,12))
## (2) Exponential without trend and data is anisotropic
fit_mle2 <- likfit(gdata2,
                   fix.nugget=FALSE,nugget=2,
                   cov.model="exponential",
                   fix.psiA = FALSE, psiA = pi/4,
                   fix.psiR = FALSE, psiR = 2,
                   ini = c(45,4))
## (3) Exponential with linear trend and data is anisotropic
fit_mle3 <- likfit(gdata2,
                   fix.nugget=FALSE,nugget=1.5, trend = "1st",
                   cov.model="exponential",
                   fix.psiA = FALSE, psiA = pi/2,
                   fix.psiR = FALSE, psiR = 4,
                   ini = c(45,4))
## (4) Exponential with non-linear trend and data is anisotropic
fit_mle4 <- likfit(gdata2,
                   fix.nugget=FALSE,nugget=1.5, trend = "2nd",
                   cov.model="exponential",
                   fix.psiA = FALSE, psiA = pi/2,
                   fix.psiR = FALSE, psiR = 4,
                   ini = c(25,2))
## (5) Matern, kappa 1.5, with non-linear trend, 1.5 nugget and data is anisotropic
fit_mle5 <- likfit(gdata2,
                   fix.nugget=FALSE,nugget=2, trend = "2nd",
                   cov.model="matern", kappa=1.5,
                   fix.psiA = FALSE, psiA = pi/2,
                   fix.psiR = FALSE, psiR = 4,
                   ini = c(25,2))
## (6) Matern, kappa 0.4, with non-linear trend, 1.5 nugget and data is anisotropic
fit_mle6 <- likfit(gdata2,
                   fix.nugget=FALSE,nugget=2, trend = "1st",
                   cov.model="matern", kappa=0.4,
                   fix.psiA = FALSE, psiA = pi/2,
                   fix.psiR = FALSE, psiR = 4,
                   ini = c(25,2))

# Plot variogram with ml estimation of best fit model (fit_mle5 seemed the best as it had the lowest AIC value)
plot(variog(gdata2,max.dist = 2))
lines(fit_mle5)

# Plot expected value for estimated parameters
ex.grid <- as.matrix(expand.grid(seq(-60,-50,l=21), seq(40,50,l=21)))
pred.grid <- expand.grid(seq(-60, -50, l = 21), seq(40, 50, l = 21))
kc <- krige.conv(gdata2, loc = pred.grid, krige = krige.control(obj.m = fit_mle5))
image(kc, loc = pred.grid, xlab = "Coord X", ylab = "Coord Y")

# Validate ml model
xv.ml <- xvalid(gdata2, model = fit_mle5)
par(mfcol = c(5, 2), mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.7, 0))
plot(xv.ml)

# The first row displays two probability plots: a Q-Q plot and a P-P plot. Both plots show most points clustered around a 
# straight line, indicating that our model fits the data well.
# The second row shows geographical plots of Leave One Out (LOO) residuals. Positive residuals are marked as red crosses, 
# and negative residuals as blue pluses. Some clusters of residuals appear to have linear patterns.
# The third row presents histogram plots of the residuals and standardised residuals, indicating approximate Normal 
# distributions.
# In the fourth and last row, plots of residuals and standardised residuals against predicted values and actual data 
# show deviations from the 95% Confidence Intervals, suggesting potential overconfidence and high variance in parameter 
# estimation. Further analysis is needed to confirm this theory.
