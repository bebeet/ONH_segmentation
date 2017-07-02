import ONH_segmentation as experiment
import Constants as c
import numpy as np

for l in np.arange(0.3, 1.1, 0.1):
    for s in np.arange(0.1, 1.1, 0.1):
        experiment1 = experiment.OHN_segmentation(
            color=c.ColorModel.gray,
            weighType=c.WeightType.NONE,
            lambdas=l,
            sigmas=s
        )
        experiment1.initNewExperiment(

            masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
            experiment_name="lamda_" + str(l) + "sigma" + str(s),
            times=10
        )
        # images_path='../Dataset/RIM_ONE_r1/All_Resize/10/GHE/gray',
        experiment1.Run()