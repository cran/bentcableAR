\name{cable.ar.p.diag}
\alias{cable.ar.p.diag}
\title{ Bent-Cable AR(p>0) Diagnostics }
\description{
	ACF, PACF, and other plots are produced for diagnosing an AR(p)
	bent-cable fit when p>0.
}
\usage{
cable.ar.p.diag(ar.p.fit, resid.type = "p", xlab = "time", ylab = "",
	main = NULL, main.all = NULL, ctp.ci = NULL)
}
\arguments{
	\item{ar.p.fit}{ A \code{cable.ar.p.iter} object for AR(p) data, p>0. }
	\item{resid.type}{ A \code{type} argument for the \code{plot}
		function; used to control the way fitted residuals and
		innovations are displayed. Default is \code{"p"} for
		\emph{points}. }
	\item{xlab}{ Character string: x-axis label. }
	\item{ylab}{ Character string: y-axis label. }
	\item{main}{ Character string: title for the time series plot. }
	\item{main.all}{ Character string: title for the entire set of
		plots. }
	\item{ctp.ci}{ A \code{cable.change.conf} object. }
}
\details{
	This function splits the plotting canvas into several panels. For
	one panel, \code{ar.p.fit} is fed to \code{cable.ar.p.plot} that
	produces a scatterplot of the data and overlays on it the fitted
	bent cable with the estimated transition. The optioinal
	\code{ctp.ci} is also fed to \code{cable.ar.p.plot} to add the
	CTP confidence interval to the same panel. Additionally,
	\code{ar.p.fit} is fed to \code{cable.ar.p.resid} to extract the
	fitted residuals and innovations, which are then plotted in
	separate panels that again show the estimated transition and
	confidence interval. Finally, four panels show ACF and PACF
	diagnostics for the fitted residuals and innovations, via the
	built-in \R functions \code{acf} and \code{pacf}.
}
\references{ See the \code{\link{bentcableAR}} package references. }
\author{ Grace Chiu }
\note{
	This function is intended for internal use by \code{bentcable.ar}.
}
\section{Warning}{
	See the warnings from \code{\link{cable.ar.p.plot}} and
	\code{\link{cable.ar.p.resid}}. }
\seealso{ \code{\link{cable.lines}}, \code{\link{plot}}, \code{\link{par}},
	\code{\link{acf}}, \code{\link{pacf}} }
\examples{
data(sockeye)

# AR(2) cable fit
fit.ar2 <- cable.ar.p.iter( c(13,.1,-.5,11,4,.5,-.5),
	sockeye$logReturns, tol=1e-4 )
cable.ar.p.diag( fit.ar2, main="bent cable", main.all="Sockeye",
	ctp.ci=cable.change.conf( fit.ar2, .9 ) )
		# compare to this:
		# fit.ar2 <- bentcable.ar( sockeye$logReturns,
		#	init.cable=c(13,.1,-.5,11,4), p=2, main="Sockeye bent cable",
		#	ci.level=.9 )

# AR(4) stick fit
fit.ar4 <- cable.ar.p.iter( c(13,.1,-.5,11,.5,-.5,.5,-.5),
	sockeye$logReturns, tol=1e-4, stick=TRUE )
cable.ar.p.diag( fit.ar4, ctp.ci=cable.change.conf( fit.ar4, .95 ) )
		# compare to this:
		# fit.ar4 <- bentcable.ar( sockeye$logReturns,
		#	init.cable=c(13,.1,-.5,11), p=4, stick=TRUE )
}
\keyword{ dplot }
\keyword{ ts }
\keyword{ models }
\keyword{ regression }
\keyword{ nonlinear }
