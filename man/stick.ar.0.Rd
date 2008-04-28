\name{stick.ar.0}
\alias{stick.ar.0}
\title{ Broken-Stick Regression for Independent Data }
\description{
	This function is the main engine for \code{bentcable.ar} when a
	broken stick (i.e. \eqn{\gamma}=0 for bent cable) model is assumed
	for independent data.  For AR(p) time-series data, this function is
	intended for determining an appropriate p and initial values for
	the stick parameters.
}
\usage{
stick.ar.0(init.vect, y.vect, t.vect = NULL, n = NA)
}
\arguments{
	\item{init.vect}{ A numeric vector of initial values, in the form
		of \code{c(b0,b1,b2,tau)}. }
  \item{y.vect}{ A numeric vector of response data. }
  \item{t.vect}{ A numeric vector of design points, which need not be
	  equidistant. Specifying \code{t.vect=NULL} is equivalent to
	  specifying the default time points \code{c(0,1,2,\ldots)}. }
  \item{n}{ Length of response vector (optional). }
}
\details{
	The returned object is compatible with a \code{cable.ar.p.iter}
	object for independent data.

	The broken stick as a special case of the bent cable has form
	\eqn{f(t) = b_0 + b_1 t + b_2 (t-\tau) I\{t>\tau\} }.

	Broken-stick regression by maximum likelihood for independent data
	is performed via nonlinear least-squares estimation of
	\eqn{\theta=(b_0,b_1,b_2,\tau)} through the built-in \R function
	\code{nls}. The estimation relies on the user-supplied initial
	values in \code{init}.
}
\value{
\item{fit}{ An \code{nls} object that is the maximum likelihood fit. }
\item{y, t, n}{ As supplied by the user. }
\item{p, stick}{ The values \code{0} and \code{TRUE}, respectively;
	used internally by \code{bentcable.ar} and \code{cable.ar.0.fit}. }
}
\references{ See the \code{\link{bentcableAR}} package references. }
\author{ Grace Chiu }
\note{
	This function is intended for internal use by \code{bentcable.ar}.
}
\seealso{ \code{\link{cable.ar.p.iter}}, \code{\link{fullcable.t}}, 
	\code{\link{cable.fit.known.change}}. }
\examples{
data(sockeye)

stick.ar.0( c(13,.1,-.7,12), sockeye$logReturns )
}
\keyword{ ts }
\keyword{ models }
\keyword{ regression }
\keyword{ nonlinear }
