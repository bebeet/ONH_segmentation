import numpy as np
import maxflow
import rpy2.robjects as robjects
R = robjects.r
from matplotlib import pyplot as ppl
from scipy.misc import imread
import pandas as pd

class Graph:
    def __init__(self,
                 image_path):

        # Read test image from file path
        self.image_path=image_path
        self.image = imread(image_path)
        self.width = self.image.shape[1]
        self.hight = self.image.shape[0]

        # Create the graph.
        self.g = maxflow.Graph[int](0, 0)

        # Add the nodes according to image shape. nodeids has the identifiers of the nodes in the grid.
        img_shape = np.arange(0, self.width * self.hight, 1).reshape(self.hight, self.width)
        self.nodeids = self.g.add_grid_nodes(img_shape.shape)


    def graphConstruction(self,sigma,lamba,TrainedHistogram, color,weighFunction,save_path):

        # Calculate nLink weight
        # print("--------nLink-----------------")
        R.source('../R/Graphcut/getBoundaryTerm.R')
        nLink = R.getBoundaryTerm(self.image_path,sigma,color,save_path)
        # print(nLink)
        # print("---------end nlink----------------")

        node_p = nLink.rx2(1)
        node_q = nLink.rx2(2)
        px = nLink.rx2(3)
        py = nLink.rx2(4)
        qx = nLink.rx2(5)
        qy = nLink.rx2(6)
        similarity =nLink.rx2(7)
        dist = nLink.rx2(8)
        weight = nLink.rx2(9)

        # Add the boundary edges.
        for index in range(0, self.width * self.hight):
            self.g.add_edge(node_p[index] - 1, node_q[index] - 1, weight[index], weight[index])
            # print("---------- check n ---------")
            # print("node_p="+str(node_p[index]-1))
            # print("node_q="+str(node_q[index]-1))
            # print("Ip="+str(Ip[index]) + " " +"Iq="+str(Iq[index]))
            # print("Weigth="+str(weight[index]))

        # Calculate region term weight
        # print("--------tLink-----------------")
        R.source('../R/Graphcut/getRegionTerm.R')

        tLink = R.getRegionTerm(self.image_path, lamba, TrainedHistogram,weighFunction,save_path)
        # print("---------end tlink----------------")

        nodeid = tLink.rx2(1)
        intensity = tLink.rx2(2)
        s_weight = tLink.rx2(3)
        t_weight = tLink.rx2(4)

        # Add the terminal edges.
        for index in range(0, self.width * self.hight):
            self.g.add_tedge(nodeid[index], t_weight[index], s_weight[index])
            # print "---------- check t ---------"
            # print("nodGrayIntensityeid="+str(nodeid))
            # print("t_weight="+str(t_weight[index]))
            # print("s_weight="+str(s_weight))


    def maxflow_mincut(self,save_path,imname):
        # Compute Maxflow-mincut
        flow = self.g.maxflow()
        #print ("Maximum flow:", flow)

        # Get the segments of the nodes in the grid.
        sgm = self.g.get_grid_segments(self.nodeids)
        res_img = np.int_(np.logical_not(sgm))

        # Save the result.
        ppl.imsave(save_path+'/'+imname+'.png', res_img, cmap=ppl.cm.gray)
