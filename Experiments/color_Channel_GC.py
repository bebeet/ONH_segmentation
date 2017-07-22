import ONH_segmentation as experiment
import Constants as c


experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.O3,
    weighType=c.WeightType.GAUSS,
    amplitude=200
)
experiment1.initNewExperiment(
    experiment_name="O3_gauss200_sv",
)
experiment1.Run()