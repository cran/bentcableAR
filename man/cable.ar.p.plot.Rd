\name{cable.ar.p.plot}
\alias{cable.ar.p.plot}
\title{ Plot Bent Cable AR(p) Fit Over Data }
\description{
	Plot the bent-cable AR(p) regression.
}
\usage{
cable.ar.p.plot(ar.p.fit, xlab = "time", ylab = "", main = NULL, ctp.ci = NULL)
}
\arguments{
  \item{ar.p.fit}{ A \code{cable.ar.p.iter} object for AR(p) data, p>0. }
  \item{xlab}{ Character string: x-axis label. }
  \item{ylab}{ Character string: y-axis label. }
  \item{main}{ Character string: plot title. }
  \item{ctp.ci}{ A \code{cable.change.conf} object. }
}
\details{
	The time series data and bent-cable / broken-stick fit are extracted 
	from the argument \code{ar.p.fit}. These data are then plotted, with
	the fitted regression superimposed in red. The estimated transition
	\eqn{\tau} and \eqn{\tau \pm \gamma} are also marked in red. The 
	optional \code{ctp.ci}, if provided, adds to the plot in blue the 
	confidence interval for the CTP (unique point at which the cable's 
	slope changes sign).
}
\references{ See the \code{\link{bentcableAR}} package references. }
\author{ Grace Chiu }
\note{
	This function is intended for internal use by \code{bentcable.ar}.
}
\section{Warning}{
	This function fails if \code{ar.p.fit} is from a non-AR(p>0) fit.
	For fits with independent data, use \code{cable.lines}. }
\seealso{ \code{\link{cable.lines}}, \code{\link{plot}},
	\code{\link{par}} }
\examples{
data(sockeye)

# AR(2) cable fit
fit.ar2 <- cable.ar.p.iter( c(13,.1,-.5,11,4,.5,-.5),
	sockeye$logReturns, tol=1e-4 )
cable.ar.p.plot( fit.ar2, ctp.ci=cable.change.conf( fit.ar2, .9 ) )

	# compare to this:
	# fit.ar2 <- bentcable.ar( sockeye$logReturns, 
	#	init.cable=c(13,.1,-.5,11,4), p=2, ci.level=.9 )
	# cable.ar.p.plot( fit.ar2$cable, ctp.ci=fit.ar2$ctp )

# AR(4) stick fit
fit.ar4 <- cable.ar.p.iter( c(13,.1,-.5,11,.5,-.5,.5,-.5),
	sockeye$logReturns, tol=1e-4, stick=TRUE )
cable.ar.p.plot( fit.ar4, ctp.ci=cable.change.conf( fit.ar4, .9 ) )

	# compare to this:
	# fit.ar4 <- bentcable.ar( sockeye$logReturns,
	#	init.cable=c(13,.1,-.5,11), p=4, stick=TRUE, ci.level=.9 )
	# cable.ar.p.plot( fit.ar4$cable, ctp.ci=fit.ar4$ctp )
}
\keyword{ dplot }
\keyword{ ts }
\keyword{ models }
\keyword{ regression }
\keyword{ nonlinear }
