# Computer Vision, Spring 2019
## Homework 6 - `Refocusing App`
Refocusing app based on a focal stack - sequence of images captured at different focus settings.
### Challenge 1a - `Index Map`:
Generates an index map which is an image with each pixel correspoinding to the index of the best focused layer at the corresponding scene point from the focal stack. Modified Laplacian is used as the focus measure to determine how focused a scene point is in an image. Then the index map is averaged to smoothen out the effect of noise.

### Challenge 1b:
Asks user to repeatedly choose a scene point and displays the image with the chosen scene point in focus. Here is a demo:

![RefocusApp](RefocusingApp.gif?raw=true "RefocusApp")
