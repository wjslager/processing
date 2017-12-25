IntList selectedPixels;
color[] selectedPixelsColors, sortedPixelsColors;

void global_sort(int threshold, boolean inverse, int mode) {
  int brightness, sortLength;

  // The index of the pixels which will be sorted are stored in this IntList:
  selectedPixels = new IntList();

  img.loadPixels();

  // ---- ---- ---- PIXEL SELECTION ---- ---- ---- //

  // Execute the following code for each pixel
  for (int i=0; i<img.pixels.length; i++) {

    // Extract brightness values using bitshifting
    // Takes the average of the R, G and B values as brightness
    brightness =
      ((img.pixels[i] >> 16) & 0xFF) +
      ((img.pixels[i] >> 8)  & 0xFF) +
      (img.pixels[i]         & 0xFF);
    brightness = int(brightness / 3);

    // Different modes of selecting pixels to sort
    switch(mode) {
    case 1: 
      // Bright pixels get selected for sorting first
      if (brightness >= ((threshold * -1) + 255)) {
        selectedPixels.append(i);
      }
      break;
    case 2:
      // Dark pixels get selected for sorting first
      if (brightness <= threshold) {
        selectedPixels.append(i);
      }
      break;
    case 3:
      // Random pixels get selected for sorting first
      if (random(255) <= threshold) {
        selectedPixels.append(i);
      }
      break;
    }
  }

  // ---- ---- ---- PIXEL SORTING ---- ---- ---- //

  // Store the total number of pixels to be sorted
  // Should save some CPU by not calling the size() function that often
  sortLength = selectedPixels.size();
  
  // Prepare the arrays
  color[] selectedPixelsColors = new color[sortLength];
  color[] sortedPixelsColors = new color[sortLength];

  // Store color values for the selected pixels
  for (int i=0; i<sortLength; i++) {
    selectedPixelsColors[i] = img.pixels[selectedPixels.get(i)];
  }

  // Sort the colors
  sortedPixelsColors = sort(selectedPixelsColors);

  // Reverse the sorted colors if specified to do so
  if (inverse) sortedPixelsColors = reverse(sortedPixelsColors);

  // Insert the sorted pixels back into the image
  for (int i=0; i<sortLength; i++) {
    img.pixels[selectedPixels.get(i)] = sortedPixelsColors[i];
  }

  img.updatePixels();
}