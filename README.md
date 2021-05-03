# ORB-SLAM2 SVE
ORB-SLAM2 SVE (or ORB-SLAM2 with Scene Visbility Estimation) is a modified version of the original ORB-SLAM2 SLAM framework. The original GitHub repository is located [here](https://github.com/raulmur/ORB_SLAM2). 

The modifications were made in support of my final year research project in partial fulfilment of the requirements for my degree at the University of Sheffield. The research project is titled 'Online Scene Visibility Estimation as a Complement to SLAM in UAVs', and can be found here.

The full repository containing supplementary code for dataset packaging and processing is located [here](https://github.com/rdehaggart1/sceneVisibilityInSLAM)

NOTE: A monocular VI-SLAM version of this repository is available via a modified ORB-SLAM3, though throughout testing it became obvious that due to the relative age of ORB-SLAM3, it is still suffering from some serious bugs. ([ORB-SLAM3](https://github.com/UZ-SLAMLab/ORB_SLAM3), [ORB-SLAM3 SVE](https://github.com/rdehaggart1/ORB_SLAM3_SVE))

# 1. Original Authors and Decription

**Authors:** [Raul Mur-Artal](http://webdiis.unizar.es/~raulmur/), [Juan D. Tardos](http://webdiis.unizar.es/~jdtardos/), [J. M. M. Montiel](http://webdiis.unizar.es/~josemari/) and [Dorian Galvez-Lopez](http://doriangalvez.com/) ([DBoW2](https://github.com/dorian3d/DBoW2))

ORB-SLAM2 is a real-time SLAM library for **Monocular**, **Stereo** and **RGB-D** cameras that computes the camera trajectory and a sparse 3D reconstruction (in the stereo and RGB-D case with true scale). It is able to detect loops and relocalize the camera in real time. We provide examples to run the SLAM system in the [KITTI dataset](http://www.cvlibs.net/datasets/kitti/eval_odometry.php) as stereo or monocular, in the [TUM dataset](http://vision.in.tum.de/data/datasets/rgbd-dataset) as RGB-D or monocular, and in the [EuRoC dataset](http://projects.asl.ethz.ch/datasets/doku.php?id=kmavvisualinertialdatasets) as stereo or monocular. We also provide a ROS node to process live monocular, stereo or RGB-D streams. **The library can be compiled without ROS**. ORB-SLAM2 provides a GUI to change between a *SLAM Mode* and *Localization Mode*, see section 9 of this document.

# 2. Dependencies

Please see the [original ORB-SLAM2 repository](https://github.com/raulmur/ORB_SLAM2) and ensure that before using this repository, you have all the dependincies required by the original installed on your machine.

# 3. Modifications

The set modifications made to the original source code in support of this project is described below:

<i>Frame.cc</i>
- Calculate SVE_a by dividing the number of extracted features by the user-defined maximum.
- Calculate SVE_b by segmenting each frame into a number of bins, and counting the number of features extracted in each. Use this distribution to calculate the chi-square histogram distribution statistic against a homogenous distribution of points.

<i>Tracking.cc</i>
- Count how many of the existing points in the local map theoretically are located within the frustum of the camera, then calculate SVE_c by working ut how many of these map points have been successfully tracked in each frame.

<i>System.cc</i>
- Combine the 3 metrics into a single value, and for each frame, store all components with a timestamp in vectors. 
- A new function then accesses these vectors and writes all values to a file 'SceneVisibilityEstimation.txt' for analysis.

<i>Extra</i>
- The project is renamed to `ORB_SLAM2_SVE` so the ROS package is distinct from the original. Similar adjustments are made throughout for build support and readability. 
- .yaml setup files are included for the datasets tested through this project in `../Examples/Monocular/`.
 
