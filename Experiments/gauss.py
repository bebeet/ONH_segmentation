import ONH_segmentation as experiment
import Constants as c



exp = experiment.OHN_segmentation(
    color=c.ColorModel.red,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
exp.initNewExperiment(
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
    masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
    result_folder_name="distance_guass4",
    times=10
)


exp.Run()