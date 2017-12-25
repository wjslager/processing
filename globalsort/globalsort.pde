PImage img;
String imgPath, imgSavePath;

// User settings
int factor = 10;
boolean inverse = false;
boolean showHelp = true;
int threshold = 0, lastThreshold;
int sortMode = 1;

// ==== ==== ==== SETUP ==== ==== ==== //

void setup() {
  // Open a window to load a file
  selectInput("Load an image:", "loadFile");

  // Default screensize, later overridden by the loaded image size
  size(320, 240);
  surface.setResizable(true);
}

// ==== ==== ==== DRAW ==== ==== ==== //

void draw() {
  if (img == null) {
    // If no images has been loaded yet 
    startupScreen();
  } else {
    // Draw the image and the gui
    image(img, 0, 0, width, height);
    if (showHelp) gui();
  }
}