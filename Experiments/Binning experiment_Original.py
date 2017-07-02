import ONH_segmentation as experiment
import Constants as c
import numpy as np

for b in np.arange(2, 18, 2):
    experiment_bin = experiment.OHN_segmentation(
        color=c.ColorModel.red,
        weighType=c.WeightType.NONE,
        histogram_binning=b
    )
    experiment_bin.initNewExperiment(
        images_path='../Dataset/RIM_ONE_r1/All_Resize/10/original',
        result_folder_name="experiment_ori_red_bin_" + str(b),
        times=10
    )
    experiment_bin.Run()


for b in np.arange(2, 18, 2):
    experiment_bin = experiment.OHN_segmentation(
        color=c.ColorModel.gray,
        weighType=c.WeightType.NONE,
        histogram_binning=b
    )
    experiment_bin.initNewExperiment(
        images_path='../Dataset/RIM_ONE_r1/All_Resize/10/original',
        result_folder_name="experiment_ori_gray_bin_" + str(b),
        times=10
    )
    experiment_bin.Run()