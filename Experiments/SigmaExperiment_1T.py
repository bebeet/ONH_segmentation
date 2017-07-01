import ONH_segmentation as experiment
import Constants as c
import numpy as np

for l in np.arange(0.1, 1.1, 0.1):
    for s in np.arange(0.1, 1.1, 0.1):
        experiment1 = experiment.OHN_segmentation(
            color=c.ColorModel.red,
            weighType=c.WeightType.NONE,
            lambdas=l,
            sigmas=s
        )
        experiment1.initNewExperiment(
            result_folder_name="Save_lamda_"+str(l)+"sigma"+str(s),
            times=1
        )
        experiment1.Run()