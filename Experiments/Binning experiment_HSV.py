import ONH_segmentation as experiment
import Constants as c
import numpy as np

for b in np.arange(12, 18 , 2):

    experiment_bin = experiment.OHN_segmentation(
        color=c.ColorModel.red,
        weighType=c.WeightType.NONE,
        histogram_binning=b
    )
    experiment_bin.initNewExperiment(
        times=10,
        images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe',
        experiment_name="red_hsv_bin_" + str(b)
    )
    experiment_bin.Run()
