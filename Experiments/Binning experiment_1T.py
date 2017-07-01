import ONH_segmentation as experiment
import Constants as c
import numpy as np

for b in np.arange(2, 20 , 2):


    experiment_bin = experiment.OHN_segmentation(
        color=c.ColorModel.red,
        weighType=c.WeightType.NONE,
        histogram_binning=b
    )
    experiment_bin.initNewExperiment(
        times=1,
        result_folder_name="Saved_red_bin_" + str(b)
    )
    experiment_bin.Run()
