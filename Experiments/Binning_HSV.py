import ONH_segmentation as experiment
import Constants as c
import numpy as np

for b in np.arange(2, 18 , 2):

    experiment_bin = experiment.OHN_segmentation(
        color=c.ColorModel.green,
        weighType=c.WeightType.NONE,
        histogram_binning=b
    )
    experiment_bin.initNewExperiment(
        times=10,
        images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
        experiment_name="green_lab_bin_" + str(b)
    )
    experiment_bin.Run()


    experiment_bin = experiment.OHN_segmentation(
        color=c.ColorModel.green,
        weighType=c.WeightType.NONE,
        histogram_binning=b
    )
    experiment_bin.initNewExperiment(
        times=10,
        images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe',
        experiment_name="green_hsv_bin_" + str(b)
    )
    experiment_bin.Run()