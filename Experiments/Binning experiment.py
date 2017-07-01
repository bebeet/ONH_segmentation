import ONH_segmentation as experiment
import Constants as c
import numpy as np

for b in np.arange(2, 20 , 2):

    experiment_bin = experiment.OHN_segmentation(
        color=c.ColorModel.gray,
        weighType=c.WeightType.NONE,
        histogram_binning=b
    )
    experiment_bin.initNewExperiment(
        times=10,
        result_folder_name="experiment_gray_bin_"+str(b)
    )
    experiment_bin.Run()

    experiment_bin = experiment.OHN_segmentation(
        color=c.ColorModel.red,
        weighType=c.WeightType.NONE,
        histogram_binning=b
    )
    experiment_bin.initNewExperiment(
        times=10,
        result_folder_name="experiment_red_bin_" + str(b)
    )
    experiment_bin.Run()
