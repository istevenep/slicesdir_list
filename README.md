# slicesdir GitHub Pages Project

## Overview
The `slicesdir` project is designed to process image files and generate a web page output with slices of the images. The main script, `slicesdir_list.sh`, utilizes the FSL slicer tool to create visual representations of the images, which can be viewed in a web browser.

## Features
- Processes multiple image files.
- Generates a web page with slices of the images.
- Supports comparison mode for overlaying images.
- Outputs every second axial slice if specified.

## Setup Instructions
1. **Clone the Repository**
   Clone this repository to your local machine using:
   ```
   git clone https://github.com/yourusername/slicesdir-gh-pages.git
   ```

2. **Navigate to the Project Directory**
   ```
   cd slicesdir-gh-pages
   ```

3. **Install Dependencies**
   Ensure that you have FSL installed on your system, as it is required for the `slicesdir_list.sh` script to function properly.

4. **Usage**
   - Create a text file containing the paths of the images you want to process (one path per line).
   - Run the script:
     ```
     ./src/slicesdir_list.sh images.txt
     ```
   - Open the generated `index.html` file in the `slicesdir` directory to view the output.

## Contributing
Contributions are welcome! Please feel free to submit a pull request or open an issue for any suggestions or improvements.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.