# Computer Vision, Spring 2019
## Homework 3
### Walkthrough 1 - `Sobel and Canny edge detection`:
* _Sobel_ edge detection threshold: `0.1055`
* _Canny_ edge detection threshold: `0.18`

### Challenge 1a - `detect edges`:
- _Sobel_ edge detection algorithm is used. 
- Value of thresholds used to detect edges in `hough_1.png`, `hough_2.png`, and `hough_3.png` are `0.1055`, `0.06`, and `0.06` respectively.

### Challenge 1b - `generateHoughAccumulator()`:
**Finetuning Hough Accumulator resolution:** 
To perform Hough Transform in theta-rho space, the number of bins used in each axis are as follows:

&theta;: 180 
&rho;: 1600

The reason for this is each bin in theta space can correspond to 1 degree and each bin in rho space corresponds to 1 pixel unit of distance. Therefore, theta space captures all possible orientations from 1 degree to 180 degrees. Similarly, the maximum possible distance of a line is the length of the maximum diagonal given for all the images which is approximately 800 pixels. Therefore all possible distances from -800 pixels to +800 pixels will be captured at a level of 1 pixel distance per bin.

**Voting Scheme:**
For voting, each bin in the accumulator array is used instead of a patch of few nearby bins. This is because the resolution chosen is just right and neither too low to deteriorate the accuracy nor too high so that it is inefficient.

In conclusion, the resolution of the Hough Accumulator chosen along with the voting algorithm gives decent results for the given images.

### Challenge 1c - `lineFinder()`:
Given the Hough accumulator returned by `generateHoughAccumulator()` in Challenge 1b, a standard threshold mechanism is used to find Hough peaks that correspond to edge lines in each image. The value of thresholds used for `hough_1.png`, `hough_2.png`, and `hough_3.png` are `110`, `50`, and `150` respectively.

The Hough accumulator is scanned and the corresponding &theta; and &rho; values for which the value accumulated is greater than the threshold are noted. The corresponding lines given by each pair of (&theta;, &rho;) values are then plotted onto the original image to indicate edge lines.

### Challenge 1d - `lineSegmentFinder()`:
To detect the end-points of the edge lines returned by `lineFinder()` in Challenge 1c, two approaches are analysed. The basic idea in both these approaches is to observe the corresponding pixels in edge points detected image (for example, from Challenge 1a), and draw the edge lines only if there exists an edge in the vicinity. The approaches are described below:

1. **Convolution:**
	
	In this approach, a filter of certain size is used to perform a _convolution_ with the edge detected image (from Challenge 1a). The convolved image now contains non zero value in some nearby pixels surrounding each edge location depending on the filter size chosen. Now, to detect the line segment ends, for each line returned by `lineFinder()`, for each location on the line, the corresponding convolved image is examined for non-zero value. If the value is indeed non-zero, one end point of the line is saved and the process is continued to detect the other end point where the corresponding pixels in convolved image are zero. Then a line is plotted between these two end points.

	Two types of filters are analysed in this approach: 'circle', and 'ones', both of width `7`. Both the filters perform identically.
2. **Dilation:**

	In this approach, a morphological operation, dilation is performed on the edge detected image (from Challenge 1a). The intuition is that after dilation, the edge pixels grow out and hence it is easier to see it's vicinity with a line. Once morphed, the approach is similar to the one described in Convolution. 

Both the approaches perform well to identify the end points of the edge lines. The final code that is submitted has Dilation implemented.