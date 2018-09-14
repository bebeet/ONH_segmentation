import ONH_segmentation as experiment
import Constants as c
import numpy as np
#
# for i in np.arange(10, 11, 1):
#     experiment1 = experiment.OHN_segmentation(
#         color=c.ColorModel.gray,
#         weighType=c.WeightType.NONE,
#         histogram_binning=12,
#         lambdas=i
#     )
#     experiment1.initNewExperiment(
#         images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
#         masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
#         experiment_name="LAB_12bins_lamda_" + str(i),
#         times=10
#     )
#     experiment1.Run()



for i in np.arange(10, 11, 1):
    experiment1 = experiment.OHN_segmentation(
        color=c.ColorModel.gray,
        weighType=c.WeightType.NONE,
        histogram_binning=12,
        lambdas=i
    )
    experiment1.initNewExperiment(
        images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe',
        masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
        experiment_name="HSV_12bins_lamda_" + str(i),
        times=10
    )
    experiment1.Run()
