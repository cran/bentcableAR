\name{fullcable.t}
\alias{fullcable.t}
\title{ Evaluate Bent Cable Function }
\description{
	The bent-cable response is evaluated at a provided design point \code{t}.
}
\usage{
fullcable.t(t, b0, b1, b2, tau, gamma)
}
\arguments{
  \item{t}{ A design point at which the bent cable is to be evaluated. }
  \item{b0}{ Intercept. }
  \item{b1}{ Incoming slope. }
  \item{b2}{ Coefficient of the \emph{basic bent cable}. }
  \item{tau}{ Centre of the quadratic bend (transition). }
  \item{gamma}{ Non-negative half-width of the quadratic bend. }
}
\details{
	All arguments must be numeric, and at most one can be a vector.

	The \emph{full bent cable} has the form
	\eqn{f(t) = b_0 + b_1 t + b_2 q(t)}, where \eqn{q(t)} is
	the \emph{basic bent cable} function with intercept and slope 0
	and outgoing slope 1:
	\deqn{q(t)=\frac{(t-\tau+\gamma)^2}{4\gamma} I\{|t-\tau|\leq\gamma\}
	+ (t-\tau) I\{t>\tau+\gamma\}}
	for \eqn{\gamma\geq 0}.
}
\references{ See the \code{\link{bentcableAR}} package references. }
\author{ Grace Chiu }
\note{
	This function is intended for internal use by \code{bentcable.ar}
	and \code{bentcable.dev.plot}.
}
\examples{
	# basic broken stick, kink at 0:
	plot( seq(-10,10), fullcable.t(seq(-10,10),0,0,1,0,0) )
	
	# full bent cable, bend centred at 0 with half-width 3:
	plot( seq(-10,10), fullcable.t(seq(-10,10),1,.1,-.5,0,3) )
}
\keyword{ models }
\keyword{ regression }
\keyword{ nonlinear } 
