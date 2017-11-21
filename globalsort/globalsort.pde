PImage img;
String imgPath, imgSavePath;

// Settings
boolean inverse = false;
boolean showHelp = false;
int threshold = 255, lastThreshold;

void setup() {
  // Open a window to load a file
  selectInput("Load an image:", "loadFile");

  // Default screensize, later overridden by surface.setSize();
  size(320, 240);
  surface.setResizable(true);
}

void draw() {
  try {
    image(img, 0, 0, width, height);
  } 
  catch (NullPointerException e) {
    // No image has been loaded yet, or the loaded file is not an image
  };

  if (img != null) {
    // If an image is actually loaded, apply image fx

    // Only reload image if threshold value changed
    if (threshold != lastThreshold) reloadImage();
    lastThreshold = threshold;
    
    // Apply fx and show the correct menu
    global_sort(threshold, inverse);
    gui(showHelp);
  } else {
    startupScreen();
  };
}