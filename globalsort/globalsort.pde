PImage img;
String imgPath, imgSavePath;

int factor;
boolean shiftHeld;

// User settings
boolean inverse = false;
boolean showHelp = true;
int threshold = 255, lastThreshold;
int sortMode = 1;

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

    // Only reload image if threshold value changed or sortMode = random 
    if (threshold != lastThreshold || sortMode==3) {
      reloadImage();
      global_sort(threshold, inverse, sortMode);
    };
    lastThreshold = threshold;

    if (showHelp) gui();
  } else {
    startupScreen();
  };
}