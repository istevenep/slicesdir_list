# slicesdir-gh-pages

## Overview

This is a fork from slicesdir used in fsl to generates a web page output that displays slices of the processed images, given a list of txt list of images, making it easier to visualize and analyze them.

## Usage Instructions

To use the `slicesdir_list.sh` script, follow these steps:

1. **Prepare your images**: Ensure that your images are in the correct format and located in a directory accessible to the script.

2. **Create a file list**: Generate a text file containing the paths to the images you want to process. You can use the following command to create this file:
   ```
   find . -type f -name "t1.nii.gz" > images.txt
   ```

3. **Run the script**: Execute the script with the file list as an argument:
   ```
   ./slicesdir_list.sh images.txt
   ```

4. **View the output**: After the script completes, open the generated `index.html` file located in the `slicesdir` directory in your web browser to view the slices.