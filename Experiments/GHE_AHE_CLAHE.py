import ONH_segmentation as experiment
import Constants as c
import numpy as np

for g in np.arange(8, 9 , 1):

    experiment_bin = experiment.OHN_segmentation(
        color=c.ColorModel.gray,
        weighType=c.WeightType.NONE,

    )
    experiment_bin.initNewExperiment(
        times=10,
        images_path='../Dataset/RIM_ONE_r1/All_Resize/10/AHE/gray/'+str(g),
        result_folder_name="AHE_"+str(g)
    )
    experiment_bin.Run()
