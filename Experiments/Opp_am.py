import ONH_segmentation as experiment
import Constants as c
import numpy as np

for b in np.arange(50, 650 , 50):

    experiment_bin = experiment.OHN_segmentation(
        color=c.ColorModel.L,
        weighType=c.WeightType.GAUSS,
        amplitude=b
    )
    experiment_bin.initNewExperiment(
        times=10,
        experiment_name="L_lab_am" + str(b)
    )
    experiment_bin.Run()