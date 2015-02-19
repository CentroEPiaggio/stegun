# STEGUN

![logo](http://www.centropiaggio.unipi.it/sites/default/files/styles/thumbnail/public/stegun.png?itok=_-Hn91KR)

S.T.E.GU.N.* (acronyms for Slice Thickness Evaluation GUi for Non-expert users) is an open-source tool  developed in Matlab (the MathWorks-sTM Inc., Massachusetts, USA).

Developed at the [Research Center  "E. Piaggio"](http://www.centropiaggio.unipi.it/), University of Pisa.

Briefly, the tool allows the semi-automated evaluation of slice thickness using four simple steps:

1. Select the magnification used during image acquisition to set the pixel size for the  analysis;

2. Load the image to be analysed. At this point STEGUN automatically returns the binary image to the user who has to select (by mouse clicking) the object representing the slice;

3. Rotate the image to vertically align the object, if needed;

4. Crop three different segments of the object.

In particular, the loaded image is binarised through a thresholding algorithm, then the pixel values inverted to obtain a white object representing the slice (pixel level = 1) in a black background (pixel level = 0). For each of the three crops, the slice thickness is automatically evaluated by summing the pixels and normalising the result by the number of pixel rows of the crop. STEGUN stores all the data in a data matrix and displays the result as the mean value ± standard deviation. In case of highly irregular slices a warning message is returned to the user (i.e. when the coefficient of variation, calculated as the ratio of the standard deviation to the mean value, is greater than 0.25).

For additional information, contact: [Irene Cristian](mailto:irene.cristiani@gmail.com) or [Chiara Magliaro](mailto:chiara.magliaro@googlemail.com)

## REFERENCES

Mattei G., Cristiani I., Magliaro C., Ahluwalia A.,  "Profile analysis of hepatic porcine and murine brain tissue slices obtained with a vibratome" ( preprint is now online at https://peerj.com/preprints/561/)

 

*in memory of the mathematician Irene Stegun ((February 9, 1919 – January 27, 2008). 