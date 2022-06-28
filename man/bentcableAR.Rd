\name{bentcableAR}
\alias{bentcableAR}
\alias{bentcable}
\alias{bentcableAR-package}
\docType{package}
\title{ The Bent-Cable Regression Package }
\description{
	Perform bent-cable (including broken-stick) regression to independent
	data or autoregressive time series.
}
\details{
\tabular{ll}{
Package: \tab bentcableAR\cr
Type: \tab Package\cr
Version: \tab 0.3.1\cr
Date: \tab 2022-05-25\cr
License: \tab GPL (>=3)\cr
}
There are two main interfaces in this package:
\code{\link{bentcable.dev.plot}} for plotting profile deviance
surfaces, and \code{\link{bentcable.ar}} for fitting and diagnosing 
the regression. In some cases, confidence intervals for the
\emph{change point} are also computed..

Detailed documentation and examples are available on the function help
pages.

The major engines for \code{bentcable.dev.plot} are
\code{\link{cable.dev}} and \code{\link{cable.fit.known.change}}.
The computational engines for \code{bentcable.ar} are
\code{\link{cable.ar.p.iter}}, \code{\link{cable.ar.0.fit}},
\code{\link{stick.ar.0}}, and \code{\link{cable.change.conf}},
while the plotting engine is \code{\link{cable.ar.p.diag}}.
Although these and other \emph{lesser} functions are called
internally by the two main interfaces described above, they can be
used as stand-alone functions, and the user is advised to
refer to their documentation. Type
\code{library(help="bentcableAR")} for a full list of available
functions.

\bold{Disclaimer:}
The package functions and examples (including those provided as "not
run") up to V0.2.x were thoroughly tested in \R 2.6.2 installed on the
author's two Mac machines running OS X. Results are known to vary
depending on machine and platform. It is the author's intention to
distribute any future updates via GitHub.
}
\author{
Grace Chiu <bentcable@gmail.com>

Maintainer: Grace Chiu <bentcable@gmail.com>
}
\references{
Chiu, G.S. and Lockhart, R.A. (2010), Bent-Cable Regression with
   Autoregressive Noise, \emph{Canadian Journal of Statistics},
   \bold{38}, 386--407. DOI: 10.1002/cjs.10070. URL:  
	\url{https://www.researchgate.net/publication/227652258_Bent-cable_regression_with_autoregressive_noise}

Chiu, G., Lockhart, R. and Routledge, R. (2006), Bent-Cable Regression
	Theory and Applications, \emph{Journal of the American Statistical
	Association}, \bold{101}, 542--553. DOI: 10.1198/016214505000001177. URL:  
	\url{https://www.researchgate.net/publication/4742466_Bent-Cable_Regression_Theory_and_Applications}
}
\keyword{ package }
