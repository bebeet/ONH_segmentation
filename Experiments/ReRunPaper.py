import ONH_segmentation as experiment
import Constants as c


experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.red,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
experiment1.loadExperiment(
    kfold_path="../ExperimentResults/paper_experimentdata/Paper_version_foldsDatas3.csv",
    experiment_param_path="../ExperimentResults/paper_experimentdata/ExperimentsData.Rdata",
    result_folder_name="rerun_paper_version_amp100",

)

experiment1.Run()