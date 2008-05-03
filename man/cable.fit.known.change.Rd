\name{cable.fit.known.change}
\alias{cable.fit.known.change}
\alias{cable.dev}
\alias{cable.ar.0.fit}
\title{ Grid-based Bent-Cable Regression for Independent or AR Data }
\description{
	These functions compute the profile deviance over a \eqn{(\tau,\gamma)}-grid
	to either fit a bent-cable regression with known transition, or to
	generate initial values for a bent-cable regression with unknown
	transition. \code{cable.dev} and \code{cable.fit.known.change} form
	the main engine of \code{bentcable.dev.plot}.
}
\usage{
cable.ar.0.fit(y.vect, t.vect = NULL, tau.vect, gamma.vect, dev.mat,
	stick = FALSE)
cable.dev(tau.vect, gamma.vect, y.vect, t.vect = NULL, p = 0)
cable.fit.known.change(y.vect, t.vect = NULL, n = NA,
	tau.vect, gamma.vect, dev.mat, p = 0)
}
\arguments{
  \item{y.vect}{ A numeric vector of response values. }
  \item{t.vect}{ A numeric vector of design points. Specifying
	\code{t.vect=NULL} is equivalent to specifying the default time points
	\code{c(0,1,2,\ldots)}. Also see \bold{Warnings} below. }
  \item{n}{ Length of response vector (optional). }
  \item{tau.vect}{ A numeric vector of \eqn{\tau}-coordinates of the grid points. }
  \item{gamma.vect}{ A numeric vector of \eqn{\gamma}-coordinates of the grid points. }
  \item{dev.mat}{ A numeric matrix (can be single column) corresponding to the bent-cable
  	profile deviance surface / function over the \eqn{(\tau,\gamma)}-grid. }
  \item{p}{ The autoregressive order (non-negative integer).
 	 \code{p=0} specifies independent data that may or may not be from a
 	 time series context. }
  \item{stick}{ A logical value; if \code{TRUE} then a broken stick (i.e. bent cable
  	with \eqn{\gamma}=0.) is fitted. }
}
\details{
	Given the response data in \code{y.vect} and design points 
	in \code{t.vect}, \code{cable.dev} evaluates the bent-cable 
	profile deviance surface / function over the user-specified
	\eqn{(\tau,\gamma)}-grid. The returned values are intended 
	to be used in conjunction with \code{contour} or \code{persp}, 
	in which case \code{tau.vect} and \code{gamma.vect} should have length
	greater than 1 so that the returned object is a matrix with at least
	two columns.  If such a plot is not required, then \code{tau.vect}
	and/or \code{gamma.vect} can be scalar. This function is internal
	to the main plotting interface \code{\link{bentcable.dev.plot}}.

	The grid point at which the profile deviance is maximum
	corresponds to a bent-cable fit given a known transition
	that is best among the specified grid points. 
	\code{cable.fit.known.change} locates this peak and computes 
	this fit. If multiple peaks exist (such as along a ridge), 
	then only that at the smallest \eqn{\tau} and smallest \eqn{\gamma} 
	is used.

	For both functions, \code{p=0} should be specified to indicate 
	independent data (time series or otherwise). For time-series 
	data, a positive integer \code{p} should be specified as the
	autoregressive order. Fitting is done by internally calling 
	the built-in \R function \code{lm} for \code{p=0} and \code{arima} 
	for non-zero \code{p}; this procedure is appropriate since 
	bent-cable regression with a known transition is linear.

	Note that the grid-based \code{cable.fit.known.change}
	does not locate the true peak of the continuous profile 
	deviance surface / function. However, for a grid that traps 
	the true peak between grid points, the returned fit is 
	approximately the overall best fit (with all parameters
	unknown), and thus can be fed into \code{bentcable.ar} 
	as initial values for computing the actual best fit. A special 
	case is \code{p=0} for independent data (time-series or otherwise),
	which can be handled by \code{cable.ar.0.fit} (called internally by 
	\code{bentcable.ar}). \code{cable.ar.0.fit} calls
	\code{cable.ar.p.iter} when \code{stick=FALSE} but calls \code{stick.ar.0}
	when \code{stick=TRUE}; in both cases, the built-in \R function \code{nls}
	is utilized to perform maximum likelihood.

	For all three functions, to fit a broken stick with a known 
	break point, \code{gamma.vect} should be the single 
	value 0, and thus \code{dev.mat} is a column matrix (see 
	\code{\link{bentcable.dev.plot}}).
}
\value{
\item{fit}{ Returned by \code{cable.fit.known.change}
	and \code{cable.ar.0.fit}. 
	
	For \code{cable.fit.known.change},
	\code{$fit} is the AR(p) bent-cable regression at the known 
	transition grid point; if \code{p=0}, it is
	an \code{lm} object, otherwise it is an \code{arima} object. 
	
	For \code{cable.ar.0.fit}, \code{$fit} is an \code{nls} object 
	that is the maximum likelihood bent-cable fit. }
\item{init}{ Returned by \code{cable.fit.known.change}, containing
	the coefficients from \code{$fit} that can be used as initial 
	values in bent-cable regression with unknown transition. }
\item{y}{ Same as \code{y.vect}: returned by \code{cable.ar.0.fit}. }
\item{t}{ Same as \code{t.vect}: returned by \code{cable.ar.0.fit}. }
\item{n, p, stick}{ As supplied by the user: returned by \code{cable.ar.0.fit}. }
\code{cable.dev} returns the evaluated profile deviance 
surface / function as a matrix.
}
\references{ See the \code{\link{bentcableAR}} package references. }
\author{ Grace Chiu }
\note{
	These functions are intended for internal use by \code{bentcable.dev.plot}
	and \code{bentcable.ar}.
}
\section{Warnings}{
	For time-series data, \code{t.vect} \emph{MUST} be 
	equidistant with unit increments; otherwise, these 
	functions will return meaningless values. (For 
	independent data, \code{t.vect} can be non-equidistant.)   

	Grid-based bent-cable regression and its use in 
	subsequent overall fits rely on locating the region
	in which the continous deviance surface truly peaks. 
	The user should be aware of possible local maxima and/or
	coarse grids that result in less-than-best fits.
}
\seealso{ \code{\link{bentcable.dev.plot}}, \code{\link{bentcable.ar}},
	\code{\link{nls}}, \code{\link{lm}}, \code{\link{arima}} }
