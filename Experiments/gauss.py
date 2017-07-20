import ONH_segmentation as experiment
import Constants as c



exp = experiment.OHN_segmentation(
    color=c.ColorModel.red,
    weighType=c.WeightType.GAUSS,
    amplitude=100,
    histogram_binning=12
)
exp.initNewExperiment(
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
    masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
    experiment_name="GAUSS_bin_12",
    times=10
)


exp.Run()