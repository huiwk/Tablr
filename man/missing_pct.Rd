% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/missing_pct.r
\name{missing_pct}
\alias{missing_pct}
\title{output missing and percentage in a nice format}
\usage{
missing_pct(dat, missing.pct.pars, dp, p1, p2)
}
\arguments{
\item{dat}{your cohort data file, of \code{data.frame} structure. For more details please refer the iris dataset.
\tabular{rrrrl}{
  \strong{Sepal.Length} \tab \strong{Sepal.Width} \tab \strong{Petal.Length} \tab \strong{Petal.Width} \tab \strong{Species} \cr
  5.1 \tab 3.5 \tab 1.4 \tab 0.2 \tab setosa\cr
  4.9 \tab 3.0 \tab 1.4 \tab 0.2 \tab setosa\cr
  4.7 \tab 3.2 \tab 1.3 \tab 0.2 \tab setosa\cr
  4.6 \tab 3.1 \tab 1.5 \tab 0.2 \tab setosa\cr
  5.0 \tab 3.6 \tab 1.4 \tab 0.2 \tab setosa\cr
  5.4 \tab 3.9 \tab 1.7 \tab 0.4 \tab setosa
}}

\item{missing.pct.pars}{a \code{character} vector which stores all parameter name that need missing pct calculation.}

\item{dp}{a \code{numeric} variable, number of decimal places to display.}

\item{p1}{a \code{string} variable, the separator appeared between missing and pct. i.e. \code{<missing><p1><pct><p2>}}

\item{p2}{a \code{string} variable, the separator appeared after pct. i.e. \code{<missing><p1><pct><p2>}}
}
\description{
This function gives a table of listing parameters' missing and pct
}
\examples{
\dontrun{
# d<-dat
# p<-get.stat.par(par,par$Parameters))
# missing.pct.p<-as.vector(p[["missing.pct."]])
# missing.pct.dp<-2
# missing.pct.p1<-"("
# missing.pct.p2<-")"
# missing_pct(d,missing.pct.p,missing.pct.dp,missing.pct.p1,missing.pct.p2)}
}
