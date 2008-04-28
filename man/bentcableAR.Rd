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
Version: \tab 0.1\cr
Date: \tab 2008-04-28\cr
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
The package functions and examples have been thoroughly tested in \R
2.6.2 installed on the author's two Mac machines running OS X. Results
are known to vary depending on machine and platform.
}
\author{
Grace Chiu <bentcable@hush.com>

Maintainer: Grace Chiu <bentcable@hush.com>
}
\references{
Chiu, G. and Lockhart, R. (2006), "Bent-Cable Regression with AR(p)
	Noise: Preliminary Theory and Applications," in \emph{2006
	Proceedings of the American Statistical Association, Statistical
	Computing Section [CD-ROM]}, pp. 2027--2034. Alexandria, VA:
	American Statistical Association.
	\url{http://www.stats.uwaterloo.ca/~gchiu/Articles/jsmproceedings06.pdf}

Chiu, G. and Lockhart, R. (in progress), "Some Mathematical and
	Algorithmic Details for Bent-Cable Regression with AR(p) Noise,"
	Working Paper Series No. 2006-07, Department of Statistics and
	Actuarial Science, University of Waterloo.
	\url{http://www.stats.uwaterloo.ca/stats_navigation/techreports/06WorkingPapers/2006-07.pdf}

Chiu, G., Lockhart, R. and Routledge, R. (2006), Bent-Cable Regression
	Theory and Applications, \emph{Journal of the American Statistical
	Association}, \bold{101}, 542--553.
	\url{http://www.stats.uwaterloo.ca/~gchiu/Articles/bentcable-jasa.pdf}
}
\keyword{ package }
