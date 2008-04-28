\name{cable.lines}
\alias{cable.lines}
\title{ Overlay Bent Cable On Existing Plot }
\description{
	A user-specified bent cable is added to an existing plot.
	Its intended use is for superimposing a bent-cable regression
	fit to a scatterplot of the data. The transition is marked
	by vertical lines at \eqn{\tau} and \eqn{\tau\pm\gamma}.
}
\usage{
cable.lines(x, theta, col = "black", lwd = 1, lty = 2, fit.lty = 1)
}
\arguments{
  \item{x}{ A numeric vector of design points or the range of these
  	design points on the existing scatterplot. }
  \item{theta}{ A vector of bent-cable coefficients, in the form of
	\code{c(b0,b1,b2,tau,gamma)}. }
  \item{col, lwd}{ Graphical parameters for plotting the bent-cable
  	function and transition. }
  \item{lty}{ Graphical parameter for marking the transition. }
  \item{fit.lty}{ Graphical parameter of type \code{lty} for
  	plotting the bent-cable function. }
}
\references{ See the \code{\link{bentcableAR}} package references. }
\author{ Grace Chiu }
\note{
	This function is intended for internal use by \code{bentcable.ar}.
}
\seealso{ \code{\link{fullcable.t}}, \code{\link{par}},
	\code{\link{lines}} }
\examples{
data(sockeye)

	plot(sockeye)
	cable.lines( sockeye$year, c(6.6,.08,-.68,92,6.01) )
}
\keyword{ dplot }
\keyword{ models }
\keyword{ regression }
\keyword{ nonlinear } 
