# slicesdir_list

## Overview
This is a fork of the slicedir tool from FSL. The script, `slicesdir_list.sh`, utilizes the FSL slicer tool to create visual representations of the images, given a txt list of .nii images,  which can be viewed in a web browser.

## Setup Instructions
**Usage**
   - Create a text file containing the paths of the images you want to process (one path per line). to generate the images.txt file, you can use:
      ```
      find . -type f -name "t1.nii.gz" > images.txt
      ```
   - Run the script:
     ```
     ./slicesdir_list.sh images.txt
     ```
   - Open the generated `index.html` file in the `slicesdir` directory to view the output.



This function/script is a fork of the original script from FSL.
No copyright infringement is intended; this version is provided for educational and illustrative purposes.
Please refer to the original FSL documentation for further details on usage and licensing.