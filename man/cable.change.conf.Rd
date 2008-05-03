\name{cable.change.conf}
\alias{cable.change.conf}
\title{ Confidence Interval for CTP of AR(p) Bent Cable }
\description{
	The \emph{critical time point} (CTP) is estimated and
	accompanied by a Wald confidence interval.
}
\usage{
cable.change.conf(ar.p.fit, level)
}
\arguments{
  \item{ar.p.fit}{ A \code{cable.ar.p.iter} object for AR(p\eqn{\ge}0)
	  data. }
  \item{level}{ A numeric value between 0 and 1, exclusive. }
}
\details{
	The CTP is the unique time point at which the cable's 
	slope changes sign. If this exists, then it must happen
	inside the transition \eqn{\tau\pm\gamma}, and is estimated
	by this function based on the bent-cable regression
	supplied as \code{ar.p.fit}. Additionally, an approximate
	confidence interval using the Wald method is obtained by
	estimating the asymptotic variance of the CTP estimator.
	Variance estimation involves inverting an approximate
	Fisher information matrix by calling the built-in \R
	function \code{solve}.

	\code{cable.change.conf} returns an error if the CTP (almost) 
	does not exist, e.g. when the estimated bent cable slope 
	(almost) does not change signs, or when the fit from
	\code{ar.p.fit} is obtained with a time vector that is not
	\code{c(0,1,2,\ldots)}. See \bold{Warnings} below.
}
\value{
  \item{change.hat}{ The estimated CTP. }
  \item{var }{ The estimated asymptotic variance of the CTP estimator. }
  \item{interval}{ The 100*\code{level} percent Wald confidence interval 
  	for the CTP. }
}
\references{ See the \code{\link{bentcableAR}} package references. }
\author{ Grace Chiu }
\note{
	This function is intended for internal use by \code{bentcable.ar}.
}
\section{Warnings}{
	Computations for the CTP estimate and confidence interval are based on a time
	vector of the form \code{c(0,1,2,\ldots)}. For any other form for the time
	vector, the CTP will not be computed, and on-screen warnings
	will appear. To ensure compatibility between the model fit and CTP
	estimates, the user is advised to fit the model using the default
	time vector. Then, if necessary, the user may transform the results
	to the preferred time scale after the model and CTP estimates have
	been produced.

	The above computational issue implies that the function cannot
	handle non-time-series data. \bold{Rationale}:
	In a non-time-series context design points are often
	non-equidistant, and the cable's slope often never changes sign;
	even with a sign change, the point at which this takes place may be
	less interpretable. In such a context, the user is advised to rely
	on confidence regions for \eqn{(\tau,\gamma)} (see
	\bold{References}).
}
\seealso{ \code{\link{solve}}, \code{\link{cable.ar.p.plot}} }
\examples{
data(sockeye)

# AR(2) cable fit
fit.ar2 <- cable.ar.p.iter( c(13,.1,-.5,11,4,.5,-.5),
	sockeye$logReturns, tol=1e-4 )
cable.change.conf( fit.ar2, .9 )

	# compare to this:
	# fit.ar2 <- bentcable.ar( sockeye$logReturns, 
	#	init.cable=c(13,.1,-.5,11,4), p=2, ci.level=.9 )
	# cable.change.conf( fit.ar2$cable, .9 )

# AR(2) stick fit
stick.ar2 <- cable.ar.p.iter( c(13,.1,-.5,11,.5,-.5),
	sockeye$logReturns, tol=1e-4, stick=TRUE)
cable.change.conf( stick.ar2, .9)
	# compare to this:
	# stick.ar2 <- bentcable.ar( sockeye$logReturns,
	#	init.cable=c(13,.1,-.5,11), p=2, stick=TRUE, ci.level=.9 )
	#	cable.change.conf( stick.ar2$cable, .9 )

# AR(4) stick fit
fit.ar4 <- cable.ar.p.iter( c(13,.1,-.5,11,.5,-.5,.5,-.5),
	sockeye$logReturns, tol=1e-4, stick=TRUE )
cable.change.conf( fit.ar4, .9 )

	# compare to this:
	# fit.ar4 <- bentcable.ar( sockeye$logReturns,
	#	init.cable=c(13,.1,-.5,11), p=4, stick=TRUE, ci.level=.9 )
	# cable.change.conf( fit.ar4$cable, .9 )
}
\keyword{ ts }
\keyword{ models }
\keyword{ regression }
\keyword{ nonlinear }
