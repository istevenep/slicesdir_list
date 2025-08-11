#!/bin/csh -f

#   slicesdir_list - call slicer on all input images and produce web page output
#
#   Modified version of slicesdir
#   Original author: Stephen Smith, FMRIB Image Analysis Group
#
#   Copyright (C) 1999-2000 University of Oxford
#   Modifications (C) 2024 Stefano Pisano
#
#   TCLCOPYRIGHT

# example usage:
#   ./slicesdirmod.sh images.txt
#   where images.txt contains one image path per line.
# to generate the images.txt file, you can use:
#   find . -type f -name "t1.nii.gz" > images.txt

# Check if no arguments are provided, print usage and exit
if ( "$1" == "" ) then
    echo "Usage: slicesdir_list [-o] [-p <image>] [-S] <filelist or image1 [image2 ...]>"
    echo ""
    echo "Options:"
    echo "  -S           Output every second axial slice rather than just 9 ortho slices"
    echo "  -o           Compare mode: filelist is pairs (<underlying> <red-outline>) of images"
    echo "  -p <image>   Use <image> as red-outline image on top of all images in <filelist>"
    echo ""
    echo "Input:"
    echo "  <filelist>   Text file (.txt) containing a list of image paths, one per line"
    echo "  image1 ...   List of image files to process"
    exit
endif

# Set FSLDIR if not already set
if ( $?FSLDIR == 0 ) then
    set FSLDIR = $PXHOME/fsl
endif

# Remove any existing output directory and create a new one
/bin/rm -rf slicesdir
mkdir slicesdir

# Create the initial HTML file for output
echo '<HTML><TITLE>slicedir</TITLE><BODY BGCOLOR="#aaaaff">' > slicesdir/index.html

# Set default image width and comparison mode
set Width = 1000
set Compare = 0
# If -o option is given, set width for comparison and enable compare mode
if ( "$1" == "-o" ) then
    set Width = 2000
    set Compare = 1
    shift
endif

# If -p option is given, set the pairimage variable and shift arguments
set pairimage = ""
if ( "$1" == "-p" ) then
    set pairimage = $2
    shift
    shift
endif

# If the first argument is a .txt file, read image paths from it
if ( "$1:e" == "txt" ) then
    set filelist = `cat "$1"`
    shift
    set argv = ( $filelist $* )
endif

# Set default slicer and convert options for 9 ortho slices
set sliceropts  = "-x 0.4 slicesdir/grota.png -x 0.5 slicesdir/grotb.png -x 0.6 slicesdir/grotc.png -y 0.4 slicesdir/grotd.png -y 0.5 slicesdir/grote.png -y 0.6 slicesdir/grotf.png -z 0.4 slicesdir/grotg.png -z 0.5 slicesdir/groth.png -z 0.6 slicesdir/groti.png"
set convertopts = "slicesdir/grota.png + slicesdir/grotb.png + slicesdir/grotc.png + slicesdir/grotd.png + slicesdir/grote.png + slicesdir/grotf.png + slicesdir/grotg.png + slicesdir/groth.png + slicesdir/groti.png"
# If -S option is given, output every second axial slice instead
if ( "$1" == "-S" ) then
    set sliceropts  = "-S 2 1600 slicesdir/grota.png"
    set convertopts = "slicesdir/grota.png"
    shift
endif

# Count the number of images (arguments)
set number = `echo $* | wc -w`

@ i = 0
while ( $i < $number )

    # Print the current image being processed
    echo $1

    if ( $Compare == 0 ) then
        # Single image mode: run slicer with optional pairimage overlay
        ${FSLDIR}/bin/slicer $1:r $pairimage -s 1 $sliceropts
        # Create a safe filename for output
        set Q = `echo $1:r | sed "s/\//_/g"`
    else
        # Compare mode: run slicer on image pairs
        ${FSLDIR}/bin/slicer $1:r $2:r -s 1 $sliceropts
        # Create a safe filename for output, indicating comparison
        set Q = `echo $1:r | sed "s/\//_/g"`_to_`echo $2:r | sed "s/\//_/g"`
    endif

    # Combine the generated slice images into one PNG
    ${FSLDIR}/bin/pngappend $convertopts slicesdir/${Q}.png
    # Remove temporary slice images
    /bin/rm -f slicesdir/grot?.png
    # Add an entry to the HTML index for this image
    echo '<a href="'${Q}'.png"><img src="'${Q}'.png" WIDTH='$Width' >' ${Q}'</a><br>' >> slicesdir/index.html

    # Move to the next image(s)
    shift
    @ i ++
    if ( $Compare == 1 ) then
        shift
        @ i ++
    endif
end

# Close the HTML file
echo '</BODY></HTML>' >> slicesdir/index.html

# Print completion message and location of the HTML file
echo ''
echo 'Finished. To view, point your web browser at'
echo file:`pwd`/slicesdir/index.html