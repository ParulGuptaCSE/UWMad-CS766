# Computer Vision, Spring 2019
## Homework 4 - `Image Mosaicking App`
### Challenge 1a - [Homography](https://en.wikipedia.org/wiki/Homography_(computer_vision)):
Computes Homography, `H`, which relates the transformation of a source image to a destination image. Given a homography, `H`, for every source point `p<sub>s</sub>`, the corresponding destination point, `p<sub>d</sub>` is given by `p<sub>d</sub> = H * p<sub>s</sub>`.

### Challenge 1b - Warping an Image to Canvas:
Given a source image and the result to source homography, this routine transforms the source image and warps it onto the canvas. After tranformation, there might be some places in the destination which might not have corresponded to any pixel due to stretching. Hence, it also uses `interp2` inbuilt function to interpolate the missing pixels.

### Challenge 1c - [RANSAC](https://en.wikipedia.org/wiki/Random_sample_consensus):
To compute homography between two adjacent images which are to be stitched, we need some corresponding matching point coordinates. We can use [SIFT](https://en.wikipedia.org/wiki/Scale-invariant_feature_transform) algorithm to generate the same. But, SIFT produces lot of points which appear similar but might just be noise. _RANdom SAmple Consensus_ algorithm is then used to get rid of the outliers and only plot corresponding matching points in two images.

### Challenge 1d - Blending:
Inorder to remove sharp boundaries in the panorama after stitching images, the images are combined using _Weighted Blending_ technique. In this technique, a weighted mask is used in which pixels closer to the edge get a lower weight. An inbuilt function, `bwdist` is used for this purpose. 

### Challenge 1(e, f) - Stitching Images:
All the subroutines written above are called to build the panorama. This method accepts arbitrary number of images and aligns them to stitch into a panorama.

Here are some beautiful sample panoramas created by this tool:

![Mountains](mountain_panorama.png?raw=true "Mountains")

![Manhattan Skyline](manhattan_panorama.png?raw=true "Manhattan Skyline")
