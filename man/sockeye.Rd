\name{sockeye}
\docType{data}
\alias{sockeye}
\title{Rivers Inlet Sockeye Abundance}
\description{
	This dataset contains the figures for the returns of Rivers Inlet
	sockeye salmon (\emph{Oncorhynchus nerka}) recorded annually from
	1980 to 2000.
}
\usage{data(sockeye)}
\format{A data frame with two columns:
	\itemize{
	\item{\code{year}}{ The year minus 1900. E.g. \code{80} is 1980 and
		\code{100} is the year 2000. }
	\item{\code{logReturns}}{ The figure for the returning number of
		salmon, converted to the natural logarithmic scale. }
	}
}
\source{Fisheries and Oceans Canada, Pacific Region.}
\references{
Chiu, G., Lockhart, R. and Routledge, R. (2006), Bent-Cable Regression
	Theory and Applications, \emph{Journal of the American Statistical
	Association}, \bold{101}, 542--553. DOI: 10.1198/016214505000001177  
	\url{http://faculty.washington.edu/gchiu/Articles/bentcable-jasa.pdf}
}
\keyword{datasets}
