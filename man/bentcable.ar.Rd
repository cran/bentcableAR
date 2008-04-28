\name{bentcable.ar}
\alias{bentcable.ar}
\alias{bentcable.dev.plot}
\title{ Bent-Cable Regression for Independent and Autoregressive Data }
\description{
	These two functions are the main interfaces in the
	\code{bentcableAR} package. They perform bent-cable (including
	broken-stick) regression to AR(p) time-series data or independent
	data (time-series or otherwise) and produce diagnostic plots.
	Confidence intervals for the \emph{critical time point} (CTP) are
	included in some cases.
}
\usage{
bentcable.ar(y.vect, tgdev = NULL, p = 0, stick = FALSE, t.vect = NULL, init.cable = NULL, init.phi = NULL, tol = 1e-04, method0 = "css", method1 = "yw", ci.level = 0.95, main = NULL)
bentcable.dev.plot(tau.vect, gamma.vect = NULL, y.vect, t.vect = NULL, stick = FALSE, p = 0)
}
\arguments{
	\item{y.vect}{ A numeric vector of response data. }
	\item{t.vect}{ A numeric vector of design points, which \bold{MUST}
		be equidistant with unit increments if p>0 is assumed. They need
		not be equidistant for independent data. Specifying
		\code{t.vect=NULL} is equivalent to specifying the default time
		points \code{c(0,1,2,\ldots)}. Also see \bold{Warnings} below. }
	\item{tau.vect, gamma.vect}{ Numeric vectors specifying a
		\eqn{(\tau,\gamma)}-grid over which the bent-cable profile
		deviance surface / function is to be evaluated. If
		\code{stick=TRUE}, then \code{gamma.vect} is overwritten by
		\code{c(0)} in \code{bentcable.dev.plot}. }
	\item{tgdev}{ A \code{bentcable.dev.plot} object. An error results
		if this is supplied together with \code{init.cable} or
		\code{init.phi}. }
	\item{p}{ The autoregressive order (non-negative integer).
		\code{p=0} specifies independent data that may or may not be
		from a time series context. }
	\item{stick}{ A logical value; if \code{TRUE} then a broken stick
		(i.e. bent cable with \eqn{\gamma}=0.) is fitted. Also see
		\code{gamma.vect} above. }
	\item{init.cable}{ A numeric vector of initial values for the
		bent-cable parameters. If \code{stick=FALSE}, then \code{init.cable}
		should have the form \code{c(b0,b1,b2,tau,gamma,\ldots)}. If
		\code{stick=TRUE}, then \code{init.cable} should have the form
		\code{c(b0,b1,b2,tau,\ldots)}. In either case, \code{\ldots}
		will be ignored. An error results if this is supplied together
		with \code{tgdev}. }
	\item{init.phi}{ A numeric vector of initial values for the AR
		coefficients. If not provided, then a default value is assigned,
		consisting of the first \code{p} elements of the vector
		\code{c(0.5,-0.5,0.5,-0.5,\ldots)}. When provided and its
		dimension does not match \code{p}, then the function determines
		which to reject depending on the situation, and reports its
		decision in the screen output. An error results if this is
		supplied together with \code{tgdev}. }
	\item{tol}{ Tolerance for determining convergence. }
	\item{method0, method1}{ The fitting method when p>0. \code{"css"}
		stands for \emph{conditional sum-of-squares} and corresponds to
		conditional maximum likelihood. \code{"yw"} stands for
		\emph{Yule-Walker}, and \code{"mle"} for (full) \emph{maximum
		likelihood estimation}. If \code{method0} fails to converge,
		then \code{method1} is attempted. }
	\item{ci.level}{ A numeric value between 0 and 1, exclusive. Used to
		compute the CTP confidence interval when \code{p} is
		greater than 0. See \code{cable.change.conf} and
		\bold{Warnings} below. }
  \item{main}{ A title for the set of diagnostic plots. }
}
\details{
	\code{bentcable.dev.plot} involves bent-cable regression assuming a
	known transition. It plots a profile deviance surface over a fixed
	grid (see \bold{References}). It also returns the grid and the
	profile deviance surface matrix, which can be used to generate
	initial values for an overall bent-cable regression (no known
	parameters).

	\code{bentcable.ar} is used mainly for overall bent-cable
	regression, with one exception. Different scenarios
	determine the behaviour of \code{bentcable.ar}, as follows.
	
	\bold{(1) Independent data and \code{tgdev} is supplied.} In this case,
	\code{bentcable.ar} calls \code{cable.ar.0.fit} which identifies
	the best grid-based fit from \code{tgdev}, then feeds it through an
	internal engine \code{cable.ar.p.iter} or \code{stick.ar.0} that
	performs overall bent-cable regression. This best fit is returned
	but not plotted, and the autocorrelation is diagnosed (even for
	non-time-series data) by a PACF plot and a suggested value of p
	based on the AIC (see \code{ar}). As stated in the screen output,
	these diagnostics should be used only for time-series data, where
	the returned best AR(0) estimates are intended to be supplied as
	\code{init.cable} in a subsequent call of \code{bentcable.ar} for
	an AR(p>0) fit. For non-time-series data, the returned best fit can
	be plotted by supplying the estimates as \code{init.cable} in
	another call of \code{bentcable.ar} with \code{p=0}.

	\bold{(2) AR(p>0) data and \code{tgdev} is supplied.} In this case, no
	graphics are produced; \code{bentcable.ar} simply locates the
	highest point on the grid-based profile deviance surface and
	returns the corresponding (crude) parameter estimates to be used as
	\code{init.cable} and \code{init.phi} in subsequent overall
	bent-cable fits. If multiple peaks exist (such as along a ridge),
	then only that at the smallest \eqn{\tau} and smallest \eqn{\gamma}
	is used.

	\bold{(3) Independent data (time series or otherwise) and
	\code{init.cable} are supplied.} In this case, \code{bentcable.ar}
	performs overall bent-cable regression and produces a
	scatterplot of the data superimposed with the best fit and
	estimated transition. No other plots are produced, and the CTP is
	not computed. The latter is because in a non-time-series context
	(often with non-equidistant design points), the cable's slope often
	never changes sign, and the CTP is undefined (see
	\code{cable.change.conf}). Even with a sign change, the point at
	which this takes place may be less interpretable for
	non-time-series data. In such a context, the user is advised to
	rely on confidence regions for \eqn{(\tau,\gamma)} (see
	\bold{References}). Since \code{init.cable} is supposed to have
	come from a reasonable source (such as grid-based), this fit is not
	intended to be fed to another round of \code{bentcable.ar}, except 
	when the user wishes to explore using a positive p (but this should
	be performed in conjunction with another round of grid-based
	approach in Scenario (2)).

	\bold{(4) AR(p>0) data and \code{init.cable} are supplied.} In this
	case, \code{bentcacble.ar} computes the overall bent-cable fit and
	CTP confidence interval (see \code{cable.change.conf}). Also
	included are the following diagnostics: a scatterplot of the data
	superimposed with the best fit and estimated transition
	\eqn{(\tau-\gamma,\tau,\tau+\gamma)} (in red) and the CTP
	confidence interval (in blue, if it exists - see \bold{Warnings}),
	and ACF and PACF plots for the fitted residuals and innovations
	(see \code{\link{cable.ar.p.resid}} for their difference). Since
	\code{init.cable} is supposed to have come from a reasonable
	source (such as grid-based), this fit is not intended to be fed
	to another round of \code{bentcable.ar}, except when the user
	wishes to explore using an alternative p (but this should be
	performed in conjunction with another round of grid-based approach
	in Scenario (1) or (2)).

	Below is a summary of the bent-cable regression methodology, and
	how one may apply it by using the \code{bentcableAR} package. 

	The \emph{bent cable} is a linear-quadratic-linear function, where
	the quadratic bend is regarded as the transition from the incoming
	linear phase to the outgoing linear phase. A bent cable has the form
	\eqn{f(t) = b_0 + b_1 t + b_2 q(t)}, where \eqn{q(t)} is the
	\emph{basic bent cable} with incoming slope 0 and outgoing slope 1,
	and a quadratic bend that is centred at \eqn{\tau} with half-width
	\eqn{\gamma\ge 0}:
	\deqn{q(t)=\frac{(t-\tau+\gamma)^2}{4\gamma} I\{|t-\tau|\le\gamma\}
	+ (t-\tau) I\{t>\tau+\gamma\}.}
	The \emph{broken stick} is a special bent cable with no quadratic
	bend (i.e. \eqn{\gamma}=0). The term \emph{bent-cable regression}
	implicitly includes \emph{broken-stick regression}.

	For independent data (time series or otherwise), bent-cable
	regression by maximum likelihood is performed via nonlinear
	least-squares estimation of \eqn{\theta=(b_0,b_1,b_2,\tau,\gamma)}.
	For AR(p) data, the AR coefficients are
	\eqn{\phi=(\phi_1,\phi_2,\ldots,\phi_p)}, and conditional maximum
	likelihood (CML) estimation of \eqn{(\theta,\phi)} (conditioned on
	the first p data points) is performed by nonlinear conditional
	least squares (i.e. minimizing the conditional sum-of-squares error
	(SSE)). In this time-series context, time points are assumed to be
	equidistant with unit increments.
	
	Minimization of the (conditional) SSE is specified as \code{"css"}
	by default for \code{method0}. However, \code{"css"} sometimes
	fails to converge, or the resulting \eqn{\phi} estimate sometimes
	corresponds to non-stationarity.  In this case, the alternative
	estimation approach specified for \code{method1} is attempted.
	\code{"mle"} specifies the \emph{CML-ML hybrid} algorithm, and
	\code{"yw"} the \emph{CML-ML-MM hybrid} algorithm (\emph{MM} stands
	for \emph{method of moments}; see \bold{References}.) Both
	\code{"yw"} and \code{"mle"} guarantee stationarity, but often take
	much longer than \code{"css"} to converge.
	
	Due to nonlinearity, initial values must be supplied for proper
	parameter estimation. Also, bent-cable regression is a notoriously
	irregular estimation problem (due to low-order differentiability),
	and the estimation algorithms (mainly the built-in \R
	functions \code{nls} and \code{optim}) may fail to converge from
	initial values that are unrefined guesses of the parameters. When
	this happens, the user is advised to generate an initial value from
	a grid-based procedure.

	The grid-based procedure involves specifying a
	\eqn{(\tau,\gamma)}-grid over which the bent-cable profile deviance
	surface is evaluated and plotted, such as by
	\code{bentcable.dev.plot}. At each grid
	point, the transition is fixed, and bent-cable regression involves
	only linear parameters \eqn{b_0, b_1, b_2} and AR coefficients
	\eqn{\phi}, all of which can be estimated using standard
	time-series algorithms (mainly the built-in \R functions \code{ar}
	and \code{arima}). Regression at each grid point yields a point on
	the profile deviance surface. The grid point at which the profile
	deviance is maximum corresponds to a bent-cable fit (given a known
	transition) that is best among the specified grid points. Thus, for
	a high-resolution grid, this \emph{best grid point} together with
	the corresponding estimates of \eqn{b_0, b_1, b_2} and \eqn{\phi}
	may be regarded as the ML or CML estimate for the model. However,
	high-resolution grid-based estimation may be computationally
	infeasible. Instead, the \emph{best grid point} on a coarser grid
	can give good initial values for the true ML or CML estimate that
	is trapped between grid points.

	However, the \emph{true} ML or CML estimate may not easily come by
	even with good initial values. Irregularity of bent-cable
	regression often manifests itself in the form of multiple peaks on
	the deviance surface. Thus, the user should be aware of different
	local maxima on which the optimization algorithm can converge
	despite initial values for \eqn{\theta} that are very similar. The
	user is advised to combine several exploratory analyses as well as
	model diagnoses before settling on a \emph{best} fit.

	For example, one may first fix p=0 as the AR order, then use
	\code{bentcable.dev.plot} to conduct a visual inspection of the
	profile deviance surface over a fine \eqn{(\tau,\gamma)}-grid. This
	is to identify the neighbourhood of the global maximum for p=0. If
	necessary, one can \emph{zoom in} to this neighbourhood by placing
	over it an even finer grid to hone the grid-based approximation.
	The resulting \code{bentcable.dev.plot} object can then be fed to
	\code{bentcable.ar} to produce a best overall fit for the AR(0)
	assumption in that neighbourhood. If p=0 is deemed inadequate based
	on the \code{bentcable.ar} diagnostics, then the regression must
	now be repeated for a newly chosen p. Since the bent-cable
	parameter estimates will differ for different values of p, the
	earlier AR(0) estimates may or may not be good initial values for
	this new AR(p) fit. The user is advised to try several additional
	initial values, possibly repeating the grid-based procedure, but
	this time using the new p. To further screen out local maxima, the
	SSE values for these AR(p) fits (with common p) should be compared.
	For a \code{"css"} fit, the SSE is stored in
	\code{$cable$ar.p.fit$value} of the returned object. The SSE is not
	directly retrievable for a \code{"yw"} or \code{"mle"} fit, but the
	user can apply the estimates returned in \code{$cable$est} as the initial
	values to a subsequent \code{"yw"} fit, and the SSE will appear in
	the screen output as \emph{initial value} while the \code{"css"}
	algorithm iterates.

	As with any numerical optimization procedure, there is no guarantee
	that the fit observed to have the smallest SSE value indeed
	corresponds to the global maximum.
}
\value{
	\item{cable}{ An object that is compatible with a
		\code{\link{cable.ar.p.iter}} object. Returned by \code{bentcable.ar}
		in Scenarios (3) and (4). Note the different components of
		\code{cable} depending on the scenario. See
		\code{cable.ar.p.iter} and \code{\link{stick.ar.0}}. }
	\item{ctp}{ A \code{\link{cable.change.conf}} object, if the CTP is
		successfully estimated; returned by \code{bentcable.ar} in
		Scenario (4). This object has three components: the CTP
		estimate, its estimated asymptotic variance, and the
		corresponding Wald confidence interval. }
	\item{fit}{ Returned by \code{bentcable.ar} in Scenarios (1) and (2).
		In (1), the returned \code{bentcable.ar} object is a
		\code{\link{cable.ar.0.fit}} object (largely compatible with
		\code{cable.ar.p.iter} objects); thus, \code{fit} is an
		\code{nls} object containing the overall independent-data
		bent-cable fit. In (2), the returned \code{bentcable.ar} object is a
		\code{\link{cable.fit.known.change}} object; thus, \code{fit}
		is an \code{arima} object containing the AR(p>0) bent-cable fit
		at the known transition grid point. In either scenario,
		\code{fit} is intended to be fed through another round of
		\code{bentcable.ar} for subsequent overall AR(p>0) fits. }
	\item{init}{ Returned by \code{bentcable.ar} in Scenario (2). It is
		the vector of parameter estimates extracted from \code{fit} and
		intended to be used as initial values in subsequent calls to
		\code{bentcable.ar} for overall bent-cable regression. }
	\item{y, t, n, p, stick}{ Returned by \code{bentcable.ar}
		explicitly in Scenario (1) (but embedded in \code{cable} of
		Scenarios (3) and (4)). They are \code{y.vect}, \code{t.vect},
		\code{n}, \code{p}, and \code{stick} as supplied by the user. }
	\item{dev, tau, gamma}{ Returned by \code{bentcable.dev.plot}. Note
		that \code{dev} is a \code{cable.dev} object, i.e. a matrix of
		profile deviance values evaluated at the grid specified by
		\code{tau} and \code{gamma}. }
}
\references{  
Chiu, G. and Lockhart, R. (2006), "Bent-Cable Regression with AR(p)
	Noise: Preliminary Theory and Applications," in \emph{2006
	Proceedings of the American Statistical Association, Statistical
	Computing Section [CD-ROM]}, pp. 2027--2034. Alexandria, VA:
	American Statistical Association.
	\url{http://www.stats.uwaterloo.ca/~gchiu/Articles/jsmproceedings06.pdf}

Chiu, G. and Lockhart, R. (in progress), "Some Mathematical and
	Algorithmic Details for Bent-Cable Regression with AR(p) Noise,"
	Working Paper Series No. 2006-07, Department of Statistics and
	Actuarial Science, University of Waterloo.
	\url{http://www.stats.uwaterloo.ca/stats_navigation/techreports/06WorkingPapers/2006-07.pdf}

Chiu, G., Lockhart, R. and Routledge, R. (2006), Bent-Cable Regression
	Theory and Applications, \emph{Journal of the American Statistical
	Association}, \bold{101}, 542--553.
	\url{http://www.stats.uwaterloo.ca/~gchiu/Articles/bentcable-jasa.pdf}
}
\author{ Grace Chiu }
\note{
	The major engines for \code{bentcable.dev.plot} are
	\code{\link{cable.dev}} and \code{\link{cable.fit.known.change}}.
	The computational engines for \code{bentcable.ar} are
	\code{\link{cable.ar.p.iter}}, \code{\link{cable.ar.0.fit}},
	\code{\link{stick.ar.0}}, and \code{\link{cable.change.conf}},
	while the plotting engine is \code{\link{cable.ar.p.diag}}.
	Although these and other \emph{lesser} functions are called
	internally by the two main interfaces described here, they can be
	used as stand-alone functions, and the user is advised to
	refer to their documentation. Type
	\code{library(help="bentcableAR")} for a full list of available
	functions.
}
\section{Warnings}{
	For time-series data, \code{t.vect} \emph{MUST} be 
	equidistant with unit increments; otherwise, these 
	functions will return meaningless values. (For 
	independent data, \code{t.vect} can be non-equidistant.)   

	Computations for the CTP estimate and confidence interval are based on a time
	vector of the form \code{c(0,1,2,\ldots)}. Any other form for the time
	vector may lead to singular computations and/or returned values that are
	meaningless. To ensure compatibility between the model fit and CTP
	estimates, the user is advised to fit the model using the default
	time vector. Then, if necessary, the user may transform the results
	to the preferred time scale after the model and CTP estimates have
	been produced.
}
\seealso{ 	\code{\link{cable.lines}}, \code{\link{lm}}, \code{\link{nls}}, \code{\link{optim}},
	\code{\link{ar}}, \code{\link{arima}}, \code{\link{plot}},
	\code{\link{par}}, \code{\link{contour}}, \code{\link{persp}} }
\examples{
data(stagnant)
data(sockeye)

# Scenario (1)
##############

# independent non-time-series cable:
bentcable.dev.plot( seq(-1,1,length=20),
	seq(.1,1,length=20), stagnant$loght, stagnant$logflow )

	# zoom in to global max
	dev0 <- bentcable.dev.plot( seq(-.04,.16,length=20), 
		seq(.2,.65,length=20), stagnant$loght, stagnant$logflow )
			# locally smooth deviance surface

	cable <- bentcable.ar( stagnant$loght, tgdev=dev0, t.vect=stagnant$logflow )
		# ignore time-series diagnostics
		# local regularity - expect to be true best fit
		# SSE=0.005
		# feed 'cable' in Scenario (3) to get fitted plot:
		#	bentcable.ar( cable$y, init.cable=coef(cable$fit), t.vect=cable$t )


# AR(0) stick, start time at 80:
dev0 <- bentcable.dev.plot( seq(85,97,length=15), 0,
	sockeye$logReturns, sockeye$year, TRUE )  # obvious global max
stick0 <- bentcable.ar( sockeye$logReturns, tgdev=dev0, stick=TRUE,
	t.vect=sockeye$year )
		# local regularity - should be true best fit
		# SSE=8.85
		# diagnostics: take p=0 to 4 ??

# AR(0) cable, start at time 0:
bentcable.dev.plot( seq(1,20,length=25), 
	seq(.1,15,length=25), sockeye$logReturns )

	# zoom in to global max
	dev0 <- bentcable.dev.plot( seq(10,15,length=25),
		seq(2,10,length=20), sockeye$logReturns )
			# surface has ridge - expect some trouble locating true peak

	cable0 <- bentcable.ar( sockeye$logReturns, tgdev=dev0 )
		# apparent best AR(0) fit: SSE=8.68
		# diagnostics: take p=2 to 6

		# compare to this:
		# dev1 <- bentcable.dev.plot( seq(10,15,length=25),
		#	seq(2,10,length=15), sockeye$logReturns )
		# bentcable.ar( sockeye$logReturns, tgdev=dev1 ) # SSE=8.683
		#	# not an obvious local max!

		# feed 'cable0' in Scenario (3) to get fitted plot:
		#	bentcable.ar( cable0$y, init.cable=coef(cable0$fit) )




# Scenario (2)
##############

# AR(2) cable, start time at 0:
bentcable.dev.plot( seq(6,18,length=15),
	seq(.01,12,length=15), sockeye$logReturns, p=2 )

	# zoom in to global max
	dev2 <- bentcable.dev.plot( seq(10,12,length=15),
		seq(1,5,length=15), sockeye$logReturns, p=2 )

	# best grid-based fit
	gr.cable2 <- bentcable.ar( sockeye$logReturns, tgdev=dev2, p=2 )
		# to be used in Scenario (4)
		# local regularity - expect little trouble

# AR(2) stick, start time at 80:
bentcable.dev.plot( seq(86,98,length=15), y.vect=sockeye$logReturns, 
	p=2, stick=TRUE, t.vect=sockeye$year )

	# zoom in to global max
	dev3 <- bentcable.dev.plot( seq(88.5,93,length=25),
		y.vect=sockeye$logReturns, 
		p=2, stick=TRUE, t.vect=sockeye$year )
			# camel hump - double peaks!

	# best grid-based fit
	gr.stick2 <- bentcable.ar( sockeye$logReturns, tgdev=dev3, p=2, stick=TRUE,
		t.vect=sockeye$year )
			# irregularity - expect some trouble if used in Scenario (4)

# AR(4) cable, start time at 0:
bentcable.dev.plot( seq(6,18,length=15), seq(.01,12,length=15), 
	sockeye$logReturns, p=4 )

	# zoom in to global max
	dev4 <- bentcable.dev.plot( seq(10,12,length=15),
		seq(1,7,length=25), sockeye$logReturns, p=4 )
			# slight ridge

	# best grid-based fit
	gr.cable4 <- bentcable.ar( sockeye$logReturns, tgdev=dev4, p=4 )
		# to be used in Scenario (4)
		# will ridge be problem???



# Scenario (3)
##############

# independent non-time-series cable:
bentcable.ar( stagnant$loght, t.vect=stagnant$logflow,
	init.cable=c(.6,-.4,-.7,0,.5) )   # SSE=0.005
		# identical to 'cable' in Scenario (1)
		# no irregularity, no ambiguity!



# AR(0) stick, start time at 80:
bentcable.ar( sockeye$logReturns, init.cable=c(10,.1,-.5,90),
	stick=TRUE, t.vect=sockeye$year )
		# identical to 'stick0' in Scenario (1)
		# local regularity, no trouble




# Scenario (4)
##############

# AR(2) cable, start time at 0:
# use 'gr.cable2' from Scenario (2)
cable2 <- bentcable.ar( sockeye$logReturns,
	init.cable=gr.cable2$init[1:5], init.phi=gr.cable2$init[-c(1:5)] )
		# "css" successful
		# best AR(2) fit, SSE=4.868
	
	# compare to this:
	# bentcable.ar( sockeye$logReturns,
	#	init.cable=c(13,.1,-.5,11,4), p=2 )
			# "css" successful, same SSE, virtually same fit
			# recall local regularity from 'dev2'

# AR(2) stick, start time at 80:
# use 'gr.stick2' from Scenario (2)
stick2 <- bentcable.ar( sockeye$logReturns, init.cable=gr.stick2$init[1:4],
		init.phi=gr.stick2$init[-c(1:4)], stick=TRUE, t.vect=sockeye$year )
			# "css" successful, best AR(2) fit, SSE=5.0

			# compare this to the other peak shown in 'dev3'
			#	bentcable.ar( sockeye$logReturns,
			#	init.cable=c(10,0,-.5,91.5), p=2, stick=TRUE, t.vect=sockeye$year )
				# "css" successful, SSE=5.1, not best fit!



# AR(4) cable, start time at 0:
cable4 <- bentcable.ar( sockeye$logReturns,
	init.cable=gr.cable4$init[1:5], init.phi=gr.cable4$init[-c(1:5)] )
		# "css" unsuccessful, switched to "yw"
		# feed 'cable4' in Scenario (4) to get SSE from screen output:

		bentcable.ar( cable4$cable$y, init.cable=cable4$cable$est[1:5],
			init.phi=cable4$cable$est[-c(1:5)] )
				# SSE=2.47 from screen output
}
\keyword{ dplot }
\keyword{ ts }
\keyword{ models }
\keyword{ regression }
\keyword{ nonlinear }