\examples{
data(stagnant)
data(sockeye)

# non-time-series data: compute grid-based profile deviance
cable.dev( seq(-.04,.16,length=10), seq(.2,.65,length=10), 
	stagnant$loght, stagnant$logflow )
	# compare to this:
	# bentcable.dev.plot( seq(-.04,.16,length=10), 
	#	seq(.2,.65,length=10), stagnant$loght, stagnant$logflow )$dev

# AR(2) bent cable, start time at 0: find best grid-based fit
dev <- cable.dev( seq(6,18,length=15), seq(.01,12,length=15),
		sockeye$logReturns, p=2 )
contour( seq(6,18,length=15), seq(.01,12,length=15), dev )
cable.fit.known.change( sockeye$logReturns, tau.v=seq(6,18,length=15), 
	gamma.v=seq(.01,12,length=15), dev.mat=dev, p=2 )

# AR(0) broken stick, start time at 80: find best overall fit
dev <- cable.dev ( seq(85,97,length=15), 0, sockeye$logReturns, 
	sockeye$year)
plot( seq(85,97,length=15), dev, type="l" )
cable.ar.0.fit( sockeye$logReturns, sockeye$year,
	tau.v=seq(85,97,length=15), gamma.v=0, dev.mat=dev, 
	stick=TRUE )
	# compare to this:
	# bentcable.ar( sockeye$logReturns, bentcable.dev.plot(
	#	seq(85,97,length=15), 0, sockeye$logReturns, sockeye$year, TRUE
	#	), stick=TRUE, t.vect=sockeye$year )
}
\keyword{ dplot }
\keyword{ ts }
\keyword{ models }
\keyword{ regression }
\keyword{ nonlinear }
