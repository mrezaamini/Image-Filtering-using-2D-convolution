## Description:
Two-dimensional convolution is used to find patterns in images. Sometimes these patterns are predefined, such as the horizontal edge detection filter, and sometimes the patterns must be trained in one process, such as the filters trained in convolutional neural networks. In convolutional neural networks, the concept of filter is widely used in the field of space. If 𝐹 is a filter or kernel and 𝑌 is a two-dimensional single-channel image, the pixels of row 𝑖 and column 𝑗 of the image after applying convolution are obtained from the following equation:
$$\left ( Y*F\left [ i,j \right ] \right )= \sum_{n}^{}\sum_{m}^{}Y\left [ i-n,j-m \right ]F\left [ n,m \right ]$$
The above expression states that a pixel of the image after convolution is the sum of the products of the corresponding degrees of a filter and a window of the original image. To find another pixel from the image after applying the filter, you should place the filter on another window of the original image and perform the calculations. Therefore, the whole process of convolution in the image can be considered as placing a filter on the image and then moving that filter and performing calculations.

## Implementation:
Main function is Conv2D(img_path, stride, is_same, filter) :
- img_path: input image's address
- stride: A number that determines the number of jumps in the next stage of moving the filter on the image, such as 2.
- is_same: It is a parameter that can be true or false. If it is true and 1=stride, the size of the image after applying the filter is the same as before applying the filter.
- filter: The filter matrix is applied to the image.

## Sample result:
