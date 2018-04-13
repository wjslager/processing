import processing.video.*;
Capture video;

color[] previousPixels;
boolean looping = true, captureFrame = false, clearFrame = false, randomFrame = false;

/* ==== ==== SETTINGS ==== ==== */
boolean IIR = true;
boolean pixelDelay = true;
boolean frameIIR = true;

String imageFolder = "docs";

IIR pixelIIR = new IIR(0.1);

/* ==== ==== SETUP ==== ==== */

void setup()
{
  size(800, 800);
  //size(800, 150);
  //size(640, 480);
  //size(1920, 1080);
  background(0);

  video = new Capture(this, 1280, 720); 
  video.start();

  loadPixels();
  previousPixels = new color[pixels.length];
}

/* ==== ==== DRAW ==== ==== */

void draw()
{
  if (captureFrame) {
    tint(255, 1);
    image(video, 0, 0, width, height);
    captureFrame = false;
  }

  loadPixels();

  if (clearFrame) {
    for (int i = 0; i < pixels.length; i++) {
      pixels[i] = color(0);
    }
    clearFrame = false;
  } else if (randomFrame) {
    for (int i = 0; i < pixels.length; i++) {
      pixels[i] += color(random(1));
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

  // Process using a simple IIR
  if (IIR) {
    for (int i = 0; i < pixels.length; i++) {
      pixels[i] = int(pixelIIR.filter(pixels[i]));
    }
  }

  // Delay effect with last pixel
  if (pixelDelay) {
    for (int i = 0; i < pixels.length; i++) {
      pixels[i] = int(pixels[i] * 0.9999) + int(0.0001 * pixels [constrain(i-10200, 0, pixels.length)]);
    }
  }

  // Delay effect with last frame
  if (frameIIR) {
    for (int i = 0; i < pixels.length; i++) {
      // Compare to last frame
      pixels[i] = pixels[i] + int(previousPixels[i] * 0.00001);

      // Store last frame
      previousPixels[i] = pixels[i];
    }
  }

  updatePixels();
}

/* ==== ==== INTERACTION ==== ==== */

void keyPressed() {
  /* Keyboard controls:
   
   space  save frame
   L      start/stop continious drawing
   V      insert a webcam frame
   X      insert random noise
   C      clear screen (to black)
   
   */
  switch (key) 
  {
  case ' ':
    //String filename = str(year()) + "-" + str(month()) + "-" + str(day()) + "-" + str(hour()) + "-" + str(millis()) + "-" + randomString(5);
    String filename = str(hour()) + str(minute()) + "-" + str(millis()) + "-" + randomString(5);
    saveFrame(imageFolder + "/" + filename + ".png");
    println("Frame saved as " + filename + ".png");
    break;
  case 'l':
    looping = !looping;
    if (looping) {
      noLoop();
    } else {
      loop();
    }
    break;
  case 'f':
    draw();
    break;
  case 'v':
    captureFrame = true;
    break;
  case 'x':
    randomFrame = true;
    break;
  case 'c':
    clearFrame = true;
    break;
  }
}