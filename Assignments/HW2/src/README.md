# Computer Vision, Spring 2019
## Homework 2
### Walkthrough 1:
* Value of threshold to convert gray-level to binary image: `0.4`
* Number of dilations followed by erosions to remove the noise: `5`
* Number of erosions followed by dilations to remove the rice grains: `10`

### Challenge 1a:
- Value of threshold to convert gray-level to binary image: `0.5`

### Challenge 1b: 
Additional property, _Area of the object_ is stored in the 7th row of the object database.

### Challenge 1c: 
**Comparator for Recognizing Objects:**
I used a combination of roundedness and second moment of inertia to compare candidate objects for similarity. Same objects are expected to have equal roundedness. But because of noise, there can be a minute difference between the roundedness of two objects which are identical. So a threshold of `0.02625` has been empirically set for roundedness. Also, identical objects of similar size are expected to have similar second moment of inertia. Therefore, a threshold of `15.0%` has been set as the allowed change in second moment of inertia of the objects. 
> **TLDR:** Roundedness with `~0.03` tolerance and Second Moment with `15%` tolerance.