#initiate R package
library(EBImage)
library(CRImage)
library(reshape2)
library(ggplot2)
library(jpeg)
library(lattice)
library(parallel)
library(dplyr)
library(RTOMO)


# load R functions
source('../R/LoadData/randomKfoldsData.R')
source('../R/LoadData/saveParameter.R')
source('../R/LoadData/loadExperimentData.R')
source('../R/Graphcut/computeBoundaryTerm.R')
source('../R/Graphcut/computeDist.R')
source('../R/Graphcut/computeProbability.R')
source('../R/Graphcut/getBinningData.R')
source('../R/Graphcut/getBoundaryTerm.R')
source('../R/Graphcut/getColorVector.R')
source('../R/Graphcut/getImageData.R')
source('../R/Graphcut/getNeighbors.R')
source('../R/Graphcut/getProbability.R')
source('../R/Graphcut/getRegionTerm.R')
source('../R/Graphcut/Histogram.R')
source('../R/Graphcut/normalizeData.R')
source('../R/Graphcut/WeightingFunction.R')
source('../R/Evaluation/imOratio.R')
source('../R/Evaluation/summarySE.R')
source('../R/Evaluation/Evaluation.R')


