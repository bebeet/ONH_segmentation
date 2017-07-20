import ONH_segmentation as experiment
import Constants as c


exp = experiment.OHN_segmentation(
    color=c.ColorModel.red,
    weighType=c.WeightType.NONE,
    amplitude=100
)
exp.initNewExperiment(
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
    masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
    experiment_name="16_neight_Red_NONE_0",
    times=10
)
exp.Run()

exp = experiment.OHN_segmentation(
    color=c.ColorModel.red,
    weighType=c.WeightType.GAUSS,
    amplitude=100
)
exp.initNewExperiment(
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
    masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
    experiment_name="16_neight_Red_GAUSS00",
    times=10
)
exp.Run()


