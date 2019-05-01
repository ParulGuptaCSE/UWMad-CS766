# Computer Vision, Spring 2019
## Homework 7 - `Optical Flow and Object Tracking`

---
### Challenge 1 - `Optical Flow System`
Given two consecutive images, correspondances between points are established using template matching. A small window around each image point in the first image is used as a template and searched in a small search window around the corresponding pixel in the second image. MATLAB function `normxcorr2` is used to find the point in the second image that is maximally correlated with the first point. The optical flow (vector between the corresponding points) is then plotted using MATLAB function `quiver`.

#### Parameters:
The *search half window size* used is 36 whereas the *template half window size* used is 24. The optical flow vectors are computed on a grid of resolution 32x24 for the given images of size 320x240 pixels.

Below animation shows the optical flow needle map:
<p float="left">
	<img src="flow.gif" width="300" />
	<img src="result.gif" width="300" />
</p>

---
### Challenge 2 - `Object Tracking`
Assuming that the color distribution of an object remains relatively the same across various video frames, a color histogram based object tracking system is developed. MATLAB function `rgb2ind` is used to divide the color range of an image into several bins. `histc` is then used to compute the color histogram of the image which is transformed into columns using `im2col`. The histogram of the template of the object that is to be tracked is then searched in a small window around the selected rectangle in each frame and the rectangel with the maximum histogram similarity with the template is assumed to be the object location. `L2-norm` similarity measure was used to compare two histograms.

#### Parameters:
The *search half window size* used is 7 and the *number of bins* used for computing color histogram is 64.

Below gif shows some results of the object tracking application:

![Soccer](rolling_ball_result/result.gif?raw=true "Soccer")

![Basketball](basketball_result/result.gif?raw=true "Basketball")

---