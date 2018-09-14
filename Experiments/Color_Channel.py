import ONH_segmentation as experiment
import Constants as c
# experiment1 = experiment.OHN_segmentation(
#     color=c.ColorModel.gray,
#     histogram_binning=12,
#     weighType=c.WeightType.NONE,lambdas=0.5
# )
# experiment1.initNewExperiment(
#     experiment_name="gray_bin12_HSV_LAMDA0.5",
#     images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe'
# )
# experiment1.Run()
#
# experiment1 = experiment.OHN_segmentation(
#     color=c.ColorModel.red,
#     histogram_binning=12,
#     weighType=c.WeightType.NONE,lambdas=0.5
# )
# experiment1.initNewExperiment(
#     experiment_name="red_bin12_HSV_LAMDA0.5",
#     images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe'
# )
# experiment1.Run()
#
# experiment1 = experiment.OHN_segmentation(
#     color=c.ColorModel.green,
#     histogram_binning=12,
#     weighType=c.WeightType.NONE,lambdas=0.5
# )
# experiment1.initNewExperiment(
#     experiment_name="green_bin12_HSV_LAMDA0.5",
#     images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe'
# )
# experiment1.Run()
#
# experiment1 = experiment.OHN_segmentation(
#     color=c.ColorModel.blue,
#     histogram_binning=12,
#     weighType=c.WeightType.NONE,lambdas=0.5
# )
# experiment1.initNewExperiment(
#     experiment_name="blue_bin12_HSV_LAMDA0.5",
#     images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe'
# )
# experiment1.Run()
# #
# experiment1 = experiment.OHN_segmentation(
#     color=c.ColorModel.H,
#     histogram_binning=12,
#     weighType=c.WeightType.NONE,lambdas=0.5
# )
# experiment1.initNewExperiment(
#     experiment_name="H_bin12_HSV_LAMDA0.5",
#     images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe'
# )
# experiment1.Run()
#
# experiment1 = experiment.OHN_segmentation(
#     color=c.ColorModel.S,
#     histogram_binning=12,
#     weighType=c.WeightType.NONE,lambdas=0.5
# )
# experiment1.initNewExperiment(
#     experiment_name="S_bin12_HSV_LAMDA0.5",
#     images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe',
# )
# experiment1.Run()
#
#
# experiment1 = experiment.OHN_segmentation(
#     color=c.ColorModel.V,
#     histogram_binning=12,
#     weighType=c.WeightType.NONE,lambdas=0.5
# )
# experiment1.initNewExperiment(
#     experiment_name="V_bin12_HSV_LAMDA0.5" ,
#     images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe',
# )
# experiment1.Run()


experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.L,
    histogram_binning=12,
    weighType=c.WeightType.NONE,lambdas=0.5
)
experiment1.initNewExperiment(
    experiment_name="L_bin12_HSV_LAMDA0.5",
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe',
)
experiment1.Run()


experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.A,
    histogram_binning=12,
    weighType=c.WeightType.NONE,lambdas=0.5
)
experiment1.initNewExperiment(
    experiment_name="A_bin12_HSV_LAMDA0.5",
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe',
)
experiment1.Run()

experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.B,
    histogram_binning=12,
    weighType=c.WeightType.NONE,lambdas=0.5
)
experiment1.initNewExperiment(
    experiment_name="B_bin12_HSV_LAMDA0.5",
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe',
)
experiment1.Run()

experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.O1,
    histogram_binning=12,
    weighType=c.WeightType.NONE,lambdas=0.5
)
experiment1.initNewExperiment(
    experiment_name="O1_bin12_HSV_LAMDA0.5",
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe',
)
experiment1.Run()

experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.O2,
    histogram_binning=12,
    weighType=c.WeightType.NONE,lambdas=0.5
)
experiment1.initNewExperiment(
    experiment_name="O2_bin12_HSV_LAMDA0.5",
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe',
)
experiment1.Run()

experiment1 = experiment.OHN_segmentation(
    color=c.ColorModel.O3,
    histogram_binning=12,
    weighType=c.WeightType.NONE,lambdas=0.5
)
experiment1.initNewExperiment(
    experiment_name="O3_bin12_HSV_LAMDA0.5",
    images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_sv_clahe',
)
experiment1.Run()