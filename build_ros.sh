echo "Building ROS nodes"

cd Examples/ROS/ORB_SLAM2_withVisibilityEstimation
mkdir build
cd build
cmake .. -DROS_BUILD_TYPE=Release
make -j
