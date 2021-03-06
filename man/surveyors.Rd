\name{surveyors}
\alias{surveyors}
\alias{surveyors.3}
\alias{surveyors.4}
\alias{shoelace}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{The Surveyor's Formula
}
\description{
Computes the area of a polygon using the so-called Surveyor's
formula, with special-purpose faster versions for 3- and 4-gons, and a
compiled version implemented via the 'shoelace' formula.
}
\usage{
surveyors(poly,usedet=FALSE)
surveyors.3(poly)
surveyors.4(poly)
shoelace(poly)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{poly}{
A 2-column matrix containing the vertices of a polygon (x and y coordinates). 
}
\item{usedet}{
  TRUE/FALSE variable, if T, will force the use of the true surveyor's
  formula, which is 15-20x slower than the special-purpose
  triangle/4-gon code.  This is only really good for testing/validating things.
}
}
\details{
This computes the area of a polygon using the so-called 'surveyor's' formula.  It computes the sum of the determinants of each edge, which results in the area of the polygon, provided the polygon is regular (does not intersect itself, etc.).  If the polygon is not regular, it will not measure the area, because negative areas will be subtracted from positive areas.

The general surveyor's formula is pretty inefficient. We primarily
(probably exclusively) use it for 2-, 3-, and 4-gons, and so there are
special-purpose functions defined as \code{surveyors.3} and \code{surveyors.4} that
are used in these cases that are about 15-20x faster than the general
one, using the so-called 'shoelace' formula.

Calls to this function account for a lot of the efficiency of the
entire algorithm.  Currently, surveyors tests the size of the n-gon and
routes to the specialized function, which appears to add 20\% overhead.
If you know that you are dealing with a trigon or a quadrilateral, you
can cut down time by a small amount. 
even more efficiency.

The shoelace function is a compiled c function that implements the
surveyor's formula for polygons of any size.  It is not restricted to 3-
or 4-gons like surveyors.3
and surveyors.4, but is still slightly slower than these functions for
3- and 4-gons because of the overhead of calling the compiled function.
It takes about 1.5x as long as the special-purpose
surveyor's formula for 3 and 4 points, but it is not restricted on the
number of points, so is a fast replacement for the much slower
surveyors() function. Consequently, it is not currently used in the library directly.
 Note that like all surveyor's formula implementations, it will not
 handle cross-over paths appropriately.

}
\value{
returns a measure of area.
}
\references{

See Mueller et al., (2016). \url{https://sites.google.com/a/mtu.edu/mapping/}
and
B. Braden. "The Surveyor's Area Formula". The College Mathematics Journal, vol. 17, no. 4, pp. 326-337, 1986.

}
\author{
Shane T. Mueller and Brandon Perelman
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\examples{


poly <- rbind(c(1,1),c(10,1),c(5,3))
surveyors(poly)

## Profiling test for 3-gon
  poly <- rbind(c(1.1,1.2),c(2.1,3.3),c(4.1,1.2))
#system.time(for(i in 1:50000)surveyors(poly,usedet=TRUE))
#system.time(for(i in 1:50000)surveyors(poly))
#system.time(for(i in 1:50000)surveyors.3(poly))
#system.time(for(i in 1:50000)shoelace(poly))
# Profiling Test for 4-gon
poly2 <- rbind(c(1.1,1.2),c(2.2,1.3),c(4.0,4.25),c(1.3,3.9))
#system.time(for(i in 1:50000)surveyors(poly2,usedet=TRUE))
#system.time(for(i in 1:50000)surveyors(poly2))
#system.time(for(i in 1:50000)surveyors.4(poly2))
#system.time(for(i in 1:50000)shoelace(poly2))

poly3 <- cbind(runif(20),runif(20))
#system.time(for(i in 1:50000)surveyors(poly3,usedet=TRUE))
#system.time(for(i in 1:50000)shoelace(poly3))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.

