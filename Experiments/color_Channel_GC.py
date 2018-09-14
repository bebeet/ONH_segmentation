import ONH_segmentation as experiment
import Constants as c
experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.gray,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
experiment1.initNewExperiment(
    experiment_name="gray_gauss50_sv",
)
experiment1.Run()

experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.red,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
experiment1.initNewExperiment(
    experiment_name="red_gauss50_sv",
)
experiment1.Run()

experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.green,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
experiment1.initNewExperiment(
    experiment_name="green_gauss50_sv",
)
experiment1.Run()

experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.blue,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
experiment1.initNewExperiment(
    experiment_name="blue_gauss50_sv",
)
experiment1.Run()

experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.H,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
experiment1.initNewExperiment(
    experiment_name="H_gauss50_sv_sv",
)
experiment1.Run()

experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.S,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
experiment1.initNewExperiment(
    experiment_name="S_gauss50_sv",
)
experiment1.Run()


experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.V,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
experiment1.initNewExperiment(
    experiment_name="V_gauss50_sv",
)
experiment1.Run()


experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.L,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
experiment1.initNewExperiment(
    experiment_name="L_gauss50_sv",
)
experiment1.Run()


experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.A,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
experiment1.initNewExperiment(
    experiment_name="A_gauss50_sv",
)
experiment1.Run()

experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.B,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
experiment1.initNewExperiment(
    experiment_name="B_gauss50_sv",
)
experiment1.Run()

experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.O1,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
experiment1.initNewExperiment(
    experiment_name="O1_gauss50_sv",
)
experiment1.Run()

experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.O2,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
experiment1.initNewExperiment(
    experiment_name="O2_gauss50_sv",
)
experiment1.Run()

experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.O3,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
experiment1.initNewExperiment(
    experiment_name="O3_gauss50_sv",
)
experiment1.Run()