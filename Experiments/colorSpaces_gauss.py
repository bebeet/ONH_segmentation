import ONH_segmentation as experiment
import Constants as c


experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.HSV,
    weighType=c.WeightType.GAUSS,
    amplitude=120
)
experiment1.initNewExperiment(
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
    masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
    experiment_name="la*b_clahe_HSV_gauss",
)
experiment1.Run()

experiment2 = experiment.OHN_segmentation(
    color=c.ColorModel.Opponent,
    weighType=c.WeightType.GAUSS,
    amplitude=120
)
experiment2.initNewExperiment(
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
    masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
    experiment_name="la*b_clahe_Opponen_gauss",
)
experiment2.Run()




experiment3 = experiment.OHN_segmentation(
    color=c.ColorModel.RGB,
    weighType=c.WeightType.GAUSS,
    amplitude=250
)
experiment3.initNewExperiment(
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
    masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
    experiment_name="la*b_clahe_RGB_gauss",
)
experiment3.Run()


experiment4 = experiment.OHN_segmentation(
    color=c.ColorModel.LAB,
    weighType=c.WeightType.GAUSS,
    amplitude=250
)
experiment4.initNewExperiment(
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
    masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
    experiment_name="la*b_clahe_LAB_gauss",
)
experiment4.Run()