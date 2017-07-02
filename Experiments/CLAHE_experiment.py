import ONH_segmentation as experiment
import Constants as c
import numpy as np

for cl in np.arange(2.0, 5.5 , 0.5):
    for g in np.arange(2, 9 , 1):

        experiment_bin = experiment.OHN_segmentation(
            color=c.ColorModel.gray,
            weighType=c.WeightType.NONE,

        )

        experiment_bin.initNewExperiment(
            times=10,
            images_path='../Dataset/RIM_ONE_r1/All_Resize/10/CLAHE/gray/'+str(g)+'/'+str(cl),
            experiment_name="CLAHE_" + str(g) + "_" + str(cl)
        )
        experiment_bin.Run()

