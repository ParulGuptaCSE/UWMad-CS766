# UWMad-CS766

## Homework 1 - Getting started with MATLAB:
Goal of this homework is to learn how to create collages and how to superimpose images.

## Homework 2 - Object Detection:
Goal of this assignment is to build an object detection program which identifies simple planar geometric shapes using template matching.

Some results from this implementation are shown below, where left image has the source objects which are identified in right image:
<p float="left">
	<img src="Assignments/HW2/src/two_objects.png" width="250" />
	<img src="Assignments/HW2/src/testing1c1_many_objects_1.png" width="400" />
</p>

<p float="left">
	<img src="Assignments/HW2/src/many_objects_1.png" width="250" />
	<img src="Assignments/HW2/src/testing1c2_many_objects_1.png" width="400" />
</p>


See [README](Assignments/HW2/src/README.md) for more details.

## Homework 3 - Edge Detection:
In this homework, edges detection is implemented using Hough Transform. The detected edges are then extended to draw straight lines and the lines are trimmed to detect the edge segments.

One sample is shown below:

![Edge](Assignments/HW3/src/croppedline_hough_1.png?raw=true "Edge")

See [README](Assignments/HW3/src/README.md) for more details.

## Homework 4 - Image Stitching:
In this homework, images are stitched to create panoramas. The main idea is to extract corresponding matching points between adjacent images using SIFT algorithm and then warping the images in the plane of any one using Homography.

One sample panaroma is shown below:
![Pano](Assignments/HW4/src/manhattan_panorama.png?raw=true "Pano")
See [README](Assignments/HW4/src/README.md) for more details.
