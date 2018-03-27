// Saved frames will be stored here
String imageFolder = "docs";

IIR pixelIIR = new IIR(0.5);

boolean IIR = true;
boolean pixelDelay = true;
boolean frameIIR = true;

color[] previousPixels;


/* ==== ==== SETUP ==== ==== */

void setup()
{
  //size(800, 800);
  size(640, 480);
  //size(1920, 1080);
  background(0);
  
  loadPixels();
  previousPixels = new color[pixels.length];
}

/* ==== ==== DRAW ==== ==== */

void draw()
{
  // Pixel manipulation
  loadPixels();

  if (mousePressed && mouseInWindow()) {
    if (mouseButton == LEFT)
    {
      pixels[mouseY * width + mouseX] = color(255);
    } else 
    if (mouseButton == RIGHT)
    {
      pixels[mouseY * width + mouseX] = pixels[mouseY * width + mouseX] << 2;
    } else 
    if (mouseButton == CENTER)
    {
      int x = abs(int(random(-20, 20) + mouseX)) % width;
      int y = abs(int(random(-20, 20) + mouseY)) % height;
      pixels[y * width + x] = pixels[mouseY * width + mouseX] << 10;
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
      pixels[i] = int(pixels[i] * 0.9999) + int(0.0001 * pixels [constrain(i-10000, 0, pixels.length)]);
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
  switch (key) 
  {
  case ' ':
    //String filename = str(year()) + "-" + str(month()) + "-" + str(day()) + "-" + str(hour()) + "-" + str(millis()) + "-" + randomString(5);
    String filename = str(hour()) + str(minute()) + "-" + str(millis()) + "-" + randomString(5);
    saveFrame(imageFolder + "/" + filename + ".png");
    println("Frame saved as " + filename + ".png");
    break;
  }
}