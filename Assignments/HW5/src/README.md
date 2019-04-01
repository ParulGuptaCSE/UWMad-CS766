# Computer Vision, Spring 2019
## Homework 5 - `Photometric Stereo`
Recovering shape, surface normal and reflectance of an object using photometric stereo.
### Challenge 1b:
**Computing normal vectors for points on the sphere's surface:**

Let the radius of the sphere by `r`. Let the x-axis and y-axis be chosen according to the MATLAB's convention (that is x-axis is horizontally right and y-axis is vertically down), and let the center of the orthographic projection of the sphere be the origin. Now, the z-axis is in the direction of into the plane according right-hand coordinate system. 

Consider a point `(x, y)` inside the orthographic projected circle in xy-plane. Now, the normal vector of the sphere for this point is a vector from the center of the sphere to the point on sphere whose projection on xy-plane is `(x, y)`. Let this point on the sphere by `(x, y, z)`. Clearly, the normal vector is `[x, y, z]'`. To compute the z-coordinate of the point, consider a right angled triangle with base `sqrt(x^2+y^2)` and hypotenuse `r`. Therefore, the z coordinate is `sqrt(r^2 - (x^2 + y^2))` and the normal vector is `[x, y, sqrt(r^2 - (x^2 + y^2))]'`

**Finding the direction of light source:**

The brightness of a surface that obeys a Lambertian model is directly proportional to the dot product of the surface normal and the light source direction (from Lambertian Model slides). Thus, for a sphere, the normal vector at the surface point which is brightest is the direction of the light source (`Cos0 = 1`). Even after orghographic projection, the x and y coordinates of the brightest point doesn't change. Thus, we can use the x and y coordinates of the brightest point in the orthographic projection and compute the normal vector at that location as described above to find the direction of the light source.

### Challenge 1d:
The below visualization shows the 3D shape that has been reconstructed for a vase which was photographed in 5 different light conditions.

<p float="left">
	<img src="vase3.png" width="200" />
	<img src="vase4.png" width="200" />
	<img src="vase5.png" width="200" />
</p>

![Surf](Vase_ReconstructedSurface.gif?raw=true "3DSurf")