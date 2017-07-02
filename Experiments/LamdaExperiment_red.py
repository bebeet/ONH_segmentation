import ONH_segmentation as experiment
import Constants as c
import numpy as np

for i in np.arange(0.6, 1.1, 0.1):

    experiment2 = experiment.OHN_segmentation(
        color=c.ColorModel.red,
        weighType=c.WeightType.NONE,
        lambdas=i
    )
    experiment2.initNewExperiment(
        images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
        masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
        experiment_name="lamda_red_" + str(i),
        times=10
    )
    experiment2.Run()