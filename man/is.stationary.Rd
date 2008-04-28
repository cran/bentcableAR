\name{is.stationary}
\alias{is.stationary}
\title{ Stationarity Check of AR Time Series }
\description{
  Check if AR coefficients correspond to stationarity.
}
\usage{
is.stationary(phi.vect)
}
\arguments{
  \item{phi.vect}{ A vector of at least one AR coefficient. }
}
\details{
 Stationarity check is performed via the simulation of an AR
 time series using the built-in \R function \code{arima.sim}.
}
\value{
  logical
}
\author{ Grace Chiu }
\note{
	This function is intended for internal use by \code{bentcable.ar}.
}
\examples{
  is.stationary(1) # F
  is.stationary(c(-.5,.2)) # T
}
\keyword{ ts }
