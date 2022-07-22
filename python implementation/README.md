## Description:
Convolution is a very important operation in finding features in machine vision and problems in which there is a relationship between the matrices like images. Kernel convolution or filter h on image 𝑥 is obtained from the following equation:
$$\left ( y\left [ i,j \right ] \right )= \sum_{m}^{}\sum_{n}^{}x\left [ i-n,j-m \right ]h\left [ n,m \right ]$$
In the above formula, [𝑗],𝑖[𝑦 is only one point in the resulting convolution image. In order to calculate other points, the filter should be worn on the input image and the result of convolution should be obtained in other places as well.

## Implementation:
Main function is Conv2D that is in the HW3.py and has these following inputs:
- src: input image's address.
- stride: The amount of kernel jump on the image to calculate the next point of the output image. stride is a natural number like 1.
- is_same: If it is True, the input image will be margined with 0 values before convolution.
- filter: The same filter or kernel is a list of lists in Python.
- filter_name: The name of the filter to use in the name of the convolution output is.

This code uses numpy, os, imageio and matplotlib packages. The os package is used to get the list of files in the input_images folder, numpy is used to perform calculations, and imageio is used to read the input image from the disk and write the convolution result to the disk. Also, matplotlib package has been used to display images in creating a demo. Also, since it is not possible to use image processing packages, we used the following formula to calculate the black-white image from the color image:

$$Gray= 0.2989*R + 0.5870*G + 0.1140B$$

Specifically, each grayscale pixel is obtained by the RGB weighted sum according to the above formula.

## Sample result:
![sample otuput](https://github.com/mrezaamini/Image-Filtering-using-2D-convolution/blob/main/python%20implementation/python_output.png)
