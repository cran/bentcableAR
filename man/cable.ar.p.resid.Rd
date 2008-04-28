\name{cable.ar.p.resid}
\alias{cable.ar.p.resid}
\title{ Fitted Residuals and Innovations for AR(p>0) Bent Cable }
\description{
	This function computes the fitted residuals and
	fitted innovations from an AR(p>0) bent-cable
	regression.
}
\usage{
cable.ar.p.resid(ar.p.fit)
}
\arguments{
  \item{ar.p.fit}{ A \code{cable.ar.p.iter} object for AR(p) data, p>0. }
}
\details{
	Fitted residuals correspond to the detrended time series,
	where the fitted bent cable is subtracted from the data.
	They retain the autocorrelation structure of the response 
	time series.

	Fitted innovations are the \emph{estimated} residual noise
	after adjusting for the AR(p) structure, and should be
	approximately independent if the AR(p) fit successfully
	captures the actual autocorrelation in the data.

	Both types of errors may be used for model diagnosis.
}
\value{
  \item{resid }{ A numeric vector of fitted residuals; it has the same length as
  	the response data. }
  \item{innov }{ A numeric vector of fitted innovations; the first value
  	in the vector corresponds to the (p+1)st time point. }
}
\references{ See the \code{\link{bentcableAR}} package references. }
\author{ Grace Chiu }
\note{
	This function is intended for internal use by \code{bentcable.ar}.
}
\section{Warnings}{
	This function fails if \code{ar.p.fit} is from a non-AR(p>0) fit. 
	
	The fitted innovations are only meaningful if \code{ar.p.fit} is
	associated with equidistant time points with unit increments.
}
\seealso{ \code{\link{cable.ar.p.diag}} }
\examples{
data(sockeye)

fit.ar2 <- cable.ar.p.iter( c(13,.1,-.5,11,4,.5,-.5),
	sockeye$logReturns, tol=1e-4 )
cable.ar.p.resid( fit.ar2 )
}
\keyword{ ts }
\keyword{ models }
\keyword{ regression }
\keyword{ nonlinear }
