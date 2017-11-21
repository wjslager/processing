IntList selectedPixels;
color[] selectedPixelsColors, sortedPixels;

void global_sort(int threshold, boolean inverse) {
  selectedPixels = new IntList();
  int brightness, sortLength;
  img.loadPixels();

  // Analyze pixels and store results
  for (int i=0; i<img.pixels.length; i++) {

    // Extract brightness values using bitshifting
    brightness = ((img.pixels[i] >> 16) & 0xFF) + ((img.pixels[i] >> 8) & 0xFF) + (img.pixels[i] & 0xFF);
    brightness = int(brightness / 3);

    // If the brightness passes the threshold, the current pixels index (coordinate) is stored
    if (brightness >= threshold) {
      selectedPixels.append(i);
    };
  };

  sortLength = selectedPixels.size();
  color[] selectedPixelsColors = new color[sortLength];
  color[] sortedPixels = new color[sortLength];

  // Store color values for the selected pixels
  for (int i=0; i<sortLength; i++) {
    selectedPixelsColors[i] = img.pixels[selectedPixels.get(i)];
  };

  sortedPixels = sort(selectedPixelsColors);

  if (inverse) {
    sortedPixels = reverse(sortedPixels);
  };

  // Apply sorted pixels to selectedPixels
  for (int i=0; i<sortLength; i++) {
    img.pixels[selectedPixels.get(i)] = sortedPixels[i];
  };

  img.updatePixels();
}