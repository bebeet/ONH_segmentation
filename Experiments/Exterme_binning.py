import ONH_segmentation as experiment
import Constants as c
import numpy as np

b=100

experiment_bin = experiment.OHN_segmentation(
        color=c.ColorModel.red,
        weighType=c.WeightType.NONE,
        histogram_binning=b
    )
experiment_bin.initNewExperiment(
        times=10,
        experiment_name="experiment_gray_bin_" + str(b)
    )
experiment_bin.Run()