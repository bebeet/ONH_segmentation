import ONH_segmentation as experiment
import Constants as c

# experiment1 = experiment.OHN_segmentation(
#     color=c.ColorModel.gray,
#     histogram_binning=12,
#     weighType=c.WeightType.NONE
# )
# experiment1.initNewExperiment(
#     experiment_name="gray_bin12_HSV",
#     images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe'
# )
# experiment1.Run()
#
# experiment1 = experiment.OHN_segmentation(
#     color=c.ColorModel.red,
#     histogram_binning=12,
#     weighType=c.WeightType.NONE
# )
# experiment1.initNewExperiment(
#     experiment_name="red_bin12_HSV",
#     images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe'
# )
# experiment1.Run()
#
# experiment1 = experiment.OHN_segmentation(
#     color=c.ColorModel.green,
#     histogram_binning=12,
#     weighType=c.WeightType.NONE
# )
# experiment1.initNewExperiment(
#     experiment_name="green_bin12_HSV",
#     images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe'
# )
# experiment1.Run()
#
# experiment1 = experiment.OHN_segmentation(
#     color=c.ColorModel.blue,
#     histogram_binning=12,
#     weighType=c.WeightType.NONE
# )
# experiment1.initNewExperiment(
#     experiment_name="blue_bin12_HSV",
#     images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe'
# )
# experiment1.Run()
experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.gray,
    histogram_binning=12,
    weighType=c.WeightType.GAUSS,
    amplitude=250
)
experiment1.initNewExperiment(
    experiment_name="gray_LAB_am250",
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe'
)
experiment1.Run()


