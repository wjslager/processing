import processing.video.*;
Capture video;

/* Don't touch these values */
color[] previousPixels;
boolean looping = true, captureFrame = false, clearFrame = false, randomFrame = false;

/* ==== ==== SETTINGS ==== ==== */
boolean IIR = true;
boolean pixelDelay = true;
boolean frameIIR = true;

// Store the screenshots in this (sub)folder
String imageFolder = "docs";

IIR pixelIIR = new IIR(0.1);

/* ==== ==== SETUP ==== ==== */

void setup()
{
  //size(800, 800);
  //size(4000, 4000);
  //size(800, 150);
  //size(640, 480);
  //size(1920, 1080);
  fullScreen();
  background(0);

  video = new Capture(this, 1280, 720); 
  video.start();

  loadPixels();
  previousPixels = new color[pixels.length];

  noLoop();
}

/* ==== ==== DRAW ==== ==== */

void draw()
{
  frameInsertions();
  frameFX();

  updatePixels();
}

void frameInsertions() {
  // Blend in a webcam frame
  if (captureFrame) {
    tint(255, 1);
    image(video, 0, 0, width, height);
    captureFrame = false;
  }

  loadPixels();

  // Clear the frame
  if (clearFrame) {
    background(0);
    clearFrame = false;
  }

  // Insert noise
  if (randomFrame) {
    for (int i = 0; i < pixels.length; i++) {
      pixels[i] += color(random(0, 1.001));
    }
    randomFrame = false;
  }

  if (mousePressed && mouseInWindow()) {
    if (mouseButton == LEFT)
    {
      pixels[mouseY * width + mouseX] = color(255);
    } else 
    if (mouseButton == RIGHT)
    {
      int x = abs(int(random(-20, 20) + mouseX)) % width;
      int y = abs(int(random(-20, 20) + mouseY)) % height;
      pixels[y * width + x] = pixels[mouseY * width + mouseX] << 10;
    } else 
    if (mouseButton == CENTER)
    {
      pixels[mouseY * width + mouseX] = pixels[mouseY * width + mouseX] << 2;
    }
  }
}

void frameFX () {
  // IIR, left to right, downwards
  if (IIR) {
    for (int i = 0; i < pixels.length; i++) {
      pixels[i] = int(pixelIIR.filter(pixels[i]));
    }
  }

  // IIR, current pixel with last pixel
  if (frameIIR) {
    for (int i = 0; i < pixels.length; i++) {
      // Compare to last frame
      pixels[i] = pixels[i] + int(previousPixels[i] * 0.00001);

      // Store last frame
      previousPixels[i] = pixels[i];
    }
  }

  // Delay effect with last pixel
  if (pixelDelay) {
    for (int i = 0; i < pixels.length; i++) {
      pixels[i] = int(pixels[i] * 0.9999) + int(0.0001 * pixels [constrain(i-10200, 0, pixels.length)]);
    }
  }
}