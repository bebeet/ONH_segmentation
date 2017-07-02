import ONH_segmentation as experiment
import Constants as c


experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.HSV,
    weighType=c.WeightType.NONE,
    amplitude=250
)
experiment1.initNewExperiment(
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
    masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
    experiment_name="la*b_clahe_HSV_gc",
)
experiment1.Run()

experiment2 = experiment.OHN_segmentation(
    color=c.ColorModel.Opponent,
    weighType=c.WeightType.NONE,
    amplitude=250
)
experiment2.initNewExperiment(
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
    masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
    experiment_name="la*b_clahe_Opponent_gc",
)
experiment2.Run()


experiment3 = experiment.OHN_segmentation(
    color=c.ColorModel.RGB,
    weighType=c.WeightType.NONE,
    amplitude=250
)
experiment3.initNewExperiment(
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
    masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
    experiment_name="la*b_clahe_RGB_gc",
)
experiment3.Run()


experiment4 = experiment.OHN_segmentation(
    color=c.ColorModel.LAB,
    weighType=c.WeightType.NONE,
    amplitude=250
)
experiment4.initNewExperiment(
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
    masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
    experiment_name="la*b_clahe_LAB_gc",
)
experiment4.Run()