import ONH_segmentation as experiment
import Constants as c



experiment4 = experiment.OHN_segmentation(
    color=c.ColorModel.Opponent,
    weighType=c.WeightType.NONE
)
experiment4.initNewExperiment(
    experiment_name="Opp_gc",
)
experiment4.Run()