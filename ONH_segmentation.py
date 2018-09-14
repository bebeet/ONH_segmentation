import rpy2.robjects as robjects
import os
import numpy as np
import time,sys
from Graph import Graph
import Constants as c
from datetime import date

# Assigned fixed values
directory_path = os.getcwd()
R = robjects.r
DataFrame = robjects.DataFrame


# Optic Nerve Head Segmentation Manager Class
class OHN_segmentation:

    def __init__(self,
                 histogram_binning = 10,
                 lambdas=1,
                 sigmas = 1,
                 color = c.ColorModel.red,
                 weighType = c.WeightType.NONE,
                 amplitude =1
                 ):



        # Internal Graph cut parameters
        self.lambdas = lambdas
        self.sigmas = sigmas
        self.histogram_binning = histogram_binning

        # External Graph cut parameters
        self.color = color.value
        self.weighType = weighType.value
        self.weightingFunction = None
        self.amplitude = amplitude

        # Initiate R session and set working directory for R
        R.setwd(directory_path)
        R.source('../R/LoadData/_initR_.R')


    def initNewExperiment(self,
                          times=10,
                          numfolds=10,
                          images_path='../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe',
                          masks_path='../Dataset/RIM_ONE_r1/All_Resize/10/groundtruth_all_experts',
                          experiment_name ="experiment",
                          runningTrainData=False):

        # Set paths
        self.images_path = images_path
        self.masks_path = masks_path
        self.result_folder_name = date.today().strftime("%m%d%y") + "_" + experiment_name
        self.result_path =  c.result_folder_prefix+self.result_folder_name

        #Running Info
        self.times = times
        self.numfolds = numfolds
        self.runningTrainData = runningTrainData

        self.makeResultsDir()
        # Random training and Testing data according to specified #numfolds and #times
        R.randomKFoldsdata(self.images_path, self.masks_path, self.result_path,self.times,self.numfolds)
        self.saveExperimentData()

    def loadExperiment(self,kfold_path,experiment_param_path,result_folder_name):
        # Load old experiment inoder to re-run by providing ExperimentsData.Rdata including KfoldData,internal and external parameter
        R.loadExperimentData(kfold_path,experiment_param_path)
        self.result_folder_name = date.today().strftime("%m%d%y") + "_"+result_folder_name
        self.result_path = c.result_folder_prefix+self.result_folder_name

        #Running Info
        self.times = R['times'][0]
        self.numfolds = R['numfolds'][0]
        self.runningTrainData = R['runningTrainData'][0]

        # Internal Graph cut parameters
        self.lambdas = R['lambdas'][0]
        self.sigmas = R['sigmas'][0]
        self.histogram_binning = R['histogram_binning'][0]

        # External Graph cut parameters
        self.color = R['color'][0]
        self.weighType = R['weighType'][0]
        self.amplitude = R['amplitude'][0]
        self.makeResultsDir()

    def saveExperimentData(self):

        R.saveParameter(
            result_path=self.result_path,
            image_path = self.images_path,
            mask_path = self.masks_path,
            times=self.times,
            numfolds = self.numfolds,
            runningTrainData = self.runningTrainData,
            lambdas=self.lambdas,
            sigmas=self.sigmas,
            histogram_binning=self.histogram_binning,
            color =self.color,
            weighType =self.weighType,
            amplitude=self.amplitude)


    def makeResultsDir(self):
        # Create result folder for runing experiment according to specified #numfolds and #times
        if not os.path.exists(self.result_path):
            os.makedirs(self.result_path)
        for t in np.arange(1,(self.times+1)):
            os.makedirs(self.result_path+'/T'+str(t))
            for f in np.arange(1,(self.numfolds+1)):
                os.makedirs(self.result_path + '/T' + str(t) + '/test/F' + str(f))
                if(self.runningTrainData): os.makedirs(self.result_path + '/T' + str(t) +'/train/F' + str(f))

    def Run(self):
        print("Running Experiments " + self.result_folder_name)
        self.ReportProgress(1,0)
        # Running Experiments according to specified #numfolds and #times and setting parameters
        # Runing by #times
        for t in np.arange(1,(self.times+1)):
            # Runing by #numfolds
            for f in np.arange(1,(self.numfolds+1)):

                # Retrive dataset
                dataTest = R['dataTest_T' + str(t) +"_F" + str(f)]
                dataTrain = R['dataTrain_T' + str(t) +"_F" + str(f)]
                dataTrainMask = R['dataTrainMask_T' + str(t)+"_F" + str(f)]


                dataTest.name = dataTest.rx2(1)
                dataTest.path = dataTest.rx2(2)

                dataTrain.name = dataTrain.rx2(1)
                dataTrain.path = dataTrain.rx2(2)
                dataTrainMask.name = dataTrainMask.rx2(1)
                dataTrainMask.path = dataTrainMask.rx2(2)

                #starttime = time.time()

                result_folder = self.result_path + '/T' + str(t) + '/test/F'+str(f)
                #change to result folder
                trainedHistogram = R.Histogram(dataTrain.path, dataTrainMask.path,self.result_path,t,f, self.color,self.histogram_binning)
                if(c.WeightType.NONE.value.__ne__(self.weighType)):
                    self.weightingFunction = R.WeightingFunction(dataTrainMask.path,self.result_path,t,f,self.weighType,self.amplitude)
                else: self.weightingFunction = robjects.NULL
                #print("Training Time = %s" % (time.time() - starttime))

                for i in np.arange(0,len(dataTest.path)):
                    #starttime = time.time()
                    graphcut = Graph(dataTest.path[i])
                    graphcut.graphConstruction(self.sigmas,self.lambdas,trainedHistogram,self.color,self.weightingFunction,save_path=result_folder)
                    graphcut.maxflow_mincut(save_path=result_folder,imname=dataTest.name[i])
                    #print("Segment Time = %s" % (time.time() - starttime))
                if(self.runningTrainData):
                    for i in np.arange(0, len(dataTrain.path)):
                        graphcut = Graph(dataTrain.path[i])
                        graphcut.graphConstruction(self.sigmas, self.lambdas, trainedHistogram,self.color,self.weightingFunction,save_path=result_folder)
                        graphcut.maxflow_mincut(save_path=result_folder, imname=dataTest.name[i])

                self.ReportProgress(t,f)
        print("\n")


        R.Evaluation(
            result_path=self.result_path,
            masks_path=self.masks_path,
            experiment_name =self.result_folder_name,
            dataset="RIMONE r1",
            times=self.times,
            numfolds=self.numfolds,
            histogram_binning=self.histogram_binning,
            lambdas=self.lambdas,
            sigmas=self.sigmas,
            color=self.color,
            runningTrainData=self.runningTrainData,
            amplitude=self.amplitude,
            weighType=self.weighType

        )



    def LoadSegmentModel(self,trainedHistogram,trainedWeightingFunction):
        # Segment by used trained model return from OHN_segmentation
        print("not available")

    def Segment(self,image):
        # Segment by used trained model return from OHN_segmentation
        print("not available")

    def ReportProgress(self,t,f):
        allfold = self.times * self.numfolds
        currentfold = ((t - 1) * 10)+ f
        percentComplete = (currentfold*100)/allfold
        time.sleep(0.1)
        sys.stdout.write("\r Progress - [ %d" % percentComplete + "% ] ")
        sys.stdout.flush()


    def EvaluateResult(self, folder_name):
        R.source('../R/Evaluation/runEvaluation.R')
        R.runEvalution(c.result_folder_prefix, self.masks_path, folder_name)