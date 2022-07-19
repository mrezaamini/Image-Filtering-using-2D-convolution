# Importing libraries
import numpy as np
import imageio # Only for reading and writing images from/to disk
import os

def conv2D(src='input_images/lecun.jpg',
           stride=1,
           is_same=True,
           filter=[[0, -1, 0], [-1, 5, -1], [0, -1, 0]],
           filter_name='none'):
    # Reading and extracting size information of the image and filter
    image = np.array(imageio.imread(src)).astype(np.float32)
    # Converting RGB to grayscale with weighted combination of RGB channels
    rgb_weights = [0.2989, 0.5870, 0.1140]
    image = np.dot(image[..., :3], rgb_weights)
    height, width = np.shape(image)
    # Converting the filter to a numpy array
    filter = np.array(filter).astype(np.float32)
    hf, wf = np.shape(filter)
    # Calculating hyperparameters for convolution based on the requested settings
    if is_same:
        py = (hf-1)//2
        px = (wf-1)//2
    else:
        py = 0
        px = 0
    # Extending the image if needed
    h_array = np.zeros((height, px))
    padded_image = np.concatenate((h_array, image, h_array), axis=1)
    v_array = np.zeros((py, width+2*px))
    padded_image = np.concatenate((v_array, padded_image, v_array), axis=0)
    # Doing the convolution
    output_height = (height-hf+2*py)//stride+1
    output_width = (width-wf+2*px)//stride+1
    output = np.zeros((output_height, output_width))
    for row in range(output_height):
        for col in range(output_width):
            local = padded_image[row*stride:row*stride+hf, col*stride:col*stride+wf]
            conv = local * filter
            output[row, col] = np.sum(conv)
    # Clipping the output
    output = np.clip(output, 0, 255)
    # Arranging the output name
    filter_type = 'same' if is_same else 'valid'
    ext = os.path.splitext(src)[1]
    image_name = os.path.basename(src).split('.')[0]
    output_path = 'output_images/'+image_name+'_'+filter_name+'_'+filter_type+'_'+str(stride)+ext
    imageio.imwrite(output_path, output.astype(np.uint8))    

if __name__=='__main__':

    # Getting list of jpg files in input_images folder
    images_paths = [f'input_images/{item}' for item in os.listdir('input_images')]
    for image_path in images_paths:
        # Sharpness filter
        filter = [[0, -1, 0],
                  [-1, 5, -1],
                  [0, -1, 0]]
        stride = 1
        is_same = False
        conv2D(image_path, stride, is_same, filter, 'sharpness')
        # Horiznotal edge filter
        filter = [[-1, -1, -1],
                  [0, 0, 0],
                  [1, 1, 1]]
        stride = 2
        is_same = True
        conv2D(image_path, stride, is_same, filter, 'horizontaledge')
        # Embossin filter
        filter = [[2, 0, 0],
                  [0, -1, 0],
                  [0, 0, -1]]
        stride = 3
        is_same = False
        conv2D(image_path, stride, is_same, filter, 'embossing')
        # Gaussian filter
        filter = [[1, 4, 7, 4, 1],
                  [4, 16, 26, 16, 4],
                  [7, 26, 41, 26, 7],
                  [4, 16, 26, 16, 4],
                  [1, 4, 7, 4, 1]]
        # Normalizing the Gaussian filter
        for i in range(5):
            for j in range(5):
                filter[i][j] /= 273.
        stride = 1
        is_same = True
        conv2D(image_path, stride, is_same, filter, 'gaussian')

    ## Plotting the Lecun image results
    import matplotlib.pyplot as plt
    from matplotlib import gridspec
    # Importing the images
    lecun_org = imageio.imread('input_images/lecun.jpg')
    lecun_sharpness = imageio.imread('output_images/lecun_sharpness_valid_1.jpg')
    lecun_embossing = imageio.imread('output_images/lecun_embossing_valid_3.jpg')
    lecun_gaussian = imageio.imread('output_images/lecun_gaussian_same_1.jpg')
    lecun_horizontalEdge = imageio.imread('output_images/lecun_horizontaledge_same_2.jpg')
    width_ratios = [np.shape(lecun_org)[1],
                    np.shape(lecun_sharpness)[1],
                    np.shape(lecun_embossing)[1],
                    np.shape(lecun_gaussian)[1],
                    np.shape(lecun_horizontalEdge)[1]]
    fig = plt.figure()
    gs = gridspec.GridSpec(1, 5, width_ratios=width_ratios)

    ax_org = plt.subplot(gs[0])
    ax_org.imshow(lecun_org, cmap='gray')
    ax_org.set_title('Original Image', size=8)

    ax_sharpness = plt.subplot(gs[1])
    ax_sharpness.imshow(lecun_sharpness, cmap='gray')
    ax_sharpness.set_title('Sharpness Filter\nvalid/stride=1', size=8)

    ax_embossing = plt.subplot(gs[2])
    ax_embossing.imshow(lecun_embossing, cmap='gray')
    ax_embossing.set_title('Embossing Filter\nsame/stride=3', size=8)

    ax_gaussian = plt.subplot(gs[3])
    ax_gaussian.imshow(lecun_gaussian, cmap='gray')
    ax_gaussian.set_title('Gaussian Filter\nsame/stride=1', size=8)

    ax_horizontalEdge = plt.subplot(gs[4])
    ax_horizontalEdge.imshow(lecun_horizontalEdge, cmap='gray')
    ax_horizontalEdge.set_title('Horizontal Edge Filter\nsame/stride=2', size=8)

    plt.tight_layout()
    plt.show()
    print('All done!')