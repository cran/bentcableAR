\name{cable.ar.p.iter}
\alias{cable.ar.p.iter}
\title{ Bent-Cable Regression for Independent or AR Data, With Exception  }
\description{
	This function is the main engine for \code{bentcable.ar}. It performs
	bent-cable (including broken-stick) regression to AR(p) time-series data
	or independent data (time-series or otherwise). However, it 
	\bold{cannot fit broken sticks to independent data} (see
	\code{stick.ar.0}).
}
\usage{
cable.ar.p.iter(init, y.vect, t.vect = NULL, n = NA, tol, method0 = "css", method1 = "yw", stick = FALSE)
}
\arguments{
  \item{init}{ A numeric vector of initial values, in the form of
	\code{c(b0,b1,b2,tau,gamma,phi.1,\ldots,phi.p)} when \code{stick=FALSE}, and
	\code{c(b0,b1,b2,tau,phi.1,\ldots,phi.p)} when \code{stick=TRUE}.
	\code{phi} values correspond to AR(p) coefficients - if not included,
	then independent data are assumed. }
  \item{y.vect}{ A numeric vector of response data. }
  \item{t.vect}{ A numeric vector of design points, which \bold{MUST} be
	equidistant with unit increments if AR(p) is assumed. They need not be
	equidistant for independent data. Specifying \code{t.vect=NULL} is
	equivalent to specifying the default time points \code{c(0,1,2,\ldots)}. }
  \item{n}{ Length of response vector (optional). }
  \item{tol}{ Tolerance for determining convergence. }
  \item{method0, method1}{ The fitting method when p>0. \code{"css"} stands for
	\emph{conditional sum-of-squares} and corresponds to conditional maximum
	likelihood. \code{"yw"} stands for \emph{Yule-Walker}, and \code{"mle"}
	for (full) \emph{maximum likelihood estimation}. If \code{method0} fails
	to converge, then \code{method1} is attempted. }
  \item{stick}{ A logical value; if \code{TRUE}, a broken-stick regression is performed. }
}
\details{
	The \emph{bent cable} has the form
	\eqn{f(t) = b_0 + b_1 t + b_2 q(t)}, where \eqn{q(t)} is
	the \emph{basic bent cable} 
	\deqn{q(t)=\frac{(t-\tau+\gamma)^2}{4\gamma} I\{|t-\tau|\le\gamma\}
	+ (t-\tau) I\{t>\tau+\gamma\}}
	for \eqn{\gamma\ge 0}.
	
	For independent data (time series or otherwise), bent-cable
	regression by maximum likelihood is performed via nonlinear
	least-squares estimation of
	\eqn{\theta=(b_0,b_1,b_2,\tau,\gamma)} through the built-in \R
	function \code{nls}. For AR(p) data, conditional maximum
	likelihood (CML) estimation of \eqn{(\theta,\phi)}
	(conditioned on the first p data points) is performed through
	the built-in \R function \code{optim} with the \code{"BFGS"}
	algorithm, where \eqn{\phi=(\phi_1,\ldots,\phi_p)} are the AR
	coefficients. In either case, the estimation relies on the
	user-supplied initial values in \code{init}. A Gaussian model
	is assumed, so that CML estimation is equivalent to minimizing
	the conditional sum-of-squares error, specified as
	\code{"css"} by default for \code{method0}. However,
	\code{"css"} sometimes fails to converge, or the resulting
	\eqn{\phi} estimate sometimes corresponds to non-stationarity.
	In this case, the alternative estimation approach specified
	for \code{method1} is attempted. \code{"mle"} specifies the
	\emph{CML-ML hybrid} algorithm, and \code{"yw"} the
	\emph{CML-ML-MM hybrid} algorithm (\emph{MM} stands for
	\emph{method of moments}; see \bold{References}.) Both
	\code{"yw"} and \code{"mle"} guarantee stationarity, but often
	take much longer than \code{"css"} to converge.

	The bent-cable likelihood / deviance often has multiple peaks. Thus, the
	user should be aware of different local maxima on which the optimization
	algorithm can converge despite initial values for \eqn{\theta} that
	are very similar. The user is advised to combine several exploratory
	analyses as well as model diagnoses before settling on a
	\emph{best} fit. See \bold{Details} on the
	\code{\link{bentcable.ar}} help page for a detailed description.
}
\value{
\item{fit}{ An \code{nls} object, returned if independent data are assumed. It is 
	the maximum likelihood bent-cable fit. }
\item{estimate}{ A numeric vector, returned if AR(p>0) is assumed. It is the
	estimated value of (\eqn{\theta,\phi}). }
\item{ar.p.fit}{ Returned if AR(p>0) is assumed. If \code{"css"} is used,
	converges, and yields a \eqn{\phi} estimate that corresponds to
	stationarity, then \code{$ar.p.fit} is an \code{optim} object containing
	the CML fit. If \code{"yw"} or \code{"mle"} is used and converges, then
	\code{$ar.p.fit} is an \code{ar} object containing the CML-ML(-MM) fit. }
\item{y, t, n, p, stick}{ As supplied by the user; always returned. }
\item{method}{ A character string, returned if AR(p>0) is assumed. It indicates
	the method that yielded the returned fit. }
}
\references{ See the \code{\link{bentcableAR}} package references. }
\author{ Grace Chiu }
\note{
	This function is intended for internal use by \code{bentcable.ar}.

	For several fits that assume a common p, their (conditional) likelihood
	values should be compared to screen out those that result from local
	maxima. Equivalently, the (conditional) sum-of-squares error (SSE) can
	be compared and only the smallest kept. See \bold{Examples} below.
	Also see \bold{Details} on the \code{\link{bentcable.ar}} help
	page.
}
\seealso{ \code{\link{stick.ar.0}}, \code{\link{fullcable.t}}, 
	\code{\link{bentcable.dev.plot}},
	\code{\link{nls}}, \code{\link{optim}},
	\code{\link{ar}}. }
\examples{
data(stagnant)
data(sockeye)

# 'stagnant': independent data cable fit
fit0 <- cable.ar.p.iter( c(.6,-.4,-.7,0,.5),
	stagnant$loght, stagnant$logflow )    # 'nls' fit
	# compare to this:
	# bentcable.ar( stagnant$loght, t.vect=stagnant$logflow,
	#	init.cable=c(.6,-.4,-.7,0,.5) )

fit0$fit   # 'fit0' SSE=0.005


# 'sockeye': AR(2) cable fit
fit1 <- cable.ar.p.iter( c(13,.1,-.5,11,4,.5,-.5),
	sockeye$logReturns, tol=1e-4 )    # "css" successful
	# compare to this:
	# fit1 <- bentcable.ar( sockeye$logReturns, 
	#	init.cable=c(13,.1,-.5,11,4), p=2 )

fit1$ar.p.fit$value     # 'fit1' SSE=4.9


# 'sockeye': AR(2) cable fit
fit2 <- cable.ar.p.iter( c(10,0,0,5,.1,.5,-.5), sockeye$logReturns, 
	tol=1e-4 )    # "css" unsuccessful, switched to "yw"
	# compare to this:
	# fit2 <- bentcable.ar(sockeye$logReturns, 
	#	init.cable=c(10,0,0,5,.1), p=2 )

cable.ar.p.iter( fit2$est, sockeye$logReturns, 
	tol=1e-4 )   # 'fit2' SSE=13.8 (from first line of screen output)


# 'sockeye': AR(4) stick fit
cable.ar.p.iter( c(13,.1,-.5,11,.5,-.5,.5,-.5),
	sockeye$logReturns, tol=1e-4, stick=TRUE )
	# compare to this:
	# bentcable.ar( sockeye$logReturns,
	#	init.cable=c(13,.1,-.5,11), p=4, stick=TRUE )
}
\keyword{ ts }
\keyword{ models }
\keyword{ regression }
\keyword{ nonlinear }
