% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extract-peak-shape-info.R
\name{spotgear_identifyMajorPeaks}
\alias{spotgear_identifyMajorPeaks}
\title{Identify peaks based on the ridges in 2-D CWT coefficient matrix}
\usage{
spotgear_identifyMajorPeaks(ms, ridgeList, wCoefs,
  scales = as.numeric(colnames(wCoefs)), SNR.Th = 3, peakScaleRange = c(5,
  64), ridgeLength = 32, nearbyPeak = TRUE, nearbyWinSize = 100,
  winSize.noise = 10, SNR.method = "quantile", minNoiseLevel = 0.001,
  shape_ratio = 0.01, minPeakArea = 0.05)
}
\arguments{
\item{ms}{The autoradiointensity data}

\item{ridgeList}{Returned by \code{\link[MassSpecWavelet]{getRidge}}}

\item{wCoefs}{2-D CWT coefficients}

\item{scales}{The scales of the wavelet function to be matched to the signal.
Scales of CWT, by default it is the colnames of wCoefs}

\item{SNR.Th}{Threshold of SNR}

\item{peakScaleRange}{The CWT scale range of the peak.}

\item{ridgeLength}{The maximum ridge scale of the major peaks.}

\item{nearbyPeak}{Determine whether to include the small peaks close to large major peaks}

\item{nearbyWinSize}{The window size to determine the nearby peaks. Only effective when nearbyPeak is true.}

\item{winSize.noise}{The local window size to estimate the noise level.}

\item{SNR.method}{Method to estimate noise level. Currently, only 95 percentage quantile is supported.}

\item{minNoiseLevel}{The minimum noise level used in calculating SNR, i.e.,
if the estimated noise level is less than "minNoiseLevel", it will use "minNoiseLevel" instead. If the noise level is less than 0.5, it will be treated as the ratio to the maximum amplitude of the spectrum.}

\item{shape_ratio}{A peak should have peak area at least shape_ratio of the maximum one. Because the
same sample could be run on multiple gels with different exposure lengths, we
pick peaks relative to the maximum peak values (using shape_ratio).}

\item{minPeakArea}{The minimum area for a peak if to call a location a peak.
An important peak should have non-ignorable peak area}
}
\value{
Return a list with following elements:
\itemize{
\item \code{peakIndex} The indexes of the identified peaks
\item \code{peakValue} For identified peaks, we record the peak values to be used as peak shape information.
We will combine this crucial information with other landmark locations' "peak areas"
to form the basis for signature estimation in the Bayesian clustering model.
\item \code{peakCenterIndex}	 The indexes of peak centers, which correspond to the maximum on the ridge. peakCenterIndex includes all the peaks, not just the identified major peaks.
\item \code{peakCenterValue} The CWT coefficients (the maximum on the ridge) corresponding to peakCenterIndex
\item \code{peakSNR} The SNR of the peak, which is the ratio of peakCenterValue and noise level
\item \code{peakScale} The estimated scale of the peak, which corresponds to the peakCenerIndex
\item \code{potentialPeakIndex} The indexes of all potential peaks, which satisfy all requirements of a peak without considering its SNR. Useful, if you want to change to a lower SNR threshold later.
\item \code{allPeakIndex} The indexes of all the peaks, whose order is the same as peakCenterIndex, peakCenterValue, peakSNR and peakScale.
}
All of these return elements have peak names, which are the same as the corresponding peak ridges. see getRidge for details.
}
\description{
Indentify the peaks based on the ridge list (returned by getRidge)
in 2-D CWT coefficient matrix and estimated Signal to Noise Ratio
(SNR)
}
